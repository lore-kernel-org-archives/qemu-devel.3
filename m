Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76434C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByc-0006Xh-PM; Fri, 01 Mar 2024 18:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByJ-0005kc-F4
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:21 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByH-0004P4-FL
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dba177c596so18019145ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334435; x=1709939235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=B1eiqbP6pDd9G29r5L8rr75Dl/dpLhfHlvQblYbHHgLqMa46UrkL5/1012J5DmHG7B
 Ei6bzb3QTwcyNxBTVSHDtuREMjsRc0V0KJf6l+l235P4zOwdJxaSMX+TMRuDd4GR4lH1
 FV/5q2jksOLvB/Qt30Oz4foEfD/HgW81CcUElMN6fRznuH32Q5OCvP4Lt5igA+Y71zhA
 IRim9lDR7p6/FWsA+32kPWx7TFstl4SV30JLc+KCeA9Zxc52RqeM6MMx01jtcpxFDQR6
 Ruyo+IU2SaikYVXneqRrIdlpvIsI5zvj1eCNtgT8lvVRyJDB3f6WQGlHfmFmSHujezNy
 N++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334435; x=1709939235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=a6FIeUPtN/Usl0irXwW8+CMYK5jBGTERVlj25N+RXIWmXQZtvx1jwLpaEpBvcOnDH7
 SoMOMrVVPI1SPg2NgtEnvH7zZX8GQYPubpnSg7sahOKGDuGkQJkNR11+KoWlnVhOOhbu
 8W0DX9G5ucCAlb5bwQXr2fCFLxr2RqR+ZGE2Xsi0eXCpmwLtB35perM0fm21+aEMJ0ZK
 gabQQfdfxyKid+ECG09X2cU4PQBD6F1zG2UlDLJrB1UIdnNzPK8goa1rLXEYVGwhN3Q3
 DD5ahFGVJGaVWO85O/ngQ6H4TlSEMH0y5fZMKQqiz5/gGeEykBK9OWPgx5HfgMEGJ854
 0rSg==
X-Gm-Message-State: AOJu0Yzsn8aKmiAH7dNYJLNtcGNHYJXfsl7NsBAh70+PmKJUmEQ1A7mj
 53kWx2QxHXqYySuiDvihnvqHc1Zt9x1IwbzYV4p6Unnw1nrhsq9T7WuaPXmCoym2c3//xaQeH+5
 F
X-Google-Smtp-Source: AGHT+IECEYzLis19kF/2sy5xqXL4PrAE6mmrgTNivuXFwMpZjH//KVgetOnUQDSFaYbIO9evcjm7LQ==
X-Received: by 2002:a17:902:da81:b0:1dc:cdd7:a056 with SMTP id
 j1-20020a170902da8100b001dccdd7a056mr4755978plx.0.1709334435733; 
 Fri, 01 Mar 2024 15:07:15 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 37/60] linux-user: Split out mmap_end
Date: Fri,  1 Mar 2024 13:05:56 -1000
Message-Id: <20240301230619.661008-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
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


