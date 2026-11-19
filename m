Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A719606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T0GsgWxV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyIp-0007tB-FM; Thu, 19 Nov 2026 04:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xTyIn-0007rW-2z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:19:33 -0500
Received: from out-18.mta1.migadu.com ([95.215.58.18] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fuad.tabba@linux.dev>)
 id 1xTyIk-0004Mj-2S
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:19:32 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=P3Ieq36YCVfa/nzyifhrZCh6abW6a6CedjynJvkFeKM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795079965; v=1; x=1795684765;
 b=T0GsgWxVfLbk3UgZQNRQrI2wsZHrfPifeeKmiA41ww/lHJhme6m/xsvUH/6FySggaWJ/SiCT
 K+/TpApTmzndGnwiPKB3+VMNGD8GrwDAcGTSl0DspcAvS44WvLzlOgTL0b7Nt+BiKwwK8ykh7DV
 1xfXe0V6hXEBbHQdZxXzwQ70=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 2dae15a69a8bec29;
 Thu, 19 Nov 2026 09:19:25 +0000
X-Mizu-Trace-ID: 2dae15a69a8bec29
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 tabba@google.com
Subject: [PATCH] hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in EOImode
 1
Date: Thu, 19 Nov 2026 09:19:22 +0000
Message-ID: <20261119091922.1380805-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.18; envelope-from=fuad.tabba@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

icv_eoir_write() increments ICH_HCR_EL2.EOIcount for a virtual EOI with
no matching list register, in either EOImode. The VirtualWriteEOIR0()
and VirtualWriteEOIR1() pseudocode in the GICv3 architecture
specification only does so in EOImode 0 (ICH_VMCR_EL2.VEOIM clear),
since in EOImode 1 the DIR write increments EOIcount instead.

In EOImode 1 an interrupt with no list register is therefore counted
twice, and KVM running under TCG deactivates an interrupt that its guest
has yet to deactivate.

Increment EOIcount on EOIR only when EOImode is 0.

Fixes: b3b48f529fe8 ("hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---

Notes:
    Tested with a local reproducer that runs a KVM guest in EOImode 1
    under TCG, with more interrupts pending than list registers. Without
    this patch the guest sees an interrupt deactivated before its DIR,
    and with it the reproducer passes.

 hw/intc/arm_gicv3_cpuif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 67a0bba4b0..02e1e7c254 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1617,9 +1617,10 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (idx < 0) {
         /*
          * No valid list register corresponding to EOI ID; if this is a vLPI
-         * not in the list regs then do nothing; otherwise increment EOI count
+         * not in the list regs then do nothing; otherwise increment EOI count,
+         * unless drop and deactivate are split, when the DIR write does so.
          */
-        if (irq < GICV3_LPI_INTID_START) {
+        if (irq < GICV3_LPI_INTID_START && !icv_eoi_split(env, cs)) {
             icv_increment_eoicount(cs);
         }
     } else {
-- 
2.47.3


