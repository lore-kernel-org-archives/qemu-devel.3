Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479E3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkM-0001v4-1c; Sat, 30 Aug 2025 11:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XU-0003DG-BB
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XS-00031U-FQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7718408baf7so2550797b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506341; x=1757111141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgN2LnuzViCzcnpZUHVNvtv/OHauCjd5CrV1japv59M=;
 b=GDfNSxDCQ/+/7FyA1D+etWLiygBepxU+Ul4ue7GGEpRDNd5PkM9Ub3kf50QXjj1+lG
 i31YWp60rq3P9/t2VxRGNIR/lpeO6kMLEp366BOBhKkYKSjyZoTWQVYENuObWbI0YTTO
 VhOZKWQjE/+1r3OF/Rq6AHHJU4/fsF1gpUWU1cNtCFuGT83dYCCR78dZi9NHAuMCiOZh
 UpHEKenvJw85E7jI03/pkHk3KprTG7n/ZyGIGnkUplCeEKCNmk/IluXTOQEtTPt99/4o
 5lFZq3upes2DO9Pa/TuXtXZboEs7uMY8Gz7vg0yqQJESqj5TL/8hlTLV+4DWm8x2VKzV
 6NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506341; x=1757111141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgN2LnuzViCzcnpZUHVNvtv/OHauCjd5CrV1japv59M=;
 b=PAuC/3GHy0hyUAVAPGFZSPJkyYWoUM99F688UZ2Eu6zGH8iwITVRIXAK6bo1WQ+ztq
 TLk3nWuZKjj1x93doaOMpXCF40ypHtubYVjlhGOxbicZ0DW5XP/zpG9Dnr+zES4gIxkl
 3HQg3dKcjOgQ1kyF1qYVs89/6CRvRo3bgCPJqs5BiHheIr+5uwjtOX1EdAZpcNkeIoEs
 432pUJzJ9aDNdj0oceyQ3TYkRoGFzOv/W3Ro31XfnGzQtmB/FdErYA+ioR5+eH3uNvlR
 Ep+vU4yv76S5mm9VAnSSb3v955GdW4k4mfFsGwOsMA6i/SS1NHRYsuyyRWip1p8MxY8P
 lPEw==
X-Gm-Message-State: AOJu0YyV3UQ5uX2cbSyOOX6R2tdgUTTD8RtDS2kEEHU2t66+CSJCYsdD
 9fPCYPS6WhZgX4b7x7N7TLTq3/r+fv08NgHyhMmFSyi44i5z+BxFG4zh64b7OGYiPKxiBRazUu/
 OYar3wZY=
X-Gm-Gg: ASbGnct3gs8J+SDnhGlKQ6aCtCvuqIqCSKTwRjV4Z6SZQYPMy5Ns+kwjFUTD+vvyeFj
 RPLb0PDPlrDC7mhY4uZHUyEbhys1q7GEjA8BWxsxEfnRRgJywCi3cNDGxqIJRU0LFh08TKF9n1z
 owMz6gZAVYh3Tdlp4SARhwtQtgQXIugmtEb5EY64nb6FV0GTaXMh5+OTsCpoB7vuy5gTvbWbnzy
 KzXLXxroS2NKKuyGjTJgtlKPj/IPwARIO4n1FsiTdmFLuJjLt2L5As31uUfU4EZm3Y/nkuquULa
 ETY6pccn4Hg6mOllk6m5Qz80e9yfpBvsJbtSa+H2LGjJuR6yaJRHNBEZFwdZvyR6HxZd2zohrkP
 MXyQgVoMy8pCWIUxR2RHQU49d3tIb4SyTxZOntM/yj7n2HF3NMfmgL1QG5WlyCyb1/KHkEDY=
X-Google-Smtp-Source: AGHT+IHzOKkfQNo0hhifstjr125apHK+QovfqFJY1An2qObfiG8bFVdm0yoJ1tVicBXeQrPZNmnr8g==
X-Received: by 2002:a05:6300:210d:b0:243:aca2:e500 with SMTP id
 adf61e73a8af0-243d6f062d9mr318066637.29.1756506341001; 
 Fri, 29 Aug 2025 15:25:41 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/91] linux-user: Move elf_core_copy_regs to openrisc/elfload.c
Date: Sat, 30 Aug 2025 08:23:24 +1000
Message-ID: <20250829222427.289668-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/openrisc/target_elf.h | 10 ++++++++++
 linux-user/elfload.c             | 16 ----------------
 linux-user/openrisc/elfload.c    | 12 ++++++++++++
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index b34f2ff672..e97bdc11ed 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef OPENRISC_TARGET_ELF_H
 #define OPENRISC_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel arch/openrisc/include/asm/elf.h.  */
+#define ELF_NREG                34 /* gprs and pc, sr */
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 96ed6b6515..8c3ef41312 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -424,24 +424,8 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG 34 /* gprs and pc, sr */
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
-{
-    for (int i = 0; i < 32; i++) {
-        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
-    }
-    r->regs[32] = tswapreg(env->pc);
-    r->regs[33] = tswapreg(cpu_get_sr(env));
-}
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
index b92442dfeb..bb5ad96711 100644
--- a/linux-user/openrisc/elfload.c
+++ b/linux-user/openrisc/elfload.c
@@ -3,9 +3,21 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "loader.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
 {
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(cpu_get_gpr(env, i));
+    }
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(cpu_get_sr(env));
+}
-- 
2.43.0


