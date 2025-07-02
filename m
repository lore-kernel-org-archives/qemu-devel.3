Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A3EC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwns-0001kq-TO; Wed, 02 Jul 2025 08:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwje-0004Te-HW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:48 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0002Ac-Fu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:46 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ea65f5a0easo3851522fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459913; x=1752064713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yBWAZDHQwxGTcAUdxImRflpZACtfYkwPssm35P4I7c=;
 b=OQuiGNudLhcUzvyDk8ai3dnWme7vEdsTugA6oDBZwHZqHs8yekFWfjaOazF/AO7lM/
 nNmUvdkkK9G6yE3AdYhpl4EVt9lob/6q3QEeKhP/2m6/tYefisD25CCga56gXQwwyCTE
 IoV+GhZi/wv1c825hQtlkG7pjUOivSxUdQk83zgMTk3F5B2eWvWd9C2jBJoB6Tm/gIgx
 ZDK//e4+hVd21mEyfLqwkPMVefZHLXVJT+r7eJTecQHw1YpSIDVLBupagjIFNxSwU6+f
 Qs1EKip5sYndgMi2SOzmoIIHNlsvwY9EkenqimoYNt7IsIC2KPgFEf2MiBvt1I9mWVeV
 AKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459913; x=1752064713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yBWAZDHQwxGTcAUdxImRflpZACtfYkwPssm35P4I7c=;
 b=mvT5yMP82WPoZvJ85M4SehVYc3wyEQHF2qwP7OScBhW6Aq0TyLhzQ0dFXIjS9vJTSC
 hn9c38bZ13DHFQpwAlv4KTrr3sc0MQpK8o7B1QBnWGHTaQN6Xk4gFc2RomKS11NwmqS5
 S8Onqi4yGO6DLCd50Q0icVuYIRvHQQ+8Gp0fxGZJRZ86ke8/TGoEYkEXv4CbKTKwcjg5
 XR0BOF1YY19eFCK+CjrovOeF0BiIqpjCIqRsobag7hldJyLcsQRr7q50CMnOrOhu26uA
 irqb1s5M32xcE50d/jhg6zN2Mv1mCY8/sIFm2bEGSxe9ZLOoHHsMEvmvo2DK+Pzkwma3
 /93Q==
X-Gm-Message-State: AOJu0YxHFQqf4TMOusNnep1o+rGogoIseVHgoR96XljAOsKSX/+1Cytk
 lBAajlpZEwHCDSw82Gc7zl+cB39iU9trWakvJi+rRC/zYcRlPODK93BbDGgrCEuTFrx4uxuNwVi
 i5MCclsg=
X-Gm-Gg: ASbGncut+393+1BIc+s3fZHt3KZxWqclb4mWYJA6t3pH6fIkezQOWhp2MN3b5j3vhp1
 Os9SI0gvYFlhMb4gXHelGgUicIAezSBV078PfEqkrYm+JRUgfSxsW889nhDW/jtbPdXJ8exWMkM
 4qYiRZRlbc6xbS7QxBu4uWf2m8skhTnj7V0jE3AGakmxB5bap1tWmsLeF0T/xQujbOxAV9RSlKl
 8ayvP0ILcIS6mulcjGdFc94EYmjoFjWEOnGhFRCQJuYZR7ilLRAhjtkzvt/1/shjMUzhGq5PUHI
 iySqDQo42hUsY1zLHJAkBm36WcUpyK8oZkcla69osOX7Itz6Yslrf0nhwdOJiJniBWfzbA==
X-Google-Smtp-Source: AGHT+IHA+wRKA5Q3ebYYhhPZze8uxZsAbxpmm6uHpolgP/vp9ffE52wmdK1MhIgRKlIxWFq2xsxZ8Q==
X-Received: by 2002:a05:6870:4595:b0:2ea:83c5:1e27 with SMTP id
 586e51a60fabf-2f664819f2amr1931400fac.12.1751459908349; 
 Wed, 02 Jul 2025 05:38:28 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 59/97] target/arm: Implement SME2p1 Multiple Zero
Date: Wed,  2 Jul 2025 06:33:32 -0600
Message-ID: <20250702123410.761208-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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


