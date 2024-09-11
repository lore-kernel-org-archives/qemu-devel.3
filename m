Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88549EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJv-0002nF-AL; Wed, 11 Sep 2024 08:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJl-00015M-4a
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJi-0007ha-LS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c6187b6eso4192154f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057165; x=1726661965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpGirFJS1hiVzWB+YvlZwSrjHOF2ym8zGg1RtGSITz4=;
 b=iCKJJfl3G83xj+NG2BfGWhNTxewFy6+bG8gGG6wfUfj6rQTJGgTYuIGgkeRkcC+dzF
 CLamP6Au7UKqu1kFijeNpSGp7iIb2n5xEmdpJ//ozGv3ZnsDSSLSTnNjVt99g6tao41h
 fbpcgc8ynZaH1iAiQj+wEOEXP1803SyjqhZJNjB3uHP+2TcVehM7C5wrrrIZ+Nd/Qsv2
 yxSTzLle23nEqwkaoGcqqv+a2g59wRxoz8HP5Qq1qLDLpiRm328i8pFEMSIemfyB8a8s
 Qc9Ut6gFrl+yO+r3soAoZcO3vO76rnZfwUHqqMNN59jt4CiCT3DLvESD2kKaywkEqjud
 ZDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057165; x=1726661965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpGirFJS1hiVzWB+YvlZwSrjHOF2ym8zGg1RtGSITz4=;
 b=WjBD6jF+xGOmIZYP/wOdGgzsCXc4lpL+IW2SizOG5wITd4cp7m5s1Fzpqilulmcupl
 YPKqWGNpN8Ukgg6ia/G/J91olBkrMXIfTQyuZPhiYeAn3vu5k+gsrAlHd657xZEzJagb
 PSbpv55nST3eE+kEq4Ww/tOdpu3XxVQR8qpwLbBdm2WokIUKEN2i1C/WEtjAtFkejwR6
 4qGVqSyoAvyvltCqxTyzt9MMsRuOt1zi3XDoxn+7eXz9wBfsa12znzxUPrtdwmnhLUOe
 D9UlnyGoT3zp9OKeQZ5faFSBiCsc6W2YMb1NGsBBiFIl1rXWvbJyw7awRW4uFGgbgpHI
 CWkg==
X-Gm-Message-State: AOJu0YzwUDjEHQkdjShv8jTBzyLlD9/2ZikL2i9ONiFso56LhhVF9qFQ
 /eD2HwGy7PHdfFdOfuF4IQ7IERgvlpyphHTv18g+epcLIiFVSnlM23/qpjHN/sTRi92RUyji4yZ
 3
X-Google-Smtp-Source: AGHT+IEUFDLgWmfIfyvZLvoZDG4wQJB1LpuWZJRXg4f/bmVHsmIsw/RxjmEpEHtdWL804ZKzbYpiQg==
X-Received: by 2002:adf:f6c2:0:b0:374:cbc4:53b1 with SMTP id
 ffacd0b85a97d-3788967e494mr12571511f8f.40.1726057164608; 
 Wed, 11 Sep 2024 05:19:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3765sm11464880f8f.74.2024.09.11.05.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 43/56] tests/unit: Comment FIFO8 tests
Date: Wed, 11 Sep 2024 14:14:08 +0200
Message-ID: <20240911121422.52585-44-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Add comments describing how the FIFO evolves during each test.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240906132909.78886-4-philmd@linaro.org>
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


