Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCEAC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83e-0006m5-T3; Sat, 21 Jun 2025 19:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82U-0002Oe-2V
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82S-0005BV-EP
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1423943b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550063; x=1751154863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OXrVKV8yo29+fdQbU0WV4uup/oeMvwjfooz8b7kJn6c=;
 b=je6iJowmoZx0bl4AoYbhl19B7s5HFFVgQWV9p18erlNPVOWgOzFLbLM16wODUGy9sk
 afukhwOFMLwayLd8UZDA9A9tUZpqM/si5Bkzp/LUMrIAHz/4LuVlA4Itil96mTTl/egE
 36D7UecUdwI/h9k/JZjMJG8d6axpkMqPrUgeb1AOlyUKjGWqC/8j0M1b6tR92KiEGij/
 lcvVAdJROmlpO/C/0/xVV7PLhta484m0hHwrIda9P6aj8e5t/QwQ35XNVIMDbJDU6YQJ
 +BetJW0rheadhYoSYwXEF3i0f0i3P9ys1cmu24gZqGa+EyFmQi7kU/L3gGZKJY25icY1
 FqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550063; x=1751154863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXrVKV8yo29+fdQbU0WV4uup/oeMvwjfooz8b7kJn6c=;
 b=RAb/zQMkjj/XxFPx1KiP5l9q2Hy1peAhi0LQdjHhQOEMnLJCm6Ls40LIPC90RlW1qk
 ixaJUuS3+lRnmEj3lRpChBArb40hBzDP2ItUE0OJqpcYcnO5wHSng2JbqsTR77RGqXj7
 YuYej+O/q/f9aGLKr660nHyt5ktwWAI/NP/JZ2gKsDGBjPxyJulnORX/fnnmzSt7S0pf
 0ye97MKgvldrNPlYVxUTa3EDY4CZCLGsHmRJFlbOd0vf+kFO5sky/qsBOg4FZiDqQd/I
 XkGH24MN+1DWbGm+MtHV1kzvyD3/fm1v3Dd3DvLKTLgne4tVnvd8uDgoPYCK7Dq9LjNM
 RLrg==
X-Gm-Message-State: AOJu0Yzdm8ZKlbPiXoVxDaTNRu10QT9mYbshNcIbljgodAFYSArmVLsn
 DCbJ3lesc/e+xMzn8Hm1vdrSTfN8yYqqWL5130VAsBzjkjlQVMrRlFdSY5KYIu6ZLu18O+KuzQX
 wk893aJ4=
X-Gm-Gg: ASbGncsphJUUXI8JA/2h5I6EkvgJoOxkov1OoO3UfDiZR6yuT4gZqiX9nMIN9AvJZPB
 Mhl5HnYqX155IS1cyVZZVf85wlaKZdQ0/3onARB+y1ZWC/E8eZWESO5mg+z6RBgmBo9fWLDbpx1
 uFV6T7VX74c8thJ03JElcUT+0MROxEQqz0HV9/aS9BLxgXHAbyxnVZ4PFR3XkBzjh1PuArYBXcF
 nqq0qZv1pGYa0fgY/qTBaRwHXr4kBNXvOSZqrrN1q4NxnF2FtjkUW39jUDrIURTCoczXV4AKHrq
 theIROyC55lF6NNnWTnQq+bxPa3g234wuF+sacYn+XjOQ7G+P9jBI5oOvYWpuuQAG91QVt9fDzb
 VMN8Cx7dgoBfu3fP4iDJt2946IiLd1iI=
X-Google-Smtp-Source: AGHT+IEgRDStiTWbH8QCrwCA82QM4qKpTwoJJswRfvz3xJJ6BDqk+qncwwlacbJfc6CzBgPVNNE4iw==
X-Received: by 2002:a05:6a00:4f8e:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-7490d663722mr8968090b3a.5.1750550063031; 
 Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 069/101] target/arm: Implement SME2p1 Multiple Zero
Date: Sat, 21 Jun 2025 16:50:05 -0700
Message-ID: <20250621235037.74091-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/tcg/translate-sme.c | 20 ++++++++++++++++++++
 target/arm/tcg/sme.decode      | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 186d46ecbf..4d82666d84 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -158,6 +158,26 @@ static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
     return true;
 }
 
+static bool trans_ZERO_za(DisasContext *s, arg_ZERO_za *a)
+{
+    if (!dc_isar_feature(aa64_sme2p1, s)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / a->ngrp;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, a->ngrp);
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
index 80fe02190c..d0dce75a0d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -885,3 +885,26 @@ SEL             11000001 esz:2 1 ....0 100 ... ....0 ....0  \
                 n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2 pg=%sel_pg
 SEL             11000001 esz:2 1 ...01 100 ... ...00 ...00  \
                 n=4 zd=%zd_ax4 zn=%zn_ax4 zm=%zm_ax4 pg=%sel_pg
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


