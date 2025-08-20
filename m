Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F4CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 13:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojCE-0006kO-Qt; Wed, 20 Aug 2025 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojCC-0006kB-E9
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:49:44 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojC9-0008Dt-PX
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 09:49:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3bea24519c0so455501f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755697779; x=1756302579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1JoKi1hqpbrpS2BDqIq6v3JJ/w73UgPs21kYdYCsdHA=;
 b=lN9I8nqb49BA6a+COmcVs2Vhda6bXDOgB5Nd3WA2zvMeEbd9xJKtGYAVbZzeb66O3I
 JhPZq485w+KFZE4+jS2X8IFTiKBOdQKH28lsJKzbAQnfOK7nelywIKNVm+YrWP5YWf7w
 QYTcUegPJPI96o4iyR6EGJT301GlJ7/i8Kv1BwG+ef8vy5PfTBxRgulEEhpTyGswd5LX
 3rpXvXKpuw/AIE/WkSLdBf5Hxzfv3UuccxAPXd2O2mtbDg7fcwyUuD1TRSpDeWHWwHmP
 AZp81vvUnIjf/IMU1Sn5roySdRRAaZWczWVoRTBOY6UBiMZ10ftjJuH5fFftiJ3kh4P4
 XoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755697779; x=1756302579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1JoKi1hqpbrpS2BDqIq6v3JJ/w73UgPs21kYdYCsdHA=;
 b=Pk1wOM9k7boOG3qFnTJOITje7TybrU56DkV3O1Imm9kW/k/JQEMDRM3OOIOMTKTBhS
 dLrysenoYEQqODBzE7LRlgSmRQjXWI+L4tl4Fy68Uthw0sw5aHNcP0eKlQI0uVG+yrFl
 9i5GKKePMU4wgeUOugcrIA1o4DnRnPLeRol1TXViqjBbr9TGs7UDPQp931HoShCAmLV0
 /254NOJAEX/dvFVB2rC+vtzM5ukDz6bUDsqtxz03CnNtEthkvST3lzPf7o5Y2cBKnojW
 gYQ+H2KOFG5HfmDM2p27BsDC1UZQh7aXpnJWcHBx0TCyFJgPHT1oysqFMDcB5R4/kjdR
 PUFg==
X-Gm-Message-State: AOJu0YwLdiPhDN3OWrMxOThNmjD7yVXaUm54AD/iQxOUUDby1RJ3WpmS
 w6jmZ4QhgtjOjA0XfKZ0vZxZ7U3Nb13zgiWSojffc2+C9UdWgkjf9yFmGqmPQM/yS7AMnevlrT5
 d7S8/
X-Gm-Gg: ASbGncsjHgLzMQFipUQ618HGNOeGrmIBDDAIc6SV4Qrdz7u2RX1VxPpxcG+hZ3ugmwy
 6AfF97NxEdEpAZw5eT8wKYy5VWo61Nxk7W9zRbPtwttPa92VTNGgKEK23RbPww+LTQA3dn6FMI8
 DSgEzKh+UGHygXvLyq55+r9XwWTYrXHZ5tIqKNqCfH+VJEc1oX06P0YGS4DwbnTfxwLaycg/Ni/
 J4/nGqIzqdAArOv5Eo4f4BQuyR5xZb7RbysJvz6pU4uhVVBrZeEP3aeIeUydAHJl873pBS40NMB
 LrBDAQeh8IWNOSCH78OMkRz2M/77JaH5si7Oex2EGoHUD+gr8QMt5nA04RRrr8Ver3OITEbVBfI
 tFQQnpLpATHZ5saiM0CwisP72UEbzGjZkDPZZ/aXqWYqauynfHSmfrpPsxvZ8QnVP07Y5FQRSHq
 oCGw==
X-Google-Smtp-Source: AGHT+IG7caQ641/rsKjQjpMyHFQAp3uSPRaRfIhTbADhiU8hROscCUz1IPM8O9KfZDVTZl11ICBdSg==
X-Received: by 2002:a5d:5d0d:0:b0:3c2:9d64:125f with SMTP id
 ffacd0b85a97d-3c31553b888mr2886516f8f.28.1755697779151; 
 Wed, 20 Aug 2025 06:49:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3fab22726sm1094539f8f.37.2025.08.20.06.49.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 06:49:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] tcg: Restrict qemu_ld2 and qemu_st2 opcodes to 32-bit
 hosts
Date: Wed, 20 Aug 2025 15:49:37 +0200
Message-ID: <20250820134937.45077-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

qemu_ld2 and qemu_st2 opcodes are band-aid for 32-bit hosts
and can't be reached on 64-bit ones. See in commit 3bedb9d3e28
("tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}") and 86fe5c2597c
("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}") their constraint
is C_NotImplemented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index afac55a203a..ff1a8b71789 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1221,9 +1221,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_qemu_ld, TCGOutOpQemuLdSt, outop_qemu_ld),
-    OUTOP(INDEX_op_qemu_ld2, TCGOutOpQemuLdSt2, outop_qemu_ld2),
     OUTOP(INDEX_op_qemu_st, TCGOutOpQemuLdSt, outop_qemu_st),
-    OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
@@ -1248,6 +1246,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 
 #if TCG_TARGET_REG_BITS == 32
     OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
+    OUTOP(INDEX_op_qemu_ld2, TCGOutOpQemuLdSt2, outop_qemu_ld2),
+    OUTOP(INDEX_op_qemu_st2, TCGOutOpQemuLdSt2, outop_qemu_st2),
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
@@ -5829,17 +5829,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_qemu_ld2:
-    case INDEX_op_qemu_st2:
-        {
-            const TCGOutOpQemuLdSt2 *out =
-                container_of(all_outop[op->opc], TCGOutOpQemuLdSt2, base);
-
-            out->out(s, type, new_args[0], new_args[1],
-                     new_args[2], new_args[3]);
-        }
-        break;
-
     case INDEX_op_brcond:
         {
             const TCGOutOpBrcond *out = &outop_brcond;
@@ -5887,6 +5876,16 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
 #if TCG_TARGET_REG_BITS == 32
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
+        {
+            const TCGOutOpQemuLdSt2 *out =
+                container_of(all_outop[op->opc], TCGOutOpQemuLdSt2, base);
+
+            out->out(s, type, new_args[0], new_args[1],
+                     new_args[2], new_args[3]);
+        }
+        break;
     case INDEX_op_brcond2_i32:
         {
             const TCGOutOpBrcond2 *out = &outop_brcond2;
@@ -5912,6 +5911,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 #else
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
     case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         g_assert_not_reached();
-- 
2.51.0


