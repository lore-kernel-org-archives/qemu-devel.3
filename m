Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64689CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZC7-00028W-9p; Tue, 16 Jun 2026 15:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZR-MD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000zB-Rr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49230a567a9so6467395e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636828; x=1782241628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZfK0y90nu3Ld/r6Gi/P+At5Q9uLEC4IcCIzFZn+LBq8=;
 b=fvyVbCbdYcPWSMI1mFeafchv+WiTpBcOTVDQzhI+Cb/uCf+Y9crB75N6Xh04GSCTiE
 fSD4oqRhdEVfUw/ZurAc5Pq1yoPgL7U3VmBK3m4gxNIlHMN38bzJeRK0bC6avXBuUf6G
 4Q3zGRL7VKO07eO2rH5G3lJ5LxEl2BnFq1BL3mgvRWRZnm/GioVXpNZfEyZ0zcU+sDKy
 yOFKfj4vtrPSMFAZW3HAaJLgCY2+8fHa7+PzyrL4aNLpHMGATviSi2KhjFo+h8iNwlqw
 93eWIEXrucsMcrEZtnnpzIPq1yaXlKMCDK5x+xjZhQtnb/Fnf46DipPKs+brE43dA5cM
 QKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636828; x=1782241628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZfK0y90nu3Ld/r6Gi/P+At5Q9uLEC4IcCIzFZn+LBq8=;
 b=GOc9euyICKA1OQExAErkiNUvYjiyxdNqHmTqKurfaLdVeU2pG94JwJsZGOuw/cMC8X
 C9XpnhKV+yp5mpv6xqwcvQo5OgxB3iPRDWNqddoSkt1L+MoBIzNg/qwY0f7OsifeSsdX
 ufWerVgiUtfHg94gLmLCYpT9KBoWN3IYxPLTS4vwMMOXsqDyjBQujEFFJ+0tX2+cd4ti
 k1fM9bGH3Mgfs42bY7oy/qLWYAZF4HA54qaOam6TmyPRZLHuoWkON4dreaAc6qv05ZbM
 OKnyC1iL7DSDOHr2nfRuIU0FDducjDTkWqtHUDmwpo+/Huqu6odu7eBj4iv/juKcS/5U
 x0fw==
X-Gm-Message-State: AOJu0YyfEb0Sr2P5cAL3bFPRSfoGthxIv0lFMdJ+UJDFI0WNlYnBRbQO
 KmDRGdZh9JzEG6rEwi4xjFf4rbownk5Bp6okSrsWAZfGpQgcqgEXJIgfZ6/k0NqoFYqVU9fz2Tq
 c5enT
X-Gm-Gg: Acq92OGeLhiKRYx+WYyAyCktgotFA0Dscug1GRJvgBX1mJWkg9+rkvbYn80K6u88sI8
 74cdUGKON+lCiIy+SiCMPeK/3N1IBtsGt5U9qWOe03ttSry+ls6IIXTD0gjMrSAcMqdJ5OKQND7
 nv3iXZm1QEYYzGyEStAJLFBRYNeGeG75ok2S0MgvsOnBoaczcrbhRLLQx1R4io0FBZvKepctKJe
 sBKQItALhK4u2eOwBDyAWUeDWeqYVE+b9JEqrCX3BQ+xhRardoD7w6iEZWOTiiq+M/O+VP1IvG6
 G33hxmV0iQk8u3qByQO1rmBxBhvVCTObNtQV/Aurl0MW0vtw8n29JTUkobDJSH11r3NMABXazjZ
 RE+wIt96VlSAUNbkL8UvLo1TrT2/9S4hUG0flDxWAhTMHr1RaH7WyEqyNlJMZiv2Xy2ouRrBKUy
 CnTdAve3xPy0jnUZsDsAK62FS0vpM8D+VpM2Qy85xq2rlG4xrN4dUkJIL6G0+2LFWcGI0qZ43+y
 Q6NW62dlMaDVMN1rrqCoyBrL55iAxb3TFzhlkd4QuA=
X-Received: by 2002:a05:600c:c096:b0:490:be9e:fd03 with SMTP id
 5b1f17b1804b1-492333e8f1emr10480435e9.7.1781636828502; 
 Tue, 16 Jun 2026 12:07:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/61] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU alloc/free
Date: Tue, 16 Jun 2026 20:06:00 +0100
Message-ID: <20260616190639.3462006-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
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

From: Nicolin Chen <nicolinc@nvidia.com>

Replace the stub implementation with real vIOMMU allocation for
Tegra241 CMDQV.

Allocate a matching vEVENTQ together with the vIOMMU, since it is
specific to the Tegra241 CMDQV vIOMMU and used to receive CMDQV
events.

Free both objects on teardown.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-14-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 48 ++++++++++++++++++++++++++++++++++++++++-
 hw/arm/tegra241-cmdqv.h |  1 +
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2875affc8d..c1351c8519 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/smmuv3-common.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
@@ -26,13 +27,58 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDViommu *viommu = accel->viommu;
+    Tegra241CMDQV *cmdqv = accel->cmdqv;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+
+    if (!viommu) {
+        return;
+    }
+    if (veventq) {
+        close(veventq->veventq_fd);
+        iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
+        g_free(veventq);
+        cmdqv->veventq = NULL;
+    }
+    iommufd_backend_free_id(viommu->iommufd, viommu->viommu_id);
 }
 
 static bool
 tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    uint32_t viommu_id, veventq_id, veventq_fd;
+    IOMMUFDVeventq *veventq;
+
+    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
+                                      IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+                                      idev->hwpt_id, cmdqv->cmdqv_data,
+                                      sizeof(*cmdqv->cmdqv_data), &viommu_id,
+                                      errp)) {
+        return false;
+    }
+
+    if (!iommufd_backend_alloc_veventq(idev->iommufd, viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                       1 << SMMU_EVENTQS, &veventq_id,
+                                       &veventq_fd,
+                                       errp)) {
+        error_append_hint(errp, "Tegra241 CMDQV: failed to alloc veventq");
+        goto free_viommu;
+    }
+
+    veventq = g_new(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    cmdqv->veventq = veventq;
+
+    *out_viommu_id = viommu_id;
+    return true;
+
+free_viommu:
+    iommufd_backend_free_id(idev->iommufd, viommu_id);
     return false;
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index a5f65a8991..9fc720e96c 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -32,6 +32,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    IOMMUFDVeventq *veventq;
 } Tegra241CMDQV;
 
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
-- 
2.43.0


