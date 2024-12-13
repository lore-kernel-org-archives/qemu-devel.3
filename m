Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C93E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3K-0005QZ-ET; Fri, 13 Dec 2024 14:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2P-0003ds-Ns
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:23 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2H-0006eF-KE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:20 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e36b27b53so892077a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116952; x=1734721752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VHlG8PfMsBdkVBprTDqyuBAqBPyNMa5du4T9t6Csx4=;
 b=uVELerz4HCplIJgdKTciJl3bWgtAjNOHPbJRMX/iVEJkIkW1hMNs0cJ5RFGrR8PnO7
 xgawOaqH1W6Zrpbqs5Tf0JRkt6AYXlv4IJY6OjbPK0KNBuyrv5qPzufAvRlUOJhlV0Ff
 lWB+EpF11SMd0PPkMaJT4LHUGXL6DOG439UJgLrpgjYqPvmV6BMA165rq+r93W035KLH
 i5PQWxhO1bzmtnHFqNLzGTQmHisJN/nbm8udGYlCCSUVeWBbTrcvpruyjMHRgz77rGaU
 g1anh3IGQmnlT5KvZ3dCzuB1blixGCRS4IVwyH8ptcqczoocpjcViffuq+661PNbprKy
 ARPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116952; x=1734721752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VHlG8PfMsBdkVBprTDqyuBAqBPyNMa5du4T9t6Csx4=;
 b=dXBKA5z/F5ky0jDjieuBEJ5IgNJ9EOnmxWv23NaPUbA5XTpFy1ayVPgTNTG9uSQktX
 Y/xVpAp7KVioX/LafujoYtiDGFJ3QSSbFgNOebkvVolksROPanLc+XYuP1jwS9VKrLHt
 7PlJQ0HlbiIprPz91tH5U5juZWUEZ2B+c1NkbMUrVUx2inMCrrRMJITygIgcC4nb/0VZ
 dNP1A1vsBEbITBUyzoP0aaV6B2xOMYHZ3DR3DU2+KP1Fyzdhbi+v+waX2LmuiGraqfOs
 /9Fj6DDClQnDAt9CLKrpqf/Eslvr+1raHjsdBBnZrKXV4y1g9m0Y3INOTnOtNGwpRITc
 HEVA==
X-Gm-Message-State: AOJu0Yyv9TKonpMtO1mDiUQJlNVW+Xa18C/MRgXrvcd2Z4NC9oXFRLsO
 tsyVUFkJS35jIwhvv3nJPB7hWNo338ZfF9Sa77EqYWSwL/AtbEh5Pe1XNT3VBQ/BXMNuQhep9VB
 ji3oVetg+
X-Gm-Gg: ASbGncvgvXdetvRSgjh8lbtnPWBJWUIZA67pbOPVxDUZgLrmbUcTL1jBrZ08mEOyfJb
 rqF6a/Xj17BTyynuOKDDu6B9hoE7Bmj2H8nRKb2CiyHbbGAROtoVp7lpd3INI2XSwotWIUfjjGI
 Hzo9cMUzjcXpVybuChb8JVh8+Z9x/Y+ZuxGn5Yz/s6aIjKibQZzCeDSRzOYrw2ts1PII57Eo6CK
 byXA7wHjAKdmdMBylDoyHHeAdV6JpvFFkUx5CFUCdLPfxS837FJhafQeZHAHgXt
X-Google-Smtp-Source: AGHT+IGEyRH9HHL+hXI9ln61NXdu6hBQ0E0Azc7UfGZaiXjnedQzhtzXg8cv3yXUzGxNJkJEPojP6Q==
X-Received: by 2002:a05:6830:6c14:b0:71d:f429:7f95 with SMTP id
 46e09a7af769-71e3ba779d5mr2253520a34.29.1734116952105; 
 Fri, 13 Dec 2024 11:09:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:09:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 21/71] hw/core: Constify all Property
Date: Fri, 13 Dec 2024 13:06:55 -0600
Message-ID: <20241213190750.2513964-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/generic-loader.c | 2 +-
 hw/core/guest-loader.c   | 2 +-
 hw/core/or-irq.c         | 2 +-
 hw/core/platform-bus.c   | 2 +-
 hw/core/split-irq.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index ea8628b892..c1cddecf60 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -179,7 +179,7 @@ static void generic_loader_unrealize(DeviceState *dev)
     qemu_unregister_reset(generic_loader_reset, dev);
 }
 
-static Property generic_loader_props[] = {
+static const Property generic_loader_props[] = {
     DEFINE_PROP_UINT64("addr", GenericLoaderState, addr, 0),
     DEFINE_PROP_UINT64("data", GenericLoaderState, data, 0),
     DEFINE_PROP_UINT8("data-len", GenericLoaderState, data_len, 0),
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 391c875a29..74af00cee7 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -111,7 +111,7 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
     loader_insert_platform_data(s, size, errp);
 }
 
-static Property guest_loader_props[] = {
+static const Property guest_loader_props[] = {
     DEFINE_PROP_UINT64("addr", GuestLoaderState, addr, 0),
     DEFINE_PROP_STRING("kernel", GuestLoaderState, kernel),
     DEFINE_PROP_STRING("bootargs", GuestLoaderState, args),
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index b25468e38a..fc52796f54 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -115,7 +115,7 @@ static const VMStateDescription vmstate_or_irq = {
     },
 };
 
-static Property or_irq_properties[] = {
+static const Property or_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", OrIRQState, num_lines, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index dc58bf505a..a29c9c6e59 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -204,7 +204,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
     plaform_bus_refresh_irqs(pbus);
 }
 
-static Property platform_bus_properties[] = {
+static const Property platform_bus_properties[] = {
     DEFINE_PROP_UINT32("num_irqs", PlatformBusDevice, num_irqs, 0),
     DEFINE_PROP_UINT32("mmio_size", PlatformBusDevice, mmio_size, 0),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/core/split-irq.c b/hw/core/split-irq.c
index 3b90af2e8f..40fc7e2e77 100644
--- a/hw/core/split-irq.c
+++ b/hw/core/split-irq.c
@@ -59,7 +59,7 @@ static void split_irq_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->out_irq, s->num_lines);
 }
 
-static Property split_irq_properties[] = {
+static const Property split_irq_properties[] = {
     DEFINE_PROP_UINT16("num-lines", SplitIRQ, num_lines, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


