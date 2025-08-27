Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D03CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTI-0005ui-Vg; Wed, 27 Aug 2025 19:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT0-0004aN-B8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSy-0004M4-Gq
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-770530175b2so327515b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336925; x=1756941725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCC1Bj0ds8VpE2M603U1zvLp3zKKtAPXp9DANJJjBMA=;
 b=Rjd+MYLQku/ErnSbrf70+UUsXajDcFuvzDanlYF4dc5wLDPK/ONR+xV5HCmFGjwrlJ
 +ACDT3h4Zqh2TEgfzGpt//m1ITJNT7NrDCWybJmJ8+NoBWmOz0GlLO1eFoJISikXKvQv
 m40oQEy7YeyE4cc8xtqZuphXh6WmorAXxukMpEi51/S00Mov2s2jipoN32UUgUT2rtAT
 ejdatou3tT35b0gBUTJhc3yaCP4Qg5wAqJfyoJnJ6z0t3hlUu8VY5puhUCnjaWdTDX/+
 CCqsiMoigxJUYa3N3P4vMPBmFhZpvGd7gLPApdDFRV9LfVpc3XyGFtdtfaniYSjsgkB0
 ruQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336925; x=1756941725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HCC1Bj0ds8VpE2M603U1zvLp3zKKtAPXp9DANJJjBMA=;
 b=uyAJBszH7p8yKZJDTcKPsL4gKcAwDGHRofxoTGGG7Viv7qsKRjQS9ByDiTgj2XIfR0
 BxAlcij4vNc91KDCaTxR1pb8OM7PfrzjPHwdZtpdEkYJL96QcIrwiDq7yNbz+pDzIKam
 ERIvgsgw9jeAqmObAcZ3Lbp0RLPQZUhjeHDPMgek3eC2tFlSVahqke8VumUuVN9OlVrh
 hDE3173d602BfS8Xj4R6NDHgQ19MM1BZFdB3pTloXY7Ow2MKVdM4ssGB3XASb+nk6rao
 tPlOxu+lgwIxwwXnxytoW5npF0OUhj9kPsGKHSLamezO+iS2g24HCKk82DDqE/vQyHTQ
 P+Iw==
X-Gm-Message-State: AOJu0YyyEaFZSOhZzCxCqGOJld2DeVifRnsznH3hHMQY3a1nID1AKZqU
 HxbAz1AqlQkn3Amum/VlY44Fm5FcT/0Anw9g402/i6lXwev+XAK/yTTwhnoUn+W9vC9eqTjQrWP
 OOkdAaiM=
X-Gm-Gg: ASbGncty8eeeEMp/0uzvrsTwIGHI/uffXtZkZ8XSbMy2RKZeqd5e/+gILo3Dbpdkz8h
 k3P4AEfjkzMR0pn4GkWT7osQ+8+crH7ezZbIWg7SiyZlT3AzKWnpD7fEfKE6H1EHGoWQLayj8FZ
 dC5R1pvbg9/LHpy3WcBIspLmrWAuImBsVZZRvm4Uz2OFApIWBCAYGF0CZGLn4bbntpGCn3VBHyH
 DpcZG4uxZVIzRWt3a9wyZkJXv5Ru694fqQY18qf6ZF4LTlsgbjsdzb72KSaTH8EzI675toEAVMJ
 p5waZSZSuEOseDP3cx9aU9j1gGJQrBiXK/cXwOaUcEk9RrRbDfcGcut/CzekwSeWlpCJxH8yWDa
 05yEvr0sOsVkDLKhLtExwYdIRyA==
X-Google-Smtp-Source: AGHT+IGaw1XB4+pBnN9OP4bwkaCiNsgOWjRr44xiFt0Q8w9hUm3MgbhxNWXnSdDQfBf1SdQlK16FmQ==
X-Received: by 2002:a05:6a00:1954:b0:76e:885a:c344 with SMTP id
 d2e1a72fcca58-7702fad491bmr22429276b3a.26.1756336925456; 
 Wed, 27 Aug 2025 16:22:05 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 35/46] linux-user/openrisc: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:12 +1000
Message-ID: <20250827232023.50398-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 linux-user/elfload.c           |  7 +------
 linux-user/openrisc/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3f9ec49359..03c9539774 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -673,12 +673,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->pc = infop->entry;
-    regs->gpr[1] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 306b4f8eb4..8c72347a99 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -83,13 +83,10 @@ void cpu_loop(CPUOpenRISCState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for (i = 0; i < 32; i++) {
-        cpu_set_gpr(env, i, regs->gpr[i]);
-    }
-    env->pc = regs->pc;
-    cpu_set_sr(env, regs->sr);
+    env->pc = info->entry;
+    cpu_set_gpr(env, 1, info->start_stack);
 }
-- 
2.43.0


