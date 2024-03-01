Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE845C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByC-0005Zw-JH; Fri, 01 Mar 2024 18:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy3-00056g-0k
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxz-0004Ip-W5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dca8b86ee7so25633625ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334419; x=1709939219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FHxKdfDsfaKmMG5O+L7r4x4DJpI3IWY2MOpcFadlFM=;
 b=u3uEyxyqvTWtkqKogANqRJHyx/OVSJ7I6+MTp6qIkHY2vI/+oqfouq2f9gssprhdxP
 3z9KZr2DKpvAa/9dSExJqWVi2mAfsvogg8RaMNq4EquVFo6C/hI0/emrka2JSJgFzbUw
 lmNam3kBclBVVqlsBWRlIA33YwKqKzesRppnxhj+rpFdBij7pxlzsIxcEts5gsF4FzU4
 6NSrb9TBjg39Ag5RJ5rgMrfbddzaDqZN13bBP+JApKrgNQV+6CoS/H2Tud5VIfmShVRU
 J/32wyLyS28KEu5bVuGRagkjDaVivQC268a0CWDix4mWEaOPnvgPVhhRkuO3WNm82Dan
 h7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334419; x=1709939219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FHxKdfDsfaKmMG5O+L7r4x4DJpI3IWY2MOpcFadlFM=;
 b=FSaVCbY4chbU81tpz+Xa2u/4O39g47lt0djiwevmYILMlsjlYnzX9nXxf0Lr0GR7rj
 i3lEU0GDZECQyZxVJ1mFJUnTmSoxHHHVTGY0yu6zZzrqBCj0HM+rcmSlgjp5oWLU7ti+
 4eP5rB2ewLW1vmBawCSTdDYU/E0mCcYJHqn986sgys2hzhtNZNY79m/MmH7tqVb3WlXi
 +0dEJMz5oTS5fEn4ajdtHwy0DnTA1wlMZPS3/y5xI80hRSNcq4sxxFdmy3uY+vJK2EmG
 Zx4Jx/UrhRo1xwOQtujUEBEpBRcTLX9jnUOkHBRmx/3MQRZA45CaVtAXiPehRvXuaMeu
 x3Fw==
X-Gm-Message-State: AOJu0YzTzqXZSmdNRFi77YMH54OdPe8LqwEopUJdGo/OnDHL81x9YkWG
 qoTQn6PzhKD789f3KaC/jixnqBxgEv5e6ybkRdJ6Q4tHkQGqGZIx4HHwjvB+1d/OK5h7RNLVIPB
 p
X-Google-Smtp-Source: AGHT+IHyS2u6qyKZfKwwcGnkl91NfNavl1QWAcBz9IAan+YgjMWALvLE9Nx26LliLGqIogMWSMZ/tw==
X-Received: by 2002:a17:903:110c:b0:1db:f15e:671c with SMTP id
 n12-20020a170903110c00b001dbf15e671cmr3899921plh.40.1709334418760; 
 Fri, 01 Mar 2024 15:06:58 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 26/60] linux-user: Remove qemu_host_page_{size,
 mask} from mmap.c
Date: Fri,  1 Mar 2024 13:05:45 -1000
Message-Id: <20240301230619.661008-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Use qemu_real_host_page_size instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-9-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 96c9433e27..4d3c8717b9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -165,6 +165,7 @@ static int target_to_host_prot(int prot)
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong starts[3];
     abi_ulong lens[3];
     int prots[3];
@@ -189,13 +190,13 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     }
 
     last = start + len - 1;
-    host_start = start & qemu_host_page_mask;
+    host_start = start & -host_page_size;
     host_last = HOST_PAGE_ALIGN(last) - 1;
     nranges = 0;
 
     mmap_lock();
 
-    if (host_last - host_start < qemu_host_page_size) {
+    if (host_last - host_start < host_page_size) {
         /* Single host page contains all guest pages: sum the prot. */
         prot1 = target_prot;
         for (abi_ulong a = host_start; a < start; a += TARGET_PAGE_SIZE) {
@@ -205,7 +206,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             prot1 |= page_get_flags(a + 1);
         }
         starts[nranges] = host_start;
-        lens[nranges] = qemu_host_page_size;
+        lens[nranges] = host_page_size;
         prots[nranges] = prot1;
         nranges++;
     } else {
@@ -218,10 +219,10 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             /* If the resulting sum differs, create a new range. */
             if (prot1 != target_prot) {
                 starts[nranges] = host_start;
-                lens[nranges] = qemu_host_page_size;
+                lens[nranges] = host_page_size;
                 prots[nranges] = prot1;
                 nranges++;
-                host_start += qemu_host_page_size;
+                host_start += host_page_size;
             }
         }
 
@@ -233,9 +234,9 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
             }
             /* If the resulting sum differs, create a new range. */
             if (prot1 != target_prot) {
-                host_last -= qemu_host_page_size;
+                host_last -= host_page_size;
                 starts[nranges] = host_last + 1;
-                lens[nranges] = qemu_host_page_size;
+                lens[nranges] = host_page_size;
                 prots[nranges] = prot1;
                 nranges++;
             }
@@ -270,6 +271,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong real_last;
     void *host_start;
     int prot_old, prot_new;
@@ -286,7 +288,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
         return false;
     }
 
-    real_last = real_start + qemu_host_page_size - 1;
+    real_last = real_start + host_page_size - 1;
     host_start = g2h_untagged(real_start);
 
     /* Get the protection of the target pages outside the mapping. */
@@ -304,12 +306,12 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
          * outside of the fragment we need to map.  Allocate a new host
          * page to cover, discarding whatever else may have been present.
          */
-        void *p = mmap(host_start, qemu_host_page_size,
+        void *p = mmap(host_start, host_page_size,
                        target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
         if (p != host_start) {
             if (p != MAP_FAILED) {
-                munmap(p, qemu_host_page_size);
+                munmap(p, host_page_size);
                 errno = EEXIST;
             }
             return false;
@@ -324,7 +326,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     /* Adjust protection to be able to write. */
     if (!(host_prot_old & PROT_WRITE)) {
         host_prot_old |= PROT_WRITE;
-        mprotect(host_start, qemu_host_page_size, host_prot_old);
+        mprotect(host_start, host_page_size, host_prot_old);
     }
 
     /* Read or zero the new guest pages. */
@@ -338,7 +340,7 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
 
     /* Put final protection */
     if (host_prot_new != host_prot_old) {
-        mprotect(host_start, qemu_host_page_size, host_prot_new);
+        mprotect(host_start, host_page_size, host_prot_new);
     }
     return true;
 }
@@ -373,17 +375,18 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
  */
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 {
+    int host_page_size = qemu_real_host_page_size();
     void *ptr, *prev;
     abi_ulong addr;
     int wrapped, repeat;
 
-    align = MAX(align, qemu_host_page_size);
+    align = MAX(align, host_page_size);
 
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;
     } else {
-        start &= qemu_host_page_mask;
+        start &= -host_page_size;
     }
     start = ROUND_UP(start, align);
 
@@ -492,6 +495,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
     int page_flags;
@@ -537,8 +541,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
 
-    real_start = start & qemu_host_page_mask;
-    host_offset = offset & qemu_host_page_mask;
+    real_start = start & -host_page_size;
+    host_offset = offset & -host_page_size;
 
     /*
      * If the user is asking for the kernel to find a location, do that
@@ -567,8 +571,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * may need to truncate file maps at EOF and add extra anonymous pages
      * up to the targets page boundary.
      */
-    if ((qemu_real_host_page_size() < qemu_host_page_size) &&
-        !(flags & MAP_ANONYMOUS)) {
+    if (host_page_size < TARGET_PAGE_SIZE && !(flags & MAP_ANONYMOUS)) {
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
@@ -595,11 +598,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         host_len = HOST_PAGE_ALIGN(host_len);
         host_prot = target_to_host_prot(target_prot);
 
-        /*
-         * Note: we prefer to control the mapping address. It is
-         * especially important if qemu_host_page_size >
-         * qemu_real_host_page_size.
-         */
+        /* Note: we prefer to control the mapping address. */
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
@@ -665,7 +664,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          * aligned, so we read it
          */
         if (!(flags & MAP_ANONYMOUS) &&
-            (offset & ~qemu_host_page_mask) != (start & ~qemu_host_page_mask)) {
+            (offset & (host_page_size - 1)) != (start & (host_page_size - 1))) {
             /*
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
@@ -694,7 +693,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 
         /* handle the start of the mapping */
         if (start > real_start) {
-            if (real_last == real_start + qemu_host_page_size - 1) {
+            if (real_last == real_start + host_page_size - 1) {
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
@@ -703,21 +702,21 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 goto the_end1;
             }
             if (!mmap_frag(real_start, start,
-                           real_start + qemu_host_page_size - 1,
+                           real_start + host_page_size - 1,
                            target_prot, flags, fd, offset)) {
                 goto fail;
             }
-            real_start += qemu_host_page_size;
+            real_start += host_page_size;
         }
         /* handle the end of the mapping */
         if (last < real_last) {
-            abi_ulong real_page = real_last - qemu_host_page_size + 1;
+            abi_ulong real_page = real_last - host_page_size + 1;
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
                 goto fail;
             }
-            real_last -= qemu_host_page_size;
+            real_last -= host_page_size;
         }
 
         /* map the middle (easier) */
@@ -784,6 +783,7 @@ fail:
 
 static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
+    int host_page_size = qemu_real_host_page_size();
     abi_ulong real_start;
     abi_ulong real_last;
     abi_ulong real_len;
@@ -793,7 +793,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     int prot;
 
     last = start + len - 1;
-    real_start = start & qemu_host_page_mask;
+    real_start = start & -host_page_size;
     real_last = HOST_PAGE_ALIGN(last) - 1;
 
     /*
@@ -802,7 +802,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
      * The single page special case is required for the last page,
      * lest real_start overflow to zero.
      */
-    if (real_last - real_start < qemu_host_page_size) {
+    if (real_last - real_start < host_page_size) {
         prot = 0;
         for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(a);
@@ -818,14 +818,14 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
             prot |= page_get_flags(a);
         }
         if (prot != 0) {
-            real_start += qemu_host_page_size;
+            real_start += host_page_size;
         }
 
         for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
             prot |= page_get_flags(a + 1);
         }
         if (prot != 0) {
-            real_last -= qemu_host_page_size;
+            real_last -= host_page_size;
         }
 
         if (real_last < real_start) {
-- 
2.34.1


