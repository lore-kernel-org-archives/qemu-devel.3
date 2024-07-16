Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4537C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmco-0006oo-NJ; Tue, 16 Jul 2024 14:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcm-0006i6-Sp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcl-0000ur-22
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so5749f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153401; x=1721758201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+f/7N8GJRq8hKRVda+Tlkh41f3Qt1aALkfzBVC63ub4=;
 b=V7Ct9ZN03/DkPtULc0Y+htfBvdw1OfHV7TWTWk7XIeyTZKd0bXgm2NCmloWnQACBaA
 4NFL8lszHMpLT3nvE2Q84L0XGWqKqkLfvKjvMRKQ5NWvFT+0duRN8CSie5a6Yc/pLF2X
 xjeK5a9QrUV4JU25RtnJykxKBUZUCOhIAxbBpUs5Xo9LjZ0eWW+prRhnJlv6rzBDiYHB
 pi5FpjzUEarIz4hZ4KmFzKMv4m6B9SPBW+p9IQaaH+gC40E9zDy2KpKFckQx/Pe9ea4V
 6KRhjiOfg6R6uHGv7KV67lx/2DsPJNkfrqaMlPYg2RtZcEKxlpebcmSeWEWMZ3pCpfg6
 PPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153401; x=1721758201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f/7N8GJRq8hKRVda+Tlkh41f3Qt1aALkfzBVC63ub4=;
 b=SmzD/M0LRiIIAWR2WdyDU8bwpdSZkqWsR3ihJf9SW0/1gxVfEpZhEbjDB9hrGZEFxN
 rgEshtlIRK++9hG4cLuhozutHNiHDDAd4DyQI+jmQy3YEZ4t+2sVJmDZczFXRvfNC08e
 9CkpReVK6jDte2Fo3jtC/MNpCGVNkeT915C6F3snJhguh0HukigX5/SwxdBGpiwAfx2D
 Va86Lom+MEux5IIYSK3HYSgrXGQkxF/Zrl9B0KT2zK6DrXCA9wnewk2t+pPHge7h54RT
 K7phR4bdZC8lovSs9OcXIyMDHF7U0PEYJ4CK/UkRpoHmKB0L+TDfjG1pUet20ku+TQOp
 m21Q==
X-Gm-Message-State: AOJu0Yznp3krq1e8vd1Kck9cXI2nIHZQpnjHMcQ4UBa621HhQdpMS8NN
 i9Fhdtp4qOXz6r8xEd4g9sgG1+j7Mm77+1DjNftjVp+q2AKxE4FT6fVqCKrnzJLMm8b/xefMber
 j+OsG7w==
X-Google-Smtp-Source: AGHT+IEg7ym5iqLUHL73R2Cl4lUWDkJMUjemVYHWCt4e2ED0JWyoShqoZhzNTCFCK4J4PBIPGkhh+g==
X-Received: by 2002:adf:ef86:0:b0:367:8e57:8 with SMTP id
 ffacd0b85a97d-36827432f95mr2270756f8f.19.1721153400814; 
 Tue, 16 Jul 2024 11:10:00 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb939sm9701924f8f.89.2024.07.16.11.09.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/13] include/hw/qdev-core.h: Correct and clarify gpio doc
 comments
Date: Tue, 16 Jul 2024 20:09:30 +0200
Message-ID: <20240716180941.40211-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The doc comments for the functions for named GPIO inputs and
outputs had a couple of problems:
 * some copy-and-paste errors meant the qdev_connect_gpio_out_named()
   doc comment had references to input GPIOs that should be to
   output GPIOs
 * it wasn't very clear that named GPIOs are arrays and so the
   connect functions specify a single GPIO line by giving both
   the name of the array and the index within that array

Fix the copy-and-paste errors and slightly expand the text
to say that functions are connecting one line in a named GPIO
array, not a single named GPIO line.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240708153312.3109380-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5336728a23..77bfcbdf73 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -624,8 +624,9 @@ qemu_irq qdev_get_gpio_in(DeviceState *dev, int n);
  * @name: Name of the input GPIO array
  * @n: Number of the GPIO line in that array (which must be in range)
  *
- * Returns the qemu_irq corresponding to a named input GPIO line
- * (which the device has set up with qdev_init_gpio_in_named()).
+ * Returns the qemu_irq corresponding to a single input GPIO line
+ * in a named array of input GPIO lines on a device (which the device
+ * has set up with qdev_init_gpio_in_named()).
  * The @name string must correspond to an input GPIO array which exists on
  * the device, and the index @n of the GPIO line must be valid (i.e.
  * be at least 0 and less than the total number of input GPIOs in that
@@ -673,15 +674,15 @@ void qdev_connect_gpio_out(DeviceState *dev, int n, qemu_irq pin);
  *                              GPIO lines
  * @dev: Device whose GPIO to connect
  * @name: Name of the output GPIO array
- * @n: Number of the anonymous output GPIO line (which must be in range)
+ * @n: Number of the output GPIO line within that array (which must be in range)
  * @input_pin: qemu_irq to connect the output line to
  *
- * This function connects an anonymous output GPIO line on a device
- * up to an arbitrary qemu_irq, so that when the device asserts that
- * output GPIO line, the qemu_irq's callback is invoked.
+ * This function connects a single GPIO output in a named array of output
+ * GPIO lines on a device up to an arbitrary qemu_irq, so that when the
+ * device asserts that output GPIO line, the qemu_irq's callback is invoked.
  * The @name string must correspond to an output GPIO array which exists on
  * the device, and the index @n of the GPIO line must be valid (i.e.
- * be at least 0 and less than the total number of input GPIOs in that
+ * be at least 0 and less than the total number of output GPIOs in that
  * array); this function will assert() if passed an invalid name or index.
  *
  * Outbound GPIO lines can be connected to any qemu_irq, but the common
@@ -796,7 +797,7 @@ void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n);
  * @dev: Device to create output GPIOs for
  * @pins: Pointer to qemu_irq or qemu_irq array for the GPIO lines
  * @name: Name to give this array of GPIO lines
- * @n: Number of GPIO lines to create
+ * @n: Number of GPIO lines to create in this array
  *
  * Like qdev_init_gpio_out(), but creates an array of GPIO output lines
  * with a name. Code using the device can then connect these GPIO lines
-- 
2.41.0


