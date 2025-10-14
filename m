Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D21CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ikZ-00018z-Lj; Tue, 14 Oct 2025 13:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikY-000184-4S
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikV-0008CQ-FZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-781206cce18so117187b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760462624; x=1761067424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE/L4nHYv6E0nW8LCragzopjp5sCZZHKC1hbmexUOBE=;
 b=VJfO2RcpCNeiZy3RrNBolt4/2mAhCeutmfS0aitPz0gxN4FocQpTgwCvyF94zxea93
 mBVOSRbyV2c0KQm0ZiUiyg6CD9IRmsAEpfSW7mDvlYdcEktz7MmDowV1sLQZw56RQWlL
 ALt+dce4/Z5/N3W/Bca4SaTDO3tjl6vydaZf+KtvNf1LVzuM3zK4XBiV9NvuSLwMFYPc
 u3JhYtcWrbVKaWZFhVbkWsQ0Qu8ERaiLLjntw8Dl03nJDlwFdyYSDqbHOL7nR6fTMw3M
 lD5MRw3tNIXW8V02szYZpEcl246SJt1wsiH19lOCN00nDgnMz6eYLFvf2b6JCR8SnXOj
 Kzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760462624; x=1761067424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE/L4nHYv6E0nW8LCragzopjp5sCZZHKC1hbmexUOBE=;
 b=XnD/aEUfyCl4F9xUUL3IRp+Jh3rg0YdaP3If/mXQs4nJnyp3SDN1KZOzvt9lQJ2SCo
 nK26dzMieA/suqr0vq/muwGR3T1TtoCfHoyoMyEJitcBeeiPoGle5XQxUR4jl4HwuYkI
 5D/E/wrF7JLpjsiEs8N7/QhIK8DGfzRt4aoaw23DXzdIDRHxrAI9bltKXYgIMpkhtZrP
 5VgLoSBMKz7fE7JYde6MPP+PLWOA0+dp+mVaHXFmDEj2eMEbJSsSKxHB8KuhRwSgfCxa
 L5I5YWeTXMYJDO2fJ8ttmI4nQ4onfPK1KAW4l6+fQfiW4Zf15OtzusTwfxUgPPstzpRZ
 sGVw==
X-Gm-Message-State: AOJu0YzQ4wiywtzasdq5opL46vpg0XRtLyNpk8WQ286wy0goiC9Hhpha
 OK7MkQQRHzndvsMHToERsJwXLZRMAteXzuNCXqkCwblmvhv08VyYI/y68sc/kd5mqple8cFoe/J
 sgGmpGYw=
X-Gm-Gg: ASbGncvL0ExjWK09G9A4TP6DLZ+eJoWRjSa1oArTZHfSfVuiErNVIJPqOSa4hALAtgm
 BB0ovMIe0RFzdNXcC1Tnrb7KniJusakGdWkaTKNLDRwt+ferRFWJueEVVAtrTGFqxhZP1wj7KrW
 tWpEBvqBgQ5Mh2Tm9hRvxnWbLNUMo4hvEXh8/zw4mz2sPYEruzVj7s6nNZCSd533yET4wrF6fGS
 m7bMaHJkbb49DlLXa942UaqhKMaJBgZaZ88mZSFBoabnJXHh+VKidpGDgRQz9i+toefpQUIREqj
 8J3/a6BTkMaehmUWhGm2Byx+kReybfddOyq8iogmYWNGV5NimhcmwZFYLnLtkMuvmeQd/sFHGg4
 XutrAe/jLtpYV/c3FPjos06PJXBlzPQqUs0w4xE6JXARbf0OVuNgikJSl/S0ybQ==
X-Google-Smtp-Source: AGHT+IFWXGc/AkmhwrY9X7IJ2hdP0OJSpVBqJOUktqEDS43YXJRdXLOEx0WkFMTygBXtrBQOBo8b8A==
X-Received: by 2002:a05:6a00:987:b0:781:1110:f175 with SMTP id
 d2e1a72fcca58-793992757eemr31731545b3a.14.1760462624237; 
 Tue, 14 Oct 2025 10:23:44 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb116basm15741913b3a.30.2025.10.14.10.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jon Wilson <jonwilson030981@gmail.com>
Subject: [PULL 2/3] linux-user: Support MADV_DONTDUMP, MADV_DODUMP
Date: Tue, 14 Oct 2025 10:23:40 -0700
Message-ID: <20251014172341.243858-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014172341.243858-1-richard.henderson@linaro.org>
References: <20251014172341.243858-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jon Wilson <jonwilson030981@gmail.com>

Set and clear PAGE_DONTDUMP, and honor that in vma_dump_size.

Signed-off-by: Jon Wilson <jonwilson030981@gmail.com>
[rth: Use new page_set_flags semantics; also handle DODUMP]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/page-protection.h | 6 +++++-
 linux-user/elfload.c           | 4 ++--
 linux-user/mmap.c              | 6 ++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index 5a18f98a3a..c50ce57d15 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -30,7 +30,11 @@
 #define PAGE_PASSTHROUGH 0x40
 /* For linux-user, indicates that the page is MAP_ANON. */
 #define PAGE_ANON      0x0080
-
+/*
+ * For linux-user, indicates that the page should not be
+ * included in a core dump.
+ */
+#define PAGE_DONTDUMP  0x0100
 /* Target-specific bits that will be used via page_get_flags().  */
 #define PAGE_TARGET_1  0x0200
 #define PAGE_TARGET_2  0x0400
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1370ec59be..0002d5be2f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2127,8 +2127,8 @@ static void bswap_note(struct elf_note *en)
  */
 static size_t vma_dump_size(vaddr start, vaddr end, int flags)
 {
-    /* The area must be readable. */
-    if (!(flags & PAGE_READ)) {
+    /* The area must be readable and dumpable. */
+    if (!(flags & PAGE_READ) || (flags & PAGE_DONTDUMP)) {
         return 0;
     }
 
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 527ca5f211..423c77856a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1248,6 +1248,12 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_DONTDUMP:
+        page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
+        break;
+    case MADV_DODUMP:
+        page_set_flags(start, start + len - 1, 0, PAGE_DONTDUMP);
+        break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-- 
2.43.0


