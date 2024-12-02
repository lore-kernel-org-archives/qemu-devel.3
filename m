Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA9BD78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Yq-0002OM-Cl; Mon, 02 Dec 2024 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6H2-00033k-Vx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003Yn-Ro
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a95095efso30379525e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145295; x=1733750095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ViFvWD2hAYTuBKEMhbDqPcZsE6RzFHNeiujTaxjrOk=;
 b=x6KNhgX8kvER1ljhqy69G/UhuRsKSXvbgKTrxMjhP/EZeDBLeOlSuWRjsKlKDTiJyC
 xuUuIkatzKguJhHlv4E+yRBBObk+LUMN/XDd1BhurswOfQq4ICpFEuToLRIrfuFO170C
 QidWJRHsfY0szrUW9EZ7RjGmPDDwniGHsll4+Hsu1fn+2v0SJO0khcrzt8cbHPbu38zn
 dekRpnr/QqcQgDvuEXjy7NPjPO5ZEPL3rnWnh2iJS0TSajcePa7cstzrRB98fqMPbRlc
 xcoBp20ASijvyJhlJAikAXLrkkqB5iOSw0TkGZLMHlAr0B71oOsVcIHeQ48lVf0b6clL
 PvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145295; x=1733750095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ViFvWD2hAYTuBKEMhbDqPcZsE6RzFHNeiujTaxjrOk=;
 b=WlZuiarbDdpNF0VEYzapLojD3MECmsy0wfRL7CQzBAm0r/8koMCSU0GSVzgvLg+6B6
 vHpQzHYy7XsEAab8rFG5XgwyAD5INhqNGWzOJQ3xnXaMjidyUdxEUHyBPMWUbvThjS8/
 ygQSsT7cdfBMCU8qKwmY5KhNqvlxE2/OBXBOLlK5JCGxd3CRVnzUWg/+cX3iOIHp+dq7
 mwW3AYhxrSIpeHS7Sq/NqPn8EI0ecuVx0Peml5wZlUJFQIZOU3TmlQUaaido03p0Wnzm
 GmLkqX3oJbBqvX7oArl9jvoTv0OhlV3wkeKpX59jLPBefCYEpwRHAZ6s3/fMWyn1+oKz
 pA0Q==
X-Gm-Message-State: AOJu0YyCuiixdnUesSXgQJqpKVz/X9Xl/tQma8l2O/GS3V8pggPIH25q
 KrAbVuwvKV4sQL6p8gPs7EVsigkOjFIpSKxY35Zxm8dW6nPTDeEPjf3P81toKVrvxbmhsQ1v5np
 N
X-Gm-Gg: ASbGnctNtAZ+kidOtrx3Pma5ZMdoBKx/0s1OXjm8VmrTkh0ju9QozyNywmuEOD2aQDm
 +vMSZYrrbmUPEJ9EHz9Tna5j0cHwAyIVZIHOJPHWs7wK9mAkAX8udfC4q9Mfqr3avlsRgkAMSAB
 WgJLH2AP4N02gGOOnuFm7+WF0NioDQDwchondnFZs6ixZoWneCb4NwpZixdDBl5MxZajeZ3mNRO
 eMgyJ0tcgXiE/SUXGEA8A7OvD8nLwtW3MA5qFpsKtQxKuiVic+fASc=
X-Google-Smtp-Source: AGHT+IHyyRQ2lvLX2YA9SmELgzRKWHRiLqS12n5m43U7VAgYLq+/2bRqSLCD2YnKzj1RyoNLuWAQAA==
X-Received: by 2002:a5d:6c6a:0:b0:382:485b:f976 with SMTP id
 ffacd0b85a97d-385cbd7c5c0mr16062827f8f.15.1733145295487; 
 Mon, 02 Dec 2024 05:14:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:55 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 49/54] target/sparc: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:42 +0000
Message-Id: <20241202131347.498124-50-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly for SPARC, and remove
the ifdef from parts64_default_nan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f2997a85e6..6b66ecb3f59 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -818,6 +818,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     set_float_3nan_prop_rule(float_3nan_prop_s_cba, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    /* Default NaN value: sign bit clear, all frac bits set */
+    set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ecb7a52ae7c..06185237d0f 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -136,10 +136,7 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
     uint8_t dnan_pattern = status->default_nan_pattern;
 
     if (dnan_pattern == 0) {
-#if defined(TARGET_SPARC)
-        /* Sign bit clear, all frac bits set */
-        dnan_pattern = 0b01111111;
-#elif defined(TARGET_HEXAGON)
+#if defined(TARGET_HEXAGON)
         /* Sign bit set, all frac bits set. */
         dnan_pattern = 0b11111111;
 #else
-- 
2.34.1


