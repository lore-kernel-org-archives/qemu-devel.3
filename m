Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC9CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEA-0005jy-Oi; Thu, 28 Aug 2025 13:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWr-0008PF-Ni
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:59 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWo-0008R2-5f
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7720f23123dso837919b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383292; x=1756988092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZDPXdfsmxBIOUaB++qruH/yHWhEuoUSA6jOwZM9P+A=;
 b=UxkejWnlCRQHNWBdPIYH1am0yOTVgggYcQPuIj1yeborabubyYEAUSr/RcYKN75IaI
 Q4kLnmofbDKOZd0qYPWtaKOzNykfKdfo85fl30j+Vj9KKVgXMfk9OdyomLFXzWkFtK4s
 k8/pys0hCpcVvpr3jA14kJS8ag8dgh+WHmwMG1gE1sGjrXIe/Ne0+g4KYyMs/4xb99Nh
 ku7TTqGQB8HWhJusaghLxFq2Io3O1eS+BwOAs/qlhKWC2i8QfLCS/CKOkhEvYfdtVASn
 1xDYs+2iMU9O5u3bqDh3SNZ0x69tOxbCs8HG5CAfuoKLOctGJfWniAmukIC6Y/aYseIc
 K6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383292; x=1756988092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZDPXdfsmxBIOUaB++qruH/yHWhEuoUSA6jOwZM9P+A=;
 b=MgoiGY5TZSnpBf1rfyO2c7IuXzbRE/rRxKflgea38S1NdnR6m827uCddF/jHpdcJv3
 ggDG2BlUunx6n+iBiaMMdHBRvySiZiteEnPMkbEndyzQlQuViwb4dxVSWbJNldPj5WUk
 E7pUwPXqi0+o26DfpXFjOxt0u8Ho6rVV+/bMnncp7j5qAF58k02mkFeofYPukBD/4mM2
 dEHyCJMR5kbgjDLxeST43zWDkLlVFHDwKFyfcWsIi9fO5vg/HP711R3DJE1bwrq8Bweo
 jsItFEj76QHvpAkxFJ/Jd8F5v+CGGBVFDM0fqy4aLFKaGtARiZqMIxzbSq02wDlBKcgB
 039A==
X-Gm-Message-State: AOJu0Yz73yy+q0OkwZGMxDCjdjW9053q046YnOo07esjrIjZ9hNYV/bF
 WGAh6ElVsbBlbtZXy3y4PQO4zDffQRsdfszur+py/gYLP7ojsJpVIb4Gt0KC9aPMTVgc7jIov21
 tZcrWbHI=
X-Gm-Gg: ASbGncvcSWLqFroIuIMyreWo6J4VZD4IwNFCeUF89Ojr6CH5dckYfKS32pz7rIBl3xt
 Ylgc9DboQdwQVaT5YrTL3mTf1OdnnodE46iR2MAmUVgb34jUKYPMYl6EPLu9laqGwjBVuFAvZBQ
 fp+QbS1dMNTk8tBKlfFkHPtQL0cOql3+O6kcaMuukrkfkXZY55TxHBUv1nqJlZRP3MnpvUkYM0p
 Rk+7YY0wvJsDWpyO3KXu4/Z8vTPzDs0nPww888wo7U1enaaJdg9bE9cu+zPBeBXSuoYJFN2fVLV
 5x7/H/42lq/1ZItwO7PcX0SObMU5nKIVwJLXKkqQHeK4yTHMmzdI/vxBpeaNa+yj/Rzmby3FcX8
 a1h0GV5I06UROeHutMHXoULfPiGHnQo9PaseO
X-Google-Smtp-Source: AGHT+IFgEq/lRrKD5XJahb3EGmlaKRQGJoue/3BYozyO2kbr99Z6Mz1mc074zCR6u8NPQeHW4HBPAA==
X-Received: by 2002:a17:902:e80c:b0:246:b3d4:5c82 with SMTP id
 d9443c01a7336-246b3d4620amr244281685ad.16.1756383292496; 
 Thu, 28 Aug 2025 05:14:52 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 67/87] linux-user: Move elf parameters to ppc/target_elf.h
Date: Thu, 28 Aug 2025 22:08:16 +1000
Message-ID: <20250828120836.195358-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h | 43 ++++++++++++++++++++++++++++++
 linux-user/elfload.c        | 53 -------------------------------------
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 2a61cd2896..9a47f18fb8 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,6 +10,17 @@
 
 #include "target_ptrace.h"
 
+#define ELF_MACHINE             PPC_ELF_MACHINE
+
+#ifdef TARGET_PPC64
+# define elf_check_arch(x)      ((x) == EM_PPC64)
+# define ELF_CLASS              ELFCLASS64
+#else
+# define ELF_CLASS              ELFCLASS32
+# define EXSTACK_DEFAULT        true
+#endif
+#define ELF_ARCH                EM_PPC
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_CORE_DUMP      1
@@ -26,4 +37,36 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#ifndef TARGET_PPC64
+# define VDSO_HEADER  "vdso-32.c.inc"
+#elif TARGET_BIG_ENDIAN
+# define VDSO_HEADER  "vdso-64.c.inc"
+#else
+# define VDSO_HEADER  "vdso-64le.c.inc"
+#endif
+
+/*
+ * The requirements here are:
+ * - keep the final alignment of sp (sp & 0xf)
+ * - make sure the 32-bit value at the first 16 byte aligned position of
+ *   AUXV is greater than 16 for glibc compatibility.
+ *   AT_IGNOREPPC is used for that.
+ * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
+ *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
+ */
+#define DLINFO_ARCH_ITEMS       5
+#define ARCH_DLINFO                                     \
+    do {                                                \
+        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
+        /*                                              \
+         * Handle glibc compatibility: these magic entries must \
+         * be at the lowest addresses in the final auxv.        \
+         */                                             \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
+        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
+        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
+    } while (0)
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ccdd87aa12..526c90e2c1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,59 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_PPC
-
-#define ELF_MACHINE    PPC_ELF_MACHINE
-
-#if defined(TARGET_PPC64)
-
-#define elf_check_arch(x) ( (x) == EM_PPC64 )
-
-#define ELF_CLASS       ELFCLASS64
-
-#else
-
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#endif
-
-#define ELF_ARCH        EM_PPC
-
-/*
- * The requirements here are:
- * - keep the final alignment of sp (sp & 0xf)
- * - make sure the 32-bit value at the first 16 byte aligned position of
- *   AUXV is greater than 16 for glibc compatibility.
- *   AT_IGNOREPPC is used for that.
- * - for compatibility with glibc ARCH_DLINFO must always be defined on PPC,
- *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
- */
-#define DLINFO_ARCH_ITEMS       5
-#define ARCH_DLINFO                                     \
-    do {                                                \
-        PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
-        /*                                              \
-         * Handle glibc compatibility: these magic entries must \
-         * be at the lowest addresses in the final auxv.        \
-         */                                             \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
-        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
-        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
-        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
-    } while (0)
-
-#ifndef TARGET_PPC64
-# define VDSO_HEADER  "vdso-32.c.inc"
-#elif TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-64.c.inc"
-#else
-# define VDSO_HEADER  "vdso-64le.c.inc"
-#endif
-
-#endif
-
 #ifdef TARGET_LOONGARCH64
 
 #define ELF_CLASS   ELFCLASS64
-- 
2.43.0


