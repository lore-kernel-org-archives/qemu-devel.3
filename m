Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF28C54E4A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 05:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgegY-0006N6-S6; Sun, 03 Mar 2024 00:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegX-0006Mh-AK
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:53 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rgegV-0003Su-S1
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 00:46:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9C81760C2B;
 Sun,  3 Mar 2024 05:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3989C433C7;
 Sun,  3 Mar 2024 05:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709444810;
 bh=a9DjyL7Kb/8nZ96CbZM91Omz+z9llahcCJYvcimBSS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uY37Sz3ZsQHeeQ/P5lRd2RbrNvNOnx/+UrBPZ1xu+qJqn2UIniBz79293DKUKQtjo
 tnx/EyJSJiP1nQbk307F7g/Q1CP9elDN5P6mgN2golRcrdKOzQ/LQqlNpYQXMdiiW8
 JSfNSrQiXkN7cwY7vmPRqTKDdxz13VF1feRCQqSwkdaDcUwk9yhfhzbuAgLh2kM3Xj
 IzKVACUOLZXY4cHUReDDOaG9HOTPWSpjvL9G5QE59uh/8pBU52ggvyqdEFwm5aT5bC
 jkXDVF0pRHzB32UDLj1QL/PbuQpE86CQcFqPTNJTAMhisYjQN96kgVyX57R8BZLaQr
 p+puwdPu6QC1w==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de, Guenter Roeck <linux@roeck-us.net>,
 Charlie Jenkins <charlie@rivosinc.com>
Subject: [PULL 1/5] target: hppa: Fix unaligned double word accesses for hppa64
Date: Sun,  3 Mar 2024 06:46:41 +0100
Message-ID: <20240303054645.3004-2-deller@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303054645.3004-1-deller@kernel.org>
References: <20240303054645.3004-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
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

From: Guenter Roeck <linux@roeck-us.net>

Unaligned 64-bit accesses were found in Linux to clobber carry bits,
resulting in bad results if an arithmetic operation involving a
carry bit was executed after an unaligned 64-bit operation.

hppa 2.0 defines additional carry bits in PSW register bits 32..39.
When restoring PSW after executing an unaligned instruction trap, those
bits were not cleared and ended up to be active all the time. Since there
are no bits other than the upper carry bits needed in the upper 32 bit of
env->psw and since those are stored in env->psw_cb, just clear the entire
upper 32 bit when storing psw to solve the problem unconditionally.

Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 859644c47a..9d217d051c 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -76,7 +76,8 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
     }
     psw &= ~reserved;
 
-    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
+    env->psw = psw & (uint32_t)~(PSW_N | PSW_V | PSW_CB);
+
     env->psw_n = (psw / PSW_N) & 1;
     env->psw_v = -((psw / PSW_V) & 1);
 
-- 
2.44.0


