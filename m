Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE4CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q6-0005gp-3B; Tue, 07 Oct 2025 10:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q3-0005fx-C7
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pp-00028s-GI
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso18535425e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846300; x=1760451100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9O/hfrpW4QDwWWLEbTcsULJfyn/JGHUsRKFKhzij6oc=;
 b=f3zZAKbjSQnd/eAE+yWLwRT60K0tXNyQBey/6dZIaSKWOnCsA4YJcwqS3RGpb7Ukhd
 a7TX9SAaIRKI3kdcE1gJb8rv4JjEIdM9sN4KZnHkrzW62x6mcSaa11yCIdfnZFiMWIZw
 mLb6pWgoYVDVmRCHhEFzPyaOig4mmokT7LzdHkNAp4yLJwp1VdusBKH0CrwlaNAZ5+uj
 OsiTjHbjV2tQqXPqclWg4ml4dvRmfGnD4CQZQUyCvFesTZu22s6G1UPVZSi4WetmZcpm
 5Zv0Dzvy0rCNHYEMNQu+j6AUzPdpHtmXqRJNp34yEs2JUVywY6z5PaM+4iZmp412nMSy
 JtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846300; x=1760451100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9O/hfrpW4QDwWWLEbTcsULJfyn/JGHUsRKFKhzij6oc=;
 b=FKlplfFUhQFSMuC3RHu188VSm0UvKRyhpJlwNqsdzLFbMk/rZKEnep7ek87AOKdE81
 kNkBWAXVeOp1YYdKTsmXWI6nkEGUhVLoChU3oylVv12jwNTQhcZPgwPMl1T45VHstaju
 urZ4e0ZysUj5Oac+SvmDsBdsqIOBXRETIqBsC1n6sEVxzX/PHRAQd40rqNouIQQQsuB6
 eH00PM91jWYdblC54rs3H3XiU2R0/ilggBXVmNy2LufKSpxouRztWsmCVo2jTJpc0z/k
 xIh5M2Ce8wn8lKueAVWIeHYirsmEvBBTHNiXJFkVnQBoiHPgxP0cpgsZkh8ThGzEbX9j
 Md+A==
X-Gm-Message-State: AOJu0YzFGK6411PzkZYqg476OEMVHt+kRojOuv4ZwhCH06trmc1jECbY
 vYof809gu1RwJN/04sxcQ0d3fmeNA+2NwSsWuGm2Wisw0WPw7PmYxwlfXiNyjiJOnMvc9NzD8ev
 TpRQA
X-Gm-Gg: ASbGnctfw1WMZkbQdFwZqERgnFMpYqJnLkTP9fxH6FFeQkYwCFQj+6z9UeZDqFEB+ez
 /THO2Gwq4cDs93sR5rF+4heGQ4OAgnGwXKxNilM8hbuoN6K9hIwMqylowPQaLoGJXK1mk/zEbhI
 YGfaetnzGwlQmOf1AlRso2vbGpSe/XY8ea/bGT52menVwRxG3PGooGQC+JXU4Xh4l4Dj7QEXjX4
 cwF9ZulRdydXYyDvyRvMQog0ki37jYKPFH56ZlKdgz+i/WYPGbLj/0S7EuaoI8XZo8jDY2S35QR
 +zHagTUPOUu4tx9puesMLX4lqr1Bdwv/xig9gwRqwh3ZAs353Z/WJaAIZrGP/Mjw6UdYHvnAjBB
 K4uYDPsV7DJECcn4XjZv2fUI26pNkq5As/RsvqBfD6dkcaUmfW5T78TJP
X-Google-Smtp-Source: AGHT+IGHEQ8TCf3Xm7HVwDxMnXvQGVvghYzznZjpggAnwnO43HlpUw/7AO1yQ9koJ0SZSkyDPPAd5w==
X-Received: by 2002:a05:600c:4f93:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46e7110f0famr153759155e9.16.1759846299827; 
 Tue, 07 Oct 2025 07:11:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/62] hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
Date: Tue,  7 Oct 2025 15:10:33 +0100
Message-ID: <20251007141123.3239867-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Luc Michel <luc.michel@amd.com>

Improve the IRQ index in the VersalMap structure to turn it into a
descriptor:
   - the lower 16 bits still represent the IRQ index
   - bit 18 is used to indicate a shared IRQ connected to a OR gate
   - bits 19 to 22 indicate the index on the OR gate.

This allows to share an IRQ among multiple devices. An OR gate is
created to connect the devices to the actual IRQ pin.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-13-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 63 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 964250bf151..d3a084a0639 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -43,6 +43,17 @@
 #define VERSAL_NUM_PMC_APB_IRQS 18
 #define NUM_OSPI_IRQ_LINES 3
 
+/*
+ * IRQ descriptor to catch the following cases:
+ *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
+ */
+FIELD(VERSAL_IRQ, IRQ, 0, 16)
+FIELD(VERSAL_IRQ, ORED, 18, 1)
+FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
+
+#define OR_IRQ(irq, or_idx) \
+    (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
+
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
@@ -174,9 +185,53 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
     return versal_get_child(s, n);
 }
 
+/*
+ * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
+ * used to return the corresponding or gate input IRQ. The or gate is created if
+ * not already existant.
+ *
+ * Or gates are placed under the /soc/irq-or-gates QOM container.
+ */
+static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
+                                          qemu_irq target_irq)
+{
+    Object *container = versal_get_child(s, "irq-or-gates");
+    DeviceState *dev;
+    g_autofree char *name;
+    int idx, or_idx;
+
+    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
+    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
+
+    name = g_strdup_printf("irq[%d]", idx);
+    dev = DEVICE(object_resolve_path_at(container, name));
+
+    if (dev == NULL) {
+        dev = qdev_new(TYPE_OR_IRQ);
+        object_property_add_child(container, name, OBJECT(dev));
+        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
+        qdev_realize_and_unref(dev, NULL, &error_abort);
+        qdev_connect_gpio_out(dev, 0, target_irq);
+    }
+
+    return qdev_get_gpio_in(dev, or_idx);
+}
+
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
-    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
+    qemu_irq irq;
+    bool ored;
+
+    ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic),
+                           FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ));
+
+    if (ored) {
+        irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
+    }
+
+    return irq;
 }
 
 static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
@@ -1217,6 +1272,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
@@ -1227,6 +1283,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
+
+    container = object_new(TYPE_CONTAINER);
+    object_property_add_child(OBJECT(s), "irq-or-gates", container);
+    object_unref(container);
+
     versal_create_rpu_cpus(s);
 
     for (i = 0; i < map->num_uart; i++) {
-- 
2.43.0


