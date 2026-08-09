Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1014FC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7v-0000vi-Q6; Sun, 09 Aug 2026 18:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7s-0000tT-HX
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:16 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7q-0007Op-W6
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:16 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9fe3c9bd5fso2448418a12.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314974; x=1786919774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xm760coKQZa8W43FawVsSYkOP4r8WAQGkftWKLyAgb8=;
 b=L937cXbEJn/O2q7yZowb5h8T4Ss8tSRWAPvRt93A+f4QpI392SOACM05N4LpTrWhf8
 dssmStKHqQ4z1fXwZayxTyWbJfhxDFXtPkX5EA2a81YnPuCINwEl2XZlmYPXUnSuOc95
 wVPjvMNf5yeZLx3UartB0PZb/aQ6d8O+UedV9s66wTHUWW4zSEZBbETf+WwJeSJOUqIm
 GM8e7vbKv9fA8gKDKl2ly+eqIUmLUfaou2BcQqqek7qP419w0hkAttK2xhk5D3ppkmzz
 XhH17PkyFucxuptUTxO6WGQ4UeuXcW9DT+E3YAoPu5TZqLgLYCY38CPcZMDDWSIl1qMD
 UBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314974; x=1786919774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xm760coKQZa8W43FawVsSYkOP4r8WAQGkftWKLyAgb8=;
 b=eId5fSgtWTDOGhMke/0os5lZ31Phm5R28icRliTkEnkGK4XXy/0U5qvPk4Mi3owiy8
 DRuwQFI0qbmbkYHUnDAiYoBWRVp7rtUyH+99RspeFOTEVE+EnEFLVPyD7AoAjs+bZsLt
 C6npDm/D+CIpomWWhXcYTZINiteQGaYIoEGbdTi3esQQoXG70qD7EWMHk++f+RJjFtw7
 2CZ3Qs3JBfwcoPXX+3kt7w1oR/xprPSNNm1BBCLF2ptAr+0ADKTbxOtXZK+unaLnMDgj
 PgwUX41aVxUvlfYOCRBswnrqOWpTX2i4saP2g+Zg9ez751yFKdPvnX4SxPPCSb4Gnhbb
 GpQg==
X-Gm-Message-State: AOJu0YxPyU2rMj8xvBSFIJ4Qk2PUWLixWNMLIUM/6Ww6A51Yohjy8xEn
 lUEcP0XIaPYtT3ufjvoXpf5AMdD5nNyfqx8lOr5ZBXBsldiiOOwcC0bUOoxuSIbcSdojTyj5dp6
 vPF+/
X-Gm-Gg: AR+sD11nbL+Ve7RoTDlsq9KEqs7EPnspdkFrDQPhrIU5W/kNFdWF71qxhd6pbNhuAie
 YIVe6PjR1ASNz1FvgzgyZ4UrcNRxHLhPTuKTTTb/JX/6xv6GE9fLIFehjKL1KpgxnMucc4ZLSs7
 CGiT280JtD6OnGTsnPcs34qyNhoXWajrE2GgJk/vwZpKJErdnmjz4eKdjJ/cWeEl0ofoP0cM33I
 4f9Z9MOHhBBdqx+um5bv/czvPuKzZ3q2qPYMZQ4EgPBKdd1HVPs0b7+zltR52ohVLM7Z1fRkhRv
 0r5GOMSeOv3D0K3lSw2J+DtiLb6Wu2rA0b2TP/qsv91VAW7Fm4rgYggex3q6x4jCwWZOCA5q96G
 C4MsVsBoUusel/C/QkiMszFkELgU79BkPJWdBibaUP5Cwwit8xRhVR0tFBC4RKHB+cyt09pirTP
 w8XCjrYUtbBox1wWVy+vZ4vgkw13tElESM+JEHXajH6B8kY05eP0liIvH44LlZ0XKMpOYT3FQGl
 nu5F/UlZ1xiOfK78QPtc2p6oaD7O+k=
X-Received: by 2002:a05:6a20:9398:b0:3bf:8de9:c64e with SMTP id
 adf61e73a8af0-3cbd373a437mr15050626637.2.1786314973586; 
 Sun, 09 Aug 2026 15:36:13 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 21/56] disas/riscv: Handle c.{srli,srai} imm during decode
Date: Sun,  9 Aug 2026 15:35:10 -0700
Message-ID: <20260809223545.730664-22-richard.henderson@linaro.org>
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

Zero shift immediate to c.srli and c.srai are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
shifts rather than falling back to invalid.

On the other hand, shift immediate >= 32 with RV32 is
reserved for custom extensions, and we need to reject those
early so that the extension disassemblers get a look in.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d6fbb3bca6..a8fbefb9bd 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1906,9 +1906,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
       rv_op_lui },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
-      rv_op_srli, rv_op_srli, rvcd_imm_nz },
+      rv_op_srli, rv_op_srli },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
-      rv_op_srai, rv_op_srai, rvcd_imm_nz },
+      rv_op_srai, rv_op_srai },
     { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
       rv_op_andi, rv_op_andi },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub,
@@ -3042,10 +3042,16 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 4:
             switch ((inst >> 10) & 0b11) {
             case 0:
-                op = rv_op_c_srli;
+                /* For rv32, shamt[5]=1 is designated for custom extensions. */
+                if (isa != rv32 || (inst & 0x1000) == 0) {
+                    op = rv_op_c_srli; /* or unspecified HINT */
+                }
                 break;
             case 1:
-                op = rv_op_c_srai;
+                /* For rv32, shamt[5]=1 is designated for custom extensions. */
+                if (isa != rv32 || (inst & 0x1000) == 0) {
+                    op = rv_op_c_srai; /* or unspecified HINT */
+                }
                 break;
             case 2: op = rv_op_c_andi; break;
             case 3:
-- 
2.43.0


