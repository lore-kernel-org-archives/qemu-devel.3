Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB210FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWed-0003Uf-8V; Fri, 06 Mar 2026 09:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeb-0003T4-2E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeZ-0002IN-4W
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:48 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4837634de51so40738965e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809186; x=1773413986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pNOqPEMn8ejxtDW65Z3UaWor69sYIcoIPnJUidDNtdM=;
 b=g2tW+8CdrlRDN5ZKvlM0532EIRgxF9U7NM9Es5ABW5gISo7KRVRDuvIkZhBuODnqvg
 4sBqsJ8rGnAvqllWH0nmmDEv1CRI9JKgqozFoiQAJ44xa4YF+bNXWodISdwIDXjoR7IG
 EBDW8nNtNs58HiCxBkfakT8eEwfzzcb6C/s9+6McPXTTm6DHfaUdcJgH5d8bM+yn1k0g
 OZQBxFfY2DigLkf0Tu+cvjbas3c72SvTyKlzxe2ulWrLJO77Vy9ppP8c4ObGIzmG6yhm
 qsTysgs16DqHRSQV3VgLK/PXPqCC+vbKLeUx5UXK2S5/vPOtxHhp+xLimrqE6nZWJ2Mu
 WY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809186; x=1773413986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pNOqPEMn8ejxtDW65Z3UaWor69sYIcoIPnJUidDNtdM=;
 b=atnn/iVyul/gRJrKffTwi/jgfnIvEkvJE92UNhQJ5W53qShiq9a92GkjH2U4jzvizp
 8qgHh4knEf0ZJVphXJRo7UlnEVt6VnjMOBHZ6cY3PxGe+Idvy90w6xRCBasuUpBEUd7i
 UEqrcWRpMG3jeHRuF3BGp48qa+RJgvtFhI64diErbGnfOuLl0KY7Mhrw1AJzlqZKxZOL
 PdbmgWh8OeLj7eKwFF9pwmk6m8xQ5XHTerYZUQ8vBdG2JNAMR4sKY3a65ByXdKid5Ywq
 2ThGOBaelu3liNxsYs+Vv/rPpka2aoEpLHpcPTBd8YOI+zssaByEOqOxtBXYD/pmXYgG
 PQSw==
X-Gm-Message-State: AOJu0YyCuNVKcvIBF/u5VU2dxjWbXpYa+3FaAKODp6hTOAKMU7olrd6m
 r4Q5+WbaG0gPZMrbOfd3ssSd1CjQ2XK4sxGK6zH+EVrpE/R8v8AJ6fpggigUFH3kDFqMBB2pkxp
 E4Dts
X-Gm-Gg: ATEYQzx0SarDzNPU/x7fw4ZxOzQ5cQ/K8B2w5eDO60jx587KucYuPRxgmhWyLusQq8Q
 0e5d/ZiLoekCJll5aGBTKDD2vKuK374tRhqXuDI5B0aq/pHOtLedxLbXYjuBznqUnIJQpQqkfOg
 DNyF9HXeFmNgqHDud8E1zAFBeqTpVc3vGpe1XF4ykxE8zeBaFMcOVEMTw/oxopBbpp8tf4Afmj/
 YRjQG1Mx55s4Tjj3eQ6wompkqDIATz6ePU8W0DBLsOoGvuwPB2iTZzASWKmNgtCfgwXjpgevwGk
 sJhnh6LQf+SxIzUYQkdGcYYU/F/1hsHBsaRSBULoRnZ97jZzhU1bQaOkoCqifO/dC8mm0R/r3Xj
 Rmo2QPPWfxS3jZg66k9uJEw8zWssaUlP9fTlTXymEBXpkygDB/XKq2KloxHcZGEPcAUBBBmucdA
 dPINR8bH8ACEZ5bruIHP/nwvuZfbwt5ATFb97dAsOWZ6GtVePgCVHbOumKgNVAZZ5lCqJ0xVm0K
 hdoAKysxnDH66+ldqZa64THU7P0lGs=
X-Received: by 2002:a05:600c:1d1e:b0:483:c35d:3659 with SMTP id
 5b1f17b1804b1-48526957d5cmr40470835e9.18.1772809185448; 
 Fri, 06 Mar 2026 06:59:45 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/49] backends/iommufd: Introduce iommufd_backend_alloc_veventq
Date: Fri,  6 Mar 2026 14:58:54 +0000
Message-ID: <20260306145939.2162189-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
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

Add a new helper for IOMMU_VEVENTQ_ALLOC ioctl to allocate a virtual event
queue (vEVENTQ) for a vIOMMU object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260226084456.112142-2-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h | 14 ++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 13822df82f..acfab907c0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -504,6 +504,37 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
     return true;
 }
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp)
+{
+    int ret;
+    struct iommu_veventq_alloc alloc_veventq = {
+        .size = sizeof(alloc_veventq),
+        .flags = 0,
+        .type = type,
+        .veventq_depth = depth,
+        .viommu_id = viommu_id,
+    };
+
+    ret = ioctl(be->fd, IOMMU_VEVENTQ_ALLOC, &alloc_veventq);
+
+    trace_iommufd_viommu_alloc_eventq(be->fd, viommu_id, type,
+                                      alloc_veventq.out_veventq_id,
+                                      alloc_veventq.out_veventq_fd, ret);
+    if (ret) {
+        error_setg_errno(errp, errno, "IOMMU_VEVENTQ_ALLOC failed");
+        return false;
+    }
+
+    g_assert(out_veventq_id);
+    g_assert(out_veventq_fd);
+    *out_veventq_id = alloc_veventq.out_veventq_id;
+    *out_veventq_fd = alloc_veventq.out_veventq_fd;
+    return true;
+}
+
 bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
                                            uint32_t hwpt_id, Error **errp)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 8dc64a20d3..b9365113e7 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -23,6 +23,7 @@ iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, u
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
 iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
+iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
 
 # igvm-cfg.c
 igvm_reset_enter(int type) "type=%u"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 80d72469a9..7062944fe6 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -56,6 +56,15 @@ typedef struct IOMMUFDVdev {
     uint32_t virt_id;  /* virtual device ID */
 } IOMMUFDVdev;
 
+/* Virtual event queue interface for a vIOMMU */
+typedef struct IOMMUFDVeventq {
+    IOMMUFDViommu *viommu;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+    uint32_t last_event_seq; /* Sequence number of last processed event */
+    bool event_start; /* True after first valid event; cleared on overflow */
+} IOMMUFDVeventq;
+
 bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
@@ -86,6 +95,11 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
                                 uint32_t viommu_id, uint64_t virt_id,
                                 uint32_t *out_vdev_id, Error **errp);
 
+bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
+                                   uint32_t type, uint32_t depth,
+                                   uint32_t *out_veventq_id,
+                                   uint32_t *out_veventq_fd, Error **errp);
+
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-- 
2.43.0


