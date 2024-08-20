Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5504C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 05:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgH7b-0004l1-0v; Tue, 20 Aug 2024 01:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH7C-0004MO-9Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:09:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgH7A-0007qP-Lv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 01:09:06 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-713edc53429so1544579b3a.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724130543; x=1724735343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rLh/vfsNw8zpHc+sq9u0/i4PzeonkxDDSgQpULc4qg=;
 b=jfRrJBxZAf5KGv0XxmmNawA376QCKO/4z7VZkUJTqoB7BFnYe/rVHrMMIeKSoYKEdr
 Kq8iHt38/kH04KIajcMvhqcDq9yG6mtcjhF/8YYY4uCmgAYem1Nc83mEHggepVpGbRg7
 FBxanEW7VimjmgzWIQI0zsojDNdDvsEBZsz1oURTtP41xlbdEm5hRTFxv/RO+UPEixMH
 OsIorRcMxwuxUx6N7CCLgLE8TO907PUOU59kHHatkIJ4FqX0dQG70yIPB6uFFNvO+n6y
 CQbtZugCkVHxwi3n94fyuUJfxq+8EdUdQAg5TivQ9il0atUneBjerjt7jwnclgRdQb7u
 S8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724130543; x=1724735343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rLh/vfsNw8zpHc+sq9u0/i4PzeonkxDDSgQpULc4qg=;
 b=TIS4KQkKDDeTn8a6rQnb7T7kGNSmbj57DV5RTaNK9qJeaLsyy9WANEv/BL2i4n1/qQ
 NxHizbEwc/XSqUE3OdLvx/Z4qa1lF/F9F7q14TJrj8Jy+VOz2O+M+B+wFyXqJ0pnZ1lB
 yi/X2qZGPyXWNMsxf2k4+oTmVnpCMiQxvfMg50WwtGQzZ4hkTeLKRlLNEddxwZ8Ttzv/
 Qx8LOGH04gcLXLn1LF57NIuxwLBLDbl1kMnrGboeF1nQ9H8Cee9aBclApjmGl10ld5n4
 HzDEOuyHpEH4r+tIb52tBUYaJvNFDU/zQsAKDBfrnbStodO8lSqu0QnWN/wrURMW6In3
 PLmA==
X-Gm-Message-State: AOJu0Yyr+F10o3XR8UNpdbtRDyU95Isf1lTZG39E+j4r7jUSfbZc0/p2
 PAwazpdyD/S+qwqOQRg+nwprHWBLY6eqyLQ8hZTwJ69ZLEpP+U5S9ES4iIAw91H6zmFD18T9/T4
 f46Y=
X-Google-Smtp-Source: AGHT+IGKF2aIxvOO6/j3etQboCG6qiFtlRFveX3d/XlShdbUgibfJ2vI3yy2HbORhOD62qQU5YezlQ==
X-Received: by 2002:a05:6a00:198d:b0:70d:1e20:1c1c with SMTP id
 d2e1a72fcca58-713c4ed3913mr12924086b3a.22.1724130542575; 
 Mon, 19 Aug 2024 22:09:02 -0700 (PDT)
Received: from stoup.. ([203.30.3.188]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af416fbsm7382814b3a.207.2024.08.19.22.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 22:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	philmd@linaro.org,
	imp@bsdimp.com
Subject: [PATCH v2 2/2] bsd-user: Handle short reads in mmap_h_gt_g
Date: Tue, 20 Aug 2024 15:08:48 +1000
Message-ID: <20240820050848.165253-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820050848.165253-1-richard.henderson@linaro.org>
References: <20240820050848.165253-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

In particular, if an image has a large bss, we can hit EOF before reading
all bytes of the mapping.  Mirror the similar change to linux-user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index f3a4f1712d..775e905960 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -128,6 +128,40 @@ error:
     return ret;
 }
 
+/*
+ * Perform a pread on behalf of target_mmap.  We can reach EOF, we can be
+ * interrupted by signals, and in general there's no good error return path.
+ * If @zero, zero the rest of the block at EOF.
+ * Return true on success.
+ */
+static bool mmap_pread(int fd, void *p, size_t len, off_t offset, bool zero)
+{
+    while (1) {
+        ssize_t r = pread(fd, p, len, offset);
+
+        if (likely(r == len)) {
+            /* Complete */
+            return true;
+        }
+        if (r == 0) {
+            /* EOF */
+            if (zero) {
+                memset(p, 0, len);
+            }
+            return true;
+        }
+        if (r > 0) {
+            /* Short read */
+            p += r;
+            len -= r;
+            offset += r;
+        } else if (errno != EINTR) {
+            /* Error */
+            return false;
+        }
+    }
+}
+
 /*
  * map an incomplete host page
  *
@@ -190,7 +224,7 @@ static int mmap_frag(abi_ulong real_start,
             mprotect(host_start, qemu_host_page_size, prot1 | PROT_WRITE);
 
         /* read the corresponding file data */
-        if (pread(fd, g2h_untagged(start), end - start, offset) == -1) {
+        if (!mmap_pread(fd, g2h_untagged(start), end - start, offset, true)) {
             return -1;
         }
 
@@ -565,7 +599,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                                   -1, 0);
             if (retaddr == -1)
                 goto fail;
-            if (pread(fd, g2h_untagged(start), len, offset) == -1) {
+            if (!mmap_pread(fd, g2h_untagged(start), len, offset, false)) {
                 goto fail;
             }
             if (!(prot & PROT_WRITE)) {
-- 
2.43.0


