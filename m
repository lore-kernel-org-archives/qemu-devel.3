Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF79AC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvG-0007Rk-Ca; Thu, 22 Feb 2024 15:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvD-0007Ou-CN
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvB-0002iQ-CB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:58 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e332bc65b3so48520b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634636; x=1709239436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzBaOBmrgtVcZmBT0VJjVQXI2NhHPFgQ+IyeqJADkZ4=;
 b=SN093ug67QNHP8bcCFYrCPXZ/l/yRHqIknj2FKResxWvxRc8rTJEYQvllgknLy98ls
 K2N1cTdkJ+q5Syrmm97djyTXjFqhqWatyMomkGskVkwJ4LNt8c2iBNrJBdzMPv0+4RL2
 yqZOeFodS9NmWW9BtoWq0Zc7MOwGp+q0Ecnj5Qn8N5DGwmJ8REEQuuCU2EQjm7/zW8p3
 QCxsTqpLgVjSCRQRUr3LkMOOSFi8vcAV9PB9bL3hv3VtHAcesvbHmPiRJpFCV2qHxZF9
 +qA6HeZq73sHD6t/Pu6UIPdLzARSH+v4gbCN6p7Abf8rSI6mJFDK6nQWPgpmRw1ukVyy
 n61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634636; x=1709239436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzBaOBmrgtVcZmBT0VJjVQXI2NhHPFgQ+IyeqJADkZ4=;
 b=n0PhXjINRx5PdmO74ZhI2GJmC9rUNG47pMNTpcaw45emenW4NZNvc9aZZRc2pvcb1M
 RTAm9iqRUMOpgnP8bEMI7FxOK/vyCWL0kCzqq5VnXksu0J7zg97fGV+maR1ZuZOX0FoN
 Rv2Z8az22ng6bEaLkFJvYI/IYBbgJzXQOH3uIcaiom7ZLIBftNAxBpJprrJVnEpQBqi3
 KdafwGEAMdC0Q9ExS9jLGOamoRRPbB70uirSpp8y2Kbuv1foQ63OucjYsgky8wI86uJa
 ngCxT+Hr0BTTYFhI5mbFXO4WSDK8Excgi0chHYKBDOfJsjeui78qufyjsKr3/s58w69c
 erOw==
X-Gm-Message-State: AOJu0YzZSp7HPIfxpiTb7tCn8ytl63IRdHvfcJJkw5WHGyg/V23pve7O
 2eHbIEL4rFk28c7xZjFN7i5+Hr2wFjONO5TTRJ5/DcQotpXr/7B9OnPiHEwUud989v3+eAFnVha
 C
X-Google-Smtp-Source: AGHT+IFFXHN1dGBUeQt3S7WWYjUKwWy6BH4V5AYK2bSxYlWgxgRd7kty/HWVVi5v1ObsVgI1C63q5Q==
X-Received: by 2002:a05:6a20:c886:b0:1a0:73b9:85e2 with SMTP id
 hb6-20020a056a20c88600b001a073b985e2mr24059324pzb.10.1708634635881; 
 Thu, 22 Feb 2024 12:43:55 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 19/39] linux-user: Split out target_mmap__locked
Date: Thu, 22 Feb 2024 10:43:03 -1000
Message-Id: <20240222204323.268539-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

All "goto fail" may be transformed to "return -1".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-17-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 62 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index d11f758d07..b4c3cc65aa 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,9 +490,9 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
-/* NOTE: all the constants are the HOST ones */
-abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, off_t offset)
+static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
+                                    int target_prot, int flags,
+                                    int fd, off_t offset)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong ret, last, real_start, real_last, retaddr, host_len;
@@ -500,30 +500,27 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     int page_flags;
     off_t host_offset;
 
-    mmap_lock();
-    trace_target_mmap(start, len, target_prot, flags, fd, offset);
-
     if (!len) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     page_flags = validate_prot_to_pageflags(target_prot);
     if (!page_flags) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /* Also check for overflows... */
     len = TARGET_PAGE_ALIGN(len);
     if (!len) {
         errno = ENOMEM;
-        goto fail;
+        return -1;
     }
 
     if (offset & ~TARGET_PAGE_MASK) {
         errno = EINVAL;
-        goto fail;
+        return -1;
     }
 
     /*
@@ -553,7 +550,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
     }
 
@@ -574,7 +571,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         struct stat sb;
 
         if (fstat(fd, &sb) == -1) {
-            goto fail;
+            return -1;
         }
 
         /* Are we trying to create a map beyond EOF?.  */
@@ -601,7 +598,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         p = mmap(g2h_untagged(start), host_len, host_prot,
                  flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
         if (p == MAP_FAILED) {
-            goto fail;
+            return -1;
         }
         /* update start so that it points to the file position at 'offset' */
         host_start = (uintptr_t)p;
@@ -610,7 +607,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                      flags | MAP_FIXED, fd, host_offset);
             if (p == MAP_FAILED) {
                 munmap(g2h_untagged(start), host_len);
-                goto fail;
+                return -1;
             }
             host_start += offset - host_offset;
         }
@@ -621,7 +618,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     } else {
         if (start & ~TARGET_PAGE_MASK) {
             errno = EINVAL;
-            goto fail;
+            return -1;
         }
         last = start + len - 1;
         real_last = ROUND_UP(last, host_page_size) - 1;
@@ -633,14 +630,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
          */
         if (last < start || !guest_range_valid_untagged(start, len)) {
             errno = ENOMEM;
-            goto fail;
+            return -1;
         }
 
         if (flags & MAP_FIXED_NOREPLACE) {
             /* Validate that the chosen range is empty. */
             if (!page_check_range_empty(start, last)) {
                 errno = EEXIST;
-                goto fail;
+                return -1;
             }
 
             /*
@@ -671,17 +668,17 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if ((flags & MAP_TYPE) == MAP_SHARED
                 && (target_prot & PROT_WRITE)) {
                 errno = EINVAL;
-                goto fail;
+                return -1;
             }
             retaddr = target_mmap(start, len, target_prot | PROT_WRITE,
                                   (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))
                                   | MAP_PRIVATE | MAP_ANONYMOUS,
                                   -1, 0);
             if (retaddr == -1) {
-                goto fail;
+                return -1;
             }
             if (pread(fd, g2h_untagged(start), len, offset) == -1) {
-                goto fail;
+                return -1;
             }
             if (!(target_prot & PROT_WRITE)) {
                 ret = target_mprotect(start, len, target_prot);
@@ -696,14 +693,14 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                 /* one single host page */
                 if (!mmap_frag(real_start, start, last,
                                target_prot, flags, fd, offset)) {
-                    goto fail;
+                    return -1;
                 }
                 goto the_end1;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
                            target_prot, flags, fd, offset)) {
-                goto fail;
+                return -1;
             }
             real_start += host_page_size;
         }
@@ -713,7 +710,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             if (!mmap_frag(real_page, real_page, last,
                            target_prot, flags, fd,
                            offset + real_page - start)) {
-                goto fail;
+                return -1;
             }
             real_last -= host_page_size;
         }
@@ -739,7 +736,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
                     munmap(p, len1);
                     errno = EEXIST;
                 }
-                goto fail;
+                return -1;
             }
             passthrough_start = real_start;
             passthrough_last = real_last;
@@ -773,11 +770,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             qemu_log_unlock(f);
         }
     }
-    mmap_unlock();
     return start;
-fail:
+}
+
+/* NOTE: all the constants are the HOST ones */
+abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
+                     int flags, int fd, off_t offset)
+{
+    abi_long ret;
+
+    trace_target_mmap(start, len, target_prot, flags, fd, offset);
+    mmap_lock();
+
+    ret = target_mmap__locked(start, len, target_prot, flags, fd, offset);
+
     mmap_unlock();
-    return -1;
+    return ret;
 }
 
 static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
-- 
2.34.1


