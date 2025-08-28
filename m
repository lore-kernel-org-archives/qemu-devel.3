Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEA7CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbTr-0005Om-2S; Thu, 28 Aug 2025 08:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRt-00033v-Ol
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRs-0007Jh-3q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so961906b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382986; x=1756987786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3VcaH/lHL+y4xRzCBDi6asdRL57brfvVUF5s/r+gDo=;
 b=udjlfGmt1BWqjLec0JfvnQs3/EvXSJWoz8ABen09bq61s1zjaCextH9XFOOZnX/DLt
 ueHHcsRyny7kE2jcW/bzSqK3P5gPLL2+ZXyub4TynGQZXfvyR9iVkCeoOq67LcW30Jgk
 C/SMGjDZwsm3jfNb4PAGaIn0Gcq8jazddBcEt5wLr4cGPUNmfDTkDwCnLPB5mpXe1O7R
 kkTxWCcyFyjjkY/AXYIlHTCtxfW2vdLoUD0Z6y473DxQ7+yt0vctmp+sucSSMGLvy7B3
 7NllIgEcQ6WFmlX+VO7rBYsx6WeK5y/JYuFRABPPYrSBYqq7KES+sSRC+9Yest7+xGL+
 Zr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382986; x=1756987786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3VcaH/lHL+y4xRzCBDi6asdRL57brfvVUF5s/r+gDo=;
 b=pZTrH0uYp7LWr54UfX795E9Hi8MoGzIS3tXmSLY07DQ5PTl/Vvfs91Gn5Z1vY5qgHn
 SJeXhei1Wy4aKOtrtozVhK/X5KPWaOlwE5G771ej2bwTUz6ds49ys2W9ot/riCngVxIx
 Q4Z+itPJvXuBzCn+QAaKjKEyG1lPeiCvFMA1bHCUjaOmSkK+pKJ2b9ASUn+bfR5ww2Vc
 O+w6D3Fl00jbiZQ8qqTriUCV9fbGV2JVu+MaU0bhwMtpNyDE0iwcYZ7g7pnHzXlxjiId
 gTeTqQPYojnH5FyQ9OXO6ZAPXXUt1Z6XBZtkEm0FYL9i7woQFalw9qZ6DGzKTWWTtu1Z
 eOUA==
X-Gm-Message-State: AOJu0YzkKji3xF4BBtHhsX6PzEf5L4AmlsaKQYEqbQhTaEfv9Lu8pOvX
 fr39G5kHHdQzDReGVTAQ9wsdiviZwQKgOgW9TT5jfmwf0i8Xyp2HUX6B6DES3W3UgiAxdtp3axI
 0TCaDZoc=
X-Gm-Gg: ASbGncu4zDUX84L505SMsdL9OA7vamK2VAGfDMtbPLCmJxgIHPmWK6KMmPDzA+KvQjE
 wi6hTEfMDcnnDUXaBsl07I9M3roR6n1LqoI1hQBpOsPvXk1H8zgEn22jU4LkRHOE+nc89zcDlOF
 JHA4QUNgRRYyU8hz1bOht1Pbsuq5AuDoh7ZiPdegVyg0NHG0gB5whMKFAmFChDEMb9W0aohGDf7
 td13ro2Ma024wbcrgXfSJtxG25NPNAmLXJlaE6RtNRH7od/vNVSO6T4Vgpk2/Tfzk9aBYHlyp0x
 FTOHZwXIpmhdjI0bTX1/QQLwH72B0MBbJ7Rwcw3R42FnnwLsfzkZs8ZTJlmINOFeRwymhiDBAUA
 drlh6P5Ba0MrhMLRBXrKHPaTwxQ==
X-Google-Smtp-Source: AGHT+IHE4X+KMfE1FGK76KkRY/kj7vEr2KdbblpMOQCZQaOFUqanosh/9kYxLzi7bnB0V9LE/E/zaA==
X-Received: by 2002:a05:6a20:2589:b0:243:15b9:7797 with SMTP id
 adf61e73a8af0-24340eb5753mr36366831637.59.1756382986081; 
 Thu, 28 Aug 2025 05:09:46 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 27/87] linux-user: Move elf_core_copy_regs to
 s390x/elfload.c
Date: Thu, 28 Aug 2025 22:07:36 +1000
Message-ID: <20250828120836.195358-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 linux-user/s390x/target_elf.h |  9 +++++++++
 linux-user/elfload.c          | 32 --------------------------------
 linux-user/s390x/elfload.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index cebace949a..b7d863ee66 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -9,5 +9,14 @@
 #define S390X_TARGET_ELF_H
 
 #define HAVE_ELF_HWCAP          1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
+#define ELF_NREG                27
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e92c424faf..7c783b74d4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -461,38 +461,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
-#define ELF_NREG 27
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-enum {
-    TARGET_REG_PSWM = 0,
-    TARGET_REG_PSWA = 1,
-    TARGET_REG_GPRS = 2,
-    TARGET_REG_ARS = 18,
-    TARGET_REG_ORIG_R2 = 26,
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
-{
-    int i;
-    uint32_t *aregs;
-
-    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
-    for (i = 0; i < 16; i++) {
-        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
-    }
-    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
-    for (i = 0; i < 16; i++) {
-        aregs[i] = tswap32(env->aregs[i]);
-    }
-    r->regs[TARGET_REG_ORIG_R2] = 0;
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
 
 #define VDSO_HEADER "vdso.c.inc"
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
index 79ceaba51d..4113273b72 100644
--- a/linux-user/s390x/elfload.c
+++ b/linux-user/s390x/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -66,3 +67,30 @@ const char *elf_hwcap_str(uint32_t bit)
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+enum {
+    TARGET_REG_PSWM = 0,
+    TARGET_REG_PSWA = 1,
+    TARGET_REG_GPRS = 2,
+    TARGET_REG_ARS = 18,
+    TARGET_REG_ORIG_R2 = 26,
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
+{
+    int i;
+    uint32_t *aregs;
+
+    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
+    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
+    for (i = 0; i < 16; i++) {
+        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+    }
+    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
+    for (i = 0; i < 16; i++) {
+        aregs[i] = tswap32(env->aregs[i]);
+    }
+    r->regs[TARGET_REG_ORIG_R2] = 0;
+}
-- 
2.43.0


