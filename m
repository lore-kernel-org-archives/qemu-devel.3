Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3CC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLKA-00070k-7E; Sat, 02 Aug 2025 19:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLK6-0006kC-FH
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:30 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLK5-0001FL-0Y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:07:30 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6197886a6eeso1441626eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176048; x=1754780848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUBD8oIvbmmAV90/hCSe5xxGHDkQPpbW/W14D5nKNic=;
 b=n/WA8PUvkn/LiYoeezG0SyUohc4FOOzAMC7wUDvv6FEgf9qoLbcSiQkEWqXWar27qq
 VHsh4vtza6Yg0+T80jWeuVfAgp34cms+3ob4BUF2FZfSCWmviEQ+4Vro66usFq37QmkV
 Ud0s3waSchIa+cMulSXP/SMc7h9MGmiaFkNC8XMu6BSXWKfNHqzQVLtXfE30hkyycjk9
 n0DtoP84XUZ6VxhI8iILCUONMfbJ3OiLTmDZda/ZNKolzxLSc1bHKCZaioQRck13NjYj
 r4fEMUbgcxmwu/zBM44xGP9MblU3C99nZw9d+wUxOcXL40H285D9TRWTHCW0dbmO629y
 0ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176048; x=1754780848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUBD8oIvbmmAV90/hCSe5xxGHDkQPpbW/W14D5nKNic=;
 b=Mfq4ollo0szS6tnqSMw1IOna/pocTHqtDHJBnLFnQP/MwlQtl8cECeD67d66brnnkb
 pXAZZkYsQYGjR6/wBX3F6xo1k3/oEHu2Ko4kapz82xaeQusVONhiSEVCIDvyA0dIZNbk
 FF7x6+9wVRl47Io99lTyRY0Yqc5qhI/fZ1xBLRDDWjX8undW7v2mL5ETt3ZdP/iMlMoG
 Uw7fBNBIytqylnxPHaPvtTGEb+2VGpZkpHWNA4WskzTWabsE2dLXiRkc/KW7qafyfunw
 TNU75y6H2ueiLbrHASdanQjh4svHaGKKTyYfe/E9GikR3kP3ZTXZhai+M4sv4H+PfI1q
 p91g==
X-Gm-Message-State: AOJu0YxmMu6L4Jsz7weC36FSDo0vvcNmyuTqA90mA4bOt/MYW8ABgZ45
 7wGwzqQJwO5WJv6d16q7+Bgq4a32GI9ZW9LyR1hJZrT3RBDoxFCAbnraqPfK75PKju4IBiVGKqa
 Kr79qlro=
X-Gm-Gg: ASbGncvFBWvY3PVcwuDDvkrwf18PM8QSRoryw8ivpFSmXY64Wg8s6JRIAYBWWICe93N
 JHDa92N9UWy81I+ONIaCedF+w1d77tWoNy0amx9oCW8YE7PQ6eqkMLRXxbwBP34YyNBUvDpSF7h
 w8VB6kCkjBgxPKQIgrOONeZi3w8Fc9zC30iWvhFldimIw7ZTNXZziDnI7hlHBDNs58K4q6YLbpc
 bxcsvlWC5AUDtryw3blfgCL4F6OTFPwhIt1zHK2zVFoKkiuNHLyi38VhuA7fjmMVObVJTqlP4iD
 ZEKhauDPUd4k0ZDBdMNH59Qt4JPUVCsZcGuCMrpNPmL898RYJ16uX6XEibb932vYwTe/z3dwoEn
 N2I+SeVqfgmBNhtszW2ja+jg9Qb8tdiFm2J1L8DJiVRmbNmUuanqu
X-Google-Smtp-Source: AGHT+IFjs8FRDPv4z5x0C5Qnuo+ij+6Ka7SvL5rCdB5IWNHQAPd89rgQKbUMNVPtrXDICkxBVU0BoQ==
X-Received: by 2002:a05:6820:3088:b0:619:a34b:3e29 with SMTP id
 006d021491bc7-619a34b438fmr724192eaf.1.1754176047850; 
 Sat, 02 Aug 2025 16:07:27 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:07:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 39/95] linux-user/s390x: Create init_main_thread
Date: Sun,  3 Aug 2025 09:04:03 +1000
Message-ID: <20250802230459.412251-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c        |  9 +--------
 linux-user/s390x/cpu_loop.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a7de852d4d..16aa09214e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -798,14 +798,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
-static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
-{
-    regs->psw.addr = infop->entry;
-    regs->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT | \
-                     PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 | \
-                     PSW_MASK_32;
-    regs->gprs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index c9124444ed..49e44548f8 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -180,12 +180,13 @@ void cpu_loop(CPUS390XState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-    for (i = 0; i < 16; i++) {
-        env->regs[i] = regs->gprs[i];
-    }
-    env->psw.mask = regs->psw.mask;
-    env->psw.addr = regs->psw.addr;
+    CPUArchState *env = cpu_env(cs);
+
+    env->psw.addr = info->entry;
+    env->psw.mask = PSW_MASK_DAT | PSW_MASK_IO | PSW_MASK_EXT |
+                    PSW_MASK_MCHECK | PSW_MASK_PSTATE | PSW_MASK_64 |
+                    PSW_MASK_32;
+    env->regs[15] = info->start_stack;
 }
-- 
2.43.0


