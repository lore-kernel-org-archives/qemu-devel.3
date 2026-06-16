Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43751CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFF-0005qJ-FD; Tue, 16 Jun 2026 15:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7x-0004V1-AO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7q-0000wj-0D
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so1523615e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636815; x=1782241615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/PbbrDXH+b4CwM0ZMVh7ZRRPi4k/+m03KAIQLjS5GKw=;
 b=mAbr0daiXKqvF3JomDC6nqAmN9coDctITWilaLeoABBsZMVf8SISEQt3gSahM1nTZ8
 u4oUh56yMrW8gqwgYRyQOo3rDTkhG6Gs6z03gPBL4IfaavWUV7NV5NbSseYWXi7WziXg
 DoE0C5Qx2hat74kRV24EVJCgcVsu7IIMR4tf2ntEARbcZ/ZRJZTgT4JLnrbp7aWlIaep
 B59S3Eikcz5JjCJT654Dz/e/+A1pg5F4URwJsBY0tlEVeSTCAl+Gvi/NF2/kLgvLnbFB
 Mn9RWcE6TvRWZM5lBTdPvj5ba1U0lTz1ynG+YvJYAc4gpHoU4VHf1UZgaQm2w8mYeWtb
 9a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636815; x=1782241615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/PbbrDXH+b4CwM0ZMVh7ZRRPi4k/+m03KAIQLjS5GKw=;
 b=E4vFODXPyghFolvNVY9sgMpP72MBqtbnXSip63UtFh/Tyf6ffCc2rb918pqscVu9eR
 16u91TZNkqY+RxvXJsB3tEBNEKDH1mudWLQGpCFTolFpmXvplJ/EM4qMxsN1riHE/yDD
 /YQe//ejTcGHYkMsbBBQ5kk7Z0Z5crJMKiIB3RuUwie6gOXMk6p8WUs97UA2gZd+VY8R
 zt4aGBnhiCpUx8qsiFdc0RxSvEA/C+QdwdiP2SXzXXssdsyF6R0GKFlCj+Kjoo/Z2ayM
 VEkFT98NXe8EeB3VPuxhLl2ba+Zz5l5wxibqd4f3wZt69q+82X+Wd5XyK2ayqBksDj+w
 HAnw==
X-Gm-Message-State: AOJu0YxOb7eyuwNzON7cXC7H5Yg1b4qcTXC19vAmTUqNp+Fyskw/WZr3
 cM/mxidpep/Hi6brB7Ml95+vppKZxWvGkXmZeX+tvZDZcOnppMBHyDEcL/FPGAnMlv03963Y8l0
 rTgGu
X-Gm-Gg: Acq92OGnmK4De5pTMcITM3eRMa/KtcXt96leyIC2VOlYOkh5shLqWLL9DqEI0G/Mo+6
 Pt5NSUhv8AI8WMJ5sz5H3yPoDDi7zP8OGjNVUnFyZdU8b7RbmP/WKkzXXZb9xEAuy1FaqtA2MTg
 4GYkgGQzRp7ZcMI0nQhGmtSuGLHCQJCJxzq+FSb1cYSh56ycuP7jaGw1sKP3kMBR3L1ne14T+yZ
 Fzt1EJFnRodpUvJlZ1xqSez1lDI9uHYCLIUecGrqN+8QaQgVV2Tz1fAiOZmSwniEMdWjYRIkkY4
 53jhlqt8BFSdtPBlVtvC2lS0HoGQo7gtZ/cvY1bCtP5cm4XtUFfbxT8whXJdbuip2ml7jnx8k8I
 MRkJ0cG1L7kQ0pLSTmTqgOgmMfQf/8mMcQ6en3rYWaFZriIcLdHv1PaYcOvt7bsJ3uYUdFDskxW
 2QkS3XJH5NsOG2huckGgnFh2F97s89DPySpv1xwIWzOEbog5Gp1dqHlixqsxU0/Cg22MrtQow9q
 fml8xbB1urQs1KBJq5r7u9e/Zfb5Jb6XYQ/z7Dmy+Q=
X-Received: by 2002:a05:600c:6c10:b0:490:55d9:149a with SMTP id
 5b1f17b1804b1-4922fb14703mr68476865e9.18.1781636815432; 
 Tue, 16 Jun 2026 12:06:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/61] backends/iommufd: Update iommufd_backend_get_device_info
Date: Tue, 16 Jun 2026 20:05:48 +0100
Message-ID: <20260616190639.3462006-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The updated IOMMUFD uAPI introduces the ability for userspace to request
a specific hardware info data type via IOMMU_GET_HW_INFO. Update
iommufd_backend_get_device_info() to set IOMMU_HW_INFO_FLAG_INPUT_TYPE
when a non-zero type is supplied, and adjust all callers to pass a type
value explicitly initialised to zero (IOMMU_HW_INFO_TYPE_DEFAULT) when
no specific type is requested.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-2-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c    | 7 +++++++
 hw/arm/smmuv3-accel.c | 2 +-
 hw/vfio/iommufd.c     | 4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 410b044370..8c3a981392 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -390,16 +390,23 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
     return true;
 }
 
+/*
+ * @type can carry a desired HW info type defined in the uapi headers. If caller
+ * doesn't have one, indicating it wants the default type, then @type should be
+ * zeroed (i.e. IOMMU_HW_INFO_TYPE_DEFAULT).
+ */
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, uint8_t *max_pasid_log2,
                                      Error **errp)
 {
     struct iommu_hw_info info = {
+        .flags = (*type) ? IOMMU_HW_INFO_FLAG_INPUT_TYPE : 0,
         .size = sizeof(info),
         .dev_id = devid,
         .data_len = len,
         .data_uptr = (uintptr_t)data,
+        .in_data_type = *type,
     };
 
     if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 06dadf9cc7..163d3e7279 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -176,7 +176,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
                            Error **errp)
 {
     struct iommu_hw_info_arm_smmuv3 info;
-    uint32_t data_type;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(hiodi->iommufd, hiodi->devid,
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df148a49a7..495a59cc2e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -353,7 +353,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     bool viommu_nesting, viommu_nesting_dirty;
-    uint32_t type, flags = 0;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT, flags = 0;
     uint64_t hw_caps;
     VendorCaps caps;
     VFIOIOASHwpt *hwpt;
@@ -948,7 +948,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceIOMMUFD *hiodi;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
-    enum iommu_hw_info_type type;
+    uint32_t type = IOMMU_HW_INFO_TYPE_DEFAULT;
     uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
-- 
2.43.0


