Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36421CE7B0B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYlW-0003xy-9f; Fri, 06 Sep 2024 09:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlV-0003xG-3G
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:41 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYlT-0006X4-0Q
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:12:40 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53658f30749so732061e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628356; x=1726233156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GD53cCFToaPHDaf/+msIM+Wg31jrU+mGaggw6OMsyo=;
 b=qY04hxEcaxRbIaayk87lZg5BWEhyphMTnQeSsYWqGsguYFuS+2ZQcONhcoZbs3b4wH
 snUnMUXjd01z5ryRNAXOwEADXNW0EARvCMJSgT4CZPP3u/KYrZG3aqUhqh4F316kddx+
 i383g2GrHCfi/R+wp5n13yUMrof7v09DvoRmnborC8KQRTY1cgHsGXAHe1MPWwoD72V7
 vkLZvOwpEXalss44YLv9MpVaElBA1infRtAqPtOw+eQ9w8N7SIOt/KTRNHI915AWlU+g
 5Xyexv+hxLZQiivHPL9cNh4NR2SDree2Q1JYLeW1ZALXQ1vIgwbqpaE/xMaUXkdfoa31
 ewqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628356; x=1726233156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GD53cCFToaPHDaf/+msIM+Wg31jrU+mGaggw6OMsyo=;
 b=Xnw9rkEIQzBlsaePEalQvkwOpkgy/4fKyycAe0vHUg24/pqf+bdJ4RMLG6r7FZ3ASa
 r9gE1/HWUMlMvixCMgL1sRf3syY1CvY4Jy8cWP26NfKUtGMRggMnvIcITsfeLqLX2zLT
 8zErH22rIqeGKiwyRiwYtmB4KmPM2W1g+J61eVA9g+u7FDKUhw6fYb2X2Vul6WQ2zDMG
 xypMcXTuro5WHNB1Lh7m1QwGpuig93hVjtMNdm0sVrbfW8Nxp3mRluHO99TMEAi6NdHo
 jUCY5Yp9V/ZFKxg99IN5qgUW+aaC5geXIUFZJflxU56FLGb/xNir2VAy73Efqx1Bo6VD
 zMzQ==
X-Gm-Message-State: AOJu0YyH7CYNycLIxDkPBw0inOFwohYdNotPlV6/mIVQFOoLa19yr7QO
 3c/nmx1cBbqZ2FyomA4b2mtR8x/VVQAy/bfbCR4X4aDLpoE9mx15W08nMYySz/9BBtB3bOcZiLX
 m
X-Google-Smtp-Source: AGHT+IE6KUm7ZmDuSnqZruDha2Eprq3u6Hd/nz4tXuOhNoTQh/xLOOGeSGb5si50kL/bOV0qN4V+rw==
X-Received: by 2002:a05:6512:3f15:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-536587b51f7mr1934963e87.29.1725628356506; 
 Fri, 06 Sep 2024 06:12:36 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a83ed05c9sm122141066b.114.2024.09.06.06.12.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:12:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] tests/unit: Comment FIFO8 tests
Date: Fri,  6 Sep 2024 15:12:17 +0200
Message-ID: <20240906131217.78159-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906131217.78159-1-philmd@linaro.org>
References: <20240906131217.78159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Add comments describing how the FIFO evolves during each test.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 190 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 4706bf8708..14153c41fa 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -27,14 +27,36 @@ static void test_fifo8_pop_bufptr_wrap(void)
     uint32_t count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: [ . . . . . . . . ]
+     */
 
     fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: [ 1 2 3 4 . . . . ]
+     */
     buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    /*
+     *      head --v  ]-- tail      used = 2
+     * FIFO: [ 1 2 3 4 . . . . ]
+     *  buf  --^                    count = 2
+     */
     g_assert(count == 2);
     g_assert(buf[0] == 0x1 && buf[1] == 0x2);
 
     fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    /*
+     *     tail --]v-- head         used = 8
+     * FIFO: [ 9 a 3 4 5 6 7 8 ]
+     */
     buf = fifo8_pop_bufptr(&fifo, 8, &count);
+    /*
+     *  head --v  ]-- tail          used = 2
+     * FIFO: [ 9 a 3 4 5 6 7 8 ]
+     *  buf      --^                count = 6
+     */
     g_assert(count == 6);
     g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
              buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
@@ -51,9 +73,22 @@ static void test_fifo8_pop_bufptr(void)
     uint32_t count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: [ . . . . . . . . ]
+     */
 
     fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: [ 1 2 3 4 . . . . ]
+     */
     buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    /*
+     *      head --v  ]-- tail      used = 2
+     * FIFO: [ 1 2 3 4 . . . . ]
+     *  buf  --^                    count = 2
+     */
     g_assert(count == 2);
     g_assert(buf[0] == 0x1 && buf[1] == 0x2);
 
@@ -65,23 +100,50 @@ static void test_fifo8_peek_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     buf = fifo8_peek_bufptr(&fifo, 2, &count);
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     *  buf: [ 1 2 ]                count = 2
+     */
     g_assert(count == 2);
     g_assert(buf[0] == 0x1 && buf[1] == 0x2);
 
     buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    /*
+     *     head  --v  ]-- tail      used = 2
+     * FIFO: { 1 2 3 4 . . . . }
+     *  buf: [ 1 2 ]                count = 2
+     */
     g_assert(count == 2);
     g_assert(buf[0] == 0x1 && buf[1] == 0x2);
     fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    /*
+     *  tail   ---]v-- head         used = 8
+     * FIFO: { 9 a 3 4 5 6 7 8 }
+     */
 
     buf = fifo8_peek_bufptr(&fifo, 8, &count);
+    /*
+     *     tail --]v-- head         used = 8
+     * FIFO: { 9 a 3 4 5 6 7 8 }
+     *  buf:     [ 3 4 5 6 7 8 ]    count = 6
+     */
     g_assert(count == 6);
     g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
              buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
@@ -98,9 +160,22 @@ static void test_fifo8_peek_bufptr(void)
     uint32_t count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     buf = fifo8_peek_bufptr(&fifo, 2, &count);
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     *  buf: [ 1 2 ]                count = 2
+     */
     g_assert(count == 2);
     g_assert(buf[0] == 0x1 && buf[1] == 0x2);
 
@@ -117,14 +192,38 @@ static void test_fifo8_pop_buf_wrap(void)
     int count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     fifo8_pop_buf(&fifo, NULL, 4);
+    /*
+     *         tail --]v-- head     used = 0
+     * FIFO: [ 1 2 3 4 . . . . ]
+     */
 
     fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    /*
+     *         tail --]v-- head     used = 8
+     * FIFO: { 9 a b c 5 6 7 8 }
+     */
     count = fifo8_pop_buf(&fifo, NULL, 4);
+    /*
+     * head  --v      ]-- tail      used = 4
+     * FIFO: { 9 a b c 5 6 7 8 }
+     */
     g_assert(count == 4);
     count = fifo8_pop_buf(&fifo, data_out, 4);
+    /*
+     *         tail --]v-- head     used = 0
+     * FIFO: { 9 a b c 5 6 7 8 }
+     */
     g_assert(count == 4);
     g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
              data_out[2] == 0xb && data_out[3] == 0xc);
@@ -141,9 +240,21 @@ static void test_fifo8_pop_buf(void)
     int count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     count = fifo8_pop_buf(&fifo, NULL, 4);
+    /*
+     *         tail --]v-- head     used = 0
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     g_assert(count == 4);
     count = fifo8_pop_buf(&fifo, data_out, 4);
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
@@ -162,19 +273,45 @@ static void test_fifo8_peek_buf_wrap(void)
     int count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     fifo8_pop_buf(&fifo, NULL, 4);
+    /*
+     *         tail --]v-- head     used = 0
+     * FIFO: { 1 2 3 4 . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    /*
+     *         tail --]v-- head     used = 8
+     * FIFO: { 9 a b c 5 6 7 8 }
+     */
     count = fifo8_peek_buf(&fifo, NULL, 4);
     g_assert(count == 4);
     count = fifo8_peek_buf(&fifo, data_out, 4);
+    /*
+     *         tail --]v-- head     used = 8
+     * FIFO: { 9 a b c 5 6 7 8 }
+     *  buf:         [ 5 6 7 8 ]    count = 4
+     */
     g_assert(count == 4);
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
              data_out[2] == 0x7 && data_out[3] == 0x8);
 
     count = fifo8_peek_buf(&fifo, data_out, 8);
+    /*
+     *         tail --]v-- head     used = 8
+     * FIFO: { 9 a b c 5 6 7 8 }
+     *  buf:         [ 5 6 7 8 9 a b c ] count = 8
+     */
     g_assert(count == 8);
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
              data_out[2] == 0x7 && data_out[3] == 0x8);
@@ -193,14 +330,27 @@ static void test_fifo8_peek_buf(void)
     int count;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
 
     fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     */
     count = fifo8_peek_buf(&fifo, NULL, 4);
     g_assert(count == 4);
+
     g_assert(data_out[0] == 0xff && data_out[1] == 0xff &&
              data_out[2] == 0xff && data_out[3] == 0xff);
-
     count = fifo8_peek_buf(&fifo, data_out, 4);
+    /*
+     *  head --v      ]-- tail      used = 4
+     * FIFO: { 1 2 3 4 . . . . }
+     *  buf: [ 1 2 3 4 ]            count = 4
+     */
     g_assert(count == 4);
     g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
              data_out[2] == 0x3 && data_out[3] == 0x4);
@@ -215,12 +365,28 @@ static void test_fifo8_peek(void)
     uint8_t c;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
     fifo8_push(&fifo, 0x1);
+    /*
+     *  head --v]-- tail            used = 1
+     * FIFO: { 1 . . . . . . . }
+     */
     fifo8_push(&fifo, 0x2);
+    /*
+     *  head --v  ]-- tail          used = 2
+     * FIFO: { 1 2 . . . . . . }
+     */
 
     c = fifo8_peek(&fifo);
     g_assert(c == 0x1);
     fifo8_pop(&fifo);
+    /*
+     *    head --v]-- tail          used = 1
+     * FIFO: { 1 2 . . . . . . }
+     */
     c = fifo8_peek(&fifo);
     g_assert(c == 0x2);
 
@@ -234,12 +400,32 @@ static void test_fifo8_pushpop(void)
     uint8_t c;
 
     fifo8_create(&fifo, 8);
+    /*
+     *  head --v-- tail             used = 0
+     * FIFO: { . . . . . . . . }
+     */
     fifo8_push(&fifo, 0x1);
+    /*
+     *  head --v]-- tail            used = 1
+     * FIFO: { 1 . . . . . . . }
+     */
     fifo8_push(&fifo, 0x2);
+    /*
+     *  head --v  ]-- tail          used = 2
+     * FIFO: { 1 2 . . . . . . }
+     */
 
     c = fifo8_pop(&fifo);
+    /*
+     *    head --v]-- tail          used = 1
+     * FIFO: { 1 2 . . . . . . }
+     */
     g_assert(c == 0x1);
     c = fifo8_pop(&fifo);
+    /*
+     *     tail --]v-- head         used = 0
+     * FIFO: { 1 2 . . . . . . }
+     */
     g_assert(c == 0x2);
 
     g_assert(fifo8_num_used(&fifo) == 0);
-- 
2.45.2


