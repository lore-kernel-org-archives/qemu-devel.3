Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B30D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6YT-0000OV-CE; Mon, 02 Dec 2024 08:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gz-0002z6-P6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Gw-Nu
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:33 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so26677425e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145265; x=1733750065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7hgTTAcAvvo63kNZS2ll5arN5VoViH9sR+6kv3WAC0=;
 b=iydRV8ew3QGAeyT4E0h018WIL+xrxgWgij9lczJcgUM50zSjUIi3Yr3Hsueahc1sri
 y90B8hwo3DSZTl/hts5SdwTnV5Ct23KUdfTEQS34WsujziCevXsoxCMXuz3op8yTCl6Q
 J1UvdYTWRwNlK+dCkkXgRbhJd5xDTOriTbhnEMOHcKFOhs0WJdm2MjfmMqkOm0q6bROb
 DTGPxNdw1Fq7gxGTZdPrynHOQ/ofKvpO5YltKR8ot7+0FQ5sPoNMIMfQh0ivYzvZi54t
 iHS0ShtXBzDLD5f9PVkvYKnKQSCtsULylXRYh3/TuzmcaCymJvJCMM/jB+mm3YcnL14g
 TjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145265; x=1733750065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7hgTTAcAvvo63kNZS2ll5arN5VoViH9sR+6kv3WAC0=;
 b=WNv9ZZl4JNxL8Y30xyvyofO7uolYmhodBOrcIC/UhcKAHgRV+lI1bLWwbk8zgap+Dv
 cHx+B8DItNC1DGtNnhISCgW95/txplBTMjqFeM5MNWzKWk+9TcgL5ekXR3Yem3t6Q5G0
 zI19cT5WcR3wsuhB6YLhKgh1Tbgl0W/EW9GB5X1WJ1nirhsjcfvw/69IeqztzFd1sGk9
 3VXHcTi/otkdVczZOLbup1WXrzmIu0d8BGBNRmZLYy+wfjyGTnMddGQYbqOVQ1cvkA1r
 3k2UYWDPkRZqnedtxg4Wr/tDO5iK8Z05EdhVCzLOv3j0Xne7YHyYxODtI3g1q7gRNPcg
 d10A==
X-Gm-Message-State: AOJu0Yx7b64ulCOuBvUg24Fl6EWgtexSHFbRpRkAGYbDbzvylpsNtyMD
 7HTC/FYioCiKzsVarxk3/2eJ3qkaV2RC/uovu7uYHCVOuURN4et/O/j4vuvJ2MH8bMZabCTK6qu
 j
X-Gm-Gg: ASbGncugjsjOaFsTcjaC8SYMKAJRWQqi33LVnl022BQ6fSI/QYpVPZAZv/cNeMTP4Rr
 XgtdaR5HOTO0K+JRL62mpY6nCNcZ4vq9bzrcpICuW7Tpq38Dc8IJXWGHPoR11w2cxgZ0NlyEO3c
 ga+8HG4fqQX4wDFwIo9Fu1po8aGE0CjbIF9a79v+F3P1wdtSKbU/cCiBOnp3vJ00tMcqZUYx6pM
 yS4llh7pbT3EcTuIlcxTpYuWJRtRFengF+xvTPqbkhpg1s27VgQN3M=
X-Google-Smtp-Source: AGHT+IEemo/kgleI2mLyCGQ61C0ZarnpS72GAYORVMtATpCawhtbXLGDqOMXKJ50Nry8KpGTlsLeDQ==
X-Received: by 2002:a05:6000:4020:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-385c6eb7c84mr16653095f8f.11.1733145259733; 
 Mon, 02 Dec 2024 05:14:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:19 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 19/54] target/ppc: Set Float3NaNPropRule explicitly
Date: Mon,  2 Dec 2024 13:13:12 +0000
Message-Id: <20241202131347.498124-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Set the Float3NaNPropRule explicitly for PPC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c          | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f18908a643a..eb9d7b13701 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * NaN propagation for fused multiply-add:
+     * if fRA is a NaN return it; otherwise if fRB is a NaN return it;
+     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+     * whereas QEMU labels the operands as (a * b) + c.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->vec_status);
     /*
      * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
      * to return an input NaN if we have one (ie c) rather than generating
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d610f460026..173b9eadb57 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -511,12 +511,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_PPC)
-        /*
-         * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-         * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
-         */
-        rule = float_3nan_prop_acb;
 #elif defined(TARGET_S390X)
         rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
-- 
2.34.1


