Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7DBCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ9w-0005sV-1f; Tue, 16 Jun 2026 15:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZX-Nc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000x2-Q6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso61626695e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636818; x=1782241618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7LbqHsqIIDkdHZnHJlOZ0cciJwmdrPLtN8RdYZYIqwc=;
 b=IW3NSkrVx6ozoEdTxh/35Et/iKLnD3r+zoianzJo5CpzsmJRC4f5+DzpM+la/B35Ml
 hPD5x4yidH8XvyzwaFrDVC7YR4xv6gIMPDIq6MMCjKjFjYBo4m3QCOChonZ8aD6XCngf
 65zqVfgqvSuQLgsazizGKcd8MnOw7RLugQCOE0T2km+TzA9JtbUsZRNbBNdyWt8/49SG
 9xThvz+03WXN7XjgdnsgwI+19zxSamOTTdF9MGLhqaxUbrXjd+IJOiE0rKkIXN6OV1ye
 9SklgUunEwV2A3z2y0MZ+/ZRuzdPpLY1fI6LgGkSnWKGoJgrRGgm3XUYr3wJtL0PkveR
 derg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636818; x=1782241618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7LbqHsqIIDkdHZnHJlOZ0cciJwmdrPLtN8RdYZYIqwc=;
 b=Xazq5bfSMudIDZ5GCeJrVTo4PcLlrpRjJF67ysA9b/KFDz+TmUYONFEQ0JJaq74fG3
 Pr120GNb/KVjymOO24Nx7nDQKIGZw/m48XFnoUJLYUekG6McTmfNB0i9PlSN48rhrTIR
 ifL9+g1wZxS8L1tsPUyCqwefFywOG7RYptF9OLSiSMiFo4qxMmKnQj8dQz/k529fctUJ
 5Pubh/eYe+V5LQfg5H3F1NjE1RoygloK4F4OWBAximdTspzp/v1ycmkzH0uaNucGZhEP
 pYOVB6JaKUfZGL1/6cKB5Qb4wnQQLPSnBSkmiAKTDaevBvyesvHXnOmHRnWHYqoClSkv
 iReQ==
X-Gm-Message-State: AOJu0YzE8QMvMk4P6dgxrHWPVs5alULSJIbn/k8ftHGKfSCILJO5hK+l
 c30CIx3oCwaOPCHsuuhrt8fVGltgXAihFyuFY+1HrmQ6IWid2VrpjQ+zl/MWoUyjsFXdKsZrpGj
 tHXlH
X-Gm-Gg: Acq92OFbnecL0nOcfFiMYkpxtTHDqwggYZZ/xKyx56Aa/s3VRKksr5b4SkI5A9uWRwD
 UfeTTYuWRYAJe5kzIzUOyENs5+ScMEsKUSCBg/1yMCjDvrlV01iAGVssB/2+kyuAZlhO9BZniRn
 xfRuE1Qm5cEwQINGl8k6Vwpw84sEDCrnDoXT7j8gA6nMXoZFGL0lI25MEFM5gd/6CfJGu8DBaSC
 e9Bp64wGxGJBTK+jP390ligPvkbZwpvy3dP2efqvNw8jmLlKLMjXVP4ONwNcJkmIZOKtosjy21C
 KLMIqrJEorPHr87BGho1jYAuDQtggMoidaB8epWojLxVVpEzr4DbDfeNS9FOPITmeTRWVM6+Jzd
 hCAKHQ3uYWJCewW0Z6EoQoNfJxCBEH6xaC8Ytk4aRK8xjbuAkJ1597M2e/6m+6x85bFvAFSsnjY
 9z3flyYnmEf1VoYfiaZ+nSPcfpjuBt7WzF4N4Vg/DngTM9FB0Q4WbDHyKZuaftFquwclyloyTp8
 0cbyxN18E8tTeeTjPyPJLafnAULtFVK
X-Received: by 2002:a05:600c:a305:b0:490:b629:286c with SMTP id
 5b1f17b1804b1-492333aa59bmr10568175e9.12.1781636818497; 
 Tue, 16 Jun 2026 12:06:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/61] backends/iommufd: Introduce iommufd_backend_viommu_mmap
Date: Tue, 16 Jun 2026 20:05:51 +0100
Message-ID: <20260616190639.3462006-15-peter.maydell@linaro.org>
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add a backend helper to mmap hardware MMIO regions exposed via iommufd for
a vIOMMU instance. This allows user space to access HW-accelerated MMIO
pages provided by the vIOMMU.

The caller is responsible for unmapping the returned region.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-5-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 22 ++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8eaaf456e8..440c1b82bc 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -580,6 +580,28 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
     return true;
 }
 
+/*
+ * Helper to mmap HW MMIO regions exposed via iommufd for a vIOMMU instance.
+ * The caller is responsible for unmapping the mapped region.
+ */
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp)
+{
+    g_assert(viommu_id);
+    g_assert(out_ptr);
+
+    *out_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, be->fd,
+                   offset);
+    trace_iommufd_backend_viommu_mmap(be->fd, viommu_id, size, offset);
+    if (*out_ptr == MAP_FAILED) {
+        error_setg_errno(errp, errno, "IOMMUFD vIOMMU mmap failed");
+        return false;
+    }
+
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index c5c1d95aad..b63420b73e 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -25,6 +25,7 @@ iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
 iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t queue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t queue_id, int ret) " iommufd=%d viommu_id=%u queue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" queue_id=%u (%d)"
+iommufd_backend_viommu_mmap(int iommufd, uint32_t viommu_id, uint64_t size, uint64_t offset) " iommufd=%d viommu_id=%u size=0x%"PRIx64" offset=0x%"PRIx64
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c6f2e87a7e..bb8d5081d7 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -112,6 +112,10 @@ bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
                                     uint64_t addr, uint64_t length,
                                     uint32_t *out_hw_queue_id, Error **errp);
 
+bool iommufd_backend_viommu_mmap(IOMMUFDBackend *be, uint32_t viommu_id,
+                                 uint64_t size, off_t offset, void **out_ptr,
+                                 Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


