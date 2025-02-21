Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA38C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5T-0002XN-HM; Fri, 21 Feb 2025 07:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5O-000220-P3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS5M-0007Fd-QM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBrAYudfN30eTDxsGlpkwQ5zRuzxrz1/bLUV220VFQI=;
 b=F2edohw3lZ3OM4n8gSLnfn1Dy8xsGniYwRIuLCUj+/H3dbqmdoxceCszA3P4jn1/AHk3zS
 kWShQea96gyHwO7hHgpX0n3A8S/CcsshLdcuLTH+PI3pMrkjm+oRMAtr2pyQUuLAS73NDv
 ZYZUcFkpg/K59C7B4N9Mm2/kgEEIkPE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-DCDNizhyMLeCEixwv6WLRg-1; Fri, 21 Feb 2025 07:24:50 -0500
X-MC-Unique: DCDNizhyMLeCEixwv6WLRg-1
X-Mimecast-MFC-AGG-ID: DCDNizhyMLeCEixwv6WLRg_1740140690
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f36fcf4b3so1229556f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140689; x=1740745489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBrAYudfN30eTDxsGlpkwQ5zRuzxrz1/bLUV220VFQI=;
 b=aT6WeTSA6b7ApHcSYFa8IGctDOMhrbxL1SuxvnNWcqIXbdz6Vbwe1p2nWgtAKABWqQ
 Mmi+Q/M+eEOl2YyOPo585PjBRPXSrxOozZBkiGs5iETHC3cWyMT/vKqKmcmWo7U9OyQt
 ASrrV4/GJLhL/CBLYzJQuACQkJPMzzmR7Ixu3ii6dyiv1qHBemgctaRasxQF7mYhE18j
 eodH52B1RuhKGPqVFqvNNz79wisMLbksKmBkUL2C0Qiu12vUU7dkb+9sa3Wt06ECFV0K
 96RU+T2vUALtxXecuccVKUwpJgxUnW2XDCy+CO4ybD2ZWDYEsl+c+tnCrhjnDAGH2hLm
 thew==
X-Gm-Message-State: AOJu0Yx69hy5yO94ieAuIDVq6Pi1JZKiN+t0M6NYpjujbXdCNy9/y0jg
 JPuQFVLZDrgdPacQ9dS4BsYzn1uKZRPZdOcxLyktQUU3+M3860Zrp+v60sHPVMlOTVsmf1tcJ4s
 CUU9gNE5DeRQLmCMSd2wzkyKu7Uyyil/tK0G3fdQ1Wu8R3CMvOhzMcub/7ZX+nofVjLDr2FITSA
 sJe1XujrmhjrG8ZGZUt8phJjvNqIu2aQ==
X-Gm-Gg: ASbGncuzTs3/FD9ZiuPSH1kpy8Hc57jDs7bG1w6BRAMCsRsJwDvYD5Ny/8NXTXaBd/+
 IJa0HyWCSafYNqd/ZTNgfeZsOTCNKK1g7XIwNxdoayA+sIW7ICjF4lLt05cuzFh3spKGz+/kcSF
 mXwONr/CIqO+5RLOW39rdsxbuJcRKlki+8Lm1OgXxneDXrczumRoIj5LKKsz0Yw4/4SbG6lA0V0
 Q/3jklS7seNtRUfNK2xqIfrm+WnqKSCuY9AUe1Ci+INCfPuQBLYeli56Pr2T5Sr5eDmmsjTVf1V
 uRLtrw==
X-Received: by 2002:a05:6000:178d:b0:38f:4263:9d62 with SMTP id
 ffacd0b85a97d-38f6e9791acmr2815549f8f.27.1740140689147; 
 Fri, 21 Feb 2025 04:24:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp32AULRbmy01GSTfnKC2IjEC3TBFgsu2vbO9S8ZHJwsJenQ6kGgbMF8w2rfBY0Cmk08V9sg==
X-Received: by 2002:a05:6000:178d:b0:38f:4263:9d62 with SMTP id
 ffacd0b85a97d-38f6e9791acmr2815517f8f.27.1740140688648; 
 Fri, 21 Feb 2025 04:24:48 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65dfsm23693257f8f.64.2025.02.21.04.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:48 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 39/41] hw/arm/smmuv3: Move reset to exit phase
Message-ID: <e39e3f8b8dea856f141e9945167d2b18021ef445.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Currently the iommu may be reset before the devices
it protects. For example this happens with virtio-scsi-pci.
when system_reset is issued from qmp monitor: spurious
"virtio: zero sized buffers are not allowed" warnings can
be observed. This happens because outstanding DMA requests
are still happening while the SMMU gets reset.

This can also happen with VFIO devices. In that case
spurious DMA translation faults can be observed on host.

Make sure the SMMU is reset in the 'exit' phase after
all DMA capable devices have been reset during the 'enter'
or 'hold' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Message-Id: <20250218182737.76722-4-eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/smmu-common.c |  9 +++++++--
 hw/arm/smmuv3.c      | 14 ++++++++++----
 hw/arm/trace-events  |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index dd74c2e558..8c1b407b82 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -924,7 +924,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void smmu_base_reset_hold(Object *obj, ResetType type)
+/*
+ * Make sure the IOMMU is reset in 'exit' phase after
+ * all outstanding DMA requests have been quiesced during
+ * the 'enter' or 'hold' reset phases
+ */
+static void smmu_base_reset_exit(Object *obj, ResetType type)
 {
     SMMUState *s = ARM_SMMU(obj);
 
@@ -949,7 +954,7 @@ static void smmu_base_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, smmu_dev_properties);
     device_class_set_parent_realize(dc, smmu_base_realize,
                                     &sbc->parent_realize);
-    rc->phases.hold = smmu_base_reset_hold;
+    rc->phases.exit = smmu_base_reset_exit;
 }
 
 static const TypeInfo smmu_base_info = {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c0cf5df0f6..b49a59b64c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1870,13 +1870,19 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
     }
 }
 
-static void smmu_reset_hold(Object *obj, ResetType type)
+/*
+ * Make sure the IOMMU is reset in 'exit' phase after
+ * all outstanding DMA requests have been quiesced during
+ * the 'enter' or 'hold' reset phases
+ */
+static void smmu_reset_exit(Object *obj, ResetType type)
 {
     SMMUv3State *s = ARM_SMMUV3(obj);
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
 
-    if (c->parent_phases.hold) {
-        c->parent_phases.hold(obj, type);
+    trace_smmu_reset_exit();
+    if (c->parent_phases.exit) {
+        c->parent_phases.exit(obj, type);
     }
 
     smmuv3_init_regs(s);
@@ -1999,7 +2005,7 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     SMMUv3Class *c = ARM_SMMUV3_CLASS(klass);
 
     dc->vmsd = &vmstate_smmuv3;
-    resettable_class_set_parent_phases(rc, NULL, smmu_reset_hold, NULL,
+    resettable_class_set_parent_phases(rc, NULL, NULL, smmu_reset_exit,
                                        &c->parent_phases);
     device_class_set_parent_realize(dc, smmu_realize,
                                     &c->parent_realize);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c64ad344bd..7790db780e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -56,6 +56,7 @@ smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
+smmu_reset_exit(void) ""
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
MST


