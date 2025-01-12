Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9962CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6HY-0007Vu-S0; Sun, 12 Jan 2025 17:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HP-0007Td-ET
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HN-0006PG-DE
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso39392225e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720273; x=1737325073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GoeTs3OwFxXFIF/0sszVZvTSkwjTETcrGfwBocwM+s=;
 b=T1vdYGt/BNcDErDAjxNxFcs3bhFrOU3Pq7dPtb6PUoPB0unMiprQeZGkBBkBroSdNv
 m/HjdqP9K34XApdqCvBFc/x/0SZEmMzzwnzeRPsTdErNCoc0lETK6lcRS59U4qJKEBVg
 E4zjHRsboLuSqhRSKsWoMjiFjc/+zsYuco/7on2Lp5GDiBAK2Fu/+VFbwQiAtfelc1R8
 XD1HcT27d/ZwlzgEf/9hVNpiTVZiUIKsBQNsCL4J2LbCoL5AIunpCaUOoH7V1ZnkqSQz
 91J5iAkOcYIbf4i3ywK8jlUzYOortqk7xzyuEkcvGFLua8EjyqmwnYs2HIFZ59PVXhMo
 cSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720273; x=1737325073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GoeTs3OwFxXFIF/0sszVZvTSkwjTETcrGfwBocwM+s=;
 b=CmsHDcPMPanYRUwp34pJ2EFuLIhB4XGW0HsbpKkQa1Xs4Dk62nLJvrLa+yM8HqNW1s
 B0Kehp1FLVKvQ5+n7LFgZa9VOzPF32+m/WcZq1JY8mCe9+6cOl+lqIPNLq8fq+RYMnxi
 qmJZhokPSJ59cSGsOpJqJTozkeqdS+F21IRTD5tUqZM4nS1MysiFUqHCAka7vfyL0elh
 IbwlyoXT+iCwqweTgTcvuyKG86DF9SERtc/1fs3TrdzUO1h0XCzuu6uovNt4tivywUZf
 mAiIocbirkJiiZQAZ52uND74gj+J2hQ7C0zwhjzb920vvki1/8pV2AGBnXL6WBoMBSF0
 TWUA==
X-Gm-Message-State: AOJu0YzlNF5Ieb+SkLc5HWUz/Pfl+iNpDV5eFqrtsBEaahJuRZfZca4O
 iLJNXIYHW1yDIghPWWqGRkR4wOmCclVLYCTe5a5+gyJxkP4bQjE53TQ2q7wQeVM5brNdDHl3Hbn
 W2Mk=
X-Gm-Gg: ASbGnctEqQSUDWYswVXtuzeFo0Zbtl6OIrDPSxos6q06VziI+sIILYeSgNB4IzgZZEh
 mjmwiHiZ0YRA9O4C+dS4uoCjVAmXpAFqo6HE24mPMDvm69FPJze6q0Yynscmusi7zH/IY1msfA2
 ql75l+b6n3Gn0lUJZmx4/j2eqoR+8LiJ1X6TylvOqdUVuexg5U3hpg+pjKtqEXdAFiSxqDmH3XQ
 V5nlpLfRV6oFlDm7GSWfeVrCU1QH9VW3yJXimCocdZYh/9QtBgwjrefUodmJa0LaZrqXT9Q64qP
 1xPSzDpDS2mu/Gtln9k7DppX7ehyCk8=
X-Google-Smtp-Source: AGHT+IEs24aJUBPMRXTZ4B8w0IpRd52IbWTRH1n/r53QH82XbaOhbiqFSUpCOV9eV9flbKvDS1+wdQ==
X-Received: by 2002:a05:600c:4704:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-436e267f796mr136934085e9.1.1736720273147; 
 Sun, 12 Jan 2025 14:17:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd15766fsm98095965e9.2.2025.01.12.14.17.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/49] hw/usb: Inline usb_try_new()
Date: Sun, 12 Jan 2025 23:16:41 +0100
Message-ID: <20250112221726.30206-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Inline the single use of usb_try_new().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240216110313.17039-10-philmd@linaro.org>
---
 include/hw/usb.h | 5 -----
 hw/usb/bus.c     | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index d46d96779ad..bb778cb844b 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -584,11 +584,6 @@ static inline USBDevice *usb_new(const char *name)
     return USB_DEVICE(qdev_new(name));
 }
 
-static inline USBDevice *usb_try_new(const char *name)
-{
-    return USB_DEVICE(qdev_try_new(name));
-}
-
 static inline bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
 {
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index b19b0b13ebd..7e7deaadcaf 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -411,7 +411,7 @@ void usb_claim_port(USBDevice *dev, Error **errp)
     } else {
         if (bus->nfree == 1 && strcmp(object_get_typename(OBJECT(dev)), "usb-hub") != 0) {
             /* Create a new hub and chain it on */
-            hub = usb_try_new("usb-hub");
+            hub = USB_DEVICE(qdev_try_new("usb-hub"));
             if (hub) {
                 usb_realize_and_unref(hub, bus, NULL);
             }
-- 
2.47.1


