Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E23FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZ0-0002du-B3; Fri, 04 Jul 2025 10:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPH-0002Wc-CR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPF-0001TK-Kv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:51 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so365367fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639327; x=1752244127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGt/IeQV1JU7unVXQVuY1VSCRAS3B0ec4CICad5URTc=;
 b=Ysfq78Nz6En0BU7ONnXKlqrz/E0QwkIKnkBqVHo02U+mxsEuBexfEDA+TLaZ3mJ4X6
 rJdCSthHAXTN+D+Y8OGgoAQnZTg314Sp6Y8EnOlPO+JNqAktEnsNmKDLuhHMejnpl0B6
 FqJsh8hkG5zG2NO1BElyQQRDUlwfZvdNI8sPo350nvzS/EA7PMS4t3ig88R/gbmk9KUS
 24HVv3qejDL4x9cXlKbIxCtC3LWli1O/6LwyfNy1llba3oM55UrtKvnWnVLdxh9rjFnf
 3A8+4/TtUYokQecI5wnbQcTDydq+bcLBzC0p9tTggst6YrK8j+y85HbL9EyQRIUNGbYQ
 wV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639327; x=1752244127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGt/IeQV1JU7unVXQVuY1VSCRAS3B0ec4CICad5URTc=;
 b=mmK+skqjAinskx5zCtuPVIk6n0PlaTLj548/8+Pl57AX4sju7LRgZt0ohidLpxxGpW
 HEN3WJDUZQUXQMnrLV9B8GyUu0rQUV8ERpytkgcIE++fbC9pBXJPyrflC/9gscn9kw35
 dg6drJzZvdc1pp/AouBkfshFOItFBabzVawoxVy+uZRdpLJCt9pZzPQjUh3621mJb4G0
 wR6gqw4PSUrn+4InMyMoE2oM2hLaZVxL/XaefHMX1iVBr5IfLQRlrUwOkZ4vINT7TMje
 Bkt1bJ5w6AAHt9ObwU+tNgZqeHbTNuOwFu8y1SSeHnva24NJhLk3AvJManfHNXyJeWce
 6XBA==
X-Gm-Message-State: AOJu0Yx3I0uBCoNbTGndYEqXQWbv4TglSsSRj0/lpfoWjqoT0fqoGBKr
 TKFKKtsgd76P8uwAIaP+SwUkT2tNJJJPcSMN7wmv7SeIT26MfxzUNyh6ZsM9IWK1QjHmiF1VWrS
 wGMq60XY=
X-Gm-Gg: ASbGncsJ9AvXheu++5f83sfSThVPTounlDes+hhLtSUAeHMFdmYsJkaQK4iI4nGawaS
 Fz6+1dgTxiU1V1jYHSPSxCkSIaYfxdtMGXjps6V9PAQ01xNLxIA59A6vgP/dz1TCi8WgRI7M+wB
 1oTozDCP+3MepwDAyrC3dtpGXgIjUTcWM0v36qaEDVseOTuw52+V2eYkRVhep3WhpTYubHxfkQv
 O8AZynHCJ2Nak75St6e8ESTdhdztoxd7TqbwA8fANlGSBRYfzZeiunu0CLTuV3EByu/aC9+sY8M
 ziStsYTL8R7X7jWT4d89yPxQVDmstjQXiSxRlK6U1XLPLUUWAXd9xTOXVOg6QEH0ow0Q0Bt/Jed
 i7h41+eAt/0rOLnXedLNJJgD8ov7/d7WY7baQRxqGfZNWGxX9
X-Google-Smtp-Source: AGHT+IH2Q2i9I0ZeJR8nmV1RDBKyMOckIh1mS792m7Ip1YiCqOOZs0aTSZUtBdJRsqQlmzuXNyy40Q==
X-Received: by 2002:a05:6870:1692:b0:2d6:72a4:adfa with SMTP id
 586e51a60fabf-2f796d8ff5emr1647342fac.30.1751639327251; 
 Fri, 04 Jul 2025 07:28:47 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 088/108] target/arm: Implement DUPQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:20:51 -0600
Message-ID: <20250704142112.1018902-89-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


