Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243B8C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kva-0001o1-3i; Wed, 23 Apr 2025 20:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktl-00068s-Hl
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktj-0005A4-Pc
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so433188b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456221; x=1746061021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Swy+toUntFPIZLsZyS/sq5veF2DhYECVz3JKVwtsdjA=;
 b=tSePn71AqO0CTVR/BkJ7U/9s1x3IV+3l4A5E110FtIFIk5I8Vnz86rF32cnhWu5Q+W
 edl9UxPz8R8xcx3jLraaGcpgMDvsYiVmHJ3xzgAeVJ8lQAMLoXyuaPZkDqBcYp+Uf/fu
 opoL/ijX+q7uz/qRp5OA6VfK7+Zyr1zHR1ZB7BKl3VBYcHl+w9nickm4/le1eWB3wZSt
 PqHTB6zqijyYbIJo2EVUwuvNJ26S3AV1pf6ntTeF+12+SFVoypMZ+4Rfx7RTvODeu2lw
 5XeqIpt0q+nol022CLf8rHhZOqOgjLeSejGXXNNQ7izaT09cgwcvrOxGkd0TuOPFg9jv
 idew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456221; x=1746061021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Swy+toUntFPIZLsZyS/sq5veF2DhYECVz3JKVwtsdjA=;
 b=GJbJDefnyQ14YoP7g0mnlPyQfBTHPlFm3eBnJBMx1nrdXtmeHWUqRcewoEiQ2ss6EO
 mk27v18vmW/c0V6aBzPS8NFXn6z4D6SOwHOXJhM8x6+fqnXikVhb0CR83T4Fr82TQGic
 /ZJEV09ZRnbwqWg24gtVa3joZJAGSWnkNiLM3BGiOmv36e4huwe4pvMBpJKYQtfUAeNM
 2CRPN5yeLBd7ElSjbHQaxXwL9KHoNkMTGV5Wk3b2zVdGwfP6Lx/7wdcFDojQI036g94F
 BMxkeDsQfJUzPdaVhG7uc2jIOaXcxtYSljuLqJMOU/DUXFWj0bdTL0AI1f+SPmvnx9m0
 f4Eg==
X-Gm-Message-State: AOJu0YwtdIEBut6sRz7Zr68mdvRtrweKdRoxe+/rG9GpkfgbZJdlo39b
 bj6aZIHVZdaU+7oKIt0pWB54/Mq/KDCb2zmFazXpcqhJwFlHpDodl6xwa0DsCIMVMcvDQrvhuJM
 U
X-Gm-Gg: ASbGncsih23ajOznmCt/2sINxhhD09aRpg9DWBtys51QgKy8Axt+7Xe2wGamdq0kz42
 0X/8xyCiZf7LSaFbqBZSqq6EU2C7uuUZMWsxe0bfegb4HXQKaoTIKBpn5GcLM5Xkokr4L0Femyr
 I9rwLXXm/1enMf/D/sLkZF16+TMudnAb+9NORnsfo6RMq3UhaVHwu7yRQ0JTvVzmSMAwt3C5Ocw
 MDaLj3ir7FIfAgZYeQwVT77DAKBkzETC1UB6m8WvTiihPKJLSyzlrv79dHt5Bc1q/fljzwxXGtF
 dfLhw2oyN3ZNrNXLM2avv3SJo+69IqYBkd4fKnZVGYw2biTDB5/MqXgAalW8l16JDN859D1Ve14
 =
X-Google-Smtp-Source: AGHT+IEdgy5q+V4+onDikKQeqITx9j2ODmAy41y8SsYQfd5DAJEIckIWO35m6ffVikl+yB5OrLB0Fw==
X-Received: by 2002:a05:6a20:9f89:b0:1f5:70d8:6a98 with SMTP id
 adf61e73a8af0-20444d21018mr968697637.0.1745456220712; 
 Wed, 23 Apr 2025 17:57:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:57:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 119/148] target/arm: Expose Aarch64 helpers unconditionally
Date: Wed, 23 Apr 2025 17:49:04 -0700
Message-ID: <20250424004934.598783-120-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

At worst, for 32-bit arm binary, using these methods will
now produce a link time error, instead of a compile time one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250403235821.9909-37-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 01408e40a3..d24acdd672 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1808,7 +1808,6 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
   return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
 }
 
-#ifdef TARGET_AARCH64
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
@@ -1826,7 +1825,6 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-#endif
 
 /* Read the CONTROL register as the MRS instruction would. */
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
-- 
2.43.0


