Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B3BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFz-0006ax-KW; Fri, 04 Jul 2025 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF2-0002Ap-W4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF0-0006pC-22
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so598394f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646380; x=1752251180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FSMUiGqdOPCQ1rGDDv1oyUjISENai/5CF90hWO6aEwo=;
 b=AxcD2yulv8gU+6XCcsvG1ZgK5QsiKnBtmssjxLBnm/WjKU0msAgB0pFOafNLAUBL1c
 c0eCYBmbXwx7Ft8HHAZLSTZTTAPepnLEyD8VzgVz8tUJSwEQhs7pN9ut9n/eythEN+Tg
 r8GwBvncM6AQrWGJcd9V6BBtUcdj1exBWX6rekwNErIuRD39Ce1u2C2FbuFtiis+GVK8
 nBppVCPtwpK1AHBHufUrxsaAIjufwDLJBYvJEQqDmOUxPWociwyyVe4YrvFgcSSbLv90
 voFjIhFQN+I4Z4NZL0oCrW+uYTnzehsVp2wIyUIuITMKxaCGleZNucO8PUA4bjrYAB2i
 6tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646380; x=1752251180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSMUiGqdOPCQ1rGDDv1oyUjISENai/5CF90hWO6aEwo=;
 b=CP8IaoBSBTsffh+oqowb87fGTzYJDvtNyl6o+ma1iuj6biMKs+X1EnsqwxLd+5szGM
 r92zt9RN7nMG4I9ZwQTmG059Bl6Eww8GRqYTYBfSsr1U1mHhAGV9B+pOTMzBGT748uip
 f2UhbVd+nv3fcAB7KSZrlAh34EoMJsn19zVFG+QISUFP4Z4JBOS+Z6JikR4FHTK71y5Y
 sHlrYAfND6x19WLSgsIFbKStPJ1yn6RklrYX0zmdGsd65j10uD3d1NysRmyiIR5RoN4s
 +VZiWnY7t/2wMwRoHDhemX6NAVcQ9tqEWlIOzyhyHgG12k45hSVNlUq42BlLO+OGYGGW
 c3Aw==
X-Gm-Message-State: AOJu0Yzkdq6OWbj6VbG1cC7TTQT4HH37YiTloyTqicsRvoYklBtwx/zB
 gQoSBSeev5wTJptIQfKkjWbTsVpOKHwWD1epSuVyDBHR2bN159UiB+1rthWVvSAtd3I2gH1Vhax
 +5N9e
X-Gm-Gg: ASbGncv8YIYNPJFcy5CAADpZcjkcs/BtVvpqpV+tLQRkKPpe/9hQDOJ89HxEjR+gWt2
 Jgb5Iu2vu6+DK8akHwq4fuTCVdR0dGoehRg/JT/kuXdCVdslAYBbHPX3JlgvxDcEfKrgWEL4suU
 AlvkfXoBeWCR9EW/p+g1TU51K2yCfmVvNgY4ChQXPkLILOtOGEYndunZJouU0Vy3LO0CkBRXErX
 s0b3droFzv4WDwYcnkeuQQ79/zwk2r9yNoAOeO6bpmpebfUheufH+33U7VL7YlCWnoH0mckUlLO
 TStc2DFwBVNiyjhPES3+T6u/V5KYUZh4haHyKeSTFrNWGF+U5Ih2eyN3KMtVuzEkq/6w
X-Google-Smtp-Source: AGHT+IFB+lL2OK+SY4zViA8ADR0ZnAqxKS4xQMTNdModu0F63SILAgYHbwSp8TKJ/2bDx3odiNLARw==
X-Received: by 2002:a05:6000:4011:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3b49703d898mr2612961f8f.39.1751646380476; 
 Fri, 04 Jul 2025 09:26:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 081/119] target/arm: Implement SME2p1 Multiple Zero
Date: Fri,  4 Jul 2025 17:24:21 +0100
Message-ID: <20250704162501.249138-82-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Message-id: 20250704142112.1018902-70-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 23 +++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 47adcb5a154..c4b85a36d0c 100644
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
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 99e4056316a..b6316ac716c 100644
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
-- 
2.43.0


