Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E847CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNis-00050g-6O; Sat, 30 Aug 2025 11:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xc-0003GW-7K
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xa-00032z-8x
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so2837595b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506348; x=1757111148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYxqF2F6v3t7TS6Jb1MS7S2soDKim5Oxkz9J/sWMYeQ=;
 b=SoQNecr0Pb6WBxEzg90zpWxCMyca6vU7bu0slU1c3MTVvPnJKLK7PLR4irKr7GxbZf
 gtzoZKqn4qm1CfJY5i0rfocybK120TgM6PeNnIq1vjd6OJRspssGMvsYDfSwRnGIWpGt
 r+NnU/V7+5w3EyvaPBZrIi3sjcHi20YTxVrON4Qvbw4qq9sLjRMCITmQ6okeGv67DD6E
 VBC2YeYa2CgZa1xcLJWcM3q8EIXUIkHSwAdAHHM0ZRiOAZxIzQan4y9rB+bXoveVv2BX
 VsomCQHdJk4teIgqtXcpVidDB6LsA0VtLoggC7/1tqbusG5y7OEr2BaIEoF6wWrEpcG+
 zP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506348; x=1757111148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYxqF2F6v3t7TS6Jb1MS7S2soDKim5Oxkz9J/sWMYeQ=;
 b=vEp7yAYykMgxxzUxIG+odJZbC4R07ICxXl/FRfIeJLo4h6e8RBkDpwVxSX03uPNZt9
 OQxBBg10kqc886ncUReRFHP80nRiJEGdoUF0rL4zbphryVSaFzqvUIwKQElH3BY2eBaK
 F3r6ZcbQi3kHKlWYKJpBdbJhTYLAqvFMEJdaYhKu8YadtPq3l3VtsEcXr584bd2JCFnj
 vuc7kHsrPmj1ATkWI1uYCQiBMmuWGEg35srnTq5UxmYJufehqSmxhG3uTPPU2tl6uzk/
 xi4h5yPxf29OdPSQ578oezwaHY/WfPhuODTax1OT+Cwt9aRUYkIbqKztjWFpLLHP+JV9
 kuEw==
X-Gm-Message-State: AOJu0YxViACRna2pG5qAilqGFIl4xkbgNiCnmO+OupXSx3PRFBU9YG7/
 DqZ5I57zu89ZzHvTdXOI4u2dCiqxJ6ipY4pEtn3dScrQZKPeFDv974qWRmUr9zVmtbiMekjWpyA
 e6/ji8g8=
X-Gm-Gg: ASbGncvRxkCgfA9eEoC8olGAWm5jqjItcp9Ajn9vpW0Sv8BySgNQfs3MM8q8QmFLfgg
 yQKN4Wnr88ubA4wcED10gFpNHCZ5sSn3PiF7T0713pDhmdM2v/ijb5JVoa+pwX6/GpKKt99dzZy
 JGKY3fS3/KXRDTVnvcCT5+zvktC7dIiFHbf2/WvFjxAWhfK+Osd/nRZShj7NoBGozAR3EIZD7eD
 gV3xWojzUyDlNZjo/5Gd1HpfDK52KIsa/DCc7pV0W4rB9wkSvoMfzMdLW+odoGFym7ZJDVP7H8z
 yHyR9/rGi7f2vADHPUV7FtuBfbxJ7Ob4LuMtglyAXvCTTulE+lUo+jYQcfPRQmDs2GuixbeVoAk
 FJhR+rbm0hf0YXFaId9dGcGFxHC4DCfEKdOJAR+f6PA+MAMV7BDLBsCVsM7MaMlyXpTcu7mfvlj
 WQd2C3pA==
X-Google-Smtp-Source: AGHT+IFabL8BX3LTI6GMneMFc6E+Q20MxzWHGe/W45d1z5F09NJIvyXULLHfTVcJmbS7Q5zocEiHDg==
X-Received: by 2002:a05:6a20:6a08:b0:243:a467:52c7 with SMTP id
 adf61e73a8af0-243d6dc18ccmr330002637.4.1756506348202; 
 Fri, 29 Aug 2025 15:25:48 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/91] linux-user: Move elf_core_copy_regs to s390x/elfload.c
Date: Sat, 30 Aug 2025 08:23:27 +1000
Message-ID: <20250829222427.289668-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


