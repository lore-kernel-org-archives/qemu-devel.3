Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB12CCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb4-0004rZ-SW; Fri, 22 May 2026 14:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb2-0004qg-UQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb1-0005R4-3D
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:44 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so50614535ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474462; x=1780079262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNRh84rUAghqHenrq+0cUxy5mrPbxSwReJ+c+zbc2c0=;
 b=McSgBKhZRYb+ysYFSX+96+4/hqgSiLmvvxs2Q2AXHxxmMyMwhO4n/dYzD4hOz5NUUb
 xuk2IudYSg6amayce3C9d7Vpywpevd3NNdwF9xI4pNi/plY4P+PEmjhgdr73fs/QdGC9
 vSHT+qIGYy+wWGJvSW1dk8Endjtn9sjdpZt23whb0l1weSD6ePJN3Y+j3JfyWwYJxdb7
 hA7Cu3bIJUC9zRkjenmtJ7B2MuoVBK2dWwFxFHnTAbnx5geUdtTZj89lFx1V+g8B8kwE
 sDSmRG2KwK0FM6Y/SY5Yhn+b0JWM3sGw8LtZrSXPH53Za0izA6/7jJVGJuYC9xbTfLUg
 y95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474462; x=1780079262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNRh84rUAghqHenrq+0cUxy5mrPbxSwReJ+c+zbc2c0=;
 b=Ir6btvPlwXshHGSP3ED/yZiUUEr6UVmTcIFSVSCQTEX6+D9abUaNBiBPVPpkMGLvVB
 0zP1Hab9IFomsVZmJnpqBTlksotWdUgaApgebb79ChqDR0bV6rn4v6ycFvnIGsld02/a
 OBqM5LxNke+hwOwc31nhBVqV9kBBJ385lEDzbBlWR62BpzNj8FA6bY+dMY0uufBVMReA
 28Er7vk0uW8dWnBHdTqmbco/32ZKC/UULRRfeVftiqKd9TsVlLBYPLf2lWuaY4y8T17n
 ftOtrX7aYPSa2LvqSIY0RI6og4vAVdUX05JkNxAgn37q6Yvr6JoTdYjNrrdnm5r9fyE3
 OavQ==
X-Gm-Message-State: AOJu0YxL0chU6G0vDsUZ6xIbZxfNWtUD2Q9iUQx8I7w2xPGdQkXjqD9Y
 H9SU/hhRcikKuboThkiCdhzNt//22L+B0olnGASOKwtNmxf4Zq8XxRb8xjfKpj+feROui3ecTga
 NNRY+
X-Gm-Gg: Acq92OEx8o+wO8YTQBbfAQsUsJy7rnGKQAokAH9m2nCklUfDDpjyEmrB46oaUb9sCqx
 j5AcY3HSa9DseJkguCIQzek6cG2ZQ8NwcT1hOyDS/jalSpxZoVKJupP8sSZe5JyidalJNXQm2KP
 4tSmDiOEbZY6CtSUwl6ElLMVTF6kofJq7X4/rbf3UibEBrX59ZhpXl9Myk8/AkoNhzQpfhu6yIx
 78EgUSWxqOykSm64Ns5KDLW7ERMjTVaD0YCtT4enUdTe0e37RYIPtzRuzEc/LHdWGaXpP0WBzXB
 3w7zho8YDWW5wdRqd0qLDoerhR7tezYuAqLQWLSam5E7IcQzT2hYQ1o+op2LPUvnQLeD2tJRlqr
 lnC9QaFHAcEul930rSzdpQ1ZtA24nHAzGXHQkVRuYKyg7wBrbrU8HIA/uB9+ypl+T8EpZMBzqCU
 AwQCOVQe0hJURpk0+M7eFRd3NZOu5fw06334SMslo=
X-Received: by 2002:a17:902:ebd2:b0:2bd:de3c:a021 with SMTP id
 d9443c01a7336-2beb06f9a8emr44065845ad.38.1779474461704; 
 Fri, 22 May 2026 11:27:41 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/30] fpu: Use get_floatx80_behaviour everywhere
Date: Fri, 22 May 2026 11:26:44 -0700
Message-ID: <20260522182658.184604-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h        | 10 ++++++----
 fpu/softfloat.c                |  2 +-
 fpu/softfloat-parts.c.inc      |  4 ++--
 fpu/softfloat-specialize.c.inc |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4ae4ddc799..e08d1c374d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1018,7 +1018,7 @@ static inline bool floatx80_is_infinity(floatx80 a, float_status *status)
     bool intbit = a.low >> 63;
 
     if (!intbit &&
-        !(status->floatx80_behaviour & floatx80_pseudo_inf_valid)) {
+        !(get_floatx80_behaviour(status) & floatx80_pseudo_inf_valid)) {
         return false;
     }
     return (a.high & 0x7fff) == 0x7fff && !(a.low << 1);
@@ -1112,6 +1112,8 @@ static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
 *----------------------------------------------------------------------------*/
 static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 {
+    FloatX80Behaviour rule = get_floatx80_behaviour(s);
+
     if ((a.low >> 63) || (a.high & 0x7fff) == 0) {
         /* Anything with the Integer bit set or the exponent 0 is valid */
         return false;
@@ -1119,12 +1121,12 @@ static inline bool floatx80_invalid_encoding(floatx80 a, float_status *s)
 
     if ((a.high & 0x7fff) == 0x7fff) {
         if (a.low) {
-            return !(s->floatx80_behaviour & floatx80_pseudo_nan_valid);
+            return !(rule & floatx80_pseudo_nan_valid);
         } else {
-            return !(s->floatx80_behaviour & floatx80_pseudo_inf_valid);
+            return !(rule & floatx80_pseudo_inf_valid);
         }
     } else {
-        return !(s->floatx80_behaviour & floatx80_unnormal_valid);
+        return !(rule & floatx80_unnormal_valid);
     }
 }
 
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d2a9f97089..f774ff278c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1578,7 +1578,7 @@ floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s)
 
     case float_class_inf:
         /* x86 and m68k differ in the setting of the integer bit. */
-        frac = s->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero ?
+        frac = get_floatx80_behaviour(s) & floatx80_default_inf_int_bit_is_zero ?
             0 : (1ULL << 63);
         exp = fmt->exp_max;
         break;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7311c3696e..fd3e79fd3e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -213,7 +213,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
      * how we uncanonicalize results.
      */
     bool has_pseudo_denormals = fmt->has_explicit_bit &&
-        (status->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+        (get_floatx80_behaviour(status) & floatx80_pseudo_denormal_valid);
 
     if (unlikely(p->exp == 0)) {
         if (likely(fracN(eqz)(p))) {
@@ -420,7 +420,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     } else {
         bool is_tiny = s->tininess_before_rounding || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
-            (s->floatx80_behaviour & floatx80_pseudo_denormal_valid);
+            (get_floatx80_behaviour(s) & floatx80_pseudo_denormal_valid);
 
         if (!is_tiny) {
             FloatPartsN discard;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 0b527302a5..4b6c17e433 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -221,7 +221,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
      * Whether the Integer bit is set in the default Infinity is
      * target dependent.
      */
-    bool z = status->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero;
+    bool z = get_floatx80_behaviour(status) & floatx80_default_inf_int_bit_is_zero;
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
-- 
2.43.0


