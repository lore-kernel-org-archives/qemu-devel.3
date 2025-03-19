Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8DBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutjg-0002nt-KE; Wed, 19 Mar 2025 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjd-0002kU-Ll
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tutjb-00042D-Hh
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:45:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so5189585e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391926; x=1742996726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS9IoYBKjFns/3rxGigGeIdEfqxRX4ylTtuMFHv8VkA=;
 b=g1aCG5LCBlTHchn35XKeE5zfr4h5tbNPdWKRPdx9K0easlZcKGEtfu87eRj4xurFli
 ZDCVywiI5Hjg/IQ3gVA1J+9eZdJ1FI5ZFtOP3qtrG+zMoNldn71HhLNmx0oKWEJzrLih
 md4Y0BoTYCkjDNrxEe0tp1e3F0Bh2S0XDC27qnhVGI04n9CfAgTESd5+n1PDoTbjI77Y
 rZ9t268EGNojVraYuifyfA9Ku6TR+fK8KVkEWC1ip5GzfHCSKtn5F8wNA2q9SLS5g8Hz
 4wAm91QZRLcHndNI0Jf/nJXFWQMsmH4I/B0gBmAkfni0mXB4lPFjM7xvYlmfl8xMK0j0
 1KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391926; x=1742996726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eS9IoYBKjFns/3rxGigGeIdEfqxRX4ylTtuMFHv8VkA=;
 b=d1d5tIN/ORlTxRIDOuAGI77sP7yoYs5pPHrtCxjrZ4qWnfrwXHr2f4lCYsxHIBNxRI
 xCaBnIRcZ4x6OKWxu4vjciFGpPg+5/qF/3fUonZ2OSF3lO5zSQWEojEAC32HdeIveUHg
 oYsPe/qAouYnwGAqwgU8HDKpKmHEyPLf96zxrl0sKM+9RQFEutNUCM1rEdHFRDw6Pta4
 KgbCWGaR2mOK7AYv/eI5aO3BEszBAXDVwlVEOkkBVqg0Iur4ejvI2cNXX4vFs2yImNzp
 OujwFNa9ftS6Kl+0LPp/TtoHlE8oEKl5c0BxjKkyvU7blTCr8RL7HviSsaS9rqClfrx4
 tqeQ==
X-Gm-Message-State: AOJu0YyrkwqSP08z+6Lj6NVG0ZxXOrVOGrNijtYk6LQQqk7dl8/ot/Kb
 va6QVu/5WKd0bhSiAAp5vnKZEBd/kbiS9pYWcbw/us8CWaNdVJCJRwIHLrL3veZskxpjO0tn4pe
 /
X-Gm-Gg: ASbGncvKvE2b0PxNfEYIAOPQ4sKDO0M6YqxjpmFdv+tyKOCwGCSdG2L4QR0WMurGjB8
 VO/sxTD/R/KpXJL6n5wpvXG3x4zB+5wQnVK+gkQ9LnEZ/1HSNhAepIqDnH5hGwBWsITxiT12Zf2
 /68slNWRdJsSRR7LLuF/tWwl85CxIbfymsieObLAadWQD38h6euz6obA+8JigaYcw8CeuKSD6zJ
 XvDBiqQ+uz+yul1cOsEYaS9t/v/myrc+HZo8iNjDXZ6jEVlWsFHMVExI2RjrP7kYzHsVN2OzVDH
 lObcm0u79zkCViu4qG0TZ6oHRveFURQ37nBrMlXH9tGll9BTcjdYWD4ER0s0QXB3hrfWCE6/jXH
 jqlK1irdnfr6BTydi7vc60Pqc+nLPCQ==
X-Google-Smtp-Source: AGHT+IFo6NpJdBeZUDB3xWWKSKpQ241+3IK2UYxLJqpO9ARXH5OVU+S9YmdMKyxR8qWtjJD+V8vYIA==
X-Received: by 2002:a05:600c:44d3:b0:43b:baf7:76e4 with SMTP id
 5b1f17b1804b1-43d3b95f719mr55577325e9.1.1742391922725; 
 Wed, 19 Mar 2025 06:45:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43cbasm19134775e9.9.2025.03.19.06.45.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Mar 2025 06:45:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 03/12] tcg: Have tcg_gen_insn_start() take uint64_t
 arguments
Date: Wed, 19 Mar 2025 14:44:57 +0100
Message-ID: <20250319134507.45045-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319134507.45045-1-philmd@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since restore_state_to_opc()'s rework in commits d29256896..04f105758
and TCGContext::gen_insn_data[] widened in commit c9ad8d27caa ("tcg:
Widen gen_insn_data to uint64_t"), tcg_set_insn_start_param()'s 3rd
argument is uint64_t, not target_ulong. Use the same type signature
for tcg_gen_insn_start().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op.h      | 7 +++----
 accel/tcg/translate-all.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 5dfddf995d6..8938f386599 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -23,21 +23,20 @@
 #endif
 
 #if TARGET_INSN_START_EXTRA_WORDS == 0
-static inline void tcg_gen_insn_start(target_ulong pc)
+static inline void tcg_gen_insn_start(uint64_t pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
+static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
 }
 #elif TARGET_INSN_START_EXTRA_WORDS == 2
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
-                                      target_ulong a2)
+static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 3 * 64 / TCG_TARGET_REG_BITS);
     tcg_set_insn_start_param(op, 0, pc);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 82bc16bd535..a857aefd756 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -117,7 +117,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
 /* Encode the data collected about the instructions while compiling TB.
    Place the data at BLOCK, and return the number of bytes consumed.
 
-   The logical table consists of TARGET_INSN_START_WORDS target_ulong's,
+   The logical table consists of TARGET_INSN_START_WORDS uint64_t's,
    which come from the target's insn_start data, followed by a uintptr_t
    which comes from the host pc of the end of the code implementing the insn.
 
-- 
2.47.1


