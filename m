Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04CFCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9x-0007RA-6I; Sun, 14 Jun 2026 15:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9v-0007Ql-P2
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9u-0001eu-4w
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXWGdkA/WVBctiP+cyHvdFhlErb0XX81I00BUPSdjog=;
 b=UlkwQYN97UVHavSkzi4piLDcVbQrPoG8SEytZ3Y6VldhfiL3OUF09wqEV89NI3gd/DGx4J
 0pRj+sE5vyOq4fCS3Qcsnjr2VFwomiULrjOB8duYluq6IMPzkw6D1fxXTFoUNboM6C6IaW
 GJPY4K5oDpid2/iVnNRPLce3XB3KPJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-pUjGX30OPZWH8zB3Op1csw-1; Sun, 14 Jun 2026 15:06:11 -0400
X-MC-Unique: pUjGX30OPZWH8zB3Op1csw-1
X-Mimecast-MFC-AGG-ID: pUjGX30OPZWH8zB3Op1csw_1781463971
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so1608001f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463970; x=1782068770; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lXWGdkA/WVBctiP+cyHvdFhlErb0XX81I00BUPSdjog=;
 b=M01a7VTpT8nZUzCm0bPzYpjQasKNjf4wn6dUnlQg/d7FzaV996OWhVri5HPAhCssM3
 T2GeRAMkAtlPTLjWILHyk/4XUYeLFzetSzM9urNywv+os6lNBaXcN6zebsKqq59G/ntL
 fiRAZQYaBQbBbIUD4VB2tP+J4SzGkD9qxmOcRQ99+5CUKiXuj9gUWNKIqs/2xtXadDJB
 aSODPPA1IjZJRsgwuOOwCNrAEPDOwAavAcyGrC+abWMCeVnAUJ8mbMZR+PaNGaMYATqe
 94XD/U7wCvw0AUzmmGCX+ypCHWIaP3/KGU/gLv4XsFC5Qmx6nj8sTf9HM0W/QLOak2kX
 QfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463970; x=1782068770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXWGdkA/WVBctiP+cyHvdFhlErb0XX81I00BUPSdjog=;
 b=gZ7G/EGA8zaNs91QAAqWrm7zT3o6YWOkDBGSVFevp00a02YoUpXge5n6chkgREw3h1
 T0IIwG4KO50uNBa1FB1cMxCsmn+wAKTUd2yFvXLDCSvozGG2XNjlxZbmEp62qjZ94lRZ
 IJYriy5b1IVKV/HMcG2JhOwbNs9LrLLYShep+SRxVDcJxqv0+wOPrIQVRqgIbflZrA5U
 7gKExQClc7DqfSfDB66HMMiED9fgWguQRdQpBKQKHUh3ckMzkIbY1eiHQDY1hDxWlm6x
 ah+yLaY8sgY8UqB8a0d2JkKvzrbQWnK6eSxNjaTRLY5D8z3Pag5fJ30FuJqNEp0noeGJ
 HtzQ==
X-Gm-Message-State: AOJu0YxmXoEn186EvxZrNS0hUaVVGmK3F1R0zwNyKgj32eL/WlbB94Yj
 EhSe+6Y9w4YMbws+lOVL4/kwtp2JDXl3129uEF8mSxvLWFsdczjLvHi3wjgstwqztWYe0yu7uRI
 l8D/t3IPSiwwkHozTpoinM2lElGXeArhbjK+rouN1Ow0s5Ox+zRhFsRHtC7laGRQ5QNh0QriGYE
 3nSkQ3HEaVal7PGvwCp9nenHpg8qW60qG/lg==
X-Gm-Gg: Acq92OEVC47HeYgyeviQ2tLYQvx9KxSuKFgbfH/S58aaJnG3h3jlsHQzI+6d6+2NLUq
 js2IR7p5zt/47ZUKeeuSKaOtV9GgGERsbjkDWG/KBz8z3/hiB+vfZ6BmPsUfJRxTBmZbrv+UdWi
 SjePHwC9QlWsJOwEWrohFkEGfbHTj9NPSMw44R8AGZ1FUNvlmD/4RRPgSgBoVXFPcig0p53px1i
 Y3Bw+lq4R2/eIakb0Q4Cuq/TZ0Ao+szBkzRoRlYYEgndtsYKcqigBw+mFyA8XCY2FySaNTG1BNx
 U3MkO9eMvkxLpI8jqsGbQCtc21LIIn7KxPPgeePI5CYSDxhm1TZRxDs8P0AEHduu/nMEvZRiefy
 sOM/Yn1hfPdTAMMZy0XjdLobMNfQJslu9IEoYYYWzoxw=
X-Received: by 2002:a05:6000:2087:b0:44a:2cb3:b633 with SMTP id
 ffacd0b85a97d-4606db8c617mr16323624f8f.12.1781463970417; 
 Sun, 14 Jun 2026 12:06:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2087:b0:44a:2cb3:b633 with SMTP id
 ffacd0b85a97d-4606db8c617mr16323543f8f.12.1781463969389; 
 Sun, 14 Jun 2026 12:06:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26392esm26624344f8f.3.2026.06.14.12.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:09 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 010/106] intel_iommu: Rename pasid property to "pasid-bits"
 and define it as type uint8
Message-ID: <312f3ef8adcf008d3992012bcdc91ce26b6d9186.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

'x-pasid-mode' is a bool property, we need an extra 'pss' property to
represent PASID size supported. Because there is no any device in QEMU
supporting pasid capability yet, no guest could use the pasid feature
until now, 'x-pasid-mode' takes no effect.

So instead of an extra 'pss' property we can use a single property of
uint8 type and named 'pasid-bits' to represent if pasid is supported
and the PASID bits size. A value of N > 0 means pasid is supported and
N - 1 is the value in PSS field in ECAP register.

PASID bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-6-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c          | 11 +++++++++--
 hw/i386/intel_iommu_internal.h |  2 +-
 include/hw/i386/intel_iommu.h  |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4f8302d200..b22feb0301 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("fsts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
-    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_UINT8("pasid-bits", IntelIOMMUState, pasid, 0),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
@@ -5045,7 +5045,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     if (s->pasid) {
-        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
+        VTD_ECAP_SET_PSS(s, s->pasid - 1);
+        s->ecap |= VTD_ECAP_PASID;
     }
 }
 
@@ -5586,6 +5587,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d exceeds Max PASID Width %d allowed "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }
+
     if (s->svm) {
         if (!x86_iommu->dt_supported) {
             error_setg(errp, "Need to set device IOTLB for svm");
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 11a53aa369..db4f186a3e 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
+#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e44ce31841..95c76015e4 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -314,7 +314,7 @@ struct IntelIOMMUState {
     bool intr_eime;                 /* Extended interrupt mode enabled */
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
-    bool pasid;                     /* Whether to support PASID */
+    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
-- 
MST


