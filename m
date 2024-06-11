Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA9C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyet-0006QS-2V; Tue, 11 Jun 2024 06:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyer-0006Q1-HA
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyep-0000Xu-TQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f1c490c13so2913708f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718101394; x=1718706194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+Nzh48rBgkECIQzn+94+NuX+YcHJey5MBlADXTE7iY=;
 b=KJG+p6Gaep7ZeyuhRNWXlqahgUstN7Qde79a8RV7DIzA6FNaiLIAZYb6CmX3kKBHGJ
 2YL+azEkUXMQva5OMZkOFdLNnz1n/jMZs6kzUlipUL6QwrT5cIjdKf52auS6tSq/zn9i
 7PkZZPMYF0zJwAnsO+gSdNYYNDrNo7aG6DIOWNzK1QqobX64Tm0xF/qcpw6IuDVW7gtq
 JWvIvzCzQCqa/41a2zwkT4aDpBpkfDFtVnIgDDTSuX7lOXusEkH26ow2Ju2CtZOmBALd
 zq3lqvy4LjFm/Wl9G+9IDOo1ftLygM8oIL/zs7+6YbLHsQjfEKUqmwIRR9UXBqyK+u6n
 8Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718101394; x=1718706194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+Nzh48rBgkECIQzn+94+NuX+YcHJey5MBlADXTE7iY=;
 b=gKT6ffwLbuSEPAbOBHGEx2OLDAUHWLTBuz1WSJExMex1fqrIuyyBDZbglqGaUYpEgU
 BoB0/kPTTBpVc3w+MqaW1Bi+LqLEySa13zaI/AdO8ABH6Eods6EWwgdCFKvhPgxgaLMv
 +x5QMk1HKEWzgQNlJSw+oxON4pbRgzxYm76x6LYcSV4JiDwjyRDVu20eFVEXTAmteJx+
 JQsp6JULQCL+7Exo0KqPbTTbCBqbMyEoG1Bov3WvEQIYxtbae9FMSYRoIiMFqpEAlerJ
 KoxaEnbj+WhB4czhspWeCynI5gaJD0eA2/H4AFGgnZC69L4iqtzDblTS4Ay7AcG2mMpZ
 U6Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlj5CP/qiia0bSI7SNDlrbQsAYsYkWcu0rVP12gZ86rE78ysRkSgmkXvjzrrC3eRPbBsorAYKRT3UtoOEEGnBpSFZkwpU=
X-Gm-Message-State: AOJu0YwGvE3bIRa1FcUZ1e1LRHInyhfDg1r5Xc7K5tKINqiwUY/970Va
 lG5j315wxH3fOffAGIo2A7mBYm7NfwRhE7VGS5YolreQP4m/APpYy0eUO6GmZjY=
X-Google-Smtp-Source: AGHT+IHNfP3UR6zjAE83/iqUWBf5IOF6zOgXT2KlPLC63mfj5HJvT36bApcL52OSte322BYej6+iPQ==
X-Received: by 2002:a05:6000:b43:b0:35f:900:4e6 with SMTP id
 ffacd0b85a97d-35f090005famr9425893f8f.60.1718101394184; 
 Tue, 11 Jun 2024 03:23:14 -0700 (PDT)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24d67093sm4999971f8f.96.2024.06.11.03.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jun 2024 03:23:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] hw/usb: Remove unused 'host.h' header
Date: Tue, 11 Jun 2024 12:23:03 +0200
Message-ID: <20240611102305.60735-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611102305.60735-1-philmd@linaro.org>
References: <20240611102305.60735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Since commit 99761176ee ("usb: Remove legacy -usbdevice options
(host, serial, disk and net)") hw/usb/host.h is not used, remove
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Thomas Huth <thuth@redhat.com>
---
 hw/usb/host.h | 44 --------------------------------------------
 1 file changed, 44 deletions(-)
 delete mode 100644 hw/usb/host.h

diff --git a/hw/usb/host.h b/hw/usb/host.h
deleted file mode 100644
index 048ff3b482..0000000000
--- a/hw/usb/host.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Linux host USB redirector
- *
- * Copyright (c) 2005 Fabrice Bellard
- *
- * Copyright (c) 2008 Max Krasnyansky
- *      Support for host device auto connect & disconnect
- *      Major rewrite to support fully async operation
- *
- * Copyright 2008 TJ <linux@tjworld.net>
- *      Added flexible support for /dev/bus/usb /sys/bus/usb/devices in addition
- *      to the legacy /proc/bus/usb USB device discovery and handling
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_USB_HOST_H
-#define QEMU_USB_HOST_H
-
-struct USBAutoFilter {
-    uint32_t bus_num;
-    uint32_t addr;
-    char     *port;
-    uint32_t vendor_id;
-    uint32_t product_id;
-};
-
-#endif /* QEMU_USB_HOST_H */
-- 
2.41.0


