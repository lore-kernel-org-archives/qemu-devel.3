Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D99606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=TYAxFxPG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9o-0005b4-1R; Fri, 27 Nov 2026 01:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9b-0005WE-L0; Fri, 27 Nov 2026 01:09:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9Z-0003wk-9B; Fri, 27 Nov 2026 01:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759049; bh=DHAICHLf+XmvjrKK4v5CChC6CTpNaJmRiTwInQFD9Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TYAxFxPGI1ZQZicPc1A68xBcLyNLlmyTsEd945MJ8kcDIoGNWc99U+AHkoqR2GZ+M
 UrXp1NX5Vo5h1kLcRWZHJWjhz03bDquh0/PegHmr1vY/l3lR/3ImKDVQj82XI1Sh4Z
 qjUhlXmesq+4AmCjwJKftzWTz5m4o19fwSUzfrauX0fmYFMJOvIte7RBktnft6x7q9
 3D1ZP0WxEuJsUqAJ3JXLP4Vaoz5y2xfG4I7fLAz2BDmADsRzAkAcjHLUtaglEpH+uL
 YWwNUZ+gcniRx2yUqt4ZtmhHdt/iQPbCltp07RX6YXFv6tm9y3gr2Hxskqa7zD8MJj
 TNnut2+UaxKFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 74E001EA378;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7282F4699A3;
 Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6931CCF33E; Fri, 27 Nov 2026 08:57:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fuad Tabba <fuad.tabba@linux.dev>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 134/152] hw/intc/arm_gicv3_cpuif: Don't count a
 virtual EOI in EOImode 1
Date: Fri, 27 Nov 2026 08:54:32 +0300
Message-ID: <20261127055709.39630-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fuad Tabba <fuad.tabba@linux.dev>

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
Message-id: 20261119091922.1380805-1-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 9b00833dfd9e031e2319c9ea85eeb2b622f80f5b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 67a0bba4b03..02e1e7c254e 100644
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


