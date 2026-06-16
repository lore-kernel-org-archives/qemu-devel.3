Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE24ACD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZC3-000266-1e; Tue, 16 Jun 2026 15:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZU-NU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000wv-OR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so34607795e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636817; x=1782241617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cpvEVVFmObCOAVZYrBljFN84sP1hXmtFa5bYh03siP4=;
 b=Oq923evNeMXZRfLLoeKc5ggHmWibOcv0lhMb5P/ztgzdA+1FLizAEdGLY7/FIcD9o6
 O/mCily33YNlOqVYPj8yafwjU+t4aoxkSS96m914dnPbzlCBJR4TvfObZQxRGDhJ3Y9A
 2gJUZiPmZ2dIZkpQp+wg4JuGjbxUciecqvgICHsNF0UhgjUOmc5FaRIWy7g4rCSqysWn
 nd2F/j5kK2M7gYZqXxpGFdh87qkpOwFTF+ePj0FpW0mWXV1B34Gb0EFsXQGyBPDh6pYz
 mGcIS6SHw4WgsfeEig4n099bP+py4hCNV+DFMb1abS21dP9L5pnpl3z96w8M9VTySKJP
 YAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636817; x=1782241617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cpvEVVFmObCOAVZYrBljFN84sP1hXmtFa5bYh03siP4=;
 b=auuQ5LZJVxRS0PqKzEhLckAdObmFn/2P9bGjsdxMf6aKrgUwynCYnmTPwpWgmqDMmN
 6/3zkMTvw0AP+q/SknBkksczCGG/eqIu27LzPU2ralYjU60R0MQZuTskqExoJJxr4u3r
 8aJnD9hPE6U0oYLL6uFjIt3TOWggkeA3BjJ/h/gJLdYekWoZBJBu/pAWVHshUpsxinDQ
 vSsuXJZr+vlF4QzdlVP510rtn2kkNhChdmEylQh+7tpod0iSdMybCtnHp8IcxThPLC2e
 A7U5LtDXyQlMtKx0X2jA7tqZ6C056P6s2u8BJBPKSqFqlzUQ4dtzeutucj1dovFuFyiD
 0Bxw==
X-Gm-Message-State: AOJu0Yz4c0pPuDAT/pvUz/CHlCVSp/vNOW4XgjUlf7KHdB1DMk0pYNjY
 ifSxAmzNvVeetemacGBTASgFWeLWTgwbL2SlnT8Et+lx/rfUqsTwHhZD24t5gSnCIDxYi7DCLlP
 K7YCD
X-Gm-Gg: Acq92OEBp+WHJQg0yuAckk86OuB2TI1M1hsLuLM8NYvixZhUKCFJYre5gq/s7Yg72aK
 LxiZuEl+hxKsE7Kr8QaUmd4KlzSsBXjN0NiWk7eK9Og203WOSiWcIjxXDxkqugOOvBD7e64Okjy
 d5D62unGIg08rgnMk98MLWKJSFfX8eVhLpbwd2sKPu2QNKUFatXwwga1c87dSgD5SG91r3GsGRu
 MMivQF+T5nt5L/oVdK66nZA2528iEYae6cZ/+TCeTo4MRoew7ka4lh536PJ3RVGsx4eupRQ8gC1
 7SwAzX9MsYKCHzsOXMd+zpUY0spNG3Le//0/bY2HdUKe5wvycNCRvZZz4o+KJzY334NCwU+RDLT
 wG7ANq8emMTP6Bbl3TdOhEsZ7sU0PzdBnT7Eb1Hy3VX9jNQBuV30xz8PXk/fukBoQ82JqxWD4v+
 F2PejjdA7fQg3sD5dwUinZyDppe+gfT0c4OFNDeBN3jMok1AhfKXzAoPiL892g4dwzQJO+UlKZ0
 kDOoj7d+OOZnw4RjfI6K81V4/yGFlCO
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id
 5b1f17b1804b1-492333e2b9dmr9219465e9.36.1781636816592; 
 Tue, 16 Jun 2026 12:06:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/61] backends/iommufd: Update iommufd_backend_alloc_viommu to
 allow user ptr
Date: Tue, 16 Jun 2026 20:05:49 +0100
Message-ID: <20260616190639.3462006-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The updated IOMMUFD VIOMMU_ALLOC uAPI allows userspace to provide a data
buffer when creating a vIOMMU (e.g. for Tegra241 CMDQV). Extend
iommufd_backend_alloc_viommu() to pass a user pointer and size to the
kernel.

Update the caller accordingly.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-3-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 4 ++++
 backends/trace-events    | 2 +-
 hw/arm/smmuv3-accel.c    | 4 ++--
 include/system/iommufd.h | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8c3a981392..c745dbd2b1 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -463,6 +463,7 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
 
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_viommu_id, Error **errp)
 {
     int ret;
@@ -471,11 +472,14 @@ bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
         .type = viommu_type,
         .dev_id = dev_id,
         .hwpt_id = hwpt_id,
+        .data_len = data_len,
+        .data_uptr = (uintptr_t)data_ptr,
     };
 
     ret = ioctl(be->fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
 
     trace_iommufd_backend_alloc_viommu(be->fd, dev_id, viommu_type, hwpt_id,
+                                       (uintptr_t)data_ptr, data_len,
                                        alloc_viommu.out_viommu_id, ret);
     if (ret) {
         error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
diff --git a/backends/trace-events b/backends/trace-events
index b9365113e7..3ba0c3503c 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -21,7 +21,7 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
 iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
+iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint64_t data_ptr, uint32_t data_len, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u data_ptr=0x%"PRIx64" data_len=0x%x viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 163d3e7279..4cef487679 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -582,8 +582,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
     IOMMUFDViommu *viommu;
 
     if (!iommufd_backend_alloc_viommu(hiodi->iommufd, hiodi->devid,
-                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
-                                      s2_hwpt_id, &viommu_id, errp)) {
+                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3, s2_hwpt_id,
+                                      NULL, 0, &viommu_id, errp)) {
         return false;
     }
 
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 2925d116ac..1b0266f660 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -89,6 +89,7 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 Error **errp);
 bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
                                   uint32_t viommu_type, uint32_t hwpt_id,
+                                  void *data_ptr, uint32_t data_len,
                                   uint32_t *out_hwpt, Error **errp);
 
 bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
-- 
2.43.0


