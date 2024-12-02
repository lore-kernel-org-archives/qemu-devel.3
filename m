Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3188D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Gk-0002JJ-9h; Mon, 02 Dec 2024 08:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fs-0001na-Lp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FR-00037g-Hf
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1677555f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145235; x=1733750035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkwmxObRxprUaJij2XbynAGv6Fy1VFYe1VACXWXiwGA=;
 b=Cc8YgfeMQBznXGfd9bv5dyVzIs9FNhg3wXUNA47YTgZPZxb0pbrBmXWw675D/vPx6L
 SeRb9c4Jop4GyhK7IPGpqWVV7GNsYvZud7fwAOx1n2kCgKJdW+ea+s+6nLJ3oBqLyie3
 0StdAfaDfpin08Qv39orBpIHf87qkX71XgH/eZcALhI/BvOHoDm3CBlITWgSA32xamxJ
 /uFW7+4h1sm1queHRItLe/9kWfBgVB3P+EGNv/IMWyEYpYSROVy+0UrxLlILbLc855FX
 hktGH3BxTzeYb++wvvjNl6RQPTuZHfAeQ2NjUrKfSyiinZnm6B/kyR8U4eAPFxOefEpG
 kiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145235; x=1733750035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkwmxObRxprUaJij2XbynAGv6Fy1VFYe1VACXWXiwGA=;
 b=RWbSa77P7s/XyK/WcphQq1f6Qa2KHWjFMvwQBMSGVXqwCf8zJmqyMeRSxdxoCsW/jk
 OPAyDxNoiO6MN78yex5WWysocMw58N76sngvUQMyVh36aykadHjf22+90MADXGvPmmmD
 vfVyrcbJT6S187n4lY8dJMJb4oabEcFlgt1LH8x09mV3JqQ8dqpRGoMsAgwNwEVRsOXf
 Fr/1RB+GG5PO8lv2UCLsqk5Z/+JU00JCISQEhPZRmjnDOVeAmDwEeEbOQNBhL5AcYT0J
 VT0vb2zA1hEdWjI+yM8sOg/1B2d2dU8+yKuX5y2gD1f+ZugaWaiOnvIxK0yuYESzthoA
 SNNg==
X-Gm-Message-State: AOJu0YwsLa6ZlIpACPUu69mdo3KbA/5slLbe/VJRk5TsMTsyVrWq2wn8
 RzQ/oTqppSec0XzvEbUAaLw8KFBEi6hDCs7KtGoWOxDCDI7JYi4xczbnQlDVPQm7ktdw7qWBxKq
 C
X-Gm-Gg: ASbGncs/gU8bWct8MkskElss3bUU3G/ByfuBwR3pTdxw6A0AP7Y2UgBn1tqVFZxtq+K
 rKMiUhmTAfdt+00kAcgvIxIOztnXv/S/cK7mdHyRNM0UKqpiq66hCQMiQwRV78SylYdLlozqqd+
 VydBRzO0o+LnoVkfaFDoYA5jCNWgyTpJcXWq/5qdloOZx8lzqnhCj+TNBRYk0Jl8+HkpxYrKoPa
 nbID25y5XZa05YWTNZZ14wV2ArbLdDDMBzO2+4pC8RKqhI4qFW6snQ=
X-Google-Smtp-Source: AGHT+IGy3HsLoAPvtrEg0h7F4JFEuE7tVbYhcQYvcU/l+t5bgP8Z4z1Fr47xDBOr+dQSqigzRmPxtg==
X-Received: by 2002:a5d:64a5:0:b0:385:f9db:3c58 with SMTP id
 ffacd0b85a97d-385f9db43c7mr626560f8f.49.1733145235342; 
 Mon, 02 Dec 2024 05:13:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:54 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 04/54] tests/fp: Explicitly set inf-zero-nan rule
Date: Mon,  2 Dec 2024 13:12:57 +0000
Message-Id: <20241202131347.498124-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Explicitly set a rule in the softfloat tests for the inf-zero-nan
muladd special case.  In meson.build we put -DTARGET_ARM in fpcflags,
and so we should select here the Arm rule of
float_infzeronan_dnan_if_qnan.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/fp/fp-bench.c | 5 +++++
 tests/fp/fp-test.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 75c07d5d1f1..fde64836194 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -488,7 +488,12 @@ static void run_bench(void)
 {
     bench_func_t f;
 
+    /*
+     * These implementation-defined choices for various things IEEE
+     * doesn't specify match those used by the Arm architecture.
+     */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
 
     f = bench_funcs[operation][precision];
     g_assert(f);
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 5f6f25c8821..251c278ede9 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -935,7 +935,12 @@ void run_test(void)
 {
     unsigned int i;
 
+    /*
+     * These implementation-defined choices for various things IEEE
+     * doesn't specify match those used by the Arm architecture.
+     */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+    set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &qsf);
 
     genCases_setLevel(test_level);
     verCases_maxErrorCount = n_max_errors;
-- 
2.34.1


