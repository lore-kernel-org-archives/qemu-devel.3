Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF4ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7zP-0000YT-Lx; Tue, 21 Oct 2025 04:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yw-0000FV-JE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7yu-0000yD-1S
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:44:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4270a3464caso2279850f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036272; x=1761641072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc11YiHtpmTqY0in4skO46MnwNo1SXkNGODEq2TMsMU=;
 b=nN5n4R+xmK5neek1jPFXgb163XunnfSQLTO2aEq+6UofrD1G628WrS9aGj3XNJNadQ
 iOYZTIDh8VRggkRK3Y7Vtrf0o5RRkRavYcN/3hyK2po5zY2Dj1DmhoDD7cMTDORK2G05
 PjpqjT012jmoXadwVQv0qkgfYiXR3MbhkU2e5GQ8h/4uMDOUXk4SMx5l3esRPRVDnN9t
 48ZDPrbQ8BhQwTxR2H5Cnqr52tcb3lNLtUAtgkH0uvzZ5mtIig23wZAsG2ykbLEmlRsC
 g/uQu1YFpgFOoFwSB2a35uMFpzyY9ggtrnzv4At3k6aEjRwj+iIVtuFFaTO64GrlO8nA
 UJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036272; x=1761641072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hc11YiHtpmTqY0in4skO46MnwNo1SXkNGODEq2TMsMU=;
 b=cLG26bb7jVnPNouxG01u78p1Ey3HfdzVGcs/XWN75NV5KReNTYxnBEAPvkNvb12fcu
 efimRlTU65n56tAcqcGGOOgJ4zxQBOlvo80SAAtD7hyfy7V9KmLCpe++1FS/gtkboQVa
 xG5ScO0h5LrhTzb4th5fItNXxBcU74ccbUJP8MhnwrZ7lB/nHsNaUNbQ0jjESA1+8k0B
 65JG291rHS95Ozlivt+uyIMkQXg26hJ5gS2p+bC4KY+P4gS83Uf5J4M+CZdMAut4t+qu
 g5rAkULKPzbs6McIODqtHiSz6QHGjuH2M4gGKnPp2lH9ZlJi1sWmuh3Ht7bGYe49qBts
 wzPA==
X-Gm-Message-State: AOJu0YzkGxBNg+Z2jb+XstwLAy+XfewScfNXD+h04qqnEBeNEaN7VXBA
 dFOk+j/cEti/kkiUsSZr8CYrqPRHuBdIB6138FYRVgNOQVd5OEfC2aNzxsHl0/zoQ7/goh0LKE2
 fgriXknw=
X-Gm-Gg: ASbGnct4z+ayQkk1gMNl2bS8c6W+ZReya4QlgV0EyErzLQ3TOlkhl9MUUfuxnkGpSPa
 kBcgiwqobIDzMUJsb3Z9pSmOFomFmVTRrAwL5XjojuZlUpt/mXNAqErLjfn9LZC0LsGwFHfq7la
 vZ0W+agUZvHDb7FzSbpuWqZWaCOjG+g1WlHBb0evgmAocb4nC1KGfUkv6AwgXqVKuitqQmbEBgl
 ed3w3sFRA1uRTU6ZjspRi1STWBbOMpcscvIDWmQMgtCj2kTqB4mKhsk5lcLimcviTWr+gXAyy36
 SCpXHj+zbD8sa8ShA1dqSQoTNT72PQtxnQSWrs/BWeXDZwZFmZiswqjmWtPVIWfeaBW3bteNlVi
 z2ubTDHu3sZSc/Hj1mWJTzcB+25eKqyrMCkdQZapliASGCbln+diEA7AkLom2cS7aUgPXcLsjr3
 pJ4J0hBo1ihzR1+41bsOV3p4ygkK5QyhEqDnA4hTQrc+/HLEsbWMdW3LJH0tSAKZSUi+FVBVE=
X-Google-Smtp-Source: AGHT+IELZJiJfnJbVwdX1Os9p1hmB3XIZTwQOpbzRswBJhyGYUnWFGq++RhkpkJDYQ54jVhPBYkK3g==
X-Received: by 2002:a5d:64c7:0:b0:427:8bc:a3c5 with SMTP id
 ffacd0b85a97d-42708bca6b2mr8568193f8f.37.1761036272084; 
 Tue, 21 Oct 2025 01:44:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a7dasm21117154f8f.25.2025.10.21.01.44.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 01:44:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/11] hw/ppc/spapr: Remove
 SpaprMachineClass::phb_placement callback
Date: Tue, 21 Oct 2025 10:43:43 +0200
Message-ID: <20251021084346.73671-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021084346.73671-1-philmd@linaro.org>
References: <20251021084346.73671-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The SpaprMachineClass::phb_placement callback was only used by
the pseries-4.0 machine, which got removed. Remove it as now
unused, directly calling spapr_phb_placement().
Move spapr_phb_placement() definition to avoid forward declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr.h |   5 --
 hw/ppc/spapr.c         | 114 ++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 58d31b096cd..bd783e92e15 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -147,11 +147,6 @@ struct SpaprMachineClass {
     bool pre_5_1_assoc_refpoints;
     bool pre_5_2_numa_associativity;
     bool pre_6_2_numa_affinity;
-
-    bool (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
-                          uint64_t *buid, hwaddr *pio,
-                          hwaddr *mmio32, hwaddr *mmio64,
-                          unsigned n_dma, uint32_t *liobns, Error **errp);
     SpaprResizeHpt resize_hpt_default;
     SpaprCapabilities default_caps;
     SpaprIrq *irq;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index deab613e070..97736bba5a1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4068,12 +4068,62 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
     return 0;
 }
 
+static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
+                                uint64_t *buid, hwaddr *pio,
+                                hwaddr *mmio32, hwaddr *mmio64,
+                                unsigned n_dma, uint32_t *liobns, Error **errp)
+{
+    /*
+     * New-style PHB window placement.
+     *
+     * Goals: Gives large (1TiB), naturally aligned 64-bit MMIO window
+     * for each PHB, in addition to 2GiB 32-bit MMIO and 64kiB PIO
+     * windows.
+     *
+     * Some guest kernels can't work with MMIO windows above 1<<46
+     * (64TiB), so we place up to 31 PHBs in the area 32TiB..64TiB
+     *
+     * 32TiB..(33TiB+1984kiB) contains the 64kiB PIO windows for each
+     * PHB stacked together.  (32TiB+2GiB)..(32TiB+64GiB) contains the
+     * 2GiB 32-bit MMIO windows for each PHB.  Then 33..64TiB has the
+     * 1TiB 64-bit MMIO windows for each PHB.
+     */
+    const uint64_t base_buid = 0x800000020000000ULL;
+    int i;
+
+    /* Sanity check natural alignments */
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_BASE % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_LIMIT % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
+    /* Sanity check bounds */
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
+                      SPAPR_PCI_MEM32_WIN_SIZE);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
+                      SPAPR_PCI_MEM64_WIN_SIZE);
+
+    if (index >= SPAPR_MAX_PHBS) {
+        error_setg(errp, "\"index\" for PAPR PHB is too large (max %llu)",
+                   SPAPR_MAX_PHBS - 1);
+        return false;
+    }
+
+    *buid = base_buid + index;
+    for (i = 0; i < n_dma; ++i) {
+        liobns[i] = SPAPR_PCI_LIOBN(index, i);
+    }
+
+    *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
+    *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
+    *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
+    return true;
+}
+
 static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     SpaprDrc *drc;
 
@@ -4092,12 +4142,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * This will check that sphb->index doesn't exceed the maximum number of
      * PHBs for the current machine type.
      */
-    return
-        smc->phb_placement(spapr, sphb->index,
-                           &sphb->buid, &sphb->io_win_addr,
-                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
-                           windows_supported, sphb->dma_liobn,
-                           errp);
+    return spapr_phb_placement(spapr, sphb->index,
+                               &sphb->buid, &sphb->io_win_addr,
+                               &sphb->mem_win_addr, &sphb->mem64_win_addr,
+                               windows_supported, sphb->dma_liobn, errp);
 }
 
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
@@ -4345,57 +4393,6 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
     return machine->possible_cpus;
 }
 
-static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
-                                uint64_t *buid, hwaddr *pio,
-                                hwaddr *mmio32, hwaddr *mmio64,
-                                unsigned n_dma, uint32_t *liobns, Error **errp)
-{
-    /*
-     * New-style PHB window placement.
-     *
-     * Goals: Gives large (1TiB), naturally aligned 64-bit MMIO window
-     * for each PHB, in addition to 2GiB 32-bit MMIO and 64kiB PIO
-     * windows.
-     *
-     * Some guest kernels can't work with MMIO windows above 1<<46
-     * (64TiB), so we place up to 31 PHBs in the area 32TiB..64TiB
-     *
-     * 32TiB..(33TiB+1984kiB) contains the 64kiB PIO windows for each
-     * PHB stacked together.  (32TiB+2GiB)..(32TiB+64GiB) contains the
-     * 2GiB 32-bit MMIO windows for each PHB.  Then 33..64TiB has the
-     * 1TiB 64-bit MMIO windows for each PHB.
-     */
-    const uint64_t base_buid = 0x800000020000000ULL;
-    int i;
-
-    /* Sanity check natural alignments */
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_BASE % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_LIMIT % SPAPR_PCI_MEM64_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
-    /* Sanity check bounds */
-    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
-                      SPAPR_PCI_MEM32_WIN_SIZE);
-    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
-                      SPAPR_PCI_MEM64_WIN_SIZE);
-
-    if (index >= SPAPR_MAX_PHBS) {
-        error_setg(errp, "\"index\" for PAPR PHB is too large (max %llu)",
-                   SPAPR_MAX_PHBS - 1);
-        return false;
-    }
-
-    *buid = base_buid + index;
-    for (i = 0; i < n_dma; ++i) {
-        liobns[i] = SPAPR_PCI_LIOBN(index, i);
-    }
-
-    *pio = SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
-    *mmio32 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
-    *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
-    return true;
-}
-
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(dev);
@@ -4606,7 +4603,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
-    smc->phb_placement = spapr_phb_placement;
     vhc->cpu_in_nested = spapr_cpu_in_nested;
     vhc->deliver_hv_excp = spapr_exit_nested;
     vhc->hypercall = emulate_spapr_hypercall;
-- 
2.51.0


