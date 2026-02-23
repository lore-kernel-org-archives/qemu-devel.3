Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BBBEC1111
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKY-00027b-V7; Mon, 23 Feb 2026 12:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKW-0001zr-Sm
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKT-0000At-U8
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480706554beso55472865e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866160; x=1772470960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YSGaWkW1wD7oBj2WDkS2uPTd2Xxikc7+tsPaDDJCviE=;
 b=pMha7Ny67BcPFXfAfgWBLy7dWoNW5YIt5zQeAom6qxg0g/WMzBLnyNivWVNoHf3xDU
 BfsdhaWe2/IGtzpv+1Fuptgedq38iAX/Cs07ppgd1BgdnPauGgy/u0v2fhJWQBzxmu8F
 os6YzXqqumrF6VTGsK0/MtYdhQ3bKEC7PO6rMA3ujzMoceXjnuCfwbZ6o09aE1cFbZuQ
 hNXFYDSEucr+D3zrMD2+SptMiJ9TpKyCYAhfnZw0FQONVL73fcCTKTjCnxb9/ITMqyeO
 RKKeNwY8B9dusSIL4uuyErqhIPSULE76Bzbd/nJAA7ofmMe7KemYkYBaNtV5Wf5aAY8g
 vfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866160; x=1772470960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YSGaWkW1wD7oBj2WDkS2uPTd2Xxikc7+tsPaDDJCviE=;
 b=RYJg8altDM9OqYaIyaPVS/rnL6iVUb6Cj+dYwgYKQVRSZSfHQqqJ/QTnQdJDQM0Yr+
 B5hSd3Ilgrk3zVlYTUt/MNXAFz+XH0YA9RPoTpHwK+79WpWeVmNk+2Yr3/kW1kt0gvgS
 L1rBZEaRz+4UPiqYALZC2qaN1/l/6bRuO7ubHEivJqYkx1yRbld9vGns+mNuYgbot437
 IJ756q/rR0tfYMiwijKo2SUOfLAHwkK9LTClJo0DIzlhukpte65LyyXn/H+q6doKyrdp
 SBE1zneJmoR+1FrYSojhk2YHcVU54ZHN34aivOwlogcqq3gLvNmW44NakUzC9ZsNL06s
 JkKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpTGegKjp/v2hokMb0UylsvYB9gkpYfW40gRPqjfa0T81jaaqoZ468SG1MQ/FyId00s/Rlyc2DcO3L@nongnu.org
X-Gm-Message-State: AOJu0Yz7YOJMcdebJHqsCzSgPt3nk0nonPvXZgYCeOM/j2/r8BtA/455
 fu1bl7nmIX8gnrq64wrWTjAeYbmU0Xsrj7bn2TBuW232yZVZN0XXW4+1ycwgOEuDTkHs5cZBew3
 7yli3
X-Gm-Gg: AZuq6aK7oL4JjnPuAEnlX7JLfglNGDpYEN11ISRS8SJKI2GnywqMgDYAVOQpbkMJesb
 H2EFw2DeZ7wYmK45OcTRac+3yFPYc4DBxzrjry3w0xBV6rikukEGc4EztdGI5umA3krAabMF63j
 /2yLdkrQOYBdXA2VLrUcbBs/LsHOYd2NeA+3OQr1q5G6nsDEt6GQkHFabngqwR8mR4e9aPwem2/
 tsaIYLiOMt55qnx3l6zlx5/dwepyklLxntdUW27Jzbgs5Un1EvZ/AoUrtjeBSPXxlrWiGn0sA2N
 KdUNPW4PaajOBauK8zZ8XqyqfAm8YWnYplC1Qmxeb8Ee8olHDCRvgYOd3Q6pFHeDnZm5NdME6Wj
 sKPMfZpN3xtxspFYOq5Xz8wJFzs3dKwA7Yh0U/bcQlOzjTDTbctpZrbwkrDDeUlGI9SC5tP7yxz
 mX/y3qUQFv9VC2RKIjpy1DQjJ5KJClFIt3XiKTqljqE4XzlWGJVnKe9Hotn8y6oXIaGPEziKBb+
 wRVRl19Q9SuE7WIOOINeKXwQcdZ1YM=
X-Received: by 2002:a05:600c:3590:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-483b427b0ecmr46929795e9.32.1771866160236; 
 Mon, 23 Feb 2026 09:02:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 22/65] hw/intc/arm_gicv5: Create backing state for SPIs
Date: Mon, 23 Feb 2026 17:01:29 +0000
Message-ID: <20260223170212.441276-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The GICv5 allows an IRS to implement SPIs, which are fixed-wire
interrupts connected directly to the IRS.  For QEMU we want to use
these for all our traditional fixed-wire interrupt devices.  (The
other option the architecture permits is an Interrupt Wire Bridge
(IWB), which converts from a fixed-wire interrupt to an interrupt
event that is then translated through an ITS to send an LPI to the
ITS -- this is much more complexity than we need or want.)

SPI configuration is set via the same CPUIF instructions as LPI
configuration.  Create an array of structs which track the SPI state
information listed in I_JVVTZ and I_BWPPP (ignoring for the moment
the VM assignment state, which we will add when we add virtualization
support).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5_common.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 28 ++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_types.h  | 15 +++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 751df2001c..8cca3a9764 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -66,6 +66,34 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
 
     memset(cs->irs_ist_baser, 0, sizeof(cs->irs_ist_baser));
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
+
+    if (cs->spi) {
+        GICv5Domain mp_domain;
+
+        /*
+         * D_YGLYC, D_TVVRZ: SPIs reset to edge-triggered, inactive,
+         * idle, disabled, targeted routing mode, not assigned to a VM,
+         * and assigned to the most-privileged interrupt domain.
+         * Other state is UNKNOWN: we choose to zero it.
+         */
+        memset(cs->spi, 0, cs->spi_irs_range * sizeof(*cs->spi));
+
+        /*
+         * The most-privileged interrupt domain is effectively the
+         * first in the list (EL3, S, NS) that we implement.
+         */
+        if (gicv5_domain_implemented(cs, GICV5_ID_EL3)) {
+            mp_domain = GICV5_ID_EL3;
+        } else if (gicv5_domain_implemented(cs, GICV5_ID_S)) {
+            mp_domain = GICV5_ID_S;
+        } else {
+            mp_domain = GICV5_ID_NS;
+        }
+
+        for (int i = 0; i < cs->spi_irs_range; i++) {
+            cs->spi[i].domain = mp_domain;
+        }
+    }
 }
 
 static void gicv5_common_init(Object *obj)
@@ -144,6 +172,8 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
 
     address_space_init(&cs->dma_as, cs->dma, "gicv5-sysmem");
 
+    cs->spi = g_new0(GICv5SPIState, cs->spi_irs_range);
+
     trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
                                cs->spi_base, cs->spi_irs_range, cs->spi_range);
 }
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 2a49d58679..c29eab2951 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -53,6 +53,26 @@
 
 OBJECT_DECLARE_TYPE(GICv5Common, GICv5CommonClass, ARM_GICV5_COMMON)
 
+/*
+ * This is where we store the state the IRS handles for an SPI.
+ * Generally this corresponds to the spec's list of state in
+ * I_JVVTZ and J_BWPPP. level is a QEMU implementation detail and
+ * is where we store the actual current state of the incoming
+ * qemu_irq line.
+ */
+typedef struct GICv5SPIState {
+    uint32_t iaffid;
+    uint8_t priority;
+    bool level;
+    bool pending;
+    bool active;
+    bool enabled;
+    GICv5HandlingMode hm;
+    GICv5RoutingMode irm;
+    GICv5TriggerMode tm;
+    GICv5Domain domain;
+} GICv5SPIState;
+
 /*
  * This class is for common state that will eventually be shared
  * between TCG and KVM implementations of the GICv5.
@@ -65,6 +85,14 @@ struct GICv5Common {
     uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];
 
+    /*
+     * Pointer to an array of state information for the SPIs.
+     * Array element 0 is SPI ID s->spi_base, and there are s->spi_irs_range
+     * elements in total. SPI state is not per-domain: SPI is configurable
+     * to a particular domain via IRS_SPI_DOMAINR.
+     */
+    GICv5SPIState *spi;
+
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
 
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
index 15d4d5c3f4..30e1bc58cb 100644
--- a/include/hw/intc/arm_gicv5_types.h
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -70,4 +70,19 @@ typedef enum GICv5RoutingMode {
     GICV5_1OFN = 1,
 } GICv5RoutingMode;
 
+/*
+ * Interrupt trigger mode (same encoding as IRS_SPI_CFGR.TM)
+ * Note that this is not the same thing as handling mode, even though
+ * the two possible states have the same names. Trigger mode applies
+ * only for SPIs and tells the IRS what kinds of changes to the input
+ * signal wire should make it generate SET and CLEAR events.
+ * Handling mode affects whether the pending state of an interrupt
+ * is cleared when the interrupt is acknowledged, and applies to
+ * both SPIs and LPIs.
+ */
+typedef enum GICv5TriggerMode {
+    GICV5_TRIGGER_EDGE = 0,
+    GICV5_TRIGGER_LEVEL = 1,
+} GICv5TriggerMode;
+
 #endif
-- 
2.43.0


