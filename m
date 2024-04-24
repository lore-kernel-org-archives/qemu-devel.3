Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CAC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5n-0005yz-VF; Wed, 24 Apr 2024 19:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5h-0005ug-OI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5g-0003Vh-1D
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso3621575ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001510; x=1714606310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EhXPPMxaAY9EqFJpabnI69teg9b6N6lI3TZrlx6dqE=;
 b=yHe1tlPRJ8hLdPa2OaNUvyNHHlJsvaEEEWvyj5rGS4e+zu/TaHKcgJ8K5LDkcGc7Bn
 FTB/suFpmdKjFiW08P9124YE03lvSWYWEDeAP0kapIXYy8Uf9MBV5JCZwT/H2c+70unv
 HGybqIyMT+9gS0W0+t/UwMIVYmza863hks7GrxM5PPKc1lRRxj4ZL/+7KE7jHkqioe/d
 Xgtp/UFN4zWRPUjci1EDRRjvthRy53HvOkmB9HqifFbJy+P/aWwho1ApZ9VPZ4IuVNTt
 jrgMdsbcJGRRfZK5ElT1XXLHcfA4pCq2LYNX36AByx1Fsvc+ZFnZQwhrOkskXinBZTvO
 /ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001510; x=1714606310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EhXPPMxaAY9EqFJpabnI69teg9b6N6lI3TZrlx6dqE=;
 b=aEUDPKYdGTARg5x4Bu29lx++XVajd/w1oZt5zMRrgCY2gbRQIKbjLiIIpGtjmCZgOW
 vGkBDnEp/AYfxvmUSOqFinXGRK4AH5DV8Lrw7b1CBxn9tsYvUKbMdbTBymZaTf1ArNQn
 Yk9qPs8XIWfdYrQu0LoaMF7dbit2+GeE1IEScJdetGIivvns6xASy966jg5AAACCN7X1
 BUuBwGNrtlWnojHslVEPvPj0bzP9Vo/hEDRcL6gDINMXLPMnTYo/ZmZvXdEW+8bExI/P
 fB+dI+JWYv3/KqV1k3l0igBZl4ArdkeENBQ7mkMrbB0ZoSK3R9hVF9AADue+BthOsFsc
 XSRg==
X-Gm-Message-State: AOJu0Yx2reBjkTqkNbKdfaheNR3b/9fU910qafM5Dwmrn+k72QYHL3Dq
 fOap9DC98jUx0Psx0zl2/NVDxCKzRbVSLCdMyA58OOXu6JySrJ7dA+f1K2F7rOC0u0Fto1Q4pP6
 y
X-Google-Smtp-Source: AGHT+IGVfougc3oHUhk+weSfBhY3IoMegFWSDJ3iSZhSxOlOVzUSkm9pXy+wIpPTRoV43Ohf+LbASQ==
X-Received: by 2002:a17:90b:1e0b:b0:2a2:cf1d:895c with SMTP id
 pg11-20020a17090b1e0b00b002a2cf1d895cmr4028357pjb.41.1714001510617; 
 Wed, 24 Apr 2024 16:31:50 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/33] accel/tcg: Introduce translator_fake_ld
Date: Wed, 24 Apr 2024 16:31:18 -0700
Message-Id: <20240424233131.988727-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Replace translator_fake_ldb, which required multiple calls,
with translator_fake_ld, which can take all data at once.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    | 8 ++++----
 accel/tcg/translator.c       | 5 ++---
 target/s390x/tcg/translate.c | 8 ++++----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 8c3a8aa3d1..fc9fc64963 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -234,17 +234,17 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 }
 
 /**
- * translator_fake_ldb - fake instruction load
+ * translator_fake_ld - fake instruction load
  * @db: Disassembly context
- * @pc: program counter of instruction
- * @insn8: byte of instruction
+ * @data: bytes of instruction
+ * @len: number of bytes
  *
  * This is a special case helper used where the instruction we are
  * about to translate comes from somewhere else (e.g. being
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len);
 
 /**
  * translator_st
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index e968d530d8..14622b69a8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -467,9 +467,8 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return tgt;
 }
 
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
 {
-    assert(pc >= db->pc_first);
     db->fake_insn = true;
-    record_save(db, pc, &insn8, sizeof(insn8));
+    record_save(db, db->pc_first, data, len);
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d74939389a..2eb787e401 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6191,6 +6191,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
     const DisasInsn *info;
 
     if (unlikely(s->ex_value)) {
+        uint64_t be_insn;
+
         /* Drop the EX data now, so that it's clear on exception paths.  */
         tcg_gen_st_i64(tcg_constant_i64(0), tcg_env,
                        offsetof(CPUS390XState, ex_value));
@@ -6200,10 +6202,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         ilen = s->ex_value & 0xf;
 
         /* Register insn bytes with translator so plugins work. */
-        for (int i = 0; i < ilen; i++) {
-            uint8_t byte = extract64(insn, 56 - (i * 8), 8);
-            translator_fake_ldb(&s->base, pc + i, byte);
-        }
+        be_insn = cpu_to_be64(insn);
+        translator_fake_ld(&s->base, &be_insn, ilen);
         op = insn >> 56;
     } else {
         insn = ld_code2(env, s, pc);
-- 
2.34.1


