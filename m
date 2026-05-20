Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141BCD5BAE
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZD-0001Yz-F4; Wed, 20 May 2026 13:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYw-0001Kt-Kn
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:32 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYu-0001tS-4n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so3295274a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297506; x=1779902306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2J8h7EuqX8JGH71JQZgqsud/ulFplvnKZbTkt0er6k4=;
 b=etK+tLZfutA/effxR7MraiXzQF56H+kJb4c+dJgaJmRuLxcU5tefevzAOZGJS7FyKt
 4daK03f7Egn19iwYEwpb+NzDYCTShN4Xz2uw9NzE5w/Y5HiVMzUypJNmd1AM9dqpbTc1
 wE0Ks0X9KN/ndY9YxVQXAmcpkswvAI9/vbVVEd34mOKLXPeI/Nl71BPXR3//0risAsZi
 DOPcRSR9J13t+tGwO3yYt73jc1RGbCw/hhRkZwG6lVYIKD0Z4Y2fJaTnZj8t/IJzhKuO
 dPd5EL9F7fL7qxll3KZ6G7x86ykAedC3HHVKoODIC2Uad5Mt/psb3p7BACq3OyKnhMRQ
 7YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297506; x=1779902306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2J8h7EuqX8JGH71JQZgqsud/ulFplvnKZbTkt0er6k4=;
 b=qBZDA73lhSnQ1ny8DYituYnpiCmaD3mAG4u1jUBGxAxPcfwOyDfYoSnumTRm3P36WI
 BNsRR/WLDv/qwOXInbDNHg4SKuhTPJ1dN4+a09dhBBjIpxySYW7+li0XsgqBSEnzNTec
 XMb+IzBuNzmMjOnzRBkn0sLma1BJxX49q55YrpemEFLsQQQKxrDJ0+o0MA9tkxwcdEDL
 bUWuRMomHpr2wGIND2XICXzPEMHsgVsviZcZT4Utfx+2QnFcPgP+9GMaPABvoCQLoFln
 0Wpoika8lWbmx2reXCa49NZpOFC5dqMSIHNyDbMw5kNiW+GPK3AS9eLy5XeY8jehdkCZ
 kpaA==
X-Gm-Message-State: AOJu0Yz86UxqP0QqG3I4eFEQf9XNu0o+Ee4W68K+O5SUebVli2jkvjV7
 O+tZXR82MNzKD1LRhNQ45o0XZSC8w0tJBUWY0tZtiPmxD33E6AkqmacG06fJMsRvA1rXMczBf8f
 g/UQROn0=
X-Gm-Gg: Acq92OH6BasNY4m376vVt/WHUv+LGa4xPO5jMYt9fSQwVAtTCPy3uXWSwINFCkp09DB
 PWq8USEYwn6WCAksa3nu+s7LhQA5O6Phn6V/renVwibI+5LFJwcMFa9vqRs1zV9Yd6PsWx2IAhq
 7BnQQy2rn5i19jyEdzmdrft3NoOi+ghlTim+OexAbo8hQhJbYgyUUlWvd/ziJwY/thUa4yWNugg
 8vqjNLkyIjvNgotISPaar5G2VQLHMKZdu2wLulM0zHcG/qngO7mg5/C+r5mr3uzHfeohqqs6G43
 CYIyY3oXjGlwT1IZ5uLRwkE8hJ1Hr1iy3fnoLPahVbphxFlUpGLe7wsi8dN3Fq5UJySVOpmCLmN
 RqjKz5Fxs2ofwOfUQ9Og8kbMl3ju0nEbmQJc4V66ZsbGxnF4k7SNpEE5Pup1LrhHHpXD0InG7jh
 Tc+qh+knd0uwWRNad9pVW+eK+dCiVt
X-Received: by 2002:a17:90b:1d83:b0:367:bb54:8768 with SMTP id
 98e67ed59e1d1-369518970f7mr22392194a91.4.1779297506307; 
 Wed, 20 May 2026 10:18:26 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 06/30] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Date: Wed, 20 May 2026 10:17:56 -0700
Message-ID: <20260520171820.848839-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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


