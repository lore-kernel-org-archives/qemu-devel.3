Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F41CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkQ-0002Ku-Ic; Sat, 30 Aug 2025 11:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Xa-0003G5-Vv
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7XY-00032U-Mp
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:50 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so2837575b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506346; x=1757111146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxM1TKQLG9007cv3kPvK0tgDNKw7VDbffsV5cWbtYRI=;
 b=y4d0RRy2BbpmIsyW7/OkgdBIOyeGA+XT6v2JLzsdRd78N9YaFF/uFICaZTnzfcrOMT
 iY73lRQCm7gRk+WD9xxVt0u3OjKqcFXcVWm9tIu/jxcPTiAH+m6nNrcCH5tX1mGxl0lR
 LBsN5pvJ/QZq3L3qQqFTtFmbsnxn6kJ2B2oiLLZvVdqJ4dITS791b5QB2Ih9Fy/NACss
 tU8DGPEOsaSDwEWS1nKGrEmbXEbmqmii2CB1vwaJt8Q9FrKVzyDkTiFl1o4GVZAOKx1s
 FSQTpKZ+i1e5LOOzgGLpwjvzHfhlpyKluNEx+rqM4KGXwv7YeJatPzuRwxzmRBRbH8Jd
 DzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506346; x=1757111146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxM1TKQLG9007cv3kPvK0tgDNKw7VDbffsV5cWbtYRI=;
 b=WL5A1iFSkZAVRHm+d9P8N75u9MGfWPzjpuOROowLLJIht/leUFTKEtZbvkepOBOO0A
 Y2HcWaRSl5oJiZsbqLgg3n3sAlC49plv9oi9Swk9jHujuFtbCuLzYW0LcwLZUYByDcEg
 F82UVYmiJXSM9dZsjts76eOEhK6zHKywcYgy1M4O/MB1Z0jaihcur6/VEXDt4qxEd1U4
 B6u1vLfqjl4iZt5eCQLcq/u5ytl/WEZsNcPtGB9PDqAoKemgOhtKKiH9KU1gsgIFSQ3K
 nBycIB7vArjv6S7FP50HosdhNuIOYBU3quZIe8E7zgwsAlcAR7BBBysND30fV6Nt5RcE
 2aAg==
X-Gm-Message-State: AOJu0YzYcf8z4BeY+lvsvwkYzbkiYxsKVb/Va5ofTC9aQJo5IPSi6Fct
 zJkHK5JVLb3LcdkXArwaYZuJUUb3USiCsGD3IgoCjjbwiqRnvxM14b/OvUf5fKRyEQbNbgF3tbt
 LgumuziU=
X-Gm-Gg: ASbGncvSKO8c3bJBIL/0f+VioAFdYEoJ4m7Kj5GuhlsWIOylIQmsAciPCVO3pP6YoMR
 ADUlsUihUoG/NMkSvpqi7TocM/WVdU+hM5+SR51rHPkCymg1VL0kOH/DFgKSHvePA9oNGyvzi8W
 UqfMH6JY7ElIsl/lpV9uTfLKSOQVUXHxbU0sIOtmROSxaoT3hdLjsKpNwHdPjnJxknsUuPpJins
 MDy5wNVhwU3bs5LwjqPd+u4f9r+GBcjNERO5GmloaXviAAHdNfecw8jEwFB9cOvxvUX9gN9QTl3
 J5SB3BLzBtztyY+A9I5CtB8b5CzP3ApUaX20IMpuwApOS11WWvddFtA8TVo/32XGIGX4czLNS+A
 MerZ8t/lLY9WR9BEOHlCN6l/U900Ay6OlW/UDlK6+4wnQNzzvyVyPbxxQl4fB5JVqtbzjgUA=
X-Google-Smtp-Source: AGHT+IG3lgJ5t2JD2VSt9zVdohPY6YwiTqj+mpq5R2UUWDSZr6LctUq3x4Xwsl+BkOL5l5qBMRFdJw==
X-Received: by 2002:a05:6a20:2585:b0:243:b31a:5945 with SMTP id
 adf61e73a8af0-243d6f7eacdmr242448637.26.1756506345870; 
 Fri, 29 Aug 2025 15:25:45 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 30/91] linux-user: Move elf_core_copy_regs to m68k/elfload.c
Date: Sat, 30 Aug 2025 08:23:26 +1000
Message-ID: <20250829222427.289668-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 linux-user/m68k/target_elf.h | 10 ++++++++++
 linux-user/elfload.c         | 31 -------------------------------
 linux-user/m68k/elfload.c    | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 62ff9d38d4..cd6908ab57 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+#define HAVE_ELF_CORE_DUMP      1
+
+typedef abi_ulong target_elf_greg_t;
+
+/* See linux kernel: arch/m68k/include/asm/elf.h.  */
+#define ELF_NREG                20
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 69532faddb..e92c424faf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -442,37 +442,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG 20
-typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
-} target_elf_gregset_t;
-
-void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
-{
-    r->regs[0] = tswapreg(env->dregs[1]);
-    r->regs[1] = tswapreg(env->dregs[2]);
-    r->regs[2] = tswapreg(env->dregs[3]);
-    r->regs[3] = tswapreg(env->dregs[4]);
-    r->regs[4] = tswapreg(env->dregs[5]);
-    r->regs[5] = tswapreg(env->dregs[6]);
-    r->regs[6] = tswapreg(env->dregs[7]);
-    r->regs[7] = tswapreg(env->aregs[0]);
-    r->regs[8] = tswapreg(env->aregs[1]);
-    r->regs[9] = tswapreg(env->aregs[2]);
-    r->regs[10] = tswapreg(env->aregs[3]);
-    r->regs[11] = tswapreg(env->aregs[4]);
-    r->regs[12] = tswapreg(env->aregs[5]);
-    r->regs[13] = tswapreg(env->aregs[6]);
-    r->regs[14] = tswapreg(env->dregs[0]);
-    r->regs[15] = tswapreg(env->aregs[7]);
-    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    r->regs[17] = tswapreg(env->sr);
-    r->regs[18] = tswapreg(env->pc);
-    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
-}
-
-#define HAVE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       8192
 
 #endif
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 561ac5b3b3..2970ff7dec 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -4,6 +4,7 @@
 #include "qemu.h"
 #include "loader.h"
 #include "elf.h"
+#include "target_elf.h"
 
 
 const char *get_elf_cpu_model(uint32_t eflags)
@@ -16,3 +17,29 @@ const char *get_elf_cpu_model(uint32_t eflags)
     /* Coldfire */
     return "any";
 }
+
+#define tswapreg(ptr)   tswapal(ptr)
+
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
+{
+    r->regs[0] = tswapreg(env->dregs[1]);
+    r->regs[1] = tswapreg(env->dregs[2]);
+    r->regs[2] = tswapreg(env->dregs[3]);
+    r->regs[3] = tswapreg(env->dregs[4]);
+    r->regs[4] = tswapreg(env->dregs[5]);
+    r->regs[5] = tswapreg(env->dregs[6]);
+    r->regs[6] = tswapreg(env->dregs[7]);
+    r->regs[7] = tswapreg(env->aregs[0]);
+    r->regs[8] = tswapreg(env->aregs[1]);
+    r->regs[9] = tswapreg(env->aregs[2]);
+    r->regs[10] = tswapreg(env->aregs[3]);
+    r->regs[11] = tswapreg(env->aregs[4]);
+    r->regs[12] = tswapreg(env->aregs[5]);
+    r->regs[13] = tswapreg(env->aregs[6]);
+    r->regs[14] = tswapreg(env->dregs[0]);
+    r->regs[15] = tswapreg(env->aregs[7]);
+    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
+    r->regs[17] = tswapreg(env->sr);
+    r->regs[18] = tswapreg(env->pc);
+    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
+}
-- 
2.43.0


