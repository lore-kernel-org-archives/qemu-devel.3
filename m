Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B9FF9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5e-0006Zd-5c; Wed, 22 Apr 2026 08:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4o-00062T-1O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4l-0005Wa-DX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so45460095e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862386; x=1777467186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
 b=igYVC1UnAeREQlFKgMkH8vv7v6oFKSl0IfrPmHFs2R9/bSFXWqWO8Y6uibCKNIVuJB
 BJikTwkXLyMBCROhchzYqgdxrqPXBi/EQzdKys3KEPlIo5ZLsRhCawLJs4Jx747vU0KQ
 vF+kf5rPJpw39rnTx+v3A3gvTHtn1dmZ+7KderIxjlvKVhyj0p2Vb5Ht0YIh91a51M4Q
 lHVsV7hk7VN2cd4RxpP2RlE1RiF9DDjTgnLLqC44r7A80LGmVSc0VBJrQJesygVjigt9
 IiPqp/FSSIvttKzUDpd1orJyOu1euRGtORj/wZR29avplP4z1DOphrojBtQkjFOjobvt
 aK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862386; x=1777467186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
 b=hpknWjmLcyNidGEV4vcgztA/o7vcQgEX32QShDytbQ4MS1Q8cZg5ay6DE1XJSvvwNP
 iQytnyV8ThVpQnQRlOuSFAEw6l8mEUolKSdLz+KdWRxHHQYINi/R+BDFvs1tlcWxr4sY
 BCikm2ryixUKEnpTCt6m7KyCoRMOtme6BSeJ8cq7XZR6NpdZjAEsNaspAlXV4RlQ6Rho
 CBRieC5sTfKohmCZTfIKaHTWMuEHVpSfMJIaIKSrZn0BvYSkSROca9c+7cOJQWAEBVj2
 e6kfGpbz0r0xjUSadONjAJNTiPqDPVooXI+g1Ld/8rAKUCm/XsNcslSm77p0PAgmCguu
 cP7w==
X-Gm-Message-State: AOJu0YxPjhSDmbEFG9tRd9JwD6XkgzJtrhltlTfwJCmx33l12pr/C3ab
 8WARLdX0JOBjgkEGAhrHG5ECS4/NEjBwE2QOOOMSPyKOqYo0Y+1Rd0/FT2p97ze8crI=
X-Gm-Gg: AeBDiesVt3Nk5sZzCDl6G/hwJIM+Hzt1KnAR2u5ua1J0D2jhYwdjQMJNOt6+pldAyM6
 xfemPjr71HV9FRhPjhlJGHTJ0FpwvQYL/Oveer0xo6v+j9XitKQd6PhpFSO/nwS6MFNkJB/CG1H
 qxzWe9e/ca6NB3QT+QMUZMxW2LDACUw+9H+oajT1wnxzENzz0bj36vzmbU64+qm7/46aXAlGhMx
 FzB3xXABuPH7vOz3ICd3BRXFNHt9YZmWCwcOVJVXiGpO4W6+iH8ALv9hQMouYYEsNMDsLydIlks
 GpcCp24hcdPpNZIDDXbPPjNYg1yJ2T3ba8ntseAebkZePNl5+1kE0hBVRgnV5WwDvsjLCAv1Ihs
 oL65QstpoIeGOjNBjiROeywTC2t0rbD1VB31hxgtj3Ufrfg4CoUBh8cwaLQGBxUKp6mOlkdMTb7
 4yiN97G3LpTWkQ16I4dC3B07JbG6XH5orXGg==
X-Received: by 2002:a05:600c:c0d5:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-488fb74dffemr247493325e9.9.1776862385550; 
 Wed, 22 Apr 2026 05:53:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a051dsm137846115e9.18.2026.04.22.05.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 019D060F3D;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 13/32] target/arm: migrate gcs syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:30 +0100
Message-ID: <20260422125250.1303100-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Tweak arg names to make it clear raddr is the data address register
number.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - rename ra->raddr to document things.
---
 target/arm/syndrome.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 65d0de63a83..7ff8c30e2bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,48 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
-static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+static inline uint32_t syn_gcs_gcsstr(int raddr, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    res = FIELD_DP32(res, GCS_ISS, RADDR, raddr);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.47.3


