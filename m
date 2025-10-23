Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE97CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjX-0000ko-9T; Thu, 23 Oct 2025 00:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjV-0000kg-Ti
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjU-0007L4-7f
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:25 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7a213c3c3f5so508988b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192922; x=1761797722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qtmy91JEQYqJR/91H8B/Uh3Fg5s9NSfMz+Wbznv9/ps=;
 b=OJYHYfXb3Uz66OhDudcvm7RReJY9HTQ1ucjJWq7iuyh8GSrBPRTEbQuMXV5VU9Hp1d
 4Az4FK4Ky6MMtwMgb6yOKXUJVHYSWSS/hTUZKdY4++X1fV0W2BPBsewE2kv+PT48dEfQ
 53dQVOeG3h7aVPqMMtEvWSD7Rku8OP8YoPoMShMcXEl4ojAOGZ6zanzLTv77MsoAK/DC
 emggynNqsRse9ghvQUGNx37Ix+pD+tRlgeDRiV+JdBaub9GLhgi3vXdfjS2qIvCJP3h5
 HMOLvAbj4vHMbp5P9sbFs2pgvgUjDuFnYZ1Eb0nJVA0Z4pgwmO4oIhlzU3IDm35pPxsB
 xKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192922; x=1761797722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qtmy91JEQYqJR/91H8B/Uh3Fg5s9NSfMz+Wbznv9/ps=;
 b=laPpXpibhf6bj6yz2oSUxNjfUTVP4VCT1VtKxcdRtlIpt7Kyr5jlvR60tElQiMibci
 8rW5/mgn5SW9bgYFdBLuROT/A4JBw6E0fESTUSttboSb6/SkQ/pxn2Yb7aDnVoSJc7HI
 J5DFw0gQCpqkXiYLXMBZiHdAn/bn/+BU2pvPn9LLTtMhAN6iag3KNmC/Ya2afS1B064E
 TyaBNJzKj7E4nptP4mMKnUs2QLLDVfoIg8JsZ0bzaZZoOlaolUj/2nm75TgdDrzFRsrG
 sJFSUk/O3dXxAtlp1oJ7npLyDfauwMctrnQikejTpI/OtXuGgbHjEfEFnCyiZ48WoahQ
 JIXQ==
X-Gm-Message-State: AOJu0YyRIHY2AqWEjsv57MQFLorriKImR7atnGZrWd3x5YgKZQppXLbS
 r9538mQuUi/8bS+Pth2oWaIRy9ndB2tfXFz5sFdthq2rx/cNe5mEADk6ilA15A==
X-Gm-Gg: ASbGnctn6fJyMlJSp84CKBl5VGPsgBujOknJY/MptjnK//tmVVcQqJeNTJI2W9hgpOl
 EK4WFNX3j/3cQ210teA5kzqmdA0d3M3kxN9ZPmpfhbnheJfAFWMY9Q8YOuaoO2dhlwwOEiMo99u
 rP0Z1fzdTI5koLv8t07aK9nwwHBSUdJTD3OFYPf2H99H/VOxih8mdQjsfi9ol6W+yAv3+UxDs2N
 h1gXbZ6x3dm56x13PBNDpMnh4Vf9hZQHUaBGeN4zu2R1Lpx1Iw6tASAHIlANauzsz/UvXEOdMYY
 LUELjMITOFO3JIH+6nAObSnk5J4OVp4SEIcqD/WhFPy2Hr0ik+SpMWZ/3EEl1dMY6iHsv9v4YOA
 SCYGPB+G7OK+4TwspZF8DntDZxm+K+zDSLiG9luxWihuqOiK+NJqfs/A6la81DMCQcfvWuQdlcz
 gBcwnoFAxA6wg3gG1iePJXoaMKzMDN055CxaArU8vFSaTdRk+pdfI8VTx8hw+/B3sOww3Y5kakv
 rBu5qNF42S3YSOpWmJD
X-Google-Smtp-Source: AGHT+IECpKQE8w51GduVho3udAeYG7AFWVYab9MkejxOqda8SGfwHd68csg0Zwtqr/a5dMHi3fYp5Q==
X-Received: by 2002:a05:6a00:178b:b0:79a:8a6d:c082 with SMTP id
 d2e1a72fcca58-7a220d40c57mr23176690b3a.23.1761192922118; 
 Wed, 22 Oct 2025 21:15:22 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/37] target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() /
 gen_sc()
Date: Thu, 23 Oct 2025 14:14:08 +1000
Message-ID: <20251023041435.1775208-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_lr() / gen_sc() set the MO_TE and MO_ALIGN flags.
Set them once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-11-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index e0fbfafdde..8737e8d60d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -34,6 +34,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1;
 
+    mop |= MO_ALIGN;
+    mop |= MO_TE;
+
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     if (a->rl) {
@@ -61,6 +64,9 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
 
+    mop |= MO_ALIGN;
+    mop |= MO_TE;
+
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
@@ -99,13 +105,13 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_lr(ctx, a, MO_SL);
 }
 
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_sc(ctx, a, MO_SL);
 }
 
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
@@ -166,14 +172,14 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
+    return gen_lr(ctx, a, MO_UQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_sc(ctx, a, MO_UQ);
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
-- 
2.51.0


