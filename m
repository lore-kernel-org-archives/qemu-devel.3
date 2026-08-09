Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB58EC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7r-0000sT-LD; Sun, 09 Aug 2026 18:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7o-0000qX-UI
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:12 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7n-0007NO-HZ
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:12 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1082060a12.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314970; x=1786919770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ei9z8QWYOzgqFZRrP1moVxHgUuQmI4P7MYZL5H76+IQ=;
 b=YoPwlZtVxbkGohA4/AmBgn0qiE9PAn45ZKYkW6YF2ODF6sYXEfHz/BT0QWCwrA0kdV
 o0meZ2Il6d95mZN1navnuyRZnF6dmxujGMbZBiiaKcrv+BQWl0KDryCocnmBSS58MS2d
 PwM/idAMjtgMJY1iC+yMd6IbgnpWrB7WaslkEk3IGgkbMiyd230HKIkdRhAozM1K7QLM
 O/pQ90tkc2zWKLli+TGl0qZFXlTbJFHk7zdvJ+myv4EkP8eTrx7nt35qECwH8mWjR3r6
 Ca/oLMz4O1M7JlR3rKwpId7RV2K4J8act6wVg5q+CDYsg4BjnP/WN5Ifh4SzrSW9oAkb
 VE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314970; x=1786919770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ei9z8QWYOzgqFZRrP1moVxHgUuQmI4P7MYZL5H76+IQ=;
 b=mLvIJmIEEm9hsa+UGrL7jRFfYK89N/v4VpbPmSKz5xwS4LJZMt80PbmZrSyDTq1w/7
 GmdGkj9qroFRCuyKlaWCnj8nkQPGJxyReWHinFivA01E56dHz1bhtdLR3mRLeBgWPIoD
 fjaue+sb+CpKffNFgkRgCc3VT51xi9hRCIAQ1LBJAit2bHJlL6L8rk+kFcbNHDC6QXBu
 0F5Bi3wW6CLKKgvNMa0wOdeIGVNk9UvAUGp+Z2MiWS08gmU6Sxreuzk9JqNG6HT8ItSg
 hgMwiCHwf0Aw8/03nQnKwSCmMOGyozQTMtzQ9qucoKS4k0CFU1SBUwTOFwBnfiaxUZtZ
 aFQA==
X-Gm-Message-State: AOJu0YxNDOXuyFsfSl7aByaTKd2NUjUbAjaTduc7KOmLv0bMQ8aY37lN
 UxHtL+luH2zM2P/2zGO+8nJkVf94i5m+Z3Qgx3aCLe6iDPHkq7hODxt497IQ5m7qDy429e0Fpdo
 G+Pk+
X-Gm-Gg: AR+sD12nW5kO0bvX8U7n79I70yZiBUzysYZzGGeAJMUAtefRdAxrhG6K3bUH+4JveEF
 AMqEvyVTa+yC2PbRCeL6+q5LcrGIF2NFJ64td1DcUvjyiVMhpOOYySkeaqoXsIV9UvCBV+1Sg7/
 65zMLPXEUrfe0unSF5OAD+AwRpFATxGUpWi2vEPN7xQ06jmumTCUUAU1+330gi/qpejaJ6AQpyM
 iGBk4QBoQEQCzOmqHgoMSjZ6Q/NfHhGS6qU+wNq6CwxyIHxJY+y1DUpGGkghidetKxGlpkiHn4I
 sTq25Coamo/CifQ6U3EX53ZRh6Rz2UMa6s5FFJuhNA8Bm+D2r9XpFAHYgmGMzGnVMA0JAIAjx7A
 hMfGygsdkKzsUfzHkaiTwCTYDr6xJ5pMn1D0K81gr/jQc5NB4puwz1KJ/2JqwvQ8vR1s6fHIh18
 YB4NzKfctl/NG8mKPWdgeJtRNSrDSjo2o7DhblXHWgb0JIDuHrhKEx31wA1rPaGTW/nw2K4Zc9S
 UwYFuwQeXdiSDPOX2XW
X-Received: by 2002:a05:6a20:d508:b0:3cb:96dd:2477 with SMTP id
 adf61e73a8af0-3cbc0103ab0mr24661332637.8.1786314970016; 
 Sun, 09 Aug 2026 15:36:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 18/56] disas/riscv: Handle c.addi4spn imm != 0 during decode
Date: Sun,  9 Aug 2026 15:35:07 -0700
Message-ID: <20260809223545.730664-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9813d75feb..8a957e6a1e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1885,7 +1885,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
     { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, 0 },
     { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw,
@@ -2952,7 +2952,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
-        case 0: op = rv_op_c_addi4spn; break;
+        case 0:
+            if ((inst >> 5) & 0xff) {
+                op = rv_op_c_addi4spn;
+            }
+            break;
         case 1:
             if (isa == rv128) {
                 op = rv_op_c_lq;
-- 
2.43.0


