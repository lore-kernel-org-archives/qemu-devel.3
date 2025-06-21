Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1604CC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82U-0002PI-AA; Sat, 21 Jun 2025 19:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82K-00025s-Qd
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00050o-S2
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:16 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so1131404b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550052; x=1751154852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I9URDM3f3fP7MaXpj7cXtuBr8ZC1zj27CRTJlUEGybc=;
 b=R5nGwL+pBNgbp8S+Oe4/eMsntmPdi6OJwxnXrn3el8+Ar68RRk2jthh6+XgFXqXepp
 qDCMtX8XMBuqb+rNiihy45jjKx2IK79KNv75z/9qADGgX56qAie3RugpvDrqsjVk/vBr
 i+RfTScoWXuJ12kRsFb2ygQoanolZQQqprXxMo3Qh3wOXSuD/Y2oJ3lVwYA8aTykg7bS
 Ud5XXJrEBargij5LL//x8HCF+zDPrBHqBFljMbs9TsV1iRK5ANiGHvQwIW4N6DdYRLxF
 K0ZvXmin/ZvWj4PXvQQxyGCk903TiIHr6g+U/GcGhQMXArj7Y4gZJNduDZC5vmbY4xME
 lNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550052; x=1751154852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9URDM3f3fP7MaXpj7cXtuBr8ZC1zj27CRTJlUEGybc=;
 b=O8frD5bhd7nCK7AGV2hN3Qsj5lJGFyqzXIs6XCc/MnjaoF66OkJNv7ubaB2Fko81k5
 E0IhHlDEQjmIYi5OtwiPk7zmliq7WdD0gwJlMESGIlCNgzACJGpxCLPw0Fx06hNEACIU
 idZ2tTLyv9+KFZwXUK6vHudGTNenNiLDiQbgJ0DiNF/QqB9uyl/Pef8sgTQxpXN4fluO
 bhAXNSJyShwSDbumnRVqKqz0JZKpxrH+OnrY+gbCKPwOU/dDMhFiaX7uWYjrpJ+hPBkw
 yiorEshlH15PLiHfMhOikGsyf/QR7JrV7q9PGp5bQ1YM31ZousZvl79JpQ3blAo9OKE0
 EvWw==
X-Gm-Message-State: AOJu0YzYLDy24I2AVjsK5SGT7R4TDwn6JZdJnB4EW6U5T3ZszAhe8Ics
 s4NzVT7qFkN4HP7AH4W8S6jYW+dLqmS4WN0NTsut+2mH1R5LcQ87KjYeAw3OmmVzSROwAwUvmIE
 +uHMPscQ=
X-Gm-Gg: ASbGnctcuzu4W+LA0tvJHrFTYonIs71ymhwlBhp2UHeClyq7JKyHuE6C/F0BWhxZ+v3
 Xi6EuR3q4Qcxi1pIlQ2NzTOBBfkKVNTwdmUUiuJ/o9lpsbGcdDkN5SjYGxbF5pU0c3cZ4wJDHnJ
 u7r+S7VTdUpADaPCIiIYbu7D2OGOZntpQ84JeJyuTItImbHirYbP+aaHQtl+Fyf7SQ0cIk33K/t
 DdneeVdo/pKGaxDCk9YCOEgn0ADK3QZUXYri2t6S87UbjyCQ9VhqpmnsVVrjxYQ4pESY30qegUD
 IYYIqNXiCGl8frPANZIUjiCMpvV1xnxZj/CKkS3sZxOs4QhUUDL5+JG6798FrEMXuJxhDJgkahr
 Q1E+SmxAqvNQGG1gYtYZE
X-Google-Smtp-Source: AGHT+IFPatyVjtt+bTJScU9Zqs4a4qWEAGFFJPTA4eKwax5ymdUiG2fYQ+08XoQf+oYmu0CD+/Z2mA==
X-Received: by 2002:a05:6a21:9012:b0:1f5:9069:e563 with SMTP id
 adf61e73a8af0-22026f58a55mr11248587637.21.1750550052396; 
 Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 052/101] target/arm: Implement SME2 FCVT (widening), FCVTL
Date: Sat, 21 Jun 2025 16:49:48 -0700
Message-ID: <20250621235037.74091-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  5 +++++
 target/arm/tcg/sme.decode      |  5 +++++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index cb81f89fb3..04db920299 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -218,3 +218,5 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index cd66f321d2..2a6635010a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1562,3 +1562,41 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d[H2(i * 2 + 1)] = d1;
     }
 }
+
+/* Expand and convert */
+void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    if (vd == vs) {
+        s = memcpy(&scratch, s, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d0[H4(i)] = float16_to_float32(s[H2(i)], true, fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d1[H4(i)] = float16_to_float32(s[H2(n + i)], true, fpst);
+    }
+}
+
+/* Deinterleave and convert. */
+void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    for (i = 0; i < n; ++i) {
+        float32 v0 = float16_to_float32(s[H2(i * 2 + 0)], true, fpst);
+        float32 v1 = float16_to_float32(s[H2(i * 2 + 1)], true, fpst);
+        d0[H4(i)] = v0;
+        d1[H4(i)] = v1;
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 39a9831d3b..60ce5b518f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1288,3 +1288,8 @@ TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvtn)
+
+TRANS_FEAT(FCVT_w, aa64_sme2_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvt_w)
+TRANS_FEAT(FCVTL, aa64_sme2_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvtl)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8cca7d0d46..644794bdc1 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -725,9 +725,14 @@ FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
+@zz_2x1         ........ ... ..... ...... zn:5  .....       \
+                &zz_n n=1 zd=%zd_ax2
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
 FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
+FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
-- 
2.43.0


