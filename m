Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC2FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbs-0006Me-6T; Wed, 17 Jul 2024 22:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbq-0006GK-GG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbo-0003Sv-Fx
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-75cda3719efso147107a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268662; x=1721873462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2m+czU4JRjBz43qF9mO7kaQHS4v+U0MLfaQ9CySHtM=;
 b=QMwIj1Q/Gj5PNV+XX/WtVmV2z2saTP4dAondmpZXlE/m9WYXgT64Ckw7QpSvAtBC01
 0w3UUGxtdKVXEVUsA53ZBi+cDJn0BlxZagiqyLwQ5z+jvadYhzzRiJf6c07qkBK1w9+O
 zMpit6K+flUL+WuSnuQ01+ouRNca200xJ+VSnb4qqgakD9cXlBO7e5VwLh+umILbtgmV
 waSIIMKgu19Ha352dvrTkycDXt6LUHOcFno6aYdzhm2apx+NyCMOg76/R/Dcur5q5UlP
 iTbsIMMEjaLmgbVJbQmzLs1YkK0QGXhcctMtuv6LoRebmeXxIrjJmlqduOi8k/SJd91C
 qL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268662; x=1721873462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2m+czU4JRjBz43qF9mO7kaQHS4v+U0MLfaQ9CySHtM=;
 b=Zf4zxN/VP6QNrDaNwlwn5wWLxVEjTJbceVpbl6t0zXjM/LWwtFER398w7vHIsOxraJ
 jfQKPYWzBY59BeCYAOptyKxH/jmISndjOjgO2Ju4tR8TAjGs235okICetJNKitXaNbL6
 /dooRNWlrWfVCee0O49lMQErDu6uH3+1/pWyhuiKPa41k+Dg1HfB/rivWViHr86r8tHJ
 pYvzq0UbeoVjPZyuFntEYbIuCfouxuMAlP/Upw9d4eMethnylnr9UgnC5CvtMLey8WXB
 XpRD76ipQmwxvNPCyWfIxG9MNcju1V1aCjlRsTlhyf+ItM4CDCq1WXeyHdxDnoDKYVj+
 hbJA==
X-Gm-Message-State: AOJu0Yx218/oYl0xn1K/hzlxRZJ5zwIilqbxzYvsCaHor6BvTxOao1Lf
 YWn1EZki9gdERgdGoOUcip+c6NyLPh9xXm45mbVYI3IcM748217+27p4Gdqk
X-Google-Smtp-Source: AGHT+IFrcyD3a5Piu4BrPRs/gSENPdgmDVzcUgWUNgy46behLyjTw5jfbvxPyH5aQuUMTqfky749HQ==
X-Received: by 2002:a05:6a20:1584:b0:1c0:f23c:28a7 with SMTP id
 adf61e73a8af0-1c3fdd3bde8mr4326293637.44.1721268662358; 
 Wed, 17 Jul 2024 19:11:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Balaji Ravikumar <bravikumar@rivosinc.com>,
 Rob Bradford <rbradford@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/30] disas/riscv: Add decode for Zawrs extension
Date: Thu, 18 Jul 2024 12:09:55 +1000
Message-ID: <20240718021012.2057986-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Balaji Ravikumar <bravikumar@rivosinc.com>

Add disassembly support for these instructions from Zawrs:

* wrs.sto
* wrs.nto

Signed-off-by: Balaji Ravikumar <bravikumar@rivosinc.com>
Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240705165316.127494-1-rbradford@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index c8364c2b07..5965574d87 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -974,6 +974,8 @@ typedef enum {
     rv_op_amomaxu_h = 943,
     rv_op_amocas_b  = 944,
     rv_op_amocas_h  = 945,
+    rv_op_wrs_sto = 946,
+    rv_op_wrs_nto = 947,
 } rv_op;
 
 /* register names */
@@ -2232,6 +2234,8 @@ const rv_opcode_data rvi_opcode_data[] = {
     { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
     { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
+    { "wrs.sto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
+    { "wrs.nto", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3980,6 +3984,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 0: op = rv_op_ecall; break;
                     case 32: op = rv_op_ebreak; break;
                     case 64: op = rv_op_uret; break;
+                    case 416: op = rv_op_wrs_nto; break;
+                    case 928: op = rv_op_wrs_sto; break;
                     }
                     break;
                 case 256:
-- 
2.45.2


