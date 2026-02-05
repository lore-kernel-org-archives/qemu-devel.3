Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A5ECD9A0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vo-0007AN-TB; Thu, 05 Feb 2026 14:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vg-0006zZ-1r
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Ve-0003CR-DL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so14048625e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321565; x=1770926365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbSmGmcLyJAYSLJVq9qt6emaKelHhhG3medBeM4cN70=;
 b=BXVyWMNashwOht3f4ANa1ekKUGLvenijrutAMBuH5gaUi+qIXXuooa+Auq/1gNLrq6
 dpWMRkSqKM5VmcdPCeX4AqtWgqS+WAPAuZavLmxnRLDQim2ShgZ23YPBA97Ktd38KbqV
 2wHWUSjn0h6+nAobsldINTESVBp/i70tDxHnkck5AwtJOweqyQVsVa50ZADrHMK4uU6O
 mIEkKRb35YzokXFqTPBmJw8Muf6UKLvDpQikbAsvwVSCQ9iWqh3hDb3B4KZKt8zYO28L
 etNBFNE5VjJ0UxUwy6kLwf873MD4ihEDqduMipYTE+kdtshmTuJfsU8QZABg2iQ3mTHG
 6rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321565; x=1770926365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbSmGmcLyJAYSLJVq9qt6emaKelHhhG3medBeM4cN70=;
 b=mOp6tsnSIAjGEFtzHYN2+tQwCLsGEEcm8qAoiDMjzF76FlRZsKhmGLzXez5jLi20z9
 l4chThcUZWunkRziyJHXdGvBKgSAb42FG9No9F85bil+6XMySJ/wsM0ZBX+z+pIC5oad
 04F8MLnFJ1sfab1KXE2OIe8RQgw6mPv+02fzUiPQtE2vSs/waTrR6+3FgIefvHxIBssv
 YyczBIKKoUqjCjqdmNMBHzmGstgAgW3EIXCr18XCsf8jjhNu0Am99MAtfO7Fp/KA5K+v
 /k89z8b7CsWzy+KbCCg88ak6af0KQnoRXopipxijXKPobOCrXK/v3kb7GU32s3bRFPes
 B8ZQ==
X-Gm-Message-State: AOJu0YzQiL4EVUzbYb+3+s92wUW6dr+/f1uzRSSoGCx0V5lNWL6W+6il
 G/s+e6IebwyRlmmHDuBHohkfEbaHIYz8R+ayxTc4gAg7YNUlfdlke1C09pGK2b0YaI4=
X-Gm-Gg: AZuq6aLMejdJevaI4Rlg6CNqBpkEW+jyQsTWF+p99UjJmghOrpQpAdjOQxWxpKu/8kM
 uug/sQoZHkXmAdhXbKlDvjjHZMZuyXUwB3w1L4dKmWobqvOsoBxnJszVc10rxwW+l1EGfWbbGND
 ArLjZ19T/Ge/amws1Wk/kozr33UwWUkWqEcDmKtQmGlThlvWAkFy15YbjjdsdcnTOm0VBSf2vMs
 9nnKdTVx9C5TbniBMfia6jsxoDdTYdcy3RZpvowsHVtAFYxCUp/95taMP4qBj6z03dKZY5He9Bh
 akUlpTfBF1jxvxub5svBF0RYeHtts2Cg7MzaiNxsWprW8mbIrMrSXLIoiyzeqJKMHI03AVJisqg
 5ZZZFfGBVds0EKTg+1C7C/2MehOwNueG8zNfiPUDTwtFNzvjT5pypTUP+YOelmifN20NJmeK2Rq
 VVaKlnmSyxzWNDlBP0mk4=
X-Received: by 2002:a05:6000:2681:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4362938f3f4mr724935f8f.62.1770321564434; 
 Thu, 05 Feb 2026 11:59:24 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:23 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Subject: [PATCH 27/29] hw/core: Support IOMMU translation for Remote Port
 memory slave
Date: Thu,  5 Feb 2026 20:58:22 +0100
Message-ID: <20260205195824.2610192-28-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

Update the Remote Port memory slave to support transactions targeting
an AddressSpace managed by an IOMMU.

This patch:
- Adds 'iommu-id' and 'rp-chan0' properties to configure the connection.
- Implements logic to retrieve the specific AddressSpace for a
  given stream ID from the default system bus IOMMU registry.

This enables external simulators (connected via Remote Port) to
perform DMA operations that are correctly translated by the
guest's IOMMU/SMMU logic.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-slave.c         | 35 +++++++++++++++++++++-
 include/hw/core/remote-port-memory-slave.h |  3 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/core/remote-port-memory-slave.c b/hw/core/remote-port-memory-slave.c
index bb23325469..0419e75bfa 100644
--- a/hw/core/remote-port-memory-slave.c
+++ b/hw/core/remote-port-memory-slave.c
@@ -182,12 +182,38 @@ static void rp_cmd_rw(RemotePortMemorySlave *s, struct rp_pkt *pkt,
     rp_write(s->rp, (void *)s->rsp.pkt, enclen);
 }
 
+static AddressSpace *bus_iommu_address_space(BusState *iommu_bus,
+                                             uint32_t iommu_id, uint16_t devid)
+{
+    if (iommu_bus && iommu_bus->iommu[iommu_id].iommu_ops) {
+        return iommu_bus->iommu[iommu_id].iommu_ops->get_address_space(
+            iommu_bus, iommu_bus->iommu[iommu_id].iommu_opaque, devid);
+    }
+    return &address_space_memory;
+}
+
+static void rp_memory_slave_init_done(Notifier *notifier, void *data)
+{
+    RemotePortMemorySlave *s = container_of(notifier, RemotePortMemorySlave,
+                                            machine_done);
+    AddressSpace *as;
+
+    if (s->channel_id) {
+        as = bus_iommu_address_space(sysbus_get_default(), s->iommu_id,
+                                     s->rp_stream_id);
+        address_space_init(&s->as, as->root, "dma");
+    } else {
+        address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "dma");
+    }
+}
+
 static void rp_memory_slave_realize(DeviceState *dev, Error **errp)
 {
     RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
 
     s->peer = rp_get_peer(s->rp);
-    address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "dma");
+    s->machine_done.notify = rp_memory_slave_init_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
 static void rp_memory_slave_write(RemotePortDevice *s, struct rp_pkt *pkt)
@@ -232,10 +258,17 @@ static void rp_memory_slave_unrealize(DeviceState *dev)
     address_space_destroy(&s->as);
 }
 
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("iommu-id", RemotePortMemorySlave, iommu_id, 0),
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemorySlave, channel_id, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void rp_memory_slave_class_init(ObjectClass *oc, const void *data)
 {
     RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
 
     rpdc->ops[RP_CMD_write] = rp_memory_slave_write;
     rpdc->ops[RP_CMD_read] = rp_memory_slave_read;
diff --git a/include/hw/core/remote-port-memory-slave.h b/include/hw/core/remote-port-memory-slave.h
index d88e806ed6..3161073a3f 100644
--- a/include/hw/core/remote-port-memory-slave.h
+++ b/include/hw/core/remote-port-memory-slave.h
@@ -23,6 +23,7 @@ typedef struct RemotePortMemorySlave {
     /* private */
     SysBusDevice parent;
     /* public */
+    uint32_t channel_id;
     struct RemotePort *rp;
     struct rp_peer_state *peer;
     MemoryRegion *mr;
@@ -30,5 +31,7 @@ typedef struct RemotePortMemorySlave {
     MemTxAttrs attr;
     RemotePortDynPkt rsp;
     RemotePortATSCache *ats_cache;
+    Notifier machine_done;
+    uint32_t iommu_id;
 } RemotePortMemorySlave;
 #endif
-- 
2.43.0


