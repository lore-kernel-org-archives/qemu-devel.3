Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5230C54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBMv-0002eB-Ne; Wed, 29 Jul 2026 16:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMu-0002dz-Mn
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:12 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMt-0003kP-6U
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:12 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F6806004E;
 Wed, 29 Jul 2026 20:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CFF1F000E9;
 Wed, 29 Jul 2026 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785358750;
 bh=pQx5YbcditN3B7gV622IuItDzYq/EcAseJ4AJoGmdfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MoAUAWyu4/JqThZgQstUPx26alNES4xuYDFZJt+YZ/ZsTwrNwdy8oSe36VSXjVA6A
 S07uWRI4TkMA1zjMm0BOuNBw1QA1u/8lUnr3/zM2uSq8dgUMvlyhVvrMA/PUH9/ETj
 U//HDsimTIAMef94Qhx2ac2YzjwXDedkhBUnH4DUzC47q1Hbm0pbevcocFH6t3l8ee
 8qX6KMZZlO/RnWMP9dM6MkXQpIKjhAD7UIYL0UYnwwi1tQmK1FOJj5b3sikSkSIrz7
 NoPeiaPQP7f5/zk+/g57EsVzHrW5Bus6YEE1370DK6ll48sEEFWYeLfOGdKb5Oqcv5
 yI1wAoIguULsg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/3] linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
Date: Wed, 29 Jul 2026 22:59:02 +0200
Message-ID: <20260729205902.3767-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729205902.3767-1-deller@kernel.org>
References: <20260729205902.3767-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The token is not computed via TARGET_PAGE_SIZE, but via a fixed 12-bit field.

Cc: qemu-stable@nongnu.org
Fixes: ad1afe433fa ("linux-user/aarch64: Implement map_shadow_stack syscall")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4106
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 547784d971..dc028686f4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6900,7 +6900,8 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
                 /* Leave an extra empty frame at top-of-stack. */
                 cap_ptr -= 8;
             }
-            cap_val = (cap_ptr & TARGET_PAGE_MASK) | 1;
+            /* Note the 12 bit field is unaffected by current page size. */
+            cap_val = deposit64(cap_ptr, 0, 12, 1);
             if (put_user_u64(cap_val, cap_ptr)) {
                 /* Allocation succeeded above. */
                 g_assert_not_reached();
-- 
2.54.0


