Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D39C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbQ-0005IS-VE; Mon, 24 Aug 2026 01:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNan-0004TY-5L
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:33 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaX-0002ch-6H
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so3060981a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550676; x=1788155476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9sf58UgizOO2O3vOdLTpSVW7MW2OkpGmmaGS8aJxPcE=;
 b=m9ZMGNpWGm+QR7wq8Ij9FVdGfDuugLS7/qmYNjWEEropk0jrH4wOL+7BaG0dtwSjXK
 VCba4MNOWvAWSruXyJtslh18WT9CypWTumqpzFKISs7KztiOYuyq2Pc1Asl65tTggRCZ
 /bnJv5Ek3iW0gZVpxZvNLzRMZeJg92/0300XwgUP3XCsmOt1bilOzWuiUy1Ifl5OpS/j
 X2Snfjzx/S/wpqcXJDcTOeJ34yveIPsQR6xdeNLms7TPrdBrgJZaG/Fk7/R8b88BwhY9
 KK3zb9Vzdl1PhUOYlavnz0eJXRYIWp301hPyDpo8hNm/vf2t9wAA720oLL7DWTGdet/y
 1CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550676; x=1788155476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9sf58UgizOO2O3vOdLTpSVW7MW2OkpGmmaGS8aJxPcE=;
 b=ejcdGpavT2ioJyZH6GTdx/6KnXdR+peuOJ7m2KEI9fwgPJjs2JJBHPycDdBz2Y/ZOF
 /gQ0syJ0DXODX3AGBQXi2RlNXovW1agcIvc65pKWPcdDWJ/xsWHUnzk0H65KFZxg8VMI
 A0JiuZ7dsCMzXCJf/BUvCorTEEoTWY6o7s1s9TxtK4rr2kxMs5IHzqrlXsYxSYqYbBSP
 qhpSOKZXLKnAERVfaPK2dXkgwYIG1oQGMpZBUjqEndNVFGN2JCwg/lisML/sGDVv7Tji
 RinCFeKKrqG8PpxPdt0I0IYzg3PqaJJeQZt0cMsHTLa9CGUymezTdZPVdQvPbEFeeD1x
 aizw==
X-Gm-Message-State: AFuF++lTbPWSD+y+lsukdXuXT1QVTFzd7Dql9aZQXuejCAFAhrETpKgp
 91r8A3bnGbhjo0Uihf58W9UmQ1qAMbDh2cNS7r0TckMjWYyzxq8dgxrOCeKkgw==
X-Gm-Gg: AR+sD13EK0Cm/ZA+AJNaTC2YlV+PbkXRJd2T6eqK6+WPDXiMLWljP+GGF5rcJX4sKWS
 2/H6LkxZfl0Ew3vC6Pm3PvdRbVCRhjZptwKgOzQpiAtgNBRWf8Q1ofQri/UciMnRbNcKi8NkZyM
 B19ZRHAgPmvr+yg5msMsAz2ug5JXPfaIBgyWcmI6kextEkqzQf4PH9SdCbwFA86ohgqhKft/ZVD
 qWLirXlN36KTXG8brUjVCJmLQlqGYIEUNZncpuCUvNqQCZnZ9hsMOZ9FJHNQ1fVd+G9udB7JA7l
 YsqSAbLrntPDCAUUgDCHBkAprPPmYKtc/YlzOgU5232aY/cphs55gSoI0h2FYxy3fDgVNLBTyio
 b9zvxZa0OGW+1Gdq3k3MH0BBa+EbmxeIGZE8zTSD8juas6kETZ5qS9BJhOBxMoocYy5qP/a1oYq
 KuOLnYxj/tIcxJOwBEmrPzwZYQaSxYK3RtWBlG5iiCZaQv7PxbWI+bAw++3QLs3k3ctbkdbS7eR
 mbM1qHVMdh5GKAq
X-Received: by 2002:a17:90a:d404:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-395decde369mr29797690a91.0.1787550675673; 
 Sun, 23 Aug 2026 22:51:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 58/96] disas/riscv: Break pseudo loop for jal and jalr
Date: Mon, 24 Aug 2026 15:47:28 +1000
Message-ID: <20260824054806.2790041-59-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

These were clearly intending to simplify
	jal	ra, foo
to
	jal	foo
and similarly for jalr, but the pseudo expansion looped
back to the original jal/jalr with the full format.

Add new opcode expansions dropping the implied ra.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-26-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


