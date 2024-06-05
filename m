Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9DFC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydh-0001jp-5a; Wed, 05 Jun 2024 17:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydf-0001i1-JF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydd-0003q2-PS
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso210318b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624664; x=1718229464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHPrHfS2bl/EpPIcLqOkk2z3w7jBOCEz25rHYhs/rE4=;
 b=MfpLkyXCK+myl0o+IFAA7tbCnYDQMg1FrJXOp3+5oTKlz91XsXIBagdiqEYcdM/TdB
 xlcvEmaNVR/rc1vVYtK0A4BLqKfKRzarkMSEPiybghtVExTrwm4Fq88bFYA+SMy9j+GV
 XdjjnQ0yTZskd4kV6o/ioHCJMFy//UO387uygREm7ZcEjiKuvPvpvqqposOnFTNEZatJ
 NNMk+G/fv0c59xw3uTIDa1Itqw7MAL9n4ciQl2TK6RwWxbq85A3i+4Mcqc5bLfF+ByKK
 LlDDC0acYLL+9LkzGuoykeCYnHpCazlKQ7dAAbd57/LfHpA5gFtoacowOPGSxf5Xbmv8
 bsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624664; x=1718229464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHPrHfS2bl/EpPIcLqOkk2z3w7jBOCEz25rHYhs/rE4=;
 b=OduHbanwo/8J/NGT5WtkZSkjQsW0ZrDv6K5RGQ1vxcH8/Y8BoswycA1t1+swWZ80ND
 tusvvjvJibOAZvghlS0Eir2SlzFs4+gXFUo7i6kb1HBGctBBcaZtu5Yu9rWGRB4Qq8Xn
 boCV5ypMeVlY5pRWF3P8ewGjqtZWSO31WrwlzJAWAOh35OmG2zGu5JtMrEitisTlKZZq
 8YzQ/bSE786Jt2OnwfoZ60+WfzmdgOmz6pI/okDoy4kQAR2VlB3CDU2mAhh0Iy9i/yaa
 v6f0aKBeHgIV+HKrL3WAJCvnuHH7u0uheMdDX5b1KbolkKLs9oCwi2D46u/wp9U4RGUx
 0Vzg==
X-Gm-Message-State: AOJu0YwstFM+z9FaxoRBTlpztOUSMhTQHlwFfWgdnBxEX8K0dv+YP3Qg
 M3lq7ViDBpUjvvwuo+KGwYz2USY/gLlg83xvC/0MPz9MZnUB9ZRrNWAgieCFk5PPN7Cy+ay2iEe
 Q
X-Google-Smtp-Source: AGHT+IH9ouns82OMQgyJd2RIw2lH0VAXHEAyFEjKXzWSux+vWewxR0rfmgjlUep8pH4hD4eUQWwnSQ==
X-Received: by 2002:a05:6a20:72a8:b0:1af:66aa:7fc7 with SMTP id
 adf61e73a8af0-1b2b6e2d02amr5069832637.3.1717624664064; 
 Wed, 05 Jun 2024 14:57:44 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 03/10] target/s390x: Remove pc argument to pc_to_link_into
Date: Wed,  5 Jun 2024 14:57:32 -0700
Message-Id: <20240605215739.4758-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

All callers pass s->pc_tmp.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bd4ad33802..14162769a9 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -172,8 +172,10 @@ static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
     tcg_gen_movi_i64(dest, s->base.pc_next + disp);
 }
 
-static void pc_to_link_info(TCGv_i64 out, DisasContext *s, uint64_t pc)
+static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
 {
+    uint64_t pc = s->pc_tmp;
+
     if (s->base.tb->flags & FLAG_MASK_32) {
         if (s->base.tb->flags & FLAG_MASK_64) {
             tcg_gen_movi_i64(out, pc);
@@ -1404,7 +1406,7 @@ static DisasJumpType op_ni(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
 {
-    pc_to_link_info(o->out, s, s->pc_tmp);
+    pc_to_link_info(o->out, s);
     if (o->in2) {
         return help_goto_indirect(s, o->in2);
     } else {
@@ -1417,7 +1419,7 @@ static void save_link_info(DisasContext *s, DisasOps *o)
     TCGv_i64 t;
 
     if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
-        pc_to_link_info(o->out, s, s->pc_tmp);
+        pc_to_link_info(o->out, s);
         return;
     }
     gen_op_calc_cc(s);
@@ -1474,7 +1476,7 @@ static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
     bool is_imm;
     int imm;
 
-    pc_to_link_info(o->out, s, s->pc_tmp);
+    pc_to_link_info(o->out, s);
 
     disas_jdest(s, i2, is_imm, imm, o->in2);
     disas_jcc(s, &c, 0xf);
-- 
2.34.1


