Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D84FE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHrw-0000oT-0l; Mon, 30 Dec 2024 10:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHrt-0000m2-U7
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHrr-00030s-Hb
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:39:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e2880606so6884305f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735573181; x=1736177981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaU9NBmAHybeYXgq1cwe95Tsd0YH1x8KfOWowQQlRh0=;
 b=JJDnIG7Qf8JnOMZf8F7Dmiy8r91072RRdmAdp+9ITKwMwpqOHdGGpabrDL5+tHS4Hh
 FbTZpQrG/H3SpyVYEZzStDAjj0GmQjcqojy3PG44ujRSTucdxrtCeXjBeCNMqsijUKOa
 PyFJwneT4dGCy7TKt9mrQCMVwbdGT9V/2iDwl9x/P381JegVsVxqSRX/uD4oCmX8F0TI
 ivxNbBogZhtgc7O40cRWpCUTBaxi1AVM/YEwlNBbnPKF8ivjQLvoiX0y6WBGIBulVdXc
 DGo+kXiiMEPNc9wngOhcAC4dJ7Fvouj1p3Q3OGkSJIQMaBz53RDdvsewqTc/niJEeQyq
 hG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735573181; x=1736177981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zaU9NBmAHybeYXgq1cwe95Tsd0YH1x8KfOWowQQlRh0=;
 b=JTCf/H8iMTojLX0ikTfBTFOj4T8dS6JTZnxNF4J9ovTDwnCqfLMrMYvBcD3VWX/ngF
 ATOQOnKO5egSijBeOYnX84xJ1g9+0dBUCQpj+0SEoHsCcY5Fzb/ALZEd4DtupkRbGgSU
 DFsZ4zyccInbUk65RINH+dSA5Jb2MO9yiC+SC9EvdlEkoUuUzu3ouyHXJG/d8KyIs5AT
 ItUNQI1uRy3tjNc7x+//UfNa/KKJvNmqy77rnEj3F5mmzGcPk3aaT0QXrZZR/A1GoIcB
 mKieDQeUzoBD0z2v4d6SGWgmNm8ARaGlTuVddti+Qnrumceg8k2dLJ+n0Pjvd2O0+xky
 TcTQ==
X-Gm-Message-State: AOJu0YzF2EQLrhRqe7D9vOL1QuKCs54YSIE4Gl8al76B33UBvMW/tHc4
 87M53G/siceQhfn2UVsHf+moUzGVOPcBRAUw0NG/aUuQgu8J6nAhdf9iqIGRJ369OMC/2xJ1DDk
 f
X-Gm-Gg: ASbGncuEy2GL3gtPMVsr9Vyr6UN6YrHt4Db7vJlXVU991PA3qc3yEpGU9g7xAYxcuBJ
 eKUJtaW6eHtH2+CViwJwGKp3OQxoGd4BGbdlwlL4Wb64n6qr6CCbpjSLA5lv1sxgIHVuAPim1tV
 Hu5iuTkDZGu3K+smUOD+HN9G0dKXzxaGmJjm7tsxQNmlmd77WIPexboUeyugWOKVt4zn6J2YSs1
 KRHNGjTsE6Zi4phXCypyxps/9JouD5Gnq96JIwn2YSdeQ6nGhtKJ0wLU1CPnHt59Y9SUh9tmSCG
 GPOfLdKH6CSaVlGeJ3NysvP2ZjjbHXA=
X-Google-Smtp-Source: AGHT+IGgWu1NGmGBTEzKIpLY4IPz62Q5Vf2h+F/vvn+VZHXxtsB29t4Gpv2ICF+oXhUmXY4gJ78WXA==
X-Received: by 2002:a05:6000:4023:b0:385:e5dc:e285 with SMTP id
 ffacd0b85a97d-38a22406d4emr31752630f8f.58.1735573181492; 
 Mon, 30 Dec 2024 07:39:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e126sm29890799f8f.65.2024.12.30.07.39.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:39:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/cpus: Remove pointless re-assignment of
 CPUState::exception_index
Date: Mon, 30 Dec 2024 16:39:28 +0100
Message-ID: <20241230153929.87137-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230153929.87137-1-philmd@linaro.org>
References: <20241230153929.87137-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The CPUState::exception_index field is always re-initialized
by the parent CPU ResetHold() handler in cpu_common_reset_hold(),
no need to have targets manually initializing it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c      | 1 -
 target/loongarch/cpu.c | 1 -
 target/openrisc/cpu.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6e5434a8e99..9b355bfe902 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -203,7 +203,6 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     if (scc->parent_phases.hold) {
         scc->parent_phases.hold(obj, type);
     }
-    cs->exception_index = -1;
     cs->halted = 0;
     cpu_set_pc(cs, 0xf0000004);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a604704..fd062d2e3e1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -584,7 +584,6 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 #ifdef CONFIG_TCG
     restore_fp_status(env);
 #endif
-    cs->exception_index = -1;
 }
 
 static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b7bab0d7abf..84aa9448256 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -101,7 +101,6 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
     cpu->env.pc = 0x100;
     cpu->env.sr = SR_FO | SR_SM;
     cpu->env.lock_addr = -1;
-    cs->exception_index = -1;
     cpu_set_fpcsr(&cpu->env, 0);
 
     set_float_detect_tininess(float_tininess_before_rounding,
-- 
2.47.1


