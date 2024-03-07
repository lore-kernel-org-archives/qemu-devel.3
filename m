Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F78C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riE7G-0006mb-Tf; Thu, 07 Mar 2024 08:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1riE4g-0005Bd-G5
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:46:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1riE4C-0007I2-VS
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709819120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FgQp0WRWuM7fbneXl+zhQwiRO3lZEEXkMeE6HtVWUQ=;
 b=iLYjijIA4y31gUUO9/b4v15aZIBwS6EajAQ7/17BnH6gLgkGn0eigcvNeoOaoPUmdxKT1x
 /wigqJ8H1oitG0BHuKwLtKwDHMC8kDO275WDNWy55HColjy5CnWTisbeQ3sklVavZkaKWN
 Ysu2E8JvmpOtBFXeNoDQ3BhvFLmVfDg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-ornFrTirMP6MRB-FrbipNA-1; Thu,
 07 Mar 2024 08:45:14 -0500
X-MC-Unique: ornFrTirMP6MRB-FrbipNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76BEF1C00D19;
 Thu,  7 Mar 2024 13:45:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16D4F17AA6;
 Thu,  7 Mar 2024 13:45:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v8 6/9] virtio-iommu: Add an option to define the input range
 width
Date: Thu,  7 Mar 2024 14:43:07 +0100
Message-ID: <20240307134445.92296-7-eric.auger@redhat.com>
In-Reply-To: <20240307134445.92296-1-eric.auger@redhat.com>
References: <20240307134445.92296-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

aw-bits is a new option that allows to set the bit width of
the input address range. This value will be used as a default for
the device config input_range.end. By default it is set to 64 bits
which is the current value.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

---
v7 -> v8:
- add return when error [Phil]

v1 -> v2:
- Check the aw-bits value is within [32,64]
---
 include/hw/virtio/virtio-iommu.h | 1 +
 hw/virtio/virtio-iommu.c         | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 67ea5022af..83a52cc446 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -68,6 +68,7 @@ struct VirtIOIOMMU {
     Notifier machine_done;
     bool granule_frozen;
     GranuleMode granule_mode;
+    uint8_t aw_bits;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index aab97e1527..1326c6ec41 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1314,7 +1314,12 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.input_range.end = UINT64_MAX;
+    if (s->aw_bits < 32 || s->aw_bits > 64) {
+        error_setg(errp, "aw-bits must be within [32,64]");
+        return;
+    }
+    s->config.input_range.end =
+        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
 
     switch (s->granule_mode) {
     case GRANULE_MODE_4K:
@@ -1544,6 +1549,7 @@ static Property virtio_iommu_properties[] = {
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
                              GRANULE_MODE_HOST),
+    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


