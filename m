Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6i-0002FC-8B; Thu, 15 Feb 2024 01:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6f-0002EP-Lo
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6d-0005Iw-NR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:25 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d94323d547so4406855ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978022; x=1708582822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=C6DB3DVdqm8erd2cdHDnzlaYP2qpWWt6WKBakXN8i/AJjN0jbwsTbqKsKf5yi9jOsl
 /8i2dLgpltV7XfxCfk4cwDaoUrSmx/pwC3rF66Qv22gRMEmUX4ov4r6UMPuYdimiGOxY
 AFq9/ZluAFf1KdhlgikeZD34EzTi3w16hwjHPgvnEY+w/0MBe5O9lnIQUOlr1DC8CDP2
 lFbvgpaCF3BHKd2FjeLfYa/bdIQjUmx9SnnLwfFSzR1mT3+KoklEXI2FYnHBrRipsb3v
 eay9yIK8//E0kR2HVJUXVZF/EzdfjjzfWFK5UpsHL+gpDz8/hG5YyWVjLRBCqZK4M441
 ht4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978022; x=1708582822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=hovhhSIz5n8aKP1FMwb0UDKNgKvYwKEKyBOIrEYGh7b53JOSS2xD6ib3jUNxOhj+9e
 HDbdEj9EhJeKtIe21IxgosX06M3CSKSEOKId5X64ZMXZJxI6+fosFFEuREbcJDy+XvUk
 nMA6FlFHUTOIXdvaplj2g3u5zRFZTvcUB5HghjV1L+JBK90hMUxIjjW8t9rs4y+XcKIg
 hrHMrqzjWcE+O3JeRpLlQibIk6bDLpFIhNBgH6sH+8jNyk9z3SyN927/9/ZtPTch2yK0
 /SSJMooz7fohuAcCzll0UkRbPA90r3rrSyJu/rEg+s7u1jQjZ/ZNLEwkqFddr7fkONz+
 5ePQ==
X-Gm-Message-State: AOJu0Yxh7+/pKcYbFpzIOWU7016287+/h7vFkZ2k67I8PNpRpHjw7RQY
 Q5cZe9T3AfAlQnBknJuQXfpvlZQ6ir8iunc+rXmU4BrBH9pv7oPHGUVQ3v1OicLNNLfv6RgCrGF
 B
X-Google-Smtp-Source: AGHT+IEF52YibLsNNp2Mu5MkQP7MpXQ09mwMLB17Ak7zW0O4tngxN3LDW8W64aL9WoS8vaLHL9srzg==
X-Received: by 2002:a17:902:bb16:b0:1db:8f3d:d48d with SMTP id
 im22-20020a170902bb1600b001db8f3dd48dmr150517plb.22.1707978022425; 
 Wed, 14 Feb 2024 22:20:22 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 01/36] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Wed, 14 Feb 2024 20:19:43 -1000
Message-Id: <20240215062018.795056-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use qemu_real_host_page_size instead.  Except for the final mprotect
within page_protect, we already handled host < target page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-2-richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68b252cb8e..69b7429e31 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -651,16 +651,17 @@ void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
+    int host_page_size = qemu_real_host_page_size();
     int prot;
 
     assert_memory_lock();
 
-    if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+    if (host_page_size <= TARGET_PAGE_SIZE) {
         start = address & TARGET_PAGE_MASK;
         last = start + TARGET_PAGE_SIZE - 1;
     } else {
-        start = address & qemu_host_page_mask;
-        last = start + qemu_host_page_size - 1;
+        start = address & -host_page_size;
+        last = start + host_page_size - 1;
     }
 
     p = pageflags_find(start, last);
@@ -671,7 +672,7 @@ void page_protect(tb_page_addr_t address)
 
     if (unlikely(p->itree.last < last)) {
         /* More than one protection region covers the one host page. */
-        assert(TARGET_PAGE_SIZE < qemu_host_page_size);
+        assert(TARGET_PAGE_SIZE < host_page_size);
         while ((p = pageflags_next(p, start, last)) != NULL) {
             prot |= p->flags;
         }
@@ -679,7 +680,7 @@ void page_protect(tb_page_addr_t address)
 
     if (prot & PAGE_WRITE) {
         pageflags_set_clear(start, last, 0, PAGE_WRITE);
-        mprotect(g2h_untagged(start), qemu_host_page_size,
+        mprotect(g2h_untagged(start), last - start + 1,
                  prot & (PAGE_READ | PAGE_EXEC) ? PROT_READ : PROT_NONE);
     }
 }
@@ -725,18 +726,19 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         }
 #endif
     } else {
+        int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
         int prot;
 
-        if (qemu_host_page_size <= TARGET_PAGE_SIZE) {
+        if (host_page_size <= TARGET_PAGE_SIZE) {
             start = address & TARGET_PAGE_MASK;
             len = TARGET_PAGE_SIZE;
             prot = p->flags | PAGE_WRITE;
             pageflags_set_clear(start, start + len - 1, PAGE_WRITE, 0);
             current_tb_invalidated = tb_invalidate_phys_page_unwind(start, pc);
         } else {
-            start = address & qemu_host_page_mask;
-            len = qemu_host_page_size;
+            start = address & -host_page_size;
+            len = host_page_size;
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-- 
2.34.1


