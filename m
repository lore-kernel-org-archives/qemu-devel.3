Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF9CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbAj-0007PB-Ap; Thu, 01 May 2025 17:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb89-0004I5-QW
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:47 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb88-0006sc-35
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:41 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d93deba52fso4621585ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133659; x=1746738459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdzft+xCucigY9en84sWDKvV9F8XabM3RidQg1HEXDs=;
 b=IgqS5vbT09UI6H6Lf6GSYXrxHx+96pcdd5SeJBGp9+77qxK2U+fKmdCniViQ11h/mr
 E3Mb3wD5AzjGx11NpwVGDpmvdqeSpd2SPcI06sq2Sw5T6MnJTARbKTuYjPLdi5d6Gtas
 EkHBdKdv0aCVOIZl6XuMFHpk0J8nIyHdCFEZagm41yCBBPd6E76cUAmciSTwELhZDzAs
 Jpm20kt6dUUQRjt/r+WbgzVQZj2obSS5L1RAJOAsJPgkUZu0nuI37gxw+VtgsGuReww7
 Fvz9UV0FB/HMr3oJ0CnySA5Rsp80DtCHCL/KnFxrxDafgCw3a6AM/i3KCRa/X0vsIQIM
 PZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133659; x=1746738459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdzft+xCucigY9en84sWDKvV9F8XabM3RidQg1HEXDs=;
 b=LB4YzLH9uKa4VTBu0CVTd3MtcuIMcmWU5yjjgp3+sa+4h7AgqEbv0Asf/BBGvxw6OC
 qV9rKDyoS+y43PeAWy/M+Jz4c0mPMzadkBffcU8U4Lr9lsa3XZ4wNTkPY0oAAQVTEUWG
 FVhQOlf7jS001gEgxNtwQ3M1zniXuIvM5M8SbajtMogDJGz6Dwul/zC1PW5MAYb5MLCl
 6zaMrf7EBFGL/F/Q+3EZHsVxoL3MKvl9y/62dZ10Rng5E12KCBMcRWP5ALaQ21jpFK3d
 zwcEl55yXZVuRdauEujif2dfRPOf8Uuaon/Ge/kN3MQsHhG2hPP073N+0Wqk70ShUSRe
 w3JQ==
X-Gm-Message-State: AOJu0YwwC3VNnPjJVd3Io/PdnDW3Oh58d4r4NyCjfEQ9vKUdULneEo7J
 DCW19YmKlA17+rivOBSR/lLhbaAWxfpvqHfIXNgYSXyNrmatWVm5ahyJrHp6NCcg5ya+GXUMyu5
 5
X-Gm-Gg: ASbGncsbbtzuVa/RpjtmikCYzZNq5LHMZChAG30kCZrFVJcCp6Q8wS50lQOxluCkmxL
 d2jLS5u7lylWzhLxpS6Jdo46Q27PBgsDlLpeD5b/aaXO+6/r97KeugBpfVQbjYtYSWfZwnsHctN
 6s8bdSD8TAJsUZ9Ywq5hoXiLuusA2vq7Nz9kPDCRbzgGKsy5/wGALHuaOIacezbc+IJxp0aNm0Q
 JMjX5Ar9iNKwD2lmOf9UJ9hMf5bGKskp1C6f44D464ALGczhy8cA98jZDlD3A3hLvfXFbHZ5U9x
 ox1kvVP+sRV7WCxAh6P+LVzQUQvYxhBu/TDP0q6GpDSq3cq9RK51op7u2OK2ZtApBd/ghdNbLfS
 /PFidrzjk/WUZUltnA3wIClpVjw==
X-Google-Smtp-Source: AGHT+IFGvGcJrzHob4stoVa8yArOOKmCQjDSWHCLpif3ypbTpKvU2DNCbYdIFucFfcroh0IjvnzY7w==
X-Received: by 2002:a92:c24b:0:b0:3d4:337f:121c with SMTP id
 e9e14a558f8ab-3d97c182360mr6369495ab.10.1746133658742; 
 Thu, 01 May 2025 14:07:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a9140e2sm49190173.37.2025.05.01.14.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:07:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 18/18] hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported
 field
Date: Thu,  1 May 2025 23:04:56 +0200
Message-ID: <20250501210456.89071-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The X86IOMMUState::pt_supported boolean was only set in
the hw_compat_2_9[] array, via the 'pt=off' property. We
removed all machines using that array, lets remove that
property and all the code around it, always setting the
VTD_ECAP_PT capability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86-iommu.h |  1 -
 hw/i386/amd_iommu.c         | 12 ++----------
 hw/i386/intel_iommu.c       | 13 ++-----------
 hw/i386/x86-iommu.c         |  1 -
 4 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index bfd21649d08..d6e52b1eb6b 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -63,7 +63,6 @@ struct X86IOMMUState {
     SysBusDevice busdev;
     OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
-    bool pt_supported;          /* Whether vIOMMU supports pass-through */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2cf7e24a21d..516e231bf13 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c980cecb4ee..cc08dc41441 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1066,6 +1066,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
 {
     switch (vtd_ce_get_type(ce)) {
     case VTD_CONTEXT_TT_MULTI_LEVEL:
+    case VTD_CONTEXT_TT_PASS_THROUGH:
         /* Always supported */
         break;
     case VTD_CONTEXT_TT_DEV_IOTLB:
@@ -1074,12 +1075,6 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
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
@@ -4520,7 +4515,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
              VTD_CAP_MGAW(s->aw_bits);
     if (s->dma_drain) {
@@ -4548,10 +4543,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
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
index d34a6849f4a..ca7cd953e98 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
-    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
 };
 
 static void x86_iommu_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


