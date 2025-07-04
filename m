Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD1DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOz-00029E-Qn; Fri, 04 Jul 2025 10:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM6-0004Yk-Td
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:37 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM0-000874-MG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:33 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6118c1775dbso307613eaf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639127; x=1752243927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJFR1eJ+WUdy2Lk3rwd5+Ns6EIeEnwPE0V3+mnbvDGg=;
 b=qpJUKgnr/yXLLnx/DCOYprKGZ0nBJFdyPFt4ZuBmUr6qiScXRQTjBQ+WOeB39C/uiI
 xvOdodV5LHlKAg6OD3eXPklLk8pSPNubOOrKD/+2rcCzE/NN4o8Bj8c5k70qa2WQN1DE
 vrZ9k+HClhZUVxhoc1wdAbO7aX+0RvuF5appVj65EpLez7g5CVnKYEM/ZCImb5iO/o4s
 SdczXmVXtfH+s9MhpFQF8+wa1EkLsTRuNpGubjABpdojJgcM+B+XriRiShW7iZrKzT1K
 ORbk8bZiNYKwkj9Xe5s1aY0q4BjwnW5PnstwBhkw++jBUlfye0ZGxf3WmhZ4x8ATkA/j
 4w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639127; x=1752243927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJFR1eJ+WUdy2Lk3rwd5+Ns6EIeEnwPE0V3+mnbvDGg=;
 b=gOVQxzU+KiIHpC/2NM33H9gNDPROigVM8oc0LqrtDysZ6SpKoDbmpO/nG/vNhwNcHB
 JmX5/aESkz1CqAyewnpcBswUbg6nW2HCEBHPOk9ivyNeGSe1l5s1kto4aJ5tSE554ow2
 ppsLAWa0DPwX6L0b8HoCFgSPG+zj0g2BhaCVszn3qvWvIY1v70g2TgSEuCE0FOrZhDki
 kdR0l69elXw5opL/kk8Kogb9s27jfQLdLtow3gX+wQ8S4w0oodSuxD9GHQGEwmrVJbh7
 wQumGAoAqKGjBMW5t/qlfGTAvK79rznMBRpZBATPJlKfuzbjmuNsgsBzQYaW1Ut1wLfH
 +iUA==
X-Gm-Message-State: AOJu0YzeP9A8tjaiyUX9TEGtFi2GxLBAKbX3ZCKIN4Ige8xOwwyGgrx5
 s50J/m2tW2IE4tV1nLqkOLTCLKk9szBZqDOM8jKpOYplZclvJV97+ZbUJSP/D5LVLqyhi2tXzcX
 s5bteLT8=
X-Gm-Gg: ASbGncvqEdvZ+JAFJ5nLugV6wwm7ssyFt8d7+9E2jjNhT5fpZjdAaP5koxqzuOLeH99
 tW1d3VnDn7etKMt/BWZX9cgttEfZJc6fuF7VO5/YSVRjFUh7yzuURWLnmP93oTS/t7TW/PAksNv
 mv21EI/dgGCgcSMueT50irApVHD3POejfCTQ00WvzApHanACqEpuw6VrIOu4rb0s747oPDKInG0
 4D2ZwSYkHiKdeTtkGYIEOpafhkJRhBgLvwTFMesdg60NkVBRuyjh+OD/2YFy+Reg6lzyVA3QTxm
 tGs+V3p2X6TKFaAEpH88tnkzFdiAOIAm4q5gNj2Am90JHV3GJFJ/YKi32wAg6XApu7+5HjznuEk
 8xuRr+BdF0OWazjexKh2qKT1d6qrPnD0mOOBDSkZ71y+lXfgX
X-Google-Smtp-Source: AGHT+IGBgIdFbO+iwZ7ceBIF7i3IIbzB+yQG5+fgr3kWXanmvu4xyx45iXJo3OJRTupd1qaqxdP2/Q==
X-Received: by 2002:a05:6808:159e:b0:401:e848:18b4 with SMTP id
 5614622812f47-40d04aba9d3mr2184558b6e.8.1751639127275; 
 Fri, 04 Jul 2025 07:25:27 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 069/108] target/arm: Implement SME2p1 Multiple Zero
Date: Fri,  4 Jul 2025 08:20:32 -0600
Message-ID: <20250704142112.1018902-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
 target/arm/tcg/translate-sme.c | 20 ++++++++++++++++++++
 target/arm/tcg/sme.decode      | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 99e4056316..b6316ac716 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -173,6 +173,26 @@ static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
     return true;
 }
 
+static bool trans_ZERO_za(DisasContext *s, arg_ZERO_za *a)
+{
+    if (!dc_isar_feature(aa64_sme2p1, s)) {
+        return false;
+    }
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / a->ngrp;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, a->ngrp, a->nvec);
+
+        for (int r = 0; r < a->ngrp; ++r) {
+            for (int i = 0; i < a->nvec; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                tcg_gen_gvec_dup_imm_var(MO_64, t_za, o_za, svl, svl, 0);
+            }
+        }
+    }
+    return true;
+}
+
 static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 47adcb5a15..c4b85a36d0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -877,3 +877,26 @@ UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
                 &zzz_en zd=%zd_ax2 n=2
 UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
                 &zzz_en zd=%zd_ax4 n=4
+
+### SME Multiple Zero
+
+&zero_za        rv off ngrp nvec
+
+ZERO_za         11000000 000011 000 .. 0000000000 off:3 \
+                &zero_za ngrp=2 nvec=1 rv=%mova_rv
+ZERO_za         11000000 000011 100 .. 0000000000 off:3 \
+                &zero_za ngrp=4 nvec=1 rv=%mova_rv
+
+ZERO_za         11000000 000011 001 .. 0000000000 ...   \
+                &zero_za ngrp=1 nvec=2 rv=%mova_rv off=%off3_x2
+ZERO_za         11000000 000011 010 .. 0000000000 0..   \
+                &zero_za ngrp=2 nvec=2 rv=%mova_rv off=%off2_x2
+ZERO_za         11000000 000011 011 .. 0000000000 0..   \
+                &zero_za ngrp=4 nvec=2 rv=%mova_rv off=%off2_x2
+
+ZERO_za         11000000 000011 101 .. 0000000000 0..   \
+                &zero_za ngrp=1 nvec=4 rv=%mova_rv off=%off2_x4
+ZERO_za         11000000 000011 110 .. 0000000000 00.   \
+                &zero_za ngrp=2 nvec=4 rv=%mova_rv off=%off1_x4
+ZERO_za         11000000 000011 111 .. 0000000000 00.   \
+                &zero_za ngrp=4 nvec=4 rv=%mova_rv off=%off1_x4
-- 
2.43.0


