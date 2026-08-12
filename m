Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FCDC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUc-0007OO-Cj; Wed, 12 Aug 2026 18:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUa-0007MN-He
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUV-00011L-Jv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso2036475b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573926; x=1787178726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RNSlwPQ0drUC//N9nSDizfiBWbuHnUkEwfXS45J1WlM=;
 b=bYGkDAh5jLnrk2DYwbQFuA79CawW27h1iZb9WvFUW6Z1oF1lrSdQCiM6JCAA6QjuKu
 EvSkW8qiFqfj6xtcQr00MZj+yC7BBF74cmv+WG2iXvQEXpfyFL6sM2KSFNFG6JERtAYi
 meY90aShf4Za6yr2K3amYoWBvXnTcyhzf4PyX15MQelF/pW0V2jZWaMjlXVSlJhRnMUF
 gP7F1BrJyH5Vl0l8Aqme6Wdw1oCqO1UUrv/xsR2Ep0sYLzoReMmMEPu3rtXreUiuJzxq
 odvCAKCAT3Ld1miIMkD1Fa7GqiTvo1xBWMBh3qVdFi+aj59kniMAiOZaydFX3yaY6H9B
 I8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573926; x=1787178726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RNSlwPQ0drUC//N9nSDizfiBWbuHnUkEwfXS45J1WlM=;
 b=EBLoiP+LnSch9dRnhj5nHT9NACys2uZPSl1aYz5V5wk9mOxUwA2ahuE98w9fSZfVU3
 4+kuo5xnufehbPA4V75AADtJc3eMQrSRXQp6fxif2GdIe3JrJGeqz5y3YiXytANxZvcg
 mgf9wtVSR2b2Pa3KG/TSDOON5oNXwRB3SomeXF+CXBFn2Y9qBmMyVV+SpBaiE03PKpmD
 6utfIgipNbPwo4SvD5aO+evtSptlvVd+15TpTRTyec0JPXZT7InHeNzqrDW5jqajHDm5
 PojHGDSD3itzE4nRYr7L1IyL7Urlw/vRNt9Ky0dYngnL6jjCkXqNXh1cd06v8wGwjJPb
 XGeA==
X-Gm-Message-State: AOJu0YwIeYTbTRISkRlDImqJEQUv4kd7coATWkowROkoxA4qvXlxyG1e
 V5lQfRUZpwiu1hhZTexYSy3uJZfsDQqEguMjBTp3sxdftbVq5zE6XPcs1SYsEGZKTUmNczzyHQW
 ZrkvQ
X-Gm-Gg: AR+sD11DHMKAK7UvjNkJ4po0hF30e2aqgrvyxQbM9d0ZYxtGKW+Pelp1v5rNafzLhQb
 Gi2WCWqNpM0B/pWsn5YClNZmtSOhiA45iK6NutuiY6ZShvJgmb5ylF/7tES/L7j+/zF41QHU3aE
 JgoGR6tl3rASPXr2Gy+rV6kSs2O/4WzzqKae4sb5CdJDLyy5+IlLJbDU+UqeqiJIQoPIBRbiSA9
 X2PT+rftd3zqlqsc22qJR1f+2ax87p1mP7yOvjfjV7bAnDgSKgX6XVW8Y+FzKmWMifSJzLZvbCG
 aGbCGxhqSw2w/V/CICytehOFW9mXXhWhhpn9Yd+vW31oG2gxDgRmolUd1woRAnQvdMyfV2OyOun
 0BwqR7q5p3UVljf7v2gR6Zd2+CeTiU7/nPybo5CmBAcMGkg8eMO6JVyGZXtTVnZSU4oi4VbMBbT
 eduX3VvusFXjWbdgIFd77m04giHqd8pWT6YQWevD5vbi8O7cNC48VoaEpfdG9FtNs8TQTlfJQJU
 WH395RpQE6tE+2pSbYL
X-Received: by 2002:a05:6a00:2999:b0:848:788a:e7f9 with SMTP id
 d2e1a72fcca58-84fc6dc62cbmr1177048b3a.18.1786573926159; 
 Wed, 12 Aug 2026 15:32:06 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 21/52] disas/riscv: Drop always true branch pseudos
Date: Wed, 12 Aug 2026 15:31:11 -0700
Message-ID: <20260812223142.349142-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The real insns are blt, bge, bltu, bgeu.  Do not include
pseudos that unconditionally swap operands.  That's fine
for an assembler but not a disassembler.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2e891f509e..bde1cc6e62 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -326,10 +326,6 @@ typedef enum {
     rv_op_bgez = 295,
     rv_op_bltz = 296,
     rv_op_bgtz = 297,
-    rv_op_ble = 298,
-    rv_op_bleu = 299,
-    rv_op_bgt = 300,
-    rv_op_bgtu = 301,
     rv_op_j = 302,
     rv_op_ret = 303,
     rv_op_jr = 304,
@@ -1062,10 +1058,6 @@ static const rvc_constraint rvcc_blez[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgez[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bltz[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgtz[] = { rvc_rs1_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ble[] = { rvc_end };
-static const rvc_constraint rvcc_bleu[] = { rvc_end };
-static const rvc_constraint rvcc_bgt[] = { rvc_end };
-static const rvc_constraint rvcc_bgtu[] = { rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
 static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
@@ -1123,24 +1115,12 @@ static const rv_comp_data rvcp_bne[] = {
 static const rv_comp_data rvcp_blt[] = {
     { rv_op_bltz, rvcc_bltz },
     { rv_op_bgtz, rvcc_bgtz },
-    { rv_op_bgt, rvcc_bgt },
     { rv_op_illegal, NULL }
 };
 
 static const rv_comp_data rvcp_bge[] = {
     { rv_op_blez, rvcc_blez },
     { rv_op_bgez, rvcc_bgez },
-    { rv_op_ble, rvcc_ble },
-    { rv_op_illegal, NULL }
-};
-
-static const rv_comp_data rvcp_bltu[] = {
-    { rv_op_bgtu, rvcc_bgtu },
-    { rv_op_illegal, NULL }
-};
-
-static const rv_comp_data rvcp_bgeu[] = {
-    { rv_op_bleu, rvcc_bleu },
     { rv_op_illegal, NULL }
 };
 
@@ -1665,8 +1645,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne },
     { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt },
     { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge },
-    { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bltu },
-    { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bgeu },
+    { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
+    { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
     { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
     { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
     { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
@@ -1954,10 +1934,10 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
     { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
     { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { "ble", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bleu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bgt", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bgtu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
+    { },
+    { },
+    { },
+    { },
     { "j", rv_codec_uj, rv_fmt_offset },
     { "ret", rv_codec_i, rv_fmt_none },
     { "jr", rv_codec_i, rv_fmt_rs1 },
-- 
2.43.0


