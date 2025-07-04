Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B92C83F0E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjH1-0001dC-9g; Fri, 04 Jul 2025 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFJ-0003ex-5f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFH-0006tt-Ba
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so8650645e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646398; x=1752251198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6H0lIgV2KwWQMWWf3+9rnQQcGz27daHOjXwoYkMAXzM=;
 b=SwhpW686YAQji4EhBQZ9t7JS0/oqs1S0kCp664IEQTm4DDK39U9C2FuUy2+6CwJTfh
 F1fBC4S7dAuKfWABj70cl8+aAkrif1crtKxDBxQDlmwvCo+JyQhHrkYNFtayNX88dlQ/
 o2ka+CdY6NKcu4yfpGIclSsMnoy5/K1jEF60f3zSN5GElVOi2s/auLEROP8ppg5FN+an
 co7PsVXGGu9FiTYfc2g4pnheAt65tm3zX12Rn0yEfVtH9fbnFekV/H6CGK7WY8lwt+WA
 M1MpO2GJKeyiGphxkeqm4iar9E59AZy/ehKUFBXVxLpPQSo3tEh8Unni3PzfpMCTMyME
 PSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646398; x=1752251198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6H0lIgV2KwWQMWWf3+9rnQQcGz27daHOjXwoYkMAXzM=;
 b=YoWvpEprYEEAQta7/1nAvLZcu1kGAgk5LV4b/6bHpsZt5rFxVWQ3qgTnnwc/Z9Ydpk
 cTP/7Y6pApiPgBxxcFN0EGZ99mOYvAEcbAkVeqPcuS+N1JFPadVCipDwu948sR9yL5MQ
 bTV6qEEB0AB6cs//Yb1ro73jy+inqo+aHuIujolHWwWG2I4Zr3uq6JknJPPCuA/UhPj0
 XtQW8K+Tqf8ULcRMEDa7rIJ9EYoD2Lf8eXqoJaTMW4tNUyVbxjp34XtV+b6U+vmsT490
 nfYiuXd+RpqaG6F1L0akqHThI6+NZhGXZAAxMmveahWX30aSpqMIRzdBGcZMNw1GjFYA
 HPIw==
X-Gm-Message-State: AOJu0YzhYUcIqlJSEISQ9WwwiGPfr7u1Ftjgp1cS7MigalRP/P8MKfr2
 JRLTj2nx34apefNEpE0K35lSL/ApUaNEtEZQbRlZEEaEMr3m2vTRtT11hRTOQT4lWS4FQiB2T9Y
 D7BrR
X-Gm-Gg: ASbGncvNGDrAiY6vRuNc/bK+ku3eQn9yJqnFu5hGr+2S+9ubaouneTgK12ykQiiBf2E
 2K68HRUtMHY770vemba2cStPvNGFNDzpJB4ci25JEKjQ3FjGDoZKE/625DG0VIgMD0vAV+C5qKB
 ifBFYKZnksr4qO5iDENKbnami1hfRpvNzWry9UXLnp+AQeuGvx0iOp0T3wguSP/Hm2RfSvfBXTr
 LT9oEjH1U1if0WTu8JCdyXfqjzsuiDE1GUHmn3xTnJa1w67/5eKuLAObioPExCD2VBH6GsSMmDm
 xHgre8NUI8Azn8+g1cseXzb+c2HCEAwKLpYwFSQ975S2Z9S0/H9RjwRgPHm2WrEqTeE8
X-Google-Smtp-Source: AGHT+IHMZ8c6uxHrrO16eSv0vkUf1qbBkMDyMS/HGg9/ash2rnEmaVFPO/4qaz2dwAVxm5KTt2y+sA==
X-Received: by 2002:a05:600c:3e09:b0:442:f482:c42d with SMTP id
 5b1f17b1804b1-454b311617amr35810985e9.9.1751646397762; 
 Fri, 04 Jul 2025 09:26:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 100/119] target/arm: Implement DUPQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:40 +0100
Message-ID: <20250704162501.249138-101-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-89-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  6 ++++++
 target/arm/tcg/translate-sve.c | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index db16849731d..2650e00f80b 100644
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
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 53db8851bf4..e33b2eb2a4e 100644
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
-- 
2.43.0


