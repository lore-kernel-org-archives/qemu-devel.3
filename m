Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C78BCD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcj-0005Rw-7D; Tue, 19 Mar 2024 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcg-0005QV-B8
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcd-0004q9-OD
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41461c256c4so9409215e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863006; x=1711467806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgNkzc9TKRqSufr7q2jowH4Mnpr7+ZnLD1X9Wx4INOA=;
 b=r+Ok3maluSmr1kXNeSb6q+w2dnmADv5ccASjV8CDE+7/CC0JR+4XYf5Wx+pJsVAp5G
 7ycRFblmI+65NJGgSyctH+3RikgJPieiGOFOMC92Rw9oUVWGha3O8RK1fuT1+MhHcuil
 6BCvp1qe6w46x3+BfR8B0KmeOQFJ/NCYDnDcqwe/jdQC1S0X4O8ilL+WDKWdSN2P1FmW
 LVDW92fCzYsfUiiU0uJ3uxS2BZNHAFzDfkwDm2/Vv4yuQBGgmWGD3QUz0WB7neve9JSl
 aTJToG/YN9JQWmXigoStSc8u8eEI5rNtdzNgpNQjpn1IeAQvPeCzOo2F1mfR0i1sDIjb
 iHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863006; x=1711467806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgNkzc9TKRqSufr7q2jowH4Mnpr7+ZnLD1X9Wx4INOA=;
 b=Opurge8Ak0aD8+MgjgPTw0T0rM8ALS2FTqeT+Ao78Nycd0DlvGPpIqfY4zNAceRa1v
 /J7gRnwc/AQESGDAknsDM+7mEWFdEx0cQOoJ1PTMMwnpR+nKqnAjItxcyjLJG7d+vPSx
 4xGZTSU88X7FJGAijVprJSRKRcwCq0O657OEn6ZjCtO/jfh/FhwRjHH20ZdVRhlQEBjz
 CU2fQqnO0Ara4J9TtdEca9Cji/OgVldPBFp+9Kg1AvJeuSGoUos0Iha6wJE78PayGqVa
 P7wPptHfJEChkw5+ne08FwUKcMTPorImyHeZZIMkaL5bAVebBp1bl6b4KS3gZ5r38IWX
 smqw==
X-Gm-Message-State: AOJu0YzU5Q905/mM1oCm2bqsCUsyylGFW1/C0MI51nRF3gxSmOb8ZPfh
 yQRShYfvrVhMHKmtjTPMFibWPnp9DN6larb6qYuBFQcltjxiNXLG6VwQpcc7NvZcsL3AvxTZwmB
 U
X-Google-Smtp-Source: AGHT+IE2A7Ne3Xv+NPuqwzhX6UCkG2MVJhIzcibLnCHb64ZEjijUDn77Dk2/i+vTzbH7t1AHT+wu1Q==
X-Received: by 2002:a05:600c:4f11:b0:414:1eb:3010 with SMTP id
 l17-20020a05600c4f1100b0041401eb3010mr2169239wmq.17.1710863006089; 
 Tue, 19 Mar 2024 08:43:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b0041408af4b34sm11116488wmo.10.2024.03.19.08.43.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 04/27] target/arm: Restrict TCG-specific declarations
Date: Tue, 19 Mar 2024 16:42:33 +0100
Message-ID: <20240319154258.71206-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/arm/internals.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dd3da211a3..087caaf2bd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -346,13 +346,13 @@ void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
+
+#ifdef CONFIG_TCG
 void arm_translate_init(void);
 
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
-
-#ifdef CONFIG_TCG
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 #endif /* CONFIG_TCG */
 
-- 
2.41.0


