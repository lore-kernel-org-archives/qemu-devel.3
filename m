Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E380C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLOj-0003ve-Iu; Sat, 02 Aug 2025 19:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOC-0003Te-Fx
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:44 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOA-0001m5-KU
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:44 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1028069eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176301; x=1754781101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYvaluqlDtgvoJHgKqOV+t3sT83HKVC7hg6Wp0CeZfc=;
 b=bpe579JTNYSUFJoll7cQ6B2MhkIVlw4eCLPJ4UsBlmy1bK1WbXfrPxVVt0Gv8tcjLT
 PtyLibM1RM02TE2Asc5B+hWyFWM2iGMkL96ZjeCWlLIWjPwTSAtWUhwgBC+o7inE27bw
 BZ5FRJmyIBWRgvMkCpRpLl6O5+cAimWu9niJxe9afoWF8LLR8uUwBM0S8HqRObf/loPm
 UlgS/pAJIxgIQze6/gpdBFM0bRXy0g8qkc74a46UwXv90qvrw0RsuOKADScCdEjop0Tw
 uEHyjc/AKgMk6Hr3ubIRIh+uo327qynbqKT9+xFNFPwJiakFVqbCiGHe06M4NMXFgcku
 OXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176301; x=1754781101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYvaluqlDtgvoJHgKqOV+t3sT83HKVC7hg6Wp0CeZfc=;
 b=kmqpzmS/tZyml0FAoyPoI8Xo0xKi/prJlE+PsMtDWbzQpvXWswTv4dhusON3rUgWFa
 dtweeHrAfY/uoqFr+ucCzHD3+rX3rqvynzPceIjXcjeyDWpKoeH5MGy+Ns73hUTHR9ug
 LGjW+XWQl/vOsrYLS/eKMUwnwfIJX30kc6Q0wGT8AKxKRISr98ewgomx/q8YIJu8VaFY
 GQMLZgJVmGeg/jnBFODomXMy7ZtacS5V8rDe5GY6hwiMOl+hRO9YZFURpfZP9c5qE/EA
 j4pJaS5inXRYle3Wux3i+KV8/fbgrl76CPzhRBCoz4sFm4OaxZoGLJFdI2HDrmoiPRQM
 frEg==
X-Gm-Message-State: AOJu0YyyRUMVw3fO0i2CVvLb304GJ+G6Jtx9bRRBLMOInyQyM4QnANF5
 EMFeHEWuUL5ABUnz4t9kybBW+Guo0GioM4WprLG/0vxEsdJ0YQ/qDdyjUi69V/Y+jJIHVgjA5+D
 yIx1J8Hw=
X-Gm-Gg: ASbGncv8B8zeT3iP5d2eONBFCa8LL+MimN7NCzVjns2UoRa1qPRwOd6LXsw/23uZZXX
 mc5rPeNYuiSjVsR0gWCdix1xrx+93p2U6ABWoy2UlPin9GVqxOdujKyZExDaIxoxBEXD/9mWyVf
 wVHWha/gfgo78yinIc7UI17iss/muiFoDi04yNzDsY+ozzfm7cQC1vZpLtLmnDtUdUXJ6t3uFNQ
 KK/TBomYgm4gmz3+pRyUOpt54tOyS9JHwO2zije3ZLHFj8t70JFaGaeXBWR0pyn+bTUhDdbn4HZ
 krqZu14j2J2nNmrWrgMciOTMw74JBNOuJSp7a6p7buVRqEFNfGwJ6/HCRJBCjDjwZ/eAXESrpAE
 YoQKo5foCD+DeU+UKHYvAxVWOSau27s0wgqljPnkqSjuZBzGCyImk
X-Google-Smtp-Source: AGHT+IFaAYnlVg+LC3kfPmWqWkivlY+X9yccZ7YL4m61biRSBNPjqCwLgGS9KVGtt1td/DuJmxeJfg==
X-Received: by 2002:a4a:edc5:0:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6198f0be1e8mr2568929eaf.1.1754176301259; 
 Sat, 02 Aug 2025 16:11:41 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 59/95] linux-user: Move elf_core_copy_regs to m68k/elfload.c
Date: Sun,  3 Aug 2025 09:04:23 +1000
Message-ID: <20250802230459.412251-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h |  3 +++
 linux-user/elfload.c         | 27 ---------------------------
 linux-user/m68k/elfload.c    | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 62ff9d38d4..b721687d3e 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 
+/* See linux kernel: arch/m68k/include/asm/elf.h.  */
+#define ELF_NREG                20
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 985c3e4e80..bc1a06a651 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -434,33 +434,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_68K
 
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG 20
-
-void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
-{
-    regs[0] = tswapl(env->dregs[1]);
-    regs[1] = tswapl(env->dregs[2]);
-    regs[2] = tswapl(env->dregs[3]);
-    regs[3] = tswapl(env->dregs[4]);
-    regs[4] = tswapl(env->dregs[5]);
-    regs[5] = tswapl(env->dregs[6]);
-    regs[6] = tswapl(env->dregs[7]);
-    regs[7] = tswapl(env->aregs[0]);
-    regs[8] = tswapl(env->aregs[1]);
-    regs[9] = tswapl(env->aregs[2]);
-    regs[10] = tswapl(env->aregs[3]);
-    regs[11] = tswapl(env->aregs[4]);
-    regs[12] = tswapl(env->aregs[5]);
-    regs[13] = tswapl(env->aregs[6]);
-    regs[14] = tswapl(env->dregs[0]);
-    regs[15] = tswapl(env->aregs[7]);
-    regs[16] = tswapl(env->dregs[0]); /* FIXME: orig_d0 */
-    regs[17] = tswapl(env->sr);
-    regs[18] = tswapl(env->pc);
-    regs[19] = 0;  /* FIXME: regs->format | regs->vector */
-}
-
 #define ELF_EXEC_PAGESIZE       8192
 
 #endif
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 561ac5b3b3..d30bee477d 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -16,3 +16,27 @@ const char *get_elf_cpu_model(uint32_t eflags)
     /* Coldfire */
     return "any";
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
+{
+    regs[0] = tswapl(env->dregs[1]);
+    regs[1] = tswapl(env->dregs[2]);
+    regs[2] = tswapl(env->dregs[3]);
+    regs[3] = tswapl(env->dregs[4]);
+    regs[4] = tswapl(env->dregs[5]);
+    regs[5] = tswapl(env->dregs[6]);
+    regs[6] = tswapl(env->dregs[7]);
+    regs[7] = tswapl(env->aregs[0]);
+    regs[8] = tswapl(env->aregs[1]);
+    regs[9] = tswapl(env->aregs[2]);
+    regs[10] = tswapl(env->aregs[3]);
+    regs[11] = tswapl(env->aregs[4]);
+    regs[12] = tswapl(env->aregs[5]);
+    regs[13] = tswapl(env->aregs[6]);
+    regs[14] = tswapl(env->dregs[0]);
+    regs[15] = tswapl(env->aregs[7]);
+    regs[16] = tswapl(env->dregs[0]); /* FIXME: orig_d0 */
+    regs[17] = tswapl(env->sr);
+    regs[18] = tswapl(env->pc);
+    regs[19] = 0;  /* FIXME: regs->format | regs->vector */
+}
-- 
2.43.0


