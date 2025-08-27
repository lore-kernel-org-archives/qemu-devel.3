Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C0CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPTG-0005bk-KR; Wed, 27 Aug 2025 19:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPT1-0004cJ-4Z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPSz-0004MX-6p
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:22:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so322363b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336928; x=1756941728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qgx7jPh2mv/gIUiwJWtq6P9AJ4NMIrU+C1ZhQ4Ea56Q=;
 b=amEG5UHPpQnxN9ImOl1J4LI/fx4LEL+gTHW0Mnz3/gP8jf1NNL3aujhvlVAjZ1RJm4
 HxwPxOV026eVjNlSVtDUFXJ3fFjCmIIUXf9TI5uQtnjNqM6nyckDrD1ZVK9xA9a7z1ny
 9Z40DZr0wYnty5RrZn9i6naT5Zt96g5e7Ds11OpWp/RezEUvOcklAoxceSqBJmLfgPmY
 0/hrjm/4DMaCFdYUYT6nfXAbdlSmlUVG2zGanZuW2ng81zPj81MTi8HHfCN3N+8kcisi
 PqVq41gmbRjOnenfePB9dSITa8JPZYRHBbIJ4HG/D2MklNvlOGhRZcBRrz9TVYcrbm6O
 Sb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336928; x=1756941728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qgx7jPh2mv/gIUiwJWtq6P9AJ4NMIrU+C1ZhQ4Ea56Q=;
 b=xJilFEgZ/xcGWQp8CAiZBSlquGn5xH1rDPMMyL05S5jwX8COoLD6jizuAplLV0YHXu
 xuVwmL0l2Bd3eeMKKGx1XO+8hPIUj+J+ztXrli0P4oyC2IELmm6aRtCUvYOZ37TRG+pk
 V7af9hSkfd0hU5dWt95SNY2Uf+roi1dJHx3nfL/XAiCazgGe7qQTUJrHpPLajmsUj3FT
 UVcWjYv0EishrHohpzwwyb8fWaEtmg9XsnAfmOxchN5/K8JRYE8BdmJWjR5IQt3o4y8y
 pn6b9dhuZXyjv4F0A+OnJQSIf7ohdN1py9WUGIddZrMBiWhynmvGkUavTVzEZx7ZEns3
 QPYQ==
X-Gm-Message-State: AOJu0Ywu98bqJyKmn698V9mEafebxa6qza0ktHoMg3pykPCl5g2jam9p
 ueSi5DZAg1OZrp78fxxREeflaSy46PWSWH/yP+eY5e6ZIRsz5qH4PdBfGSFEmDpjsNZPKtEc7hK
 DU7Ic2sE=
X-Gm-Gg: ASbGnctfxoxtIqfEgfSiuaA50rsPeQC9LIyK8RMnhItqACsYdGy/MYuYLEVDIcCWc+0
 iBgedeiglLDQR2OM4JxzUcJYeCZWHAl0VnFFgJnBLfutbZynBlkupIWQcMQ1lwSbCTFzkqM6gOE
 uy6hAZYwfplUwn8MV/j6fp7603cPO87iA6zVlmWYrah62Kfdoq+AvxArHrck0FgUMrwx7rVsdk2
 T23nUoWU5yp5R+R94rdM+QPW97Oj4FWHbrnMwoleaR+fjzPxZaxo0O/LbA8kYuh1AaPIDGUKxku
 xZT+vom2WM0+WtHYAnkU2Vq+PyM9S1TcFbbxtiOrWHqAEUrmmtpAxB0TRHA9vzQ3d2vspsMFkOq
 vBzGfrM1fTGNBlreBFtBj2NnvYQ==
X-Google-Smtp-Source: AGHT+IHD+1P4JiimYsILlZhVJMEZYs564va8n2obc7B5ihLMUOXxsq6/pbEhZLaL8bQDlxDXu5/etw==
X-Received: by 2002:a05:6a20:a104:b0:243:af34:8f80 with SMTP id
 adf61e73a8af0-243af3492d3mr116634637.33.1756336927621; 
 Wed, 27 Aug 2025 16:22:07 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:22:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 36/46] linux-user/sh4: Create init_main_thread
Date: Thu, 28 Aug 2025 09:20:13 +1000
Message-ID: <20250827232023.50398-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 linux-user/elfload.c      |  8 +-------
 linux-user/sh4/cpu_loop.c | 10 ++++------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 03c9539774..8604308a31 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -701,13 +701,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_CLASS ELFCLASS32
 #define ELF_ARCH  EM_SH
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /* Check other registers XXXXX */
-    regs->pc = infop->entry;
-    regs->regs[15] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index ee9eff3428..259ea1cc8b 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -81,12 +81,10 @@ void cpu_loop(CPUSH4State *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
+    CPUArchState *env = cpu_env(cs);
 
-    for(i = 0; i < 16; i++) {
-        env->gregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
+    env->pc = info->entry;
+    env->gregs[15] = info->start_stack;
 }
-- 
2.43.0


