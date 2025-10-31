Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A5CCFA03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwQ-0004HS-Di; Fri, 31 Oct 2025 14:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwM-0004Fx-LI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwB-0006Aq-D7
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so1697383f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935593; x=1762540393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LPeA/g+pch0tkk30DBEizWt4XL6uVfpnMmfjPQ5229E=;
 b=qtEuOZ5E0+SHc0+ACOvDrRGB4GeaeytXZguRKfg0WoK7if2b30Gklq80zq5sck5nm9
 eB8KzeS/Wf0auTsv4W72n5zu3UomQ2hyCI17Dd6v0Eh59eRGCJnkm5YkYEik5ONoRuWd
 1AYmCVh7JlqERuNbWcZi9NqF8VJpNcc7fWsmF8okPTiyYEJA/Gq132vCs/R1O/8BPjUR
 2gaSTW8hZbsQEdNfhc9kauM58WpDiiB71ZRTBtmrdR9RbwZVgeK56XgIgXFVlBO3mxUt
 cS18SPOTaCTNkBitRbgLv2Wfj6ULvEACf2tScnszHh66dA3ZnJUFKoQe5PiPD0o4HZcZ
 luVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935593; x=1762540393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPeA/g+pch0tkk30DBEizWt4XL6uVfpnMmfjPQ5229E=;
 b=e7QwHJCOKbAckKYEQ57lIqJ2HDuYgHRE+LtPreqXQlUtQLnd6ep5zPaXsqJNNhoi27
 taEMQ3V7bUjs634CaWMlkhmNp1jg5ktmtkMWo8zYrgdcjRYVLb1kMsl/be9cnlKsBL7I
 SChvFRsn8nIyqcCBvk0WS6RJdISHjeIn0x//18WUAQbave3ci5xE3KQpgNl7iW6xeeDx
 +xisJdK4MYMl5BsIgq+2bb+5BoO1EOlxAPV/qqsmzDHKtqETT2v9vmAa7MH05MqWC0Z4
 W/fYp5T8RqOwFJD8PK0zl4x1+qJqc9nxGyki+CEGY4q1N7UKhdVPreUI1ASgDqyLnkIl
 paCg==
X-Gm-Message-State: AOJu0YyIKgBCCetfAUvYNObTC1gdmgCuAxS6DYGzhJs6IjPKM2Wi6Rl+
 sMo31OUlczRuhL7QxZB6eirIZPYt3d2IkWHuZibp2fXmYDZVUcHjIcB4qsj4rrdRWYIrXkx5W3B
 AwPC2
X-Gm-Gg: ASbGncuORiXQNQMNL/c0npx9LQtGBuqJp85TUxR+OQ3eZe4x2Ikv5R0+V1Cu76v3JOe
 8Th2zMabebg6UnpG18lk9RPdQIvVuI6QQZtAvF1lbG30imjDRdHr7yVeyDfaauYT3Q9UPga4zv9
 5UDNuhZqhg4V2OuY+e3q5merZmie0+hdkDQuD2I/YOMlThnkC9Sb93NXXTvV+7G8TSU5DWCPH7a
 bkoYATgPjG661W2BCFI2SfQtz//kKgoB4O2rI/u/8r6J/OCYm+AZ6JMM/ZAN8FxxPJP71QGd0GG
 YElcOzZwP8L61O96Q7uOriPX1oVgzD+zfWbAB07YzjOirwFlyPIZR6czWC4qpMJVJwRHHXIVtvg
 KfMv4LH+hP1u3bafmNSk3PXwPCImmA2SMUI1Q1eptXdEcFiYyF7W5GSzFBppjpbOr+bbE4Yz2eg
 85Od/a1HBuBZjqXrBD
X-Google-Smtp-Source: AGHT+IG3UnxSrzCEDqfE5N1jTAO1mG6iSQGTIlKe1Drl+tINLCzcWgkfXnn8JsE9ciGjaVkdNy5zvg==
X-Received: by 2002:a05:6000:18a3:b0:428:3cd7:a340 with SMTP id
 ffacd0b85a97d-429bd69914fmr3914605f8f.35.1761935593309; 
 Fri, 31 Oct 2025 11:33:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/38] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
Date: Fri, 31 Oct 2025 18:32:33 +0000
Message-ID: <20251031183310.3778349-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

uint8_t is good enough to hold a property "between 0 and 0xff".

Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
macro, remove unnecessary range checks in pl061_realize().
Update the two caller sites.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c        |  4 ++--
 hw/gpio/pl061.c      | 16 ++++------------
 hw/vmapple/vmapple.c |  4 ++--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d07cfe16512..b3ecd6dce36 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1136,8 +1136,8 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
 
     pl061_dev = qdev_new("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
-    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
-    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
+    qdev_prop_set_uint8(pl061_dev, "pullups", 0);
+    qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 1acca3f2f80..a3ac038c2f7 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -79,8 +79,8 @@ struct PL061State {
     qemu_irq out[N_GPIOS];
     const unsigned char *id;
     /* Properties, for non-Luminary PL061 */
-    uint32_t pullups;
-    uint32_t pulldowns;
+    uint8_t pullups;
+    uint8_t pulldowns;
 };
 
 static const VMStateDescription vmstate_pl061 = {
@@ -547,14 +547,6 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 {
     PL061State *s = PL061(dev);
 
-    if (s->pullups > 0xff) {
-        error_setg(errp, "pullups property must be between 0 and 0xff");
-        return;
-    }
-    if (s->pulldowns > 0xff) {
-        error_setg(errp, "pulldowns property must be between 0 and 0xff");
-        return;
-    }
     if (s->pullups & s->pulldowns) {
         error_setg(errp, "no bit may be set both in pullups and pulldowns");
         return;
@@ -562,8 +554,8 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 }
 
 static const Property pl061_props[] = {
-    DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
-    DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
+    DEFINE_PROP_UINT8("pullups", PL061State, pullups, 0xff),
+    DEFINE_PROP_UINT8("pulldowns", PL061State, pulldowns, 0x0),
 };
 
 static void pl061_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 1e4365f32c9..f3cff329244 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -326,8 +326,8 @@ static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
 
     pl061_dev = qdev_new("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
-    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
-    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
+    qdev_prop_set_uint8(pl061_dev, "pullups", 0);
+    qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
-- 
2.43.0


