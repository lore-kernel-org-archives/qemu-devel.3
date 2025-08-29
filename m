Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F8DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkF-0001DY-GO; Sat, 30 Aug 2025 11:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XL-00039a-GM
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:35 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XJ-0002zN-8U
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:35 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2659893b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506331; x=1757111131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84/JK3DP1F/+ND6QYYiYK3M7/bjEXR8Zh3F4CzLGSok=;
 b=iSxClwJnqTuc1QEQ3KSJ5Bg+qboTK5z5Zr1svxgWTS1L2CxWRoKXPelJDraKQjduyn
 cfWsU5RM+5LMk6oh15ceMLXJQBxFujnzKNsFynXFma8G3s+KTki1jDLupDzXtGGVw3mi
 XFxqWqYeS5t4cFZlr8vPfsZvgkgaHjSS9RZQraRzJUTVjN7fy/7iq96KpU4Lr0zdm3pZ
 n7qG3xGmmMlAiyhRoWBXr4io0VG6wcr0tNsLKyDxYYFIl96kO13J4s3CPRuTi+kclaXV
 WIgJyz8VFAFXGR5FQjScA8yQu42qkFoMaxfN0tMSeYQdgSg7FB46U04qaDkiUYxvuF1i
 FdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506331; x=1757111131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84/JK3DP1F/+ND6QYYiYK3M7/bjEXR8Zh3F4CzLGSok=;
 b=L7blKPaTY0cxB1wBF5zIbDExYaj+zZoeFZLu0k2kv6KifsLaHIvJlLrrqm8L1hIq9p
 K6PbDjNLoPVRRfEpv3UpE7X5zy7jm2VXvjIWuPGl8nMOSSyGpwhb1JnOYt04zSDSnTsT
 lMAOvc2I6dNZMBPq3wxrq6qyDlI0MKlqkx2ep4mhO8A6P0DIuPpPEGi4kYi0RiF6uP+y
 9LoVvPNVMAyens0x/5PSSpc8TFlLHM1yme+GpMzxarLBnQOh95SeYLSgJFsN4I/TxEf5
 iG8q89ZxIfjSIeCttmBFriy3CFPGQ5f+6YeIbl3F9rlLuNZ71yr08eSfSYS4KHQzRHBz
 Hv/A==
X-Gm-Message-State: AOJu0YygKb3T2P7TrL5pcdZM5JG2zT3Ez2O5cuQsr3GIbZvFbz0nPSus
 MSVZ6mt4Pcg/nceQwsrv3Q5JpCb5c95F+61YL1NqYDR/ta8h2ZyM8yQWysHLHE2KVPBXu99i1L6
 HCb8dszg=
X-Gm-Gg: ASbGnct0POOm8us3t87NbAR3vxMuGwC1elSWtHTc9SWPuM+Drv+vO8cXu6BWHVRAy3r
 Mte1lKlaTC8yjYAYiwT+ewP8OelDfz4hSn0XwrLUxAczHpJh8XENQnjg5JjcVplmFFbU1YsLW8r
 i1h1cmve3Sm8Id3oZw7V8mxOZz4igi7IkPpyIFjMr79ruiqZODeQym8lipRRFyoz8h7JZU+BVnj
 E6NSO6ilbIYItuUe+F6hs3H7uKgTvwiuzAWlA4cUdqhY3xNmyb1j/kujgoq+YZnN4INA9GIi+LR
 HZ+Y8Hq+D2H2kBjzTp+FEPPt9zbRdkdNx4Ny9D8uNm3OBwxpviIzuIZ3bVy72NhMhk3VBXJkGx2
 qyxS4RQZy/XX0Lbvhhzg8Zr4bSxgOxcsnWnLeLJ/kzE318o3NLxsN/L6jPjGF
X-Google-Smtp-Source: AGHT+IHdXy8KIUP3GzO0bFfdGMPxBM3nu1cp/u8esQGz4igqaMSGdXrzBzB2iX+MWccfrUpWtqmM8w==
X-Received: by 2002:aa7:88c8:0:b0:771:f852:452e with SMTP id
 d2e1a72fcca58-7723e4033afmr223752b3a.29.1756506331374; 
 Fri, 29 Aug 2025 15:25:31 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/91] linux-user: Move elf_core_copy_regs to ppc/elfload.c
Date: Sat, 30 Aug 2025 08:23:20 +1000
Message-ID: <20250829222427.289668-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
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

Move elf_core_copy_regs to elfload.c.
Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
For now, duplicate the definitions of target_elf_greg_t and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h |  9 +++++++++
 linux-user/elfload.c        | 26 --------------------------
 linux-user/ppc/elfload.c    | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 4203a89d66..72615553ea 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,5 +10,14 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
+#define ELF_NREG                48
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 017346b82d..d1d0a112fb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -361,32 +361,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
         NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG 48
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
-{
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[i] = tswapreg(env->gpr[i]);
-    }
-
-    r->regs[32] = tswapreg(env->nip);
-    r->regs[33] = tswapreg(env->msr);
-    r->regs[35] = tswapreg(env->ctr);
-    r->regs[36] = tswapreg(env->lr);
-    r->regs[37] = tswapreg(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    r->regs[38] = tswapreg(ccr);
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
 #ifndef TARGET_PPC64
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index a214675650..114e40a358 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -129,3 +130,24 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
 
     return features;
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
+{
+    int i;
+    target_ulong ccr = 0;
+
+    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[i] = tswapreg(env->gpr[i]);
+    }
+
+    r->regs[32] = tswapreg(env->nip);
+    r->regs[33] = tswapreg(env->msr);
+    r->regs[35] = tswapreg(env->ctr);
+    r->regs[36] = tswapreg(env->lr);
+    r->regs[37] = tswapreg(cpu_read_xer(env));
+
+    ccr = ppc_get_cr(env);
+    r->regs[38] = tswapreg(ccr);
+}
-- 
2.43.0


