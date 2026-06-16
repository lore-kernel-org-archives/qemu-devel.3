Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2428CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAV-00075B-RD; Tue, 16 Jun 2026 15:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZQ-Li
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000xf-O3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so30451355e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636821; x=1782241621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PYQ8HdK5SkU6BX/BtmWU/KoQEGIEXyhmRcW7vzpl7zc=;
 b=h0wh+SBIXmiWKI/xi3nihv/iI16LPz8wcA0ssPDIYEqu5oQYQ1BJXe/bGwkDvdTq/m
 4LxbWGG/P05Ftqs0uY9HaMsmp91BUjy4R1ActAk0EsDgLL46Xyqnh/3RLRcdXrESPfbK
 BH0f/zOGxTpCzGF9kPVIcAScQg/5LLM2lBsL7Ssp8ACPIbCehyEV/6vuoEynfo+onEG7
 y+iKc4FEAvLU7Z/GqLNy/hLNpfNoB1cqpOjdk3/VwYXkBz3OSZgZVEjtfU33FzTHWkdS
 lKp91D4AghTm/H8fJ76ukJZdkyaVm7z1khGZ9aUUc3ZMk8o1fxPnN/SQZrB6OJ/rUybF
 tuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636821; x=1782241621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PYQ8HdK5SkU6BX/BtmWU/KoQEGIEXyhmRcW7vzpl7zc=;
 b=eeOgmsojduTASLpuxftS7lJAzRaryWvqzk+ahvR5xLSyHQ9MBzbjgNTx7VBnme3vJl
 k4cDYDcmay3jZTWG45Tbo4EwltQPJ8vi8BQrEcd1j5vCzjTHGKecQUdf93Lx7G18ol3U
 XwRzkV/9gr43kUuNcjgF66BPzR0ImHMmU8SuqIONAIqbt7hNfTkpYcIdJMfhv1yWi5PO
 TFdsIxlRnLJzGk+SMf7ZgdUsT1OZaCDX5pYYIfziyXbirXKbtXhR4g7P/c2lTekgKNi/
 /hSAHGIpzlLtNL054VpaUdf5fE33WmnFaBpX0dURRCgLEvfgT2YsyNLA5huCAybSkK8H
 axxQ==
X-Gm-Message-State: AOJu0Yw09IziPmAeIZHLkW0wloJFCHvdoqCgRzuGU0e8eETFcGA6CjEF
 HjxuMfAqaKgiqObFaqcDSKMUJSoVQgdHLfhZwKa7HmuA7E37OY/jSCXwwp3YRGAjJLd616lPA8x
 FNSxv
X-Gm-Gg: Acq92OGZUSUDVTKu87cK7qCnUMfTONxWwR0JLwp2IJpRbXWKDqnOz8NdG9xLPD14lHm
 e+69Z5tqIJjWOa+JSl0fZGZJ9ROGT9Xv+0rMkrSlLaKJrqu2kdBgZSs/Uhvb9+VkbmLJ1IOV6bK
 HJ6AyXp4bXAIdYEY1CYEUGuaFYlY9DW6vixf+cu6QAivgSfvwGmoOkAp/ynhrKVdTsS9gM6FaJA
 fN07F3uMtEj/LvyPMXDnSUWydy5m9Vws7VhLoKz47lh79IZuHEmYERIlYeZ2slxrUuLktsG+DAT
 1pfvDWx01VNpOONn1wgnb4/4XWglDmaLAZDoKhnoFNBGErs5fFFzh1yWyk0P9vREQ7RVrgEwNW2
 H0xUrqHpd6AgNblSSKaIh6452ftbUV2SQN3NwKd46Dvw3kRMshcSqTTjljIUqoQdvGg5Gk7KYNI
 mYlSA/qKWqc9LjbiIh2HnNCNkAJsFXjXXwhpeqNZNnWJ0PDIA4y5+OTc4Cd4jpLlVChAbGqxPiD
 BHsaTJhdj7tYD+u3EPqqFrnM35uvCv1
X-Received: by 2002:a05:600c:3e8e:b0:490:ea8a:32da with SMTP id
 5b1f17b1804b1-492333d6b3bmr11595385e9.26.1781636820743; 
 Tue, 16 Jun 2026 12:07:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/61] hw/arm/smmuv3-accel: Introduce CMDQV ops interface
Date: Tue, 16 Jun 2026 20:05:53 +0100
Message-ID: <20260616190639.3462006-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Command Queue Virtualization (CMDQV) is a hardware extension available
on certain platforms that allows the SMMUv3 command queue to be
virtualized and passed through to a VM, improving performance.

For example, NVIDIA Tegra241 implements CMDQV to support virtualization
of multiple command queues (VCMDQs).

The term CMDQV is used here generically to refer to any platform that
provides hardware support to virtualize the SMMUv3 command queue.

CMDQV support is a specialization of the IOMMUFD-backed accelerated
SMMUv3 path. Introduce an ops interface to factor out CMDQV-specific
probe, initialization, and vIOMMU allocation logic from the base
implementation. The ops pointer and associated state are stored in
the accelerated SMMUv3 state.

This provides an extensible design to support future vendor-specific
CMDQV implementations.

No functional change.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-7-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 87fecb5c68..b45f25ad03 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -10,11 +10,44 @@
 #define HW_ARM_SMMUV3_ACCEL_H
 
 #include "hw/arm/smmu-common.h"
+#include "hw/arm/smmuv3.h"
 #include "system/iommufd.h"
 #ifdef CONFIG_LINUX
 #include <linux/iommufd.h>
 #endif
 
+/*
+ * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
+ * support multiple VCMDQs with virtualization capabilities.
+ * CMDQV specific behavior is factored behind this ops interface.
+ */
+typedef struct SMMUv3AccelCmdqvOps {
+    /**
+     * @probe: Mandatory. Vendor-specific device probing.
+     */
+    bool (*probe)(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev, Error **errp);
+    /**
+     * @init: Optional callback. Initialize CMDQV hardware.
+     */
+    bool (*init)(SMMUv3State *s, Error **errp);
+    /**
+     * @alloc_viommu: Mandatory. Allocate CMDQV viommu resources.
+     */
+    bool (*alloc_viommu)(SMMUv3State *s,
+                         HostIOMMUDeviceIOMMUFD *idev,
+                         uint32_t *out_viommu_id,
+                         Error **errp);
+    /**
+     * @free_viommu: Optional callback. Free CMDQV viommu resources.
+     * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
+     */
+    void (*free_viommu)(SMMUv3State *s);
+    /**
+     * @reset: Optional callback. Reset CMDQV state.
+     */
+    void (*reset)(SMMUv3State *s);
+} SMMUv3AccelCmdqvOps;
+
 /*
  * Represents an accelerated SMMU instance backed by an iommufd vIOMMU object.
  * Holds bypass and abort proxy HWPT IDs used for device attachment.
@@ -27,6 +60,7 @@ typedef struct SMMUv3AccelState {
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
     bool auto_mode;
     bool auto_finalised;
+    const SMMUv3AccelCmdqvOps *cmdqv_ops;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
-- 
2.43.0


