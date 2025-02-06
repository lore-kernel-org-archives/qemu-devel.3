Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF5BC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80u-0008Rx-8n; Thu, 06 Feb 2025 14:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80M-0007HV-Jv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80J-0000Zm-9r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:42 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f40deb941so17975175ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871858; x=1739476658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuHx6Q8iUrayT4cq+z3o5N3Kau1Z3OHMIp7MMZtna6E=;
 b=bBmpcU6MAtvk/LK9+BPy2b5yMBtL+vWOs3s5SYokAr60SHPsnpdsfCcj1QY05qKp3s
 Cvs0hErVGfdwxjlCnP7R1nK/6oBnXpofQeCylaEy95xgAw8S8re2GOZaYgimmCCAeZsL
 mbnnk/X722nDzc8tQ78OWjYAXFmiNC+DQCj0wUdV9WizYlncqW1SCTUKiScTy9pP12xp
 SCziwLTKLb8vWV+Idz/nncr1iQg/OzIWoOmI6zb00zg0I3o2r8uaVs8Cz6p2zOMOYgot
 EgjFEuhtRWBzldJpNLCz9ko8wFGpt1cA0T9Y4AlHB7rJrK7i4O8ThnTzhWHxmjDtTh8g
 z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871858; x=1739476658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UuHx6Q8iUrayT4cq+z3o5N3Kau1Z3OHMIp7MMZtna6E=;
 b=NTqBN4jAA86ZW1mONaGG5LFygOTc2T3DXW116qKe0sjDXIiCREi6JpjPHRrBrOPkC+
 zZVSMNyfz/+oE4nsyE9nxkoWAWnY4DZzoGz28qQ/Ju+sz7CZjTfCkNBpgdYilGVTVvdK
 /XaQoKt571ZbMGMUd6MKko0vBClIWBwtNFW0FfGL36RkdDxFYsS+pS2JFq2omXWmjojA
 kQ86G/SPY5BwbctCH4+v/Jrpz5JM+R/hVoYrcJQUNT3B7BTVlR651aYt8zmyt+RKXxdS
 wfTsXmOGlIIMZ3KINMl7Uvkj1KCEi+fRKd+is+M57qpI98P6QBePlXBw5Bpll+Lz3NzF
 4Bpg==
X-Gm-Message-State: AOJu0YwbMx+J2WNDV5NfeM0NXnfUgzfwRvVNXiq00mepJ4ZjdirbcFEr
 7X5/d70xSPZ8IiPanghy7OX5+ufFuIHqZWF713skvAG5CySafsa35Nl7sYbbZi1cUOQZYuwr/4k
 W
X-Gm-Gg: ASbGnctAD1YZ9mZDvMNphJP7otlMjFVMsDY7ufjhAtPyhiOhcPrE+xaP7syJMuP+o1m
 cRx2O8ElpmB8m0wfPKgo0Vexj6JYH6idFz7l+9FjAK4cz479+SYn/Ft49yVzkTFYdOIa9pED9AA
 r4hXN5+kfr9yQytgPlyz5zq4oIvv3rYSLzh03h8tYbEmzX5IlomQzHExQGFxesMiH9WcUaju6dh
 cTfm6DZ84IEjqhCxOQkhrntIZRTnVk+oZib8PSB7JrngC0lTNaa8oJk7ywrjjxCbCH6tUk7Ltww
 KSUaHueiNkuiPnNKrH6bFe12rQMt+QJkEGMevKzXBh1qXAw=
X-Google-Smtp-Source: AGHT+IHJwWDYnpJWEZrROxzPUcvTnYtPZ8cAPpGlXOg4EY55Y857lR3urMRwORZv6Sva49AA/jjPWQ==
X-Received: by 2002:a05:6a00:194e:b0:72d:3861:895c with SMTP id
 d2e1a72fcca58-7305d45cc3bmr871593b3a.8.1738871857760; 
 Thu, 06 Feb 2025 11:57:37 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 28/61] target/arm: Implement SME2 ADD/SUB (array results,
 multiple and single vector)
Date: Thu,  6 Feb 2025 11:56:42 -0800
Message-ID: <20250206195715.2150758-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/translate-sme.c | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index c364d977f3..be39adfa86 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -638,6 +638,8 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3FnVar(unsigned, TCGv_ptr, uint32_t, TCGv_ptr, uint32_t,
+                           TCGv_ptr, uint32_t, uint32_t, uint32_t);
 
 /* Function prototype for gen_ functions for calling Neon helpers */
 typedef void NeonGenOneOpFn(TCGv_i32, TCGv_i32);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 617621d663..09a4da1725 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -691,3 +691,32 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
+
+static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n, o_zm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n);
+    o_zm = vec_full_reg_offset(s, a->zm);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, (a->zn + i) % 32);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 470592f4c0..8b81c0a0ce 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -245,3 +245,18 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
+
+### SME2 Multi-vector Multiple and Single Array Vectors
+
+&azz_n          n off rv zn zm
+@azz_nx1_o3     ........ .... zm:4 ...... zn:5 .. off:3     &azz_n rv=%mova_rv
+
+ADD_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+ADD_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+
+SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
-- 
2.43.0


