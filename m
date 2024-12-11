Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F47E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSN-0000aH-G1; Wed, 11 Dec 2024 11:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSL-0000ZW-UT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSK-0007n1-Cc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434f3d934fcso25241495e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934054; x=1734538854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t++4ywN2N/TpqmWSD8grbRREKM5vsqH/rZ/w1M5vhhs=;
 b=XG/uyIZLkOvxY0J8yUgWM9n13YqyjA/qYClNPiRnB0JK2nBT419W9O9LPZ4ob9Pe5D
 nAa03KdTPiQj+ndiqXY3UABmnO/FX20+LpoqgkrQ23Y/+Q3mXb76KvuS5wtuKW4yumby
 98boHSufO1Tc9MIVPxtWXyXuHXTuarnrSoHMcYkFJFgGhJFms66T38fRrK9CG/PVbVhm
 w9cHbZ3E0AFjHuLJcbon9AymEFBMxynMJvUkTZ+8kV3UfKsgg5IxGR1f3Ewut5ZBpJKd
 S/2dr1Lzp5JTM6wSwSWpBqCQLPtRLzHC7CRSSXCBRwbC0A359jxjInLm5FJDCUrTbh7E
 yQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934054; x=1734538854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t++4ywN2N/TpqmWSD8grbRREKM5vsqH/rZ/w1M5vhhs=;
 b=gC3ZdW8LnEsMM8V2Ev5fPFe4Wj/kqYvhpZ0vTMoexuL3sfQmEyc4TeiBDVvfrN3LtU
 W+iNyfxJhQcLIfJ1GRo21kmA+L7r7wPOMh3YaUKjlZ2vmKeyN4BHoux8Chur2486fCvi
 cAE79xI37d8waDgEPK47s7NtQX5AAY3teBaukc0nMGXZULLbxw+Fs/DKR87v1P0w+2yu
 +XyPW9/zDtO4+F9RZVWCiYI6Kz4s6z77etIhPgo5R4JItKKZMGu9OebvUd6eokOTwuGX
 FQ6nUVBGNXKyduOoYbNvUpHhhoc32vd40Cqxh3h03t7aF9phVDLTntG9oJrI18a9T5g/
 /dbQ==
X-Gm-Message-State: AOJu0YxcwdfFwPQPaTKSpw9ZhX84arazCKt5kiPSrn29pII2cSd5wQMs
 vGZjF3Wmjvy2jDK4dsXUhwiPMXLXEp2NyNu5qxbThZdcRRMSaN5XRpjoN4ZAS1HxXRI/Abd8RTr
 0
X-Gm-Gg: ASbGncsVKISJAN/0ItHPLEZmvu0mQjo0fPlCkiuUrjQXh5rHpRXYfHjx3OtvA0G9YN1
 HfMvCtChXCl6wDkGE3XADUyiTdJRYTl2ASXU/aHvXpLZK9KvXaHJajngzW7D8qRx6WKyhsCM4S1
 s0n87RHamhoBk4XS9JqfhWiRS9FAnJaI4z+3ROfYg2eoPR5dyhHkfmQqg2/lE/UvtvPvaOEhNLt
 lnVmR5Chts5om1ME9pjqEwgEPwrXUUT8f9evJi+2YjHQiCtGs9iEGlhWZrB
X-Google-Smtp-Source: AGHT+IHUChZ15ytVFY+Hqz4T4vUPpjGhKb4AAb1hXszC8aQ9IYRryQ+IykTLkc+KOdg/pM3Pn5zqtg==
X-Received: by 2002:a05:600c:4f11:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-4361c3aa6demr26312385e9.11.1733934054601; 
 Wed, 11 Dec 2024 08:20:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/72] tests/fp: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:33 +0000
Message-Id: <20241211162004.2795499-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the default NaN pattern explicitly for the tests/fp code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-36-peter.maydell@linaro.org
---
 tests/fp/fp-bench.c     | 1 +
 tests/fp/fp-test-log2.c | 1 +
 tests/fp/fp-test.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 39d80c9038f..eacb39b99cb 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -495,6 +495,7 @@ static void run_bench(void)
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, &soft_status);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &soft_status);
+    set_float_default_nan_pattern(0b01000000, &soft_status);
 
     f = bench_funcs[operation][precision];
     g_assert(f);
diff --git a/tests/fp/fp-test-log2.c b/tests/fp/fp-test-log2.c
index de702c4c80d..79f619cdea9 100644
--- a/tests/fp/fp-test-log2.c
+++ b/tests/fp/fp-test-log2.c
@@ -71,6 +71,7 @@ int main(int ac, char **av)
     int i;
 
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+    set_float_default_nan_pattern(0b01000000, &qsf);
     set_float_rounding_mode(float_round_nearest_even, &qsf);
 
     test.d = 0.0;
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index f290d523ab1..c619e5dbf72 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -941,6 +941,7 @@ void run_test(void)
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
     set_float_3nan_prop_rule(float_3nan_prop_s_cab, &qsf);
+    set_float_default_nan_pattern(0b01000000, &qsf);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, &qsf);
 
     genCases_setLevel(test_level);
-- 
2.34.1


