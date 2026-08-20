Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4351EC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkk-0004J1-5e; Wed, 19 Aug 2026 23:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkG-0003gB-B6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkE-00049A-4g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso1835752a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197629; x=1787802429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/dfTpCPKeINTMs5DuO+JXEx9y5VLl487hSHIWrRqxGo=;
 b=mP5EP/PF81zuJvu2KZBfYEic8b2AxgGNbuhIdgVSq0xxyvwgoWp25OM4jm/jfrPjhr
 T2e3pTcpEwZxeEQ6GZZodpR9qrPfSD3NhIWi8ZtH099qJzzA6Lz/Y/OG5ekMt0v98tBD
 slX2qJq4lI8gHpwtCtZlu5nU2D/1gfxye9OPftH6iEZP23HQOXKPfl+GVIHcGV7ZZijv
 h3bzWnt8pFFQSPlac7BbR4fcIPHASC2mOXza5KCWB+EUtFD2lHWuiuGMAojexPTfVRN1
 FiJmiE81uDsSZh7vc6uXZvvjF7Wqu2bmG/7Ut0wlnQjqLpcLcUgtAtoF4E+F+3kO/2PP
 faFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197629; x=1787802429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/dfTpCPKeINTMs5DuO+JXEx9y5VLl487hSHIWrRqxGo=;
 b=chRTnvqlnxYixd+rRbIZaL0TN/RjWKkdRkh3Y9OKiJH1X5eiCVbL65bIIwcuy09PSr
 6vpCMy023KUMG1urBqveq60+nTjQEJomNUATP/1FQuz51z3dg2Qf+bIyd8ijUi0nqKtg
 C6bjoFk5DJ5jYgHalrl8ciQ2Xd1m7UdcFZSJKbdwfAQrfU2GhiEDPq8AqpUrAt5em6gT
 MlyrRpSi8AMNdQSwQqFDIERYiQcIx9V3nSrqhM9k74oeDhiIbtfUHFTloaNkhrliIi0Q
 BTq2t2Th7IKFiigXqNCxwosgjOa+Q69A+CyYZevs6MhZnCawoVoSTmAaumV45nlPDag7
 /FLQ==
X-Gm-Message-State: AFuF++mVcXVhJdeVB+lqYCEmGk8r+fb+8bePM4FLewq+71k2DhXLNWFz
 LaIczCyPtv768dimbJC6GAwu5NdXWaZ+oum7SC+P6awMr9Z+0erQDcjygbXjnQ==
X-Gm-Gg: AR+sD10JWqa51AaSd8MI+Gyk5KiWpLnbxbumGsEqSfEpmsoOrxnsS7YAD3YQ6oIFy3G
 LwUc9etTOW7LbVVq3IEo6fxZZGWRHpoJL6YYDZwAw6tj08pUpKu9pzShCsfGcfYLt7WTAiNMtLR
 AJVgp7toz5PvDKGYsiiO99ymYR9j/LAf+Hpg1/TIt/M8tht1wF1JujfVVXwKfvKGsdNJlxlclNa
 ICEjhf0KwEaAXcMeHbwZl50mnk3NK1sLci0UIdBcBiVTjKmOXvoZdc2MnwoD2CbpXfQmYRFgwDc
 L1wDeLlZKAWQ7dkacWRyDkJZ8m0eahIQYPrpabZlxxRPJcn7XGtyHv/qUHyweQPWaQZ3KraeaKr
 6//IpnKB+TCSYKDSEjvXLxXRP80UTmRXhwfWwi/ry1WbI38GV9zRQqfAkbJfR4onx5n2q1JFQ3T
 L/xWxPNofLE+KlekvnwDIVlocDIzBS8BqhO8yjyPLy7sBm/bCl6pd54wYibZ76jBH9dpYk3Aa2B
 DANc5P7+FwejAt4
X-Received: by 2002:a17:90b:4a05:b0:37f:c22a:c188 with SMTP id
 98e67ed59e1d1-39580a80a65mr17774606a91.4.1787197628905; 
 Wed, 19 Aug 2026 20:47:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/93] disas/riscv: Handle c.addi4spn imm != 0 during decode
Date: Thu, 20 Aug 2026 13:43:46 +1000
Message-ID: <20260820034430.1186695-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-14-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


