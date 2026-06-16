Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30194CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAP-0006AI-8Q; Tue, 16 Jun 2026 15:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZJ-C0
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ86-00012A-KI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso37691395e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636839; x=1782241639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v/w08YsGzSbVzz3Gzi7V2p2Sw+AOEyN59cWjZhnh21E=;
 b=LtAR3SC9CP8D9Pf0vSKvFcF2KxzPiL+5r3m/xu5G+l2muPyWWYtio+FHokRpQ6OHI+
 NCTQkniS4GQ3INsSm/GjTO1W3DULJYr1JPsDmwjDcZ5cfc+Jp6TwtTE2CLAbCPQYDWzF
 jJqS/kRGMO/FhEHxDFCCE5XW8pPMpGxGi0i2B3wEG624MFNNMXLrpvKQ8gOyHVJXjg6A
 6MJZ0Nf2j/xdHaC9NdzAA+0lR/4pE9dMwquEkhIZr/ZZJR878vGHmOfApX12J/0xUa03
 CcXCVSGgCDWWDFO2Emw7ay9BDlNcGNqXxHMq6fKHiw/tqzesEiWmXwhSxe331bVeLf3D
 +cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636839; x=1782241639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v/w08YsGzSbVzz3Gzi7V2p2Sw+AOEyN59cWjZhnh21E=;
 b=LSTybbUTX3nJazQ3Sx+ZSOGVud4GY208x7vaQtZFlyUzmFcUJVuZ9ZhAYtdn8CFf6N
 iQBMR/o9IAMHiET6DfGpznlKt095d+P0Mmmp/eRj5QXQaI4M/6mIQQmJXikv4tT3dBs4
 3RjFhvx7dCnBBzTqdHaD1Rr2o8vJSkDVhNrgy8lt7ld7cN5YACzcGcT3p50iuwbK3rAK
 2bwkqulma/NWYV8x2FRLHhXMDov4FyS7/4cUIbLjDC9VVb6B5kBWMI4TBc9kDSz8Fb83
 EkFeD8zUg8ivuHRO6UfrYf5Y4xcqxYsWMM3/GG53m7bxHGVsxg0ipVSNT+a0n312sZ8w
 XPnQ==
X-Gm-Message-State: AOJu0YzZMnIxwWHWGZCWpC4EKoTlfqJNv5brD/1zpotZHRLaaKlWriKG
 LjSaC+ck7H3GHf0rfiTVIbRkXKqm7kla6qtD6yrzhW4M1SutDGSRYcwTBei/cyHQ8FCmXOxqFrU
 n4t32
X-Gm-Gg: Acq92OGcw2E7x7pd22ORgmoHQhTpVjVh9ukNNAw0N7gjzl6U1B5l14RpqCArMLeadwv
 7S4nzajX1C0eq8sR+/y5/5mUNoOBQWC0dQBLGU94iStHgPv++D9eUizVVvGwdoazwjWZgy6Zzop
 +dHAjkRfhbOsgqhxT5LFSDQY4eOFlWj9n9AQ3QTs6aD5Qjlo3mwqj8dQQvjITPuvNnQHU6WrRFT
 gKZCHv/wRhSTvO8RuAwCG31sm9Xyz+f7hbt79sj8fU7FJDsYeUrtmzDcaNUGKUOdT++PSzLGABh
 JpqQWwWQXLNsHN+dRDL5zkpfZuwuIP5UYtdgkv0n9ozr8gjGKvVO542jjY2gYNidE4jalWjnpBb
 B7I9nWBRpXhxpJDrTpiKiIstjMV2r9IFRXwptw1ACyQM5I7A8gKk91s5lCloz28FJzLz2Cyaoq0
 EdNjErqhPaviPxvmp5c2N/IryZIqh5kuYOELxBenaZcASt26qCvA/eTde+yAJFRDhsztJlLjdY6
 PAV9/2Z01jk+R+Dls8CqdvDYlsTUcN3
X-Received: by 2002:a05:600c:6308:b0:492:1e36:8c72 with SMTP id
 5b1f17b1804b1-492333e2433mr11717775e9.37.1781636838897; 
 Tue, 16 Jun 2026 12:07:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/61] hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV
 errors
Date: Tue, 16 Jun 2026 20:06:10 +0100
Message-ID: <20260616190639.3462006-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Install an event handler on the CMDQV vEVENTQ fd to read and propagate
host received CMDQV errors to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-24-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 63 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events     |  1 +
 2 files changed, 64 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 7264b4bfa9..ff0fcd1e66 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -12,6 +12,7 @@
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
+#include "hw/core/irq.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 #include "trace.h"
@@ -729,6 +730,51 @@ out:
     trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
+static void tegra241_cmdqv_event_read(void *opaque)
+{
+    Tegra241CMDQV *cmdqv = opaque;
+    IOMMUFDVeventq *veventq = cmdqv->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_tegra241_cmdqv vevent;
+    } buf;
+    Error *local_err = NULL;
+
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
+                                          &buf, sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
+        return;
+    }
+
+    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
+        cmdqv->vintf_cmdq_err_map[0] =
+            extract64(buf.vevent.lvcmdq_err_map[0], 0, 32);
+        cmdqv->vintf_cmdq_err_map[1] =
+            extract64(buf.vevent.lvcmdq_err_map[0], 32, 32);
+        cmdqv->vintf_cmdq_err_map[2] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 0, 32);
+        cmdqv->vintf_cmdq_err_map[3] =
+            extract64(buf.vevent.lvcmdq_err_map[1], 32, 32);
+        /*
+         * CMDQV_CMDQ_ERR_MAP and VINTF0_LVCMDQ_ERR_MAP are distinct
+         * registers (different MMIO offsets). With only VINTF0 exposed
+         * they carry the same data, so mirror.
+         */
+        for (int i = 0; i < 4; i++) {
+            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
+        }
+        /* Set the VINTF0 bit in VI_ERR_MAP_0 (only VINTF0 is exposed). */
+        cmdqv->vi_err_map[0] |= BIT(0);
+        if (!(cmdqv->vi_int_mask[0] & BIT(0))) {
+            qemu_irq_pulse(cmdqv->irq);
+        }
+        trace_tegra241_cmdqv_err_map(
+            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
+            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
+    }
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
     SMMUv3AccelState *accel = s->s_accel;
@@ -740,6 +786,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         return;
     }
     if (veventq) {
+        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
         close(veventq->veventq_fd);
         iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
         g_free(veventq);
@@ -759,6 +806,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
+    int flags;
 
     if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
                                       IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
@@ -784,14 +832,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto munmap_page0;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg(errp, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
+        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     cmdqv->veventq = veventq;
 
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
     *out_viommu_id = viommu_id;
     return true;
 
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(idev->iommufd, veventq_id);
 munmap_page0:
     munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
     cmdqv->vintf_page0 = NULL;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index a8dcbc82db..dbed00afbb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 # tegra241-cmdqv
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0


