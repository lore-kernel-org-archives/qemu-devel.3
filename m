Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB75C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2P-0004fb-HL; Fri, 01 Mar 2024 18:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1O-0003f8-CW
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:31 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1K-0005dn-AF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:29 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-365c96e2605so10492445ab.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334624; x=1709939424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4UwZkIS26PhKHP+iY1jWw6KRSEUK2Dc0FNGbwDM3y4=;
 b=y7inVYTmmCQwt+c1mcimvuVifIwBmPOKWglqaYA8yELg87KB/utF5iWOPYmvoF4rZe
 eXWNedSUqB2mBJr1aeeAfNUgdca2tXs+R7u+3glSvxrUwHso0s4tWiABNgwZNYd7GyZl
 NL4zdV7hDUVh4XQ3iCkJsj7ry3OiTHv5nMIlqbvgR2/bkgfQzdMyggIOqiJMNL9OId+5
 uKdCbDiEokGI/9MsrLz4DUe6tfWYhL8sC1WPrWLJP4fmeWrekWC3EyQpC21cTK1GxISg
 L4+UEE0+OORKQhDo0SkAjsETNVe++vKlcd64BLGVmPDMbuMguT/jHQN5wfmKWKg8ohwJ
 bh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334624; x=1709939424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4UwZkIS26PhKHP+iY1jWw6KRSEUK2Dc0FNGbwDM3y4=;
 b=bMUfAb3YGvii1U1ol2zwskoGYeHKinT6jxZYiWcCTL52PFlX+A1zXPRFAG46sA4WHs
 JcPHHi2FK0tXUaPP2swmF7hdxk+gQLj0kR9M+uITVuZQ5x9A98LsbTFRBvji0kZ3IaYh
 SBzMSLiJepji/8QPb+cp7BVy5F1MdnOFGGTw02DLFEgZD13TE/i13Ygm6devRMxedZfW
 +m011jgfjOY/aR1MjROW9NaHSSGWAIESHz5Y2MWY7Y3IqzSBtVuNLM7HagDLOr4amUkZ
 ElsQMmu97PgV38CseSxpjSjB942DnY39gy7afRRTOs+jWrwjFcFQMnj+fvanaZVI5bB+
 FLcw==
X-Gm-Message-State: AOJu0YzqG/1qYbQ20NPXCvIJJxIZtHShVzNQ1uNN9rtdpqFRrhcYF3qt
 9iwkca7tD00SWGpVPYMSKrlTWfCN+Ykwjl69STDmZbWf9I3KQXE2gMNgBpD8x1kj9VxnsewnC8k
 c
X-Google-Smtp-Source: AGHT+IG53LjvkCuURiL/wExFQJzOkNtlyt+cSmSejHhcFbykvjx6jed8znqvwrTvrFq5tZpmec9PXg==
X-Received: by 2002:a05:6e02:490:b0:365:d2bc:a535 with SMTP id
 b16-20020a056e02049000b00365d2bca535mr2671246ils.14.1709334624422; 
 Fri, 01 Mar 2024 15:10:24 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 42/60] linux-user: Split out mmap_h_lt_g
Date: Fri,  1 Mar 2024 13:06:01 -1000
Message-Id: <20240301230619.661008-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
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

Work much harder to get alignment and mapping beyond the end
of the file correct.  Both of which are excercised by our
test-mmap for alpha (8k pages) on any 4k page host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-23-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 184 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 153 insertions(+), 31 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d3556bcc14..ff8f9f7ed0 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -569,6 +569,156 @@ static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
     return mmap_end(start, last, start, last, flags, page_flags);
 }
 
+/*
+ * Special case host page size < target page size.
+ *
+ * The two special cases are increased guest alignment, and mapping
+ * past the end of a file.
+ *
+ * When mapping files into a memory area larger than the file,
+ * accesses to pages beyond the file size will cause a SIGBUS.
+ *
+ * For example, if mmaping a file of 100 bytes on a host with 4K
+ * pages emulating a target with 8K pages, the target expects to
+ * be able to access the first 8K. But the host will trap us on
+ * any access beyond 4K.
+ *
+ * When emulating a target with a larger page-size than the hosts,
+ * we may need to truncate file maps at EOF and add extra anonymous
+ * pages up to the targets page boundary.
+ *
+ * This workaround only works for files that do not change.
+ * If the file is later extended (e.g. ftruncate), the SIGBUS
+ * vanishes and the proper behaviour is that changes within the
+ * anon page should be reflected in the file.
+ *
+ * However, this case is rather common with executable images,
+ * so the workaround is important for even trivial tests, whereas
+ * the mmap of of a file being extended is less common.
+ */
+static abi_long mmap_h_lt_g(abi_ulong start, abi_ulong len, int host_prot,
+                            int mmap_flags, int page_flags, int fd,
+                            off_t offset, int host_page_size)
+{
+    void *p, *want_p = g2h_untagged(start);
+    off_t fileend_adj = 0;
+    int flags = mmap_flags;
+    abi_ulong last, pass_last;
+
+    if (!(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
+
+        if (fstat(fd, &sb) == -1) {
+            return -1;
+        }
+        if (offset >= sb.st_size) {
+            /*
+             * The entire map is beyond the end of the file.
+             * Transform it to an anonymous mapping.
+             */
+            flags |= MAP_ANONYMOUS;
+            fd = -1;
+            offset = 0;
+        } else if (offset + len > sb.st_size) {
+            /*
+             * A portion of the map is beyond the end of the file.
+             * Truncate the file portion of the allocation.
+             */
+            fileend_adj = offset + len - sb.st_size;
+        }
+    }
+
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (fileend_adj) {
+            p = mmap(want_p, len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        } else {
+            p = mmap(want_p, len, host_prot, flags, fd, offset);
+        }
+        if (p != want_p) {
+            if (p != MAP_FAILED) {
+                /* Host does not support MAP_FIXED_NOREPLACE: emulate. */
+                do_munmap(p, len);
+                errno = EEXIST;
+            }
+            return -1;
+        }
+
+        if (fileend_adj) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
+                           fd, offset);
+
+            if (t == MAP_FAILED) {
+                int save_errno = errno;
+
+                /*
+                 * We failed a map over the top of the successful anonymous
+                 * mapping above. The only failure mode is running out of VMAs,
+                 * and there's nothing that we can do to detect that earlier.
+                 * If we have replaced an existing mapping with MAP_FIXED,
+                 * then we cannot properly recover.  It's a coin toss whether
+                 * it would be better to exit or continue here.
+                 */
+                if (!(flags & MAP_FIXED_NOREPLACE) &&
+                    !page_check_range_empty(start, start + len - 1)) {
+                    qemu_log("QEMU target_mmap late failure: %s",
+                             strerror(save_errno));
+                }
+
+                do_munmap(want_p, len);
+                errno = save_errno;
+                return -1;
+            }
+        }
+    } else {
+        size_t host_len, part_len;
+
+        /*
+         * Take care to align the host memory.  Perform a larger anonymous
+         * allocation and extract the aligned portion.  Remap the file on
+         * top of that.
+         */
+        host_len = len + TARGET_PAGE_SIZE - host_page_size;
+        p = mmap(want_p, host_len, host_prot, flags | MAP_ANONYMOUS, -1, 0);
+        if (p == MAP_FAILED) {
+            return -1;
+        }
+
+        part_len = (uintptr_t)p & (TARGET_PAGE_SIZE - 1);
+        if (part_len) {
+            part_len = TARGET_PAGE_SIZE - part_len;
+            do_munmap(p, part_len);
+            p += part_len;
+            host_len -= part_len;
+        }
+        if (len < host_len) {
+            do_munmap(p + len, host_len - len);
+        }
+
+        if (!(flags & MAP_ANONYMOUS)) {
+            void *t = mmap(p, len - fileend_adj, host_prot,
+                           flags | MAP_FIXED, fd, offset);
+
+            if (t == MAP_FAILED) {
+                int save_errno = errno;
+                do_munmap(p, len);
+                errno = save_errno;
+                return -1;
+            }
+        }
+
+        start = h2g(p);
+    }
+
+    last = start + len - 1;
+    if (fileend_adj) {
+        pass_last = ROUND_UP(last - fileend_adj, host_page_size) - 1;
+    } else {
+        pass_last = last;
+    }
+    return mmap_end(start, last, start, pass_last, mmap_flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -613,37 +763,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     if (host_page_size == TARGET_PAGE_SIZE) {
         return mmap_h_eq_g(start, len, host_prot, flags,
                            page_flags, fd, offset);
-    }
-
-    /*
-     * When mapping files into a memory area larger than the file, accesses
-     * to pages beyond the file size will cause a SIGBUS.
-     *
-     * For example, if mmaping a file of 100 bytes on a host with 4K pages
-     * emulating a target with 8K pages, the target expects to be able to
-     * access the first 8K. But the host will trap us on any access beyond
-     * 4K.
-     *
-     * When emulating a target with a larger page-size than the hosts, we
-     * may need to truncate file maps at EOF and add extra anonymous pages
-     * up to the targets page boundary.
-     */
-    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
-        struct stat sb;
-
-        if (fstat(fd, &sb) == -1) {
-            return -1;
-        }
-
-        /* Are we trying to create a map beyond EOF?.  */
-        if (offset + len > sb.st_size) {
-            /*
-             * If so, truncate the file map at eof aligned with
-             * the hosts real pagesize. Additional anonymous maps
-             * will be created beyond EOF.
-             */
-            len = ROUND_UP(sb.st_size - offset, host_page_size);
-        }
+    } else if (host_page_size < TARGET_PAGE_SIZE) {
+        return mmap_h_lt_g(start, len, host_prot, flags,
+                           page_flags, fd, offset, host_page_size);
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-- 
2.34.1


