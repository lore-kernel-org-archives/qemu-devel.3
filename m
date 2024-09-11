Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0E5EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJo-0001WE-2J; Wed, 11 Sep 2024 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIf-00048C-0t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMId-0007cV-G2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bbffe38e6so52011735e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057096; x=1726661896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdfUdsdLR+8JCN5US5V2C8xoXcEQ5Gixgip4Af6tbZ0=;
 b=chqbvnHgY7GrpOeYxqvWoZzYU+K7hZi7nrpZpV3cwNN6Va++agn0rf4MJpPcCXAqoZ
 xMhwdxgSbwrTS+JeIDHDwX0/nZOKUAgrYbtgI4FsBiHwWJxKuwBpjey/jM9n0NaM5ioZ
 2T0yWhjF7Dy7Q4z3anZ5Re+U36A7zcMkGHFTziVuSnHOZAzOe/0occmjsrU3aRvdQNED
 C44Fh6H/2tvDkl0/qS+VHe1rfEdxvzhaWLzaeOKH+RZeWCAqCMrBtveiXhvRrg9/nRAq
 kobhj8zaX1yO4zScQdoROMpaF8QsD14c19RIZt8Foy936dwvIcSiq316itOyFjKzrKwC
 BRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057096; x=1726661896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdfUdsdLR+8JCN5US5V2C8xoXcEQ5Gixgip4Af6tbZ0=;
 b=xSWWLnLwUz6h9AhtiYqKw4iSLd5RCnQE/gm6jF1BuHXksOje+fB18OSb13PuB1s0DZ
 /OWnMWHR1a4Lh4L+t3o7v2X/WHYJQeTHYLiiVX1ls0oYgB+C9Ubb0nzi7RemXxvTgI9X
 G/sqv4DRoagFCVMrnLznbM9GeGMIR4Ne2oFqPGqNWdaXhzMfwjqaI9cO4AwQjaavkUfo
 PYk3GCsw4F65SHrYGVutJrAl0BmuHO2flqCkgoZCybEwp8jQf7kK2M07jiyNtrIVSn8b
 GaHX/E1T/Em5B/XdQ9XsBysE8Mt99c3HtWXYXHkhthvoWNn9swhcTP/djL8yifqaDFuR
 f/7A==
X-Gm-Message-State: AOJu0YxrlvUvXIjCcTv5eb1Gm6rDYCrnBHSzsTHhUuHEa/JCZzOV6B4Y
 thGSFlOz18x7YIoT23A4j6+zXe+R1Jp3GC0ahvEzQsWzdrnxCHN7h6XZS2r9zlWs6yQNj/OH4gd
 3
X-Google-Smtp-Source: AGHT+IEVsCmdkreKWQlQfm90sUuaJdjKdj2d4Xw8CMDtJhGAU8moTKMrcQjpnTFViD7w6XAOuBCRcw==
X-Received: by 2002:a05:600c:354a:b0:428:1e8c:ff75 with SMTP id
 5b1f17b1804b1-42cadb6a47cmr94532795e9.35.1726057095880; 
 Wed, 11 Sep 2024 05:18:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665762sm11455779f8f.45.2024.09.11.05.18.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/56] fifo8: introduce head variable for fifo8_peekpop_bufptr()
Date: Wed, 11 Sep 2024 14:13:58 +0200
Message-ID: <20240911121422.52585-34-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Rather than operate on fifo->head directly, introduce a new head
variable which is set to the value of fifo->head and use it instead.
This is to allow future adjustment of the head position within the
internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 61bce9d9a0..5faa814a6e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -75,11 +75,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
                                            uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
-    uint32_t num;
+    uint32_t num, head;
 
     assert(max > 0 && max <= fifo->num);
-    num = MIN(fifo->capacity - fifo->head, max);
-    ret = &fifo->data[fifo->head];
+    head = fifo->head;
+    num = MIN(fifo->capacity - head, max);
+    ret = &fifo->data[head];
 
     if (do_pop) {
         fifo->head += num;
-- 
2.45.2


