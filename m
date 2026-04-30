Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E3CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvR-000807-LB; Wed, 29 Apr 2026 20:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv6-0007ij-VS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv4-0001pf-34
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so266230b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507577; x=1778112377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P36S9oF3hhIawVjz64/S26T69xm/jo805Qcqz+Wuw4E=;
 b=NU5NACyd/E4ij8DgZOqBpAW2Ka9xb7L4KnztNG3C4DJodsKFm3lBxkuHPX432JToZ1
 +mZMnGjEmY+By+nf9qo90nc3szLHd3NradSejWyGljxpu8r+hYEL2x0yLQKaZ4QPeA3d
 QcGEuHQUj14Y30CReDx+Ok+dOAOr2Z72HK/Ldv3dj31hgmqdQ+w3jv3qTIXHAuhbKZ8B
 YGTgCD05FilN4UQjxT4ww9XpPLHRn5xk2qzuHRh/z+cmqaxEdG/uvB9jAOggiOxgwAJF
 fCR93gG4+isVEvimE877mlVR6KqBuisGEwL26yxEP3JQ47QvnLYCPy+tOTVSiSPecSbz
 k/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507577; x=1778112377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P36S9oF3hhIawVjz64/S26T69xm/jo805Qcqz+Wuw4E=;
 b=SxMNrFuSeOEjLXPLuJm0SI/MwW/EXjOSgIwkEyQI74G5add9vD188S96f/XzdO24Gm
 JM1X6QNSnJzRwwwUK1SccHZKFxbv2T0hHiB3I2yX2dGkWlmelVY8iNCWDmEn3teSwuww
 F5B8qHugLcCWCCKmkCuclnCJA+TNKXHnHoByMbFrvM2p9p9HO36yBfYZF/SFi2LwFIyL
 SWyCGvCyf2vBetFmW0FUgEiG1DHvJJ69COwbGn+Jj9yFcUAbM9uY0C82s3Ps1u9V4GxO
 0kHcJ13LmDqWDl7bUjcqaLbhgIL27KaUHF/KhxEb3lfUY8peMZg0Ey4k+N5J3tDSpa+u
 B5bw==
X-Gm-Message-State: AOJu0Yy/KtXuD/30Wvd+6h1ciYAJnNA+yL+QtQis4SLLSAX8quuV1nYl
 49g8UZgJxbHk/DYK78tIuSUWvZvv9d65BbLUTFYD/UjUTSb4WuFDZ4Iklmx/l/QSZgkVQKNEcjU
 6n/ODmUw=
X-Gm-Gg: AeBDievAieqe8b+zecNvsDKGiWT2AfxRwGUAR119h3aYV7t8X8lXzwmmyEhnTZ4400P
 tQwFZn4aCN1JrPMoDFoZWJBYZbBBQBjsvwRXvwKdmQSf7bdYHZ+eBLjhtuCmkrWX7nT6WjD7U09
 Z7n6K0st9X4MH9K7hSfIzVGAeF2fSySrmlNHILJcslm5nac2r1UWWtuCy2nTenmIAD4R4pOCp+Y
 iFqoFYhtcoSmayp20uoV0FZoPs1t7D8p4eqxJH7fpm/MOBLHP9qcbLyQW1aOJcBpo0Q4DOYEb1N
 suCYsqQjwYVLiQb/vyyhYOCISlbue6kMQVMxgmU5jEAMv5jK4KVWLnIrFbaABCakXccNTjQmNNk
 bBADKLklZI8idf+yVk6ucJgyQlFgx8P2i1Hi4T2MJkADpsnmo5YE9WzdQM9S+U6xvIwhvstyX36
 SDPJ7AX2aFywCyqEygUSXGINQ1X33NuuZ07IFEXzCd
X-Received: by 2002:a05:6a00:812:b0:82f:1369:7268 with SMTP id
 d2e1a72fcca58-834fdbd904cmr780578b3a.30.1777507576502; 
 Wed, 29 Apr 2026 17:06:16 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 21/40] fpu: Introduce parts64_round_to_fmt
Date: Thu, 30 Apr 2026 10:05:04 +1000
Message-ID: <20260430000524.56046-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat.c               | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 8c3a94bbbc..1876264d43 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -196,4 +196,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
                                     int scale, float_status *s,
                                     const FloatFmt *fmt);
 
+FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
+                                  const FloatFmt *fmt);
+
 #endif
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e42782c656..4efafbf05a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1396,6 +1396,24 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s)
     return pack_raw64(p, &float64_params);
 }
 
+/*
+ * Round to Fmt while remaining canonicalized.
+ */
+FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
+                                  const FloatFmt *fmt)
+{
+    FloatParts64 r = *p;
+
+    parts64_uncanon(&r, s, fmt, false);
+    /*
+     * We normally expect uncanon to be followed by pack_raw,
+     * so we don't actually crop the bits.  Do so now.
+     */
+    r.frac &= MAKE_64BIT_MASK(0, fmt->frac_size);
+    parts64_canonicalize(&r, s, fmt);
+    return r;
+}
+
 static float64 float64r32_pack_raw(FloatParts64 *p)
 {
     /*
@@ -5175,10 +5193,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         /* Round remainder to the target format */
         *r = *r_precise;
         status->float_exception_flags = 0;
-        parts64_uncanon(r, status, fmt, false);
+        *r = parts64_round_to_fmt(r, status, fmt);
         r_flags = status->float_exception_flags;
-        r->frac &= (1ULL << fmt->frac_size) - 1;
-        parts64_canonicalize(r, status, fmt);
 
         /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
         if (is_q_smallish) {
-- 
2.43.0


