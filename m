Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C64CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeRW-00085c-6I; Fri, 16 Oct 2026 05:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xHeRU-00084M-9D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:41:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xHeRQ-00071r-Pm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:41:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so38828115e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792143691; x=1792748491; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QMuWtTbJe6HaHVUeISmXFKSp463/r6hE6STO/fYosIY=;
 b=t/ltPJLLXxkyGuHdZeSw+ITf6Y7oIU6jhD3kXTeoOP+kkVem+U9hetpxAlB+rHJMtz
 uztnxTGE90b8k8QPt18WkbZFO61N0nxTEPemXa95QnvrlcMoO0P6och2W39JH6h2qsf/
 DsTBYCvoOmyJfDqZK9v8hTRLz4GttPNs27cwE36wcjYqN6k1VvkEkqNgB9ItS6F3x8/K
 75vM2/qK8/R+b7LPmjbeAGQTz064E7uP8+//rPtpSS6chHzFJIvGRhJUAeIrJFIztIv6
 8GXgbs6d4b1turfqd+ZoJESjD20Vkhy1tc9TJG+XkJh89oa+DKiNedrS7IVIxVjCzfEa
 KKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143691; x=1792748491;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QMuWtTbJe6HaHVUeISmXFKSp463/r6hE6STO/fYosIY=;
 b=1T2h5hSK6yuaCS0loNV48/rXpsxTv3QJUYEpj+jMobYZ6aQVoSF55BHHmmN3GaqWTT
 HSrmt0LwPvjPl61kXQqfHXp/fF9k7fj0V/b7I1NbOm6+1sCjqIF2ANC70RIvie4iVuXu
 Thvym4avyPQvPOYVt+gr19cedFb0m6N49ohRhQRUKfNqclQQ/C2ce8h+tQnjuJ6Iqxcu
 9fBTh3760esYXdgmty3n8q8ZZ2km6vHhU7ifenW6WylABJOPAtJ9gMXySiXNpetLFEgX
 Wu0sIxBDB0+ENMf/rdzL78+kmTdMljRYyggyjB3u2FQYb1r96NNkNWbwZj/VgHfknVcD
 83yw==
X-Gm-Message-State: AFq9FYK4X+HdUdoBb5aYKYP80OuQ2H3S/21CTcO48YXev40FHFQRjpbp
 ngU62LSApCrwyJ/MgdcTagPIkMEi8lxC6GDwc4hgdf4ibfnOvS+8Ti7uItQRBlwzQv1M3+a2ZiK
 6VGni/Q4=
X-Gm-Gg: AYBFou1Olyk7dL9zpYYTyF7lMOWHx+/7SwodnsoemPWdYrPeIQWt6E95YuucpRw0gYg
 GpufJV7FwgCEqD8dWxEejmJqqjnANNWgiW+xXo284dqd7UTTbYAVbCV4dUHuWexzh36Jfq89Uh6
 JlF/upedkgSAPpxx2HS1ZaDa7ajpmV1KCTyeC8AHScDx0ZzIEb70NvQTIBRNu5hME/7RvM384SX
 0vHSnKuq9/qtXiq5FJ8Aur5PfBN0AEbrCRsQ/4B3RMOoaTB++8eqw1XXh3dhmrIffCRmIFxmLiq
 XCqG4MUKT9Vavm0rd2bIjeQO5buraw75XLf/wPZ0i0zR0z3YQwUyNqwpzke3TolIegfUSHNw68y
 EaaVB61/mF0XjBG+m5W/VsPfx6avvzwn4N2U3xN1WyEHlG+vUEELiP8cpSiXMXdrl8rP8sPfifQ
 ttsB222TaVcoNlv4IoV5bvvKUEYjP8AJmwENxysZlhWb8bvZYTArlwqUDtrFZegkyLKfsC2Y7FK
 g==
X-Received: by 2002:a05:600c:154c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4a18e4a9159mr460498265e9.19.1792143690985; 
 Fri, 16 Oct 2026 02:41:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:8f73:128f:8f43:e3ec])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf05009csm28649385e9.10.2026.10.16.02.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:41:30 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 16 Oct 2026 10:40:51 +0100
Subject: [PATCH 1/2] hw/arm/smmuv3: define Root registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-jmac-smmu-root-registers-v1-1-e78e8879d347@linaro.org>
References: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
In-Reply-To: <20261016-jmac-smmu-root-registers-v1-0-e78e8879d347@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Adds all the non-optional SMMUv3.3 Root registers. These registers
do nothing at the moment, but RW registers can be written and all
registers can be read.

Based on original work by Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/smmuv3.c                | 229 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3-common.h |  22 ++++
 include/hw/arm/smmuv3.h        |  13 +++
 3 files changed, 264 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ed19536a4d..9d9bc2601b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -316,6 +316,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
     smmuv3_accel_idr_override(s);
+
+    /* Initialize Root bank */
+    s->root.idr0 = FIELD_DP32(s->root.idr0, ROOT_IDR0, ROOT_IMPL, 1);
+    /* Set this to 1 when SMMU Realms are implemented */
+    s->root.idr0 = FIELD_DP32(s->root.idr0, ROOT_IDR0, REALM_IMPL, 0);
 }
 
 bool smmuv3_ats_enabled(SMMUv3State *s)
@@ -1769,6 +1774,111 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
     return MEMTX_OK;
 }
 
+/*
+ * Check we are from the Root PA space to read from or write to the
+ * SMMU Root register area.
+ */
+static bool smmu_check_root_access(SMMUv3State *s, MemTxAttrs attrs,
+                                     hwaddr offset, bool is_read)
+{
+    /* Check if the access is from Root PA */
+    if (!(attrs.space == ARMSS_Root)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Non-root %s attempt at offset 0x%" PRIx64 " (%s)\n",
+            __func__, is_read ? "read" : "write", offset,
+            is_read ? "RAZ" : "WI");
+        return false;
+    }
+    return true;
+}
+
+static MemTxResult smmu_root_writel(SMMUv3State *s, hwaddr offset,
+                                    uint64_t data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_ROOT_IDR0:
+    case A_ROOT_IIDR:
+    case A_ROOT_CR0ACK:
+        /* RO registers, write ignored */
+        return MEMTX_OK;
+    case A_ROOT_TLBI_CTRL:
+        /* Optional, not implemented. Present if IDR0.RGPTM == 1 */
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE_UPDATE:
+        /* Unimplemented at present; has side effects */
+        return MEMTX_OK;
+    case A_ROOT_CR0:
+        s->root.cr0 = data;
+        s->root.cr0ack = s->root.cr0;
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 32-bit access at 0x%"PRIx64" (WI)\n",
+                      __func__, offset);
+        /*
+         * Locations not associated with a register (including registers that we
+         * have not implemented yet) are RES0, and will follow RAZ/WI behaviour.
+         */
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_root_writell(SMMUv3State *s, hwaddr offset,
+                                     uint64_t data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_ROOT_GPT_BASE:
+        s->root.gpt_base = data;
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE_CFG:
+        s->root.gpt_base_cfg = data;
+        return MEMTX_OK;
+    case A_ROOT_GPF_FAR:
+        s->root.gpf_far = data;
+        return MEMTX_OK;
+    case A_ROOT_GPT_CFG_FAR:
+        s->root.gpt_cfg_far = data;
+        return MEMTX_OK;
+    case A_ROOT_TLBI:
+        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE2:
+        s->root.gpt_base2 = data;
+        return MEMTX_OK;
+    case A_ROOT_GPCBW:
+        /* Optional, not implemented. Present if ROOT_IDR0.GPTS == 1 */
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit access at 0x%"PRIx64" (WI)\n",
+                      __func__, offset);
+        /* RES0; See smmu_root_writel */
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_write_mmio_root(SMMUv3State *s, hwaddr offset,
+                                        uint64_t data, unsigned size,
+                                        MemTxAttrs attrs)
+{
+    MemTxResult r;
+
+    switch (size) {
+    case 8:
+        r = smmu_root_writell(s, offset, data, attrs);
+        break;
+    case 4:
+        r = smmu_root_writel(s, offset, data, attrs);
+        break;
+    default:
+        r = MEMTX_ERROR;
+        break;
+    }
+
+    trace_smmuv3_write_mmio(offset, data, size, r);
+    return r;
+}
+
 static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
                                    unsigned size, MemTxAttrs attrs)
 {
@@ -1776,6 +1886,18 @@ static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
 
+    if (offset >= SMMU_ROOT_REG_START) {
+        if (!smmu_check_root_access(s, attrs, offset, false)) {
+            /*
+             * As per 6.2.8, accesses in any PA space other
+             * than Root are completed as RAZ/WI.
+             */
+            trace_smmuv3_write_mmio(offset, data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
+        return smmu_write_mmio_root(s, offset, data, size, attrs);
+    }
+
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
 
@@ -1918,6 +2040,100 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
     }
 }
 
+static MemTxResult smmu_root_readl(SMMUv3State *s, hwaddr offset,
+                                   uint64_t *data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_ROOT_IDR0:
+        *data = s->root.idr0;
+        return MEMTX_OK;
+    case A_ROOT_IIDR:
+        *data = s->root.iidr;
+        return MEMTX_OK;
+    case A_ROOT_TLBI_CTRL:
+        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
+        *data = 0;
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE_UPDATE:
+        /* Not a regular register; reads as 0 once update is complete */
+        *data = 0;
+        return MEMTX_OK;
+    case A_ROOT_CR0:
+        *data = s->root.cr0;
+        return MEMTX_OK;
+    case A_ROOT_CR0ACK:
+        *data = s->root.cr0ack;
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 32-bit access at 0x%"PRIx64" (RAZ)\n",
+                      __func__, offset);
+        *data = 0;
+        /* RES0; See smmu_root_writel */
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_root_readll(SMMUv3State *s, hwaddr offset,
+                                    uint64_t *data, MemTxAttrs attrs)
+{
+    switch (offset) {
+    case A_ROOT_GPT_BASE:
+        *data = s->root.gpt_base;
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE_CFG:
+        *data = s->root.gpt_base_cfg;
+        return MEMTX_OK;
+    case A_ROOT_GPF_FAR:
+        *data = s->root.gpf_far;
+        return MEMTX_OK;
+    case A_ROOT_GPT_CFG_FAR:
+        *data = s->root.gpt_cfg_far;
+        return MEMTX_OK;
+    case A_ROOT_TLBI:
+        /* Optional, not implemented. Present if ROOT_IDR0.RGPTM == 1 */
+        *data = 0;
+        return MEMTX_OK;
+    case A_ROOT_GPT_BASE2:
+        *data = s->root.gpt_base2;
+        return MEMTX_OK;
+    case A_ROOT_GPCBW:
+        /* Optional, not implemented. Present if ROOT_IDR0.GPTS == 0 */
+        *data = 0;
+        return MEMTX_OK;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit access at 0x%"PRIx64" (RAZ)\n",
+                      __func__, offset);
+        *data = 0;
+        /* RES0; See smmu_root_writel */
+        return MEMTX_OK;
+    }
+}
+
+static MemTxResult smmu_read_mmio_root(SMMUv3State *s, hwaddr offset,
+                                       uint64_t *data, unsigned size,
+                                       MemTxAttrs attrs)
+{
+    MemTxResult r;
+
+    switch (size) {
+    case 8:
+        r = smmu_root_readll(s, offset, data, attrs);
+        break;
+    case 4:
+        r = smmu_root_readl(s, offset, data, attrs);
+        break;
+    default:
+        r = MEMTX_ERROR;
+        break;
+    }
+
+    trace_smmuv3_read_mmio(offset, *data, size, r);
+    return r;
+}
+
+
 static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
                                   unsigned size, MemTxAttrs attrs)
 {
@@ -1925,6 +2141,19 @@ static MemTxResult smmu_read_mmio(void *opaque, hwaddr offset, uint64_t *data,
     SMMUv3State *s = ARM_SMMUV3(sys);
     MemTxResult r;
 
+    if (offset >= SMMU_ROOT_REG_START) {
+        if (!smmu_check_root_access(s, attrs, offset, true)) {
+            /*
+             * As per 6.2.8, accesses in any PA space other
+             * than Root are completed as RAZ/WI.
+             */
+            trace_smmuv3_read_mmio(offset, *data, size, MEMTX_OK);
+            return MEMTX_OK;
+        }
+
+        return smmu_read_mmio_root(s, offset, data, size, attrs);
+    }
+
     /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
     offset &= ~0x10000;
 
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 4609975edf..a538334066 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -411,6 +411,28 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
 
 #define A_IDREGS           0xfd0
 
+#define SMMU_ROOT_REG_START 0x20000
+
+REG32(ROOT_IDR0,            0x0)
+    FIELD(ROOT_IDR0, ROOT_IMPL,   0,  1)
+    FIELD(ROOT_IDR0, BGTPM,       1,  1)
+    FIELD(ROOT_IDR0, RGPTM,       2,  1)
+    FIELD(ROOT_IDR0, REALM_IMPL,  3,  1)
+    FIELD(ROOT_IDR0, BA_REALM,   22, 10)
+
+REG32(ROOT_IIDR,             0x8)
+REG32(ROOT_CR0,             0x20)
+REG32(ROOT_CR0ACK,          0x24)
+REG64(ROOT_GPT_BASE,        0x28)
+REG64(ROOT_GPT_BASE_CFG,    0x30)
+REG64(ROOT_GPF_FAR,         0x38)
+REG64(ROOT_GPT_CFG_FAR,     0x40)
+REG64(ROOT_TLBI,            0x50)
+REG32(ROOT_TLBI_CTRL,       0x58)
+REG64(ROOT_GPT_BASE2,       0x60)
+REG32(ROOT_GPT_BASE_UPDATE, 0x68)
+REG32(ROOT_GPCBW,           0x70)
+
 /* Commands */
 
 typedef enum SMMUCommandType {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d39fe8850b..e2708e13fe 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -34,6 +34,18 @@ typedef struct SMMUQueue {
      uint8_t log2size;
 } SMMUQueue;
 
+typedef struct SMMUv3RootRegBank {
+    uint32_t idr0;
+    uint32_t iidr;
+    uint32_t cr0;
+    uint32_t cr0ack;
+    uint64_t gpt_base;
+    uint64_t gpt_base_cfg;
+    uint64_t gpf_far;
+    uint64_t gpt_cfg_far;
+    uint64_t gpt_base2;
+} SMMUv3RootRegBank;
+
 struct SMMUv3State {
     SMMUState     smmu_state;
 
@@ -80,6 +92,7 @@ struct SMMUv3State {
     OnOffAuto cmdqv;
 
     Notifier machine_done;
+    SMMUv3RootRegBank root;
 };
 
 typedef enum {

-- 
2.43.0


