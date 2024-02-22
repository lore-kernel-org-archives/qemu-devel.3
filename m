Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27638C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvO-0007f3-KD; Thu, 22 Feb 2024 15:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvM-0007eF-Vl
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:09 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvL-0002kO-7l
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:08 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so1997345ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634646; x=1709239446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+mIi8OQkXxgV79040kdu3+FCdCNzpLRNnazUCypFlE=;
 b=VIhlhAbpL5iXGhnY5rZzpRWNY0dB9c7JHJjo5RkstGK5cE4Bt5jyppMQ/pvhDrPtos
 z2TT3rykEwUpzs8aiUz9GAUnRAkF5rsMMsaWjYzajz5somxEA3T+bvEZBPJT1vL9RsT7
 SLOKQO5oH1I/j6gbasbs+1f5korRVytoEsXB+5oT6oCljXjIn5LDOcBCMirz5WE/1QnZ
 cbfl1xGuyU1sl+oxEE5TTsp2jfIRobDdEp9MlomipAUcKxiFI3sD36meSYxRIN2Y59Jq
 sN+znUNHvawe8tgzjWS+0sEQqbK31OotNBmAUIHgY93h2/TIsXVjiu8WSvvtK8n0fj4+
 aTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634646; x=1709239446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+mIi8OQkXxgV79040kdu3+FCdCNzpLRNnazUCypFlE=;
 b=Vhun6DuD4lGQuoiZYWrQguxFEosSz2PTewynWQ57eOJC0BUjjd9qiUryCvyJs+LOHo
 fMr8arYHhAd7WunroH+98Winvn26a/uPSOpSwiIl7L29M4gkBW5NNfd1tX1jO+eS8/Qf
 oQbLIlgeyaxCg9O2cs1H2VDSFXH2PGhS6dthQsucC+cc3JeTv5eKAXVhCcOBQ29eutv8
 gy4m5EZBBrAyxWry1jTBuP3FXTM23/EozqpuVlw/bu3Kk1pU+YC5YNrWwkW5AIvLAbS9
 tMKo36IX3enNS+ijTPoTGZr/F/cm+nBxa2uJczeiub7PwIcHH8OmdKgJ3f/FG7YeBMGq
 ULHg==
X-Gm-Message-State: AOJu0YzvljaFM8fmmrC/deYpDWDU7H7X0LToisA2TzXgtIa+yn2s6TYB
 0RTUfnHFvAlIfW0S8r3D2WcCA8fhY74eVQj1oqXT5SkI0z6QZHTojMIK36dILMBXV3VWZ+jKdTo
 e
X-Google-Smtp-Source: AGHT+IGJQXINA+zntUgjfujiTO13Tk5er0M2KLyX3IG0XVpHUc1nAnPiwOxBID8VRbC4M2mZ5zlvnA==
X-Received: by 2002:a17:903:1105:b0:1d9:8832:f800 with SMTP id
 n5-20020a170903110500b001d98832f800mr25026852plh.8.1708634645785; 
 Thu, 22 Feb 2024 12:44:05 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 26/39] linux-user: Split out mmap_h_eq_g
Date: Thu, 22 Feb 2024 10:43:10 -1000
Message-Id: <20240222204323.268539-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Move the MAX_FIXED_NOREPLACE check for reserved_va earlier.
Move the computation of host_prot earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-22-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 68 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cbcd31e941..d3556bcc14 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -542,6 +542,33 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
     return start;
 }
 
+/*
+ * Special case host page size == target page size,
+ * where there are no edge conditions.
+ */
+static abi_long mmap_h_eq_g(abi_ulong start, abi_ulong len,
+                            int host_prot, int flags, int page_flags,
+                            int fd, off_t offset)
+{
+    void *p, *want_p = g2h_untagged(start);
+    abi_ulong last;
+
+    p = mmap(want_p, len, host_prot, flags, fd, offset);
+    if (p == MAP_FAILED) {
+        return -1;
+    }
+    /* If the host kernel does not support MAP_FIXED_NOREPLACE, emulate. */
+    if ((flags & MAP_FIXED_NOREPLACE) && p != want_p) {
+        do_munmap(p, len);
+        errno = EEXIST;
+        return -1;
+    }
+
+    start = h2g(p);
+    last = start + len - 1;
+    return mmap_end(start, last, start, last, flags, page_flags);
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -550,6 +577,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     off_t host_offset;
+    int host_prot;
 
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
@@ -558,16 +586,33 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
      * For reserved_va, we are in full control of the allocation.
      * Find a suitable hole and convert to MAP_FIXED.
      */
-    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        host_len = len + offset - host_offset;
-        start = mmap_find_vma(real_start, host_len,
-                              MAX(host_page_size, TARGET_PAGE_SIZE));
-        if (start == (abi_ulong)-1) {
-            errno = ENOMEM;
-            return -1;
+    if (reserved_va) {
+        if (flags & MAP_FIXED_NOREPLACE) {
+            /* Validate that the chosen range is empty. */
+            if (!page_check_range_empty(start, start + len - 1)) {
+                errno = EEXIST;
+                return -1;
+            }
+            flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+        } else if (!(flags & MAP_FIXED)) {
+            size_t real_len = len + offset - host_offset;
+            abi_ulong align = MAX(host_page_size, TARGET_PAGE_SIZE);
+
+            start = mmap_find_vma(real_start, real_len, align);
+            if (start == (abi_ulong)-1) {
+                errno = ENOMEM;
+                return -1;
+            }
+            start += offset - host_offset;
+            flags |= MAP_FIXED;
         }
-        start += offset - host_offset;
-        flags |= MAP_FIXED;
+    }
+
+    host_prot = target_to_host_prot(target_prot);
+
+    if (host_page_size == TARGET_PAGE_SIZE) {
+        return mmap_h_eq_g(start, len, host_prot, flags,
+                           page_flags, fd, offset);
     }
 
     /*
@@ -603,12 +648,10 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         uintptr_t host_start;
-        int host_prot;
         void *p;
 
         host_len = len + offset - host_offset;
         host_len = ROUND_UP(host_len, host_page_size);
-        host_prot = target_to_host_prot(target_prot);
 
         /* Note: we prefer to control the mapping address. */
         p = mmap(g2h_untagged(start), host_len, host_prot,
@@ -731,8 +774,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             len1 = real_last - real_start + 1;
             want_p = g2h_untagged(real_start);
 
-            p = mmap(want_p, len1, target_to_host_prot(target_prot),
-                     flags, fd, offset1);
+            p = mmap(want_p, len1, host_prot, flags, fd, offset1);
             if (p != want_p) {
                 if (p != MAP_FAILED) {
                     do_munmap(p, len1);
-- 
2.34.1


