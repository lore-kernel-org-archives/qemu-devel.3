Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893ADCA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbS9-0003UA-Jn; Thu, 28 Aug 2025 08:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRc-0002cS-61
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:33 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRa-0007Fj-Gq
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso707116b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382968; x=1756987768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYOR2txVRXgp+21wx6twyLM7OtlGXRFl33SFJCsnOmM=;
 b=RJFcQVWkdRZUM4v+KNRyZkFbpfb/R3QQYfQjTgRK+bnN/QMVD4Q2LKGpVHZ3QrXMqd
 KWG6B51aHPPUw4qLTbDX4RzSJkruML75xK5xChr6K9NA+T9dVo0NYcKOTojAHFTiZeGd
 DTYaZswf/RYp6R63D94kX4GG0hbfi4/Iy5NAx9PZyiKtdSqyqYKJox39vTCL6jHt9ztB
 4IldecBcy5dO2ZMfhAzNbnmaWnCCRhRzMSdubUEfp6VT4H9W2raPP7PBJYJPUGaotzqe
 p+ZBxKhFfd08nZVkKIMZ8a9ifVN13oRuXf5OOH+/zDawgXjNDx5DVUYjqYBt8e9xhFzJ
 2HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382968; x=1756987768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYOR2txVRXgp+21wx6twyLM7OtlGXRFl33SFJCsnOmM=;
 b=A6pGwETBVnXP92Hzq4DvlpTElbzDBUMCqTAzrt7jOO33eOKmfnaqf14EZLCNZ7rfDT
 2LDsgqGjA8C3ssLrGnBeBR8LmB6AdlKUc9lGk3qKfKnhwE/lybk6ij2+vblWmPAb7Nk3
 pf+IKVBqO6xpoMRpVfcB3+KMRhOWLgYfsRSwUHLY3wSoqrn5X4KGOGKMDl3osRJZhGnr
 HXlIXzhgWPvxLK5CYQkn6WCfXFQkDXtqAjwLAAhCHJ4X5XF9L2o6kjbBXFBvuWuIsKHp
 TRDCKoxrcg0QerqhH0zxfChrA/5Lnn70yU9/mtf9A0yr9evZdAFOzZDaRuA8N+7XGfel
 znjQ==
X-Gm-Message-State: AOJu0Yy6wjtzJnhpGBRUGsptAF0YYDvmTgFjii8KUGYSAbAvvpet8RKv
 m966rvT4mJc4UgSYlGCNTKqaknBOkcIjDKs09jQBH6/+jF1edNOoN1EWiG3RfKoRkTS9nAcy7BI
 WZ/8eAQw=
X-Gm-Gg: ASbGncuydSbNmwFiw6VGqZ7yOnXzaPmn8BFpZCN7UHe5JaNyVLvotfHtIkREfvh9ZJ7
 l20ckLv0vsXXmdgCe5acHht54ZKmTBPDEK23SGJrUEgAt2N0vpbqVZ1FC21LTuAfITjH7/UmDCF
 3vjLB/Ood34pMmA71BUUsmL571H16lmh8/EBBMWhC8YfeB/Ht+7yZWbzdeD/h2WRPqe4EqJATiE
 qr39DoY5vjfiwYHCJ/kWaPQNX2POc4BHDWUWTRAmRtpxyAC7DEz6Tkj8i7NEwfyEKRCq9nuYqTp
 TMq9KdoRN6IU7y0DuT4XTqz68jqrwx7nnHdQgPST92Rz+xe1NZ0IhBAlKLqe6oHhDkTiyvXBRIf
 VKYlHWAMOCNZnQt3y/WzxnKWz6Q==
X-Google-Smtp-Source: AGHT+IGFokdnb+OfB62Va6xZo3dXxGOgMTj9A/oa1QKme0DFnt24ma9LP1ranfsPCGFrakkgzmFQzA==
X-Received: by 2002:a05:6a20:3c8d:b0:243:b656:dcc9 with SMTP id
 adf61e73a8af0-243b656dd00mr945598637.55.1756382968299; 
 Thu, 28 Aug 2025 05:09:28 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 19/87] linux-user: Move elf_core_copy_regs to
 aarch64/elfload.c
Date: Thu, 28 Aug 2025 22:07:28 +1000
Message-ID: <20250828120836.195358-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  8 ++++++++
 linux-user/aarch64/elfload.c    | 12 ++++++++++++
 linux-user/elfload.c            | 15 ---------------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index dee79ce0c6..b0728a1008 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -11,5 +11,13 @@
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+#define ELF_NREG                34
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1030cb8094..00550f9fdf 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "target/arm/cpu-features.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -347,3 +348,14 @@ const char *get_elf_platform(CPUState *cs)
 {
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->xregs[i]);
+    }
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 72a291e51f..017346b82d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -291,21 +291,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_NREG    34
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(env->xregs[i]);
-    }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(pstate_read((CPUARMState *)env));
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
-- 
2.43.0


