Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DD1C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC85-00016K-Ad; Sun, 09 Aug 2026 18:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC83-00014l-Op
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:27 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC81-0007Sh-GZ
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:27 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so738180a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314984; x=1786919784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSh1lfI0jX+r6FX1tpaxG4Gr8KvWJHl1oy8OeMmCwtY=;
 b=AgDKbotfSZP7HoeSk+5e3DGtFeIoSI6aJ0uZoiXBKR0kiG+EJSDLTlNiYdTT1WnCce
 8uAF8XJMt8ykQb0ouS69IV0rR/jto4p12QC5JsmBt5KpzVHhwVB7+B8aD/f9OftLldq6
 mFCjfenAm60Y80l95m8dPbzrlWEADhoYQRKsujOymtwxRMQOHzjBUifhOGwQgP3TXeWL
 RlKnBp8CAq4eG5I7llwz8aZXj6WbjBkD+4cPW1euSDXw1XUJ4Ud2rkxWrdWwNHIJpz6W
 FZDJVxvfuGZxrWsYogDvzeZBYaY9VXHOU09K2ibgyu39EswybZTla/pqaR5ngqmdKrwo
 8Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314984; x=1786919784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSh1lfI0jX+r6FX1tpaxG4Gr8KvWJHl1oy8OeMmCwtY=;
 b=qKoEGbyzu1yqMSRKFc4sXDVfDVVDhiAthnvA3X0YEL4WHum6VUY4e3MfvjNJqPfMmG
 nl7VD6pyyR+/dUr3rAcpwstnW81+Sv00Y8iHXku2YvbSt5Fu+SSCroxn2gkNmtjFWPc2
 0RaAwad8vl1kSbUb6nIULpSox7FYsMj5ji5hOcVzt8oPGTKf6olD3g17GTQPcpEXkKAQ
 QqCKQJOMI4ZSp7JFyk86noiuA+v+K72PZ5wqBKkBcKYMlPSuWfbneyYH9Eiv91f7NM+0
 ilbx8nfi8bUmu+8AWBPKvUhQvcFNasgP0eT4zOUdSs59SZWAV3bT5Udp+Lt1dADOgeXm
 0v2Q==
X-Gm-Message-State: AOJu0YwtAhBtrdlCkVJ8y9StKxx6UB8NczCo4isinF8vvwVCQ+Ay5lJo
 oApj5FTgglWEgABQ8bFpg99Hq+19/ezTkqZGMiA0hvERAfQD5m3lwg6yVb1h0e7Y0eUf7v3sEkw
 ikEj7
X-Gm-Gg: AR+sD12FdXBT3A87r0cKA1hl+QZ5qrlN/JPEMpyOYCo2N5M2yL15Rb7JkQo3+CuGnE7
 HGQMbSyBCT/qqRy/CrB4uZ9x9SFSZpPY3zqLSEqPHNOpGFwwc0u0WKGFSEtBs2g7HrUm12h/aA5
 x3F3MGTALUV/v+jLGjDRx8woPx7LM8mdFn6QvRVraI4T7bbLMo9G1AQQ8WRrWOVDCMizlrDLEoM
 8JUV98Iu2tfui6jPC0HpRjcUdctBfPi/cDddEtv+8wy/fkqYzbk2v/eIhhib+e3laLKRrqdxKjH
 ugPNusNzLh4S0eSrS+Z0ZECsnIB/xFpe5/Pv4Ca7sCyulkHGZaakRlEA9K/7+uW6TTuycXTM2VG
 9ZxcPKFWYhQt5I53ONXFADUIfkyeCPoPn3/c8DdTCzhoxSW0Iy4rmDwXETPJBwxvEhLgLWJ9DOn
 Y9QFOzvqW9YsHNhMmT/CvqXBZ13bRBrh9lFcVMDRLbYPjXnPlU2DTudR8e3SghtejyiDIg4CmKa
 GqAk4u00O1MUDprMMz6
X-Received: by 2002:a05:6a21:4d8f:b0:3bf:651d:fee0 with SMTP id
 adf61e73a8af0-3cbd3a9bbaemr15063620637.19.1786314983897; 
 Sun, 09 Aug 2026 15:36:23 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 30/56] disas/riscv: Break pseudo loop for jal and jalr
Date: Sun,  9 Aug 2026 15:35:19 -0700
Message-ID: <20260809223545.730664-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

These were clearly intending to simplify
	jal	ra, foo
to
	jal	foo
and similarly for jalr, but the pseudo expansion looped
back to the original jal/jalr with the full format.

Add new opcode expansions dropping the implied ra.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d3cbfb86ac..fe503b6cae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -326,6 +326,8 @@ typedef enum {
     rv_op_bgez = 295,
     rv_op_bltz = 296,
     rv_op_bgtz = 297,
+    rv_op_jal_ra = 298,
+    rv_op_jalr_ra = 299,
     rv_op_j = 302,
     rv_op_ret = 303,
     rv_op_jr = 304,
@@ -1029,9 +1031,9 @@ static const char rv_fli_name_const[32][9] =
 
 /* pseudo-instruction constraints */
 
-static const rvc_constraint rvcc_jal[] = { rvc_rd_eq_ra, rvc_end };
-static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
-                                            rvc_end };
+static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
+static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
+                                               rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
                                            rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
@@ -1068,14 +1070,14 @@ static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
 
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
-    { rv_op_jal, rvcc_jal },
+    { rv_op_jal_ra, rvcc_jal_ra },
     { rv_op_illegal, NULL }
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
-    { rv_op_jalr, rvcc_jalr },
+    { rv_op_jalr_ra, rvcc_jalr_ra },
     { rv_op_illegal, NULL }
 };
 
@@ -1884,8 +1886,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
     { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
     { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { },
-    { },
+    { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal_ra */
+    { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_ra */
     { },
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
-- 
2.43.0


