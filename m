Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18A0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ4r-00087e-DG; Mon, 10 Nov 2025 06:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnW-0004vx-7g
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:11:11 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vIPnU-0004KZ-Oq
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:57 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c6cc366884so822216a34.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762773055; x=1763377855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuF/v0yXtrg33Qqyg428lUouMv/b84r+E+BBuSI4+Io=;
 b=QjAfFNM8BmU6598I2uaaeASd5JX4vWmVJnqwJTiAs8/iG7Ktk3QCcE2Fye3TEh/SQd
 Ao2N9M6liB39VoGvQf2Nr877S65Z85YivOAKqYZ0gwwisJtdaQFPehjBJ1VNl+m3jTtG
 TaZcOHZrWIypUrHLI8NMcveG9lejDEwvWrZ0xcVCALiwjcRxNy0BpRfJJyYgdW5IEns8
 rO9XPY9IB4JQ3W7OYrIbgxgdUVU3KLj2tn1qqUV25s8BAiHVgqnMa+qjf4lKusCpgmwc
 FpMu+7JNEpisDx/D/FrFGr1fqEP+ppIG3kLgM3KMagx/G+A1Jrju0jlvkYVnUgVkcYGT
 AKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773055; x=1763377855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WuF/v0yXtrg33Qqyg428lUouMv/b84r+E+BBuSI4+Io=;
 b=v03qpIMYsJBHlVrV2jS2HIRhl522Dnz4eyWQacQkIW/rEhmuD57hyNqfcvnOOSmo0v
 sfKQ341CWS0xOSeXYuzawZVVxlDpEsPbC0h7eAoztwXvvOHWtUdvMB8ubuXewrnDDGVq
 k54vx+wqfqGS6PmlukxBUwgCtOwSxBtRjto4ALpIEVIkEelROCD9yP/xAWDhoYMkhEOI
 adf9vU8lL/dkh6PntRsbLZKH2oa9kLS5X2xqSBkksTlJPjuh40dZMeE3wd0C1WAE3J3r
 5W65HbnBWEWy/Je0kkd5gXbNFZFbXf274mBq/1tDjOBZYUWjxb4niDCkzNYsbGjITDyj
 v99A==
X-Gm-Message-State: AOJu0Yx8TvRbhcKlfuvw4kSNdwnUM1ue0D0KYL7K6sMUmZqW7HoSxj8Z
 a1D1YFTl9VwrJBEnjVUzKx65SBzQWhY6S24feVrqpb2L71GhSSq+4O7biWlMZqUE6jXh60XC/2Z
 B7J2u
X-Gm-Gg: ASbGncuwUXHPqG6HGegGXZ2EhrgVi4691Z5DvqQUl5H6jeLc01qWxSPRalcf1eFGeOB
 0filbmhK+daY503qVN0elRzEHeWK66Ztvbv/ero0pFeByBX9RANEIIzJag3dxnt3iYtrCRZ0HsQ
 W9MNrW2BfPKjKZLbx9yROtHm9DhHNN07FcExHdV6UBmrE8h7ELk365betd+hETEdvoyPLTyqX1B
 Im8pRr7nODtuWJap/qgMCJ4+5B+AFhwopYHUpz+6GuHC/VDKSIuxX2LBuoC/xQGYmIqR2ilYZOR
 fxuL1XbETXusdTORGBZzNjSoUnB8gq4uFmb2k0c0D88pzs/w46kByO/i7S4oVRcWf6yMplLAsjg
 Fhd0ik/rMPtZkyrIQquEhV5aCNfv8B+5burH6P9TkHNoAJZ/W1FYbIwjF2CmOeH0nJwHo85OYSi
 SrM6imD8T/NkjkWO4ntQXZW+oH1MEy7w==
X-Google-Smtp-Source: AGHT+IFI3niuUwJ7IV2mY1l9nlRes14sbUXJiT5G24UKroXwdiibnIQIjJohSfUXrcbMl5WAN0mceA==
X-Received: by 2002:a05:6808:f06:b0:450:4e1:47a3 with SMTP id
 5614622812f47-4502a361af1mr5005166b6e.35.1762773055561; 
 Mon, 10 Nov 2025 03:10:55 -0800 (PST)
Received: from stoup.. ([172.58.183.226]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450426be56dsm1603412b6e.18.2025.11.10.03.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:10:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/5] accel/tcg: Trace tb_gen_code() buffer overflow
Date: Mon, 10 Nov 2025 12:10:42 +0100
Message-ID: <20251110111046.33990-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110111046.33990-1-richard.henderson@linaro.org>
References: <20251110111046.33990-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250925035610.80605-3-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 3 +++
 accel/tcg/trace-events    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index da9d7f1675..fba4e9dc21 100644
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
index 121d6b5081..0816cafd33 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -12,6 +12,7 @@ memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, const void *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
+tb_gen_code_buffer_overflow(const char *reason) "reason: %s"
 
 # ldst_atomicity
 load_atom2_fallback(uint32_t memop, uintptr_t ra) "mop:0x%"PRIx32", ra:0x%"PRIxPTR""
-- 
2.43.0


