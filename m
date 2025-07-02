Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B60AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwp8-0003Oe-3Y; Wed, 02 Jul 2025 08:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwk7-0004rp-SD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:19 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjn-0002H5-Ek
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:15 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40ba3d91c35so85508b6e.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459931; x=1752064731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8C/wkbnZTuy6uWFeOHVvDoeWONxE+AwGqQusVfoPHOE=;
 b=qPOKIJ/u06dBAqG95dA8tf8fzy6xGvxNJSJhywykU4nHAjzHpeN1IOKDuGJ7y8ABle
 QICs4j0pR4b+DuXKHh7lBN8iYGd795/+tucy/FUL+dD9Rd4uhXdTH5uVn9th2Y9KWXRU
 1andoOCBCsthbdBJ9H1Rou+7+1vhhuG1uIZIfw2lKGTZ5GU7seMzXK3ZGlckISUbvA9J
 7jZosCuqsQoDG4rPRX2J1FOfgPLwZq5Dcxq+7R822Ykqf91jlLa/ZDlF0U/KdqPWJwRt
 RG/UHV/IcsfYe2GREKbH/bJieU166GofNdKpspw6oOyAzRX/ljFjkHmSJw++cGgwF9J3
 kOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459931; x=1752064731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8C/wkbnZTuy6uWFeOHVvDoeWONxE+AwGqQusVfoPHOE=;
 b=DsMh1jSuc8i0Wp+7h+jyVyJFSgeZjk9l2tFsq4ZjTjI54fvFO6zAdrl7crvnF1Lexv
 e2qk+QmpFwcjcF3Xgg6OUKmm5Vx6xODqjfww19aImQ9Z56k/6He++U15t3QW290FhCea
 NoWjqSdBswjdYvVuwY4i/bXIzayUu1W3FmmtPOYgTwNPuyZEXlsub0QpdMjKUgtkECyK
 lxGE/o71MBWaYQ4WkoJnYCRfBI9SuJftRKaANp06hcrLppYsKua9oixGI4bqiz3XuMwd
 Zwxnx9HPxhrPylDt5ZeuSXzNS7jmn+UnoctQ79EGgNqlB8CxB7/zZFbxdmokMpCozrdE
 6egQ==
X-Gm-Message-State: AOJu0YyCNdIrphFjlWWdZrnq28bu5WAPnxFTzA55vR2hLpKK+ey6Zr82
 upZZc5WgXcKoSCJlT9AUIp23uS5ZHfYNlGFUNHCMGo6LxSGi5ace/53DgEgMcFwGGqYLLydeap0
 bYIY5uRQ=
X-Gm-Gg: ASbGncsMG8t6XeHwvY7Lp+HOXD/INitKZ4OBAzuaeD2KdRkiiRv/sN/gwObmVRawgOY
 bGmjl9ZsgHdrm0ZCMuz7h0o5jYb5/Jp7jaFDv7gjB/LBihJJjpKYq/eGAsXrXUBEdJlg60AGhpL
 2amaNd5fJnZCQA9hs6Pv3TdX7SIDmqoq320ecd8m6DryQq9gDruTmATRm5ZjXenooSF/Sz2ptee
 XtxNczFPTUxUxMfaFU8A2M0eo2cqKYRHD6Se6MTggEOfub8D+/uNTuZpYG2+tUz+Gtzey3oAOe2
 H8M6FJ2NMH3eibPnWu2QHS+fgxgBBFVeHfoZX29L4GKSH3ohz+byAH5vvsAHfOIlOl66/s9py6H
 4Payr
X-Google-Smtp-Source: AGHT+IFu2oKge88SYNr0LTCjz9sOg1enGJydsVyC1rEHBJ8eEa8R4ZmNbhaeAufRVU/t1LkP7fWn3g==
X-Received: by 2002:a05:6808:1b99:b0:409:f8e:7297 with SMTP id
 5614622812f47-40b8840cf7emr1738323b6e.0.1751459931273; 
 Wed, 02 Jul 2025 05:38:51 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 77/97] target/arm: Implement DUPQ for SME2p1/SVE2p1
Date: Wed,  2 Jul 2025 06:33:50 -0600
Message-ID: <20250702123410.761208-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 21 +++++++++++++++++++++
 target/arm/tcg/sve.decode      |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 53db8851bf..e33b2eb2a4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2249,6 +2249,27 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
     return true;
 }
 
+static bool trans_DUPQ(DisasContext *s, arg_DUPQ *a)
+{
+    unsigned vl, dofs, nofs;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    nofs = vec_reg_offset(s, a->rn, a->imm, a->esz);
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        tcg_gen_gvec_dup_mem(a->esz, dofs + i, nofs + i, 16, 16);
+    }
+    return true;
+}
+
 static void do_insr_i64(DisasContext *s, arg_rrr_esz *a, TCGv_i64 val)
 {
     typedef void gen_insr(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_i32);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index db16849731..2650e00f80 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -577,6 +577,12 @@ DUP_s           00000101 .. 1 00000 001110 ..... .....          @rd_rn
 DUP_x           00000101 .. 1 ..... 001000 rn:5 rd:5 \
                 &rri imm=%imm7_22_16
 
+# SVE Permute Vector - one source quadwords
+DUPQ            00000101 001 imm:4    1 001001 rn:5 rd:5        &rri_esz esz=0
+DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
+DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
+DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
-- 
2.43.0


