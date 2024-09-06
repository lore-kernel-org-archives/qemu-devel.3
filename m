Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19E9CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ2G-0004vu-Dc; Fri, 06 Sep 2024 09:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1r-0004IB-8k
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:36 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1o-0008OX-QI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:34 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f4f24263acso36036771fa.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725629370; x=1726234170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmwJGfzR3xYXiphg+dD2S7iJ9AFQ7Rwo7vO79swYL6U=;
 b=DkrfM16BEmbR27RdO3qaIybB7xsFhb8NPrmQaoEfQ5wWFPaHI/fw6SdhM4ax0Mm1H+
 tgimQqWdEE3BuwfuWsI2+j1ZKTsfSRJnUN4CHKrj+SS/MxFrbh71J55I6TgFFnMVzNu1
 z/gnshfo5AYm9iWfRFQoljYYdS0EuiOq0q1uU8RyhXzo8c1rnNjWFew2vvC4a//oeYux
 XViga3EkHpvMK4GXUll35sRKnUCtwKezgRM2PVk7JQGXR7Tk5BSDadPPkJ9kvEiEEeg6
 P48MG4k+A+FX/OWY9xMIfduV3Mf5N9ejj8PUMBCBSIeNcU8bp0WbqlqVn4g5/RaEZmL/
 BOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629370; x=1726234170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmwJGfzR3xYXiphg+dD2S7iJ9AFQ7Rwo7vO79swYL6U=;
 b=hWathfqekB2Ri5NZQ17ptJLkRwFjsmzBzExvdHqAbfpg9bTAHpPY+pqn69iAQTOPJX
 aN/hVobZtQ3y+0c+lInGPMk/bb4iv08zgyvGiqYXyA3oguw1ck44tofVvVrDUHBmToUV
 vHKBMAqcDp0rDajokq4VfGxNbB2L/YDlrukv5zvtO2PLwvRwBwvles4IjUJR58tS91ex
 E59FDM7isPz1ZSx+bP8D60wHY3Y5GF0+pD/xoo8C8F8OIelIPIlnnynmQXnzmiAhzvbj
 MFs+haqcNVP10KXAgsMm83LgaTfFL4Up7mS+R6GvFvJIa0XRCHEy8tMqqx89iZAnINMa
 GoGg==
X-Gm-Message-State: AOJu0YwHZIyhmVr/BGn9ufv89HMv3KaWUlb3zhJ8XAwWQWR/VTMfbetd
 j0tCq7c97nn6lT34RUsKcSeM4OPZhqq+MCLDi3Yfmdx3qbTQau5Mv2q5Q80SxwFUnShMHdXR5T/
 E
X-Google-Smtp-Source: AGHT+IH7AdPoUVCDcc8BPgmIolXxGEsWpXCSMKDqQSflZd5gwlswW0IgPQvzHBrVeX3sCZKZNaSl/A==
X-Received: by 2002:a05:651c:b22:b0:2f7:5049:160 with SMTP id
 38308e7fff4ca-2f7504902fbmr29979361fa.13.1725629369829; 
 Fri, 06 Sep 2024 06:29:29 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a61fbaeddsm278591966b.3.2024.09.06.06.29.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:29:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] tests/unit: Comment FIFO8 tests
Date: Fri,  6 Sep 2024 15:29:09 +0200
Message-ID: <20240906132909.78886-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132909.78886-1-philmd@linaro.org>
References: <20240906132909.78886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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
 tests/unit/test-fifo.c | 188 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index fada526b6c..14153c41fa 100644
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
 
@@ -70,18 +105,45 @@ static void test_fifo8_peek_bufptr_wrap(void)
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


