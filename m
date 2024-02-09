Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F2C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPVH-0003hy-Uw; Fri, 09 Feb 2024 06:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV5-0003e9-VD
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:57:01 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rYPV2-0002Rr-2L
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:56:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 68812CE1FFD;
 Fri,  9 Feb 2024 11:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFF5C43390;
 Fri,  9 Feb 2024 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707479811;
 bh=bMGiugQoc2DhmTSqm+CZs/LiSubHUzCkUMZHroTlcng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lycUpyNz4vAwK5BLzO6/naFOOw5BNHMv5BWVRm/4lR7ubxWBwAdkEm2ZPM+HzLTaD
 +7cE4oh0zRVlJup5LeoKdwd3npZWiZKia3d2s8SyM+p1j549zEpBeoAyDxaEuG2hjk
 T14l5iZ1yWZFKb5ERrrzWtCtKSLhA/dWRM3mYk+vZUJLlcNMwvnHaO5jkU5NGfBpxm
 aSERUc02+d689vW62bHRosqQCBulJs7g8cVQ4sG28NivwQ5KxRaYpplMnHpBZL1Ty9
 qomhfiu3jO06QjXDvHP/i1xaoLNGg4yO4wmkk+NBRyCBU8rS6MGGhQR+sH/CXhkr8e
 LJ3dUvNFzCRNA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 09/12] target/hppa: PDC_BTLB_INFO uses 32-bit ints
Date: Fri,  9 Feb 2024 12:56:30 +0100
Message-ID: <20240209115633.55823-10-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209115633.55823-1-deller@kernel.org>
References: <20240209115633.55823-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


