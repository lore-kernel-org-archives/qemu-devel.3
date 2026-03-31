Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D7210F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCY-0000DG-I6; Tue, 31 Mar 2026 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCX-0000D5-3E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:33 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCV-0001Xt-Q2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E496F41529;
 Tue, 31 Mar 2026 18:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD51DC19423;
 Tue, 31 Mar 2026 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983150;
 bh=iI1d5bFylepSOxI2yENVX+NCRKlOf8n+vgOxjT9JKDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ItZebtgIdgDxFKHRwHsgek1DvBvp1y0Ad2PVpgFGA1dHurMMWh2pN1a6rvAszq9jY
 SEH5/+JB+ERV7yd2h8LojwXuFpIyGdy6DKtxbLdqgyq7FTAtDTzBm33qWQgssTa7mJ
 KGooUHe5JugStdZm1vQwVUngEaWIavzs7k0zUzp2NlOthCLDJJveOIsucWBfhTpVAO
 Gp/o9K+uH+1UHbBpGCIWqbuo+IcqsuiBp1x1+F0IAjynVEzyhm2uBLwak9XLCLubOv
 IxNaEBZ672aBQMsbvVaDJvtLQkbWruKpiJe5KV7lqUwevkvVx8n+JbzhCOs1l00+mT
 nzNR3etVGhusQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/8] target/hppa: Fix TOC handler for 64-bit CPUs
Date: Tue, 31 Mar 2026 20:52:17 +0200
Message-ID: <20260331185219.12187-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
References: <20260331185219.12187-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

When the TOC handler is triggered, e.g. by using the "NMI" command
in the QEMU monitor, make sure to call the full 64-bit TOC handler
address in SeaBIOS-hppa firmware.
This fixes the TOC handler on 64-bit CPUs (and 64-bit SeaBIOS).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/int_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d5a20cd549..3e87b9a001 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -203,7 +203,12 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
     /* step 7 */
     if (i == EXCP_TOC) {
-        env->iaoq_f = hppa_form_gva(env, 0, FIRMWARE_START);
+        hwaddr pdc_toc_addr = FIRMWARE_START;
+
+        /* for 64-bit include the high bits of PDC */
+        pdc_toc_addr |= ((uint64_t) FIRMWARE_HIGH) << 32;
+        env->iaoq_f = hppa_form_gva(env, 0, pdc_toc_addr);
+
         /* help SeaBIOS and provide iaoq_b and iasq_back in shadow regs */
         env->gr[24] = env->cr_back[0];
         env->gr[25] = env->cr_back[1];
-- 
2.53.0


