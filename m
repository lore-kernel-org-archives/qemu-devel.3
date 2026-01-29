Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D482D6B087
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbD-0001zv-1H; Thu, 29 Jan 2026 11:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUan-0000Xt-Jb
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:02 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUal-0006n7-Ei
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso10072505e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702997; x=1770307797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HyUsZEQsdn3K2mNkG80GmLcIjlyjULxDGM4SHbQzwtI=;
 b=eFyULnozWeeAeLy2AE07oSH869ESTIib4IpSyEaxvs56xHTUiaX2nraBlTnK6aJqa4
 AS7n/1fEdeQLiJWGZ5hW9vf62GtzimtEtEOkpg2B0yRdN3uUk8cY9DoiQcjX48T1u662
 wJbBIMgcnBueExJMCfwwh11IluUAlGs7A1EVRqY8TxGA50DGJoDxO6zCT9qs9d8Dr1ql
 bvB+OxsaTGw97wQIJqoMdKXg8kaZT/1DicOxHv5rrzJT4L2uSiFuyrEcGcE7QYiB8iSB
 TkaRxol2jjbEZKap/bPmcMLHdS+TzKYgEICq4E75nm0HDkFydlz90fj/lXRCF7P1jfGz
 XQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702997; x=1770307797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HyUsZEQsdn3K2mNkG80GmLcIjlyjULxDGM4SHbQzwtI=;
 b=UguGk/hYkBzj7al8ZTmDZQyrkLGXKGUZ1N9iHA4Y6D9pURCKVpOdty2P28QFjHKjf1
 Lz+6gibL0WSa3zzo+djwNM1qHkp4TeO7cmrQYmqwajZy/JQMsXA5Qebc70CYxnh2T41I
 YjvvumyRy8+5Uod1Ft1qUxyZp9zIbYG1miFs1GqQLJcM6YOcHl2tkL2fV1WIZ8o4pj+Q
 X42O/5fbLc3iBU1byaNYXBEQmbMxAo4NN09P4vMFM1ceYOr1WmdcNbiSZm1hgVLWz6BW
 r374Yv4fX9cRtx4CbuzM+sqosFenVIT6fydsxq4tkYmiPw9PG29BJXbWNChJiTTMRTg9
 hMrA==
X-Gm-Message-State: AOJu0Yyc7mOofaNufr7a9Gl2gGPEkePPsX3NpZmKzUb0x9GFgoRyDL78
 1S9/mI1S4DzZPz04xMy6dQGzHUkvWSmBKbNplu3LC/4qGcjTHX1o6u+9sMT+stQhhXK74P02mSz
 TUNzO/Qs=
X-Gm-Gg: AZuq6aKlNVTYW0lyghKm0hcEuLj1PQNQ5OnpP4WmD1GnuNzkQkAqJqpCmRVg3wEB4i8
 oFEjxoMUlTtPk1fbIwuvpPd3Je0NfAfyxHMqVtrfXd/J7jeooHm9LEiCAcInB/6GF6D15vHl6eN
 h86emiqeolJmarwpZqwUGd4UM/jMYJmwijNGmrwWCtLo32kqgj8TlKvduP6dm2C05Z0/MW9WnsR
 0e3wF06V35pE1AHBEbG6it8CoHTsPCilLh56snU6fE0+U9RkqKC5e4UO6CX5UQyNBDCSNPNswkQ
 vYVo1BN9rgiawMYPdNGfwtDR3Xq0KHRwY9BViADC7R1xIgeDseO8I4iezbvumyblabVZ+gRw8CM
 897vk50zPoRktyctwkg5zoAMcF9xyP72uPYCKO+sh3LjX2lavMjV8cy3gFqnRzgdgM8lIjZ3OmF
 v44WxzZ7jAcsbbxRYuc9fgrof0Xqo6Uw==
X-Received: by 2002:a05:600c:154c:b0:480:32da:f33e with SMTP id
 5b1f17b1804b1-48069c6978fmr129222925e9.17.1769702997263; 
 Thu, 29 Jan 2026 08:09:57 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/43] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Date: Thu, 29 Jan 2026 16:09:06 +0000
Message-ID: <20260129160917.1415092-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Retrieve PASID width from iommufd_backend_get_device_info() and store it
in HostIOMMUDeviceCaps for later use.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-33-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c                 | 6 +++++-
 hw/arm/smmuv3-accel.c              | 3 ++-
 hw/vfio/iommufd.c                  | 6 ++++--
 include/system/host_iommu_device.h | 3 +++
 include/system/iommufd.h           | 3 ++-
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index e3a3c1480e..9b63d74083 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -389,7 +389,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
 
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp)
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp)
 {
     struct iommu_hw_info info = {
         .size = sizeof(info),
@@ -408,6 +409,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     g_assert(caps);
     *caps = info.out_capabilities;
 
+    if (max_pasid_log2) {
+        *max_pasid_log2 = info.out_max_pasid_log2;
+    }
     return true;
 }
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ea420afeb7..342944da23 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -121,7 +121,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     uint64_t caps;
 
     if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
-                                         &info, sizeof(info), &caps, errp)) {
+                                         &info, sizeof(info), &caps, NULL,
+                                         errp)) {
         return false;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2947e1b80f..131612eb83 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -398,7 +398,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
                                          &type, &caps, sizeof(caps), &hw_caps,
-                                         errp)) {
+                                         NULL, errp)) {
         return false;
     }
 
@@ -939,19 +939,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     HostIOMMUDeviceCaps *caps = &hiod->caps;
     VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
+    uint8_t max_pasid_log2;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
     if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
                                          vendor_caps, sizeof(*vendor_caps),
-                                         &hw_caps, errp)) {
+                                         &hw_caps, &max_pasid_log2, errp)) {
         return false;
     }
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
     caps->hw_caps = hw_caps;
+    caps->max_pasid_log2 = max_pasid_log2;
 
     idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd = vdev->iommufd;
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..bfb2b60478 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -30,6 +30,8 @@ typedef union VendorCaps {
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  *
+ * @max_pasid_log2: width of PASIDs supported by host IOMMU device
+ *
  * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
  *               IOMMUFD this represents a user-space buffer filled by kernel
  *               with host IOMMU @type specific hardware information data)
@@ -37,6 +39,7 @@ typedef union VendorCaps {
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    uint8_t max_pasid_log2;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
 #endif
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 567dfb7b1d..80d72469a9 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
-                                     uint64_t *caps, Error **errp);
+                                     uint64_t *caps, uint8_t *max_pasid_log2,
+                                     Error **errp);
 bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t pt_id, uint32_t flags,
                                 uint32_t data_type, uint32_t data_len,
-- 
2.43.0


