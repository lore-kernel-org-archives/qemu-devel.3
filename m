Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D228CA0FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRq-0001fZ-IS; Wed, 27 Aug 2025 19:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRo-0001cZ-AV
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRm-00049P-AZ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:56 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-771e4378263so349635b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336852; x=1756941652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkh6QSZcv8eWN+z+za46kqtwRfzEqAI+OgnnDkHvgxw=;
 b=ghxzpygJ613NXM4KcfJk+KdDa8FHoRF0c4VcCjc05Oul3ya1QVWT5UI1Ype/2eGtyL
 ufQ9Pb72ITu3peM765lmz0Puv6xO9XaIKRJXfJBhOLaVnHTVYa0HDymIwsCF//0fFVVw
 0AEL87IP3TYGjDmO7wh5BgeU4b2V2VQ1kCghNZG68+TDvJLTioxu4aCJjwOLcw8nkrFV
 HIjkzxcJf8V/haml1+Qf7awsuj5UmOZ+OL/gJDvzWBK/I5MsMx4VoglYYzTrzQCPhliF
 EvrCogerL3/+lejYTPwg/OLJ9ja8oQiT5XvjTfT7Do66oaThY0VM/T+Fp2LrUrgyzrUe
 EdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336852; x=1756941652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkh6QSZcv8eWN+z+za46kqtwRfzEqAI+OgnnDkHvgxw=;
 b=hqCctQyY/aIBY5mCUDp/iQspEoFRdEqMHDx7aJORiVIEKrmFbEbGNg7ArvC9eo+kKG
 9q52BOd/QsO0G+Z/QuKhSYRP3pcSiV0VQp8FR0idkQ0AAEVq+FT0ABa5dktFv0mye0nI
 UjbcK+40t4XNUweE4DU9tuQ5NTi4sLDhUJ4UJYuwJiGRA7wRCuNdomShpedk/c8RfRbn
 Dz6tt5h8DBmb8V32PoR6Ztl/b/XZO8cB+nWhZqM2orVxuAVo2w531Ah3i1xPckWVsf0+
 5JPZFQ2X/xqdex/d5p3bd9KSSVo5KDlQzn1x0190EgR9s82xj8gR9eJj4Sr7nj/7OWRH
 GOYA==
X-Gm-Message-State: AOJu0Yx0PluONGO11FDrgBfzhQXGBPNQbbj6aOpxcoIwhxXxFU0USqY8
 qPaTTl9NR6SQrVgAx7rhdADq2BB4VNiWbo3+L68sdrxsfPtWO26k310y111Xt6jaoo4d+5Pt2ZG
 z4ddg/h8=
X-Gm-Gg: ASbGncvXF37QkbGCpCkq77cX9UADKb4fuOdLfYs11fgT1ruGBOItfe3xT7ndgtD70Rq
 vQlt+Z5y/51OtaAcSZoaHvW9M0sO54ItyXFz78eoeQRu6fJHvBK6h4RWtiTQtObYpn0t+3bbBPt
 6jwddkjN0tnNPvIVZLksO2GvX1tGWlolw16wAfBq1xZDEusbSlbh9FVYvEbbKFSHorHdMmbbZkM
 wvXnRrpB3L+wQTfM7GkBd8JCfenT0IGF9qqJnVuXaw9d2WvHy4jpfsCoSpmUTKRHkYWQ5DX76FW
 84Si0I/2KE3j9MKLfbETsiY3K0NULWt4oA/WH/E0jmWBO09uPM2ce1ngwoA727w8bBTg1dcoP0n
 e51/Uwnx6p2lHYDe4q1Pen11olw==
X-Google-Smtp-Source: AGHT+IEUGb0ngIoZTXvgkhTGoF2RDSsuldUtMIlOsRnQ5H4dzmrbkCGlTg5wNhuaLiwCOMlm3plyWA==
X-Received: by 2002:a05:6a00:1ca0:b0:771:f763:4654 with SMTP id
 d2e1a72fcca58-771f7634976mr11132733b3a.18.1756336852007; 
 Wed, 27 Aug 2025 16:20:52 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/46] linux-user: Move get_elf_hwcap to sparc/elfload.c
Date: Thu, 28 Aug 2025 09:19:45 +1000
Message-ID: <20250827232023.50398-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Change the return type to abi_ulong, and pass in the cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h           |  3 ++-
 linux-user/sparc/target_elf.h |  2 ++
 linux-user/elfload.c          | 30 +-----------------------------
 linux-user/sparc/elfload.c    | 27 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 151a06f5db..2c8414e0e5 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -101,7 +101,8 @@ extern unsigned long guest_stack_size;
 /* Note that Elf32 and Elf64 use uint32_t for e_flags. */
 const char *get_elf_cpu_model(uint32_t eflags);
 
-#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM)
+#if defined(TARGET_I386) || defined(TARGET_X86_64) || defined(TARGET_ARM) \
+    || defined(TARGET_SPARC)
 abi_ulong get_elf_hwcap(CPUState *cs);
 abi_ulong get_elf_hwcap2(CPUState *cs);
 #endif
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index 7e46748d26..b7544db0a1 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,4 +8,6 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#define HAVE_ELF_HWCAP          1
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 149d1313c0..16709865f7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -565,35 +565,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 # define ELF_ARCH   EM_SPARCV9
 #endif
 
-#include "elf.h"
-
-#define ELF_HWCAP get_elf_hwcap()
-
-static uint32_t get_elf_hwcap(void)
-{
-    /* There are not many sparc32 hwcap bits -- we have all of them. */
-    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
-                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
-
-#ifdef TARGET_SPARC64
-    CPUSPARCState *env = cpu_env(thread_cpu);
-    uint32_t features = env->def.features;
-
-    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
-    /* 32x32 multiply and divide are efficient. */
-    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
-    /* We don't have an internal feature bit for this. */
-    r |= HWCAP_SPARC_POPC;
-    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
-    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
-    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
-    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
-    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
-    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
-#endif
-
-    return r;
-}
+#define ELF_HWCAP get_elf_hwcap(thread_cpu)
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
index 243e6f9b66..32ca1b05b1 100644
--- a/linux-user/sparc/elfload.c
+++ b/linux-user/sparc/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -13,3 +14,29 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "Fujitsu MB86904";
 #endif
 }
+
+abi_ulong get_elf_hwcap(CPUState *cs)
+{
+    /* There are not many sparc32 hwcap bits -- we have all of them. */
+    uint32_t r = HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR |
+                 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV;
+
+#ifdef TARGET_SPARC64
+    CPUSPARCState *env = cpu_env(cs);
+    uint32_t features = env->def.features;
+
+    r |= HWCAP_SPARC_V9 | HWCAP_SPARC_V8PLUS;
+    /* 32x32 multiply and divide are efficient. */
+    r |= HWCAP_SPARC_MUL32 | HWCAP_SPARC_DIV32;
+    /* We don't have an internal feature bit for this. */
+    r |= HWCAP_SPARC_POPC;
+    r |= features & CPU_FEATURE_FSMULD ? HWCAP_SPARC_FSMULD : 0;
+    r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
+    r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
+    r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
+    r |= features & CPU_FEATURE_IMA ? HWCAP_SPARC_IMA : 0;
+#endif
+
+    return r;
+}
-- 
2.43.0


