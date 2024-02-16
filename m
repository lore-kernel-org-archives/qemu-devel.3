Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D987C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw12-00073T-Do; Fri, 16 Feb 2024 06:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0x-0006qw-Ft
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0u-00011d-L2
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:19 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4124907f6fcso2992465e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081455; x=1708686255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iBFC1QhPdWDrDOtRIvOXPWDjCtIz2lHCQrIRmLbo9Y=;
 b=wYiptgNATPM6dlfnFTPvx+lWJzI+wJZgbFG8wYD7C3czB9Cy/uqfistfDLM4yxj/U0
 /qwWlA+2JzfJgywgFXbiX+Fwq1Al0h3JHuQ637UDAC9sFfTbDmZLsUV+nN0mOBBFtTsv
 M5tu/2JKLMzH/GFc/WHanaZy8CdIMc3nSZR52EYbMkINHq/REzasZ4val+iRVC6HbgHl
 A4zS2LKtfaHto88IuwrQHSTzKl9IvJVWSmnJJUEoByabCZYB/APz/rIVLY0kQicaxMwa
 qoYkpCUWivO8Vn2Z3HdweVwQJOa1xnaX29PjdY5MTy7lkcooDRYPunTwZm+hp915dky+
 4Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081455; x=1708686255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iBFC1QhPdWDrDOtRIvOXPWDjCtIz2lHCQrIRmLbo9Y=;
 b=YWuAjOin1fbprF4d13YZGzEHD86oyV30H8jFweDeKLYVEKRO/srFiuiMRQBbU1+gTL
 HkuZIwZXFWBe79/8BwlDgQxj6ZLaTiBSjC0M4YXpwv0Z7VEQHOZT0e9BBUn12bBvtgWh
 qU9q6mFPTgr68WHu+86lh7Ob/MApKLCok4ZfPxzWTbsUGkonV0KQfVZa5URBqKE/BvZM
 BI+WOv37xtjFtz2yhYDaFxvnbMQPZaIP4d4aMwnwzbhNU7SehYzLzz9Ak0u15gpmRZ50
 IefFwo3vlqKYBDEjASHdOO6X7nezrH+FqKwcKVv+qLYZB1BWSIhYXTp85eoxmw0Mi5Bj
 g3GQ==
X-Gm-Message-State: AOJu0YymlkuoUQ0/jHy+y+pwHrobom7DcPv4o021olxw3UA50I3KjXQ6
 Oip7ZXVa5pClMRSyETXT1OIRLDI9sqkf7EB3kfsRiwnKUCYZaUcN0e8+JKgQG564GByH8o2tejS
 m
X-Google-Smtp-Source: AGHT+IF8QGAe9CWzaU1NDXic+DWdnM9DUB8PzSiWHsKJgDo8NqFEzjBod/sng/WkWkUHWzyjCvyQtA==
X-Received: by 2002:a05:600c:b92:b0:410:c69f:51b8 with SMTP id
 fl18-20020a05600c0b9200b00410c69f51b8mr3531506wmb.14.1708081454975; 
 Fri, 16 Feb 2024 03:04:14 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 k35-20020a05600c1ca300b00412393ddac2sm2036410wms.6.2024.02.16.03.04.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 09/21] hw/usb: Inline usb_try_new()
Date: Fri, 16 Feb 2024 12:03:00 +0100
Message-ID: <20240216110313.17039-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Inline the single use of usb_try_new().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/bus.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 59c39945dd..148224f06a 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -334,11 +334,6 @@ USBDevice *usb_new(const char *name)
     return USB_DEVICE(qdev_new(name));
 }
 
-static USBDevice *usb_try_new(const char *name)
-{
-    return USB_DEVICE(qdev_try_new(name));
-}
-
 bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
@@ -447,7 +442,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            hub = usb_try_new("usb-hub");
+            hub = USB_DEVICE(qdev_try_new("usb-hub"));
             if (hub) {
                 usb_realize_and_unref(hub, bus, NULL);
             }
-- 
2.41.0


