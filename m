Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E801CCD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ET-0004bj-Sf; Thu, 07 May 2026 12:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EQ-0004ZP-GN
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EO-0006wm-2W
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:46 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1093747a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169943; x=1778774743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9tARAUzHMROq9GakhsM2fWYigc3Ck01ZMugAdtTR4E=;
 b=g9xia8lT9YqkhKJ+MWUh/x/Sb/eq67mNE537V3HQIUBjEVZt75Oz9DxW3vKmcXdvZZ
 LSNRRB85COX/dkdQdXwFr5j9KleXdMLObucMYVlmHldP4AnVas+XD9w64YZYEaWW2ZmU
 BlvHTK7rnwqdacU+qbe/g9ozY4+wDO4MavOuVB7I3s9/SCiMh192JxRf3LmASBC1DVX6
 iGYLUoi2wIpeGHhjO/t15QMViPZn9K3gX16X53RQ2/ZGVUQqAAmEvSnkWou3QQx4wzjS
 Qck0tWNaALZzKag352s+VQ8Rk8aXEQH01PQEypaIxNILrdlf/oPNXumlyCwewSkI28xP
 KxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169943; x=1778774743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o9tARAUzHMROq9GakhsM2fWYigc3Ck01ZMugAdtTR4E=;
 b=YaUdl2MoRmxApEZU/TPiV7B+vZWjgSVtfYbluO+PUIPuZTlY03+aW8wsxJgxwppZqk
 4aGcJn6q9aMrpSV95SuYwwFMbOpzbUKggXfsiI0uC7YuZN/jIBAwr+jgt5SUhKPKtUBz
 NOcVvIt313y5VqjCBc/4En69zjkMyaczOTBOFy5IX6+YrQawOw34beE013r0/rKNmscP
 N1gnG/wmR8IFWncEFDzwXPpF9ABB8luBe7Vjwj/h1yr9ZlR0wYOvukN7RtmE1fdwdqUw
 1/t6g29DNZVkiYX4gNVeuWJACXQqaQVvQVBrqyq3gYekZU1LejJc63PMP39295cHWQnN
 AVWQ==
X-Gm-Message-State: AOJu0YyIZetngxZ2aaLZ0VpIZmOFo4sn5ofgnETSxledehNzymw71g3P
 71qNc9+BF5ew+wzg9xVaGVhrrE0s5C6dpdRoTCSApdQsO0H0AmMhmJKlzRYUYv69TJFCsthM2ZI
 CgLk6
X-Gm-Gg: AeBDieukIjgMny3Qz/8xjYJT944vcutJS7UqvprYwh1AxRZK9OMT1RCXGxZctxllXKi
 WKsmJkZIqtoZDbhymbWAYrfBLeqtJizs8RTTuEISMMLw4Axl4mxAVJ7NX/qcH8RnYkxEd9dSSak
 GZOID/gdzuIJuDOyUfFKe9UsVnEUK9lZdiB8kpL41CxjTPWuRlKGMspxYmC3CEWtOmEDICksCqK
 UKeW6c54bpHYXkvgtivnuG1vp3Kc0SrK5Jqvm4yzegcMxVe/V8pEDlTh48JMm08BI1YcNKOQ1wd
 WvjdSR4pGxC0HY0PW8LcAH52LG6Bf6gPBDfv38VPSdmeidFP4g5ryS/eiqImiVNrevEB4KxhIm+
 Jc9e0SLKrzH+NF/fpm7VhwIFqvXGoIbGLMZM12g4jXreo+k32Hs1907qa0WVrYKl4/RRzHVJT35
 zRecyh//kNZEa3nGZK1knBoBB24nkOCb4W0YvAhI1dzH8y/w==
X-Received: by 2002:a05:6830:2785:b0:7d7:d510:4bf9 with SMTP id
 46e09a7af769-7e1def2801emr5449638a34.12.1778169942579; 
 Thu, 07 May 2026 09:05:42 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/29] fpu: Export default_nan, pick_nan, return_nan routines
Date: Thu,  7 May 2026 11:05:07 -0500
Message-ID: <20260507160518.444797-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
 include/fpu/softfloat-parts.h  | 15 +++++++++++++++
 fpu/softfloat-parts.c.inc      |  6 +++---
 fpu/softfloat-specialize.c.inc |  4 ++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 1329bc4d2f..8c3a94bbbc 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -163,6 +163,21 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
 float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
 
+/*
+ * NaN handling
+ */
+
+FloatParts64 parts64_default_nan(float_status *status);
+FloatParts128 parts128_default_nan(float_status *status);
+
+FloatParts64 parts64_pick_nan(const FloatParts64 *, const FloatParts64 *,
+                              float_status *);
+FloatParts128 parts128_pick_nan(const FloatParts128 *, const FloatParts128 *,
+                                float_status *);
+
+FloatParts64 parts64_return_nan(const FloatParts64 *a, float_status *s);
+FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
+
 /*
  * Operations
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1cd0df4159..7d4b40022b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -15,7 +15,7 @@
  * indicated otherwise.
  */
 
-static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
+FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
@@ -37,8 +37,8 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
-                                    float_status *s)
+FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                             float_status *s)
 {
     bool have_snan = false;
     const FloatPartsN *ret;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2723bf5e61..485f082cf8 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -118,7 +118,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
 
-static FloatParts64 parts64_default_nan(float_status *status)
+FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
@@ -142,7 +142,7 @@ static FloatParts64 parts64_default_nan(float_status *status)
     };
 }
 
-static FloatParts128 parts128_default_nan(float_status *status)
+FloatParts128 parts128_default_nan(float_status *status)
 {
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
-- 
2.43.0


