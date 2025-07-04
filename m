Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B3FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUG-00031A-NM; Fri, 04 Jul 2025 10:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPH-0002Wf-D1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPF-0001Tt-LM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:51 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so798555fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639328; x=1752244128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O7jmLrwj7uYx9707P2+AK6L9PFAUcM9kTC7/PievL8=;
 b=ecRas4AXToF2trg6iHA3OKedkKhUr2aQqt2MgebjTltM0mIIjDeQ478e/aXwpL4Jti
 6MCMoNozg9llNkIAPVeP5vhtTNW6+FQw3bzc1eQ84VEL7fSHWQX2YYptWxc39TqXu5KV
 4J558eSXKzes2jQKQMXSqQVUX9eg/ATOIzZwh9aYNhQYAYmiPRrzK4GExj0kA2N0g2Jg
 P1e8gPnWuqHRe94pGoEMayu1mEeTvL9ZRHFYV1XaA+DFTA5Css65sZRdIUdWlVoT4gsS
 hJu1PzDj2NpEVtCpni9chd+0OqcTmsEOTps7Lod6ImI1EaYZIECvWiKVmdM/3WbapuVJ
 Qfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639328; x=1752244128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O7jmLrwj7uYx9707P2+AK6L9PFAUcM9kTC7/PievL8=;
 b=v8XoYwpwMS8SxGLbSuKXyIaqV13cd/0jt/p3AyBeeuV6c9MWMX8+eRFrKtcwc5fS38
 e9Fs7MIgNh3kGMQywqJysBb26PRDS5RL3G2zHfBjtFtqXoNolpNq8tBF0L9013BhNuvs
 vJNOoNHUDA0DHOFce7Lc1U67t9Ps4ifm00HOZIcD7NnC71S679g/deLVEpImHqDbrSvj
 IhV7QIvOOoPH4TG2JLzBkyvmDiKoC2quKtW+ccBrSybIpnzJ/Uoz+SKwWlx5sVeT/UX0
 AwmV0nsdeFAaqareUj+WdBeCdW9HhRfPNX7bjgZoy5licFAtH7hwgPOBe0gOMB4v3AbT
 wu4Q==
X-Gm-Message-State: AOJu0Yyz2RFeo36fotDdT5txvwKCV/m0+5vzC0lkC60v8yRMaTPlLL+J
 0/EDvwZOxj7ht+UQ5tDkHSRqFsgBOX7FH7im8WpO5tEttW9gBJGb1YG1N/qNA598zWlWKZT1YZs
 PFm9d5W0=
X-Gm-Gg: ASbGncuf9C1zyzmTqTgmVCIFWn69Vo2Hqhjw8pz1IsFXpXzJb8c/wsghxAx4qd3lcAt
 df6giHd2JCvCcQdQS1pRSVHSxp17q7aWO/+lpgHNTBhDvWNC1tMVyaKL0LwvH1Hk+PfhR6ZHytv
 6Nak3aAvJ+RWN7atn/oJt3bTur480aI1UGccyzUNRnxI55d9OBi2MMXeJuQvlJQpi7kxvQhqSaw
 DIlq3mTofNKl2FmSItL/6GWFxcBy77GBlZnDuzenmAC6aYH100C8RyJFoJSDeuYQ3PTLTK8o4G1
 wPVn+wLgiursdjSOSO0IMN7WVsz9SOGB1BzUclaJTYu0coDOTV8gLyZiokfjLkBfugTC1anugsT
 dGU1CADF/DmTMPpD1jCnADOhQxRkoVhg/KqLabfDublMz74IW
X-Google-Smtp-Source: AGHT+IHCpyaMlJvjghflFTZakZQcFiCqJUv+AKBpnulB8coo09dMZMWFPtqgeuPbRGsH/9OmSfE8QQ==
X-Received: by 2002:a05:6870:e80b:b0:2cf:bc73:7bbb with SMTP id
 586e51a60fabf-2f796cd0dd0mr1763771fac.25.1751639327945; 
 Fri, 04 Jul 2025 07:28:47 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 089/108] target/arm: Implement EXTQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:20:52 -0600
Message-ID: <20250704142112.1018902-90-richard.henderson@linaro.org>
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
 target/arm/tcg/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e33b2eb2a4..a918da31fe 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2202,6 +2202,55 @@ static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 TRANS_FEAT(EXT, aa64_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
 TRANS_FEAT(EXT_sve2, aa64_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
 
+static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
+{
+    unsigned vl, dofs, sofs0, sofs1, sofs2, imm;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    imm = a->imm;
+    if (imm == 0) {
+        /* So far we never optimize Zdn with MOVPRFX, so zd = zn is a nop. */
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    sofs2 = vec_full_reg_offset(s, a->rn);
+
+    if (imm & 8) {
+        sofs0 = dofs + 8;
+        sofs1 = sofs2;
+        sofs2 += 8;
+    } else {
+        sofs0 = dofs;
+        sofs1 = dofs + 8;
+    }
+    imm = (imm & 7) << 3;
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        TCGv_i64 s0 = tcg_temp_new_i64();
+        TCGv_i64 s1 = tcg_temp_new_i64();
+        TCGv_i64 s2 = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(s0, tcg_env, sofs0 + i);
+        tcg_gen_ld_i64(s1, tcg_env, sofs1 + i);
+        tcg_gen_ld_i64(s2, tcg_env, sofs2 + i);
+
+        tcg_gen_extract2_i64(s0, s0, s1, imm);
+        tcg_gen_extract2_i64(s1, s1, s2, imm);
+
+        tcg_gen_st_i64(s0, tcg_env, dofs + i);
+        tcg_gen_st_i64(s1, tcg_env, dofs + i + 8);
+    }
+    return true;
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2650e00f80..af4fb966bf 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -583,6 +583,8 @@ DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
 DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
 DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
 
+EXTQ            00000101 0110 imm:4 001001 rn:5 rd:5            &rri
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
-- 
2.43.0


