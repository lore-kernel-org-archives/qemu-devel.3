Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A250AC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVy-0003Fv-IO; Thu, 03 Apr 2025 20:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVq-0002X6-9A
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVn-0003JA-W9
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so9961735e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724938; x=1744329738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4O0pR2tKGmsZXJBTN8E6GVcoNcPDwXo/K9Vu3Mm6vQ=;
 b=DAIRqEQ+H3tPMwA8zWTDNDhciAS8U6jnQGvF+qePCWik9s5IgSWUL6M65Fva0acybY
 qpFRhXAVVYALceSt2S5nXZA+4vW1CUC9DKZtHMf7NfNc3zyq21+9dASlDTdc3dhVX9Az
 DBdQNumbkkM4crM5PpOwMeGECly6u84Ep6TuFKDTDnewjTgKpMpM1eTWIQeD6nTL3l5w
 uvJy1OdvOnV2gmgSmaELqRcpaLoJnPmzH0SWObVeGu/Vs9Ehlc2h1ujG4CnccQqiL70x
 itoO2uDf1ENxcvwA6MMEMuoEgcCSykfhOCZFOjYnnm6IwUkzrqZjUGgt2f5kn7lgn5AQ
 NbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724938; x=1744329738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4O0pR2tKGmsZXJBTN8E6GVcoNcPDwXo/K9Vu3Mm6vQ=;
 b=fgS+SEjQ41gCdbmXXXZzPs+TPaOOYFzS1GN32YuiUUvGSzyhc3mtHoZf/4wy/6UwgO
 /c8YeUKuL9orwwIaFBrgDzqNWClQdasrvyB3khuIfFgW9HDteAfVTu3qNVozr99xTcB8
 cuastGnGscECgk7u8ZGlj4PzZD+XtksCTfHY4OKha0FVUUCSqvmAWlGaTYZYAIjkXpJj
 myzwwpTimu+wefdY4yiKRZboJvJfEbxkKFCS8ta5RjujGF3Xc8sc71wJjFvwJXJ80z3W
 xN15K+25popnlr2YpPA8PzC66qnPSWNrB0AKzPdHYOsCEBfQ96QESWj3PKl8tQjZO3BS
 uw/A==
X-Gm-Message-State: AOJu0YyGjuW+s+MhG7j/L+qekEeaih5aNTikOOgKwe+XA0eXvCXmDN3l
 TkL9UJ6W8CTJQ9ufm9URn2ubJkXaBTzvyJqnQWK+OxKfoZcY67j7PPnj0m1D8LfjBZZytQo1pfb
 i
X-Gm-Gg: ASbGncuWn4dcgCxWifv3dlNgNxLz0cyhZAqaCOv1QpUwiPHsuLMgyYGMhYbZHqn/no1
 3WE3/WKHK5RMWSX05ld+DxQB54SJ8A/ZvrD31OfGcD0Jkqr4B6YaCMNWow+96mN+GESl3JmvbLG
 uZ8kLArQbYy3hCDW0uLW/OPUIAMPHUghJnG4bmnEW0+7UTQCUeMcqI4QkKz+3qb2cPYuIpAuR/4
 7+ukMVZWBTK6IopDWJ9A0Pv57sw5Ze5DODZq4afmuYBq1HOsFAA65s5bvfFDtYHXJ/InkQ2bNtO
 uaFX1YxAlJ+9lGJvlyZj1qbyOGbkU2iaAjOtrSxQbpcxbyD5A9dYvQHs1l8UNsZZ0c1YDZakHBL
 51K8gIX5EeHkF8vfW/Ws=
X-Google-Smtp-Source: AGHT+IHK6/Zw2kQ8aWc/24uMlElVG5mi3+umvz4a7iMNM6iruMQZXpBDUjf1CGlf5dxEeJXGtd5pwg==
X-Received: by 2002:a05:600c:4695:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43ed0db3646mr3944395e9.28.1743724937891; 
 Thu, 03 Apr 2025 17:02:17 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226b23sm2925910f8f.86.2025.04.03.17.02.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 36/39] target/arm: Expose Aarch64 helpers
 indistinctly
Date: Fri,  4 Apr 2025 01:58:18 +0200
Message-ID: <20250403235821.9909-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

At worst, for 32-bit arm binary, using these methods will
now produce a link time error, instead of a compile time one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 86577207b85..f9353887415 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1810,7 +1810,6 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
   return (1ULL << 31) | ((1ULL << pmu_num_counters(env)) - 1);
 }
 
-#ifdef TARGET_AARCH64
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
@@ -1828,7 +1827,6 @@ void aarch64_max_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
-#endif
 
 /* Read the CONTROL register as the MRS instruction would. */
 uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure);
-- 
2.47.1


