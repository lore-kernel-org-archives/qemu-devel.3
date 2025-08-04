Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3022C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0vh-0002so-Fa; Mon, 04 Aug 2025 15:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06S-00019C-KH
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06O-0000xt-F6
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bc55f6612so4175622b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332802; x=1754937602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NhduwSVHFJtmbAuoSXf5vp/8JFTbyhJo4xB/s950yU=;
 b=R85CkHsIfEe7WmaYLpa0ImA2+MwV3vrL45Tq8Vbcfp7j82VsIp2o9h3rGnNGyz0glF
 ZMQm+dp+Qv38tOGGEZIsmb47GEohOwlGbtH3bacwKeVTDDrkn3llvaW04eHFw7UMqpGc
 U71rdnPsZClMcvf4rY2IoQ8K9X4xOxC8YVu/zTTHGM9LuaDYYNTCYif4/a8iB9jpJF/u
 PgROi4EDYt7WCKiV70K4TfX30wHus+eaoB5GJR5zSSNu103kNawSaJmSlCjljClhsu/P
 jBnb5uoBD96Brg34wqgVXfsGIYHeIxQc+dppwZQ/Zp1MZ80BtqODbabdnD7va1OmpKuZ
 XV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332802; x=1754937602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NhduwSVHFJtmbAuoSXf5vp/8JFTbyhJo4xB/s950yU=;
 b=FEjfdQ1wdLFp1ncMpt9nG1tradZcpfzP8GkFgVLH+n7BUWas09DDL96WrWbeTem1lM
 LR+SFaC4ryg3LQ/fGvVul9qCmjo2NPXoZBTkQoYl3Av/x4EXGwBP5pSUnGwJ0ec/lJPd
 ZmO1vD+mUGslE2kEdUPQdlXK8wRAAxYNf1tEMKru6W3tpq2vcdFliI8Ggh5AS3MK4K6q
 pJIkCUDcFGlOuH8aw+YoVUoDjKHcKKyTE1Miwzuq/dFqWWnJTsnOQ2mfs+jJ8LvYEaK7
 VgincjuNURptm20800Mt7W1PhR5rA4BpY7WpqDrFs1cLLnbouDtckIIz7KyycQn80yTZ
 ItbQ==
X-Gm-Message-State: AOJu0YyaC/8/kP+WHjgueUWY4x6IXkKneCkhi+L9uKuVpssNlDlPJSol
 vdTzVkFf3yNE5grU32CLXqYqsudF1fBzlcT1PJsWbdYmIuv2neb96jAZwd0rsb+LPxves8HD0tw
 rJDPn
X-Gm-Gg: ASbGncsU3C/GJrB+kfhzwt5wxh+jBrvCiKR9XtDoVqLXSVuW+JSsvyv6BV93SZE2qWl
 zGMQpSvIpfTnv7LAUSjtadROO2RhWbv9+MhURtZfQ2bse3zc66plmNYNldFq4HFD+T+773y9XfL
 xhwFmqlreTqxR9SqPL7lQcnB0GYxEkSBFuDJ/pdNQS1UxylYnySKfLhmcdtklhLGcpzrb0iIrlN
 Wk00BCPOHyYszEYejCa5CQvp+s64IfrNprD7xApSukm94u54wXMYYcYtim4f9lPRP1YqLSaOVkD
 KFQWHP8jRjNuXg0nwABuFtLzYagwUqCTbL7wzPRVnVfz2eclEUhGoT8Sc5opyY4D43YnUxt21C9
 hmn0erxLpvqOvqiFVAyI3ow==
X-Google-Smtp-Source: AGHT+IHR/w0/fpPIPn5YeSZYa0SFPle1wY8FkODkXv1KAAlL6CRmOPWbi7jWCwQqHyB6eM473Zqi6Q==
X-Received: by 2002:a05:6a00:8783:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-76c193a7057mr439497b3a.9.1754332802416; 
 Mon, 04 Aug 2025 11:40:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/12] target/{arm,
 riscv}/common-semi-target: eradicate target_ulong
Date: Mon,  4 Aug 2025 11:39:44 -0700
Message-ID: <20250804183950.3147154-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

We replace mechanically with uint64_t.
There is no semantic change, and allows us to extract a proper API from
this set of functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/common-semi-target.h   | 6 +++---
 target/riscv/common-semi-target.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 7bb442f24ca..6775a270aaa 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -12,7 +12,7 @@
 
 #include "target/arm/cpu-qom.h"
 
-static inline target_ulong common_semi_arg(CPUState *cs, int argno)
+static inline uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +23,7 @@ static inline target_ulong common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
+static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -44,7 +44,7 @@ static inline bool is_64bit_semihosting(CPUArchState *env)
     return is_a64(env);
 }
 
-static inline target_ulong common_semi_stack_bottom(CPUState *cs)
+static inline uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7e6ea8da02c..663dedfdad2 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -11,14 +11,14 @@
 #ifndef TARGET_RISCV_COMMON_SEMI_TARGET_H
 #define TARGET_RISCV_COMMON_SEMI_TARGET_H
 
-static inline target_ulong common_semi_arg(CPUState *cs, int argno)
+static inline uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
+static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -35,7 +35,7 @@ static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
     return is_64bit_semihosting(cpu_env(cs));
 }
 
-static inline target_ulong common_semi_stack_bottom(CPUState *cs)
+static inline uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-- 
2.47.2


