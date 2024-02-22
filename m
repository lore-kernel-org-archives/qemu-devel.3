Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519ACC54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvL-0007dJ-US; Thu, 22 Feb 2024 15:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvJ-0007ZV-W6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvF-0002j6-C1
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so1996555ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634640; x=1709239440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=HtCZcS4rnN0CRbolkLyb4UyZcW2xUNSay+3Pi0LecdOx09YpEOA0cFus3hGwRT3R9L
 9R0d35j8/IPbr/vjQNrFNhznoTccB/5pM7l7C8lQkNDm0f0ghs8X+8KB/NCCZVlB3kac
 UHeHTfq58UFpzXXkFxJpmngPU5rvaaS3BAnUpmB+Zp7S70rdWP2BHCVBYguooSMmwv1z
 BOUZVerM+xt+EXD14EtW+4owSLgW/QStRJfqeW7DZTLh5HQa5HFRzXcPgLuvK8tRP2G+
 ropee1sRsybOxO8t/r47aaUJqfvFVKBIo9UR2UuVNALeRhCB5SMB/lVc2XRabYLHXMve
 p1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634640; x=1709239440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=xNUrLYXkcD/EAIXvVQg2LqFYniOs7PkIGlOgH8PHoknKC/9/HPw5f4AcRExbivePen
 MqgkZ3PndXhnyeV9SlMRR9bSRgshKMP3xDokYlfqlJyC61QNcCe5dvZWLw8oCrifmR6k
 JrT0fcUMuzCnCZuBaTRgLFqMEwN0eEpUt1+ObPdHSaMnAAdAirOZ0lcJlqwBVK4X8ifs
 x+vTFTqZ6SSIK2L4C4e+xOvo6+N7iwpKGRcfZwBWOeU68Xjfd3ZgffeWxcXd5cadL+nz
 paSpBPHCI3fDJ54Kkf84KVkjjPTt+QusYSCWNpo/pAOu1ywY4RxWrbrcDFZR7Ay0uCys
 9Z1A==
X-Gm-Message-State: AOJu0YwWsiVR142DWP0OSJ9/6fG3Wd+pBFFt4YBifDOvnETXS+AzUUv3
 3iIeSSizLrA/1+Y3M6V7wXwPkaH3/ZVewbLmHAgc9D58E/RDRjfFqCAZVKZ16NUD6B9FWg4tGdv
 k
X-Google-Smtp-Source: AGHT+IEQGIDVz2f2V1KJKPufMFaDh4njKgljOg58FS8lNAbMbimtmlEMz5vedB+yCXP1hfP5+X6qLg==
X-Received: by 2002:a17:903:1c4:b0:1dc:685d:f0e2 with SMTP id
 e4-20020a17090301c400b001dc685df0e2mr379596plh.12.1708634640167; 
 Thu, 22 Feb 2024 12:44:00 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 22/39] linux-user: Split out mmap_end
Date: Thu, 22 Feb 2024 10:43:06 -1000
Message-Id: <20240222204323.268539-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use a subroutine instead of a goto within target_mmap__locked.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-20-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 71 +++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 48fcdd4a32..cc983bedbd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,6 +490,43 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
+/*
+ * Record a successful mmap within the user-exec interval tree.
+ */
+static abi_long mmap_end(abi_ulong start, abi_ulong last,
+                         abi_ulong passthrough_start,
+                         abi_ulong passthrough_last,
+                         int flags, int page_flags)
+{
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_ANON;
+    }
+    page_flags |= PAGE_RESET;
+    if (passthrough_start > passthrough_last) {
+        page_set_flags(start, last, page_flags);
+    } else {
+        if (start < passthrough_start) {
+            page_set_flags(start, passthrough_start - 1, page_flags);
+        }
+        page_set_flags(passthrough_start, passthrough_last,
+                       page_flags | PAGE_PASSTHROUGH);
+        if (passthrough_last < last) {
+            page_set_flags(passthrough_last + 1, last, page_flags);
+        }
+    }
+    shm_region_rm_complete(start, last);
+    trace_target_mmap_complete(start);
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        FILE *f = qemu_log_trylock();
+        if (f) {
+            fprintf(f, "page layout changed following mmap\n");
+            page_dump(f);
+            qemu_log_unlock(f);
+        }
+    }
+    return start;
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -632,7 +669,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
-            goto the_end;
+            return mmap_end(start, last, -1, 0, flags, page_flags);
         }
 
         /* handle the start of the mapping */
@@ -643,7 +680,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end;
+                return mmap_end(start, last, -1, 0, flags, page_flags);
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,34 +727,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end:
-    if (flags & MAP_ANONYMOUS) {
-        page_flags |= PAGE_ANON;
-    }
-    page_flags |= PAGE_RESET;
-    if (passthrough_start > passthrough_last) {
-        page_set_flags(start, last, page_flags);
-    } else {
-        if (start < passthrough_start) {
-            page_set_flags(start, passthrough_start - 1, page_flags);
-        }
-        page_set_flags(passthrough_start, passthrough_last,
-                       page_flags | PAGE_PASSTHROUGH);
-        if (passthrough_last < last) {
-            page_set_flags(passthrough_last + 1, last, page_flags);
-        }
-    }
-    shm_region_rm_complete(start, last);
-    trace_target_mmap_complete(start);
-    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-        FILE *f = qemu_log_trylock();
-        if (f) {
-            fprintf(f, "page layout changed following mmap\n");
-            page_dump(f);
-            qemu_log_unlock(f);
-        }
-    }
-    return start;
+    return mmap_end(start, last, passthrough_start, passthrough_last,
+                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


