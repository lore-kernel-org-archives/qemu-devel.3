Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1895CC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqMn-0005Ma-Oe; Mon, 08 Jul 2024 11:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqMk-0005LE-VV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:33:22 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQqMf-0000D8-8R
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:33:19 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ea5765e75so4078008e87.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720452794; x=1721057594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CfDKabwbkhzBnNFkgs25Ai9FqhNzmhV2Qv0inHFS3/U=;
 b=Nq8ve4zpbtkc8EdUhGG5dWcmF3vV7RoNlbMa6isw4kL9/20xBfKjg2d0AUpBms260q
 DCI3qJz2ZXI0MSSabxpnI9mHDDvCKRwksjyZA9xuvHjIEW+cotMM9uCuZxHxDxY1JOZL
 16JZ+X1m2p2ifrvkcgCJjKDP/L91PCauEJZdnKQYn4kG1SOPxkitXBYFBJhDSGf4hjUn
 xC1kCUESUujw81Kd39i3lnLZQ6JIzuvgO4o5HTfKRLmNyGsbYIjYAOH0J87zzObWbI9Y
 M7MGzSlUazirXEPBbr+4BcZnsVhrAQIEmMMGboqUCxLMe9WM9t3F3Pzr4LcT/RC5bAON
 mfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720452794; x=1721057594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfDKabwbkhzBnNFkgs25Ai9FqhNzmhV2Qv0inHFS3/U=;
 b=SJo5e0CIy8ih5mJpPYDnWGFZioMDPYWhdwJdbdyFNDklBOnmuOpdMutOoAWWdYF2TL
 SY04emN0rz2LChc+ODZZy2ml2/KiEp745Ik6rWMI6D1s9kxs32ZQlVdmDGrpY63YFmgH
 LgrUiS6B4rS6dkCvf1kb2YOh7zfOo8J2LpMXuMGa9DxZmZqcK26YMm+XJcdLh+fSVhXW
 pzb+6OlfT5EX3TpCtJ7ij2jMp3M1cBMXbG/XGIFNWdY9KpnY5rSSnYbxKoKPo5X2vmx6
 wCfq/UedsXikjP5Q8l8tYbZr/NhdhbKsMvYlv0g4xtEfOEdFDd9plJLRB3sQCARU8Cs/
 0pjg==
X-Gm-Message-State: AOJu0YyZC5U0CxuiEs2KrEGA/z82uK5PrILiSFoLKq12GM5TpcK6WCTL
 S5V5C9QKDDEj+dg/fgEpbxFBcPq3WKCaqGkPQq4SGrza5vSB2e7ap8VQpzzrKmb7p1UZjIpm+ax
 KjvY=
X-Google-Smtp-Source: AGHT+IHkOZhjpccss1GkjOYqcTQ3dhrsEkSpbvUQgShPUnl5t9DHST4nBxYLw76fHQtPQC7RaSCVEg==
X-Received: by 2002:a19:ee11:0:b0:52c:dd21:8d09 with SMTP id
 2adb3069b0e04-52ea06e8702mr6832080e87.63.1720452794255; 
 Mon, 08 Jul 2024 08:33:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4265f84cd44sm95476115e9.18.2024.07.08.08.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 08:33:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] include/hw/qdev-core.h: Correct and clarify gpio doc comments
Date: Mon,  8 Jul 2024 16:33:12 +0100
Message-Id: <20240708153312.3109380-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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
---
Does this help? I wrote the text and know what the functions do
to start with so it's a bit tricky for me to see where the docs
don't state things as clearly as they ought to do...
---
 include/hw/qdev-core.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5336728a23f..77bfcbdf732 100644
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
2.34.1


