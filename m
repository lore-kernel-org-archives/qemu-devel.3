Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD61C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbJ-00055A-H3; Mon, 24 Aug 2026 01:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaA-0003uY-3f
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:54 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNa8-0002XB-Cd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:53 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so3060676a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550651; x=1788155451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqpgx19U+U0hdUaAa6qWGdcaekLx063/m+xN5qlHCgk=;
 b=ftq42FviER8PzNfgBjMCNtbMpN2DL8/efCpHnsE2KtLCaNbIIyD/I77l4IeHnS96X1
 sQZiQeSdef/ajFIzmOBVSkZyuKDoHlfYHaFPulz/wq3KH+n+/93zdTrh0nRwBUYyyyNt
 Z660Gbu+Yn6VzHdoOmdxr+LW5N5qK64Rn/VUkG/anXKwye19V+t9SaJtdi6x2WqMWa7j
 sTthZqe0CTgeGhez0ZjVhOwvFa7WYnzCnbVLGazeMO/HbTpkoSYf/54uEGcoyjtOY0nv
 dTTLtsWpJ7igCQ+fZ9eW272zlqzE73EEIqlbmU0B3SDCt04mb+PLuCpr45jYswcnbjT4
 S/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550651; x=1788155451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqpgx19U+U0hdUaAa6qWGdcaekLx063/m+xN5qlHCgk=;
 b=GS2ozq0YnZTlsBLEYO5zEAZ8TND+mX6SySwNg30/L/YYJ1Jtp9GoXP9ssv7b+kXrp7
 j5XwQZa6IY1rIxvcr3qj1XKjahvtKqRrKr93CBpwJZ22d4CaYLxPkKOz2VaZZxJO7ZyW
 jfA6wjkEIkX5ROeX9E16KgptQa5zZvec7oFLx1jiwsGwxAKbrVV0JiDRheF//uV8KcFw
 /afAsM6rVnxgCnWJcVm0uIundYcwWG/NEkQpkmFgynHdTsq+2FI/gFzpXHSgwd49QFJ2
 rOAKeggcT4qLE31KchgzPUrR0FHM6dVF0yqzkpfBlNzyZw8kO0XVGM928hUDd75rOaM/
 Lfgw==
X-Gm-Message-State: AFuF++lRuSd40AyeA2/jE6e6oGR153rnlc7iUt4+Wd0Qxlg5/v+TJD0d
 1BMrNcAiu0kWNDig/87OZ0AQI2VixRXhhKCJSLyWBjpSaPPNlBFV92iwTCjaFw==
X-Gm-Gg: AR+sD13B5umnafpB34i9+5/vROUl14qiXjHbJ2IkWNBk+nGuF5ep/3kT8TkBz6S99SX
 js1t1QtttSjxRMArRo0xP62sVkGtI9hHuXZVE7UbeMeSoxCpmM/to1FCjYCQ1nIdVK22QbP79Qa
 bD4iYsg9nU9I6lfwFNo9oBt9rg7u73EqEf5FDLyxFCF86xG3utki88TiqkFvjtIvvxXwrq9kUOR
 isztFR/hhMS8iiRQNxXT4zdgHd4/AGgnOBQ5u7YwFHh1RyzRdJ+FfCbkrtfJjR8VymtR3CRrXa+
 5r211pyeu6N/Zcn+oEDFF1TGzlYE+pp6l0y4wHri61AVT4Cnr9m0zvHrs5HJIerg3OJ353KxDZ8
 FGmMQbV0T44yoaa3zLNWTlF+k1IrEAjY9+pbYpnQvjffBHSPBV+K3gOdXAU26vD14IFZBd6VabZ
 pGaD/5ilPTrbrkvsGACtU50Zipavs+wcnFmTrwm8WufWYBIDg4fIZUBVrxC/YhckbbVQ27x8W6B
 7gLiQ==
X-Received: by 2002:a17:90b:1b0e:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-395deec7930mr27341374a91.7.1787550651049; 
 Sun, 23 Aug 2026 22:50:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:50 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 49/96] disas/riscv: Handle c.{srli,srai} imm during decode
Date: Mon, 24 Aug 2026 15:47:19 +1000
Message-ID: <20260824054806.2790041-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Zero shift immediate to c.srli and c.srai are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
shifts rather than falling back to invalid.

On the other hand, shift immediate >= 32 with RV32 is
reserved for custom extensions, and we need to reject those
early so that the extension disassemblers get a look in.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-17-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


