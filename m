Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A8DC4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xl-0006BA-IX; Sun, 11 Feb 2024 07:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xh-00068P-FY
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xf-0006G9-Vt
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BB7C960C56;
 Sun, 11 Feb 2024 12:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DE5C43390;
 Sun, 11 Feb 2024 12:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654569;
 bh=bMGiugQoc2DhmTSqm+CZs/LiSubHUzCkUMZHroTlcng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lj4GZYBnN9ClB0jvm2zMsFEvZFFXt7nBF2UgERlrJvm2JI1k/Om/YSwj5R3mCrhI5
 ttMTDFq502kE/dY2TDATc9eDRUA0ikBII0F5wy21rOg7vEnuBUdqbnmdFql1xX295M
 qimuoSSc8N/PzMYvyNqMbwDsINa26fEp3a3/4DYCnFk6k5FznZCb1yVYrApRYuzvNm
 KsX4vRWwUSZ1AccnmEs++mQ/EUH6pdlZ8e61gNkhHMkrC5zut/Qr982Mmw18DZWAMY
 MetqoSH4GegFocG2H+8BpSMnlm9lFc1TwRTKOuC71rOURsa5LR/YKPSvLehgVPPE5A
 jNlCimcoh//4g==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 09/12] target/hppa: PDC_BTLB_INFO uses 32-bit ints
Date: Sun, 11 Feb 2024 13:29:06 +0100
Message-ID: <20240211122909.5807-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

The BTLB helper function stores the BTLB info (four 32-bit ints) into
the memory of the guest. They are only available when emulating a 32-bit
CPU in the guest, so use "uint32_t" instead of "target_ulong" here.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 676c0b3003..66b8fa7d72 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -684,7 +684,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
     case 0:
         /* return BTLB parameters */
         qemu_log_mask(CPU_LOG_MMU, "PDC_BLOCK_TLB: PDC_BTLB_INFO\n");
-        vaddr = probe_access(env, env->gr[24], 4 * sizeof(target_ulong),
+        vaddr = probe_access(env, env->gr[24], 4 * sizeof(uint32_t),
                              MMU_DATA_STORE, mmu_idx, ra);
         if (vaddr == NULL) {
             env->gr[28] = -10; /* invalid argument */
-- 
2.43.0


