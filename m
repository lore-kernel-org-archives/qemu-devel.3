Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38142C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3moH-0003Ci-3e; Sun, 05 May 2024 21:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmx-0008P5-6R
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:19 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmO-0002XA-65
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:05:06 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2b4a7671abaso875745a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957470; x=1715562270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbPodXVfNYDOBeFPuI23bmSPTaq8W6PthVSB/YmIGHc=;
 b=xEJDXnh2pC61OPsT3B2r4ySQf/qWqVEwuUKICjBbdXynHLB4OrSR5nah8Xkukc5YYX
 xSch0ttaOtU2dy6Gv53AwO0+E0bXnhf5t3bUmd05BUDbBUzGHGXciIDFucL4n3uk5Ba0
 dDYusYRdK64Eak0x0TypzviXBj3iAmuJYHpMyXn5BFjgwR/P6U9RUWl+wWA5vBLgI+U+
 0eDDsgcXoT4X1HqdrZsheQMmIJFaj16XO1+nnngNFnC7IY8LQiFKfZOR1d7zrdM80bUM
 7ymAziiFZ8Q0m5jthHOVZe14QXks6c88s1tUmSbN7S6H1rgUDcOPGtEAgUilS/hfTwb5
 zrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957470; x=1715562270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbPodXVfNYDOBeFPuI23bmSPTaq8W6PthVSB/YmIGHc=;
 b=DbVzaig7AvqDkZo+eADY+bLsIdEkZ0W1xL/OblvIYd+eJjKdFAKDg9dzMcJh36BmAB
 9cuuXTuYBboxb7QTkxUWDzSBSarn7D4Qg9Zi6d8D7a1U1dlLlHWAzN3lgh0zw0KpuFDm
 MKbCcM42RuANJ4BpWtL01eaaB9GR3eN8ZgAOM+Ji8pwPEUzNISg9QToCyrGqOBcz7lsD
 9JLmritY5Avdif6r1iMepIjeju8p5YnMj+4z04/nN/rCbgRlYCujoz7hl2CxqYx/lac5
 nHDJlPARjZbehf7eA/mCn5AhemCLWZ7zRM7RgSaoS/T79Ssze6z4x1UaJc5WKeogFeYS
 PcAA==
X-Gm-Message-State: AOJu0Yz4wjeavLBMKtUFpe9wK692Z2qRg66BKMyI9ReWvvbyiiWeZe9y
 l+i8sb/NCSWkMLV1kIfzcpGYL1G6p4frPnanJGS9CVafEphwuH32ZMxo9/JZLFjO0nsX+wkLYfF
 J
X-Google-Smtp-Source: AGHT+IH1nKlQX1OvMfSGrqLWnpfiKJH0Bzm4PKXM/WrQ+1I99uqS38yQ4ASj2+dTUC4tVSTITNzObg==
X-Received: by 2002:a17:90a:650a:b0:2a2:70f6:8f67 with SMTP id
 i10-20020a17090a650a00b002a270f68f67mr7393275pjj.30.1714957469835; 
 Sun, 05 May 2024 18:04:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 30/57] target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
Date: Sun,  5 May 2024 18:03:36 -0700
Message-Id: <20240506010403.6204-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No need for a full comparison; xor produces non-zero bits
for QC just fine.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 22c9d17dce..bfe6885a01 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1217,21 +1217,21 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_add_vec(vece, x, a, b);
     tcg_gen_usadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+        INDEX_op_usadd_vec, INDEX_op_add_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_uqadd_vec,
@@ -1259,21 +1259,21 @@ void gen_gvec_uqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_add_vec(vece, x, a, b);
     tcg_gen_ssadd_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+        INDEX_op_ssadd_vec, INDEX_op_add_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_sqadd_vec,
@@ -1301,21 +1301,21 @@ void gen_gvec_sqadd_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_sub_vec(vece, x, a, b);
     tcg_gen_ussub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+        INDEX_op_ussub_vec, INDEX_op_sub_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_uqsub_vec,
@@ -1343,21 +1343,21 @@ void gen_gvec_uqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec qc,
                           TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec x = tcg_temp_new_vec_matching(t);
     tcg_gen_sub_vec(vece, x, a, b);
     tcg_gen_sssub_vec(vece, t, a, b);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
-    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_gen_xor_vec(vece, x, x, t);
+    tcg_gen_or_vec(vece, qc, qc, x);
 }
 
 void gen_gvec_sqsub_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                        uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
     static const TCGOpcode vecop_list[] = {
-        INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+        INDEX_op_sssub_vec, INDEX_op_sub_vec, 0
     };
     static const GVecGen4 ops[4] = {
         { .fniv = gen_sqsub_vec,
-- 
2.34.1


