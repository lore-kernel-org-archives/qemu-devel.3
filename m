Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB47ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQUF-0001Gl-Jk; Mon, 27 Oct 2025 12:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQUC-0001G1-6e
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:54:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQU5-000122-KB
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:54:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso14417835e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761584051; x=1762188851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5AYcZWKjl+z3UUAUBIKeSJtay1TyUPTtzgR0XhDmJM=;
 b=pPG1R8wBXsi97G4OOt51dbyRP7bdV5cWURkY2YhMooPMLymwG5gRaM/iVlTcaYWM3O
 HTFi5U8aq6/tjx8cuRa5b9yO2dZhJhF0bo+c2K62nyNPa37PC2Juzs7HVtMX48GnER/7
 RXlQr+lwaUyn5CfQBxJmMMmzklh9PShjn+rPKP7shK/OBMhznvNowmjKyKdsd7W9DCjW
 7xtH6FeZO2EZTbWyL8A9NldmN7e5+RF4B29xLU+cVVb7Wfy6qdM0Vk1uAvR68fTh2ZA6
 mtto7v1ATDevnk04/RhoQkzfJkJrMKTaUbPjh/FUgcNYk8xKMN45BVp3ubSrUrBghSi8
 6fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584051; x=1762188851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5AYcZWKjl+z3UUAUBIKeSJtay1TyUPTtzgR0XhDmJM=;
 b=aF4fGRT9hlph9IlTHZGc5EiyGMa+MPVQHjpc9cKkFffs5Z6AUelTGmfbvtaO3Bxaj1
 BzvzwYT0q6qJRA7fNuWyJLztU6agwrnZo3tug7eRe0ZWJKq2YWJoc+Jt2obKcaxGj0jb
 jtex677R1MFmzZyFyVzQrNEu8woefqZIHSRfLrGJSP0N42CEsKmYGf8JVx/nQZHmIumN
 kUGi+0t6pEjEs3Z/MoIMMWtYnQKDp/9CchgDBFSde9r1fcKs96dDOjFlOsuANEHpm5sO
 XYo879J38zzUBZVxkqBM26tjf8PK+CcLqZz5RyB72jeLjUSi4bG0ZOJP9vmHMkFw8/gu
 9yGA==
X-Gm-Message-State: AOJu0YxE5HqCTufdZPRknMuPzc41eR/XY2e8pIstavlfxfCZ6NlRj5Yg
 snF21sO9G0qjzFbO/YjtF/xj46p2hRIFu09I7GztwKayKvaObfl3vYK9DhIlYr5OWzSfU15Shub
 2XWx8ROU=
X-Gm-Gg: ASbGnct5TtrBrbr3QpfEaxU6oceHnqzh1ESJlJQXLJZl4/p/ibKQ0LxI7axIDBvXRlV
 /rLjlpVitB2vMPlaSQeSa1dbhSN8tg0Xr6fbMWWvGnM3iXxPRKPFCve1AJVkZOdcdnFA1NTNsXZ
 T79YFzB73lU5l1C+hjP39PuBJheERChV+RrllPncFgrM19IErbAU81spzFleX9xgpt6unUFSnwy
 lkqvW5ckCqNA6EGCWnKnlT9zzMJUzC+UHH5fk8e/QEsiHTLI3TdTJvwOf3eOyRCt+mjoVPu4j03
 ShqpFjCS3VEpUmVtiPSTRoKC+TbZHGPlgbDcQRN5OKta1A4IJkAGBrv1GbnA5wjUyEV39IMMl1q
 xG7rdI3rv0upSVw0zi0dLxjFNDT8ZIkV2nX5/dGLNFmh2nptUpvJzsL/E5BhuWPs3trcUkLJhYB
 gVKFhV5Vfaw07qkaIy9rKF0q19cMs6z+Zccs+eNy+2Dkp6nowzUXYa1NdbDMlmmwvdDiA6Dkk=
X-Google-Smtp-Source: AGHT+IHAQAOoZb1W2wHQvvRjdxUwWsLVNI/OC/sQc0j3frVvzML3t+yDeweyFZuUO5ATg6KrHbf6dg==
X-Received: by 2002:a05:600c:1e28:b0:46f:aa5b:feb2 with SMTP id
 5b1f17b1804b1-47717e67e60mr2553775e9.30.1761584050716; 
 Mon, 27 Oct 2025 09:54:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd47794asm164074245e9.1.2025.10.27.09.54.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:54:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] hw/pci-host/astro: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 17:52:58 +0100
Message-ID: <20251027165304.98296-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027165304.98296-1-philmd@linaro.org>
References: <20251027165304.98296-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Avoid duplicating code, clear the "config-reg-check-high-bit"
property in .instance_init() in order to re-use the generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c      | 35 ++++++++---------------------------
 hw/pci-host/trace-events |  2 --
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 0bd66ab3de3..72e625c2508 100644
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
+                          &pci_host_data_le_ops, phb,
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


