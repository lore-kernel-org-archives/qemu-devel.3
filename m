Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75A0C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByL-0005k9-9w; Fri, 01 Mar 2024 18:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxp-0004vN-Bu
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxn-0004G4-HR
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:48 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so24577165ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334406; x=1709939206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=WC6R8Cy1R42yVSuTO2NwOSCU4z2YOpjV4Ec8i8ymmWDq4Dbh5jljrSJlGYyuTqu90a
 ng5tSnU9hPLGXMyyP4Fbh+hn8Vf8W+tS997UQ23/sgS/6cr7JVFWay7r6uQJorUjNDid
 3o7PlAMSYI9GD6i7Ov9Lh9CsytulkNEoNkHDJ/RJpQyHIeUP81TKiCwqQKrn1I2idd1n
 UUT6Cs496oa8wn0/55segL9Mj+akD9DDptJseOYpe0d6o2cUlo5nIQPMiZ+BTMmKBnGC
 1NtLcCrOKNjc7leD79cbrbSJuTPedAOiyzXG8bGMZGdOF2GfoX7sEX9n6Ckz2BhN8c48
 3Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334406; x=1709939206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=qKO9FIKqQ4hyxxJiKrUaJdCGIJckRIihzbYe9Whny87Ul28JR1JEHsZ0W7w7UoD4Ld
 NaDRmbS4wjlWPulMleT8OK4T/sICSESMP7/OPVxIDNkYYBv5zXjTqjhbaV4miWp1HD66
 zuT2h8KxwH1NnYc/dQmvajN7RSXOBlArxx76EKdspvnN35LoV9AuaYQ1pU0xQyqmPE0L
 zYVnim0qXhWZ45H9LKW/tj4Q4agGXBISybrDcFPfZrdwDOR/N8qaOoOFa88xxJBEZHsC
 BlbioILkq/NnUiBGTJWiAvWuCk7eF4rg5GdKNnpO5czG1ZtBY0Ng6BrUiZndZh0BFOU1
 VoOg==
X-Gm-Message-State: AOJu0YzjzhiMR2gZqag4gjF9Riiyy1AtrKGTPYfDvheHLer/e1RA9NcL
 +zvS5iC7S0vSf/k+VvslIe6198+hX9KBZXsQ2GX9QEnvLugZZwIvZVR3Xr3R3j6hrdaZJKB2O+9
 +
X-Google-Smtp-Source: AGHT+IHhX/hTS8JqfJgFZnNbpy4DodUMopAeISIYRTej3Phw3GQ6esTUSjBTHZJzRKoM075InFTK0w==
X-Received: by 2002:a17:902:7790:b0:1d9:a4bb:29f2 with SMTP id
 o16-20020a170902779000b001d9a4bb29f2mr2518601pll.46.1709334406292; 
 Fri, 01 Mar 2024 15:06:46 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 18/60] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Fri,  1 Mar 2024 13:05:37 -1000
Message-Id: <20240301230619.661008-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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


