Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E40D0C615
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L3o-0003zR-My; Fri, 25 Oct 2024 10:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3n-0003xr-3x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3j-0007lj-Js
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so1613275f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865578; x=1730470378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnxIUdeIDPfopOqS6esccSkst6Aak8TUkDQf9Y6bLJw=;
 b=wFazQQ+Zttx2Q0IVTm/i/o55910/+kh86QQ2FD5IxroezhhQ78OgmGj6nZ2ISRd5n7
 CgPlOYiplTK2RCFHyvXRIQc32n5vWv1WVjy26UVbXIdZsQG1VTt2+ilpOZir3uPx0xGM
 G0I3PF9BrzJCu8yfw1dyUIctk7Idzc8By6IUJVC8Rak5gBUzkFMIYtkr9WKLGaNZJXxq
 AaDHmZkPniFDFlDbC+Mqa/PWzLD+owCzWhrw1+AYasDj8GbwTs03mWY268bkCMf2cBIN
 XlkfQ666HG4VVwhU45kdwL3z842dpdfLzCpjJcBg07whhs/acODElyUhJQrRDUKye1UV
 TJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865578; x=1730470378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnxIUdeIDPfopOqS6esccSkst6Aak8TUkDQf9Y6bLJw=;
 b=qhBkdt2yjECTNFHJfARDRHHc/HvRT2cYsBD6nJQtWn8132S5dpnwPsBHHtVFS7EGVf
 oejpywqqYpqoJQDzw67HoMsxukWUHoTi6ZO6n1lQR8F3kn2qrnd+1vMpvGcD6jyQYpUG
 fbVOGtyVPMvHmjtQmW64fFshDmLtvGCrysKuROvmDY2AKjtRtZ8T2kbspQTVj4+7EUZo
 Dpm6PMVp3oSYbEcJubPNAlfZCopbClj7CrdelLgGdNrhvB9u/yxs27G8YoyhTy5MObiy
 1hgIZPo7Ifx/JNpL/A0skbWVVja3C7pjsgF26vJAui1h0KrRKa+vxtX+eL/8tR7aDYb5
 gSfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoW4ECr55qZYyQ/Zo5NOzHaM3B1gZaU8WZB/hN8eLDJXSqvCY7ZudTqSDNADGaHYHTmtGI1/paAPzv@nongnu.org
X-Gm-Message-State: AOJu0Yy7l1hKLzhEEf3bad6F/Z5Ci16JWivuvc92ZmSIMUMpV96n8RAl
 k1MtJ/wl+hX/yUUtFBlEIUpfAiNM63QT997zJydjzgj9QJa2aQtYsag+lVhdtZA=
X-Google-Smtp-Source: AGHT+IGbytfqhK7flKWpsy7Fx6Uu02lBkJU5a5y/tCFHWWrB5gwAn7GzxDwiORlerliSD/mfpFRIBw==
X-Received: by 2002:a5d:4fcb:0:b0:374:c33d:377d with SMTP id
 ffacd0b85a97d-380458812bbmr4321188f8f.28.1729865578101; 
 Fri, 25 Oct 2024 07:12:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:12:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 02/21] tests/fp: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:35 +0100
Message-Id: <20241025141254.2141506-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Explicitly set a 2-NaN propagation rule in the softfloat tests.  In
meson.build we put -DTARGET_ARM in fpcflags, and so we should select
here the Arm propagation rule of float_2nan_prop_s_ab.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/fp/fp-bench.c     | 2 ++
 tests/fp/fp-test-log2.c | 1 +
 tests/fp/fp-test.c      | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 8ce0ca1545d..75c07d5d1f1 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -488,6 +488,8 @@ static void run_bench(void)
 {
     bench_func_t f;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &soft_status);
+
     f = bench_funcs[operation][precision];
     g_assert(f);
     f();
diff --git a/tests/fp/fp-test-log2.c b/tests/fp/fp-test-log2.c
index 4eae93eb7cc..de702c4c80d 100644
--- a/tests/fp/fp-test-log2.c
+++ b/tests/fp/fp-test-log2.c
@@ -70,6 +70,7 @@ int main(int ac, char **av)
     float_status qsf = {0};
     int i;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
     set_float_rounding_mode(float_round_nearest_even, &qsf);
 
     test.d = 0.0;
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 36b5712cda0..5f6f25c8821 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -935,6 +935,8 @@ void run_test(void)
 {
     unsigned int i;
 
+    set_float_2nan_prop_rule(float_2nan_prop_s_ab, &qsf);
+
     genCases_setLevel(test_level);
     verCases_maxErrorCount = n_max_errors;
 
-- 
2.34.1


