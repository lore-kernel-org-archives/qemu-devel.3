Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B01DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLQv-0004RM-9c; Tue, 06 May 2025 12:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCLQo-0004Qi-BH
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:46:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCLQl-0003qB-3X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:46:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so20634065e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746549963; x=1747154763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CN0x7sDidlTSuZ0lYt7EHm+6CgKwp8xe6SoPkgfgX+A=;
 b=USgFjbXYPCHyvg09IkZJGTV/nUwWeUja3HlYCQLEmWzVV97U6ypgCMEUlGXrmAftRH
 5zGPvOoW7D93kJuZRmCseeqhEEyzJQdO4GpNCZ65pNyFnWlGfgcqmW0tMOBqT4CiRHku
 dvYfvE+yygzW4UMhsJaSyijySY6gkMij+GkGtJbYuFSyXriWNdTVkX+uZlVj2RPCdvEO
 9K2luBsOKJ5rqwrIHxmY35XELsjVw2bi5heYD95LT1xIlZNibOmxSAytvXebRHM8ySdl
 cfYCislZIUDv5snfhoTZ/H5V2AJrO7byx/jsrqCfhx6kef7TOLRYAgD8/J4KibDx+Mv/
 floA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746549963; x=1747154763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CN0x7sDidlTSuZ0lYt7EHm+6CgKwp8xe6SoPkgfgX+A=;
 b=PVlLvZJaKWy34r2S5z5JzFK2VGL5Vd0uljyEP4TNxkXJKaXa9UtttcHZBTrLPdjw/R
 dOJiXQ0T0smUapHpSpkYTrr9Sz9c/KGnD23Ak26avE+D3psY+ei4nLeckbPTleCFNI/7
 wD7aGnrduhia4O0D2xgAyK1m7WXtbeO2DrIEuOjHB9BoauZ59AKLiTjiTdTi6Dbjq5q2
 10FQ2ZWE4Y+5grsB+ikUWBP33coVF1v2Yw5WQi+ln8wtuYgWxh4VM8+r8GuPRikEUSnb
 q6wifyxWw0dVVVLqX4+EcANy7WJ5jffod0k5LtTtQpBU7CEVkO/7DKGy4FKwxj2NC0zu
 obzQ==
X-Gm-Message-State: AOJu0YzqRBySMDexiPw44+FmfYLzQPW3eQJ2N4JJBLXfg2UkcwKZ4tay
 6zUva5HjaUEBT9SI9p8w2wDjKTs9eVPVoNtDKQG9tB8oZRTuF+SFY0K+b1/6BDw=
X-Gm-Gg: ASbGncsJdbFh3eJIYwvPJKFvUuP7Wp5RJ0ugZkCVzzEEBW1WvMN5E7M8DaAxaFU7W5J
 sXas0JWZg0uG4oYJpCMRsGTxWsbFzXLjW2V99R0Vc8ifrTgnqVwLeyQNzRTe8IUmjS0UI24o5D+
 SgCszRsvuAS8XW5uZrSNYWwSC+thOzy15x7B7nENm2eSeXmae5rTVZuxuvrAOPO3aNVY4knVAmO
 VxPSxjQ3sf6l/8hEjdbZu0/NpJMGO9jJ1tGh6RT8eKq72w/O3xfvdeQdrBoQP+gUjIhQmNJC8m8
 wWgpLY+1GKsWWrIisON+eWX7mCNOVoIKKZMuaeqOij5FG1LabbOunVJgZqOKTVsJhR6cCDfnp+4
 qLTY5xumLu2JzvonwNgTXD6sSOjxH1M7F5MM=
X-Google-Smtp-Source: AGHT+IHSfZm17FyF50wR7EnPy7JzASO9Q5FACgDdHGXUBVuR4f5uSZkEOsuhLdXMdeQttT0eg/UiPA==
X-Received: by 2002:a05:600c:350e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-441bbe2c815mr173023695e9.0.1746549963257; 
 Tue, 06 May 2025 09:46:03 -0700 (PDT)
Received: from outlast.lan (97e5422b.skybroadband.com. [151.229.66.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0d15sm14529930f8f.13.2025.05.06.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:46:03 -0700 (PDT)
From: WorksButNotTested <jonwilson030981@googlemail.com>
X-Google-Original-From: WorksButNotTested
 <62701594+WorksButNotTested@users.noreply.github.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
Subject: [PATCH v3] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
Date: Tue,  6 May 2025 17:46:02 +0100
Message-ID: <20250506164602.1292446-1-62701594+WorksButNotTested@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

When running applications which make large (sparsely populated) address ranges
(e.g. when using address sanitizer with LibAFL) the inability to exclude these
regions from any core dump can result in very large files which fill the disk.
A coredump is obvously very useful for performing a post-mortem when fuzzing.

Whilst the man pages state that madvise provides only a hint (and hence can be
ignored), this patch adds support to handle MADV_DONTDUMP and set a
corresponding flag in the page flags, thus allowing QEMU to exclude these
regions from the core file.

Signed-off-by: WorksButNotTested <62701594+WorksButNotTested@users.noreply.github.com>
---
 include/exec/page-protection.h |  6 ++++++
 linux-user/elfload.c           |  4 ++++
 linux-user/mmap.c              | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b..f8826d917e 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,4 +38,10 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/*
+ * For linux-user, indicates that the page should not be included in a core 
+ * dump.
+ */
+#define PAGE_DONTDUMP   0x1000
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fbfdec2f17..41c46da055 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start, target_ulong end,
         return 0;
     }
 
+    if (flags & PAGE_DONTDUMP) {
+        return 0;
+    }
+
     /*
      * Usually we don't dump executable pages as they contain
      * non-writable code that debugger can read directly from
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f88a80c31e..016063a8cf 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1247,6 +1247,24 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_DONTDUMP:
+        if (len > 0) {
+            /*
+             * To set the page permissons, we must OR our new flags with the
+             * existing flags. Only mark the pages as PAGE_DONTDUMP if the
+             * entire range has the same flags. If any part of the range
+             * differs, we would need to process it one page at a time which
+             * might not be very performant. Since we are not obliged to respect
+             * this flag, we will support it for the most likely usage scenario.
+             * Note that we don't set PAGE_ANON, since this can only be set with
+             * new mappings.
+             */
+            int flg = page_get_flags(start);
+            if (page_check_range(start, len, flg)) {
+                page_set_flags(start, start + len - 1, PAGE_DONTDUMP | (flg & ~PAGE_ANON) );
+            }
+        }
+        break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-- 
2.43.0


