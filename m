Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA4FC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByX-0006La-5x; Fri, 01 Mar 2024 18:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByF-0005fJ-LY
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:16 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByD-0004N1-RH
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:15 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso26021765ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334432; x=1709939232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48MAJNKY8itF/Uvxdy9leMjwL6Lq94BoHatvMOlA6tE=;
 b=Iuf2pmTXfNbaEDQ3d60gi7CqM53oX//yskS3tzvQm3W0qH6fIq2I4Dd8Gi5tF9lX5Z
 bh6ThCvDAGDzKRubzYvhPBid8+dwka9JDJPKvNDD5Fv677F65fvzdcpfx/W+COepGV4r
 cNjl9URJ2QJMikTScA4Phmq4B4ZnZk7PGkZSlybrZh5/yvtsPk7HdW857x8AgKnugbx6
 Cm/ahIhfkfy73qIk/JLYHl9AW5cSXS0JA4r0Sb5srI0JL30bp417236AJlZdiVeWA/5+
 0JtV7u0a30aWdes+o6HkirZoXk93+1//EjR7dOskJ+hTxneygtY+/TVki8kC65tSYg1Q
 j9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334432; x=1709939232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48MAJNKY8itF/Uvxdy9leMjwL6Lq94BoHatvMOlA6tE=;
 b=fvFgiGO3etv6ztIJ67nReTVYsIoZO93uP/ZnzEkiA1s9zgSS22PQncTncv9GEWlE8k
 hNDgB5FY19sLwPesmw1B6BxnnJ2QU0uR5FlLO1dbGfnak7A1ZH56RJR7o3fj2s50IQj5
 hJvJF+/3NI7AbSB+Vv1PJoDvjWjh8voAIaQKG0IgJ5bt9goMhyk6192WoGeip7Eqlni6
 CJUxwhoNmdbLTFzRmtbNZRIpkg7OcicVLKPu92IoTj4yM6K3jatZBfWhGn934ok0pQsd
 4BHICILQX9pAE3Xsi7iAAm2+gzaNE3NWw7jSc2V273fGdM69FzfgrUsFsVQhfT1Zxle3
 kQtA==
X-Gm-Message-State: AOJu0YzXu1e1cqwJp1/IlJ0vkYA9HxVq5lBzTK1Hn66QvqVWqUG/Tdmh
 OCd/Ui2wEIJiPBODv1QtZfpW8823BLkKysCaX/yjFAH1GsLYRWn493H1X31U1xRFLJub08MbVgS
 h
X-Google-Smtp-Source: AGHT+IGXe5RIQiKaRkK2v4FEie1dqvB6MmoWawzFTGul53D9EBsGhsE0L8xrSeuTVBagPGw+uTdWjQ==
X-Received: by 2002:a17:902:c20c:b0:1db:f389:2deb with SMTP id
 12-20020a170902c20c00b001dbf3892debmr2647282pll.17.1709334432587; 
 Fri, 01 Mar 2024 15:07:12 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 35/60] linux-user: Move some mmap checks outside the lock
Date: Fri,  1 Mar 2024 13:05:54 -1000
Message-Id: <20240301230619.661008-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Basic validation of operands does not require the lock.
Hoist them from target_mmap__locked back into target_mmap.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-18-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index b4c3cc65aa..fbaea832c5 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -491,52 +491,14 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 }
 
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
-                                    int target_prot, int flags,
+                                    int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
     abi_ulong passthrough_start = -1, passthrough_last = 0;
-    int page_flags;
     off_t host_offset;
 
-    if (!len) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    page_flags = validate_prot_to_pageflags(target_prot);
-    if (!page_flags) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /* Also check for overflows... */
-    len = TARGET_PAGE_ALIGN(len);
-    if (!len) {
-        errno = ENOMEM;
-        return -1;
-    }
-
-    if (offset & ~TARGET_PAGE_MASK) {
-        errno = EINVAL;
-        return -1;
-    }
-
-    /*
-     * If we're mapping shared memory, ensure we generate code for parallel
-     * execution and flush old translations.  This will work up to the level
-     * supported by the host -- anything that requires EXCP_ATOMIC will not
-     * be atomic with respect to an external process.
-     */
-    if (flags & MAP_SHARED) {
-        CPUState *cpu = thread_cpu;
-        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
-            cpu->tcg_cflags |= CF_PARALLEL;
-            tb_flush(cpu);
-        }
-    }
-
     real_start = start & -host_page_size;
     host_offset = offset & -host_page_size;
 
@@ -616,23 +578,9 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         passthrough_start = start;
         passthrough_last = last;
     } else {
-        if (start & ~TARGET_PAGE_MASK) {
-            errno = EINVAL;
-            return -1;
-        }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
 
-        /*
-         * Test if requested memory area fits target address space
-         * It can fail only on 64-bit host with 32-bit target.
-         * On any other target/host host mmap() handles this error correctly.
-         */
-        if (last < start || !guest_range_valid_untagged(start, len)) {
-            errno = ENOMEM;
-            return -1;
-        }
-
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
@@ -778,13 +726,64 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      int flags, int fd, off_t offset)
 {
     abi_long ret;
+    int page_flags;
 
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
+
+    if (!len) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    page_flags = validate_prot_to_pageflags(target_prot);
+    if (!page_flags) {
+        errno = EINVAL;
+        return -1;
+    }
+
+    /* Also check for overflows... */
+    len = TARGET_PAGE_ALIGN(len);
+    if (!len || len != (size_t)len) {
+        errno = ENOMEM;
+        return -1;
+    }
+
+    if (offset & ~TARGET_PAGE_MASK) {
+        errno = EINVAL;
+        return -1;
+    }
+    if (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)) {
+        if (start & ~TARGET_PAGE_MASK) {
+            errno = EINVAL;
+            return -1;
+        }
+        if (!guest_range_valid_untagged(start, len)) {
+            errno = ENOMEM;
+            return -1;
+        }
+    }
+
     mmap_lock();
 
-    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+    ret = target_mmap__locked(start, len, target_prot, flags,
+                              page_flags, fd, offset);
 
     mmap_unlock();
+
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
+        CPUState *cpu = thread_cpu;
+        if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+            cpu->tcg_cflags |= CF_PARALLEL;
+            tb_flush(cpu);
+        }
+    }
+
     return ret;
 }
 
-- 
2.34.1


