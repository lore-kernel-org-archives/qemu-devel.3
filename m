Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539FBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mDE-00044l-2H; Tue, 15 Apr 2025 15:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001H9-49
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5d-0004Iw-3Q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4673170b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745759; x=1745350559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+h27PFrRmmJ3MbDGqZa1hHbsmytiPMNDxuHO770glYk=;
 b=AvDps9nF2B4W3Gf3kQqSPUpyT0ySs2fBZm0+VA17jmRv40d0xG615hkcitS3DuiTq6
 v2ucB3JFoZuccOnX5ysArAyo6IUOHkxA/SsJPEjhMJUbhAJB+Ba0bqGBi3m8zTKgZAI7
 8eotzwfHithKaWMpiswcieG/mjr5c0i58ugEnOnmqSlMjjshBwB9qzS5TDwJqbLk5119
 vgbxAIkJLC70EqI/REweY1xiKrVU4iuvHMY1zRbVVoANhO7mMZIYgaAS0pcIaJtFjxsk
 lcd1akFUzcZ0EGztXJ2ebrXtpfIt0V4CfQ0ZNXXzAp/Z+Kq+oHdSvMDIj3CRczI7ryQq
 CkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745759; x=1745350559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+h27PFrRmmJ3MbDGqZa1hHbsmytiPMNDxuHO770glYk=;
 b=VbSnv8c5Ulmwa64Yu7Qjar3f7NdsNtP3p+3ymoXtziB4sRrH5MYFRrN6VQwC++DrVv
 aKLft6DxSCka0oDXdz9JgcmrCYOXadIiLXgKp4QDhhGhO26RMeIT5sWQVRIfQeoS4hLQ
 swqFCz1LBWSGK2RQEduVVpNUl8GK3c/1TzFZtZkkxRl+5KjmuP83C/WPIdfOMvkAOTJR
 E6AIutfWZAoWj7BrzazNGaoo5DE2y8zemfIXBF5iMU3PfxN/rmQzPEi23imZihmHlqFN
 pgTXJ+iFqIC8pMXI80QY79aABBG+jn0UJs/8lPc6QJ5xKyVXsKAE5faVm0qvuVkvHWF6
 gR6Q==
X-Gm-Message-State: AOJu0YzG6/KKGktUJ3GqbBXDTlCS4jmFmtoeqjLiEFzCM6g22+0uKtnp
 pZGqlRAEcJe51IZho5IdJnWz0kDAE8d/PgYB4XYsvKUamAHg0rzCiqhxGi1Td4kc0SMPybiGFLq
 2
X-Gm-Gg: ASbGncvpjNFKd0mbMUMvwmQ32qVv3jwPe4mtaHTMXShFcDPXFfBw1/5hQRmMbM4L1R8
 +93vtNZhhd95Km39RTF3PNLQZ3qGf66Kxf4CTWu6KivheHbDQQiYo4t6mFAJDCdq6MyMYWyOZWS
 +phJwKFtRvh7GZ4Dcbcb5krA77E9rGCEHXI+FSOjTeysAgYm9IgAPDYolx2mtPIYb1eWUCkpFz1
 TEwZojrPSvs5ED8uT6GdH2n5/mRFvuVk2cvWq3VQubpOawiYfRJHm41VcoUTD+TVjQNELrUF2da
 8SgCvJyKAT5X1wcQMsFyV6EQu+jbih6RowDFxcTA5U0RF56t1+LjK3HYKNpteIaDO22brVS+JuQ
 =
X-Google-Smtp-Source: AGHT+IG8hzH9xSomIQHQ0kZYPeMiEHwDLmbc0VCj06wKH30eNyzHsbJPAyKE0LLXJ63HtXHm8spFsg==
X-Received: by 2002:a05:6a00:3d47:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-73c1fb48a9dmr1071463b3a.20.1744745758897; 
 Tue, 15 Apr 2025 12:35:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.35.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:35:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 121/163] tcg/i386: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:32 -0700
Message-ID: <20250415192515.232910-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  1 -
 tcg/i386/tcg-target-has.h     |  8 ++++----
 tcg/i386/tcg-target.c.inc     | 31 -------------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 0ae9775944..85c93836bb 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -57,4 +57,3 @@ C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
-C_N1_O1_I4(r, r, 0, 1, re, re)
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 0328102c2a..a984a6af2e 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,14 +26,14 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 52d3402f29..44f9afc0d6 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3479,31 +3479,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
-    OP_32_64(add2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADD + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_ADC + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
-        }
-        break;
-    OP_32_64(sub2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_SUB + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_SBB + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_SBB + rexw, a1, args[5]);
-        }
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_ld32s_i64:
         tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
@@ -4109,12 +4084,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, re, re);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
-- 
2.43.0


