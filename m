Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BCD7831E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UM-0000KD-1Y; Mon, 02 Dec 2024 08:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gk-0002ba-R5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GU-0003Pw-Oz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1803830f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145282; x=1733750082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4IQwxgZ7TI3dnLUr9pZJR/1M5zZVOxtymkRhBauZGw=;
 b=CSpOnLhuvj4kwUVJp24vBJYuYpF0EPgcpxPxaa1oUdWi9iaa64+ojm/S99MUc8QHTf
 lOVQQkusszuhuduHC79u2wmH/MDovhRx05YLxMS+4y3ZpBnBc5Z2MY/PI6wLTxKCx49Y
 AWAS2iXYKDLJYw/QRFhIpT5M+THngxFoUy+EtiuBE/Qxei0KEjfs4J6drnQ19AaccVgN
 ww9/r5E3vj+npmEiOYjBZUtKQcTqsK4kVa03PQxnpEUezA/PuPYYru2y7jatvFBWqEo2
 /G77x5apnPVBG6DGEfyj2ngFtPW04fNtQoB9yvS26kL/gAkYZs1iaqHRGqrkNm/KPij1
 EQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145282; x=1733750082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4IQwxgZ7TI3dnLUr9pZJR/1M5zZVOxtymkRhBauZGw=;
 b=nM9jeF7gaVPGCTyCoPM8PTwga7RBdT6z9ZJY9mK+XxnOBjWEMWTT5e+Ol7+/fTYnZg
 J/1/K29s7r1wcxMdXng6GBlakek/l8aLqVutX+fL8hfjGBdptjcPAB+/AON0uwylNyjT
 XxHn5nBkzSoVXgZuZVfN5qTGhWjK/K9WeiS3DVGXtcDsOvcA8Uce1roJSiLX4zLzF2ne
 uUHJQM79cdreEMaXStmRxw75BqKc8gjv/U9d2aWpquLiEcgdk505b7RSmUTrt1mMth39
 9H5hZ/hqrauyh9MyUCgfoGa+ffuSwFQ/T4HzWXP69X6vCKqUeo6ld6FB/VH3BsN56P9+
 ZISQ==
X-Gm-Message-State: AOJu0YzWqsN1/vGBbeK2z/hMTDyb07s7+0tOM7lR43p3iZLhglnGMQq4
 H9MhjjOAFK0ZWT2N5yXv1JacDcQZdddZeeRJxlw7eOt9AybJLsv0XnnhxGZbQdRIwmHlWlWak6t
 5
X-Gm-Gg: ASbGnctrX4boBj344jn3z9EDc6EDd5wfYRyes8P4ReWZIo5FgpJiwEsrcTGSwuC9iub
 Hk9QkF9jhv6p8RnGEXPDDAA5UhIkTl6/7tSvDE/D//IePjs1avsgWRFlZU1QKPm4xmQtW7xBlpC
 KeEfRkXyg410XpsXbNoFMtPZm9h75x55tS8ttOqfEeYOyhkHcP/DKqSlIl33EtEPXkIgTm3l2bV
 8ZoMb88s4XDHrQwUQ0rheaAI58zu98iD1kyzzODAAYW4Ob+lO9BnOw=
X-Google-Smtp-Source: AGHT+IGBl63lSMExmDzDmz56Hi4ps6ZYUHjIAloYoP3kfaZz4pTVN4il5atAGH8qHrWm3IohWUeDQA==
X-Received: by 2002:a5d:64c5:0:b0:385:f7b2:aadd with SMTP id
 ffacd0b85a97d-385f7b2add6mr1499818f8f.41.1733145281644; 
 Mon, 02 Dec 2024 05:14:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:41 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 35/54] tests/fp: Set default NaN pattern explicitly
Date: Mon,  2 Dec 2024 13:13:28 +0000
Message-Id: <20241202131347.498124-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly for the tests/fp code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


