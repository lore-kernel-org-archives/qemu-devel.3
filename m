Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B32CCD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKp-0001iC-H8; Sat, 16 May 2026 20:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKW-0001eJ-Tj
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKU-0002YA-6V
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8354461da74so444400b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977561; x=1779582361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2J8h7EuqX8JGH71JQZgqsud/ulFplvnKZbTkt0er6k4=;
 b=DemfvLZoIwfhF2RWcaopTdjkBqGfx+jiNo2s4QtldWqIl2yT5fJjsYXZyybN+5IZtU
 ZA+IkI/tnGf9D7E0vPoV9BXFHotNa2CpuwW1zDsjjHivhj0OiQrD/PYuTQFiYePMvPn5
 kqQ3CSJE1suA0jg/BBEFVQ/aDlnr0hhulAcAdnpaMS9yF/zdBYA8xThNqGdmoh0AqR+H
 mQsfeRTPTloVGb9e2EquTk8PE2gTrNcR/Id9g9/QQlZ8ZQ8gX7wHXOdHanpBE049G47B
 n59ucPZPoJpgY8A6cg+pf4VmX6uSw/kk4N9jfMPpajmBuDpCIyTuOdfUh6JBabI3oHXs
 Ljiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977561; x=1779582361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2J8h7EuqX8JGH71JQZgqsud/ulFplvnKZbTkt0er6k4=;
 b=M3kLjQZG37uUaJsWOiCqlwULooeqfh5XSkPKooz8+9qQA8xW0bo1KpiRNy0wuhTDEA
 nByurnIeXPMz4ExINaw5S+QY2eLXr0TsYqfq6Vc41RWKd0DNvfgEIPUyA0r+6KzkgZZc
 OxBy9JOEdnBzx3sfSw5mFRU+XAVIUEetNiR8xT/tQIRKD92RKEyW86dKBqnsQgmCq1k9
 5eZUVy1N4sgH5za3w+udAB9OxX7OegxzIEg7uL6j+JSMwmpcwkAZiiqIp/heYrHnW/3w
 oZ3bT5JT63e6OL1cxqsxnw5YNmijFwBh+CfyVzEJRtfM+LBhgZxFD1WKqg0RpqRZ18YE
 N+7Q==
X-Gm-Message-State: AOJu0YxVM0I8QfajFaRmCgOpoWwyxGq4oSpG66XWIoPkBNb2F6fs6DFi
 OxF+B4yVT747kYNYLuzv5a0sDLFjuMPO5n8pYsYdcD/oCWaFqO89nNXAhj2yAjicmC1dI8uJ8E/
 K2op7
X-Gm-Gg: Acq92OGcO6nNOJfENqryumqjuJmEF6YtJ8I/DuPQQ60h9HzIWXoSkRD6LOXXRTrN/ti
 YTMK3i7DK6CRICRkNEKUWpJ2vlpolHaKpNS7RQR284cTbHiK0CuX+d+OhjfIh1JqTtUXXEgHfnB
 9yFNqrlMXiFoLjqg1Wfv+WQhLpWFpiFBMEapNZrwvTViprOQhNKzjuLnGoyaXHAQBl9X97o30nJ
 PZOJThY1Qb5urVq9bGSI4FcNgDpx4ICnuSSGzQ8Vd6kpulGE2dyoVa8t3QbWWjTFs0aBqiRT92V
 DSzO2k3KXIc4NIRS3y6ExRi/HBpr5Dz+7XboCwznz10Mpfb1aHQWnN8gfPcvFDrG3M/tyZAtFZN
 SVf4T87FFuAnHM4bfSWTfPaBI+eAwbLUIfREkGf3pNmMP486smIk8GxymrnhD0t5tlR/oVMx04T
 iUgr5P/IADphXrNxhq0z9wCo8Girc5
X-Received: by 2002:a05:6a00:a20e:b0:82c:e1aa:21e3 with SMTP id
 d2e1a72fcca58-83f33bca81dmr9848317b3a.10.1778977560527; 
 Sat, 16 May 2026 17:26:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/12] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Date: Sat, 16 May 2026 17:25:43 -0700
Message-ID: <20260517002550.321291-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

We will not expose parts_round_to_int_normal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 905ba6ecf8..08ea56a71d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5197,12 +5197,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
          * Rounding of partial quotient may be inexact. This is the whole point
          * of distinguishing partial quotients, so ignore the exception.
          */
-        *n = *q;
-        parts64_round_to_int_normal(n,
-                                    is_q_smallish
-                                    ? final_quotient_rounding_mode
-                                    : float_round_to_zero,
-                                    0, fmt->frac_size);
+        *n = parts64_round_to_int(q,
+                                  is_q_smallish
+                                  ? final_quotient_rounding_mode
+                                  : float_round_to_zero,
+                                  0, status, fmt);
 
         /* Compute precise remainder */
         r_precise = parts64_muladd(b, n, a,
-- 
2.43.0


