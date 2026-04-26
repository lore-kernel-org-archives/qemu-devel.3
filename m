Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F7FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzki-0001Vn-Bz; Sun, 26 Apr 2026 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzk7-0000Ir-Cd
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzk3-0000MW-BF
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b461310af5so36489775ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210905; x=1777815705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2oP1AoPp9GVb73a8OxFUw9mtARZFRgHS2lzcILL9oU=;
 b=XYW+Xj+u/Yp2jS8KUoRexC8323XaO4zY3voJnf/O2bXkZfaYzctRww/c3vOqa9yymk
 ZFLIjmF0LXoL+VhLoqXP4lMAB0GUBwXFjFA15Oj+mKSD8XmBFRXWrd0Ntm6pQOYpDNWz
 Uy0jNaR+5jiUsy6Qe+c0IUlZk4sPCNhTmwNu5Z/INRSJmxQL7f83So89I2HCF1kWXoWK
 aG68VPxC37b7s43pbfE/2BueKMo/wME5ZYZ4yvQxS6gda0QApyYjT+KqIPyJ1PmVo5Mm
 5VcmE4LaOXLSeEeP0Q0CoPyBTSjsddqAy/PcwicjuRirofDwT7BlMLt+4I92qPGKmv/3
 hXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210905; x=1777815705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2oP1AoPp9GVb73a8OxFUw9mtARZFRgHS2lzcILL9oU=;
 b=darqGoJmSI/MoQ8zh1GnV6E7lS7ECkpVRzyFGfIgU+tZ7XXhR8NLnRHbaloBYG7OWG
 hNSqndy+iV1LlmgIx3tBiqa4akclfx+opLldYe5t2Rne29I0FIF6c3s/TPrDnfFqBASp
 TgcA5YoTlf+bxk/ks7FiYntG7F+SDlwZ/qly9feg2F6rSJ7e4dTUIb8SqcmAcN55Vgz9
 VWJ9gAd8en3A9tgJKwoxgMpm5SSbtmHYRVoY0myn5RwNoKMR40bHmGUJFMP7llosmU6t
 pyO/gy9c11PphpMD/Vci9OJMh6ZiJhRgIIbk8aG7LolQomTQEzKbhErGg1sHBhmckiWE
 bI0A==
X-Gm-Message-State: AOJu0YyO+PjwGFeBABi/nUfh9Zl+gEtn3jKdFVMqv6990Puw+4IFPeXi
 bol0O5JBkGKSM50l4Qja9yVB0AUpOxcYOHqhcaD76i3q6Q2LD5h0uyAMVl9VxYFou50ZrF9tdIH
 TFGRxK7s=
X-Gm-Gg: AeBDiesHQ0iS7CupokpEl/xFzoq3dVMR+RXFS6bA6vHL44eQswxxdKuSnaRFyNRl+fj
 yZKU8kt3MnKTuf3uvuXXLoPlclYffkMjHY1NylCwhruFtt4KAIU0iKsUtsuz9qAk1NT6kMbOkso
 h9YBgi0+/Qk9F2OZQh+MTXQ6pvWCiUnjsqKOf7gq4RH+ZUwSVwOUYn8fRCiLm99vqjBQCatIuNw
 dHcTnRvLMuAy8OrqTpF4q1p7ITZaX9hqMp7mSraCZNP3eVwkozqichjild701xfJxGdqDg8OPef
 CpWEGSwzRlD0WYBnzXR1VWXMhQJo1rHdyD1fU27+n7mU2ZdkGEzjgHZKxTn0OJJVEihoRp/FZ8z
 qBOqAqqB4QsNlDPU1MCKpAq2qr0kc4W1E8Lxro5Ze+RwsuJRvRAHa7uCeKHh+VN+UtSOBU7PubC
 ZlhNpNryetrux7I4nUGEPR3fO3VAi4rjk0TjqqyNqtKjYI4n3r718=
X-Received: by 2002:a17:903:1ae7:b0:2b4:5e85:efc with SMTP id
 d9443c01a7336-2b5f9ea55b6mr335417835ad.18.1777210905330; 
 Sun, 26 Apr 2026 06:41:45 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 37/84] fpu: Return struct from float16a_unpack_canonical
Date: Sun, 26 Apr 2026 23:39:14 +1000
Message-ID: <20260426134002.865628-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cdf95a8517..dee5dcd0d2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1474,17 +1474,18 @@ static FloatParts64 float8_e5m2_unpack_canonical(float8_e5m2 f, float_status *s)
     return p;
 }
 
-static void float16a_unpack_canonical(FloatParts64 *p, float16 f,
-                                      float_status *s, const FloatFmt *params)
+static FloatParts64 float16a_unpack_canonical(float16 f, float_status *s,
+                                              const FloatFmt *params)
 {
-    *p = unpack_raw64(&float16_params, f);
-    parts64_canonicalize(p, s, params);
+    FloatParts64 p = unpack_raw64(&float16_params, f);
+    parts64_canonicalize(&p, s, params);
+    return p;
 }
 
 static void float16_unpack_canonical(FloatParts64 *p, float16 f,
                                      float_status *s)
 {
-    float16a_unpack_canonical(p, f, s, &float16_params);
+    *p = float16a_unpack_canonical(f, s, &float16_params);
 }
 
 static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
@@ -2701,9 +2702,8 @@ bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
 float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-    FloatParts64 p;
+    FloatParts64 p = float16a_unpack_canonical(a, s, fmt16);
 
-    float16a_unpack_canonical(&p, a, s, fmt16);
     parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
@@ -2711,9 +2711,8 @@ float32 float16_to_float32(float16 a, bool ieee, float_status *s)
 float64 float16_to_float64(float16 a, bool ieee, float_status *s)
 {
     const FloatFmt *fmt16 = ieee ? &float16_params : &float16_params_ahp;
-    FloatParts64 p;
+    FloatParts64 p = float16a_unpack_canonical(a, s, fmt16);
 
-    float16a_unpack_canonical(&p, a, s, fmt16);
     parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
-- 
2.43.0


