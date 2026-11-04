Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34403606A331
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.a=rsa-sha256 header.s=s1 header.b=LPKxcVBi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOR83-0003jd-UY; Tue, 03 Nov 2026 21:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xOR80-0003j2-Tv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 21:53:33 -0500
Received: from va-2-39.ptr.blmpb.com ([209.127.231.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1xOR7x-0007nB-CO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 21:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1793760799;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=p8vo27e0BbcWSkotfRUgXo1Va1wBw6w3HN3q+yADEVw=;
 b=LPKxcVBiAcBr0/VUIPYAhPhL2WUzpex3uoxIb9GukEBQZHErhzbZAlNoYJI+dlbhuI/V40
 1vKP6oPdT2P/Zpz/83hAkB3B/KXdqpoPupgQp8LDHebfQeBoE2iANC8LuSBCcubXJwG8tK
 lYG+r4LboLbfIEZRGWiUPv8xDjANKiLdXMilTfCh3+vpXMoTiY64ho2476CdOEi5jX7p/m
 yhkvzp0uqSZ505W/AF82n7fJ5v92s9ktzhZOBBFz/PmGSHbKQzclAYXoTU35jq1RThqquE
 AobldXXn1JiaLnMDmp2As2xTgNaKngWbIPbEeOithXz+BvwdKhAfFXmWL7QGuA==
To: <palmer@dabbelt.com>
Cc: <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>, 
 <chao.liu@processmission.com>, <qemu-riscv@nongnu.org>, 
 <qemu-devel@nongnu.org>, <xiangwencheng@lanxincomputing.com>, 
 <anup@brainfault.org>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Date: Wed,  4 Nov 2026 10:53:08 +0800
Message-Id: <20261104025308.1920474-1-xiangwencheng@lanxincomputing.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2] hw/intc/aplic: Fix msicfgaddrH in split mode
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
X-Lms-Return-Path: <lba+26aea9e1d+8325ac+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Received: from lanxin-ThinkBook-16-G5-IRH ([123.120.5.129]) by smtp.feishu.cn
 with ESMTP; Wed, 04 Nov 2026 10:53:16 +0800
Received-SPF: pass client-ip=209.127.231.39;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-39.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add hart_bits and guest_bits to msicfgaddrH in KVM irqchip
split mode.
Also remove the redundant left shift when loading
kvm_msicfgaddrH in riscv_aplic_msi_send().

Rationale:
static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
                                  uint32_t hart_idx, uint32_t guest_idx,
                                  uint32_t eiid)
{
     uint64_t addr;
     MemTxResult result;
     RISCVAPLICState *aplic_m;
     uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;

     ...

     if (aplic->kvm_splitmode) {
         msicfgaddr = aplic->kvm_msicfgaddr;
1.        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     }
     ...

     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
             APLIC_xMSICFGADDRH_LHXS_MASK;
     lhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXW_SHIFT) &
             APLIC_xMSICFGADDRH_LHXW_MASK;
     hhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXS_SHIFT) &
             APLIC_xMSICFGADDRH_HHXS_MASK;
     hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
             APLIC_xMSICFGADDRH_HHXW_MASK;
     ...

     group_idx = hart_idx >> lhxw;

     addr = msicfgaddr;
2.    addr |= ((uint64_t)(msicfgaddrH & APLIC_xMSICFGADDRH_BAPPN_MASK))
<< 32;
     addr |= ((uint64_t)(group_idx &
APLIC_xMSICFGADDR_PPN_HHX_MASK(hhxw))) <<
              APLIC_xMSICFGADDR_PPN_HHX_SHIFT(hhxs);
3.    addr |= ((uint64_t)(hart_idx &
APLIC_xMSICFGADDR_PPN_LHX_MASK(lhxw))) <<
              APLIC_xMSICFGADDR_PPN_LHX_SHIFT(lhxs);
4.    addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
     addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
     ...
}

Since msicfgaddrH is left-shifted at (2), the left shift at (1) is
redundant.

At (3) and (4), hart_idx and guest_idx are masked/shifted using lhxw and
lhxs, which are extracted from the LHXW/LHXS fields of msicfgaddrH.
However, riscv_aplic_set_kvm_msicfgaddr() did not program the LHXW/LHXS
fields into kvm_msicfgaddrH, so lhxs/lhxw always read as zero, and the
hart/guest idxs were never encoded into the MSI address. Fix this by
programming hart_bits (LHXW) and guest_bits (LHXS) into kvm_msicfgaddrH
in riscv_aplic_set_kvm_msicfgaddr().

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
Changes in v2:
- Add rationale.
---
 hw/intc/riscv_aplic.c         | 13 +++++++++----
 hw/riscv/aia.c                |  6 +++++-
 include/hw/intc/riscv_aplic.h |  3 ++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 03a0852b8b..2b618e73df 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -182,7 +182,8 @@ bool riscv_use_emulated_aplic(bool msimode)
     return kvm_kernel_irqchip_split();
 }
 
-void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
+                                    uint32_t hart_bits, uint32_t guest_bits)
 {
     if (!kvm_enabled()) {
         return;
@@ -191,8 +192,12 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
     if (riscv_use_emulated_aplic(aplic->msimode)) {
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
-        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
-                                 APLIC_MMSICFGADDRH_VALID_MASK;
+        aplic->kvm_msicfgaddrH =
+            ((hart_bits & APLIC_xMSICFGADDRH_LHXW_MASK) <<
+             APLIC_xMSICFGADDRH_LHXW_SHIFT) |
+            ((guest_bits & APLIC_xMSICFGADDRH_LHXS_MASK) <<
+             APLIC_xMSICFGADDRH_LHXS_SHIFT) |
+            (extract64(addr, 32, 32) & APLIC_xMSICFGADDRH_BAPPN_MASK);
     }
 }
 
@@ -404,7 +409,7 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
 
     if (aplic->kvm_splitmode) {
         msicfgaddr = aplic->kvm_msicfgaddr;
-        msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
+        msicfgaddrH = aplic->kvm_msicfgaddrH;
     } else {
         msicfgaddr = aplic_m->mmsicfgaddr;
         msicfgaddrH = aplic_m->mmsicfgaddrH;
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 56fc064533..bd608bd7a6 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -38,6 +38,7 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
 {
     int i;
     hwaddr addr = 0;
+    uint32_t hart_bits, guest_bits;
     DeviceState *aplic_s_dev = NULL;
     DeviceState *aplic_m_dev = NULL;
 
@@ -93,7 +94,10 @@ DeviceState *riscv_create_aia(MemoryRegion *container,
                                  msimode, false, aplic_m_dev);
 
     if (kvm_enabled() && msimode) {
-        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr);
+        hart_bits = imsic_num_bits(hart_count);
+        guest_bits = imsic_num_bits(aia_guests + 1);
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s_dev), addr,
+                                    hart_bits, guest_bits);
     }
 
     return kvm_enabled() ? aplic_s_dev : aplic_m_dev;
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 62d2b33ade..d3ee2e537a 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -78,7 +78,8 @@ struct RISCVAPLICState {
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
-void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr,
+                                    uint32_t hart_bits, uint32_t guest_bits);
 
 DeviceState *riscv_aplic_create(MemoryRegion *container,
     hwaddr addr, hwaddr size, uint32_t hartid_base, uint32_t num_harts,
-- 
2.53.0

