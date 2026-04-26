Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FBBFF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGziv-0006yA-Ej; Sun, 26 Apr 2026 09:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzid-0006qO-TZ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzic-0008GR-Ce
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so54568745ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210816; x=1777815616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/MQvoUvAYu+yjHEPgbSDsDM+i+7vZ7bw4Zw94qnE14=;
 b=Xp4XTg/LrTM8okfHj9KN8yuao49JKS9rv/+JS48NUrMVRJwuVTO8IiRIgog7hcbRzx
 QnUQym6QPXq1C0hVDQmVz75llq2B0wo43BMK7cmpqTroJIGr2rm+Vl2lN1kgVt+eWWkj
 MO3W7n3wBCQxRMCIzS8aYh4/ilmOLnxi4/RJQYF6t3RHMQQ5Mt3HaHi6pjHGOup4MQ1n
 Z9HhbwznGk/p6pbfisqA+CwwtbpyiTi3Zzbnm+k4/zuMve2eXztAFmaQnSajbGDxuR1k
 B7poPcWoRyRDR7ts075RoDjKazPX+hBxSaJ1Q74Lnt75g7ZXBuYXGW2vbIId6VWqt+JS
 XRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210816; x=1777815616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/MQvoUvAYu+yjHEPgbSDsDM+i+7vZ7bw4Zw94qnE14=;
 b=sHHcamsKQeDK5oFEIZCTEhMD+8STr+H8dXf0LvKZKoEB+h/dr/YVG59Vuefmkl5uk3
 GQyxnPavKUfUgD40shbwCsAOLTnsw6taisEm20bKkaJSTh79bM41D1NfP5KzZ57pSNIM
 +APTqO/JPoGx0XZ2G+HsfPPhHD5Mf12Wj+CvPrRa+rEVM3p5S5W0YS/VQjXKNDain0bz
 tWuC8Kajv2M4mryrh2qDCzjfWHZMySJ0Cf3Rpl6V+nDgW5w8S9DbHdqo3jnlGGTT0C6K
 FMPJYiI88kmy7uvMrB8g0wyrPDTdqRwXgicKbUEDogegTrEtNu1i68F2BeQG6ylukC9G
 ObVg==
X-Gm-Message-State: AOJu0Ywea3V6qZhpLDFzjnars7X020LeHTAl3MD2Nm1wSu5Ifidrl/aQ
 JF9tyMPLPKQ8Q62iHYxiMtZYT/trkvdLxT3+Ml+Ntf+wP/7UkBCZF1CkHYOdNAnEUap9pgdRk/5
 RgQSlj9o=
X-Gm-Gg: AeBDieuyQgfEuUCAq0i4KeBdPie2F/xsW3djLA8NSubqaq0J0ZcDezi5AslUJqSS/zb
 ZOcTToLp0PD+YDKyo3CVBTVqobHbvIyUOQwMxqEL4p8UVT9jnzE/M/QEYF3uWWW1durSkphcbRH
 /ll4kkyWa02DjOmaWCXRi5cSdaXBj/d1KFfV3EBlm/7vVmN6NCGz5o9eSJLBOBlQH3WYyObDQHl
 eXC5OqKsBwQ8QDBEEH15U5dGiXBSI43iX54CofRt823dH2mzzxkl7bgZGuGs4EjINC8KJNhzyaC
 Ien7FD592Yw7/VUuskFNji3pGAabY5tpLUDF3mnCH806o91E8S+DlpQ/rSfc1OSZD5l+9AE6vCY
 w6oF8PLPzCm9aHMHFM/snZ7PTIS9IwsujvBwWeiUNLhxaSvlE+n0fhSloeFZgjA8wiPDvE2fy/F
 OCjzC2QhfKWZq8tMf2dtu0yDcCZ/OweMJjOV6lUpNg
X-Received: by 2002:a17:903:3805:b0:2b2:4dd2:dcf5 with SMTP id
 d9443c01a7336-2b5f9f527famr392838925ad.20.1777210816513; 
 Sun, 26 Apr 2026 06:40:16 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 03/84] fpu: Drop parts_uncanon_normal
Date: Sun, 26 Apr 2026 23:38:40 +1000
Message-ID: <20260426134002.865628-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use partsN(uncanon_normal) and the single call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 8 --------
 fpu/softfloat-parts.c.inc | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7c13a7848e..4876a8bb27 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -806,14 +806,6 @@ static FloatParts128 *parts128_pick_nan_muladd(FloatParts128 *a,
 #define parts_pick_nan_muladd(A, B, C, S, ABM, ABCM) \
     PARTS_GENERIC_64_128(pick_nan_muladd, A)(A, B, C, S, ABM, ABCM)
 
-static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
-                                   const FloatFmt *fmt, bool saturate);
-static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
-                                    const FloatFmt *fmt, bool saturate);
-
-#define parts_uncanon_normal(A, S, F, X) \
-    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, X)
-
 static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
 static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
 static void parts256_add_normal(FloatParts256 *a, FloatParts256 *b);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3c323c0cec..948eb7bd6a 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -482,7 +482,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                             const FloatFmt *fmt, bool saturate)
 {
     if (likely(is_anynorm(p->cls))) {
-        parts_uncanon_normal(p, s, fmt, saturate);
+        partsN(uncanon_normal)(p, s, fmt, saturate);
     } else {
         switch (p->cls) {
         case float_class_zero:
-- 
2.43.0


