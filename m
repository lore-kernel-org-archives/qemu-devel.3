Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC6BC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvaw-0000CM-AQ; Fri, 02 Feb 2024 10:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvau-0000AR-LC
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvas-0004RT-IX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:44 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40fafae5532so19305315e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888201; x=1707493001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1V7+Q0KTyYvIAHFDW7/i7eB7p3uahpOup8LdNc0Y8Zc=;
 b=QS0BjLb7N2WSVl501ICpWCcR+xYQt0/Or6RbTBNuXEiQQg+qI53iirlCw5jrIwMit1
 ejoq8/T+kZWotM9999k0SqoKt+UDbVZTEeR7UUkuW4Q0ElDIjutAf2XKSQigP6tVp9lE
 i4dqHG6D1v61Y3X8uDesM5gsr1ywvQ0KJco1FyfP0T2pZETGLlhRZIMgyTwyPBDQDTKB
 omcRFBwvDbEKKDSQFbajz2fTzKHs/2DZSiFGp0+R3Omg9PTF9cap6vjdjGClMrPJnkm+
 gLT1GrrQ8bfr/evRpTJIAKlM2/bX2MNUAH/ooodtspB8K6PK6PBLR1Ic5CiLUHB0BIA6
 7Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888201; x=1707493001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1V7+Q0KTyYvIAHFDW7/i7eB7p3uahpOup8LdNc0Y8Zc=;
 b=Nu67VZ9ogpDCSzn9hOKu8GaZ8B6hGVZSVoM591kV5dDxEaYNb7B7tEF5jYfSKFBJ82
 MzdYUMXxpyZliGTapWR4/gz9TnL9jW+15UC89h5zd3v6kMEJ72wwVcDcXr78bwaHK9BT
 6meNw35HBl8Z4dJKUj0eNZDm5ukABHTyqfVvUlFs5DGoQBZn/o1/1F8QF74pBYw0zpHy
 532A75y9J0Sk0kh3g1KVgkVdU94vfVljChSXf5X5xbBZ/2xY8XvRXts1zOAtSoUVN45w
 ysjv8jCTlZllZ5jJy0/s7uFoBOSJZXxNpuSVs7nGhAMCMqdpzDnAuGVh4fKduEJ5hoIF
 R4AQ==
X-Gm-Message-State: AOJu0YxcPbuTbcaJbL6mJRUO8gztMZCOuwhmgkW9mBPM5r7CD/hTIptj
 LaJJPgxRtl5cswdQFiT0zCWm8a9U2ZYeMzzP303DbMSUyoI+K/UrW42Ott3Hw1P48B7TMZqx/fZ
 m
X-Google-Smtp-Source: AGHT+IFUtj4qWAJ6L354Y967i9IQdvvF8HqHsYKGG884+2RxmfXkG9vi0ZAHxHol6BJbGppXGA/eQw==
X-Received: by 2002:a05:600c:a39e:b0:40f:b680:3e84 with SMTP id
 hn30-20020a05600ca39e00b0040fb6803e84mr5893811wmb.2.1706888201257; 
 Fri, 02 Feb 2024 07:36:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] hw/s390x/css-bridge: switch virtual-css bus to
 3-phase-reset
Date: Fri,  2 Feb 2024 15:36:06 +0000
Message-Id: <20240202153637.3710444-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Switch the s390x virtual-css bus from using BusClass::reset to the
Resettable interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240119163512.3810301-5-peter.maydell@linaro.org
---
 hw/s390x/css-bridge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 15d26efc951..34639f21435 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -56,7 +56,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-static void virtual_css_bus_reset(BusState *qbus)
+static void virtual_css_bus_reset_hold(Object *obj)
 {
     /* This should actually be modelled via the generic css */
     css_reset();
@@ -81,8 +81,9 @@ static char *virtual_css_bus_get_dev_path(DeviceState *dev)
 static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    k->reset = virtual_css_bus_reset;
+    rc->phases.hold = virtual_css_bus_reset_hold;
     k->get_dev_path = virtual_css_bus_get_dev_path;
 }
 
-- 
2.34.1


