Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7180DFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznU-0005a8-0o; Sun, 26 Apr 2026 09:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznO-0005R8-Ir
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznN-0001ID-6J
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b2ea1b3962so53570125ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211112; x=1777815912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWzy2wmG/YVpmfySiB9DM04usKyzulFCXbIVFWan6xA=;
 b=j3q9e7rJCLEab3F8uy5gLFc2J8M7FQyUmZOB0F5qo+VySso05FxaavuwFN9bg9XaUP
 CJw87LNZiTJP2wDMJeWzxEdop8ZExCJ9por4TPIllmsOJiDHrmS9z0RRQeNiJ4eIHOi9
 TwX0RXWygVJCqh2I/3N4xkr6eYtcoZMqndzTlWhEE0lTWDefPF/tTm5ag71vnbZ372hz
 0fgymrd+PaD5U6TKOcUF5d/WJIX6quj/ZxiYenzd1CsPZ8vn6yymlQ3DblfDHx22uM3m
 D579uUXSKtwzOOFnYkE9jaaLFW53VzmRfF5mWKMd08cfNCy0f3CnoQcE2TsYHtVD9fMA
 8M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211112; x=1777815912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JWzy2wmG/YVpmfySiB9DM04usKyzulFCXbIVFWan6xA=;
 b=ftiz4zlDSa4PiJYIRxHaKTpyXC9PYfijTQXP01YTYC7CPWwKGaCWIx0J+3NGbgfQkY
 ZZ7bG+mrWGo4pYucU/EYLx0yVIxFjX2r3eSbU6Fh1rzG5PPuqR2UaOiVGuxOtzQGwhf2
 qyHQb2PVIHo8SMb91NSQ9Bp9khsuiIFmwuhwRd+PW/QbV4wXuIgbd7QY/DqdGj1oXntQ
 3Az3OysYEQs0dyWbBBgiSA3UPeVwYGd1ENfmiy1RoJPwy5vGAAFwIQBmv56dYallJ1fp
 7HYMXF3ZD4hK08dHYqpm4V4donZGRDPM0TIo9sjny+xOBKwC2dGQlsT2FHRT60bF5eIo
 WGmw==
X-Gm-Message-State: AOJu0YzZuGnjiS6CBNI3BwvThisA8HoACkHFxi6c2MDHFF9age7IBsIH
 B+xQS8GQE5f9YkFP2toFgkDA9XnrwBz2yvsjvleIMJM5Tzl5WB6IndgU7yn9rmEnCz3aR/S8uPl
 6cFsaHLI=
X-Gm-Gg: AeBDievBT7xA6ycyHUFMnB2cjyKhEaB0gUXKl3vK454piikM2kQGP+E8zwuUw6BzW9V
 qMtEJ/Hhsiz4rhlX9LmTVzM25ZfvZMuFzUee+sYm+oipAZx0B8plp6NRgv5Jo0gvFT9uTblz5i1
 jDHklO17lJijJR6VV1mQ/9mkHeN67/D4/9lXLToLCwHcpABdNdmzmeN+N21U5DQj9gN2KAtdlOh
 y4RSvn5B5cg/iv+7zyIJnTWHhpoVSP1p2EYU+wwZbnhSDeeqzJIR9nYLvs6LxC4Ivtbz6OKtnsJ
 WErRhh7KejB5CTZQDkEgOUm+jaDyeidXsUyEaP+CmTVwUxOQsQl3Jxil1IJ8T2sfSixTQvk2rJi
 nzfD5A8ZYZrdpuMCgYncyFl6cDdsWXw0zibMauqHwtoCxA4lpumNSWC0VnkZDC0ZK3p+l7CP/KI
 5aGrDi/jeCwW6dKDXJrZcN37OBLAbkGRQVbclnmLYI
X-Received: by 2002:a17:902:efc1:b0:2b4:5dff:30fd with SMTP id
 d9443c01a7336-2b5f9eb0501mr284546525ad.4.1777211111665; 
 Sun, 26 Apr 2026 06:45:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 45/84] fpu: Return struct from float128_unpack_raw
Date: Sun, 26 Apr 2026 23:39:22 +1000
Message-ID: <20260426134002.865628-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5412fd0360..a9c91fb8a4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,12 +646,12 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
+static FloatParts128 float128_unpack_raw(float128 f)
 {
     const int f_size = float128_params.frac_size - 64;
     const int e_size = float128_params.exp_size;
 
-    *p = (FloatParts128) {
+    return (FloatParts128) {
         .cls = float_class_unclassified,
         .sign = extract64(f.high, f_size + e_size, 1),
         .exp = extract64(f.high, f_size, e_size),
@@ -1586,7 +1586,7 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
 static void float128_unpack_canonical(FloatParts128 *p, float128 f,
                                       float_status *s)
 {
-    float128_unpack_raw(p, f);
+    *p = float128_unpack_raw(f);
     parts128_canonicalize(p, s, &float128_params);
 }
 
@@ -4845,9 +4845,8 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
 
 float128 float128_silence_nan(float128 a, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_raw(a);
 
-    float128_unpack_raw(&p, a);
     frac128_shl(&p, float128_params.frac_shift);
     parts128_silence_nan(&p, status);
     frac128_shr(&p, float128_params.frac_shift);
-- 
2.43.0


