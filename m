Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903B8CE7B0D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1m-0003ul-Il; Fri, 06 Sep 2024 09:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1k-0003oS-Br
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1i-0008O9-Lw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:27 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3c34e3c39so2986845a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725629364; x=1726234164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogUHnqKbTeP8dZWukr0SjuV7LdIfgZ21X5AZ6K1ackk=;
 b=xYRSPvcjTKZ1B7qJbtZFsgpZo7+/DjdFHtBtA5f1nxRbDCNCF79+TJYmupFl+D5IAn
 Ki1GB3Vu2PwooZhFvKRa0G+AviDJrD7a86cUZzbl6u+lCDk34peiRT/8I6NsFnA++j+s
 dj09h76grr8AvGTI9e4d71ZLmEt+bvW4UR1m91D6yWWFpZcZ135m+onxD5Ar3qMsR7+G
 /8UUnVUEfBdkxdQmO6M1tezclbiCwN1TbdUr684t2UuXOWENNxKBjemq5XTaZc72VkAZ
 gytpa8Jgu9X3SmaArk2fv7kJ2PYp2vaP3r6oFor2TAhovzqHreLajJw3ADcnmQ5lYljJ
 r4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629364; x=1726234164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogUHnqKbTeP8dZWukr0SjuV7LdIfgZ21X5AZ6K1ackk=;
 b=ttI+oLKTHTUUd24Yd+L+AMY0DqLXQkjRhKA665dnZAm0L1aB3bwCX93Dc/ECtVhW2q
 6BXyLWouohXYVeyZzKmrOFmWNtlekZJNiv7KWs8s+h/Ry6C6SclSCBQQo1UXvY87hi4h
 5jL2RgTjnolyY9AXuJuxAb6QMqUhdzIJ5CryLuv7K/lz7GtNu9b3Wf5mxs6M6rO8hTFJ
 K2Auoz6g7hlc2eCi8H0AJErTrIfvCO+4JrLO/7ZpNonwstchbp7tHk2x4KtB3jCsOiaF
 ptZly4vpgrN+FnJVCjng58IO4/GfeMw/WuSyd2n7Wy+A1YA0z6F+5SBnIVBOCJe1pZ8Z
 v7Ig==
X-Gm-Message-State: AOJu0YxWZnAC3kQZJfEg1OQs2lCGNXuW38U95QAJ89O7uX2cvwO94it0
 V5I35vtZNkagURp001/ZnrBNzl1RI1J4fgD2+y/AdXolqqxMlceJ2Z0vh0xJSJx7a/JmB0TfAxW
 S
X-Google-Smtp-Source: AGHT+IGHsSBPjaU2lsYPdJzcRz7yHl7oi1s1yv24A98HYdSC+sMz1ZNZydgiO14x1ADfFuUw83j4Mw==
X-Received: by 2002:a05:6402:13d4:b0:5c3:c3f5:592e with SMTP id
 4fb4d7f45d1cf-5c3dc78db9fmr1650298a12.12.1725629364307; 
 Fri, 06 Sep 2024 06:29:24 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc52b376sm2441679a12.7.2024.09.06.06.29.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:29:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
Date: Fri,  6 Sep 2024 15:29:08 +0200
Message-ID: <20240906132909.78886-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132909.78886-1-philmd@linaro.org>
References: <20240906132909.78886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Test fifo8_peek_buf() can fill a buffer with wrapped data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 9b3a4940d0..fada526b6c 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -158,7 +158,7 @@ static void test_fifo8_peek_buf_wrap(void)
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
     uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
-    uint8_t data_out[4];
+    uint8_t data_out[8];
     int count;
 
     fifo8_create(&fifo, 8);
@@ -174,6 +174,13 @@ static void test_fifo8_peek_buf_wrap(void)
     g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
              data_out[2] == 0x7 && data_out[3] == 0x8);
 
+    count = fifo8_peek_buf(&fifo, data_out, 8);
+    g_assert(count == 8);
+    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
+             data_out[2] == 0x7 && data_out[3] == 0x8);
+    g_assert(data_out[4] == 0x9 && data_out[5] == 0xa &&
+             data_out[6] == 0xb && data_out[7] == 0xc);
+
     g_assert(fifo8_num_used(&fifo) == 8);
     fifo8_destroy(&fifo);
 }
-- 
2.45.2


