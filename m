Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304CFC54E51
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2H-0000j2-Ma; Tue, 27 Feb 2024 03:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1x-0007u6-KN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:43 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1w-0008AR-0R
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:41 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d220e39907so63255661fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023297; x=1709628097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPm16UPsnU4F/4oJXar+5N8ETXoxZOH1kbNjYRQpNV0=;
 b=rcJligoQblwAJ4JCuYj7ylTS9+N3IYln4qB/Be9hSHJGr8Na6JAqdv8q1MBbLHKePm
 UXarjKcg70IsR1k25gI19UVIUG2Q9GA3/zcVNTI3K8nS2FT+eSNHfezttGMqos1IoNqi
 U8J09SlkTtSXxqiHInisBATNsaX7J8yWC9vpSpEKtW19xgswqGiAL+1Zl4vHJooO1/72
 wJ/zoGrvKZLA5JXeF24aDgE8Vm/M0yPYabPx8kJloQY0krQvhWC9Ix2yOTuL7FBWtjW/
 qgDa3UBlrj3H56xN3N+NraT9wUyFFWFp9pAZMu4xxkBdGRnrTaHpPrzNMBOFLkE9afNE
 WHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023297; x=1709628097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPm16UPsnU4F/4oJXar+5N8ETXoxZOH1kbNjYRQpNV0=;
 b=X8ORfNwXY4oQtrDy7bJYP0EUN9YMbC4fCmGusm/wcRB4RPmKSgPOqsqepv2yHUBqj0
 5CAlHDsbUl5uWFExK5qBByjV93eZ5qhIQIR7Ar2MqH38N+7ZO6dqZqyvfS3ilJ4tL/4Q
 cptQk3mky+WXWhK/7X5g6rbu51rI5yoc5H/4w6qCArYFUBtl+OqtWfSJev2P/hll7aWV
 BChFlzCX7wycTyJ7IPuvbWr+pB1KNJYtPCJrwJ/+hbtzXH1lp6s7loUj7O3p7KJHjmJF
 1XcxxMM796Rb0G79MvtNyudQ/kYivMjDtb1KQfABz/h1MSTwXsdtyHycTwTBDnusZWPf
 4omA==
X-Gm-Message-State: AOJu0YzxzBHiDPGz6Mec+PnNiAD4JumONGYlOimoMnj8muDWAMzirknw
 Ni7OGyt2EvcA09qPgtAUcfiXKzpafeXtWB0n5VcfIr/P2dAwppfVB8PVHUnLjw40nJ29b01ldWo
 J
X-Google-Smtp-Source: AGHT+IFcaDayJbT4H+1fH7SfXNgHNb226cHPP5331/6xu5QjiH4t6uJV5SqFwlEyBu/IKD0duQzz6w==
X-Received: by 2002:a2e:8784:0:b0:2d2:3c10:4b6c with SMTP id
 n4-20020a2e8784000000b002d23c104b6cmr5534555lji.24.1709023297560; 
 Tue, 27 Feb 2024 00:41:37 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 n1-20020a2e82c1000000b002d236114533sm1162859ljh.75.2024.02.27.00.41.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 17/30] hw/usb: remove usb_bus_find
Date: Tue, 27 Feb 2024 09:39:33 +0100
Message-ID: <20240227083948.5427-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

Inline the sole remaining use, which is for the -usbdevice command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-9-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/usb.h |  1 -
 hw/usb/bus.c     | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index cfeead2840..d46d96779a 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -498,7 +498,6 @@ struct USBBusOps {
 void usb_bus_new(USBBus *bus, size_t bus_size,
                  USBBusOps *ops, DeviceState *host);
 void usb_bus_release(USBBus *bus);
-USBBus *usb_bus_find(int busnr);
 void usb_legacy_register(const char *typename, const char *usbdevice_name,
                          USBDevice *(*usbdevice_init)(void));
 USBDevice *usbdevice_create(const char *cmdline);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 76fda41b7e..796769fadb 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -100,19 +100,6 @@ void usb_bus_release(USBBus *bus)
     QTAILQ_REMOVE(&busses, bus, next);
 }
 
-USBBus *usb_bus_find(int busnr)
-{
-    USBBus *bus;
-
-    if (-1 == busnr)
-        return QTAILQ_FIRST(&busses);
-    QTAILQ_FOREACH(bus, &busses, next) {
-        if (bus->busnr == busnr)
-            return bus;
-    }
-    return NULL;
-}
-
 static void usb_device_realize(USBDevice *dev, Error **errp)
 {
     USBDeviceClass *klass = USB_DEVICE_GET_CLASS(dev);
@@ -643,7 +630,7 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
 /* handle legacy -usbdevice cmd line option */
 USBDevice *usbdevice_create(const char *driver)
 {
-    USBBus *bus = usb_bus_find(-1 /* any */);
+    USBBus *bus = QTAILQ_FIRST(&busses);
     LegacyUSBFactory *f = NULL;
     Error *err = NULL;
     GSList *i;
-- 
2.41.0


