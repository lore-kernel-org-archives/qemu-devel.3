Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBEAC87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uktCt-0005jh-79; Sat, 09 Aug 2025 19:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCr-0005j8-BE
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:33 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCp-0005hZ-NV
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:33 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4b08c56d838so41746201cf.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754782950; x=1755387750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N4OkU+DgDKGb66i12ye1eGOR4zW3QJF0mGHVePO3CKA=;
 b=rrnxyEOAuU8uUDcs84cVET7DTOJkQX9ouqEnLZrupKYGi3rkUjZ7O/GkWsC/Xi06sC
 LnfkdBB1AwqJRFsV7vom5AV3UUvSLqmjoHqXLqB0qW2TGHorRCOhrDlk6uAAYipX8gLd
 bC8CLsaUa7cFHsJXLnkQTN/bpiELvwsWOb/ASQ2xovmLlltc/LgDSwqG53c4tqpgt5Pn
 K+viNvs9fVpfn+y1CiRPV3DIGIh8gYk7CQTWSZip//ttDSfx3ahtpk86Ya+2diZpwKtz
 GZdGHyuY7CsuwxRxI7bW7yzgFIwNwAt8janVaVUyQn8PeSWdc2uVNZFNLAp/I0L/NaBY
 VSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754782950; x=1755387750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4OkU+DgDKGb66i12ye1eGOR4zW3QJF0mGHVePO3CKA=;
 b=Hwt5Ss4TD/RK2Qs0K80vc31kh/W2AcWnAPiDbNcWWmRvTh6vPRLF2GhXBq7KAzylMe
 UTkM+ha0DBgXnQmIU7500ZAZSzkSspDetcPkO0ofQy7tBmsPOEys0bkTggQWei0h8nRd
 17iyNd5hKJZED42rC7ST7QAvJwX7BlB8oPmmPbhX8wDemFpaBT1EDSVxoW479mrxNJsv
 aHFATvPJPhw8W7u6SYM4J/AcGZ4S6uZ6nJEAQCh44EAAnTs1qkNiJWz5JC3oI8HgGMzc
 D5p/VYht27tG66fKF/PKL34qYBLqhv9+EJLnvaaZ6Nzpe8FLXyxLPny9DOGCeaBskT78
 w/Ug==
X-Gm-Message-State: AOJu0YyPS2/GmJBEK9QlPUjd2UJl3FRNdeGnIP9vDu2+vdLYV88MwxBW
 cOWBJkoRkkCdyDAiAb4MCbchfPJoUSyASDRLgk/Vm/3W0vRtU68mOSIcPWX0WLfvlcczohQuE2q
 dtjhw
X-Gm-Gg: ASbGncs7vbzSizBby/b1dNnN00SLH/IHFEr8JGju0+ENeQtd/8npvcpLUnEoBTiHezx
 39oFmBd+I/qXA50Z3A18+wYnfessljjxIrhgkOT7ysPRIrqpPqBfIGAaZOe26P9k0LBI2ECVjQH
 X4ucIXSIkkD+v2f9QGSKkj10htjKnR3DNN4Ohjy9SpkS2KV+wi0dmcKW930wp2A5iPetwbIrsNF
 iO8L9rY+X5OCN6JzxekFYIhQpuutQW3AZe3KHeg55xYhftVAb+sNqGVd6N8e0z6cht6ObrIEmN7
 2bemtQaKQpR299YISB9hRDkVi7ebaKTkGM4Rnfv8lglxR/rcMt5fuQ8eE0X8gv4xNZz4KROlyYd
 uMoQbVfYmrNWKo4FSS8ubRRgLZdatIlLWRLcqSqhIHZ1NwAFltqzUA0olaufPECW8kGYFOr7DjY
 wzipTm
X-Google-Smtp-Source: AGHT+IGV3hR5B+EyX8W8ZCDmnLBWoBGij2ZL2P/R6DtI05fDgLnksrPOjvJdqN+3TP488YGjQkcTwg==
X-Received: by 2002:a05:622a:1aa0:b0:4ab:640d:414e with SMTP id
 d75a77b69052e-4b0a06eedfdmr186607741cf.3.1754782950476; 
 Sat, 09 Aug 2025 16:42:30 -0700 (PDT)
Received: from stoup.. ([172.58.166.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cd56226sm132135636d6.44.2025.08.09.16.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 16:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts
Date: Sun, 10 Aug 2025 09:42:08 +1000
Message-ID: <20250809234208.12158-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809234208.12158-1-richard.henderson@linaro.org>
References: <20250809234208.12158-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A constant matrix can describe the movement of the 8 bits,
so these shifts can be performed with one instruction.

Logic courtesy of Andi Kleen <ak@linux.intel.com>:
https://gcc.gnu.org/pipermail/gcc-patches/2025-August/691624.html

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 75 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9dd588fc41..fb76724941 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -4342,12 +4342,46 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
+static void gen_vgf2p8affineqb0(TCGType type, TCGv_vec v0,
+                                TCGv_vec v1, uint64_t matrix)
+{
+    vec_gen_4(INDEX_op_x86_vgf2p8affineqb_vec, type, MO_8,
+              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
+              tcgv_vec_arg(tcg_constant_vec(type, MO_64, matrix)), 0);
+}
+
 static void expand_vec_shi(TCGType type, unsigned vece, bool right,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_shi[2][8] = {
+        /* left shift */
+        { 0,
+          0x0001020408102040ull,
+          0x0000010204081020ull,
+          0x0000000102040810ull,
+          0x0000000001020408ull,
+          0x0000000000010204ull,
+          0x0000000000000102ull,
+          0x0000000000000001ull },
+        /* right shift */
+        { 0,
+          0x0204081020408000ull,
+          0x0408102040800000ull,
+          0x0810204080000000ull,
+          0x1020408000000000ull,
+          0x2040800000000000ull,
+          0x4080000000000000ull,
+          0x8000000000000000ull }
+    };
     uint8_t mask;
 
     tcg_debug_assert(vece == MO_8);
+
+    if (cpuinfo & CPUINFO_GFNI) {
+        gen_vgf2p8affineqb0(type, v0, v1, gf2_shi[right][imm]);
+        return;
+    }
+
     if (right) {
         mask = 0xff >> imm;
         tcg_gen_shri_vec(MO_16, v0, v1, imm);
@@ -4361,10 +4395,25 @@ static void expand_vec_shi(TCGType type, unsigned vece, bool right,
 static void expand_vec_sari(TCGType type, unsigned vece,
                             TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_sar[8] = {
+        0,
+        0x0204081020408080ull,
+        0x0408102040808080ull,
+        0x0810204080808080ull,
+        0x1020408080808080ull,
+        0x2040808080808080ull,
+        0x4080808080808080ull,
+        0x8080808080808080ull,
+    };
     TCGv_vec t1, t2;
 
     switch (vece) {
     case MO_8:
+        if (cpuinfo & CPUINFO_GFNI) {
+            gen_vgf2p8affineqb0(type, v0, v1, gf2_sar[imm]);
+            break;
+        }
+
         /* Unpack to 16-bit, shift, and repack.  */
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
@@ -4416,12 +4465,30 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 static void expand_vec_rotli(TCGType type, unsigned vece,
                              TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
+    static const uint64_t gf2_rol[8] = {
+        0,
+        0x8001020408102040ull,
+        0x4080010204081020ull,
+        0x2040800102040810ull,
+        0x1020408001020408ull,
+        0x0810204080010204ull,
+        0x0408102040800102ull,
+        0x0204081020408001ull,
+    };
     TCGv_vec t;
 
-    if (vece != MO_8 && have_avx512vbmi2) {
-        vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
-                  tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v1), imm);
-        return;
+    if (vece == MO_8) {
+        if (cpuinfo & CPUINFO_GFNI) {
+            gen_vgf2p8affineqb0(type, v0, v1, gf2_rol[imm]);
+            return;
+        }
+    } else {
+        if (have_avx512vbmi2) {
+            vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
+                      tcgv_vec_arg(v0), tcgv_vec_arg(v1),
+                      tcgv_vec_arg(v1), imm);
+            return;
+        }
     }
 
     t = tcg_temp_new_vec(type);
-- 
2.43.0


