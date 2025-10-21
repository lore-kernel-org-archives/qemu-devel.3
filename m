Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E4DCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB74W-0000uy-Ef; Tue, 21 Oct 2025 03:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB74U-0000uJ-Dm
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:46:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB74P-00020d-Su
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:46:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso5266744f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761032771; x=1761637571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIYtnVBl4SF0o8KcOR6H46cacGNMKA1Sg+xze/mfewg=;
 b=fpa6Fhsn9ya9oC2uZd4EEQ0Lh6FRmDKb7DUKMOWM/+hFPCc/n7pnW1lvsZholJZn+7
 BfE0Vi4IFRH6rerXyBA9Npqt2GrbxTV2kufBByVCEFbdhE5wWEU6vFOPzb8euomUB4Yv
 xDM/Pk1EIdREkBniEMqx4b9I5bJxj2goBwkXX5xM1hWxTV/5q4g37XBnUS/Ks2FVhs5i
 4baWwDGq8tvhmauNmQwo56hL8hXQCmpj25uQ7LlF/J4ciw0H3DMG1qQrXkBX3uAyaq0H
 3CAfJSjzeXLi5KnvYBwwiOG9jQSPyDpo87h+nDChiSR6vV406B/xEbEDzS9/S+boxqMI
 /oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761032771; x=1761637571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIYtnVBl4SF0o8KcOR6H46cacGNMKA1Sg+xze/mfewg=;
 b=v/Z5h1JpvVlbwtShgdrQem7KBY1KM5T3N4pF59bBBK7WpESak8LlFMSwfW5BrnXd6Y
 wZv1Xl7KuO+8uK5HmVKd0tkFbV9eFjdPbponwDU3MnkK8qjIFXwTWWOF1jqjiWnvze2h
 +ZXGsnlKygHxzKVbMFAXFBx7Xm0q4YNa+I6imlfC0SazqFfY+eeEDqax/9OJ+nRq5gT3
 oIxnmdadyNKESR7zsO9ctgiTd6K3MZz6tnxMzgIHaPAnSkScKaDQwlwGGjbX+5L49uKS
 rnwx0fY8uQf1+2G3xqGwg0qNMPSqrjIWqAMuCt1bRGmcvKyk609AFyUZMVos/CyEvRR8
 x++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcwo4D2dTx50xV+asSFlZ/gfHzvE8NJIOW2qWCTSnaAYDUO6+miAkP1+f+5h5PLFg2ds12qOLOEh29@nongnu.org
X-Gm-Message-State: AOJu0Yzcsckhh18uypOYnqV0PgBfYC/xihF4rhTVF8qH9bGWsuDePH44
 /WidR43O3oxGY14V27nRkYjOwxRNb5uIxQYCt07rRkf3aXitVqfdSdYmZ0yjBVA66F0=
X-Gm-Gg: ASbGnctTV+tRxGQDiCO9x5v4LPj9kqyHuh4X+GFifP22Mw5L3OlYzp7R/pPu2JnRGQO
 U7JKt9DfO6NRMtw4TfCoEWltEqVmkmtsxX7aqh5EmVPuz34jvzvDxlzwZQfxLkSws6Ltnqz+dm0
 cYA/bi73ndabGiOJKhXBusH2wW+DfjDTGqEIDZHNNXDGnohPl5FpTPYHKrqcYZI9rdO9IiKflF2
 vyNTA5n7Wq4bKBeNjU5kYGZnY4u5KEboxjkiUG7WWlWNVc1rekawVrmMIZ+Z4eNsO7oGuB+i4/e
 AujhL+Gg9FOFyxJ4d4/VIVdkXy+ahjKwir576uAviirS/n6kSoh5K8D1cC2b/yKUfoFPXBe+JFV
 RBjg/OB0/VO8Y4ciSb+UvmBpRCKnpYQatnksYPVPqx2QV7FL8V2pq6oPUCyBaEDUi1cS3ltDyoD
 hpajF+5F6+PdRQUSJ1BeUKkfjWJHHLV54MSP0CxOFH80Y=
X-Google-Smtp-Source: AGHT+IFzm7l05bRYkAbQXtdzhU8KlaqVqQyHgxFk+gHF51ax0yzC2pmzP0mgQwV44h1915sJXvod8g==
X-Received: by 2002:a05:6000:1884:b0:427:167:c2ce with SMTP id
 ffacd0b85a97d-42704dc9f6cmr11375768f8f.42.1761032771340; 
 Tue, 21 Oct 2025 00:46:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3acfsm18788634f8f.14.2025.10.21.00.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 00:46:10 -0700 (PDT)
Message-ID: <6dcf7f38-5d1d-47a0-b647-b63b9151b4b6@linaro.org>
Date: Tue, 21 Oct 2025 09:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20251020103815.78415-1-philmd@linaro.org>
 <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
 <8993a80c-6cb5-4c5b-a0ef-db9257c212be@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8993a80c-6cb5-4c5b-a0ef-db9257c212be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 21/10/25 08:31, Cédric Le Goater wrote:
> Hi
> 
> On 10/21/25 06:54, Harsh Prateek Bora wrote:
>> +Cedric
>>
>> Hi Phillipe,
>>
>> It had been done and the patches were reviewed already here (you were 
>> in CC too):
>>
>> https://lore.kernel.org/qemu-devel/20251009184057.19973-1- 
>> harshpb@linux.ibm.com/
> 
> I would take the already reviewed patches, as that work is done. This 
> series
> is fine, but it is extra effort for removing dead code, which isn't worth
> the time.

My bad for missing a series reviewed 2 weeks ago (and not yet merged).

Please consider cherry-picking the patches doing these cleanups then,
which were missed because "too many things changed in a single patch"
IMHO:

-- >8 --
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a9cf8677ac8..b9d884745fe 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -139,19 +139,11 @@ struct SpaprCapabilities {
   * SpaprMachineClass:
   */
  struct SpaprMachineClass {
-    /*< private >*/
      MachineClass parent_class;

-    /*< public >*/
-    uint32_t nr_xirqs;
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
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a1d9ce9f9aa..742881231e1 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -21,8 +21,6 @@

  uint32_t kvmppc_get_tbfreq(void);
  uint64_t kvmppc_get_clockfreq(void);
-bool kvmppc_get_host_model(char **buf);
-bool kvmppc_get_host_serial(char **buf);
  int kvmppc_get_hasidle(CPUPPCState *env);
  int kvmppc_get_hypercall(CPUPPCState *env, uint8_t *buf, int buf_len);
  int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level);
@@ -129,16 +127,6 @@ static inline uint32_t kvmppc_get_tbfreq(void)
      return 0;
  }

-static inline bool kvmppc_get_host_model(char **buf)
-{
-    return false;
-}
-
-static inline bool kvmppc_get_host_serial(char **buf)
-{
-    return false;
-}
-
  static inline uint64_t kvmppc_get_clockfreq(void)
  {
      return 0;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d704b8ce211..52333250c68 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2050,11 +2049,6 @@ static const VMStateDescription 
vmstate_spapr_irq_map = {
      },
  };

-static bool spapr_dtb_needed(void *opaque)
-{
-    return true; /* backward migration compat */
-}
-
  static int spapr_dtb_pre_load(void *opaque)
  {
      SpaprMachineState *spapr = (SpaprMachineState *)opaque;
@@ -2070,7 +2064,6 @@ static const VMStateDescription vmstate_spapr_dtb = {
      .name = "spapr_dtb",
      .version_id = 1,
      .minimum_version_id = 1,
-    .needed = spapr_dtb_needed,
      .pre_load = spapr_dtb_pre_load,
      .fields = (const VMStateField[]) {
          VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
@@ -2976,9 +2969,9 @@ static void spapr_machine_init(MachineState *machine)
       * connectors for a PHBs PCI slots) are added as needed during their
       * parent's realization.
       */
-     for (i = 0; i < SPAPR_MAX_PHBS; i++) {
-         spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
-     }
+    for (i = 0; i < SPAPR_MAX_PHBS; i++) {
+        spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
+    }

      /* Set up PCI */
      spapr_pci_rtas_init();
@@ -4051,12 +4044,62 @@ int spapr_phb_dt_populate(SpaprDrc *drc, 
SpaprMachineState *spapr,
      return 0;
  }

+static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
+                                uint64_t *buid, hwaddr *pio,
+                                hwaddr *mmio32, hwaddr *mmio64,
+                                unsigned n_dma, uint32_t *liobns, Error 
**errp)
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
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % 
SPAPR_PCI_MEM32_WIN_SIZE) != 0);
+    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % 
SPAPR_PCI_IO_WIN_SIZE) != 0);
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
  static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, 
DeviceState *dev,
                                 Error **errp)
  {
      SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
      SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
      const unsigned windows_supported = spapr_phb_windows_supported(sphb);
      SpaprDrc *drc;

@@ -4075,12 +4118,10 @@ static bool spapr_phb_pre_plug(HotplugHandler 
*hotplug_dev, DeviceState *dev,
       * This will check that sphb->index doesn't exceed the maximum 
number of
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
@@ -4328,57 +4369,6 @@ static const CPUArchIdList 
*spapr_possible_cpu_arch_ids(MachineState *machine)
      return machine->possible_cpus;
  }

-static bool spapr_phb_placement(SpaprMachineState *spapr, uint32_t index,
-                                uint64_t *buid, hwaddr *pio,
-                                hwaddr *mmio32, hwaddr *mmio64,
-                                unsigned n_dma, uint32_t *liobns, Error 
**errp)
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
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % 
SPAPR_PCI_MEM32_WIN_SIZE) != 0);
-    QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % 
SPAPR_PCI_IO_WIN_SIZE) != 0);
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
@@ -4589,7 +4579,6 @@ static void spapr_machine_class_init(ObjectClass 
*oc, const void *data)
      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
      fwc->get_dev_path = spapr_get_fw_dev_path;
      nc->nmi_monitor_handler = spapr_nmi;
-    smc->phb_placement = spapr_phb_placement;
      vhc->cpu_in_nested = spapr_cpu_in_nested;
      vhc->deliver_hv_excp = spapr_exit_nested;
      vhc->hypercall = emulate_spapr_hypercall;
@@ -4636,7 +4625,6 @@ static void spapr_machine_class_init(ObjectClass 
*oc, const void *data)
      smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
      spapr_caps_add_properties(smc);
      smc->irq = &spapr_irq_dual;
-    smc->nr_xirqs = SPAPR_NR_XIRQS;
      xfc->match_nvt = spapr_match_nvt;
      vmc->client_architecture_support = 
spapr_vof_client_architecture_support;
      vmc->quiesce = spapr_vof_quiesce;
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 548a190ce89..892ddc7f8f7 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -1041,16 +1041,14 @@ void 
spapr_clear_pending_hotplug_events(SpaprMachineState *spapr)

  void spapr_events_init(SpaprMachineState *spapr)
  {
-    int epow_irq = SPAPR_IRQ_EPOW;
-
-    spapr_irq_claim(spapr, epow_irq, false, &error_fatal);
+    spapr_irq_claim(spapr, SPAPR_IRQ_EPOW, false, &error_fatal);

      QTAILQ_INIT(&spapr->pending_events);

      spapr->event_sources = spapr_event_sources_new();

      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
-                                 epow_irq);
+                                 SPAPR_IRQ_EPOW);

      /* NOTE: if machine supports modern/dedicated hotplug event source,
       * we add it to the device-tree unconditionally. This means we may
@@ -1061,12 +1059,10 @@ void spapr_events_init(SpaprMachineState *spapr)
       * checking that it's enabled.
       */
      if (spapr->use_hotplug_event_source) {
-        int hp_irq = SPAPR_IRQ_HOTPLUG;
-
-        spapr_irq_claim(spapr, hp_irq, false, &error_fatal);
+        spapr_irq_claim(spapr, SPAPR_IRQ_HOTPLUG, false, &error_fatal);

          spapr_event_sources_register(spapr->event_sources, 
EVENT_CLASS_HOT_PLUG,
-                                     hp_irq);
+                                     SPAPR_IRQ_HOTPLUG);
      }

      spapr->epow_notifier.notify = spapr_powerdown_req;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 317d57a3802..2ce323457be 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -279,15 +279,11 @@ void spapr_irq_dt(SpaprMachineState *spapr, 
uint32_t nr_servers,

  uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
  {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
+    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
  }

  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
  {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
      if (kvm_enabled() && kvm_kernel_irqchip_split()) {
          error_setg(errp, "kernel_irqchip split mode not supported on 
pseries");
          return;
@@ -308,7 +304,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error 
**errp)
          object_property_add_child(OBJECT(spapr), "ics", obj);
          object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                   &error_abort);
-        object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, 
&error_abort);
+        object_property_set_int(obj, "nr-irqs", SPAPR_NR_XIRQS, 
&error_abort);
          if (!qdev_realize(DEVICE(obj), NULL, errp)) {
              return;
          }
@@ -322,7 +318,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error 
**errp)
          int i;

          dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + 
SPAPR_IRQ_NR_IPIS);
+        qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + 
SPAPR_IRQ_NR_IPIS);
          /*
           * 8 XIVE END structures per CPU. One for each available
           * priority
@@ -349,7 +345,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error 
**errp)
      }

      spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
+                                      SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);

      /*
       * Mostly we don't actually need this until reset, except that not
@@ -364,11 +360,10 @@ int spapr_irq_claim(SpaprMachineState *spapr, int 
irq, bool lsi, Error **errp)
  {
      SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
      int i;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
      int rc;

      assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));

      for (i = 0; i < ARRAY_SIZE(intcs); i++) {
          SpaprInterruptController *intc = intcs[i];
@@ -388,10 +383,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int 
irq, int num)
  {
      SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
      int i, j;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);

      assert(irq >= SPAPR_XIRQ_BASE);
-    assert((irq + num) <= (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert((irq + num) <= (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));

      for (i = irq; i < (irq + num); i++) {
          for (j = 0; j < ARRAY_SIZE(intcs); j++) {
@@ -408,8 +402,6 @@ void spapr_irq_free(SpaprMachineState *spapr, int 
irq, int num)

  qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
  {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
      /*
       * This interface is basically for VIO and PHB devices to find the
       * right qemu_irq to manipulate, so we only allow access to the
@@ -418,7 +410,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
       * interfaces, we can change this if we need to in future.
       */
      assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));

      if (spapr->ics) {
          assert(ics_valid_irq(spapr->ics, irq));
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cd60893a17d..43124bf1c78 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1864,17 +1864,6 @@ uint32_t kvmppc_get_tbfreq(void)
      return cached_tbfreq;
  }

-bool kvmppc_get_host_serial(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/system-id", value, NULL,
-                               NULL);
-}
-
-bool kvmppc_get_host_model(char **value)
-{
-    return g_file_get_contents("/proc/device-tree/model", value, NULL, 
NULL);
-}
-
  /* Try to find a device tree node for a CPU with clock-frequency 
property */
  static int kvmppc_find_cpu_dt(char *buf, int buf_len)
  {
---

