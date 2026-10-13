Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE1CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9k-000347-VX; Tue, 13 Oct 2026 04:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4d-0001nC-QZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4b-0008JD-Lg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so23060545e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880884; x=1792485684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCpgab38MLMVKSwDafn5dl4ylWQwh1yRX8QFoIz4DxM=;
 b=RBh3B2xWcN2bTkysZ5JAMPYDcCH7eprNE89ly59HcyrEjccuf/YwZz3Ruczhv1i+Cd
 pEqxI5mdFRVA5SHJJyiz/cqdlV2/vx0D0BWl3w3pED+NhOqLPun1qeqt3dzjyly2D5Ep
 jv/wNbgqDMK1Bwhi2uuScQqdojiActzXgPW9OO+554dnzOwOwSdcgxveTD/GiV9Gc3cB
 Oput4qcZfBGHz/2wN/xnlY+wLPgywEe6mh1qiI8a0e4mjdB6rS50hkx6JXYLMsk2rHQA
 p/XllIQJ8qSp01O0yChPkbYV8a3cSkPnFVczbgtjbFpiipA9lwJSSXI7VlFdqFJasNpe
 BVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880884; x=1792485684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uCpgab38MLMVKSwDafn5dl4ylWQwh1yRX8QFoIz4DxM=;
 b=d+fVfCqLAhjrz3wpdMeXZaRsMrO3ZfbSpLERtavM0QhM9GYgqYDkaif4HMrdp+A8gN
 20I0hN4SBjzDuny61eZRMnzWX0QcjeTVwTRDmQ+E8XAFJYvXJNXknO/4uCvX8u/NIGBW
 sZwOptTcwO2kVeCGgOn3os8adjjOvaPujiqr4avTkb4KHjv1ZEAmhfOGVPajDeGMQoTD
 kF8TNYRIvrQq8ExCtH5R0Yz9Qf3OIEnGPm3uSqvJeDBpHPqZehX4OC324rbAwpPrJ1gg
 ZmMBciJ4ygODo5SGoXAbvtxU2LXAj7AXG2pGCKfw0tluxQeZ3mpvT93j9Re9D00d/kgc
 qjuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5M1OltjvYdkxt7FCVVT6UPpemxFJURCMbX9JuCBetw/w1JzNu86xzwjs23V+7Z9AXV4qOdLmS0/9Y@nongnu.org
X-Gm-Message-State: AFq9FYKAUm3K7Ynfxj+rTOeApNsS42jpcdPOu2LzwQ0Ul4oI+1sL/vu1
 RcimlUFN2YYozaZpxbhkX/93HqnldqUOFifIfdxlOVhndz/7gTmb9ZCzyXBwh5EroGM=
X-Gm-Gg: AYBFou0l0iSHkh36JI38bfLd7+JCp8sW06Rn3q7pydoafImqFhLg8k1KnFp1ew7xVCn
 tIjKsntUlVd5RgbiAR4DvIguTmrE/5+jtnZj+zIvzrCNHDNM+SSlgtZDD6jIuSpOJF+P7rhXJyR
 VIjZ658m3VmLJoh8lv+mCNP+o6LANvJQLC59MDPpXg7/2FOdE2c5j4BkLV3A88Lp5N3cFIySaUT
 JQb6+L//3wWNFRX4mOlFppOeOn9UBaMsJdBadgP7cR3LcWI10qcGCfaMrInuJiYtpxjwxkQQVqD
 /YNq68e9ZRpX9Ui5A7Ngm6hIfvJgih5LiG5yvTKMY/LI9IkaF60Ne/AzcKen/Aq5y9098OBH/rf
 z1IQSGTGYvtJO1ts+1uhwhnmClN/FYv84XtkLnW8uDXDm/2T6lor+0Cgpx8plIvgUtMa9x36Ane
 Z7UXanosGH0vHA+Sdq+fCVKwGsTBvfRVbfuLo8oBUIlGbA72eSQtKyg07TvdEYZks1yVULWxywA
 ifw9CNWn+TOAGG4cLzoMw3zIM4u5m1B2qjgStk1wAjsjIi5+AN8cpJg+5bwtAFd1irAm7OKi+OA
 K+8=
X-Received: by 2002:a05:600c:4e55:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4a18e49c008mr209129145e9.12.1791880883687; 
 Tue, 13 Oct 2026 01:41:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 84/86] hw/intc/arm_gicv5: Implement reporting of Quiesced state
Date: Tue, 13 Oct 2026 09:39:31 +0100
Message-ID: <20261013083933.1024405-85-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Implement the IRS_SAVE_VM_STATUSR register and its reporting of
Quiescent state.  For QEMU, save-vm operations are instantaneous from
the point of view of the guest, and so the IDLE bit is (as usual for
these status registers) always 1.  The other bit in the register is
Q, which reports whether the VM is still in the Quiesced state
following some previous write of 1 to IRS_SAVE_VMR.S.

As I_DSRQY notes, the set of conditions when Q is UNKNOWN give us
the latitude to implement it as "always returns the current state,
and the guest doesn't need to trigger an update by writing
IRS_SAVE_VMR.{S,Q} to {0,1}".

A VM is Quiesced (D_MGVXX) if:
 * no VPEs in the VM are resident
 * there is no change in the Pending state of any virtual interrupt
 * there is no change to the number of valid VPEs in the VM
 * the VM does not become invalid

We can therefore track Quiesced state via a flag in our VMTE struct,
which is set to 'true' on an IRS_SAVE_VM_STATUSR S=1 write, and then
flipped to false for changes in Pending state, number of VPEs, and so
on.  IRS_SAVE_VM_STATUSR.Q returns that flag value, or 0 if the
VM selected by IRS_SAVE_VMR.VM_ID isn't valid.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c  | 77 ++++++++++++++++++++++++++++++++++++++++++--
 hw/intc/trace-events |  1 +
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index e1796ec17a6..de595d93506 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -50,6 +50,7 @@ struct VMTE {
     uint32_t vmid;
     uint8_t vpe_id_bits;
     GICv5Domain domain;
+    bool quiesced;
     /* We don't cache the VMD_ADDR as we don't use VMDs */
     /* We don't cache VALID: the existence of this struct implies VALID=1 */
 };
@@ -914,6 +915,8 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
         if (!set_pending_for_ist(cs, cfg, id, pending, &iaffid)) {
             return;
         }
+        /* changing Pending state breaks Quiesced */
+        vmte->quiesced = false;
         irs_recalc_vhppi(s, vmte, iaffid);
         return;
     }
@@ -1171,7 +1174,8 @@ uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
 static bool activate_for_ist(GICv5Common *cs,
                              const GICv5ISTConfig *cfg,
                              uint32_t id,
-                             uint32_t *iaffid)
+                             uint32_t *iaffid,
+                             bool *changed_pending)
 {
     L2_ISTE_Handle h;
     uint32_t *l2_iste_p;
@@ -1185,6 +1189,9 @@ static bool activate_for_ist(GICv5Common *cs,
     *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, ACTIVE, true);
     if (FIELD_EX32(*l2_iste_p, L2_ISTE, HM) == GICV5_EDGE) {
         *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, false);
+        if (changed_pending) {
+            *changed_pending = true;
+        }
     }
     *iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
     put_l2_iste(cs, cfg, &h);
@@ -1201,10 +1208,15 @@ void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
 
     if (virtual) {
         const GICv5ISTConfig *cfg = ist_for_vint(s, cs, domain, type, cpuidx);
+        bool changed_pending = false;
 
-        if (!activate_for_ist(cs, cfg, id, &iaffid)) {
+        if (!activate_for_ist(cs, cfg, id, &iaffid, &changed_pending)) {
             return;
         }
+        /* Changing Pending breaks Quiesced state */
+        if (changed_pending) {
+            s->res_vpe[cpuidx]->vmte->quiesced = false;
+        }
         irs_recalc_vhppi(s, s->res_vpe[cpuidx]->vmte, iaffid);
         return;
     }
@@ -1214,7 +1226,7 @@ void gicv5_activate(GICv5Common *cs, uint32_t id, GICv5Domain domain,
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
 
-        if (!activate_for_ist(cs, cfg, id, &iaffid)) {
+        if (!activate_for_ist(cs, cfg, id, &iaffid, NULL)) {
             return;
         }
         break;
@@ -1484,6 +1496,10 @@ bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
         vpe->cpuidx = cpuidx;
 
         s->res_vpe[cpuidx] = vpe;
+
+        /* Making a VPE resident breaks Quiesced state */
+        vmte->quiesced = false;
+
         trace_gicv5_set_resident(domain_name[domain], vmid, vpeid, cpuidx);
     } else {
         vpe = s->res_vpe[cpuidx];
@@ -2317,6 +2333,9 @@ static void irs_vmap_vper_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     init_vpe_from_vpete(&vmte->vpet[vpeid], vmte, vpete);
     trace_gicv5_irs_vmap_vper_write(domain_name[domain], vmte->vmid, vpeid);
 
+    /* Adding a VPE to the VM breaks it being Quiesced */
+    vmte->quiesced = false;
+
     irs_recalc_vhppi(s, vmte, vpeid);
 
     return;
@@ -2514,11 +2533,55 @@ static void irs_save_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 
     trace_gicv5_irs_save_vmr_write(domain_name[domain], vmid);
+    /*
+     * Writing S = 1 is the start of a check for if the VM stays
+     * Quiesced. If some VPE is currently resident than the VM is not
+     * Quiesced. Other state changes later may also flip it to
+     * not-Quiesced.
+     */
+    vmte->quiesced = true;
+    for (uint32_t i = 0; i < (1 << vmte->vpe_id_bits); i++) {
+        VPE *vpe = &vmte->vpet[i];
+
+        if (vpe->valid && vpe->resident) {
+            vmte->quiesced = false;
+            break;
+        }
+    }
 
     irs_sync_ist_to_memory(cs, &vmte->lpi_ist);
     irs_sync_ist_to_memory(cs, &vmte->spi_ist);
 }
 
+static uint64_t irs_save_vm_statusr_read(GICv5 *s, GICv5Domain domain)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+    uint32_t vmid;
+    VMTE *vmte;
+    /* IDLE always set; Q set only if VM is Quiesced */
+    uint64_t value = R_IRS_SAVE_VM_STATUSR_IDLE_MASK;
+
+    vmid = FIELD_EX64(cs->irs_save_vmr[domain], IRS_SAVE_VMR, VM_ID);
+
+    if (!cfg->valid || vmid >= (1 << cfg->vm_id_bits)) {
+        return value;
+    }
+
+    vmte = g_hash_table_lookup(cfg->vm_cache, GINT_TO_POINTER(vmid));
+    if (!vmte) {
+        return value;
+    }
+
+    trace_gicv5_irs_save_vm_statusr_read(domain_name[domain],
+                                         vmid, vmte->quiesced);
+
+    if (vmte->quiesced) {
+        value |= R_IRS_SAVE_VM_STATUSR_Q_MASK;
+    }
+    return value;
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -2802,6 +2865,14 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_SAVE_VM_STATUSR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = irs_save_vm_statusr_read(s, domain);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         *data = 0;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 9902cb97b8f..017f0fc21dc 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -262,6 +262,7 @@ gicv5_set_resident(const char *domain, uint32_t vmid, uint32_t vpeid, uint32_t c
 gicv5_set_non_resident(const char *domain, uint32_t cpuidx, bool db, uint8_t dbpm) "GICv5 IRS %s set_resident phys CPU idx %u: now no resident VPE; db_req %d dbpm %u"
 gicv5_irs_ring_doorbell(const char *domain, uint32_t vmid, uint32_t db_intid) "GICv5 IRS %s VM ID %u: ringing doorbell LPI %u"
 gicv5_irs_save_vmr_write(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u saving IST data to memory"
+gicv5_irs_save_vm_statusr_read(const char *domain, uint32_t vmid, bool quiesced) "GICv5 IRS %s VM ID %u reporting quiesced %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
-- 
2.43.0


