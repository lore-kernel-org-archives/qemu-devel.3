Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E3FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMv-0005f4-EO; Fri, 04 Jul 2025 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIO-0005MR-Uk
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:47 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIN-0005zk-5F
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:44 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2e999729ccbso667970fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638902; x=1752243702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZHxsghFcUANhQ9FBp2KHEXBbIHriLYmgetebn62l7Q=;
 b=AU5Muo+cllVXb82wznK7Eh5JTlDNlTmbLyZfG20giz/yx0OE/yBYdeGqaPkgVGNZrH
 FtIKufpEu6y633bi4h6D0/pstDxJubMGRV5/h/VvUW1ayB2iNstaIogqOkUjxKCy3ENu
 Qi7CMnZ4MX/Nlo49k9miWJMX1lriifW6EWOabjnWzlnD/dHSqYlDYvoLjKe5PjI7fE4a
 /rZairNp+n+gzhYjcHBOGKLaKitAyMQWXiNjugLYmHf6/JnV1V/WuuJBASYseMM3iNq7
 F3pnbrsisuR5EyspV75I7MQLqyC5XL0ZmQD4tZv9zv2C8F4fcBlyXSZkkA4SziLQlkRw
 wYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638902; x=1752243702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZHxsghFcUANhQ9FBp2KHEXBbIHriLYmgetebn62l7Q=;
 b=f7A7PUMpMYG0j/m0T7Y3pN2tbZ+3MItHoNEHFdxFI/GslFq8SdvPCVkcOKIwQ3PYL4
 MbOoXDJuMk1njRubObqZGDtc79/TIghd2lXqMfjDDpAVwYCziJmuq9CUnKsCYGJgXttN
 qHpjwgp+V6bS1Rr7wo9CvpVIL1xGJylrbbtveyqXcF4Q0gGey+6pnMED3e6lpOAkR1JE
 tBEinqWD+jZfcF65CevngUuXNFFxXQ/piXZIvLQ0391qQI974hxCTqG3Lh2AiI60JE4G
 3RZvk9+oAFlDo46rNgPUbeRjAuGRbIEf4KPm1kUOO4fus7XrveYrDY4XjZQP+nWSwFsE
 psVA==
X-Gm-Message-State: AOJu0YyOMiLiRFtPbTp/aJ853Ulo/U/AGaVM03bGN2Pwiycuw+K/ibRG
 HYaMdkAcRXTG45+/Jty1zzhHkxLi8DXQtHEPOxahGGA7jZUcTSLHKc3r6ZHnLwvBbKtdJFXZapZ
 YR/LuPts=
X-Gm-Gg: ASbGnctUnjomFC3pcCEBDZ/EknYDReMMA43r8jacd2aTXbVH8/nBlkSxeYO8k6aSIHb
 NnW5n29I34WZTzuWggPU/314aiLlWmvhdlC00ji3YD+mVy+RTjoOjlKXPAp0jJm7YiAV8RjmC5D
 I9Tkiq10j1uQeBfkjhth8r8S6Wbh2ZhV+IMB/XlzxTyYry0y53zRasEPUgbJ2rfnpj4aXJABj7c
 Yp1YJUdurBAaSEp9dBo8fdJ9kNSOd9sipOFaM/ewkbk+oT9ulExL5aFj59UOyLl8MmfI5jSAh/Q
 Ysc732ohy2nqjvg7JTYf79sYgnOPoqMgIGOIHpld245GxMqKqJ+HhQBRDS3AMLyKjaqWmWgK7Ri
 Cof3TUBIKFpvrxBEpXc0VBcg7aivlxfuEuQlCgObXGAdEZ9QE
X-Google-Smtp-Source: AGHT+IFKU6NlBqBGk9xMCOwyxMHlO2qRgs0nRHmEuwfi+CUOYaM8sD4R/fw6Ryt6X2qBBqouej9TnQ==
X-Received: by 2002:a05:6871:8308:b0:2c2:5f8c:4630 with SMTP id
 586e51a60fabf-2f7919c7ba5mr2222541fac.0.1751638901935; 
 Fri, 04 Jul 2025 07:21:41 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 026/108] target/arm: Implement SME2 MOVA to/from array,
 multiple registers
Date: Fri,  4 Jul 2025 08:19:49 -0600
Message-ID: <20250704142112.1018902-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
 target/arm/tcg/translate.h     |  5 +++++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7336b7db72..a18d07540e 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -210,6 +210,11 @@ static inline int plus_2(DisasContext *s, int x)
     return x + 2;
 }
 
+static inline int plus_8(DisasContext *s, int x)
+{
+    return x + 8;
+}
+
 static inline int plus_12(DisasContext *s, int x)
 {
     return x + 12;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d4c7d7e85..7b275dd2b8 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -298,6 +298,36 @@ TRANS_FEAT(MOVA_tz4, aa64_sme2, do_mova_tile_n, a, 4, false)
 TRANS_FEAT(MOVA_zt2, aa64_sme2, do_mova_tile_n, a, 2, true)
 TRANS_FEAT(MOVA_zt4, aa64_sme2, do_mova_tile_n, a, 4, true)
 
+static bool do_mova_array_n(DisasContext *s, arg_mova_a *a, int n, bool to_vec)
+{
+    TCGv_ptr t_za;
+    int svl;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    svl = streaming_vec_reg_size(s);
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zr = vec_full_reg_offset(s, a->zr * n + i);
+
+        if (to_vec) {
+            tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, o_za, svl, svl);
+        } else {
+            tcg_gen_gvec_mov_var(MO_8, t_za, o_za, tcg_env, o_zr, svl, svl);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVA_az2, aa64_sme2, do_mova_array_n, a, 2, false)
+TRANS_FEAT(MOVA_az4, aa64_sme2, do_mova_array_n, a, 4, false)
+TRANS_FEAT(MOVA_za2, aa64_sme2, do_mova_array_n, a, 2, true)
+TRANS_FEAT(MOVA_za4, aa64_sme2, do_mova_array_n, a, 4, true)
+
 static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
                     void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5eca5f4acf..37bd0c6198 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -27,6 +27,8 @@ ZERO_zt0        11000000 01 001 00000000000 00000001
 ### SME Move into/from Array
 
 %mova_rs        13:2 !function=plus_12
+%mova_rv        13:2 !function=plus_8
+&mova_a         rv zr off
 &mova_p         esz rs pg zr za off v:bool
 &mova_t         esz rs zr za off v:bool
 
@@ -88,6 +90,16 @@ MOVA_zt4        11000000 10 00011 0 v:1 .. 001 000 za:2       zr:3 00 \
 MOVA_zt4        11000000 11 00011 0 v:1 .. 001 00 za:3        zr:3 00 \
                 &mova_t rs=%mova_rs esz=3 off=0
 
+MOVA_az2        11000000 00 00010 00 .. 010 zr:4  000 off:3  \
+                &mova_a rv=%mova_rv
+MOVA_az4        11000000 00 00010 00 .. 011 zr:3 0000 off:3  \
+                &mova_a rv=%mova_rv
+
+MOVA_za2        11000000 00 00011 00 .. 010 00 off:3 zr:4 0  \
+                &mova_a rv=%mova_rv
+MOVA_za4        11000000 00 00011 00 .. 011 00 off:3 zr:3 00 \
+                &mova_a rv=%mova_rv
+
 ### SME Move into/from ZT0
 
 MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
-- 
2.43.0


