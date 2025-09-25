Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB275CAC5B3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 03:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1d63-0006ze-3N; Wed, 24 Sep 2025 23:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d60-0006wG-GV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1d5u-0004rO-EQ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 23:56:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso321452f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 20:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758772582; x=1759377382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNU7nECbR4ZeOCi29LIuImtKK4Mevi+f4hK1nNtMWTI=;
 b=MtGMR/4RC7D0CWFF7kewL4x7/AwWzJAC4pZZuXZGf+X2GRgdJS5yqEDXWWQuQZ8UKP
 P/yODDfUaweBzPnJ4MStZ2Jld6H0TFEOnjT5Yz9ATNOOBAn03UBVq6WgXELa93M1rrg+
 yGzUpB7nH8+b3aVThQi6mXsV0PyDyjrHAboIewDXKewhS1kTTiZIGpzpLw1vFOxlu3aK
 WsxWpDCCsgilGDl9glphoe6Khk8nVOg63C0yw8T+CIY7YDczOBXevzO84PYgodFfLO2j
 ukGzhoiGrmJdyN8aY77VkIxXc5LTpFDklQ4SlEuC/71Ozu593zfYfaQPHDd8x9ZlW9/Y
 hSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758772582; x=1759377382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNU7nECbR4ZeOCi29LIuImtKK4Mevi+f4hK1nNtMWTI=;
 b=jnXIeipQbdGYtnrM7rT5nJHQwBie2H5Gn4cxaA0KYoKlOX7EoQ6YSE1HRFS2OhaSfK
 jBg5uhE0A9qXQEVCHSLeSvdsXT7uSJf11lX7ZMGigexabE6GajGuMcYfG1ofbnQp61k+
 nEkcKMsjzoTtZmJh1Q9M6jpLq71VNeJedZGTVhCDZ0wjA2xx6+SL1zMZZz+47aK72rZg
 RjyIgFaOfq4/UBtaCqbaDb9cCelNXapGPYPdgv4G4ZD5YdYYtEfeFhAOZzUzrT5Yx8Q4
 W/GnfhW7EtNMBkMG33imIbhxA4/bqw8u3yLE0+v+avkddl9p92HBBFi9SPEXuxQxqTsH
 7PzA==
X-Gm-Message-State: AOJu0YztnraWOQMaNHllbjsUBC+YQ0BX23XsR2XhFK+ruDHFzXihqag3
 kez4t2U3QdWz8ZEfLp/A5C1RKy8mmkYBuxtc5eBf+aC+2M25jtnvdpP01ZDVgwGUYooyjWd2TfD
 YejBtWIesAg==
X-Gm-Gg: ASbGncsK+7ZsrjJvFftddDgdrpddSTG3PiiShAOBFx8IqGHF1AMgK4Dco9Z0FByKIJb
 Sbw3QAkM+hcn6BKuBMXeSx10ypxY9bDhayYqhc3zqOeD9uR+mPkv8RN3sonOmGLCj84c0M0Jxdc
 Az9QgA2rNAPjMb1ZHIt9D9JJDwZVv/0QJwyXa4WdRUtEKYIQ9QbSDg7M6AYh4q9/j9sM87EGyFO
 ss0kFP9IKbus8G1F81Rj2oKqXwzzG1Xazq9P+P6nAX5qft6Xa+vOYbZ0TnI0BgeoB7Z/h4Pdvpa
 dSe1IkmgAzInYX0qXVgVxyFek8LIPCeWLbi9WS4WwOe2EuBxcq9abvGKhG6wDdlH1khfOBiXSHL
 fQegjmUi//K7os2qw+cPnRR++JvAIeaRGGwChaozUVjx104J5gywidnZZ3AeW3j5MS7VwFWWj
X-Google-Smtp-Source: AGHT+IGEep4xAHQTYG1NRfwkPT1mcRsV5WGymxBVxJ0NwMoXF4GFOr8DYUjeHl/2rX3sThhu+ETnoA==
X-Received: by 2002:a05:6000:2585:b0:3d4:15a2:11e9 with SMTP id
 ffacd0b85a97d-40e49e7291dmr1727667f8f.61.1758772582582; 
 Wed, 24 Sep 2025 20:56:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b9e3bdsm15470385e9.2.2025.09.24.20.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 20:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] accel/tcg: Trace tb_gen_code() buffer overflow
Date: Thu, 25 Sep 2025 05:56:10 +0200
Message-ID: <20250925035610.80605-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925035610.80605-1-philmd@linaro.org>
References: <20250925035610.80605-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/translate-all.c | 3 +++
 accel/tcg/trace-events    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index da9d7f16752..fba4e9dc21c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -290,6 +290,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     if (unlikely(!tb)) {
         /* flush must be done */
         if (cpu_in_serial_context(cpu)) {
+            trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
             tb_flush__exclusive_or_serial();
             goto buffer_overflow;
         }
@@ -325,6 +326,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     if (unlikely(gen_code_size < 0)) {
         switch (gen_code_size) {
         case -1:
+            trace_tb_gen_code_buffer_overflow("setjmp_gen_code");
             /*
              * Overflow of code_gen_buffer, or the current slice of it.
              *
@@ -389,6 +391,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
 
     search_size = encode_search(tb, (void *)gen_code_buf + gen_code_size);
     if (unlikely(search_size < 0)) {
+        trace_tb_gen_code_buffer_overflow("encode_search");
         tb_unlock_pages(tb);
         goto buffer_overflow;
     }
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 121d6b5081b..0816cafd336 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -12,6 +12,7 @@ memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, const void *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
+tb_gen_code_buffer_overflow(const char *reason) "reason: %s"
 
 # ldst_atomicity
 load_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
-- 
2.51.0


