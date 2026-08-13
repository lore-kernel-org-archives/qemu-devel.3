Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C52C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYH6-0004eH-No; Thu, 13 Aug 2026 12:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGc-000441-Tf; Thu, 13 Aug 2026 12:27:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuYGb-0001Qm-8q; Thu, 13 Aug 2026 12:26:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCHj1NK8H1qTyVvAw--.34755S2; 
 Fri, 14 Aug 2026 00:26:50 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwoHJE8H1q7ywjAA--.56307S3;
 Fri, 14 Aug 2026 00:26:44 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 27/28] hw/arm/smmuv3: Add secure bank migration and
 secure-impl property
Date: Fri, 14 Aug 2026 00:26:43 +0800
Message-Id: <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwoHJE8H1q7ywjAA--.56307S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAGBWp8yc0HtwAAsg
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3GrWxGw1fKFW3AFWkAFyfCrg_yoW7AF4Dpr
 s8Gwn8GryUGF43Zr43J3WrCFs5Cr4xGa1YkrWDCa9aya1ktF42qwn7A3yFg3ykGrW8Xa1x
 uF1xuFZrJr47ZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Add a secure-impl device property and advertise it through
S_IDR1.SECURE_IMPL. Reject secure-impl=on unless Secure memory is available
and stage-1 translation is supported.

Usage:
    -M virt,secure=on,iommu=smmuv3 \
    -global arm-smmuv3.secure-impl=on

Add the smmuv3/bank_s migration subsection for the secure register bank.
Serialize secure bank state including GBPA, IRQ config, stream table and
queue state.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/smmuv3.c         | 93 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e7376c65e2..8e1de94fd17 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -348,6 +348,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
 
     sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
                                SMMU_IDR1_SIDSIZE);
+    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SECURE_IMPL,
+                               s->secure_impl == ON_OFF_AUTO_ON);
     smmuv3_accel_idr_override(s);
 }
 
@@ -2752,6 +2754,37 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static bool smmuv3_resolve_secure_impl(SMMUv3State *s, Error **errp)
+{
+    SMMUState *bs = ARM_SMMU(s);
+    bool secure_as_available = bs->secure_memory &&
+                               bs->secure_memory_as.root != NULL;
+
+    if (s->secure_impl == ON_OFF_AUTO_AUTO) {
+        s->secure_impl = secure_as_available ? ON_OFF_AUTO_ON
+                                             : ON_OFF_AUTO_OFF;
+    }
+
+    if (s->secure_impl == ON_OFF_AUTO_ON && !secure_as_available) {
+        error_setg(errp,
+                   "secure-impl=on requires a secure-memory address space");
+        return false;
+    }
+
+    /*
+     * When SECURE_IMPL == 1, stage 1 must be supported according to
+     * (IHI 0070G.b) 6.3.53 SMMU_S_IDR1, Page 442.
+     */
+    if (s->secure_impl == ON_OFF_AUTO_ON &&
+        s->stage && !strcmp(s->stage, "2")) {
+        error_setg(errp,
+                    "secure-impl=on requires stage=1 or stage=nested");
+        return false;
+    }
+
+    return true;
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -2781,6 +2814,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
         return;
     }
 
+    if (!smmuv3_resolve_secure_impl(s, errp)) {
+        return;
+    }
+
     qemu_mutex_init(&s->mutex);
 
     memory_region_init_io(&sys->iomem, OBJECT(s),
@@ -2807,6 +2844,54 @@ static const VMStateDescription vmstate_smmuv3_queue = {
     },
 };
 
+static const VMStateDescription vmstate_smmuv3_secure_bank = {
+    .name = "smmuv3_secure_bank",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(features, SMMUv3RegBank),
+        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
+        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
+        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
+        VMSTATE_UINT32(gbpa, SMMUv3RegBank),
+        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror, SMMUv3RegBank),
+        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
+        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
+        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
+        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static bool smmuv3_secure_bank_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->secure_impl == ON_OFF_AUTO_ON;
+}
+
+static const VMStateDescription vmstate_smmuv3_bank_s = {
+    .name = "smmuv3/bank_s",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_secure_bank_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
+                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static bool smmuv3_gbpa_needed(void *opaque)
 {
     SMMUv3State *s = opaque;
@@ -2861,6 +2946,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_smmuv3_bank_s,
         NULL
     }
 };
@@ -2893,6 +2979,13 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
+    /*
+     * SECURE_IMPL field in S_IDR1 register.
+     * Indicates whether secure state is implemented.
+     * Defaults to auto.
+     */
+    DEFINE_PROP_ON_OFF_AUTO("secure-impl", SMMUv3State, secure_impl,
+                            ON_OFF_AUTO_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 8cd2edc3412..9b533b9a99b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -81,6 +81,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+    OnOffAuto secure_impl;
+
     /* SMMU CMDQV extension */
     OnOffAuto cmdqv;
 
-- 
2.34.1


