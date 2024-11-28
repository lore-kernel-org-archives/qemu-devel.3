Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E17D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc1a-0004vr-KR; Thu, 28 Nov 2024 05:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzj-00027T-AS
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzb-0000cf-SA
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a752140eso5706945e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790606; x=1733395406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSKy4hpjmDanw2YkU8Msj9vNT9iFFxMr9XhYnZJtyOY=;
 b=pJVqARvBxhBksRpOt2hfm6pQ+r3TYzk79rmjdWMoqJnX/0R6R9REYs+CJnRwzsgviS
 CWFlEsxqr93zoKh81dgb0k7Sowl/EDAtVJDvgglZMET6ERJuD4rZ77erzg+M4k+WV7NN
 oWMQ6nrxOGbt1/iOwiqO9UcVG5izQopiuoZE8N2mv4fCltMvezp4RvwjKDvhNUXUbnu7
 PzbTBSr/CYx87nkSx4MaB6Qy03CzUv79C1Yx8oe9sdC/Ro2s9iBFkSt1LUVQJ8h5hS61
 jzBEWZWEnM8IdS1cNQoXjsH/YucmeNmq1p/z6zqDmW0lZ9LA7iIO/e1085fFMQTTKNL6
 0P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790606; x=1733395406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSKy4hpjmDanw2YkU8Msj9vNT9iFFxMr9XhYnZJtyOY=;
 b=oMdJT9clKXAZA84vbbjE6dpCJ68Mo5hSngSU/aPeGlXKzZxaHgbMMGERPwaWBC4DfV
 ViaIMqTQ+MoRN5zut+WdwPZ4kXQJ822kuaOwQUiC8dV+jdnwohXphUHQq340kMJBYDvR
 0q0HJ9+NdwYnPfXD594N5oI6bjbumxPjnnFXYly6fUYUAhUY/LvLLCpS0zHxdl1DJzrw
 kTjbdqCgUV12QuKUFCkoLyNppZ/PVurzspdd0pieqW4eBLTxN1fIVOkfOV+1gqxEiEhu
 8nX0QDXzBRrZnp5Gr2Lq1hXHFpQx2eDCX3C0zTNFHFmQZJbIWq260Lk+3U5M3E4BP4z7
 vs6g==
X-Gm-Message-State: AOJu0Yy//CnCptpp6+/PG+97OkJROV2rvX81iVg6vcWpyBzZHN8bkWkC
 LWMKwDRDPFD/qRwSO7+4TfsIVfnD14fxHhJUvXiHyQhwiiKtHKv2wX4LB3gR1awwbE45CMy12Wm
 O
X-Gm-Gg: ASbGncvTxMO+ZF7nQxVaC15suOGg+d8rK4sTfSXVu3N3krTQGo5B+pZDLDawkjA2/Tu
 Z5qB5ERJvlHAXaTFLHJoGKJjkvswlGYALU8kYQxyadqs//uk7xvsZnuhAr9Fje7c9vT6Sd0+qWt
 hVJ9Z4h4NdoJ6R5ozU+u7deu3eNfaWq9AdrgJ/bp4goIN5CIP/H+ZbIX9N3KzNGZb2B4btWj6F9
 J4mRJUcVJrx75/OXi2iJxk4LlvlkrnQENWrGDFQQQdcUkb7nwklYqY=
X-Google-Smtp-Source: AGHT+IFPYgLS/9mtFeOgG8MTJy0ecGQ8tHYcoQ6j4T4JFNFBCu+Lus0yiAtaYo6HX1Dg78AUM8LyQw==
X-Received: by 2002:a5d:59ab:0:b0:382:42d7:eedc with SMTP id
 ffacd0b85a97d-385c6cca8dfmr5318903f8f.5.1732790606376; 
 Thu, 28 Nov 2024 02:43:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:26 -0800 (PST)
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
Subject: [PATCH for-10.0 15/25] tests/fp: Explicitly set 3-NaN propagation rule
Date: Thu, 28 Nov 2024 10:43:00 +0000
Message-Id: <20241128104310.3452934-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Explicitly set a rule in the softfloat tests for propagating NaNs in
the muladd case.  In meson.build we put -DTARGET_ARM in fpcflags, and
so we should select here the Arm rule of float_3nan_prop_s_cab.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/fp/fp-bench.c | 1 +
 tests/fp/fp-test.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index fde64836194..39d80c9038f 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -493,6 +493,7 @@ static void run_bench(void)
      * doesn't specify match those used by the Arm architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &soft_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
 
     f = bench_funcs[operation][precision];
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 251c278ede9..f290d523ab1 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -940,6 +940,7 @@ void run_test(void)
      * doesn't specify match those used by the Arm architecture.
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, &qsf);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &qsf);
 
     genCases_setLevel(test_level);
-- 
2.34.1


