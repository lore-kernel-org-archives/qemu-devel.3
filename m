Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639ADFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEv4-0007ap-Jq; Wed, 29 Apr 2026 20:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv1-0007Md-3T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuz-0001p0-J3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso224764b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507572; x=1778112372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8q92mP0WsVg7jShnJO3IJxQ7Z8BkHGBrtVLkPQnGUU=;
 b=cMz2GRKxpXPCt5gWCqtI8lHt+wdibTHrjbkvh/r1suU5YK6LZJ2LNSGovTX+HZ85nL
 y9EtHPA56EjdFM9xYtz+C7d2PzWwinPfr2YkvFY9eev16tN/qT9YW05Df4H6COykweCJ
 oKbmFSuuqhOqqDjpSBwR94qz0EK9BKy9pgws+KmollgSgoEZe+2rwiG0PyuqHDrDuXl7
 YRO/lTKXF2rjuyOdTBOKrkB6AZBUqJMkBKTzwsLMJ1UZAbCbnVSuBFVYHElNEOhd+YJO
 DW1v6L9YFh1J4eMe5I6s6pbaoqbFLUsxYcft9+6iQqRgWxNG5kg/53d/0KxDfd2wMerM
 Bqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507572; x=1778112372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t8q92mP0WsVg7jShnJO3IJxQ7Z8BkHGBrtVLkPQnGUU=;
 b=VjzaMfW4imG/9DHMzp0wgbSf0rQ7pcwkG4z7hi1BfG1vAKCc1LosJO+L3ao5jgUIM/
 aR/XzpAZsnI9bdCigiRkGETHNc2sFpqw/1YhIfrmsTXJ9WJCwWFESmTy0XTfvpQbD3t9
 fWcRqk9iYsl5PhYHB41HJSB7gNoijm/23KmlfuvDzobniBWqOd8R4hLwoRtTbvfNqJkO
 8rFci+HFAvVHP+3HhJdio+6f0H62JsC257AXWLWdof8U3nTTF3XgJG4ox7AL1ncHe2rq
 EJdT2IvYGzEcY7NWJoIV3ghynxSlE7IS25lrg5+sQhoCDzPjNqfeaLT0Bz+7BBuyqTwC
 ut2A==
X-Gm-Message-State: AOJu0YwJJXq+vAO+sDLuf0fHoNE0N2bRPvsCKRHCku/3lxrJ3Vdt0Xyk
 QQJjt7zB2gxiXTilubJ/fsPVaZkHVQzNJQEy7ofNoTqEQaJWTVEe7s2q4wPuh4kS9uzJgR27v/X
 pTpzNkvw=
X-Gm-Gg: AeBDievmeQqFfTdKqA2Cj/XZ6tOcphqcn2oJwumjqsJzsD4am4BvxtFL8C7BG3Z4O/Q
 3QqQUpeFgq6J1XUvzC6gEHnMZujH0K1pl5TmbEyCs18wXPJ0xKw7bMLcNzlUbBMZNhfhK5NIdzR
 +JOyBnQOoM2JTyqz59PVEXPVFx0P5BaOmadXUc+pXTrAJ3h7YS09ZeMvnsnOYpUCTFqlbHbiEjV
 yN58kD4iZ3M7lMs24fDarH/kowLMOWUmzh8BeNzt5mv3vPn367qy5fWM5r8v2nWEhzd27RsCY1F
 gU36qyYz/aEHDrZECQyRc2khnfxjcCQRAfzAe6orNd14OrgMTnGGzj7I6e+GuMe7eIjhX1vpqCe
 n7npQUVi6V/2+TCiKw4jGKWtXhpeddV/Xo/L60oiH+joF99o1C8PzdC9zOYSr2zJ1CZu5Nr0A7Z
 SZgGWAoZaQltnv3jkNr7O2WI4PKnlNIaoYtcZrDFS6
X-Received: by 2002:a05:6a00:9284:b0:834:e24c:3f9c with SMTP id
 d2e1a72fcca58-8350000ec86mr216657b3a.22.1777507571986; 
 Wed, 29 Apr 2026 17:06:11 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 19/40] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Date: Thu, 30 Apr 2026 10:05:02 +1000
Message-ID: <20260430000524.56046-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
index b71bd49483..e42782c656 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5161,12 +5161,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
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
         r_precise_buf = *b;
-- 
2.43.0


