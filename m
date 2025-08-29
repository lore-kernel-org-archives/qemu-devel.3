Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EC9CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmL-0006f4-4j; Sat, 30 Aug 2025 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7br-0004rH-CI
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bp-0003vO-1M
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-772301f8ae2so956414b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506611; x=1757111411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJ5D76Lv5/JEWH6fy1PlED+PdSmiXzdOglOZPBl9O+8=;
 b=f4eK4rsYCkGXfgp+oTuvliwrJzOGy0hGkE/aRQIF4kRqaxolW/a+En9Tsulcg9qt03
 dJ+EseXCbo3pdALjLEhKd56nDBRuwSORC3iUVjL4bTRNkINg1xXmOZs/nx53aKu9FOxq
 1r8uZiBYbVlm0RSOa/gbFUX+YYqUCDrr4dJcEYJxMu5ow5eI8sVxO5aWIovarYTXtUmh
 xiGangUVAjIkbTTcpmeyhuAPMtr8yQcxkYGNYyIJuSoqOBCIz1L8tOWwA23/u0Fwa7g8
 xjtSgW1kPZW9w8Zb8+0qn+Z+N6KWaAIECpvh4efrmLP28iRXVXZ+eX3CsZamMIJwSqoa
 N8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506611; x=1757111411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJ5D76Lv5/JEWH6fy1PlED+PdSmiXzdOglOZPBl9O+8=;
 b=t0fA35PQZ9JXP3s005pqYy02cpo5OTzcHBpcx0mQOaRoc8RWQtz0D2OUbbh4Yvvd9k
 Rf5EZ4ssqAokbRohB2BQkKMOZ9XE71/yFQyKaMzX5n2O3iVUpaOAvHodLA6IVtKWCvuD
 N7kQz+xrejRx3SC17Lt/tnQe3MM5hQURBvCABdi9U6wq8AcnjS/MD3JStobSZcW5VhUO
 DCvMEn3x940B7btefj+TkHDp5jB42bPzliTj5mI1Egcuwkh8RhIdYLxX+p31Gwm2b1ia
 g6Wlk3UaLb78/e/Pv0BU864lQOQLaggDdHLEjx5M/Khsw5M3m9gQnlXkQyJ8CoRTm1Fk
 Ofxw==
X-Gm-Message-State: AOJu0YyTDNXr1Qz2AWvJYzewflgrFUJOa2nPYe+alh9Fty79jiRVaPPO
 2sONJ7/t2aVqPMLH2gMDBfBH8XB3O8eZjO4Gqqqmqel/G59+VqUC/kfzqYOyd+RnWM00ynlgBuA
 r5Rx1234=
X-Gm-Gg: ASbGncvygG3Mnfxz+d6z2xzCRTvJ1xrmuYNUNpSfVbMDD72TFrf3nxX3ttDzUdM2qWF
 6j9of9Johu/zvreuhcnhJF6w57ILbLaP2iCAC8zh/EUDTrJ3ZM+fFINrVYVCt9Q0KSRei/4Q2qI
 bequwJ0QxdD1zhBOFo4rEvKhXXQPKwCjouLfChfbmLFCETFJv6LmLkvQmL/f+fwxTPnRn11YU40
 gGqGtP55HvFQP0XxEqm24lLj4010qfCeEm36Zf74vMRSocINFArwp/2CvptF9B6PcdUwl79CD17
 ZU3Nss6w6TBb8GAiUFpi7wC/Ne0ReinWA5P86IQSryElISkhwavgLzKhVymgFmaptzT1eY82G+m
 0CZ4RT2DxAcMKX0+QQEk2HOvt3UoamdL4lsK4HeJzagSqjQ8WK079aUd8suo7voY=
X-Google-Smtp-Source: AGHT+IEpowwrHFZcLyyHfRkXbdBN2JNVx61pj1DgboF4W162iRzTXMY0pSsk/Ns09PDHNc3YZLCVuA==
X-Received: by 2002:a05:6a20:431a:b0:243:a682:9d1f with SMTP id
 adf61e73a8af0-243d6dff535mr323263637.19.1756506611116; 
 Fri, 29 Aug 2025 15:30:11 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 65/91] linux-user: Move get_vdso_image_info to arm/elfload.c
Date: Sat, 30 Aug 2025 08:24:01 +1000
Message-ID: <20250829222427.289668-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Rename from vdso_image_info to avoid a symbol clash.
Define HAVE_VDSO_IMAGE_INFO to signal the external definition exists.
Provide fallback versions for other targets.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  1 +
 linux-user/loader.h         | 12 +++++++++++
 linux-user/arm/elfload.c    | 20 ++++++++++++++++++
 linux-user/elfload.c        | 41 ++++++++-----------------------------
 4 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 5f81a43efb..19fdfa2f2c 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -14,6 +14,7 @@
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 #define HAVE_ELF_CORE_DUMP      1
+#define HAVE_VDSO_IMAGE_INFO    1
 
 #define HI_COMMPAGE             ((intptr_t)0xffff0f00u)
 
diff --git a/linux-user/loader.h b/linux-user/loader.h
index c3b8f92e23..2175dd4e0a 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -110,4 +110,16 @@ bool init_guest_commpage(void);
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
 
+typedef struct {
+    const uint8_t *image;
+    const uint32_t *relocs;
+    unsigned image_size;
+    unsigned reloc_count;
+    unsigned sigreturn_ofs;
+    unsigned rt_sigreturn_ofs;
+} VdsoImageInfo;
+
+/* Note that both Elf32_Word and Elf64_Word are uint32_t. */
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 1205687976..308ed23fcb 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -7,6 +7,7 @@
 #include "target_elf.h"
 #include "target/arm/cpu-features.h"
 #include "target_elf.h"
+#include "elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -255,3 +256,22 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
     r->pt.cpsr = tswapal(cpsr_read((CPUARMState *)env));
     r->pt.orig_r0 = tswapal(env->regs[0]); /* FIXME */
 }
+
+#if TARGET_BIG_ENDIAN
+# include "vdso-be8.c.inc"
+# include "vdso-be32.c.inc"
+#else
+# include "vdso-le.c.inc"
+#endif
+
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
+#if TARGET_BIG_ENDIAN
+    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
+            && (elf_flags & EF_ARM_BE8)
+            ? &vdso_be8_image_info
+            : &vdso_be32_image_info);
+#else
+    return &vdso_image_info;
+#endif
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 81bf05f581..aed390ebb3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -40,15 +40,6 @@
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 #endif
 
-typedef struct {
-    const uint8_t *image;
-    const uint32_t *relocs;
-    unsigned image_size;
-    unsigned reloc_count;
-    unsigned sigreturn_ofs;
-    unsigned rt_sigreturn_ofs;
-} VdsoImageInfo;
-
 #define ELF_OSABI   ELFOSABI_SYSV
 
 /* from personality.h */
@@ -191,23 +182,6 @@ typedef abi_int         target_pid_t;
 
 #define ELF_EXEC_PAGESIZE       4096
 
-#if TARGET_BIG_ENDIAN
-#include "elf.h"
-#include "vdso-be8.c.inc"
-#include "vdso-be32.c.inc"
-
-static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
-{
-    return (EF_ARM_EABI_VERSION(elf_flags) >= EF_ARM_EABI_VER4
-            && (elf_flags & EF_ARM_BE8)
-            ? &vdso_be8_image_info
-            : &vdso_be32_image_info);
-}
-#define vdso_image_info vdso_image_info
-#else
-# define VDSO_HEADER  "vdso-le.c.inc"
-#endif
-
 #else
 /* 64 bit ARM definitions */
 
@@ -1973,14 +1947,17 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     load_elf_image(filename, &src, info, &ehdr, NULL);
 }
 
-#ifndef vdso_image_info
+#ifndef HAVE_VDSO_IMAGE_INFO
+const VdsoImageInfo *get_vdso_image_info(uint32_t elf_flags)
+{
 #ifdef VDSO_HEADER
 #include VDSO_HEADER
-#define  vdso_image_info(flags)  &vdso_image_info
+    return &vdso_image_info;
 #else
-#define  vdso_image_info(flags)  NULL
-#endif /* VDSO_HEADER */
-#endif /* vdso_image_info */
+    return NULL;
+#endif
+}
+#endif /* HAVE_VDSO_IMAGE_INFO */
 
 static void load_elf_vdso(struct image_info *info, const VdsoImageInfo *vdso)
 {
@@ -2311,7 +2288,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
      * Load a vdso if available, which will amongst other things contain the
      * signal trampolines.  Otherwise, allocate a separate page for them.
      */
-    const VdsoImageInfo *vdso = vdso_image_info(info->elf_flags);
+    const VdsoImageInfo *vdso = get_vdso_image_info(info->elf_flags);
     if (vdso) {
         load_elf_vdso(&vdso_info, vdso);
         info->vdso = vdso_info.load_bias;
-- 
2.43.0


