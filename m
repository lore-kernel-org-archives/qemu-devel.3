Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A993C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09A-0007Sv-98; Thu, 06 Feb 2025 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg098-0007SZ-Ks
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg097-0000sO-1y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:14 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38da88e6db0so357595f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841651; x=1739446451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVKpviLMTY/xpsQ4Un5x7Zpm8oUwtOVraYJxurTn7aE=;
 b=WLG7jbEyC7FG0HqLpLo3qD0I8xRa/R+ZutIGze6EB+jba1ozpF8yO6S+4CzH6ozqe0
 Q4FGzfK4WOG4NU409C79q2khYUas6JmVN55yPHHrmwAAs0x2/EOpOterTjJcgFfLIaCw
 JceOCHzi1S+zbKTSYrWOWm5vOLNnO0maBNjS+VqetakdzZ8knKRXFLHfLDqPmKaQmuUD
 hGnkwQw4kN81rgruzHeiF2t2UdwNT52hdiSDLwfqDmkc0lmaCTKIMISS5w30XDJviHcH
 NdHOf5rJ5OW7zGOzt52f+XJ2gZtybxpsOpmfFhx3q2coE24HEbABDRzVZzl8DMd5MYx4
 f8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841651; x=1739446451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVKpviLMTY/xpsQ4Un5x7Zpm8oUwtOVraYJxurTn7aE=;
 b=t5elLqrAsWCvIaXrZymoCiejwUvRiGYbLYU4+ic6HORth9kl9WH9WBWmDZEOsu+yot
 z69UgV2rVMjaXnXlRgrdoVfpkOkdizflmwrTl+htyPAvCmBHmtkjBLVDQ1CHJvSAOyli
 0g2R/75qSrrE9oUpCu5qk65oGb5slarB8EjFa9OOk5J3Gu6w7m9jpHS+g7kLqfCVzjOc
 qiTbGNeQ+fvw2bsHscQHrTM0wOFNnIpkTrlyxjjDcScZfX/T2zRvEfgE+kv7GhXMzagi
 rTnsIdexFJYRBssHDRoXsx3mNMZMprdMm0UrUaSWjiFQp+BafxVvIbPDAgcUwaxl+dcc
 mncA==
X-Gm-Message-State: AOJu0YwBT/sN1bT/6KaxjUhTmbqt7nVHkroS8WHCAZdME8Lb5kmmtMlo
 6/7Ae1CYYksZ15noR++us+3PStXy+lI/3yF+edkYahHfM/DO9fHCN4P/yxu11+aIofg2E7zyOVl
 ab38=
X-Gm-Gg: ASbGnctnewa5li+m4xgCG0lr3kFFXanmqNyN/uMLGRN/qUBQDWUDi+3VARcQbG90au+
 Z3OcEF+QoBsl54TVTYwtQQiB5czaLUOKLEuU0lRdn6KZDb7uFrYCjAPCWiPdHIqlNcuhRsC2iv6
 QLJT2X9sL909aOjHqp49IGqYa5Zv8FSdlKQEDDnWgfOcngQn8WlkEMFZTehGJQ7HGZ23qCZT7Sb
 /Ra7Y3PpOxZMq6WIf4mu2wpk2t0RsuRQrTFmVINHYj/r2yYgni+9qEOd5BPafwa4p7EoMIopkM3
 4jVeMrhR4dWA1NAlUCUczgYgAp8Y8weIrHoXxGexmZBc/qYCe5mEvSmVDFPpYmUvOw==
X-Google-Smtp-Source: AGHT+IGAqBSoSd12cBD+IMSrISASEJgWOTnv5yttBRw/sYGEagHpQCRSjy4IC6ERuWnbJ/RO+QNIhg==
X-Received: by 2002:a5d:588e:0:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38db48ca340mr5201169f8f.24.1738841650986; 
 Thu, 06 Feb 2025 03:34:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fe37sm1515984f8f.69.2025.02.06.03.34.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 10/16] target/microblaze: Consider endianness while
 translating code
Date: Thu,  6 Feb 2025 12:33:15 +0100
Message-ID: <20250206113321.94906-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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


