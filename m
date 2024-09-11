Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A50EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJu-0002hN-ML; Wed, 11 Sep 2024 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJ0-0005ti-Da
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIy-0007e8-MB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so1125687f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057118; x=1726661918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxSgJSSxDK73WSQ/reDz72E9qOvMV6LMGI8MzcCZ4P8=;
 b=q+5lYRvHAz8Q2gz4uc5N8N33QZCXfL6XdWE/mUTiOcnF7VE5JcsjeG4jofsPvpzvSW
 pIE/mR/DavWtJyO5hP0R8RwGJ+80dwMsaCZ5M49IIkSjN3NdTVHzoiQcMBl0zJ3Pwa9T
 jjVSVebXbzCW1sQU8S/Ob9WaX4YPgAxoCrF/VLn/Y1HB6kLishala+RYf308B2et5XTY
 6Y9By+ltITmCEieFbrFQZpPoS59blEIH8QZ2P6qpHjYYEloN7luO1ekjdpTftclfTq5s
 xAa59VjNFIH+sQYwOOrUvZnP5Ib4Ejo+NgGBsohzM000SDrudxpxbZPUXs/3NlHAMqBF
 6zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057118; x=1726661918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxSgJSSxDK73WSQ/reDz72E9qOvMV6LMGI8MzcCZ4P8=;
 b=nw/JzdMLStk83Ba0x9ugmQm9ESMjN2EgOY7qV6iAB537o4/sIvxcpHc2wdSGkzDB5r
 X9VQZ+KU6+iqaVrQyPRlRsrLxBqXclges617iyoPrEU1axkhnuXbBtlpc635hVjS+wnN
 tB7iWKcbt9aL22UC6RWOwFR3BjeUAsa8ZD4/NA+sk/gSPueyn7+L8vAofYqe2AjNXkbq
 N2ekhzRylK5nbl1KFJzlzoxheE2k3SdQcLGNhf1aZGm6I7L1Ys02NK0MntHuB0DCBn5U
 nAQVry3HCYP5m7oo4WNQYwQ4hagUuyZH4TzK5eD0SjiDBeKTV/l8mkYnRpxumZjCfUBp
 +rWQ==
X-Gm-Message-State: AOJu0YwoAJe2R3Fd0f8jUFaV/TWIraMNE7xpWmI7mLLjWNNIDz2SZJN4
 +YU94MmLUsoKW28CMwFXeLWlRl5PvsZ7MqvZfVZpK5amHhEJwT7czG+9n4wKHhyDYl7vZeEYV2R
 Z
X-Google-Smtp-Source: AGHT+IFja6mpvCYl0hIZShGO9uDLrHXeYb4P4urQxjFgGEJi+ysiXaR9ipT2ZTvxCkl8/CrKaMRsaw==
X-Received: by 2002:a05:6000:1cc9:b0:36d:2984:ef6b with SMTP id
 ffacd0b85a97d-378b0796598mr1697529f8f.11.1726057118460; 
 Wed, 11 Sep 2024 05:18:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d2ee6sm11368723f8f.83.2024.09.11.05.18.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/56] fifo8: replace fifo8_pop_bufptr() with
 fifo8_peekpop_bufptr() in fifo8_pop_buf()
Date: Wed, 11 Sep 2024 14:14:00 +0200
Message-ID: <20240911121422.52585-36-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The upcoming peek functionality will require passing a non-zero
value to fifo8_peekpop_bufptr().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 62d6430b05..efe0117b1f 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -116,7 +116,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     }
 
     len = destlen;
-    buf = fifo8_pop_bufptr(fifo, len, &n1);
+    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
     if (dest) {
         memcpy(dest, buf, n1);
     }
@@ -125,7 +125,7 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
     len -= n1;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_pop_bufptr(fifo, len, &n2);
+        buf = fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
         if (dest) {
             memcpy(&dest[n1], buf, n2);
         }
-- 
2.45.2


