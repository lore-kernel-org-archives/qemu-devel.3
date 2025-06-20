Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB9C7EE2E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5v-0003nF-JK; Fri, 20 Jun 2025 18:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaH-0007nX-Js
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaF-0006Sr-BF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-453634d8609so10089925e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440681; x=1751045481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlXH1r9Eq65epKdF2wHJhzUPAP5cNjkA2y6D3lDqNss=;
 b=vdYOdtXQT3GhXLZU9B6zChZ7Ukfi3qv/hF4h2VeLIlZJ/A6JsbD+/H8d7ZmI/PIEFb
 CsG+IxWZzDILW7xDky63WDWX2pA9PLWBm+eu7CWhJ+8nSdUXLhhg1AO22UG40zTn5muZ
 wfCMwyDat3ojWZoih+q3GffKRgZ0Pr3FNmOTmSa8rdXJrm9JPdH0GoIkLBYRdnsi6IJp
 y5SivUYGARbwzf0e6MUHVATv1yx724d5tLAOGkB7duTDEZj0R5mekrNibd+C5BM0Ee9J
 lDtOJT8Ra7w5UULBQLOuL5YtNkSPjehun2PRKYpMzoGylmoNSc5htVWBuJG39Me5BGmq
 /tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440681; x=1751045481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlXH1r9Eq65epKdF2wHJhzUPAP5cNjkA2y6D3lDqNss=;
 b=PFbg9zCpDOS5KrxpppxSVvZB2GZ1HuesqwKVRqIxP7oGozTYg/V0EgQeJ+gC1i5ko1
 De3riHX+BdOeMOAkWV4wTHR54OA7CgN2lrc5mgNm1aF8sjPp5aQcfQAF2GDe8P4BqYDy
 h7vN5Vz9BEx9E0NtCUg2DR2Euo7gRGGFGnLSTwY8Ch08DQfsfmBkkFMcL/guPmI5mHuE
 omOExOFTI8Ei87LCsmPlBCpGjGzqkgwd7CH+nDbKBdpIQQSb5W/8C0YDbteb55JPEb4O
 wBta7gsRwrFEQSaNlnq6BnaLyFwWtJ5jPJXbYU7tSRN8K36dBQsy9tVTlRLlP4GfSFDm
 Zpag==
X-Gm-Message-State: AOJu0Yxb1DB44+oJkGGMMMvR9FhnkFhXWBU3XRdWbQsMAY7Qz3JqXFC2
 DXrByh8qCpSDyHpAOfpPuVKltHeAGQNcyMlX2Ia3Er8WDFhE/8IDwBqr95Ec28faifzHI1oK/85
 myMJ+CEaGHw==
X-Gm-Gg: ASbGnct0KqlUMe+2wZq42uVk6zRlCmu895eyoT/kGI7yLnNcfdEuwo6g+1ry4px+wDw
 T3wPDdlZbkLRQuys5v8WWTgz8llgXavQrreXg3nvlY2Q+CTUVYSUaANBXhRva1uvbge2rfj91Is
 60LiiNxvNpTchOmb7YnUT6uZ7JkdRjrx6w2PQtqh5UFeE4GkqYewVoaDRGjVL3IrL3bTfgmQ9L0
 tYc3CnD5PdhHAcZdDQ+NQAEbs1eJnFQv5mGR6tF+x6memIiquRB71gxViAbeG5Fl1Zh32xqMLYI
 zFU1Htz/YxKGiS5QzhJAk9of4KeF3aKYnw81pzgOL71Ms2j1iFtWH44AC/nqC5wJOx2id6zNwwb
 8d93bnPzHvUfLT+qPXC46Q1tyXerTD/JlxKrmGk+F2C7arRL7m+rBzKPG
X-Google-Smtp-Source: AGHT+IG5qZIq2ewth8k/bk1RqlnbL9NcemIQLVYcKWe7Jalvs1OnfvUKn0MO20PAoFT+8P4+Jw+Hbw==
X-Received: by 2002:a05:600c:840f:b0:453:c39:d0d0 with SMTP id
 5b1f17b1804b1-4536539c48cmr34355355e9.13.1750440681379; 
 Fri, 20 Jun 2025 10:31:21 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190b00sm2525752f8f.87.2025.06.20.10.31.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:20 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 23/42] target/arm: Implement
 SysemuCPUOps::can_accelerate() handler
Date: Fri, 20 Jun 2025 19:27:31 +0200
Message-ID: <20250620172751.94231-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

ARM hardware can only accelerate EL0 and EL1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab5fbd9b40b..1a19e5cfb45 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -149,6 +149,13 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
+
+static bool arm_cpu_can_accelerate(CPUState *cs)
+{
+    CPUARMState *env = cpu_env(cs);
+
+    return arm_current_el(env) < 2;
+}
 #endif /* !CONFIG_USER_ONLY */
 
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
@@ -2695,6 +2702,7 @@ static vaddr aarch64_untagged_addr(CPUState *cs, vaddr x)
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
     .has_work = arm_cpu_has_work,
+    .can_accelerate = arm_cpu_can_accelerate,
     .get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
-- 
2.49.0


