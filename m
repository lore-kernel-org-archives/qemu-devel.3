Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92128CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbVd-00077L-GQ; Thu, 28 Aug 2025 08:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRg-0002gu-7D
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:37 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRe-0007Gb-5F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:35 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-324eb9cc40aso1588304a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382973; x=1756987773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uM+3dz9YMXnBjvCgcRPx6pacLAFy5WHpxuZMWuhu4ac=;
 b=BHDUo76d9BOlOfV621oq7/PsEOEAYpq1vJA5YdE7uNVd8I50KS3wezftbLhzbSo5XX
 JkBB30UOkldZ4EVGDrsWSWKDVTZfFBFuab//hPIPzv2qtZJhZ8CKOiBLbvr+YIf4+WBP
 l8CT/Uj+3Y7FvpMGz51LlT8N66kcxyQoPfluc/0VMR4Dv3D/GQTCJgUq5knCM9UyUBGf
 qz+/Y2L5OQR2f2fk5PILuvb4H3BmfbA64VDe7NvkSWLzmZS6CWBNz7dngTGZT8aFh/jU
 eN9E4QulzOg/M+5k+3pz7hYPG14EqldAdUaiWvEvEzMEMCBWvf6wdyQdjpynxcDlNfF/
 4NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382973; x=1756987773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uM+3dz9YMXnBjvCgcRPx6pacLAFy5WHpxuZMWuhu4ac=;
 b=CAKy6K7nW7IhCffyfCYqlkQ9QI7w/vJdlHWxgwE0lidDDaf+/OzyhjcWa49PsiYT2Y
 fOh9UhG8w2AV2h8PJrw7aOUfihZmjZcxMJ4fKo/BX+kg7W07/hVH9lWvuDFQ5BPHWwu3
 55x0jwL6d+DdquSgNv7OiY7qAwTubUZpxtCpxE44nasDovJS8vzl/QI0qkZZX4Dka4B6
 RS5kM7QQ4VilWTsiJkVY+G8WXxUTbb9501LFwmGH1VgqpAfPb0AyutMEU9Wh6+g/nyS8
 pvREVOt8vHRHUnBzoOFMXVSzgb2UTxgOQc5WUB8+C897b9h85MK0/jYtxwKQD4K85t24
 cP3Q==
X-Gm-Message-State: AOJu0YxokiaQoCw4vV8xGqJnWojQv3QhIFKdtO/haLqb2geRIE4RnMPE
 HlxSIVsBd8I/2u8arvViOFnlboN1Li5OrajYJhBsZAzEJ2zBdSGctzFHzW5rdxZhk3fKszYUAuF
 laZzXE00=
X-Gm-Gg: ASbGncvajK8xLZ0hAr4vrU0ia7PqTo++se1ErxYZJXuDMBYKr/LEKx9HB9nEJ1sDlG0
 MtF7UboJhY06NwTmsJGFi6iAPYXwYKbkYh+X/hEXsPjNEz+vlxlTdfdSz6SWkzlLT3qI2PBn2Qf
 DVzI6x+MPPauztqabgrG/SlszEcS+RkZgxjzZr43cln+xCQ1x4pbm5HWjW3su48OlyG2kfjdYp2
 lXV0TXy39M4utp6ZDrjPDpaDZUzt45ltR7rC2IZT1pr3bQ6w5Rkll3vLel+uh0WzoUPZkaLJ2EL
 i6M+Mn2R/qOiETvK7xpoxGzCH9CvhvIhsEtJL8/buF5Lo/owl2++Tg5OT+anpPpxynejxhYsCdM
 nr1UEfPnEwg4iugsnj0esfcazVo0Vl4fPpN3N
X-Google-Smtp-Source: AGHT+IEwj5n8NqHLR6BDrzaHAYciujj5+2CJ9CQs7p3DYGLJdEh72k9eRl8SfpQhnE0T7OpJkm4RXA==
X-Received: by 2002:a17:90b:5246:b0:321:82a0:fe50 with SMTP id
 98e67ed59e1d1-3275085dabemr11216792a91.5.1756382972643; 
 Thu, 28 Aug 2025 05:09:32 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 21/87] linux-user: Move elf_core_copy_regs to
 loongarch64/elfload.c
Date: Thu, 28 Aug 2025 22:07:30 +1000
Message-ID: <20250828120836.195358-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 linux-user/loongarch64/target_elf.h |  9 +++++++++
 linux-user/elfload.c                | 25 -------------------------
 linux-user/loongarch64/elfload.c    | 21 +++++++++++++++++++++
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/linux-user/loongarch64/target_elf.h b/linux-user/loongarch64/target_elf.h
index eb17927325..90bca4499d 100644
--- a/linux-user/loongarch64/target_elf.h
+++ b/linux-user/loongarch64/target_elf.h
@@ -8,5 +8,14 @@
 
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_PLATFORM       1
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/loongarch/include/asm/elf.h */
+#define ELF_NREG                45
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d1d0a112fb..4acd7b9ffe 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -383,31 +383,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define VDSO_HEADER "vdso.c.inc"
 
-/* See linux kernel: arch/loongarch/include/asm/elf.h */
-#define ELF_NREG 45
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-enum {
-    TARGET_EF_R0 = 0,
-    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
-    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
-};
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
-{
-    r->regs[TARGET_EF_R0] = 0;
-
-    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
-    }
-
-    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
 #endif /* TARGET_LOONGARCH64 */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
index 911352840f..832890de10 100644
--- a/linux-user/loongarch64/elfload.c
+++ b/linux-user/loongarch64/elfload.c
@@ -3,6 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -61,3 +62,23 @@ const char *get_elf_platform(CPUState *cs)
 {
     return "loongarch";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+enum {
+    TARGET_EF_R0 = 0,
+    TARGET_EF_CSR_ERA = TARGET_EF_R0 + 33,
+    TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
+};
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
+{
+    r->regs[TARGET_EF_R0] = 0;
+
+    for (int i = 1; i < ARRAY_SIZE(env->gpr); i++) {
+        r->regs[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+    }
+
+    r->regs[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
+    r->regs[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+}
-- 
2.43.0


