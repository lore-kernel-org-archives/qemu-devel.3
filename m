Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252EC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4V-0000r4-4n; Fri, 20 Jun 2025 18:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcJ-00082y-Te
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcI-0006ff-2J
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so13514895e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440808; x=1751045608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9SQL4jNoEdh7B3HxMQlGzYytqro/3I9dxDIahK3Zis=;
 b=RjjSlMRj1EzsZgL45XowINjBQPQoqwh+npHslbJgXHZ7kLPFUk9wKIFMr3MRGngwNQ
 m+IcrwN/CluZy1ZnNaPZiYcgIxCml2UQqkFzSIaYxQyetKMjbJktwDT0pYTxZH6lxjMb
 jZX1kkOI1fEHLWjX8ZfpH9fIWHZpgAnyr33HgiGsg0uzX8Ja3JAsUKyQMjxqJVazbbGX
 7XnpEPzm89vj2TZDvvS4vwK4sQa3FxAMrYK/+vlhRfUhxdqEKtfgbc6IeSw5T4w7b5uC
 RTXQQD9RfXmnmv2W9kn7GFCGRhP1RNpVTAc1wlphLqJk2nM6MKyD2oxMII5E9w3YoWfe
 zldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440808; x=1751045608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9SQL4jNoEdh7B3HxMQlGzYytqro/3I9dxDIahK3Zis=;
 b=ac8MB9791Ieg/GWBySjkc3Gzpu/Q0cZPbmGghUkjTDYEW3abbkgRiEpsdOlf6tiHSr
 Mz9YMOG1hczbLxFXwn7X7wJtwiJP58rjpRE841AI0UGtT8pOO+bsVX+MynJ/0Mff/2L7
 0cDyxvWhvYEkP+BcECy3pR9CPtzdo+SrNDz3NfGFtuOSSJbT3gMBE5334cf9WTQ630Ce
 IJ23D4wYKXeSTOIuJ2sqjzUiPkEwZvusTQLLNqe4s2FzFOV1VdZQWidz+39Ke+1sQ44Q
 0wm67fq6pSH27x7XekCJA5Pk3RXVV/irgZKwl2p18ONYSsXb+uYHzAAYelifAeHXRNnQ
 Tf/w==
X-Gm-Message-State: AOJu0YzKVGOleJV6+5dv5mhI5JrC7M6cRN8cs0Dbj9Hg+EWjsjxYCGM2
 47uV3wVfeDmdjIlitr26wkuge2zIIV/WqpUm4RQeEMNwDbz+90yhM8NGWZpug7Md0coso3qa3Ao
 n+O1hRKHyUQ==
X-Gm-Gg: ASbGnctMPYD2zwTAe80gsLc7n/PFvmhmmMTIxnFsANXXMtLg+zSku3J80JH5glUyYPG
 vUK9xVc9stI9GgRLqA3f2NrkY8h+28sKqV0Cr3Baa/9JUg2KAXpD96pScWAnJeOlmICrODFEc2O
 Blurf/6FXiLig7lZ+OICyXbPRd5ij6pOhM4jSWaJteY4MoJPmrz/FTeuE8aQbJTsyZ1R9bPc1pF
 WQHjL7c603yq5oagXwtlKfe9Elfh/pDhQihyoM7BuKv90VUwP0pc473olzzNeOmhzmHADWmurwp
 PRN1zEi3x56XRDExA9z0TKHgEoQWPH2X3eykz74K/eTI+nHpzoqZGU41coTlG+vr/lWn4VSN8f1
 Zg8U6gPfioRlrOBFL1OqnJch+YRb3+C3KXcMVAumrNhaLviyquFI3BQNw
X-Google-Smtp-Source: AGHT+IEomomILrdSjX9hasuUlwmpD88LMxg68vR7HPDoZ2JaMXy+JhkSzogvBTCyGWjfkyYBftTBBg==
X-Received: by 2002:a05:6000:718:b0:3a4:eed9:755d with SMTP id
 ffacd0b85a97d-3a6d12c2a8emr3561660f8f.3.1750440807886; 
 Fri, 20 Jun 2025 10:33:27 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c0f1sm2659139f8f.53.2025.06.20.10.33.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 39/42] target/arm: Implement
 TCGCPUOps::rebuild_tb_hflags()
Date: Fri, 20 Jun 2025 19:27:47 +0200
Message-ID: <20250620172751.94231-40-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h         | 2 ++
 target/arm/cpu.c         | 1 +
 target/arm/tcg/cpu-v7m.c | 1 +
 target/arm/tcg/hflags.c  | 5 +++++
 4 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c31f69912b8..b703ec7edc9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3160,9 +3160,11 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
 
 /**
  * arm_rebuild_hflags:
+ * arm_cpu_rebuild_hflags:
  * Rebuild the cached TBFLAGS for arbitrary changed processor state.
  */
 void arm_rebuild_hflags(CPUARMState *env);
+void arm_cpu_rebuild_hflags(CPUState *cpu);
 
 /**
  * aa32_vfp_dreg:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1a19e5cfb45..32a2e6c75e1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2743,6 +2743,7 @@ static const TCGCPUOps arm_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .rebuild_tb_hflags = arm_cpu_rebuild_hflags,
     .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 8e1a083b911..fa17029c65f 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
 
     .initialize = arm_translate_init,
     .translate_code = arm_translate_code,
+    .rebuild_tb_hflags = arm_cpu_rebuild_hflags,
     .get_tb_cpu_state = arm_get_tb_cpu_state,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 1ccec63bbd4..ea1174c661c 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -453,6 +453,11 @@ void arm_rebuild_hflags(CPUARMState *env)
     env->hflags = rebuild_hflags_internal(env);
 }
 
+void arm_cpu_rebuild_hflags(CPUState *cpu)
+{
+    arm_rebuild_hflags(cpu_env(cpu));
+}
+
 /*
  * If we have triggered a EL state change we can't rely on the
  * translator having passed it to us, we need to recompute.
-- 
2.49.0


