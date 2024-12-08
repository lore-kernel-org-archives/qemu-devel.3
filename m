Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067AE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5E-0007A9-MB; Sun, 08 Dec 2024 17:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5C-000796-Em
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:58 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5A-0006Dz-SK
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:58 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71df567621dso89513a34.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698136; x=1734302936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRa0RWX8JWWgFHE4wF27O0iRwodZmuUKdq8/kFDIfG0=;
 b=QvKD02uAJJ3zUM3JEmrOLo3lc8teQvvo+TkR2kHuDWmihecFmt4/BZWmdj91SzSV+J
 iiNcx6vR0QowzTJuc+tj+GJiFxaRR+nw+3Ekyk26yfKty5HnmAi2JpNrPBvLsJ2VvDK7
 /qPWWSyD4TTFiYSfSulnGA8eqnYpmTbgtrmBd/DnVHX/+awXU4jZGuSIdwdQYBPNK/N7
 of/pfuTxi7xZaT/QIFX40QvwZ+2IyChwwj9iZBr99cRLHYEslxnTp4C4x8bAz6LWnGC4
 bVUgBbiBhcwTjfSto83v56wL7MnCvNFgPy6qs9GB/hmHSTebekcvhSmjQGGuoqPbPcTL
 Z2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698136; x=1734302936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRa0RWX8JWWgFHE4wF27O0iRwodZmuUKdq8/kFDIfG0=;
 b=OYSVQYIAMZcsPoY3INrv5g1646LP8NJhpOiQ6n0n5GwhUNj3lW+28wbXFYAe437K+Z
 B7IMJY2tfyMm3M+Ke+e3lwObL/oyKL1Aefng/ukSdTbNBn++K3m+EmDfdvBRNVcL6A9q
 kEer++uKkL6+VJB+ehDHRsnbTuOeeSzK3Rb1xSG792J3l4y4sRSV13Q9JzUAj10AUWmw
 CvPr5h/aqnO3qQNAkmh80e/74B9u2mtLfOdlxlCPGM58u4bnDKCEwi0uDVZF5l4q6/pX
 d1kc64xIcDM0uyQoO2G5ZiKuSgl7jx9dLgl0jKwx7ytmNHZiyGhH/vOfCZ5w+JsTupFt
 hoZw==
X-Gm-Message-State: AOJu0YyL4sPKbBBRozOVbCJrOjyvnoIt2J6xboavn+81B90EjZXmslv3
 sqrfbVyKWCVIEZgIG0l66BtehDbEjeIoWAWM5jW9LglK05bQg/7EpOss42yqfFtI2Zd9mNUN9yy
 rRJaG3g==
X-Gm-Gg: ASbGncsFp+nHKfTKP1hGSwKOhKz6HobN1VsSyhh+zFUYIrow9kOUtBNpcMcCYuLyhmC
 6vinX8YpuqJXdnzZQuXscWYZRSa2N8sVblEckMfkuD5KZpKT2H+exik/dcD2BkXs6CaLiAhXxDo
 +uHLe6Yyrbed0Vrq7XkotQwuinXiPbTYvaApFYKTmupBol1IAIQj0QCdcG71gecyjXxTltmXc05
 lEjz5ZovLtekzHveTmLu9N8vBMF9AWiCcwy82Vjn1vPG8t1bFrGjTobo/d/spwlV/bYKWc9vY8V
 0s5S0dFIVXBNG6pbsJzUohd+YGYyiDFUiw38
X-Google-Smtp-Source: AGHT+IEDmS4xt/c+E3XCEJ8qNCrcJBhS9z+QrNID+79DwYI5QPesy+sjvBCkX1/4yBGgnn4DLQU+UA==
X-Received: by 2002:a05:6830:4992:b0:71d:5a8a:1a2f with SMTP id
 46e09a7af769-71dcf4e6b84mr5932360a34.14.1733698135791; 
 Sun, 08 Dec 2024 14:48:55 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/17] target/hexagon: Use float32_mul in helper_sfmpy
Date: Sun,  8 Dec 2024 16:48:34 -0600
Message-ID: <20241208224844.570491-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

There are no special cases for this instruction.
Remove internal_mpyf as unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.h   | 1 -
 target/hexagon/fma_emu.c   | 8 --------
 target/hexagon/op_helper.c | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/hexagon/fma_emu.h b/target/hexagon/fma_emu.h
index 91591d6050..ad5df5d038 100644
--- a/target/hexagon/fma_emu.h
+++ b/target/hexagon/fma_emu.h
@@ -32,7 +32,6 @@ int32_t float32_getexp(float32 f32);
 float32 infinite_float32(uint8_t sign);
 float32 internal_fmafx(float32 a, float32 b, float32 c,
                        int scale, float_status *fp_status);
-float32 internal_mpyf(float32 a, float32 b, float_status *fp_status);
 float64 internal_mpyhh(float64 a, float64 b,
                        unsigned long long int accumulated,
                        float_status *fp_status);
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 05a56d8c10..35971b8b99 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -655,14 +655,6 @@ float32 internal_fmafx(float32 a, float32 b, float32 c, int scale,
     return accum_round_float32(result, fp_status);
 }
 
-float32 internal_mpyf(float32 a, float32 b, float_status *fp_status)
-{
-    if (float32_is_zero(a) || float32_is_zero(b)) {
-        return float32_mul(a, b, fp_status);
-    }
-    return internal_fmafx(a, b, float32_zero, 0, fp_status);
-}
-
 float64 internal_mpyhh(float64 a, float64 b,
                       unsigned long long int accumulated,
                       float_status *fp_status)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 90e7aaa097..b8b556f4c6 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1157,7 +1157,7 @@ float32 HELPER(sfmpy)(CPUHexagonState *env, float32 RsV, float32 RtV)
 {
     float32 RdV;
     arch_fpop_start(env);
-    RdV = internal_mpyf(RsV, RtV, &env->fp_status);
+    RdV = float32_mul(RsV, RtV, &env->fp_status);
     arch_fpop_end(env);
     return RdV;
 }
-- 
2.43.0


