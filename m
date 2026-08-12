Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4BFC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUV-0007H7-Rs; Wed, 12 Aug 2026 18:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUT-0007FE-Dh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:05 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUO-0000yW-G0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:04 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84847482584so322630b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573919; x=1787178719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zSsmw7bVpHqwBzN8hoA5zO7q54qplu7ZuYLxAfPjq2k=;
 b=dpS561XyABlRzA8QhoA9CQz+koM4OYJiD2WDxatzyMhSsxic7bto7/BXvXUTzXzn2L
 ImBq5fmmlAVzPeX3Ybdh6/CAI9Ax0dKXAH2UbDaxPqIgemMZG8wNxsyEqPwwkiCb+q/B
 NsxAASnsU3MisKLJ6ALojUFpND2mqV+9t16YZwAeOK+1/nUzzJge+AA6E4qBVkxD/Mkc
 TuFZArpeLSRppmoMtxExY1BfL7MlhkEfBdvpSEXVkyAl8oeIfWsD8Pghn8p6xRmScQZI
 KVgoLab/2CUmyXhS4YYXaCYSLFFWFbykOpwbu8xGOasB7jecAKFiH47bpZwAbulHC5O6
 3EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573919; x=1787178719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zSsmw7bVpHqwBzN8hoA5zO7q54qplu7ZuYLxAfPjq2k=;
 b=dptlYWgDgrUjAylS4HUIrxsxq4rmYP5lRcBcwVQnC1mBHvORnlWq4gV57vIR5qrNYZ
 BPG39OvV8hzaX28QzjEO5ejYB+4//qOcCwXlQI73D3JAhy0OQJ5QtXMhk9yaUJUkt7Wn
 YYw+a9TykCjGr9l1HqDJmgupuXoWNb1o2LasEdGGF0DpxA0/hw1ryG665MeDY3ceLDtP
 0X+1/E6dYGr6/9WC9qDdC3DpLEz7NBPezCwQXLxhEIcFk52xrkDUOQ0Ztp91kB+CSH7x
 YpS7ysW40lseV+z/LBoc/+H8hCrjo2e3T9HAYm8aAE9dQ058VhgtbAEimZock1hQNu05
 7hfQ==
X-Gm-Message-State: AOJu0YxYEFmcmtYwO7518mDUkMSfCevdZf1ZgwNsWRw58aMlaYkTcoeG
 +hBwJqC2g+hEH3wwdRRUYONq2goCiPR3CdAY0ar1Dx+zvMBAK/7ufEAOg0oOfb39bHRnQboCC7c
 Y3EkA
X-Gm-Gg: AR+sD12TqVj8C1OcOknYjHCws3yAtXVVW2GIVr3WYNBWPHi829NP3jYQorYzUnfyqoI
 zt/ff5/gm/O7AG0So+m4S7wIGgK53pyZ5bwK9NSkMgvRKLD/65j/DZtaJMxAb23auGdQmhnu2vQ
 Szk8xwBDh9oaBJ1bpe1JVpWNIACBSHH1IfokDFTQrGB3NZZgLIFG1jmIIfk+XgdQRXlHbD5wcpe
 HYc6C2T6+cx17YSZxrqxap8bbxBhultArEDWHt6e4CoaC5fpTdnUltsVUovvtP9dOttf6thsQ7z
 nEHu1/9tv6ZM1xwul2QFEomzdm8bzSwrCholasDmKwci+ugHYQ/JzCbgn85p7aipfhQbviYBtlO
 Nz+CCl0uc+unGXac3z74yGQxwSTbdwuYmoFlvwE4VUlD2miOaS/doVPyfdMhO3qTo4lI/dX/3Kk
 ZCjm24DFJ2HjK7f2ioIIB4/K0j5d7tciaoRpU3BHmfo39VxpR7C3IM39YWBveGqX0gXqO/i7MfT
 I3f7mPiHKtZsRI3KZtZ
X-Received: by 2002:a05:6a00:7582:b0:842:63f5:d097 with SMTP id
 d2e1a72fcca58-84fc79da3bamr1014481b3a.3.1786573918699; 
 Wed, 12 Aug 2026 15:31:58 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 12/52] disas/riscv: Drop codec from rv_decode
Date: Wed, 12 Aug 2026 15:31:02 -0700
Message-ID: <20260812223142.349142-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is mostly write-only, only used in one place;
other updates are ignored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 1 -
 disas/riscv.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 3325b7b4ef..31bb0db86c 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -197,7 +197,6 @@ typedef struct {
     int32_t   imm;
     int32_t   imm1;
     uint16_t  op;
-    uint8_t   codec;
     uint8_t   rd;
     uint8_t   rs1;
     uint8_t   rs2;
diff --git a/disas/riscv.c b/disas/riscv.c
index ec40abb618..9813d75feb 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4603,8 +4603,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
 {
     rv_inst inst = dec->inst;
 
-    dec->codec = op->codec;
-    switch (dec->codec) {
+    switch (op->codec) {
+    case rv_codec_illegal:
+        break;
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
         dec->imm = 0;
@@ -5369,7 +5370,6 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
             if (check_constraints(dec, comp_data->constraints)) {
                 dec->op = comp_data->op;
                 op = &dec->opcode_data[dec->op];
-                dec->codec = op->codec;
                 break;
             }
             comp_data++;
@@ -5407,7 +5407,6 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
             dec->op = decomp_op;
         }
         op = &dec->opcode_data[decomp_op];
-        dec->codec = op->codec;
     }
     return op;
 }
-- 
2.43.0


