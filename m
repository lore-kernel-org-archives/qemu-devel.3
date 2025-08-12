Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9ABCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpcI-0007X6-Cd; Tue, 12 Aug 2025 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpcG-0007WP-S7
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpcB-0007kY-UG
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso34684785e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755007472; x=1755612272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjNdH5Wyoh4MqiPJIO2aI8sd0ovUKaYmzU8biN1Y86k=;
 b=vbAIkIckyMWFoO8keKgKE+Vfx8ws0nj7ywuZCNDFi0xveWfbRveLPN7CYwWxNYvSgK
 fDCIayS9vuTwfAYo/iBbaZl86rXpPhpe37Ev2tcUpiH0Eod1jPA93T2mPxPR8qXKkhlP
 K4n9LhBSNu4yPozJXWVIIo/eO3Og9dKvOyetMV0hweINRAc4yH5KXxXmnvvWxmkJOzJV
 SYx75fO6EQIMZhyltli24CpbJ1adOXvK95/5P7kURByooIH28LwcGblhuYNS6/745Kni
 ZcU8HjE3kcCmCJQPlhiRBQYWCJMohmoQehFX7MlwpD8zcVdrWpoTgMABgAslaPnq3W9k
 +B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007472; x=1755612272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LjNdH5Wyoh4MqiPJIO2aI8sd0ovUKaYmzU8biN1Y86k=;
 b=bLN0eIKTwZbGKblYkqMUOQsu+59I5g5EJr5l4L1b7VCFwu+dL0PhtaewWI/n5RJefz
 oFm3VZc3KrlKU43II6+rETM5ZvT/LVQs9syPPQKdWTVzImfi++rFU3DpCKcG88V/b0Zt
 tjNkkpKYhGd9X7iQb8Zh//U6J8L8pYXkXBa0wiU+F9zNvXGr66fOlHbB279yOtpCPBpH
 AOlL+KdCk1Fw7PIfpv/qStIwaTDxYI45O1Q1fvX5SnfoOkULBY+pxhKWVL4Sp7YjcmMV
 HfEpbxnXlRScSvjeh9KkT9TRjITQMdBTvI6O6Nnv5ojhBHdZOsnkjI1Q4gd9TfIjDKHC
 QXJA==
X-Gm-Message-State: AOJu0YxVSymoabnw2cYdDJr/qFl8KiPw2cadM4TBd89/cPp54VGUCuKC
 QuxmnZ3J0tilnLeiMi2J180s1iGuHsUljNB851eELEz1TwVThjsCxKgYQi+EJdLzsSLpVAthfQq
 yOQb0
X-Gm-Gg: ASbGncveZh2vN1nk1OfCm8Xzmi9slMzZnfHytN5slqx06DKxJqtlxQ9XRs4tojeIhMS
 OFOHGng2kqGzPBaJP4LPoiN9rujsudKck3BNdrdiZroWDY/Rg1Zs9+mrJoTCFH7FTUWhLxsqMbT
 3waiY8Jm/N0YuKtyU4XM8Q34ZYV298KVW9hutQ/5Rr5D+qJpSIxhJyRQ4ulL3ByrjIVOlsQpXPy
 kfDtlgSjfrPUtBm+qHLz5E+M/cvSRmewdFfDm9gjZ6pdA2vFTursdLHsO8d38D8KncasU552+I7
 NKiZ0JfSGrBAhQbY6Ed3D3bdjQRD5XsOnATkWZtJnb1rYpLngN6s7Ng+pYmZv9CyNMwVTtSVwkJ
 SlH3TLG7QNnvSSr9jvrtTG3w8KJKwbjCnnr+j/G5o9GQjHIdV+12qaJbIRILKeWPOgAZlwQqi
X-Google-Smtp-Source: AGHT+IFL6WbcU2qAox8o9N+QNZjCqE+/L5nwIOJ0X2mUCixfX42bGyAcx0gQoImpf/ZpP1dTrs+pgw==
X-Received: by 2002:a05:600c:1709:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45a10d258eamr23743945e9.17.1755007471795; 
 Tue, 12 Aug 2025 07:04:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5853104sm299223425e9.8.2025.08.12.07.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 07:04:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 RESEND RESEND v2 3/3] hw/ssi: Document ssi_transfer()
 method
Date: Tue, 12 Aug 2025 16:04:15 +0200
Message-ID: <20250812140415.70153-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812140415.70153-1-philmd@linaro.org>
References: <20250812140415.70153-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

A SPI transaction consists of shifting bit in sync with the CLK
line, writing on the MOSI (output) line / and reading MISO (input)
line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ssi/ssi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 3cdcbd53904..2ad8033d8f5 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -38,6 +38,7 @@ struct SSIPeripheralClass {
 
     /* if you have standard or no CS behaviour, just override transfer.
      * This is called when the device cs is active (true by default).
+     * See ssi_transfer().
      */
     uint32_t (*transfer)(SSIPeripheral *dev, uint32_t val);
     /* called when the CS line changes. Optional, devices only need to implement
@@ -52,6 +53,7 @@ struct SSIPeripheralClass {
      * of the CS behaviour at the device level. transfer, set_cs, and
      * cs_polarity are unused if this is overwritten. Transfer_raw will
      * always be called for the device for every txrx access to the parent bus
+     * See ssi_transfer().
      */
     uint32_t (*transfer_raw)(SSIPeripheral *dev, uint32_t val);
 };
@@ -110,6 +112,18 @@ bool ssi_realize_and_unref(DeviceState *dev, SSIBus *bus, Error **errp);
 /* Master interface.  */
 SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
 
+/**
+ * Transfer a word on a SSI bus
+ * @bus: SSI bus
+ * @val: word to transmit
+ *
+ * At the same time, read a word and write the @val one on the SSI bus.
+ *
+ * SSI words might vary between 8 and 32 bits. The same number of bits
+ * written is received.
+ *
+ * Return: word value received
+ */
 uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
 
 DeviceState *ssi_get_cs(SSIBus *bus, uint8_t cs_index);
-- 
2.49.0


