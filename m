Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BEEC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkN-0003mn-OE; Wed, 19 Aug 2026 23:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkD-0003aq-1R
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkB-00048g-Jb
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:08 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1772531a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197626; x=1787802426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2ERpv2R5tDGDX/CspojpX8vl9OuHWWYGhdlr3yYFXI=;
 b=KdW5U/Ityh7h+YepAHpCdleIk1/lgrciqdYRKjxGtKYf7b4xhHJeEVlUM1HD4NQyMm
 8qFnaiJuRXkg+izDM19VON0qDpX6z0jZtNmezJD2BY+zMdxMMROYuXZ85cDnbxKDFs44
 uyKPqkOGev14iJhWTaaTs2n9m1RW+ph8xpXG3e60+AHu+SPbvKPN/8in6GevdbmjHn9T
 r0nhdicqYd568p07528Eq7ovmIZaEAlnidnQ+PRv6vJR05Orx2rkVPhl/CwSPJ0Xjm07
 ZkGQDpP0hOIWrbgH7KZ50ZTYxAp/Q9F9seilWw5OzyfujP4TGc1LBDbeFgbEhzBL+pLO
 5XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197626; x=1787802426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p2ERpv2R5tDGDX/CspojpX8vl9OuHWWYGhdlr3yYFXI=;
 b=i/cBCCsTbpC34E5D+7gOVfxfbiBnyZM9IcdMetnWnvLHv0QQvPLzXeQ8kIoxUMaodS
 BsRai/8RXJQ1TbDejfI6i/MLu44hmf3LDFUKh5rvZimsPFT/y1Qg2HQVuUsErqoRPCo0
 AVEHPpEtyTXu00GkNQeobd7VTNWu9cw9D/HfKnpofDjXay4Yc51/tiSFZ3fS/mf1Badf
 7Z9iyj/0w+d6rkl8B7lJRnz5JjSij2olOedPioQEzG6mXyT8I8T3Sv1/H9B28aXRd9UP
 KsahSfEhgw4FmBZrbxFJ+GNeZeuLPZ6ETJM5d/4QuWai9/SMWC6rM7oolpJ4O/9A3Cys
 QmAQ==
X-Gm-Message-State: AFuF++naU9hzfcoj3sw1MU498GvuEwW8ppRHSHFv91Okqw8F22ai/Q5L
 /68bRwYFjfPJTwnqE0ODn68LY1aibLpRe0sjfmi3nU6adX45pOgh3yPXoXBeig==
X-Gm-Gg: AR+sD11MMhpVdf9jWMh6UEdY9YFGI+cjMyx/S+DAKKkPDk3wTtW0ZNKuuiBzveM2Huj
 2TpSsBS6dsBS2fWlnP+Q7zZaN5fghHhBYdWSCIqpJmQ00T3W80Fk22vw21UyQtBEQi0DyL9lCQS
 mrxxymDMG+bcAWUftUzaVceMTh8G6B7oGhcJm8lpH1sF6Bk0piK5V41Ah9uY5bGZPfIDq19G2sj
 ddwUw/yMnpgtj2wWshLA/GOK0ppDQiN/S0svS77K7/rOQKK7rOAbmKKSrwtFLp3U4Q6hToyXM+l
 CMr2BF1kRGCn+S6MAnydakoRvMedt4i15WX7J6Nl7uKxg1um6bJKREHzVmjojl6FY6H5K45tCBp
 y8WkysxclFkF5HHxv86a4ofaVNxVZcxUKiY8rbx4Q6xA9VaO6slZa0wDUzG6USivhIxRxagwao9
 3EJZWYwzWmEr3/aBhSiXjsusa8usMWy5SKWn6jvSAwo2R+aVc04PXFKy8x8Ikzu+ptKtve6Q1Kh
 9uv8A==
X-Received: by 2002:a17:90b:4a46:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3958083fc60mr17335792a91.4.1787197626309; 
 Wed, 19 Aug 2026 20:47:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/93] disas/riscv: Drop codec from rv_decode
Date: Thu, 20 Aug 2026 13:43:45 +1000
Message-ID: <20260820034430.1186695-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This is mostly write-only, only used in one place;
other updates are ignored.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-13-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


