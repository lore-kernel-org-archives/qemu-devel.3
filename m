Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4D7C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguVd-0002cD-Jl; Tue, 29 Jul 2025 20:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFo-00029Q-2p
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFm-000494-5P
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso858218b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833664; x=1754438464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1qA7VhXCQSEj2ysCTHwwEzXNPecwlWbXtt2zgXbWExA=;
 b=t5rj9zTUTJSJQ/mOhNI6vBUWaWqaOsxF9pEkDbLifWu/+WBj4Fhbgq3l0KOYlDACeU
 fHnn0LA/nT40yYdq5t/OEYCglXB1VLhw+9FTYUB21mw1Maqt5fFtd0nORbIIf4l5DChZ
 xjoyZzPlnRmIq4kr5ZwML+Kc6ka3MXKdag5WznGGRc89o0YVupEXrKSShh9O3KSV52R9
 r6zvcJIu9bTn338VPtVnYA9hBnRfMyP/qGFOWSZ+8Nlc0pzVaXK2OYx2wWgQD/PHvyaC
 xxINELWXQncoD75fR8Cu5WbPvjUuIvTtkJihHasbZ2kRAlvIvGDhGhNLXz0BhcaefeLd
 yVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833664; x=1754438464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qA7VhXCQSEj2ysCTHwwEzXNPecwlWbXtt2zgXbWExA=;
 b=po6tEuSPWX+v063z2hTfFrRcqGugP4R1WHSUtz55PONlctFcnS1++eY6EOHQcdlSNs
 tT0BJzJoqkoheyMGASi7utSwiewF4lECA4PW4/fPzJv08A/QSFvriGeJALw5eAxf1DjS
 hZCzczlyE0VI9UVxNEh8wdHnl/Jsi8Lo/pXeb8AIiWk0BunraVDuKEIYHdUDHdnLqgMd
 qlMdKRwueEDzDgeYYW4bJxU5ulhk7fxLyUm36g7HJXDHeZ0PWPeikWknIzZAN3YRCsyC
 rLRGvB0GoJxgc9+tBKGcoBCuPsARcu7f0KsRNsmcqRx169quiG7GmAZCcq9wr0ckpb3o
 dMiQ==
X-Gm-Message-State: AOJu0YyxdbG6SWF616M6J8549AuaZjNZ4WCCaFtUGnxMD9PBuGK8rBor
 YUFymvvTwekHviqVosThuWIBGwMkitPutYkgtue8XczP8Nv2BZ/6agda9v19XtgzX02OD51UhhT
 0oawp
X-Gm-Gg: ASbGncuh/ZZwWk0aOfIheEBH0zHVJ9Ok4pt5VASRdYL+bqD/BuyPsv47jh9U2FVX9WC
 AJ/XikYp0dv+zTMgVUSujPUv8lzbbxHjfGr1tEP7wjUZ2dICG75NPfQV6FG4ftC7b9Px8bDaGQj
 vJcfYcdc1EW0eyy/C3ifBextUtjqxbKKs41YSwI4e/bqmpvprTqEzHl1t4TIrXC+F2mycsKIzjJ
 YAu9XO2WwI61XeK4eODElNdDpZH3sJOgDVUl8NPYT7/Wy9wbiFHi8XFhyeZyxB791hBiqovcXR3
 DThtjXyWprbI8IkcOzza0b3Zpkjs1fhOwPS/jjKqZ3hYTygxjcpuq76EOkCy+aKEwYhaVgZlaHz
 fQPYZnjGDwnoEDDsXne3ooccai24DCW/FlIgGi7YEm/HYQT9v2YH9N9HY48YFfOakUQNs3DkH09
 xw65dJhKqn0A==
X-Google-Smtp-Source: AGHT+IHhkF4DqfoWy8+e7xJtR1+1mgymUmUubmygp+H8Avm3P6zf1SPavhJVuFWpwfX83TlQ7g6ZQQ==
X-Received: by 2002:a05:6a00:2443:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-76ab1414873mr2018191b3a.7.1753833663762; 
 Tue, 29 Jul 2025 17:01:03 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.01.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:01:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/89] linux-user/hexagon: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:12 -1000
Message-ID: <20250730000003.599084-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c          | 7 +------
 linux-user/hexagon/cpu_loop.c | 8 +++++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4a58811f4f..1276b57f0d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -960,12 +960,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS       ELFCLASS32
 #define ELF_ARCH        EM_HEXAGON
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->sepc = infop->entry;
-    regs->sp = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #endif /* TARGET_HEXAGON */
 
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index e18a0183b5..25c97edcae 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -79,9 +79,11 @@ void cpu_loop(CPUHexagonState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    env->gpr[HEX_REG_PC] = regs->sepc;
-    env->gpr[HEX_REG_SP] = regs->sp;
+    CPUArchState *env = cpu_env(cs);
+
+    env->gpr[HEX_REG_PC] = info->entry;
+    env->gpr[HEX_REG_SP] = info->start_stack;
     env->gpr[HEX_REG_USR] = 0x56000;
 }
-- 
2.43.0


