Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A80E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Iq-0001LD-8Q; Sun, 12 Jan 2025 17:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IV-0000pM-HK
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:08 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IT-0006VH-V2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1955543f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720344; x=1737325144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6K7t3TbXwHAqgGaxmfHNMiMSManKTTs7a5XM/qzWt5U=;
 b=Y7iYF4cfsRFZVsgrPYLWEhLtQMjFJz7n59QaHSADyN8B2HhkUsj3qabkkpcqvt5Beq
 W12O4vZv3Nh/LFIZ6rwFhSXgJ31gAYA/Yv5dcHxuGxivwC7rzrMxZkNGRPF9xDmmvJN+
 paIGnNVOfh/LCx2tZuhgpF2j6ivtn3HZhxdspCJhxI7wS6bM8QklJhPzB3H4GwiiRAy7
 qKSZ8paKMBnNGZ3zabrVltvrkBIp93K5l4W8NQD+qfs1c4YiidtnS59hEH3uJhplIYcd
 FOeI6Omlm1NYe6EUxgZwBYSDDofM6QNQxoYaW7fTVhooQpy/xHSQqfvIkAA3mjZvWase
 9DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720344; x=1737325144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6K7t3TbXwHAqgGaxmfHNMiMSManKTTs7a5XM/qzWt5U=;
 b=AUf1tGlNsM5nnkLrf0cL2nhneuY3soz1a7SSJzk1RqEQ7J82LU+Eu6PvXiJEuwiusk
 nnGpdSNjStob1t+ap+rriPmrTcyZPWeB3kFeYE/7Dxzz685lXbX+HLVvSPQoU4onJoEb
 Ab45cdBWPpGVMjRdjPqLmPzX2wd144xbmXps21avYAbm5m42u8fZAoFdWGLSHDX+iD8g
 OrxmB5poZK1/tlH6xD4fpOfA+D5QyEwacazLpS+g7B5MP1V4g8wgRXFo6Vy78toli4Sg
 4TKjQ+lnvfcV+fw9oO44NOzLc/iK9M7FVde9IwxZUrDa37omV9YSzK2BA0TW6tFwoaZj
 llkg==
X-Gm-Message-State: AOJu0Yy/ERGUvtR4MI59mrVQv3Lx15RaRoHfEmkTUdfjHaEFtKAZgyiF
 n44Aow5Ozb1cONT8i2+EXoOvzr34rKa/jlqRW3NHGrc1wFflAB/mpvQSZt+c1ldoC7TT+4gljPL
 ccn4=
X-Gm-Gg: ASbGncsxMU4fgPL/+pnUlqMKVrKjLPGqT58CHVxTQ0TKPC09Y6Q7XOXY1AEl5WIUr6g
 4v7/rXfD6vCvpTRvF3yToPilj14RgX5WB6n4pDMWak5iesIfjl5AjCP7VqaMMfH4p9qfMJzynzk
 iWoYCwBNRY+1tiqXIm3WMc20UVCC2e7F+c4AejWwzKR2V3RsfARJxQ22UbgO8qyUXaspwF/Trhs
 ehdzo0pinuWjrIkqnpSR5Gcbhhedw1rtWy77NcX0R0x2Zc3MEJtINXp+SqFKYhry2R1ye4dKHZO
 zG5MM8LxiOc7oTON7veWtD3cKHFS2hA=
X-Google-Smtp-Source: AGHT+IE7UdjiGadiGRCMcxOV4LqJ7V9c9KMl/YK+boRt9X2T46K88TDH8+Ncp2snBCjEKg7Fs5TjcQ==
X-Received: by 2002:a05:6000:1f81:b0:386:1cd3:8a03 with SMTP id
 ffacd0b85a97d-38a872ec38fmr14919936f8f.32.1736720344078; 
 Sun, 12 Jan 2025 14:19:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383882sm10664710f8f.34.2025.01.12.14.19.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 19/49] hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
Date: Sun, 12 Jan 2025 23:16:55 +0100
Message-ID: <20250112221726.30206-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Having all its address range mapped by subregions,
s->mmio MemoryRegion effectively became a container.
Rename it as 'container' for clarity.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241112181044.92193-21-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 758226a65dd..a7f6d1b368c 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -85,7 +85,7 @@ struct XlnxXpsEthLite
 {
     SysBusDevice parent_obj;
 
-    MemoryRegion mmio;
+    MemoryRegion container;
     qemu_irq irq;
     NICState *nic;
     NICConf conf;
@@ -300,7 +300,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
-    memory_region_init(&s->mmio, OBJECT(dev),
+    memory_region_init(&s->container, OBJECT(dev),
                        "xlnx.xps-ethernetlite", 0x2000);
 
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
@@ -308,31 +308,31 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
     qdev_prop_set_uint64(DEVICE(&s->mdio), "size", 4 * 4);
     sysbus_realize(SYS_BUS_DEVICE(&s->mdio), &error_fatal);
-    memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
+    memory_region_add_subregion(&s->container, A_MDIO_BASE,
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
         memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
                                i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
                                BUFSZ_MAX, &error_abort);
-        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
+        memory_region_add_subregion(&s->container, 0x0800 * i, &s->port[i].txbuf);
         memory_region_init_io(&s->port[i].txio, OBJECT(dev),
                               &eth_porttx_ops, s,
                               i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
                               4 * TX_MAX);
-        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
+        memory_region_add_subregion(&s->container, i ? A_TX_BASE1 : A_TX_BASE0,
                                     &s->port[i].txio);
 
         memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
                                i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
                                BUFSZ_MAX, &error_abort);
-        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
+        memory_region_add_subregion(&s->container, 0x1000 + 0x0800 * i,
                                     &s->port[i].rxbuf);
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
                               4 * RX_MAX);
-        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
+        memory_region_add_subregion(&s->container, i ? A_RX_BASE1 : A_RX_BASE0,
                                     &s->port[i].rxio);
     }
 
@@ -348,7 +348,7 @@ static void xilinx_ethlite_init(Object *obj)
     XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->container);
 }
 
 static const Property xilinx_ethlite_properties[] = {
-- 
2.47.1


