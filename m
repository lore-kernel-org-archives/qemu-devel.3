Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717BEC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT3aM-0006BB-Tg; Thu, 25 Jan 2024 12:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aL-0006Ag-1M
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT3aJ-0006na-33
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 12:32:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40eacb6067dso57033715e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 09:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706203932; x=1706808732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qYjEPErl5XVh5u2nT0CJZDvflYNdae3uJnahchVLNhA=;
 b=jAyEVuIpg+ONfrSB6uW03dH3WVXziNiRGgkDk32GYsARKGcS+E9YPTFxJ2He3hhtSS
 Li3M9Mp38OGR3y8wWtum2QncdH9d0P5Qn0WxgG76O+oEy61AyeIX6oblLJ7A6ow2XbkP
 0Yl2jHnJcVr1Na6H5eBCdAxfE2Ms5SK4h4QlVcvKQdtBD1RBEGcedPYYSpX/9sR7KQDX
 nTIVx2Yhq/tTCS7B7TE55fsEC80Tf4PbwQ2j4Ywdd6qstoVPZrlf1i8D0FcktC/RhDNE
 rH9LkcxUQxyf/ao1w2kFalsuiAlRLKLkjPOFKoimu7l27tdPOU6pB+97cZRPoLfqIIn1
 Rw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706203932; x=1706808732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYjEPErl5XVh5u2nT0CJZDvflYNdae3uJnahchVLNhA=;
 b=PCZOHi0XDuFv+XlF47DtIiDHrT28awy+RqxYWWoc3nD2OCPbTE/tfvq57pzUJGgdKq
 qmyAXbnnOj2MVsJ7gJlgH3VaJ4cscILjZKicAqtWImuHF5r2huvPsl7SMz+uKEeWiORs
 isYVZ+feyyKGvEPW/l0WnUbvazApGEhPylIiwPclTk1eJYG3f/KFHqFFYNweNMpf1NrI
 oAxZVd+xCeFq9giWoezu9LDz+9FRd27e6cHRMF/9UG/15RWkEn+1S2DwOmZQVcEVkviP
 +8xqRS5c82RD30TD+5neg94XdJjQ/9PQs9WB05NZXcFD+xcTmgfrWp+bYudoQBfASGcC
 f8rA==
X-Gm-Message-State: AOJu0YzhWW0DRI8tnLBHmmVefHq/yRDsmkj0q29Ytza9ZVSGQg7RDXfo
 U9yNA+SkoEDOciVSeecYjGskxsXNx0rIPLu5/ww+2aCmh4vgNl5hbuFuQS5Wq+lJtJhD8tMDS1t
 B
X-Google-Smtp-Source: AGHT+IGTtOwq0/g6b8okxw62hPkqwjcd4cSVWXKTNtUdM3YoZ8zb9LwCHiIQmAAX2vY1H/NBIKcoVw==
X-Received: by 2002:a7b:c40a:0:b0:40e:9ec9:e4bc with SMTP id
 k10-20020a7bc40a000000b0040e9ec9e4bcmr27835wmi.332.1706203932488; 
 Thu, 25 Jan 2024 09:32:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a05600c354d00b0040e45799541sm3287805wmq.15.2024.01.25.09.32.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 09:32:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/qtest/xlnx-versal-trng-test.c: Drop use of variable
 length array
Date: Thu, 25 Jan 2024 17:32:10 +0000
Message-Id: <20240125173211.1786196-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125173211.1786196-1-peter.maydell@linaro.org>
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This test program is the last use of any variable length array in the
codebase.  If we can get rid of all uses of VLAs we can make the
compiler error on new additions.  This is a defensive measure against
security bugs where an on-stack dynamic allocation isn't correctly
size-checked (e.g.  CVE-2021-3527).

In this case the test code didn't even want a variable-sized
array, it was just accidentally using syntax that gave it one.
(The array size for C has to be an actual constant expression,
not just something that happens to be known to be constant...)

Remove the VLA usage.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/xlnx-versal-trng-test.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/xlnx-versal-trng-test.c b/tests/qtest/xlnx-versal-trng-test.c
index cef4e575bba..ba86f39d13c 100644
--- a/tests/qtest/xlnx-versal-trng-test.c
+++ b/tests/qtest/xlnx-versal-trng-test.c
@@ -298,10 +298,13 @@ static size_t trng_collect(uint32_t *rnd, size_t cnt)
     return i;
 }
 
+/* These tests all generate 512 bits of random data with the device */
+#define TEST_DATA_WORDS (512 / 32)
+
 static void trng_test_autogen(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -343,8 +346,8 @@ static void trng_test_autogen(void)
 
 static void trng_test_oneshot(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -370,8 +373,8 @@ static void trng_test_oneshot(void)
 
 static void trng_test_per_str(void)
 {
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
@@ -415,8 +418,8 @@ static void trng_test_forced_prng(void)
     const char *prop = "forced-prng";
     const uint64_t seed = 0xdeadbeefbad1bad0ULL;
 
-    const size_t cnt = 512 / 32;
-    uint32_t rng[cnt], prng[cnt];
+    const size_t cnt = TEST_DATA_WORDS;
+    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
     size_t n;
 
     trng_reset();
-- 
2.34.1


