Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016E3F9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX4g-0005xb-GX; Wed, 22 Apr 2026 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4b-0005u5-DE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4Y-0005RI-S3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:52:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7650202fso4257465f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862373; x=1777467173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
 b=apmCZBCSxrYyZthGBc+uAQMwMicO2g5PCwX6xX9Q0Aznh7KROkEH7Bi2gnpQD87F6P
 xYhRCVZBETDn70wfm8k/MUr6UD1VuOSGV4VYQCXRg3f4nrMC0Ks6MCBCmXlU6B2OQHeo
 8r5GCvZ7MJfkHas0vjXO8zhiMPXE3Ns3bEOsC4TbUJBYwDEnRQVTOLFXXPFDV9ioLBZj
 yIOxY8wxE993gY8cjiy987krA8xIf2/fPT3wpB+t9CIDnhdpb5wwliPUTvD/IjAKICPk
 XaEBLZi2GRc/Q3nnZIPuYKVkRKb9N9LpFYw4Q+jPyR50e7BA7uF0p6uC5ErDqD2HD7w0
 sklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862373; x=1777467173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
 b=WJd38wFdmweDRCXQuLEor31IV/jWCtd8+icxoRUBctUIrrXhshKaejMiYNgCd6QxwH
 bVzciF6/D2yOAhbiEDMCvfarEdS+JiHRhWchKeA59kaZmwsJGZ9xj6wl7Fkzq1qWDqrh
 TZLsLb12y3aKh1bR2ES1CwwNIAjKpVDrarvefPSqtGovqtWlO9hT7jk4N8kd/0Nl3qwW
 SgAM1vAHLyBVANDLZRfVeQOz6SF6GjYmdVXIRHmNpC/POWFkN+RMyu3siFy8pHG4pOuj
 YtvI6Z+c8LQq5ZARaHyXdCt/ATrRAcd1IWtD0JZMkG6mChQGk13UhBydEOs3Zaxv3L52
 zSZw==
X-Gm-Message-State: AOJu0Yx4mOygQBk7U+pPcSkFMNJuo+jCzRRJjD/SXQnLQ8V+Bt9K8ex8
 XDfdVA5Y+p566aXWb4nx7nR4hrHKSOs/ZeVf9Pz2WyWtRtolstmTcBZWmxIJizYNXcA=
X-Gm-Gg: AeBDiesLMsOOOHguNZuvksypO8emm3feojS2HDHC7Maw0xemlwPCq2Mq1wLWBgGAhbb
 F0vrAj0xjXpkbOEgYWDqWr54D8XWwP9pb5lM5kGMPaykWc6lZ5AJD9vv/rRRVqZCA6ihvUHt+yl
 miZzHtjyvhrpdeR/cRkdV8hOqBgtpBM/UhJhXJ0hgdZf8U3dUdVs5jVWJ7XViFNvU3CVEcX9i5K
 A1FrmjIif2hywHEHPDr7EqmosCngn25KYRXfc00sSU/ZRsZdMBZvT1uMEtNGFpyLhiRcnR4Spt0
 ni966YGlx7p81O29AWymTLSY3CxQqNo5x/JI+BhKHlBVSVC6brMLzey464wC5futgxfpHnrjmlO
 iL84PNQWl41JoVYE4IlgTbIxaqyg5lO7AE/gGUSnzCVTzhCnJ44jAisPfRkR07wAJzlL39Vd7RG
 k5sh3UkNxZHCsD+D1dEWjTh4NXfZiM74NOfA==
X-Received: by 2002:a05:6000:200c:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-43fe3dd407dmr34461259f8f.19.1776862372594; 
 Wed, 22 Apr 2026 05:52:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm46907702f8f.0.2026.04.22.05.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 330505FC04;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/32] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 13:52:20 +0100
Message-ID: <20260422125250.1303100-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The syn_simd_access trap was never used so remove it. We should only
see the COPROC encoding on v7 architectures.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is16_bit directly
---
 target/arm/syndrome.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 29462aa103c..72051443d59 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -337,21 +337,26 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an access to a register of
+ * instruction resulting from the FPEN or TFP traps.
+ */
+FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COND, 20, 4)
+FIELD(FP_ISS, CV, 24, 1)
+
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
                                           int coproc)
 {
     /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | coproc;
-}
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
 
-static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
-{
-    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (1 << 5);
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
+
+    return res;
 }
 
 static inline uint32_t syn_sve_access_trap(void)
-- 
2.47.3


