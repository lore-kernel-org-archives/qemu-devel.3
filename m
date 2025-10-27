Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2EFCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNMM-0007vS-Es; Mon, 27 Oct 2025 09:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNLI-0007fM-J3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:33:17 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNLF-0006fc-4Y
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:33:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so3236743f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571972; x=1762176772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzCv5oKALadzAwWmhxHmfCNCg4IWePEaMyvXQSgNH0M=;
 b=Wkp0aZ7wYl3X54jHj7TP5LxQwovD5gqCIfB8opSqsUelVb4rA/11zf/sJdemWB2Joi
 miIZPxnfIdjZ34bjR6nwKsLYPJJ98fqBnHZnaUv5p1t03R9ruxLUbd7SAwJ9KBC2x3tl
 +dPhQF3dL+aLuJvlqvvISZg9pJxMAiujLeGUCf58dEcCsrtu04Brh7ejuDDnBjNgQWuf
 iacl0dJ/Bu2vStDpD7QjIUprDm/viMV98QpVXdSXh4mR4rs0mLJEVI6foNV76n9iXFMm
 8oeKlK9Dh5b9k/1fKcWHbqdDbDERpLebDqtQ8ddLvW9cVvRkI6dV99zFgOqhDeQs5DVs
 ThqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571972; x=1762176772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzCv5oKALadzAwWmhxHmfCNCg4IWePEaMyvXQSgNH0M=;
 b=eT+OlHHcKYftakYdhminLQQh2ajUpjteXGZ66VEGKagwDS2drjZAsyub0E1KYvZ0bv
 NZqIKO3cDviRdzS3Rl+S7rihFEG7Q5Izmco+Z3won4I0h4AMHvl/FX1iPvqZEtOlIFi5
 m/R6UAKsEmslY5MHqi9dJqJu0ep8iZz6Rz6bjk+1KIYLy7A0dJ2yQ4ObeeB+k67+VZmY
 PsmnogEELtb6A00Ar7F8uP36yEud1CMwz78LJCHznPr6Sjh74iwnFUPePxBLyL53UDQk
 38vvsaiZDTntoASMgLL6bUkvaluKWWcnCtQ11BJzK0CnG10/31qKN5/4ybFvpLmOuWA1
 /9yw==
X-Gm-Message-State: AOJu0YwgQWA2QbRE9s75k8yQy/U7yo6fwWo4yiTuEfxzEo+XFH96abeg
 RhLmzUkYq+o+t0eYAqIBxyjDdR+QV1OMEeBByBE07F4BupD82YBD98va1/97KIXZ0vLnhd2H427
 1tNy5KSY=
X-Gm-Gg: ASbGncuv9SspIISMBDhP2dSk41L5xYDGO5pUDrgZlRlU6B/EmB93ks40qIugzgw4YDa
 UaIJ+ImGvJYrI9LN2DlLOLX4NSp1qdq8Y/OqaKe4B/Dcp2WV+9C16mSX+Uj3BueIBQSBpb62L4L
 2LUQ9e30uprBQ+7/k5m4jzNj4c71tnj3s7fE1J2hUoD8WGdZJuwK1sLLr2j7K9+yxKgpyxZHK/w
 WELxwXrpwmjQmwTdovTGI6u/PHJFr/yzkUlmNvMyuQRgaGkj8QJ63w98yfP0yr+JZddhWcjGjHq
 gaGvAcTLpdGKdunqwjrSibPhd5+Ya4cfxodYmp/zuMHZ23z6XRpFumMUxZO3emtumtXH7D0baMQ
 LV7phYX27VQEsfjAIlI7essbPsCosCdJcgG2qRGx0vXWc6vJyObTHH26xnEmPKPUcCL2MCTRXuO
 omexkdXGXCjRZUXji+CO1F7pCHyA1JjneC8Z9DKI9w2MgAdFOk7A==
X-Google-Smtp-Source: AGHT+IFsGResgw3xdMLqOTWeqIyHdZNhmbZeODsdn8WteDOKvsoCklyMsLVtlRVx2nzY+R0ym1w99Q==
X-Received: by 2002:a05:6000:609:b0:429:8d21:5729 with SMTP id
 ffacd0b85a97d-4298d2157cemr9861487f8f.49.1761571971629; 
 Mon, 27 Oct 2025 06:32:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df5c9sm14318157f8f.41.2025.10.27.06.32.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 06:32:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/pci-host/sabre: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 14:30:37 +0100
Message-ID: <20251027133037.70487-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133037.70487-1-philmd@linaro.org>
References: <20251027133037.70487-1-philmd@linaro.org>
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

Avoid duplicating code, re-use the generic generic
pci_host_data_le_ops MemoryRegionOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/sabre.c      | 34 +++-------------------------------
 hw/pci-host/trace-events |  2 --
 2 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index f95e5db583a..cc7229025f6 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -246,28 +246,6 @@ static const MemoryRegionOps sabre_config_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void sabre_pci_config_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned size)
-{
-    SabreState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    trace_sabre_pci_config_write(addr, val);
-    pci_data_write(phb->bus, addr, val, size);
-}
-
-static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
-                                      unsigned size)
-{
-    uint32_t ret;
-    SabreState *s = opaque;
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    ret = pci_data_read(phb->bus, addr, size);
-    trace_sabre_pci_config_read(addr, ret);
-    return ret;
-}
-
 /* The sabre host has an IRQ line for each IRQ line of each slot.  */
 static int pci_sabre_map_irq(PCIDevice *pci_dev, int irq_num)
 {
@@ -361,12 +339,6 @@ static void sabre_reset(DeviceState *d)
     pci_bridge_update_mappings(PCI_BRIDGE(pci_dev));
 }
 
-static const MemoryRegionOps pci_config_ops = {
-    .read = sabre_pci_config_read,
-    .write = sabre_pci_config_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void sabre_realize(DeviceState *dev, Error **errp)
 {
     SabreState *s = SABRE(dev);
@@ -430,12 +402,12 @@ static void sabre_init(Object *obj)
 
     /* sabre_config */
     memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
-                          "sabre-config", 0x10000);
+                          "pci-conf-idx", 0x10000);
     /* at region 0 */
     sysbus_init_mmio(sbd, &s->sabre_config);
 
-    memory_region_init_io(&s->pci_config, OBJECT(s), &pci_config_ops, s,
-                          "sabre-pci-config", 0x1000000);
+    memory_region_init_io(&s->pci_config, OBJECT(s), &pci_host_data_le_ops, s,
+                          "pci-data-idx", 0x1000000);
     /* at region 1 */
     sysbus_init_mmio(sbd, &s->pci_config);
 
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 792ab25729b..20c3cae47a2 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -35,8 +35,6 @@ sabre_set_request(int irq_num) "request irq %d"
 sabre_clear_request(int irq_num) "clear request irq %d"
 sabre_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 sabre_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
-sabre_pci_config_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
-sabre_pci_config_read(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" val 0x%"PRIx64
 sabre_pci_set_irq(int irq_num, int level) "set irq_in %d level %d"
 sabre_pci_set_obio_irq(int irq_num, int level) "set irq %d level %d"
 
-- 
2.51.0


