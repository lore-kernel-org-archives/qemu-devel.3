Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88801C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUZ-0007L3-HD; Wed, 12 Aug 2026 18:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUX-0007Iq-JN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:09 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUR-0000zT-UR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:09 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso798778a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573922; x=1787178722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iKoRvR9bnQdkcWpSiEAIwUjFioc1PQonXhV3mYvi0Qs=;
 b=DJaGsCLFgdyR2fiF1+FIDjeL8D5Cq9p44d2F+41M+z4FetonVY5uZxEsHaQFEm7u5n
 v1HVfEYR5hgTsNipsHl+VTP2AT9nj10Q4UO02SoyyOU75ySXDYYb4yhSeFH7enMWGmg2
 XruE/bBsmUo8B+iqWiNIB/82gECYf0H3oneCzofJPCrXD/lqUgErCefiSnnUu5TdZjKs
 ip2uG/YqcFnOtIJFdmZzn8UiH00bUrm6NcvHaRwDdGG2Jf0nuphPhMCTSIQu7jP2JhpE
 3CCJs+p6Q0g3jIbgEWvW8keopC0DrEk1XV+11HvO23pmCdX+fvbQWZS7CSod7WGkwTWB
 Ur8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573922; x=1787178722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iKoRvR9bnQdkcWpSiEAIwUjFioc1PQonXhV3mYvi0Qs=;
 b=I9Y0AXwbjTjhMCupzKO6s1lXI+AOFh21u7mDJbxyX+fnDC21LNUncdGEAjNafqdvCX
 Zvfeh3br9i9+xE9yW1BjslR1Sngl+II4IV40Q9/KDiDr0dDYZoEU1KcAluZStnrIEOu5
 Qh2ddU8duH2cNGhdfasv8WwydqNrcNtaqdsVW6Xcrl6VBFN92Q3WlbApkuX4srf6diQP
 jJ9WR7GpVrzk5hTY//PdtEWQSdfeg3oKgnVwhV2sgJvGoeBxs5fpYXMUjnkX94O1F4eq
 peRWN6S4FMURZ6z/1lO6KgUxSsSg/DpS9UoUbq3fFGoOkaakMFY5cZmRz8VvzBhU8oyv
 K36A==
X-Gm-Message-State: AOJu0YwaDBczBk1uSXbgiv6MTD1FkYo9m5jIKiT4a8a3HRMbsJtTs05S
 WvOtPCwamdubtJYFcxSa9waMmqf/6sUg+B+G7F6N0okoC7SN1gO4sbVPU4ZDu7cjqqGlpt0LF+9
 KCy7N
X-Gm-Gg: AR+sD10rzdcdWXaiHvLxcIU7Q4locHBTDMiQD7B3qFElIanOTmzsVfWuplxyJhRESSW
 e/leevpbdeZuZnbpZmMhEBMNbmRZIkmShrqmx7+TdSKloKneCi29KoNnRneuipcEj0/rT95HRqs
 dHKNdS7cgQyTP5d0Vd09QTBo1j2iSL2tAOerkQ3sF5AVKwUvu3upmhW4WpJz4xDk/KOVgEr/n3g
 F+mJQPm5IPDPKN/vmQQXr7FePwB8xomJrPG+LnwkradtDnZkQWxttK3KEyoK9LAD3TU5KTvK99z
 lJr2ecyjJVgGFJGXWSnIGc2I3+N+tyl/AFVWlQ9y0P7jKal4tQSX5smdWMBjA4AX7fjrmMKFKPB
 6nfSrDFHUMHKP4M+7qhbo65zZM0tUFvyIIOXP+h2TCBcCnQifz4VetJyL4CZ9ywuN+otu0sIlmR
 SHTO5G995zjGAVXdVvPUYxCdUlqFuYiJQPdp6YYmpic6NIkfc3yFj+6CSqjhNoc5rczA9ZrI8J5
 T/bJfcRBUzr2iKz8S6cVaOdDE3Jsoc=
X-Received: by 2002:a05:6a21:2e14:b0:3cc:4d86:389c with SMTP id
 adf61e73a8af0-3cc54fe4420mr2337854637.13.1786573922131; 
 Wed, 12 Aug 2026 15:32:02 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 17/52] disas/riscv: Handle c.slli imm != 0 during decode
Date: Wed, 12 Aug 2026 15:31:07 -0700
Message-ID: <20260812223142.349142-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index a8fbefb9bd..77347b557d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1930,7 +1930,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne,
       rv_op_bne },
     { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
-      rv_op_slli, rv_op_slli, rvcd_imm_nz },
+      rv_op_slli, rv_op_slli },
     { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
       rv_op_fld, rv_op_fld },
     { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
@@ -3085,7 +3085,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 2:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            op = rv_op_c_slli;
+            if (isa != rv32 || (inst & 0x1000) == 0) {
+                op = rv_op_c_slli; /* or unspecified HINT */
+            }
             break;
         case 1:
             if (isa == rv128) {
-- 
2.43.0


