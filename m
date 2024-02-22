Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFC2C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFuq-0006yD-8p; Thu, 22 Feb 2024 15:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuo-0006xs-QX
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFun-0002bl-73
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so520585ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634612; x=1709239412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=SwfpMlbChj9GimvK00b40lmzlQeHldHj7r499f+741B7BIeowbyP6D6si+/My+1Cfx
 RmKgqCK/QVkLZ8u5CftMrA4vjSdzIcwXVcRC5lTlBIedSiXBJ8PRiPdsLk2ouekQATc4
 Z4lYMeKg/Xkwfq0mQOsDeG2YdondWjStf8SOu7/g0j6sD0QfZoM1aSYk27hf4GA0s6dV
 QGsZQT8FFMGS4hCwNbzgqEPlV5h+2NfSMqL2rcOwZWgzfbYIbLhW7JPnP9v3eGU2UgZ8
 ceZ65KvMKlFg5Bj7NbWD+WZhbvJmAuRp36BZb8yrpg0I8nC3LY3ZzbCTcHuHOPILL4mh
 tzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634612; x=1709239412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2VXMZpzicQ4Dm28fmEM7ZpGthYgfI6UDANYII3bJPA=;
 b=j3CUbG4GqH3NVvoMfNouqz9Vo43wvUtvudhEIS0J+YdYJnS/LL5Z0Pi3OmsGinynSo
 vFf65Wt9Q0uTcwbw6qhEPD9xWq5n062VbS6LcAbnOK+gUQmn2NhstvVy/Nbxasi+3XPK
 w7WNVaSqFAHWUxG81m7yHjgTdtG6nnyCWDbc/t3+IIbEGjieMNrusfpv7wSh4Op1Skxq
 FS9Sgn8dbcxNpfH4A0mJOXRypxY2xfJ2JkjMQD2mXB4M8di+eXQ//8jQ1G/VYM5gr0gX
 T4fOL41InaF26ig/tavrhdxJPq9zcrJJ4Hh0OponFfvEtPzE0lfwPw0YtZ+IK/Kq9A0N
 9sgA==
X-Gm-Message-State: AOJu0YzXh9BAHPcjI5wpiIbgv+RvguIzyLdEc5h/g2jY69aet3C7mSO2
 uu+NTVL4C7EpDubDPQorv20yqe8yiVjssq53YbpmHJooWdPNe6p9qSzpn4Cxdcv/R2GmC+xjiOH
 V
X-Google-Smtp-Source: AGHT+IHslhyFBJCm6uPiyIGzPEI7Rf8m5cp/0bXtqZF8LH667ETcoPoyOEUE3pdQwWYdYkjOOSZzsQ==
X-Received: by 2002:a17:902:6ac8:b0:1d9:f83e:3a54 with SMTP id
 i8-20020a1709026ac800b001d9f83e3a54mr17359368plt.64.1708634611972; 
 Thu, 22 Feb 2024 12:43:31 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 04/39] accel/tcg: Remove qemu_host_page_size from
 page_protect/page_unprotect
Date: Thu, 22 Feb 2024 10:42:48 -1000
Message-Id: <20240222204323.268539-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


