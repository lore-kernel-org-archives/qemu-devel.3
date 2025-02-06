Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6867C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1fc-0005gZ-CC; Thu, 06 Feb 2025 08:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fZ-0005UE-O5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fY-0008Bc-0D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:11:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436341f575fso9966805e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847505; x=1739452305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVKpviLMTY/xpsQ4Un5x7Zpm8oUwtOVraYJxurTn7aE=;
 b=O/rH5PaKAAxRes30yKUK3bnXR3DoMWE8Fo9RdQlNKIpYPCyvm9GDEhrRWkWGICB0ed
 FvuxO/0BhhkUlYkmXmJKwNmS0mJ/p5sIHywpAMlW3EkRbk1Cm8TKhKdb5zag/e8NaGif
 SXPV2An6t9kBT0inlhC/5RCt2SAZOFS8rmdPJ7owJpb/m8RK9d8a9bh2n7Ejw4+MRsfY
 dYTX1c4g+nRal+qFRqzBwsjRV3MZSfJB20w1+KjK58DVnDAXENKLi3J+g8n1zK6a61rP
 9EUXyj4IKwwkZ7TezI56sReIct/Cda30PQJI6DFwcQczPUCeySmy8SMdbdr7hC4eVzkr
 VlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847505; x=1739452305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVKpviLMTY/xpsQ4Un5x7Zpm8oUwtOVraYJxurTn7aE=;
 b=hUT5PRn5uvTokdJRK4oP1xlqLTg0FHJrppgEaWaVEFEff5mYEj0SvcRDkqhLCnb5xk
 srw0UjD+pI+Ddwlmc5dYiVi6LbSp1z+x1ij39JYdHF4pvzppH0a5Ijq8+/H/7hMQevRt
 vV2rxp7oxYk1aGWeAPISCvRL4w94q+vIJ4adLMyb9tYDZMaeYcQ6X6RJDhZTgVoQ4+z0
 zaxDu0ytfQ9s3WWZsg/V9V6UtsZ9TqoRC38JCyITQn84FPrmOVfVL+q+TGpquCJNKvmW
 xM10izsyQL/xqfODLWhblAFuG9WF07x8264UioSAl7uvrdSL0QHmwMws/UJ8WXGijzJS
 dnnA==
X-Gm-Message-State: AOJu0YwA4KwmH8OiBYUNbZqc5ClGrl7KGWzdfjFRk1MeBf/snQOw58g1
 PDhow4GPNKwm8R9NfjfXJxYBcy0gJ5RVUu/0bCYd2LP0U+SQfWkHqSiJUsSdj7sT0Oum7cmbINm
 bCE0=
X-Gm-Gg: ASbGnctT+/MaNlGT72xkothtaN6Cant+pYMb3hRjrkcyEwedm+4WncPWUATBMe/1k9+
 fC4ONtojiaz9SyWYS51KwcZ5p9hcAUlskOhUvbXwABiD2WFXrbRDhW34LGol/q3qed1mDmHBHIQ
 ju5svhxz2otGxfVzgOjjOXkhjmhzvZ4+Y8VIGv2bZ5Yb2qDr8tYsFXVSoEaUzKtdojZAPj38sQD
 BMfZTxctH0GAHOUlfLFQ4vc6S+af60TfLtrlz9/u6jJt3AbywS3B3JOJljIxGqCAu5r7K4+Da20
 yFK4xyLCdcvzushK6TvIR3uhYM9NydBZfAkwUhJn10EWilFUmsxZnjIT/0TUSAO1Ew==
X-Google-Smtp-Source: AGHT+IEm4GB0Jr03Paz21Ocek5BXIDAwomihezpBNk8unkXWnGDjOV82gA9oJfqLKqlc0h6etC8peg==
X-Received: by 2002:a05:600c:4514:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-4390d576214mr59974545e9.28.1738847505262; 
 Thu, 06 Feb 2025 05:11:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd84b9sm18709055e9.39.2025.02.06.05.11.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 10/16] target/microblaze: Consider endianness while
 translating code
Date: Thu,  6 Feb 2025 14:10:46 +0100
Message-ID: <20250206131052.30207-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Consider the CPU ENDI bit, swap instructions when the CPU
endianness doesn't match the binary one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f6879eee352..e44ddd53078 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -414,6 +414,13 @@ void mb_translate_code(CPUState *cs, TranslationBlock *tb,
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+static inline bool mb_cpu_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index b5389d65b2e..b54e5ac4b2f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -710,7 +710,7 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
@@ -1647,7 +1647,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
+                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.47.1


