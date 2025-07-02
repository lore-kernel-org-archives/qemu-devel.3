Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A1C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgG-0008E4-TG; Wed, 02 Jul 2025 08:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfp-0007cI-1W
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:49 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfb-00010j-4J
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:48 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso2467745fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459674; x=1752064474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2fzwhtLG9lMcShMZnFVlEkQjvvkyWGwHBNuHHz9TEU=;
 b=txS1xK27FDIabJwob5fl98WZWYwh016YzkPKDSBzh/e5WUc/poM8oHEtylGRRh2v01
 h1XYTD0JqI69HnN/XKcY8By2M3coptbh2Y/yAv7IGkaVuZc16vWvJHYspPaRd5PTkbNV
 eoFmMUgOjhy1/iNj4QH7OA2mIAlBOCVV9jzRlEa4CibjI9PdA8Z8bJN84VmXUoGmjL/N
 Gbx9BlHnk2ZoF7/ihvnoFmqzO5OrovuAWquFlfZB38V08chFRHMVCLCdJk2PGJzpcmqR
 pTDhztoV7yUzD4MfQlq8D59reKCxdf0PQ6G6macrRE6khZQPK95FH/G5MYmQSlLjkbLn
 5uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459674; x=1752064474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2fzwhtLG9lMcShMZnFVlEkQjvvkyWGwHBNuHHz9TEU=;
 b=YzZOj2VYgTUp4MbbKQF8a54iRiAw4VjtjpCpmo507Ac9QvNimNo6+5RbSzM5IaK5yL
 qSaW+1hPvT/O/t/5VWLSJllDjJbIH1/itv0m+0B/dOVjRcoJA164pgxpypChlUhyqfKh
 4SQHgEMD53vstsRv6bIsIxN8B8AHITUz1G0LFtiECgKblvMT34Hm/rszbMMz6t5MbUAe
 RRS6KQ5g0NQChR6hcvY6fqtIKsFwN9tyFLoizvgyYSAGuS6kWyVTbYzSUAHMoXeb1kj6
 wnaNgAzhT/HFVoV1+u03QYBJynTjuQ7lGZCdfT/G2jEUGn2a3GPvuolM2Rj/aQinYJOq
 qT6w==
X-Gm-Message-State: AOJu0YzyaL7pGp8AD1plsLbVaQk2IUPzCfdPqndrkGfzB6D765nYQm5U
 J4rbpjmMxMpqsOyAW+mYCXi9EWmojgFdl+0sm7VjQC3Qhgp14fIWcXAEt9h1VBgXAZetAb7xjM+
 wzm++dOI=
X-Gm-Gg: ASbGnctSSrdOxN/GA5HSuXFVUCGLdx9xAeTpT++90Bt2UMKiB8yJvF1h+YKiup4JeDs
 e7+ClIybokxMQbF/4uRxJQ3boHfkhfgXet3X6q7zUW7oqFluD3VxsJ3OpnQSNvCWcU1Q4U3UUCK
 1thounVnje7853ztwPaLSEy50qas6VIpc7xxZW7G94mOx9FReEcJvA0mmqN3jD9v58w30J0HlRM
 lFJNxPIxm2MlAgigbd+0kYWZy2xqZDEmDYEcvqhfzh2yqTBAwzpa/yuWo2UQanK6X0+SbSHcs03
 A1+EcQBwN2eCyJZfIs0pHNrlgjLu6ijHjKDKkMOy5/iUcqRcfCJzcKI7Pl9d3mc1224nHQ==
X-Google-Smtp-Source: AGHT+IHhXFyMcQguhDnYidxcy5IN0/4jwyRePs9b6b3yJuT60yTiV6KFxy5npKWrnAOMC31BRGxvMg==
X-Received: by 2002:a05:6870:d687:b0:2b8:3c87:b491 with SMTP id
 586e51a60fabf-2f5c7cc0be9mr1885489fac.26.1751459673694; 
 Wed, 02 Jul 2025 05:34:33 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 16/97] target/arm: Implement SME2 MOVA to/from array,
 multiple registers
Date: Wed,  2 Jul 2025 06:32:49 -0600
Message-ID: <20250702123410.761208-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
index 4dbc30a376..1b29b958f3 100644
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


