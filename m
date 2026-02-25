Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127EEEFD211
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvB66-00043u-B5; Wed, 25 Feb 2026 04:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB64-0003x1-Vd
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvB62-0003kO-Rl
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772011333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A48Ot7MeNR5A/tznDjC1sMdqc/WpvBD3v76rlGiX8AU=;
 b=G0tWbNzh1c9nD/67s2vXjMemtnjGouSJ9bnpU9SF9wNrHmu91PWwfs6z/I9QZqfaoC4u/i
 5zFe2F3f+P9HfPpEEFj0KmtG4JpRegicY6O50hZXMt1qBt4zUerJUgFCCVLOZlkrihRe0P
 r36mje5CAhMR5tDvdSTByKFDHQfs74c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-w6T1s_g_PuCOGogF1t31Aw-1; Wed,
 25 Feb 2026 04:22:09 -0500
X-MC-Unique: w6T1s_g_PuCOGogF1t31Aw-1
X-Mimecast-MFC-AGG-ID: w6T1s_g_PuCOGogF1t31Aw_1772011327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB12118004BB; Wed, 25 Feb 2026 09:22:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D10C19560A2; Wed, 25 Feb 2026 09:22:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 15/16] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
Date: Wed, 25 Feb 2026 10:20:23 +0100
Message-ID: <20260225092024.794595-16-thuth@redhat.com>
In-Reply-To: <20260225092024.794595-1-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The X86IOMMUState::pt_supported boolean was only set in
the hw_compat_2_9[] array, via the 'pt=off' property. We
removed all machines using that array, lets remove that
property and all the code around it, always setting the
VTD_ECAP_PT capability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-19-philmd@linaro.org>
[thuth: Dropped the hunks that were already merged via commit 31753d5a336f]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/i386/x86-iommu.h |  1 -
 hw/i386/intel_iommu.c       | 13 ++-----------
 hw/i386/x86-iommu.c         |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index c526a047ab6..0a1e1ba7257 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -63,7 +63,6 @@ struct X86IOMMUState {
     SysBusDevice busdev;
     OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
-    bool pt_supported;          /* Whether vIOMMU supports pass-through */
     bool dma_translation;       /* Whether vIOMMU supports DMA translation */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4924aa43750..d24ba989bfc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1072,6 +1072,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
 {
     switch (vtd_ce_get_type(ce)) {
     case VTD_CONTEXT_TT_MULTI_LEVEL:
+    case VTD_CONTEXT_TT_PASS_THROUGH:
         /* Always supported */
         break;
     case VTD_CONTEXT_TT_DEV_IOTLB:
@@ -1080,12 +1081,6 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
             return false;
         }
         break;
-    case VTD_CONTEXT_TT_PASS_THROUGH:
-        if (!x86_iommu->pt_supported) {
-            error_report_once("%s: PT specified but not supported", __func__);
-            return false;
-        }
-        break;
     default:
         /* Unknown type */
         error_report_once("%s: unknown ce type: %"PRIu32, __func__,
@@ -5004,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (s->dma_drain) {
@@ -5032,10 +5027,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
         s->ecap |= VTD_ECAP_DT;
     }
 
-    if (x86_iommu->pt_supported) {
-        s->ecap |= VTD_ECAP_PT;
-    }
-
     if (s->caching_mode) {
         s->cap |= VTD_CAP_CM;
     }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 33ac0bfc97e..a57445404ef 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
-    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
     DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, true),
 };
 
-- 
2.53.0


