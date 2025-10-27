Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335BBCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNKM-00073D-S7; Mon, 27 Oct 2025 09:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNKJ-000711-Pc
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:32:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNKA-0006bb-Ba
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:31:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-474975af41dso32603075e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571904; x=1762176704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAKUljJ3Ki5HyrVPMR5JskJBV5m6bECGQrsJLrYoqxs=;
 b=Q7PQ87TbDCsAkMw3hPuu+cHF8Cabrasgl4eb8lO3LX7YNDH74WfFE1GcptEAQo+bDq
 MDd1e3PA6stAsap7+0AD8+gRJ8DNdQNIIUZTZHoiNY6A1DsqYygu1hlFhHmNau0lgv3F
 aaKHzWGRVeWJ2V3IOiuak/3LxdjCmFIpI8mjXRXvXdPf5baJGhOG02ATPu1PQvDXRMAS
 WLLSBiyewWeA0HmCme8y1meQ4KUyPHnD55nDUGbObYKDRE46epbLnIqNyPWJWOZnz5uK
 AyKmp91QXMMc/WWrh9TJTSNUI0+iKlo2ifLkbMVuOv/Mlw9M0gl28UiQLqrrksGwD8f3
 k+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571904; x=1762176704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZAKUljJ3Ki5HyrVPMR5JskJBV5m6bECGQrsJLrYoqxs=;
 b=Akmd/Pz+JZY4OUxgSj1S8WjyN2RlSIQQD7WxCCozZew97649rjAo+5ULYuUFzxFMWN
 hO75eILq29iQ+mITZBLxt8h/6knmgzC3R2yRp8vEHGoHXyUShb9WW/9GYDVXHu4ZO0tW
 MZrTzgXjWrFEpkM8Wfx+BKFdOtHgejnFczzM2kGo7rfpU6JI5CBHf98oYW4xbyIkZI6+
 n+EWDNzAjn0k6WhfHbaeknk1jUd+xvM0H97bSKVRKJgkYfk9pbWytws1hy592gWQcwf5
 CLQ9bpi9W1B+FNBFYrPzeOE6tLlpnxpRe7aRBsWaJY9+y9nGPcPmzGD3uvFTluG7AOVe
 ldjg==
X-Gm-Message-State: AOJu0Yx4o7BVdtQyh+rbb/XhiuPFJdPzwnsFZDEcde6PFYV3dozaH5Od
 TJQs4djWMsxUrZzsSNGz0ua7Or8TDo8Nity2wI21tVa5U267cK4UoQuQ6exQCQJqHwj3p4TfUOL
 1m1bISaA=
X-Gm-Gg: ASbGncsNkLBCRTP3M4RE0KES80q7j1VXv2CS40t/KCGHhHskjlK4wT2nkYgekIbsOqZ
 knOiFOTJs9pIYyG0LUHKIR5Zd9vU1LTfII820yr+aknj5P4vJOAsRBaiaSk/Lw/DvfSbwjgHogD
 yZfirLracFzbyiq81FAMU3VUgMC03SjfWMjH87MHEcgzA5LDJAla7wVdjeHh950nbTRhbxCV+eq
 b9yKhvfxob4MB7zC3KWncQOwDJ3Tdja1p5ITwCVUoBbP5S2I9jx56QHn34J/bGivRp6+uGYOVSa
 uVaWUYIaU0gbnOj7r+8tApaF18fl6U3GVrQzhq2c/bJ4tDBq3anF7FCu5SjWIwTkmKo4j6wDnSC
 6RU1Cs4HAYescDq4XyRoR7rwHWIuuF+CJWAfzL6u2CBNN+nh83USIKZr8kUA2NRDBgkOeSGe4rv
 aM42hUJ8GnYswDKi5n6YkuToBDfpEWztIxPGVekK0URBzQfHUejQ==
X-Google-Smtp-Source: AGHT+IH+AxwryH2yXGkM56H7va3vscQIjjlLVT+EkxDXH79YWhrVMGV89HyBaMGy4Dwzq2IJLQ6+3g==
X-Received: by 2002:a05:600d:438b:b0:475:dbb5:23a2 with SMTP id
 5b1f17b1804b1-475dbb5250amr34047695e9.16.1761571903997; 
 Mon, 27 Oct 2025 06:31:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df62dsm15473844f8f.45.2025.10.27.06.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 06:31:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/pci-host/astro: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 14:30:35 +0100
Message-ID: <20251027133037.70487-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133037.70487-1-philmd@linaro.org>
References: <20251027133037.70487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Avoid duplicating code, clear the "config-reg-check-high-bit"
property in .instance_init() in order to re-use the generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c      | 35 ++++++++---------------------------
 hw/pci-host/trace-events |  2 --
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 0bd66ab3de3..110070486d7 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -230,32 +230,6 @@ static const MemoryRegionOps elroy_chip_ops = {
 };
 
 
-/* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
-
-static uint64_t elroy_config_data_read(void *opaque, hwaddr addr, unsigned len)
-{
-    uint64_t val;
-
-    PCIHostState *s = opaque;
-    val = pci_data_read(s->bus, s->config_reg | (addr & 3), len);
-    trace_elroy_pci_config_data_read(s->config_reg | (addr & 3), len, val);
-    return val;
-}
-
-static void elroy_config_data_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned len)
-{
-    PCIHostState *s = opaque;
-    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
-    trace_elroy_pci_config_data_write(s->config_reg | (addr & 3), len, val);
-}
-
-static const MemoryRegionOps elroy_config_data_ops = {
-    .read = elroy_config_data_read,
-    .write = elroy_config_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static uint64_t elroy_config_addr_read(void *opaque, hwaddr addr, unsigned len)
 {
     ElroyState *s = opaque;
@@ -424,6 +398,12 @@ static void elroy_reset(DeviceState *dev)
     }
 }
 
+static void elroy_pcihost_instance_init(Object *obj)
+{
+    object_property_set_bool(obj, "config-reg-check-high-bit", false,
+                             &error_fatal);
+}
+
 static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
 {
     ElroyState *s = ELROY_PCI_HOST_BRIDGE(dev);
@@ -440,7 +420,7 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
                           &elroy_config_addr_ops, dev,
                           "pci-conf-idx", 8);
     memory_region_init_io(&phb->data_mem, obj,
-                          &elroy_config_data_ops, dev,
+                          &pci_host_data_le_ops, dev,
                           "pci-conf-data", 8);
     memory_region_add_subregion(&s->this_mem, 0x40,
                                 &phb->conf_mem);
@@ -497,6 +477,7 @@ static const TypeInfo elroy_pcihost_info = {
     .name          = TYPE_ELROY_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(ElroyState),
+    .instance_init = elroy_pcihost_instance_init,
     .class_init    = elroy_pcihost_class_init,
 };
 
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index a6fd88c2c46..792ab25729b 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -76,7 +76,5 @@ astro_chip_read(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d
 astro_chip_write(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
 elroy_read(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
 elroy_write(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
-elroy_pci_config_data_read(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
-elroy_pci_config_data_write(uint64_t addr, int size, uint64_t val) "addr 0x%"PRIx64" size %d val 0x%"PRIx64
 iosapic_reg_write(uint64_t reg_select, int size, uint64_t val) "reg_select 0x%"PRIx64" size %d val 0x%"PRIx64
 iosapic_reg_read(uint64_t reg_select, int size, uint64_t val) "reg_select 0x%"PRIx64" size %d val 0x%"PRIx64
-- 
2.51.0


