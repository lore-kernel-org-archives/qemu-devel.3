Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1A0C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rYz-0003Ps-P3; Sun, 30 Aug 2026 22:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYx-0003PI-9D
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:55 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rYv-0007YC-I2
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:15:55 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc11a905ba5so2056619a12.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142552; x=1788747352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kRlIG3jdUXL328hhNzi0eKdNWIgnViBStzI80X+iMs0=;
 b=I+++hLm8+9ws9BEhH0E74kGWb6cHiuaniCCJoIkiRGyHk7kTEtn8K3cP8gVoLiModQ
 UmgBaHmu+11RhFudTPDMj6ZW/js5JfOBMQZGxX74CMdMinOFYfhPbirG+OpfP3yFw7IZ
 F/RcUmntPyNQVAVgDOna7jmZkzuUQhIagwg2nRqz9zknxc0vrIhmeNTzHzE2ChvQYaVS
 A8rAJ+Nn2it6D86MuYjtPpzXNZ4X82Wezu6UGPckoJB/5Z0utd0w/3DDQ7GZ/zGw/fgl
 26WEIs7e0uRumW1EKWA9RD0IUNLOZkzy1Q4HbJ0ZsGHxzNwooL+BwYbASun0+UHt9jz6
 aBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142552; x=1788747352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRlIG3jdUXL328hhNzi0eKdNWIgnViBStzI80X+iMs0=;
 b=JQR3RduEqv6ejIEGV0IOC/b2c1SJwOPfxem0Wyw2bVJ1zUJg9KypHEoFBRSkSChc7M
 2eyTG/Sex9s9MyQmX4EpJGP+iSh64uTz3P2KBeJjK+qN59B0sStD7HFqyNgZPwCXiGfT
 XqW3ERqnyow76ma2k8E8r0DSqDcWYZsgCeuIVDS+H/9B6Yb1oH9cgMX1y40ivRy66prq
 yyhMkUTusLcMeXi+8Kkhf8haF2QjyVAdAlQe4P71O6tpbKltPuRajr2mpYtZcKqAqFpE
 ozK3aNCR01kFezYDKnpf5e92a/7NoQ1R34+nJFKx7XBok1S7IwuH3JcerXEDxQRGEiYK
 DPjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1H9W0TXsy340MGbFBRbKZOczsey/Qmco73KbDy0UkMuFCawyQ30FpBfQjmwB7AKtO7kciF9Dxq+Xq@nongnu.org
X-Gm-Message-State: AFuF++lcywdS1nOiUdkduDlFpI4KY6UKiHJCrvse0rs61b0bZ4sMqtml
 WTDyDAu1yhrtKAQ/ygT9Pf+LvBSYOS6zNgJhFXW0CCvj3Ier9F3W+YuGuxpPGA==
X-Gm-Gg: AYBFou1QB0KtV382793atA10qaC243uHcYTrIRDvS+/DY5NgoM9nZQv9QZq5vABPsqf
 hyaHrQGw8xuoRtvMIYCetPZiDGmYj5txAC9cT8TbvenXDwNg1UV8KaR6x5EXuJnB8XHpIXSadH5
 IeyIKuOt+Umj36xTZi2iJJZOedb8ZlCg0sIfBnUY2qbdZZlEMIx5lm7eSFqL69a1YNIWvNg+kiY
 gE9YUAVZXpWvVnSj92X1roA8R6A9R5A37shEPcsZrjqrUHUlky35mZHJyMSHwu/MQgdjLhsOWot
 mKkmLpZRJlYD9E8Y4mngGIzZV5m+ZVTJO2R6ovlmkGxwLnBdgxnRBKcjogCuD6L+cfIHp6gblXZ
 5xUfMhtVroAUOUQKIKr0AZ0yLpljst+lleRjO+riyoZ/TtF7x5+ZR3N+PkbsxKAffXSrbP4xo0c
 gApNSeYFWdaKrZEZsw90bTbYkl662wAZW6zqHoEe+xfvq1IOp8W66aF/awnUhFdKQefaFgK/w/9
 /VJtXVMKd1T6vVywFBbyYD9E+7SeoGrG+Brta7DC5v2qgHqvbfqV0E+6naDKsETvBex8I7IO5Ep
 HbAsd+KGrRhFhQUVQlph
X-Received: by 2002:a17:90b:4a8c:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-396d0f69d10mr29681441a91.13.1788142551951; 
 Sun, 30 Aug 2026 19:15:51 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:15:51 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] hw/intc/riscv_aplic: Take a MemoryRegion for the
 created device
Date: Mon, 31 Aug 2026 11:44:45 +0930
Message-ID: <20260831021500.82565-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

riscv_aplic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). The mapping still only happens when the
APLIC is emulated. All callers pass system_memory, so there is no
change in behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/intc/riscv_aplic.h | 2 +-
 hw/intc/riscv_aplic.c         | 5 +++--
 hw/riscv/aia.c                | 6 ++++--
 hw/riscv/cps.c                | 6 ++++--
 hw/riscv/xiangshan_kmh.c      | 6 ++++--
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index c7a4d4ad0172..baeec76e4c3e 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -80,7 +80,7 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
 void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
 
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aplic_create(MemoryRegion *mr, hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
     uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent);
 
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 84606e9f3d88..87d7d9e49cdd 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1109,7 +1109,7 @@ void riscv_aplic_add_child(DeviceState *parent, DeviceState *child)
 /*
  * Create APLIC device.
  */
-DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
+DeviceState *riscv_aplic_create(MemoryRegion *mr, hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
     uint32_t iprio_bits, bool msimode, bool mmode, DeviceState *parent)
 {
@@ -1137,7 +1137,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     if (riscv_use_emulated_aplic(msimode)) {
-        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+        memory_region_add_subregion(mr, addr,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
         if (!msimode) {
             for (i = 0; i < num_harts; i++) {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 49cb14349f00..974806c425e2 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -71,7 +71,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
 
     if (!kvm_enabled()) {
         /* Per-socket M-level APLIC */
-        aplic_m_dev = riscv_aplic_create(aplic_m->base +
+        aplic_m_dev = riscv_aplic_create(mr,
+                                     aplic_m->base +
                                      socket * aplic_m->size,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
@@ -82,7 +83,8 @@ DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
     }
 
     /* Per-socket S-level APLIC */
-    aplic_s_dev = riscv_aplic_create(aplic_s->base +
+    aplic_s_dev = riscv_aplic_create(mr,
+                                 aplic_s->base +
                                  socket * aplic_s->size,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 5cfb54aa27d2..d2fd9638a08d 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -135,14 +135,16 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_of_clusters; i++) {
         uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
         uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
-        s->aplic = riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+        s->aplic = riscv_aplic_create(get_system_memory(),
+                                      cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
                                       hartid_base, /* hartid_base */
                                       MAX_HARTS, /* num_harts */
                                       APLIC_NUM_SOURCES,
                                       APLIC_NUM_PRIO_BITS,
                                       false, true, NULL);
-        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+        riscv_aplic_create(get_system_memory(),
+                           cm_base + AIA_PLIC_S_OFFSET,
                            AIA_PLIC_S_SIZE,
                            hartid_base, /* hartid_base */
                            MAX_HARTS, /* num_harts */
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 9eb608f8c578..c5a654ab417d 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -80,13 +80,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     }
 
     /* M-level APLIC */
-    aplic_m = riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_M].base,
+    aplic_m = riscv_aplic_create(get_system_memory(),
+                                 memmap[XIANGSHAN_KMH_APLIC_M].base,
                                  memmap[XIANGSHAN_KMH_APLIC_M].size,
                                  0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                                  1, true, true, NULL);
 
     /* S-level APLIC */
-    riscv_aplic_create(memmap[XIANGSHAN_KMH_APLIC_S].base,
+    riscv_aplic_create(get_system_memory(),
+                       memmap[XIANGSHAN_KMH_APLIC_S].base,
                        memmap[XIANGSHAN_KMH_APLIC_S].size,
                        0, 0, XIANGSHAN_KMH_APLIC_NUM_SOURCES,
                        1, true, false, aplic_m);
-- 
2.47.3


