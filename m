Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0006C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYb-00083a-4Q; Thu, 23 May 2024 19:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYX-0007pl-SC; Thu, 23 May 2024 19:09:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYW-0005kx-4y; Thu, 23 May 2024 19:09:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6bddf57f6so3423261b3a.0; 
 Thu, 23 May 2024 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505742; x=1717110542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTBsxieFnP6H1LC24Dq0DwZTt7yPI0ZXaUq+86G8NVQ=;
 b=K6FMdeIbz+2hMaG7G8S9gRV9wkwEIAL9Nm2YBdb4Sj0HC8OtLCDgZDJFpsfLW3qbKB
 4dnLE2l4PTtTwWVT1HjptEa6ByMsE+HAXpzhmd5MZXN1FISdLn1nlcjKsgMtG71BSpYN
 clsbId+GlV7a9aR44wiNpFBi+KQiAbfncRqCKSU7JT1qx3HRy5OobhPp7UQTLSZ7Zoby
 9eXNTLne1LbxrAI5vs9IDdSz2dXcD2r7uvfsFQzP/xiyNiKHsYpapGxVoUnOY9jXEo9D
 ewfvffc6H6C7u8zRU5rxPq7vOhv5/my//k/tvKxqqKXtAUcSPgNy85BM2FsG9Lkovwje
 mfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505742; x=1717110542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTBsxieFnP6H1LC24Dq0DwZTt7yPI0ZXaUq+86G8NVQ=;
 b=qpqdRw8MQEmnTVjh3K3kA0RMoVNlg7RDY+enNn2u0G7TXipmcRYUcF48x8VfHv7FxE
 JJa1jMe8Tnw305bX98cIlUwf5MfZTuABZMu/sHUA88FEtzqRc+7IX4JcaocOBD9VbWrE
 +xbF6sbVBIwJiC+6r0cKOKh+2g1wZ8e3zgjPpjUZOq3nR81ZGYJn4nARao9GKXB/8Mj1
 44wo7oc6vuP6s+ATPA+RVIjQ/QEjvLhRbNI+5o5hA0nfnNPmb13IFMNyDPynOYmfLLAz
 rcHCDmb46BcLl2ZnHfShQi5y/SmeKj8QOd8S4Hw3w+ly2utOPr8l5alhkYoGpo2d4xoM
 37cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX9nv0oVGfPliLxSSjpmasvhlUMsclRtjnRGJnJ/EeaBaRJNAyjcniAtSGuk49MTlu9/ODhl2qYkP8vsf+nMhoMJWL
X-Gm-Message-State: AOJu0Yw7RuDFf5EWJKKYmwe0r4CtR1eOvISXLDUG+EpaWxYYEbsStPYc
 8Ou2swL7d2p4nJvaK81RUMi5+Ciiw429DJO3LZy4LSvl1PCv5cBeDEllbw==
X-Google-Smtp-Source: AGHT+IHnLNMTuNwmVNKb3zPvpLunQaM7/NIlCUPEz2XkKK5y2QtSH9+fVYf3otKfzMvSxYA/zKX7Qg==
X-Received: by 2002:a05:6a00:2786:b0:6ed:cbe2:3bc8 with SMTP id
 d2e1a72fcca58-6f8f3f9082emr694025b3a.22.1716505742018; 
 Thu, 23 May 2024 16:09:02 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/72] target/ppc: Move VMX integer logical instructions to
 decodetree.
Date: Fri, 24 May 2024 09:06:53 +1000
Message-ID: <20240523230747.45703-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification:

	v{and, andc, nand, or, orc, nor, xor, eqv}	: VX-form

The changes were verified by validating that the tcp ops generated by those
instructions remain the same, which were captured with the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/insn32.decode            | 11 +++++++++++
 target/ppc/translate/vmx-impl.c.inc | 22 ++++++++++------------
 target/ppc/translate/vmx-ops.c.inc  | 15 ---------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 11be21d230..16f3711073 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -709,6 +709,17 @@ VCMPNEZW        000100 ..... ..... ..... . 0110000111   @VC
 VCMPSQ          000100 ... -- ..... ..... 00101000001   @VX_bf
 VCMPUQ          000100 ... -- ..... ..... 00100000001   @VX_bf
 
+## Vector Integer Logical Instructions
+
+VAND            000100 ..... ..... ..... 10000000100    @VX
+VANDC           000100 ..... ..... ..... 10001000100    @VX
+VNAND           000100 ..... ..... ..... 10110000100    @VX
+VOR             000100 ..... ..... ..... 10010000100    @VX
+VORC            000100 ..... ..... ..... 10101000100    @VX
+VNOR            000100 ..... ..... ..... 10100000100    @VX
+VXOR            000100 ..... ..... ..... 10011000100    @VX
+VEQV            000100 ..... ..... ..... 11010000100    @VX
+
 ## Vector Integer Average Instructions
 
 VAVGSB          000100 ..... ..... ..... 10100000010    @VX
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index 4d5e743cfe..cefe04127c 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -205,16 +205,6 @@ static void glue(gen_, name)(DisasContext *ctx)                         \
            16, 16);                                                     \
 }
 
-/* Logical operations */
-GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
-GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
-GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
-GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
-GEN_VXFORM_V(vnor, MO_64, tcg_gen_gvec_nor, 2, 20);
-GEN_VXFORM_V(veqv, MO_64, tcg_gen_gvec_eqv, 2, 26);
-GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
-GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
-
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 static void glue(gen_, name)(DisasContext *ctx)                         \
 {                                                                       \
@@ -727,6 +717,16 @@ TRANS_FLAGS(ALTIVEC, VRLH, do_vector_gvec3_VX, MO_16, tcg_gen_gvec_rotlv)
 TRANS_FLAGS(ALTIVEC, VRLW, do_vector_gvec3_VX, MO_32, tcg_gen_gvec_rotlv)
 TRANS_FLAGS2(ALTIVEC_207, VRLD, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_rotlv)
 
+/* Logical operations */
+TRANS_FLAGS(ALTIVEC, VAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_and);
+TRANS_FLAGS(ALTIVEC, VANDC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_andc);
+TRANS_FLAGS(ALTIVEC, VOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_or);
+TRANS_FLAGS(ALTIVEC, VXOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_xor);
+TRANS_FLAGS(ALTIVEC, VNOR, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nor);
+TRANS_FLAGS2(ALTIVEC_207, VEQV, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_eqv);
+TRANS_FLAGS2(ALTIVEC_207, VNAND, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_nand);
+TRANS_FLAGS2(ALTIVEC_207, VORC, do_vector_gvec3_VX, MO_64, tcg_gen_gvec_orc);
+
 static TCGv_vec do_vrl_mask_vec(unsigned vece, TCGv_vec vrb)
 {
     TCGv_vec t0 = tcg_temp_new_vec_matching(vrb),
@@ -3331,8 +3331,6 @@ TRANS_FLAGS2(ISA310, VMODUQ, do_vx_helper, gen_helper_VMODUQ)
 #undef DIVS64
 #undef DIVU64
 
-#undef GEN_VX_LOGICAL
-#undef GEN_VX_LOGICAL_207
 #undef GEN_VXFORM
 #undef GEN_VXFORM_207
 #undef GEN_VXFORM_DUAL
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 672fba3796..80c5217749 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -1,18 +1,3 @@
-#define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
-GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
-
-#define GEN_VX_LOGICAL_207(name, tcg_op, opc2, opc3) \
-GEN_HANDLER_E(name, 0x04, opc2, opc3, 0x00000000, PPC_NONE, PPC2_ALTIVEC_207)
-
-GEN_VX_LOGICAL(vand, tcg_gen_and_i64, 2, 16),
-GEN_VX_LOGICAL(vandc, tcg_gen_andc_i64, 2, 17),
-GEN_VX_LOGICAL(vor, tcg_gen_or_i64, 2, 18),
-GEN_VX_LOGICAL(vxor, tcg_gen_xor_i64, 2, 19),
-GEN_VX_LOGICAL(vnor, tcg_gen_nor_i64, 2, 20),
-GEN_VX_LOGICAL_207(veqv, tcg_gen_eqv_i64, 2, 26),
-GEN_VX_LOGICAL_207(vnand, tcg_gen_nand_i64, 2, 22),
-GEN_VX_LOGICAL_207(vorc, tcg_gen_orc_i64, 2, 21),
-
 #define GEN_VXFORM(name, opc2, opc3)                                    \
 GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
 
-- 
2.43.0


