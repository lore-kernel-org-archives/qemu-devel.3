Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3EFC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pg-0002KU-IS; Wed, 19 Jun 2024 17:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pe-0002Ga-Fc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2Pa-0000bI-GD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:13 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f44b594deeso1813665ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830808; x=1719435608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaeM+0q5EwrcxAQIdVCE42v6QSxVbiZP1wP+3ptJ+AM=;
 b=MyukPaXzToy9KErCYOmdPtTpt42FKwJTVagNk0RE2uQRREq1RIqPgjk0tXsZtVSmw4
 DxDgpOFLQKKajKEa4My2924bCcZ42cYamNFbJr2Wsmv1PK/uuOVO1SAVXhDITZ85bhr8
 Mu3qRhKy59C2/b4rPc78cB6QHIeuTVYCS2F/MEY6RdNDdmcgnhU5shItCHIAYX7wBfoH
 /WD2UCmlWyiJUWL8s9TKjrTRhAMPoilc/LtwsY0klMo2xVLBb9GGg/hSbBi0oBvVfY9T
 K6/UdS//ek5ma6GM3eygG2thjLdOT5yBqfPmtmheJwx9l0EdlZ9wZpd6Z1wQRk/VvVAn
 UMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830808; x=1719435608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaeM+0q5EwrcxAQIdVCE42v6QSxVbiZP1wP+3ptJ+AM=;
 b=IYl9iR7ZwA2QG2nhkrb9wkmTYIIN5QGhX9eX2gRj5wcfFyl8bh+T19g1Fh67WQ8eX/
 NqIeyFyKLB7akBpKuREgO1yIiCDn+XeZNKY12aQAjT7VA7VW9A3EWjL95C+MmHk0p2Xo
 2rcixAQCiGH50ar/E8AjCH3Tj0ENPxiAowZ1My0bZBkQpE4HKLOLhZv3oZawcFQVJ+ac
 VopnHVCRCIwbcm0YEZ6CsztLSAdzijnYda+h6JQxCafD2wXAZfvARDKWOvhjMydFWdlN
 rFPd/y+7idFuWBbo5+5g/ShBvzbJg9RMpxoXM5KxEbqzNEVJJZAeUc3VFUBpayEIhz9a
 ZIGw==
X-Gm-Message-State: AOJu0Yz+LRaMfIwD5xJQFSWzRsN4CXnf8titlRbgro8WAY37CyCUlRra
 yLvOSXAyqndUeeTLbREAVqbLUmaLWE1S9JgXVdwcJj5WZsS0m2dfI6B+jTGjGOITEWhQxJrhQfE
 7
X-Google-Smtp-Source: AGHT+IFqZpA9/fFaRz75riP82VnE/2QjeSUeGTMJDGotrM3APQta+X4ZYLkyN8vAcRns5ln5EK40bg==
X-Received: by 2002:a17:902:e543:b0:1f4:9e69:a8f9 with SMTP id
 d9443c01a7336-1f9aa67dffamr35951495ad.62.1718830808218; 
 Wed, 19 Jun 2024 14:00:08 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/24] tcg/loongarch64: Remove temp_vec from tcg_out_vec_op
Date: Wed, 19 Jun 2024 13:59:43 -0700
Message-Id: <20240619205952.235946-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use TCG_VEC_TMP0 directly.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4ead3bedef..1d9e0bf028 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1834,7 +1834,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2, a3;
-    TCGReg temp_vec = TCG_VEC_TMP0;
 
     static const LoongArchInsn cmp_vec_insn[16][4] = {
         [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
@@ -1976,8 +1975,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                  * dupi_vec temp, a2
                  * cmp_vec a0, a1, temp, cond
                  */
-                tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
-                a2 = temp_vec;
+                tcg_out_dupi_vec(s, type, vece, TCG_VEC_TMP0, a2);
+                a2 = TCG_VEC_TMP0;
             }
 
             insn = cmp_vec_insn[cond][vece];
@@ -2046,8 +2045,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_rotlv_vec:
         /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
-        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], temp_vec, a2));
-        a2 = temp_vec;
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], TCG_VEC_TMP0, a2));
+        a2 = TCG_VEC_TMP0;
         /* fall through */
     case INDEX_op_rotrv_vec:
         insn = rotrv_vec_insn[vece];
-- 
2.34.1


