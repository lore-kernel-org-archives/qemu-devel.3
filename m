Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA0FC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKg3-0006V3-Bq; Thu, 21 Mar 2024 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKg1-0006Oq-DS
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfy-0001UM-P8
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-414700cffd6so8776605e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036192; x=1711640992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ByGtnAj40FIgzzc5+9YA5mVdDA+/CNg+MM7X/H831Q=;
 b=eouEY2oGgzd5llVOOxZvaytQsD+HTpAg69ASK6D8w7e17YeBjS7YfBi15/2szVz9Gu
 vywRw+Te3UkA9J+IbhNtZaO5kMxaLvpN2ufnwQ4cspPC5r0i+3vYoXqkVy1tct8vTxlk
 XWEOFEkfGGJ5IEO+zjbeaS1g7Dn/lNJoFtWfmnq5hblBJTvsVCeIJpmX49sjIySItBRF
 UeWLmOMqSxMvsZtZn36NngJ9U3ZJFkATujAhzos83/skqcaAJOUAWazoAY87cisTVT8s
 bg+dCPeyJTOuo7rPgHLia2elJ/OfUoh4xy2X4428nlJXNg1A67ETnzmICgQVlDrg6FyW
 UgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036192; x=1711640992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ByGtnAj40FIgzzc5+9YA5mVdDA+/CNg+MM7X/H831Q=;
 b=iXTVruPlFy201zBkx2ZBLdXQ0pWM3y99H/I819yL02G12UkE8nnrUVU4sY61dj9jyR
 AuVHZSZp1VRAGkTz6nIPQNI6ZbYSwFMe+De1hHvo/SXY8tluxG/+nUjnnanxLXP3eSKh
 77SiNovsXJ+vo/m92DNSqiJ9+/rCqtLkTa5yFeyBiZJV4mk6FF/emawIjbV6ulbwCCeZ
 mxYqrL/5SzCAVWUqF87fV6WkrUsBFuiRpSFlsDqTMjWcgVp1Tjojxm24v7t4SdWleI2o
 bHuaJS1Uj1Cv9MsBEASMmA3RXQe0x4RxtxSaiv5kDQVoUveffN5wmkvmSHbNdK5aEwfg
 hQBg==
X-Gm-Message-State: AOJu0YwuxpidNh+KLXxq9LApeWwjAtnSmNvegJnpCc8UQuYTVP60NUv9
 RkigaCDObHgwMDcSasNK48vVq3u7zVnTmGKs9C0lHtSQ9xKayNUxVIvWC52kSsPM8udU/qy8YDn
 Mf9E=
X-Google-Smtp-Source: AGHT+IH/yAHOFp/p/fI7IC+W6jUuAkkKiFdF0KGxCo9t+wlbViIM7IhRlXMf1UHUz2YzS+/8U1P9pQ==
X-Received: by 2002:a05:600c:a4b:b0:414:85f:1f72 with SMTP id
 c11-20020a05600c0a4b00b00414085f1f72mr4265147wmq.6.1711036191940; 
 Thu, 21 Mar 2024 08:49:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c4ec800b0041408451874sm5958377wmq.17.2024.03.21.08.49.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH-for-9.1 09/21] target/mips: Prefix MMU API with 'mips_'
Date: Thu, 21 Mar 2024 16:48:25 +0100
Message-ID: <20240321154838.95771-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

MIPS MMU API declared in tcg-internal.h has public linkage.
In order to avoid name clashing with other targets, prefix
the API with 'mips_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/tcg-internal.h      | 2 +-
 target/mips/cpu.c                   | 2 +-
 target/mips/tcg/sysemu/tlb_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..2dc9d9100f 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -43,7 +43,7 @@ void do_raise_exception(CPUMIPSState *env,
 void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-void mmu_init(CPUMIPSState *env, const mips_def_t *def);
+void mips_mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8d8f690a53..8acf691b0b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -485,7 +485,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     env->exception_base = (int32_t)0xBFC00000;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    mmu_init(env, env->cpu_model);
+    mips_mmu_init(env, env->cpu_model);
 #endif
     fpu_init(env, env->cpu_model);
     mvp_init(env);
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 119eae771e..0167b1162f 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -464,7 +464,7 @@ static void r4k_mmu_init(CPUMIPSState *env, const mips_def_t *def)
     env->tlb->helper_tlbinvf = r4k_helper_tlbinvf;
 }
 
-void mmu_init(CPUMIPSState *env, const mips_def_t *def)
+void mips_mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
 
-- 
2.41.0


