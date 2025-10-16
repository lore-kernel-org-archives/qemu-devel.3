Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F2CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Myd-0005El-S2; Thu, 16 Oct 2025 08:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxG-0003rs-Ej
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mx2-0008Vf-VG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso292556f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617153; x=1761221953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jZZbc8F7BIZzB+ZNvADbn4ri/l/49R6GBMLGAc1WORA=;
 b=Tj6ZIrbebbxThY+/6y1xhIHKoUI0KcN1iolq1eXRpghxZkGzx+CG1e4NQ8WK/ouh9z
 odq48Z5CnP3aRBid/UcmGKb4XtK6nLQhh31Q3WZGchFt6IOqD5+ElI1kwMQ+DL4+PwXf
 sroJmjwzb/a5O+I9BjBr8d7PKybRJ7RMcO14LXtfWhE5q7g2bIW4W6GH8K5HbKyLPHZA
 gV8xOthKiLo3bKztJCW+Z+BKVJb+Oe25mXFpTdVXxRKGnkknEtkiufohd0kIU4+unoMf
 OSjznFT9RyO3MjeyoX7F7pSkezTR9HjBAdi9kg5KjPiGmVZp+Yq6kTuweqTosfMkKJvo
 OaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617153; x=1761221953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZZbc8F7BIZzB+ZNvADbn4ri/l/49R6GBMLGAc1WORA=;
 b=BRMkLbsydPWxqLcqxQnMI4owywnnkmFzAY84FAAwTKwsGoBWB8Hbc73FQsFA4mB7so
 YzMDtQn159EMeAFXbaI4pa/dB50befZ/qBnX5aHL1SD9+jUaHLfBBKK+GsGkkrD1GkTF
 VKBY5dz7SZXjaJncVyD3eI92jdp294ybROCOl+W9CDjHVkmFX5HcR2BUqS7EEEHmgQx1
 Y5AAO4HlRd2vzuSFydmEL4nicHc7jA4BPpRAqHAND/k+Sq90eZpgdnH5cQ7TehbXlqJ4
 GhIZQ5muUjCCWH9txv1Ah/4e84PzqpTx3BxsL8xOx5O00CCYravPVy+Y8d23aBmNJvQb
 uRvA==
X-Gm-Message-State: AOJu0YxWZohDU/DsgmI9hKLthm6Eml2qz3RjPBS3n/gnoyUEzMBPNbeg
 TnPWwafK6PfnRWGWMx2WT2Ngr1vWI1WThZvG+iEJ5TCt8co5QS9ODh0Y5vTaQswHHRQA0pTWeKt
 XYu3WrXo=
X-Gm-Gg: ASbGncsnH1RlyvcbC3Boopz2qtyLrf1IUj13GW5GrbYXX60cl4OEPL/6/hf35Zlg0mE
 cjdHjeZJCBWJnsbcsnYvJQu4Fve6JKuXvvMIecGOlTkcbAtYbD5fFEB9NF+sEmnutlbTOMm2U5L
 0o7Fd9kq08uJsoEC+gQ22JIZXECYivfb9mA++ZA2hJpbkcMXyyQvwSqAHFfbguJMXSxycuJdQsb
 aO0udCRBaOpqgyswua64qdPQZzoNTnAjZyYPypJ72qNDd1LVmrbNND9Nxgw6ifEV4STtQzQ30ab
 y5t4WkVgn0d6o8oDlY8siXOneOvld2Vr6XVxDXAwFaNzS/MQ8q1m4Qsn+eUX129g9Befq4PlPaD
 MrkgShUD5hG2mM1Z6iHmzQb7icW6aM0Paek9P0fAM3XF8KsOTDmrXRjd/P/HHA3BZLLcPWwBXWl
 zlMbl19LT7LB4H95cEYJljHih1kxwd1JL6xI3+Qq9RuCvm36pna8qv7Q==
X-Google-Smtp-Source: AGHT+IHXKTILZFeI3k8C+OEEN5PPuIOOcBubPPv6diLJJj91Yec3KYZFm0/HqRTTf8iUbMAv5T/Org==
X-Received: by 2002:a05:6000:2408:b0:425:8125:b108 with SMTP id
 ffacd0b85a97d-4266e8de10cmr21315140f8f.54.1760617153159; 
 Thu, 16 Oct 2025 05:19:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm34160108f8f.42.2025.10.16.05.19.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/75] target/rx: Factor mo_endian() helper out
Date: Thu, 16 Oct 2025 14:15:03 +0200
Message-ID: <20251016121532.14042-48-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-7-philmd@linaro.org>
---
 target/rx/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 3c7bcc9933d..6ed7ef629ff 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -72,6 +72,11 @@ static TCGv_i64 cpu_acc;
 
 #define cpu_sp cpu_regs[0]
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return MO_TE;
+}
+
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
                                   int i, int n)
@@ -163,19 +168,19 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 /* generic load wrapper */
 static inline void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
 }
 
 /* unsigned load wrapper */
 static inline void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* generic store wrapper */
 static inline void rx_gen_st(DisasContext *ctx, MemOp size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
+    tcg_gen_qemu_st_i32(reg, mem, 0, size | mo_endian(ctx));
 }
 
 /* [ri, rb] */
@@ -226,7 +231,7 @@ static inline TCGv rx_load_source(DisasContext *ctx, TCGv mem,
     if (ld < 3) {
         mop = mi_to_mop(mi);
         addr = rx_index_addr(ctx, mem, ld, mop & MO_SIZE, rs);
-        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | MO_TE);
+        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | mo_endian(ctx));
         return mem;
     } else {
         return cpu_regs[rs];
-- 
2.51.0


