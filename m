Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32045C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KuA-0001Cu-Jj; Tue, 22 Apr 2025 17:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktv-0000zr-OO
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Kts-0000PJ-Cn
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so6157363b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356286; x=1745961086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEoa5+P2s+dvjQMF6oUGcAe5STudghf85RD71OkQiHw=;
 b=Xv9+55YKv+AuK92hJXPNdVqnAd0rZdHvsIzoKjl+wFX9FHssTIZyyeank8gH+RchYB
 ehwkHbt9QVF2ciS8P/e5N5nM1JoGiOeKRYTt9v5JjSDDDe5B+Dr2s7CuQkuBhntnfi2R
 ULNDwMx/PklfuHL2JcJ9TDMBDGFeUbwn7oU8fyPPu55duKIDNOA98mSplWrD1NR9Gwp8
 6dpOscMEW8lr/b5okWBx3KVltEQ2jarcI94reDE1Nunw7e9q2JypAeIYjMXcgPT4knGA
 hQ/aZY+//YssRiiIrWjiNn3DPOwTOAYe/gNxJDYOe67j3/TxPUn2obrMNkVxrBN9167l
 ypvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356286; x=1745961086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEoa5+P2s+dvjQMF6oUGcAe5STudghf85RD71OkQiHw=;
 b=ixw+JJD4SgsmRAHj+PyAowQd4Zg5+lvstWVw5n3BgCiBNLULcQs1GKEtyx+254XFUJ
 OasDEQdENafRjwfTPq1e5DqQnm23kR3Nkrk4rjewKzNFZAm4gQtQqko246jiOWbkJm/U
 3BDo2Mpmsfs0YDMR2tYMCeKwaFQnzxfIO3Mo1YDOOWB9ofXqrAyqfm7wiredsyOy56Cp
 soRHDBaKNl3zw+tu6QNYfiaZ0Byc5cmVI3XBpany+Kw0LqgJVtRMvEd++j3ZfS+7ytrp
 Yf2QyujQR6683ciEEEaGM6gppCgIieg7jJwKurDh6J84iBayIwpoQEjMZBBHEETunedB
 HBcQ==
X-Gm-Message-State: AOJu0Yy5wvpTUHPbPP46WkrKJC6A9H6MIXoq9XWzYVEhWq0M117Hb+HC
 i+VZVOQAYe7c6wx9d4o1vfFn1jOFyjkKY84NhNJ3IUX8VxhJXMu8uK/1HiU9gKtccNSGotuvSgx
 u
X-Gm-Gg: ASbGncua8onEBToQHPLXarC8E0WEQqNYv3g0RuzuEjHtZ8m9hkaO1j0XMwmwWTqR2UK
 x2tGu9UGIM8TullWNIMtHscp9We/r6XNTzvglx8izpgG0+FGANmivixYBGdHBvG3qXamUckcYwx
 w+PPJAYveqLghB9sB7y1e4ZcTnZP0qMqUX6BB2d/w7r8dtsI+TGKdBp2jgOg6FTdghcN0+eSorT
 JrsiIEdfiYxyUmwkfeV120CTHIgG1aNKHZRmZDRAYmMZiZ/P5THaY6xZNMN/kKMi0lloH7/dh5u
 fZ/Ijgixy4LVDSocla+muwlJsQA3CJdwxodZ8Rvuj4lXMoK7MdD0Quf0Ajab+CyCPActlmMAfC8
 =
X-Google-Smtp-Source: AGHT+IH85Xbb6fHERhvGrN7qw1qb234RqITajeWO4p5kIJQXuT523MIGes66o7BG7UfwabqrYNQgRQ==
X-Received: by 2002:a05:6a00:884:b0:730:97a6:f04 with SMTP id
 d2e1a72fcca58-73dc1494019mr24972876b3a.7.1745356286115; 
 Tue, 22 Apr 2025 14:11:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 1/9] target/avr: Improve decode of LDS, STS
Date: Tue, 22 Apr 2025 14:11:16 -0700
Message-ID: <20250422211124.305724-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

The comment about not being able to define a field with
zero bits is out of date since 94597b6146f3
("decodetree: Allow !function with no input bits").

This fixes the missing load of imm in the disassembler.

Cc: qemu-stable@nongnu.org
Fixes: 9d8caa67a24 ("target/avr: Add support for disassembling via option '-d in_asm'")
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 2 --
 target/avr/insn.decode | 7 ++-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4ab71d8138..e7f8ced9b3 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -1578,7 +1578,6 @@ static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
@@ -1783,7 +1782,6 @@ static bool trans_STS(DisasContext *ctx, arg_STS *a)
     TCGv Rd = cpu_r[a->rd];
     TCGv addr = tcg_temp_new_i32();
     TCGv H = cpu_rampD;
-    a->imm = next_word(ctx);
 
     tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
     tcg_gen_shli_tl(addr, addr, 16);
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 482c23ad0c..cc302249db 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -118,11 +118,8 @@ BRBC            1111 01 ....... ...         @op_bit_imm
 @io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
 @ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
 
-# The 16-bit immediate is completely in the next word.
-# Fields cannot be defined with no bits, so we cannot play
-# the same trick and append to a zero-bit value.
-# Defer reading the immediate until trans_{LDS,STS}.
-@ldst_s         .... ... rd:5 ....          imm=0
+%ldst_imm       !function=next_word
+@ldst_s         .... ... rd:5 ....          imm=%ldst_imm
 
 MOV             0010 11 . ..... ....        @op_rd_rr
 MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
-- 
2.43.0


