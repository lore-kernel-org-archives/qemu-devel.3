Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB05FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWef-0003gw-O7; Fri, 06 Mar 2026 09:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWec-0003UH-SV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWea-0002Il-Uy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso70384575e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809187; x=1773413987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y+UJrf0+XqVFVS2uBBH5yz9W2AfmeAVb1aoauvtaMS8=;
 b=puRonhcHAYXBTDsiJFq69xysBzMg+jb+JrMW8nTJnFSkLwxIqUGmH1e64lNfqNatO4
 aA4QRx5tDkUwt7QtIowPiEmMW9uSDIlP513R9YxaDJqN02kw1fqYMjjUKVBobJj+vjSL
 AumIfrLbukLQkLoXvJtiBrlDarSiiCmL1enJFOjawcRqEnqmRhbOJVJBqvvgA5QeIsk1
 LU0uUMuip605u/Y3T41uEtayPSzQyEU/BfqY0XW91TD6dd2edHsLQZ1jQarzdozURc35
 ThF9fvN+q5lA5DaJntmu3us09WGaXxAeghaKwfBgnPcHqrW+QrfmXu44IlxQLaOBkAPw
 745A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809187; x=1773413987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+UJrf0+XqVFVS2uBBH5yz9W2AfmeAVb1aoauvtaMS8=;
 b=bEcwPI5eMWhUqaegNrPc2+6cMNdbKeQ5Jckz+UVhG2UBcUadkrRz5Yzq7lBbD0GLSJ
 TCGXrSV2iBTQ/Ts5xZwiJyJ90VR5o/Uv1IR+5gqxCt6RCQzL96rjvDyR2IIRutHWKzBM
 i/hXJu7GImPF0kebzrq9TejEbjJTVpobAABZ6q1pzcBEbkoNkoEufHkJ1eNfum3y+NbM
 BcQ2sjf9Uw7ErNH7mB3VV5FG3Di3VF0h1bKoi1pGCKsEqiq57xPglmTa6gztIu9you1t
 1KOpMKqmSCcHMCoUKzNvLVHZSweEQjL0gS76ahYzOEEeX/vxZAINmPjeCEzTQbJ0FhM3
 65vQ==
X-Gm-Message-State: AOJu0YwitcasfUUB/ecX2Pc7mebS4XbnYLtOfDLo/6z7L68haVuejnCU
 o02YWtpFSMYYot1UBUWWQmKW5rALxPpr/rf8fhx0Dcju56TU9X4kgvw4Fb9TfCMrXFVPz/Q8DMY
 jRsnt
X-Gm-Gg: ATEYQzyfF0Rn9/vqAA1Fv5ailTEDBedlFiHm/6Siyt6U/dlE11rrRx9MEBpnG0Do6u/
 xJ9w0EoxnG/1C/+d/KA7IfGYvyM9+YLxbFF7DhIZswe5dCwITGHfc49+Q254SRcS6ODmKBotJUt
 nJ+NHbxwIXJgSpQSfGv3Qvtbil/dGEN/93XS07UZqWEx9DuftdF53uml0Si4ZwiQQbLbR0/+kZj
 7SApolMdPctsZyUZzOEVz4GzcVRtTfiGee8JosmnWD+QVwikUtq0rzcl5soMHV26Shn1hPyxgjN
 MdLVeugl8WT4lEcI+oowvf3BVtNt9jUyxeEIwlivF6R/hvMevtfFpKasPTnBeefYEjTBHUJ2j8r
 yPebwUld58LXP0jcd6tC2o4fMqtB+Gt+paZy5a4MK30WCQeLnr7dg0dR0tsDS8Lt0FHXf0tCSAN
 h6HdL/UV+jo8PvElG4yRGVJEHVXbXhZpskVmEn8X+J2vbrUqkRKAAczBcBykSiqH4JRKFuvi+i6
 IzCTBb30DPT2lLWcikHvdgNfTTi5rw=
X-Received: by 2002:a05:600c:6489:b0:47e:e712:aa88 with SMTP id
 5b1f17b1804b1-4852697758amr37308165e9.31.1772809187264; 
 Fri, 06 Mar 2026 06:59:47 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/49] hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated
 SMMUv3 devices
Date: Fri,  6 Mar 2026 14:58:56 +0000
Message-ID: <20260306145939.2162189-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
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

When the guest enables the Event Queue and a vIOMMU is present, allocate a
vEVENTQ object so that host-side events related to the vIOMMU can be
received and propagated back to the guest.

Allocate a vEVENTQ only when both of the following conditions are met:

  1) The guest SMMUv3 driver has set EVENTQEN = 1 in SMMU_CR0.
  2) A vIOMMU exists (created when the first VFIO device is attached).

These two conditions may occur in any order.

In the cold-plug case, the vIOMMU already exists before the guest
driver probes. When the guest sets EVENTQEN = 1 during driver probe,
the vEVENTQ is allocated at that point.

With hot-plug, the VFIO device may be attached either before or after
the guest sets EVENTQEN. If the vIOMMU is created first, allocation is
deferred until EVENTQEN = 1. If EVENTQEN is already set, allocation
happens when the vIOMMU is created.

In all cases, allocation is triggered when the second required
condition becomes true.

Errors from command queue consumption and vEVENTQ allocation are reported
independently as the two operations are unrelated.

Event read and propagation will be added in a later patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260226084456.112142-4-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3-accel.h |  6 +++++
 hw/arm/smmuv3.c       |  6 +++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c19c526fca..f703ea1aac 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,19 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
+{
+    IOMMUFDVeventq *veventq = accel->veventq;
+
+    if (!veventq) {
+        return;
+    }
+    close(veventq->veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
+    g_free(veventq);
+    accel->veventq = NULL;
+}
+
 static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
 {
     IOMMUFDViommu *viommu = accel->viommu;
@@ -397,6 +410,7 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     if (!viommu) {
         return;
     }
+    smmuv3_accel_free_veventq(accel);
     iommufd_backend_free_id(viommu->iommufd, accel->bypass_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->abort_hwpt_id);
     iommufd_backend_free_id(viommu->iommufd, accel->viommu->viommu_id);
@@ -404,6 +418,41 @@ static void smmuv3_accel_free_viommu(SMMUv3AccelState *accel)
     accel->viommu = NULL;
 }
 
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    IOMMUFDVeventq *veventq;
+    uint32_t veventq_id;
+    uint32_t veventq_fd;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    if (accel->veventq) {
+        return true;
+    }
+
+    if (!smmuv3_eventq_enabled(s)) {
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_veventq(accel->viommu->iommufd,
+                                       accel->viommu->viommu_id,
+                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
+                                       1 << s->eventq.log2size, &veventq_id,
+                                       &veventq_fd, errp)) {
+        return false;
+    }
+
+    veventq = g_new0(IOMMUFDVeventq, 1);
+    veventq->veventq_id = veventq_id;
+    veventq->veventq_fd = veventq_fd;
+    veventq->viommu = accel->viommu;
+    accel->veventq = veventq;
+    return true;
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
@@ -429,6 +478,7 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
     viommu->viommu_id = viommu_id;
     viommu->s2_hwpt_id = s2_hwpt_id;
     viommu->iommufd = idev->iommufd;
+    accel->viommu = viommu;
 
     /*
      * Pre-allocate HWPTs for S1 bypass and abort cases. These will be attached
@@ -448,14 +498,20 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
         goto free_abort_hwpt;
     }
 
+    /* Allocate a vEVENTQ if guest has enabled event queue */
+    if (!smmuv3_accel_alloc_veventq(s, errp)) {
+        goto free_bypass_hwpt;
+    }
+
     /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
     hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
     if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
-        goto free_bypass_hwpt;
+        goto free_veventq;
     }
-    accel->viommu = viommu;
     return true;
 
+free_veventq:
+    smmuv3_accel_free_veventq(accel);
 free_bypass_hwpt:
     iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
 free_abort_hwpt:
@@ -463,6 +519,7 @@ free_abort_hwpt:
 free_viommu:
     iommufd_backend_free_id(idev->iommufd, viommu->viommu_id);
     g_free(viommu);
+    accel->viommu = NULL;
     return false;
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index a8a64802ec..dba6c71de5 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -22,6 +22,7 @@
  */
 typedef struct SMMUv3AccelState {
     IOMMUFDViommu *viommu;
+    IOMMUFDVeventq *veventq;
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
@@ -50,6 +51,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
+bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -80,6 +82,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 static inline void smmuv3_accel_idr_override(SMMUv3State *s)
 {
 }
+static inline bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..5d718da764 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1605,6 +1605,12 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->cr0ack = data & ~SMMU_CR0_RESERVED;
         /* in case the command queue has been enabled */
         smmuv3_cmdq_consume(s, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is available */
+        smmuv3_accel_alloc_veventq(s, &local_err);
         break;
     case A_CR1:
         s->cr[1] = data;
-- 
2.43.0


