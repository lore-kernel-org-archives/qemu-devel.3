Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DFFF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxi7-00087V-SX; Sat, 07 Mar 2026 14:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxi6-00086Y-7T
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:14 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxi4-0008VM-FV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:13 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9515E4448E;
 Sat,  7 Mar 2026 19:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9BDC19422;
 Sat,  7 Mar 2026 19:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913191;
 bh=OOKfroUsa/NmmKFDrQXJY1cwDi1GkvGCyavkONtRuAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nZ5QELcoMuG41M0Ort6CBbgWBlrPLDffM800Pa/YGNHxMqHuaiF6S1uvEq7kfoAII
 4HpywoSmkdPuBh1Qna0XgF96VrlqLyhKjlQwGy30+WidGvYBg9wGi+5mZ39uqkHAwd
 7qhdF28Ml9WH8Ra3CeXA9b00Fmy0I6FFuAu+AcwMQ2xolyyJjT8Rs7TBOWwQcxLmuX
 XrPcVEUGQXRNSkQvxQOe5o8Zt46ixQmsgNLKO/bYQHWuNOWvAzl5M7EnP5+52ZNIY9
 x8jPazCyDgesdjRmSLPGslt3DrtzvlTHQh6B+gE9BMtKnt8Cc0tEHbq2u+uj4XYhzM
 jyLG1zyBmdFzA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/12] bsd-user: Deal with mmap where start > reserved_va
Date: Sat,  7 Mar 2026 20:52:40 +0100
Message-ID: <20260307195243.8813-10-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307195243.8813-1-deller@kernel.org>
References: <20260307195243.8813-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Bingwu Zhang <xtex@astrafall.org>

Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for mmap_find_vma_reserved")
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 bsd-user/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 24ba1728eb..fe77eceb48 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -258,12 +258,14 @@ abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong ret;
+    abi_ulong ret = -1;
 
-    ret = page_find_range_empty(start, reserved_va, size, alignment);
+    if (start <= reserved_va) {
+        ret = page_find_range_empty(start, reserved_va, size, alignment);
+    }
     if (ret == -1 && start > TARGET_PAGE_SIZE) {
         /* Restart at the beginning of the address space. */
-        ret = page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
+        ret = page_find_range_empty(TARGET_PAGE_SIZE, MIN(start - 1, reserved_va),
                                     size, alignment);
     }
 
-- 
2.53.0


