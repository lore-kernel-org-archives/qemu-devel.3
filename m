Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4FC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGV-0005oM-J1; Sun, 23 Mar 2025 13:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGT-0005nW-T7
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGQ-0002ss-RT
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22435603572so61794335ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751453; x=1743356253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGgDZgK8X2BSYVWSdj2GCRC9iMdojOu2NC7i0DOuuAA=;
 b=vNYqetvcBXQCyIHKeUTj2NgIlsMrirj0MqcigE1BpeCq83c8Jk5p/fvPQ8giiPxcmc
 wadAC+xHQUH57/CRmqhAKgnlR3MwlbQ/VLq29Gaqa1sy6+7Z79P7TwlO2Dqqha2aH+7g
 L6K2W5FcN46E4MJgKolh5UKQWVx0/m9jVwzch+XFjkbCIRHc+9J83zTG3Dba++lGt1aJ
 kw08o1IulAMxZLnqzGoBlcsFAxj8RLOQUmLZlDClAKoxHidFG06lQNvntXm6b2FDO/Bw
 To5rQ90F/Ry5sJGXXsB8tT7InX+Mh9yXdt+p01aQiR2Ng8zT5f0BwX6urvjqrs2dojaB
 oEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751453; x=1743356253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGgDZgK8X2BSYVWSdj2GCRC9iMdojOu2NC7i0DOuuAA=;
 b=V5zRGT0xohPnUYEB2/QPzvTH+JfxI/O8+wTdbb16Djh0Sa3Kayh1oAleioK52AQY0h
 cXvwFkPHmk0MNn9bW1yYFTOSl0266z/Idxs7rpbG27FWwdFCgKqjEaVt2PD5w0vo4dTc
 AA8jIzsVsSaGTQxHAel/UccsF7ZHhK9xUioASrTBYaj7+ZYbazaYPkmPDfPjTpnMR1Rd
 X7Cy8EwkpzN7YGcMNpXymUJM153+PaNkQHloTpP8MniwZ2QWsenB2zhuj1AijntCQ9xX
 d9hPUyiRtFSGuoydY3zD5hy4CzP/KfcgjesHYZe1s3Nz2VNwd6zYfJDVbsrJBW2KlQRo
 56eg==
X-Gm-Message-State: AOJu0Yyodn/awgAS+GDf6p/8wxoH6rhyhsbbLnxQyxEZpZI7R/80+sCi
 j+jO1hr6XKmbJ4/K/QUJrelPdlof3gNyYjU/nwxlQwd9h0wZVv01R8jNSC9xPcPIVFmuCWoGzfr
 6
X-Gm-Gg: ASbGnctC4MrzaD1rJmB7LjbzjIhEXwzohY2bQGUsOFUd0TNoovennQYgHsDS11QfYOP
 engue0zO1RyeYYPWE5qVOGBMcmS3wmzcJWON9dVv+Q4NfgSYALTUMobicwJfmrcj58JXD5rX8hJ
 Bp1K5nlwqSOJs1Mjc11TOI2G9cejeiu/H+zh35Vl3NQVkbwg29roMGqXOpN9EMQOlDCsZSNWGgF
 /nfm4mjGOvVIjL9BBKi4XTJT83AvOeQqj/0sqAcJJH5/JKh8a7jhFPLGWHWzEtc0jiX9WcNfYb/
 Xi/jbg2pgYgoIHOC7MHX4f1nQJ9N3/f3hcgEV7352RRwLkzMiY8sf+7WjH0OtbzxQT6XfsvRmus
 tEejVN9VAFa0=
X-Google-Smtp-Source: AGHT+IHHjB6B0aSiinZE2kTfMdMwJ2ciLfmNsLKY4AnB8g+LRZw0g8rAnpEja84qwoVEiW8UNlbmwA==
X-Received: by 2002:a17:902:e846:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22780da6237mr185737895ad.28.1742751453497; 
 Sun, 23 Mar 2025 10:37:33 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH 03/17] target/avr: Improve decode of LDS, STS
Date: Sun, 23 Mar 2025 10:37:15 -0700
Message-ID: <20250323173730.3213964-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


