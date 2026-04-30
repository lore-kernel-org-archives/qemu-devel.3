Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411C8FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEue-0006Ac-EP; Wed, 29 Apr 2026 20:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEub-0006AH-U7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEua-0001ka-E1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:05:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82f1f6103afso164804b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507547; x=1778112347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naCDYMEynTNqx6TFzJKNSAiBh0vvryTyWBIKKZOB+4U=;
 b=N+JMrXtjz3QAGDI5YHDgW+4p9DE2h0AnpzZroaXrZoNp9u38ljmwBW+OONnTWVz25v
 xdmthQVo1/Qul9rAbB9bj0Ne3Q8tnQC1eq/ZXyGC1qhTNmPQMy/+6ikiz1iB+SZsFctj
 /d8CCWCZWO+3vABtUcCo1Yjw6BS7WYe9fN/6QIApYcHhRVcO9khaQ+wFiOqqienJg+6i
 +Wk63MS3Atkh8avkKYW9eXfObaFlTXMKnl8JvkEXZqflWqMp7usnIW4/oAmT1jFb+Ov7
 gtXYip6D5QxsQhe6TEuEe5p1T0R1AczOwvzxG2bXwEOT1VDg34FIwpW+T9mi4MD+couD
 r5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507547; x=1778112347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naCDYMEynTNqx6TFzJKNSAiBh0vvryTyWBIKKZOB+4U=;
 b=XWaIda6QvzWa/piYAjXCeHlCHI+WDacIibk2XtD40boNaSIKwl4/f3SSz0M9t8Xgl/
 D4tf4HR4yhyRIKPjbChBcCjPfjhqHIAoLsWJlbvIbLWWzrlMJMfaQhcY/wzO2599kht6
 eSgINnt0D9VuM1ra0tqp7V6WUkrzlfjBOBkNkaMZeKOBsbPh8DVYiNyncMecZtfXds+3
 LIqiiico4lUZd622ve8Elnq8SADsR5E2Dvh7MlmEUWv94ijPzpu3uO3gspEtaLfUqZqA
 n7VCqtM7dgvKqV0z53cE89+PDerOIMG0YTyfc4l/5WB7SV6XNDc5A6i5jYwm9kc1pY7I
 +rlg==
X-Gm-Message-State: AOJu0YxjJ8a7LXLjWa3cxyuWKFgwV+VO2M9TEnMuRGCubmi6LlVHLNxB
 SxCJxL9KVCWEqysFXhjQSJ4r4FD34fYnj86HkYgiVGJg14p32HhNIgpT3L7W1aGsV4cBtRMljyb
 BV+KEXjk=
X-Gm-Gg: AeBDievz4O+iX1DWkk+qsAHpoOAtVjMlhhLxNaz+5PQJBOmuJrFDOy7LrjRyuCtdzxH
 V+zLdRqStBnlEY1nArs51Lajw0qThs/3kR96U7v/jMIlE56jJgPGeZDqtik+H177LGlc0GwPZE9
 SrXNtIkPrGrDhZqLapTrhuWTxABZ8OeDrg9dvk+IelcUmVJHego3Vm2VIn20H5em96lQ9/G6aKA
 Njm+TWuARB3z1o/xdWgzW5p1a7iiG+1OgWz0NdW3Bl9nvQAAV5d2sx/s3jWtbic3YmQ4yk5Gcdp
 TAWbqH9ru+MdRreM+jBcfdkQSPsUAaa92ZAYMwtYYu9pdCNzyKg/IcA9ESh7kxqTK8Ms/nSTI+f
 u+jboHbBDUWrOQWjdcp0GM1jQvX9uIDkUy0sL5ZuLwCCT3ABaHu2yvXf95k4N3jQHmvUYykk+Cs
 wRlc7MX2bfIOzBg7+a3UH5prSy0SzlgMdkhPV/9S6u
X-Received: by 2002:a05:6a00:4fcc:b0:82c:db50:ef77 with SMTP id
 d2e1a72fcca58-834fdca283cmr750883b3a.49.1777507547015; 
 Wed, 29 Apr 2026 17:05:47 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 08/40] fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
Date: Thu, 30 Apr 2026 10:04:51 +1000
Message-ID: <20260430000524.56046-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 63697ab3db..8c4263bfe6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -662,7 +662,8 @@ static FloatParts128 float128_unpack_raw(float128 f)
 }
 
 /* Pack a float from parts, but do not canonicalize.  */
-static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
+static inline uint64_t QEMU_ALWAYS_INLINE
+pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


