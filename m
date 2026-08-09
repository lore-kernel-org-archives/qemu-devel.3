Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22787C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC8B-0001IT-C6; Sun, 09 Aug 2026 18:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC8A-0001H3-2L
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:34 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC88-0007Vg-FI
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:33 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso671904a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314991; x=1786919791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1B1clRZ2sxLvuLYBilMUBWv+75W8rJPRUtukNd1MOmM=;
 b=K5/RsD3BWTdc/FPXPi6qxtO3s/4a2R9RZBoPqOm9xhs4IhUMKSKDVirCLPnzQbdNE1
 BB7uGm7dWmFp9Z37HYEVXwsyJzYqbPoO3uWQLbCcrgpkrqFU0/ZtJ+s5qT6qpxk2YJqc
 eVPMYK2sf9GAqZcd5509ro0O7J4rAb5HzgjlbOWBtoUYYyDdt1AZK7A4VX+wecxZVjY3
 xlr7mqAQZRbDYScVSxNJzHbqRiyGX/uO/ASB7v/E9Qc8SN+3LSd2oozEdGmtedkLvvxj
 yCYp0Fiz60h4PNPJzzIX/nn1j+0XAgszaaEKK+22MHaDXXt8P9Y84Mr6exLrI36dMSOb
 opKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314991; x=1786919791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1B1clRZ2sxLvuLYBilMUBWv+75W8rJPRUtukNd1MOmM=;
 b=EgC3yEryFFlBdZHn/h8rvzILfxHD3k2VnU2W2gvPRHlRDaSOtYwYONyZtrEHRFwIlB
 IQZfhLcnAAjDyYjuzx4DaFCQp6SKJbf5teSne+LcRzpXVro5EhVtEsZnLSEr/nanByJd
 qPZhjLQeH5okAfszUu2nLRYM/p1sseOaQdZtzfCQk3TGNKapBi0y6desLgBtAMgpb0uM
 eRXnTtIU0Xy+07RpBRgOQ/Y3cTfi6kQA/0TMqPXJDIuHFvLYsBRVCJ9tSnle97lwWLrh
 X+SCTSyRJfSH7cjEO5s6mEGDxt2tIhW5G1IojpdfI2rFCjMZuG3JLAiabzI0OPl88y4j
 RFTA==
X-Gm-Message-State: AOJu0YxUtM30Wn+JrvWLmFfw3ATh/Rz+NRR4Giom+bJJrf367MK5ugBV
 7Hb4DmxRudGvKmU6K49PYm0SO0UY+x5c7e/tsaCQ0PzTd/PWoxqtCAxTmOyj/x1GP9iZDZVmlhW
 O8Baz
X-Gm-Gg: AR+sD10H6n5N5hQzdjheayhRlGxITgptqw+/DWFsVAeI/hdj+tFVO+iA5UfgpRCRjO2
 j3daDqk+qOzwC2Rt2O1eFsh0MbL+vKR3cGG9LS5pQ3WieSVciSIFXgCPNKyweqVOynqZoa7NWAj
 alk2DTL6fEDbU1Qpg7hiFDCep/Fq4nj9ic/vDCrfVmA4+vo4NsNsNTNJMxTUept+z5Y7Gn85QLo
 VjLww7h0H00pJzA8rsGHLeF7qMv0EV8vApaPvKld4zariHCKJp4NmiplaTr75zw4eViWfgDOFSr
 RjVtdxMSEnziQGRoyAPRaXXK8Bq9e9CYUs7DGN5w0r2KKnvuzQZz3fGR3x7INcpsc7t5Br7pLL8
 vJB8qDU8oyXhoS8QKAHMj9fPzE8ONGlQqihrDzjyxugX0gNvDB8RZhZX/6uVvnOLEKBsjBGA9fm
 /SvxYBB4pD11WxqYfL+OP16A+SPBqrUolmkjQHgNCRl5eUT6e6gPzMJqaAjPh7Oy92iRG15rTqj
 d41aawpTJl7GKA75PQI
X-Received: by 2002:a05:6a00:3305:b0:845:eb88:3d74 with SMTP id
 d2e1a72fcca58-84f2e06b682mr45239468b3a.29.1786314991010; 
 Sun, 09 Aug 2026 15:36:31 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 36/56] disas/riscv: Chain "nop" pseudo off "mv" pseudo
Date: Sun,  9 Aug 2026 15:35:25 -0700
Message-ID: <20260809223545.730664-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

"mv" has already checked a condition that applies to "nop".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2fec135b5f..37f6440831 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1035,7 +1035,7 @@ static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
                                                rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
-                                           rvc_imm_eq_zero, rvc_end };
+                                           rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
 static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
@@ -1108,11 +1108,15 @@ static const rv_comp_data rvcp_bge[] = {
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
     { },
 };
 
+static const rv_comp_data rvcp_mv[] = {
+    { rv_op_nop, rvcc_nop },
+    { },
+};
+
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
     { },
@@ -1869,7 +1873,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
     { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
-    { "mv", rv_codec_i, rv_fmt_rd_rs1 },
+    { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
     { "neg", rv_codec_r, rv_fmt_rd_rs2 },
     { "negw", rv_codec_r, rv_fmt_rd_rs2 },
-- 
2.43.0


