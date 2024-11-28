Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0BED690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0J-0002RK-V2; Thu, 28 Nov 2024 05:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzX-0001yi-Ig
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzS-0000Rn-78
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:22 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a2033562so5883135e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790596; x=1733395396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jI12Che8rR4gDrXI7XaPlHeXLQNnrp2Bpm/Wl6NH9ec=;
 b=nkNI/jGOcdtXU/t3irkXGhrb8F4xNZjmvsc0RhFGBAaQbDqG2heDynoTfV9qIBXW/r
 x0KD/BcJncH5cLap9TI0cQlR2k2YTf35fgbJS66gm2yYRdmpBGyDHXCosh46zBSWIO27
 ArmoioehEfjO401LXeW1IJ4PYCzwf+GwCjC8ihWgl+zPLBoTFvZXmLDs6I41htbmmLEj
 rzScNuNQqnf2DLetg22Z2h2fAH08D2vi5EB2w8IpcYAifxgKm6BKGrGy+OW8xJuI27WJ
 8/ZJNEDEY4RklcjDMeUQgXIDPSrbdIcizBIDaMPwCtgBAdhGDx0sjlMgvK+mpy+Jy8Ot
 9NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790596; x=1733395396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jI12Che8rR4gDrXI7XaPlHeXLQNnrp2Bpm/Wl6NH9ec=;
 b=QQdkUO3891zM2lDqNPlbs65Df0NfoCg2Uy6kwOpSkD2uiugC36nYmHNtHi46Zibqwj
 DAbFnMq0FPoEt3vF8APFJTnPSUbXz57IdeCwLfejAr1/6HO4dCyo/q5Pl/CmGEiG3otU
 YBl94Bx5JkSXEepYFj1MPHJYhqpSj/JQJ9B3lsqXdceUIHMhp293wDFYE7923H6LNP8d
 tqOPKfy/ro9gNoJO6T1HgoUhvgyRtSSwEKn2mPrtYLaFuwWNv8NWQ+Cp/6bC5B5RTAse
 zIv0DAwU0XbbW3c8Xvb1Cx9FLX5Ks3Kb6eSTHcUUax4oQPRwSN5EgKnRqmrmLZplynXj
 Qd1Q==
X-Gm-Message-State: AOJu0YwZPQcb6YOQvV11WnueAh3ief4++/VgXOoInsCDjp1m6+NrSg1V
 A45AWUWxwpwZ+p+5vWmIq3GPB7C357kn8M1YG8wjlmkw8PCQYzzPJxCe9kd+EyxpOmjsS++eAFe
 r
X-Gm-Gg: ASbGncsENJnbEMMWrxndLm1kn3ebKiPO4JZN16PaUZc3WaEGc0n3/9NJ79eN63r/Png
 xZbcSEuT0BkV79gapQQZPOpj+EhOJut/oQC9LeDIj+kpzqZNzyKEH2m1yK4uml5YQ0P4MIP2p1N
 lUqIIvkLNetrij965rD7BtWxzV0a4IC4j5Y1Wrproyz5g3AIyYCnlnXitCMRa0Ouo41XrRq39Lf
 U0fDds1kgmyAwIz+LWawo4VNZpne1uYRnWKgyt9DscofjTtVlba8dw=
X-Google-Smtp-Source: AGHT+IEg9PnTcT6BSRsSqrS8CdhAVEObZ4GIia4fpQ6/wBRhLPAJAaAuqSZKOxEWiKUIlV1NYlviHA==
X-Received: by 2002:a05:6000:2d12:b0:382:3afd:1273 with SMTP id
 ffacd0b85a97d-385c6ec0b21mr4354997f8f.30.1732790596550; 
 Thu, 28 Nov 2024 02:43:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:16 -0800 (PST)
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
Subject: [PATCH for-10.0 04/25] tests/fp: Explicitly set inf-zero-nan rule
Date: Thu, 28 Nov 2024 10:42:49 +0000
Message-Id: <20241128104310.3452934-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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


