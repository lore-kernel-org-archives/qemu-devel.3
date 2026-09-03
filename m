Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8FBC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20NP-0006Wx-W0; Thu, 03 Sep 2026 01:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NO-0006Wh-Gt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NM-0006JT-N6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so2343658a91.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414759; x=1789019559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ueueg6h6L/6zGU1+lLrauSFQbJFf5Bkt7eWt6E1w4o=;
 b=sWgtXnNAu+itsNkaCurOfILvKlHxt6oyTKVt+mFzXaOUTRzWtxndUsAQ4YUqPwmfOv
 dKJfvPcroq8r2QGK9OVU0Yq6sNRNG1ILQ7FHyiwoVIiiPkjxF4ak8e30niPIASOXmsDk
 6yZBVruCGHa9MVglMtJ92knvsZBFGyyLkhebNdjanCLiShTkADBLJpoNkAmg43auFBds
 h6kxfNF3bZmWhHtmG+6YrLhyiDRtmC3SiLw0Noq7f/WPLKLJdX0e1gwNMLFGJEIyZMd/
 TYuBlJ0vDv+IcysuCB+DXNmB3jtxLVrdZgn+5nLqcyb3DS2BCV2hZHkSvHcGboZSDKTU
 PkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414759; x=1789019559;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ueueg6h6L/6zGU1+lLrauSFQbJFf5Bkt7eWt6E1w4o=;
 b=GQlG6jh26fPRIRtUTnm39z0O7jK709w+SdC3ZqCscXuwgtu7LV4cDhMCBls/gLBPNX
 E1nPSN4MJFcVT6KC3ZhpQaZvm++CcvizJy4AM30srXpoXbEnba+Fd7DTFK3pKQMANj4y
 3Ofu3tVyxx9KAPvZrww5RZ6Sp+zH7Fz06NX72vXQP88oC2dFpa4k3FC3u0OoT0JfF5nf
 nMu/BKHMLZBC9BuWAdmW3HyWzRmxhOZM5mVOx50Uenn5cyHnH7/FVFp4nIMULkQSv1hY
 ZOnbuxYg44Vknvwcwd/PdLWv3BqdtAHcTb61/oEtO9kbAYRppfkgs7CeCykfDksTV14S
 Cang==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQDLoIOnr/KNutNx/R55wlXhfle3UGUo8egnHSHuw6TnDu+EmQNyceMaie53xBKQZlaNv/angNhnrO@nongnu.org
X-Gm-Message-State: AFuF++lrAqnhCgoBtxnm63dqxzJ/6yat8Y29+OBAyhyWhEfS2yUTF9kf
 lXvop9szFbNeKcnAt6UPVihKf+w71zM6hZcaXhd/JiKB/PrCGYRAtdSn
X-Gm-Gg: AYBFou3w8KTzoxWr0X/2pkKuAreIpDAJkWB8NdFBaKywBY5c05a5cK9V6SqJhMPHKjt
 ytjveWAOThE+CaEbXv7+wSQWmrRkssNvw8CjwyzU3s/DKC0M2NQwRtWl7GzQmBRPKNq7GDSrmzn
 uKP1ILAKpcmFGTmjPUW+U0VtY/DOyMKzVQU+tUGg1XtKqbnFJBi75Xdw4sWuHGhV2H/Q0x4ctC8
 wPtzS4zEMuNbAcmk9R5dT3sZp//eTcmL+wO4TeknTTwSZSgwzI3DCK04gwS7yn0N7Sm6SwUmr73
 iMZPvaegWqj2gIlcziv6qWJIqvuYSRcWF9NkwGtJ9VV3PC662PIaoDydKTp6s/UBnNfhfgaqQVl
 qPR1hh1unPR17tXXHY4S5labCwMUsDcyxwXfsaZgyq3kTkBZjWYgygZ3vzvTu+/rVQ1lxo6+45I
 kjk0K9B9/9rgYlftBBosv/+oEtlYtkCL4VpgOJ/a1EeoDgQrKFRCyP8JduSdaMOlynNpAM8mN01
 gLj3NgKk01cziK1ERUqkrAm5FmhI5gaqSeViLVNWcU5ZDTYvwbE8Sxpetz3txTqrMPFifzJYjgO
 MbzVNAQPuAhRnQ8WKPwSPVbE3qdpHzo=
X-Received: by 2002:a17:90a:c10e:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39aedff8438mr15563810a91.10.1788414759254; 
 Wed, 02 Sep 2026 22:52:39 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:52:38 -0700 (PDT)
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
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 03/16] hw/intc/riscv_imsic: Take a MemoryRegion for the
 created device
Date: Thu,  3 Sep 2026 15:21:17 +0930
Message-ID: <20260903055131.257903-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
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

riscv_imsic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/intc/riscv_imsic.h | 3 ++-
 hw/intc/riscv_imsic.c         | 6 ++++--
 hw/riscv/aia.c                | 6 ++++--
 hw/riscv/xiangshan_kmh.c      | 5 +++--
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/hw/intc/riscv_imsic.h b/include/hw/intc/riscv_imsic.h
index fae999731dff..0a1df1c2f8d6 100644
--- a/include/hw/intc/riscv_imsic.h
+++ b/include/hw/intc/riscv_imsic.h
@@ -62,7 +62,8 @@ struct RISCVIMSICState {
     uint32_t num_irqs;
 };
 
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids);
 
 #endif
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index d6b46cdca220..cb9ce9612cff 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -495,7 +495,8 @@ type_init(riscv_imsic_register_types)
 /*
  * Create IMSIC device.
  */
-DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
+DeviceState *riscv_imsic_create(MemoryRegion *container, hwaddr addr,
+                                uint32_t hartid, bool mmode,
                                 uint32_t num_pages, uint32_t num_ids)
 {
     DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
@@ -518,7 +519,8 @@ DeviceState *riscv_imsic_create(hwaddr addr, uint32_t hartid, bool mmode,
     qdev_prop_set_uint32(dev, "num-irqs", num_ids + 1);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(container, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     if (!kvm_irqchip_in_kernel()) {
         for (i = 0; i < num_pages; i++) {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index e11382e512da..eae7638f972b 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -53,7 +53,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * m_imsic_stride,
+                riscv_imsic_create(container,
+                                   addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
@@ -62,7 +63,8 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
         /* Per-socket S-level IMSICs */
         addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
         for (i = 0; i < hart_count; i++) {
-            riscv_imsic_create(addr + i * s_imsic_stride,
+            riscv_imsic_create(container,
+                               addr + i * s_imsic_stride,
                                base_hartid + i, false, 1 + aia_guests,
                                num_msis);
         }
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 94f9d02a00b9..9eb608f8c578 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -65,14 +65,15 @@ static DeviceState *xiangshan_kmh_create_aia(uint32_t num_harts)
     /* M-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_M].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0), i, true,
+        riscv_imsic_create(get_system_memory(),
+                           addr + i * IMSIC_HART_SIZE(0), i, true,
                            1, XIANGSHAN_KMH_IMSIC_NUM_IDS);
     }
 
     /* S-level IMSICs */
     addr = memmap[XIANGSHAN_KMH_IMSIC_S].base;
     for (i = 0; i < num_harts; i++) {
-        riscv_imsic_create(addr +
+        riscv_imsic_create(get_system_memory(), addr +
                            i * IMSIC_HART_SIZE(XIANGSHAN_KMH_IMSIC_GUEST_BITS),
                            i, false, 1 + XIANGSHAN_KMH_IMSIC_GUEST_BITS,
                            XIANGSHAN_KMH_IMSIC_NUM_IDS);
-- 
2.47.3


