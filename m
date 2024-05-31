Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38502C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD109-0004a8-83; Fri, 31 May 2024 08:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zm-0004QY-C8
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zh-0003Ty-SW
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so10964055e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157064; x=1717761864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O9/ZiyB1WbPf8tvQ86RPlL03siKzf1MBXclSoFzmyKg=;
 b=e+dilwA5vtEEUROUd7DXDxThw/YcIcke0Ta3EsrRUVzU6sh4zhdCc4NjYAUL21qVEg
 B5+HmfNiVz1USpi6lhbaPAXsPcM4/KYc+BYn4ZXchGr+VQ5Smi55g+t2CK9mXsIXd9ff
 i+gSW+YkvdqWfFvEp6pdZIjKjqam76s5ywGDFIP/2DpIfQNNYey1+71hDtxH9pjhaXeT
 U2r4iHqFihZYqtrzedVGJTHt6KmfYdW5nILESQMVlHLmTyO2zDTLNx7I40C/NxaD8X22
 9TATGxDduFX/XoqwEH6WR0jJjXsolL4BsrqLbXHGZpUR9H8qF9uvA76cVBS/UNepoI/x
 lxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157064; x=1717761864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9/ZiyB1WbPf8tvQ86RPlL03siKzf1MBXclSoFzmyKg=;
 b=mG5MU4MoGn6UNn45J8Y9CHI2SqtJGakxnHvUXUO6XvPLyea6rtenguxYo2ivkB+pcV
 MiokZUQtnmOB68GQfYTDLbHjGR8AXI3Xn2+JoPV8szFMhZBkpTErLi0tg+PNVAgt+B0+
 mYnZsPVKb1Bykwk5bVn1Hbs9Zthfctg0o1Q5Lamj2cnqFRIH1WqCefPBb/N0IRP5ebex
 DhVfwvZ533FwrF6/sko/bPtEfvtCPDM4Kho9dXSy3qs0Axj8Ir22tVhnwBZ7TIhe1N9X
 juGSSS1OnFGTDxVE+SK/Dp4B1FWnD8t+aMivNABSkidDZKmBv944vHu0ZJPqqnEFZB1h
 BAVQ==
X-Gm-Message-State: AOJu0YxOrCHRJxkPuPHcurCy1ghylLB1+1bqeQ+afvbXdHm3TKbehK2Y
 Ny2AZNpmJ4Y6n7QdcN+qPEwCRmzQVodTTRUbkUjpPPXztpE/uI2gQmulC0uHXvHHJaGvPLDSHDz
 p
X-Google-Smtp-Source: AGHT+IFRzLVi7A1JlgUt/QKAj3SIcUOh2HOFRbl6Qta1gdaQDj//vOHR/g7uhJDhVAJTnkIDmokHTg==
X-Received: by 2002:a05:600c:3ca2:b0:418:5ef3:4a04 with SMTP id
 5b1f17b1804b1-4212ddbc898mr13721475e9.18.1717157063955; 
 Fri, 31 May 2024 05:04:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] target/arm: Convert SRHADD, URHADD to decodetree
Date: Fri, 31 May 2024 13:03:48 +0100
Message-Id: <20240531120401.394550-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-26-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b1bbcb144eb..1c448b4f7c9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -916,6 +916,8 @@ SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+SRHADD_v        0.00 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
+URHADD_v        0.10 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 40aa7a9d577..9ef5de6755c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5458,6 +5458,8 @@ TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
 TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
 TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
+TRANS(SRHADD_v, do_gvec_fn3_no64, a, gen_gvec_srhadd)
+TRANS(URHADD_v, do_gvec_fn3_no64, a, gen_gvec_urhadd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10923,7 +10925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0x2: /* SRHADD, URHADD */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10949,6 +10950,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x02: /* SRHADD, URHADD */
     case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
@@ -10968,13 +10970,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x02: /* SRHADD, URHADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urhadd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srhadd, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


