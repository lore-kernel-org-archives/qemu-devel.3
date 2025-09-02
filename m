Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D2BCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnk-0001SL-HD; Tue, 02 Sep 2025 09:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnS-0000w9-Ji
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnL-0004Xw-1D
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso3448255e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818683; x=1757423483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ffy782YI9rbL70UmV1deEFYCAKelshR+/2GjIPy8X8Q=;
 b=pmFaowSgEqZZAy50P3iPSXsxMnEsrZSNJBZjNcCw3HZwUhDHBVDtYTLkRS1X2Hc4B0
 XuMh5zwa/tqBPuzar2kdTOmm+sbaforY7n5DYJ9gkZv5/PzupREQe/J/CBxtd7AVbCQv
 YX07FYhSHCyapj4onWDX0U0p+KcvVD589NwRXLcFzLfIQIwWZTgn5CpqjHRey63M0CzW
 rThahVyJFtHWQO1zZDzxSIUl0BWI8gj++2fB7jsjJupJn16oC3cjsk/1neLKuDzs8IRA
 KvfVDB+GXNvlZk4Iv4iIMHk7MSjuWo+Ms/WLTmUIktg8MQ5XWCDzCLgC3d5rI7zz1MQG
 9BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818683; x=1757423483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ffy782YI9rbL70UmV1deEFYCAKelshR+/2GjIPy8X8Q=;
 b=iiCAVIqe38BRgindzAxpLrPKbe2WTYCKkzXPLCOLXau9ASoYlia/P6Ne0qSWiJ5hZA
 4RUHVahclINEjeOPUszpdnaAMSkm32agCIBw1q/F/1GkvsZUO/DBDgSyj92bxgETYYuJ
 t3BbpRg0vfKnoMX3GE0IUjPgDYztnKqWQX58sgqR0vAyodDSKLEoWi9gE3bev1lokPB5
 HpFQ53Yp0upBYvSjI8RR4yIsF93NDGPDQWVpVSR/wWOBhcw3zK/1NLAbSzHFwl8iQR4K
 FVvbrwxyZkxWFCPoGs0jJ3VF4C3F6LK1W6Ue0ucc56/cRGFk91cuTR0wx1DN6drvewDh
 NTiQ==
X-Gm-Message-State: AOJu0Yxz7yGplaOc7a3c13pwdrMSNiVcFJKBHep6VOqhbn95AZZ1JhwF
 zzvSycVj0WZmqyETqjaJnnOzSN10ZRmUZtr/bsd3P22g/UwkCME1b/JDUjUXBft9y6MKttpEi9T
 LICin
X-Gm-Gg: ASbGnctDy9bzeNFq9PHptka+LNqf0ssS2i7/lttycsW6kjxMrMUNsIhRbhzRGjNUpVF
 JUbvWB9k3agHi/65FkIoY5ZhIsK6vDMZQiWA1a3y9VbyKYPjDO9ZKFPzcvb27s8LmsjPb9SzS90
 J+OhQGI2dXACiHr7aUIzYMLFRmP9D0AXF5RVgLrNFrpBx16csGHqSEnC7vQzuTkqC7wviECtu0z
 /F9ugZ2euxcngeDDdHFloEDS1nGBnqEUJp75P8CPKnQ9YoVEBGhcvZnvpellKbWnYEBIBv2ac9F
 wNdZCSZO++VLMhrQ3RjnmKSLBgqUZYCBKO0+erXwaXUFrCF8HNcvx/DjE/IB/ejpb9JAvzWX5iR
 zPRMPOwufrTwyAJJYljD8V/flefLQUHqytEJlLaMbjP4S9RZ0gk6XY1XDnDMj0gMVvNlxFfAeQk
 wf0w8v3xBjIcBskRhC2Q==
X-Google-Smtp-Source: AGHT+IGie+8qYrr46iOMFvLWII6ZPPL4DiSQ64IT2RKSkgVeNuurS1qTH440zo9+99cohtd6oOV5RQ==
X-Received: by 2002:a05:600c:3115:b0:45b:81b4:1917 with SMTP id
 5b1f17b1804b1-45b8555c359mr97915305e9.10.1756818682763; 
 Tue, 02 Sep 2025 06:11:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7fec07sm193103085e9.10.2025.09.02.06.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/39] hw/ssi: Document ssi_transfer() method
Date: Tue,  2 Sep 2025 15:09:51 +0200
Message-ID: <20250902131016.84968-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
2.51.0


