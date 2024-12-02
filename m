Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDB5D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Uk-0002iH-6G; Mon, 02 Dec 2024 08:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002bn-0p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GU-0003OS-QO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:12 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385eb7ee7e2so757597f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145280; x=1733750080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yn+C6iEiC0sRjTP+yU6n2XqVtvMbEiwrywPK2VrWnnM=;
 b=mhkl/zF65pW9PwQsyeJE28ziqpbX481pQsTvJMEZnXF9wswOroM4Tr+hpggbW8R+s+
 K9DXcIxVY3qnbNs2j07CvY0+9HU+C3UgTeiBCJpiXg+ORyoHR9BHouhDmh4Ylz/MXQ/g
 E9H7fd/vYwaF/79BIwblAIcHLkkW8kdAmM97qn+YKPEkgoujVIdYXXEjvUfRfSuzDwQg
 lU6WeIJVATeUzM5amEMr5j1ylzKlxAfVnH+D4Vwm21nB5+8YUYpOFjV356BHgDGeNXrr
 z/fLhEmw+kRSHbu42OQGaQfBxWvciskxpBfsMHxVcj5Q5rHtis0L8CLsdjYtks3d5O++
 bPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145280; x=1733750080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yn+C6iEiC0sRjTP+yU6n2XqVtvMbEiwrywPK2VrWnnM=;
 b=GLyfo5LyHuB5hzPzInKBy0mc/ifs3ZczajKsyS3HSODbGq7KY/xaV8Oj8GazC74F9K
 i9ozQ8II9nqMLrL2WkCAQeKYYvT0i/unaRjD1dO7ZOCFr4E0RNf+pmBebIlXL536rdNh
 mqcIT+B56jVfRaRZooaEbrIRW7NlX70HbVAo6mry/PBPdy/a+y8bzHUNh7vyLJkMcTlV
 E2iKB9ILXFU0BABtpb0J9zJWh2K7B8R4YF52t+InsvjwANslGln6ilydvsSjKRKwCop+
 kn8tBBifp0FeeeREqBHsHYM9E/m1RvHzhxaz+/5g9U7gPywxB7FYabWW6/Gw17IOTW1j
 s24A==
X-Gm-Message-State: AOJu0Yzs91aGxhUFP4SCvloW1vSy5MOfebDfH87QlBQhHflHfKCWd1Kj
 m0R5ePj2Owq8vE/qqtSqFq/nuqV38vh7jEaZ0TXF2anlRz4QNVTQ57s0kD06AbAA7aC0ZeWBiQu
 P
X-Gm-Gg: ASbGncsvmlY9pov9Dt0c/ilFHeNfC3S7jJh9PdSpmLApQ8x3talKZMfCxodLwzuEvt5
 SWKj7L4siPtomDmdg/tS5f9b/NFYAbWEwObZxxuR62+HZ15w6SWS8+91vYIeaFxGn66sDBBkPGz
 /X3uxhyS816iYnigVwNnidxit5ApBL4ydmO6u71sDEb7YRxflTYFpl8VS4/RYuIbA5aEKlCYQ2E
 3Ri8O0qHw+ibRtKODGkJ7B72JSZLm1DGV6ZYLWA2Byg5jytOcjj/ss=
X-Google-Smtp-Source: AGHT+IGgrbQVdk/2k8ryRWS9HxyA+sh5LcHmOVIRwbYvPZqSLOeoonYWeClB9HtUkPgQEiQBvTpmKA==
X-Received: by 2002:a5d:47cb:0:b0:382:4f68:1f63 with SMTP id
 ffacd0b85a97d-385c6eb8478mr20884855f8f.7.1733145279747; 
 Mon, 02 Dec 2024 05:14:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 33/54] target/ppc: Use env->fp_status in
 helper_compute_fprf functions
Date: Mon,  2 Dec 2024 13:13:26 +0000
Message-Id: <20241202131347.498124-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the helper_compute_fprf functions, we pass a dummy float_status
in to the is_signaling_nan() function. This is unnecessary, because
we have convenient access to the CPU env pointer here and that
is already set up with the correct values for the snan_bit_is_one
and no_signaling_nans config settings. is_signaling_nan() doesn't
ever update the fp_status with any exception flags, so there is
no reason not to use env->fp_status here.

Use env->fp_status instead of the dummy fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/ppc/fpu_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 230466a87f3..d93cfed17b4 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -155,8 +155,7 @@ void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
     } else if (tp##_is_infinity(arg)) {                           \
         fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
     } else {                                                      \
-        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
-        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
+        if (tp##_is_signaling_nan(arg, &env->fp_status)) {        \
             fprf = 0x00 << FPSCR_FPRF;                            \
         } else {                                                  \
             fprf = 0x11 << FPSCR_FPRF;                            \
-- 
2.34.1


