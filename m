Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A69C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXSp-0002mC-RT; Fri, 07 Mar 2025 08:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSo-0002lD-3V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqXSm-0001Ly-8q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:10:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so20623015e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741353002; x=1741957802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yfyfv3HDb0p+J1qRUgpzig7LH5Vl2xWLWoUhxNEl80M=;
 b=iR0ewxhOfczaTEaRT028Zvu6/7YoiXlNxZn+U1MnuS+oeOVQyoiTUmpPVSEAAZ0M1o
 3Vo3ImQcVTJGJXC87EZCZQhKAGj+2Nqbzo0JWSIIVyM1V7tPQ4eZwSe0coGrAliFJEYv
 in48AidUCbHOsd8WQkPrPcYYNg6bB45rygNRfPWMHnyDSENgErn9KxldLI7F5dwyRksN
 bBpYUlLK+O5QJ+pjky62ogKPrjets7kBo3xlzBUFIarjCQKMCfhGM4u+QbRtfOJerFD+
 MaEW7Tbc6cUBmMGdXYdWYaQstD6ezPe3OQZHnkg2uvrt+7CLq5T5hByZGvAwxnXcMVzl
 E38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741353002; x=1741957802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yfyfv3HDb0p+J1qRUgpzig7LH5Vl2xWLWoUhxNEl80M=;
 b=QCFALHOidJdG3OtVff+aUlfvKTBQQ/ZAMxoHNUf9WPOJP08VsXf2APRnQMaM8o+iGB
 W0pek7Mf4spWJwM8shHnBUA0AiEuExrQMq/Rv3hb+sRs14wc5YyXoAoDld/Nco4zPlLz
 Qod4wtoToTZ/++G60650u1SvEZmVrX3nLvfB/qjWdrTdaUsMIltqH23Ce2Apg/jOfOId
 grpt44JY9GIhkg2/BEaU0TvxjdL9LxyQ4lRYLBXlaBMQxe3qmhinXLxZ7PaxWd1P0CZf
 tRbTAhybCTeC6MjiszJ17IwHGXGMyhokdqC2dnTzZtVAs/QLKihs9v9SiKOaVeBOWWAm
 T0Ig==
X-Gm-Message-State: AOJu0YxRmnxczWe8INx4JT+3p9/Xbmg2JhCZvmwSBKxrRgDCk5ef5eSl
 3QvEPs5j1cYEV3z128C5K1gxLTl9yoXS7XYIhM4DjyYjBspXDeLAq6QobnaO1IQXA0AOmZWxHDQ
 uNEA=
X-Gm-Gg: ASbGncsJ4Fq4tSlNleiKcsIXPVQEaughT4HYdvalJrS38RGsvnfsll2yMDPh24mK/06
 YP/A8s1dGR/eYx9BsDsuI8qdLdcyb8kxD1hHXS+yhMCNMg3uSDeGIOAEmYrLar+T5LLzYPaXl/N
 K8Ce9QCLHNXy6geVC+jB3uWCgJY2zRdH9YrQPTN50d6CoCQX65dJZ4ibO95dj6jZzhZjN8kaXE0
 6xMsIFsuCDZzmrXf9H9JoxEGkK8rU2UhyoQgjFkxbSNWXO/SGwe1w7a/ZHZ/KXyZBWBN1cwZIUH
 ZxZN62QE57iw5aKGM5cf9CKduRNAV88tRY34aj+tMAjWL2Yt6zm1OEKjp0Jlz+3YfzrewHIyg8g
 TlXU5OXn8rJeIwdzln2I=
X-Google-Smtp-Source: AGHT+IGLXTVTYWdrNw/NR2jjfwIyjXLaWAqG6mHrnleniZVaXadrd5X8ajDkthne3WsZ0wYdDHLLXA==
X-Received: by 2002:a05:600c:4ed1:b0:439:9b80:ca6f with SMTP id
 5b1f17b1804b1-43c5a630248mr37335545e9.5.1741353002264; 
 Fri, 07 Mar 2025 05:10:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm80351355e9.36.2025.03.07.05.10.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 05:10:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
Date: Fri,  7 Mar 2025 14:09:50 +0100
Message-ID: <20250307130951.4816-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307130951.4816-1-philmd@linaro.org>
References: <20250307130951.4816-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Propagate the alignment to mmap_find_vma(), effectively
embedding mmap_find_vma_aligned() within mmap_find_vma().

Since we ignore the alignment in do_bsd_shmat(), leave a
FIXME comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/bsd-mem.h |  2 +-
 bsd-user/qemu.h    |  2 +-
 bsd-user/mmap.c    | 10 ++--------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f5ec0de24ca..87219da2919 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -372,7 +372,7 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         } else {
             abi_ulong mmap_start;
 
-            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+            mmap_start = mmap_find_vma(0, shm_info.shm_segsz, 0 /* FIXME??? */);
 
             if (mmap_start == -1) {
                 return -TARGET_ENOMEM;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4e97c796318..0b3bd65b180 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -242,7 +242,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
 void mmap_reserve(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
 void TSA_NO_TSA mmap_fork_end(int child);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 28d7e387a20..da22fcc7c41 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -275,8 +275,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
  * It must be called with mmap_lock() held.
  * Return -1 if error.
  */
-static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
-                                       abi_ulong alignment)
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment)
 {
     void *ptr, *prev;
     abi_ulong addr;
@@ -395,11 +394,6 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
     }
 }
 
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
-{
-    return mmap_find_vma_aligned(start, size, 0);
-}
-
 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset)
@@ -496,7 +490,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         if ((flags & MAP_ALIGNMENT_MASK) != 0) {
             alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
         }
-        start = mmap_find_vma_aligned(real_start, host_len, alignment);
+        start = mmap_find_vma(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


