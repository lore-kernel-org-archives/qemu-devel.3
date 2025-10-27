Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFACACCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNLD-0007dX-4s; Mon, 27 Oct 2025 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNKo-0007V1-G9
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:32:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDNKi-0006eI-TE
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:32:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-421851bca51so4333711f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761571938; x=1762176738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDF8qFFV7cgxV1j/8RoZUJ+MPOSC+u4/FewxtfgCGSs=;
 b=gY6ax86hAz+9ZIBYLlxIs9MjPQsTcAc5KhGIpt5dwcjvy8q7pTNkNjjC0NpmtxonN4
 OwzmYP/2oIa/FlX7L16MtFQih8O7f/iuXqkcoL1Xlp7iu7zxbqJt3tcgzbvQdhR/hZKb
 dX2D9dNb5theqjyc3eCl2wG0P3E80kxdwn91ORXsqIBX6It+cEWsN+wrQ2VrciAAYVoi
 1zuRiroWmGI5jzoLvVj3PM8xwgctDhKcfOwHETDEnJ2hF+EK9q6jJUfnJBigdsiIO58C
 g53pT5EEdAEVcvIPbFc4XSHSA1SED6hrA80ixV1yMoTfPI4+GiF9dRKfStBlU7FGo5Z1
 xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761571938; x=1762176738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDF8qFFV7cgxV1j/8RoZUJ+MPOSC+u4/FewxtfgCGSs=;
 b=H+Rn2p9kruRIuB6LzueXPa5suoRElzD654oWgyFgcPDndSLpMxyiTlhPo39kb/OmPs
 h8nuFfkZn8zsRm1dbfTl5KzZNU/iBoHZlKV/l4COoIvSZrCLPjiIi156bc+Ss8RMkleL
 kmHQmgXugMhTvUENOFuerbuwCEQ2d0R9HipE/OtfFy6p20VOkSq82zj1JvzfBGhjDi9z
 DlbwX3AmyIVPG/UxqDhyNrLbMIbXOGR8kFN0NFXMZsRvFI+Kfd4FIGXUpiS95hpTJvNo
 4vddXh0MmApqEuQ3aL859C+RhQN183ZUdvnD7L2afyloP5K9ilMKaFeTN9Sb1JuShb40
 8jQg==
X-Gm-Message-State: AOJu0YxAYpgBY/79JjkhjMzuuCqbvcE/dM46wDZu+zk+NEhZD2PCSeXR
 N2ThSPUrw6Gt4qOVUz3Bk/R4nqslnYmqyiPNgncjrhoU+PD/eMG+cUTvoOL3dpNuQXa0+MssO/C
 PuoL40uE=
X-Gm-Gg: ASbGncsZqqsGR/5oKcXRtcbaf3kvwDkTL8ZPDr46dXLg9StkQupWS+Kdqr0oCcxdLt0
 cXthyTw0o0vsLSAxP2XoYDOmkO4WFWIBUbtER/VQxdiE/Nf+GYdedofpNxlL/tWaDLASxKAcByJ
 X4uUMyMsQzLkDQdYobJOQX42Bxi7Ytz7YhigDxAVmiCxxThwKIaJQQ6Umla8toSJSdQCGcQAY/h
 +75uQX8wKCoHr+dwrLFEfO1uu+5ETsBMPjcvMg2STwsHUDRxOOJm0aHE+ZhEHduughMFhnXEY4I
 zb3KxU3sKSl70Ggjgs8C3Tsrka4ncH8fpxBmKpptEUvECOPFjb4fsa9jfXeMibAX4c+foV37ohA
 zYKnflLPhBQiWgP12EjDxAudNi3GG13XHu60iennQIT/uWdO/8tGebPKLMfhPW/XwB2LEETKt+l
 na+EKcOqJAiQFUQ7nYAxvRdLTEvascCdLk1OGHtXw04ziOiz8yGg==
X-Google-Smtp-Source: AGHT+IF0Ak0gqYM/av7anYcNk/2TKImX8icXUte9cj95iJUoGGwUBWsK201y/hFvjCkNtWZbYtMnRQ==
X-Received: by 2002:a5d:5d02:0:b0:425:7590:6a1f with SMTP id
 ffacd0b85a97d-42990755c5emr9537672f8f.49.1761571938003; 
 Mon, 27 Oct 2025 06:32:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b6fsm14490976f8f.1.2025.10.27.06.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 06:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] hw/pci-host/dino: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 14:30:36 +0100
Message-ID: <20251027133037.70487-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133037.70487-1-philmd@linaro.org>
References: <20251027133037.70487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
 hw/pci-host/dino.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 924053499c1..e317167dbfa 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -302,27 +302,6 @@ static const VMStateDescription vmstate_dino = {
     }
 };
 
-/* Unlike pci_config_data_le_ops, no check of high bit set in config_reg.  */
-
-static uint64_t dino_config_data_read(void *opaque, hwaddr addr, unsigned len)
-{
-    PCIHostState *s = opaque;
-    return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
-}
-
-static void dino_config_data_write(void *opaque, hwaddr addr,
-                                   uint64_t val, unsigned len)
-{
-    PCIHostState *s = opaque;
-    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
-}
-
-static const MemoryRegionOps dino_config_data_ops = {
-    .read = dino_config_data_read,
-    .write = dino_config_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static uint64_t dino_config_addr_read(void *opaque, hwaddr addr, unsigned len)
 {
     DinoState *s = opaque;
@@ -410,6 +389,12 @@ static void dino_pcihost_reset(DeviceState *dev)
     s->toc_addr = 0xFFFA0030; /* IO_COMMAND of CPU */
 }
 
+static void dino_pcihost_instance_init(Object *obj)
+{
+    object_property_set_bool(obj, "config-reg-check-high-bit", false,
+                             &error_fatal);
+}
+
 static void dino_pcihost_realize(DeviceState *dev, Error **errp)
 {
     DinoState *s = DINO_PCI_HOST_BRIDGE(dev);
@@ -424,7 +409,7 @@ static void dino_pcihost_realize(DeviceState *dev, Error **errp)
                           &dino_config_addr_ops, DEVICE(s),
                           "pci-conf-idx", 4);
     memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          &dino_config_data_ops, DEVICE(s),
+                          &pci_host_data_le_ops, DEVICE(s),
                           "pci-conf-data", 4);
     memory_region_add_subregion(&s->this_mem, DINO_PCI_CONFIG_ADDR,
                                 &phb->conf_mem);
@@ -505,6 +490,7 @@ static const TypeInfo dino_pcihost_info = {
     .name          = TYPE_DINO_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(DinoState),
+    .instance_init = dino_pcihost_instance_init,
     .class_init    = dino_pcihost_class_init,
 };
 
-- 
2.51.0


