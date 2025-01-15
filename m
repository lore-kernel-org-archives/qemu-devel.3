Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5FFC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qG-0007JS-Da; Wed, 15 Jan 2025 13:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pa-0006en-BJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pY-0006dc-2Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb1uDbXRRItaCpZXeSioPd9EkaMevm8T9RBXmZ42Yp8=;
 b=F4GYEtXktc76/fsPOCxA7SN5+vcdwyrvKeN8ag0Fw6sbadaaF+Ms91Dkj3CWcmqbKwym3u
 e6nSI/RWrJ5hoOv6eZoXREmNZUVQi43Sjpbf3QoulAFWvdGMLh4UCC+PDAcWJqks8s5H/b
 MOMqr1Oezk/3fb7xUIMMmWIDDD0TD/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-dujXYjqzM0u4K3ERkiapdg-1; Wed, 15 Jan 2025 13:09:25 -0500
X-MC-Unique: dujXYjqzM0u4K3ERkiapdg-1
X-Mimecast-MFC-AGG-ID: dujXYjqzM0u4K3ERkiapdg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e2579507so36297f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964564; x=1737569364;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cb1uDbXRRItaCpZXeSioPd9EkaMevm8T9RBXmZ42Yp8=;
 b=HFgE1eY7kuN0oShOlghZ+BEl1LnVxVOACZK+yIGzIN49ggbHTGFJQPl0CXQI3kYjKm
 qU24YKSSSXLu6HnsXKGgtCdd3dRtMvNN8Azo0CJdvxiQ68MFiase6k/2N7R62fzlBpbn
 P2fjEkVGnIAR+WOnVr/KtqxVRAJ8b36ynJgYYZhd02WUQmqfIZV4eNteGza9FJMnPruW
 fSQ0bo/8+ZvU7VJT7j6n52JZIgr1+Y9hLbpsXjiUSD/jSjw/OrQTyw7fWHbedaiM8by/
 ILY9Y4SAAmEOo/1hkpD9mPu9T1hM+vUI2mPdtTi66I3r/4cGE/zdoIN9P9Nm99Q8FBFD
 Rtlw==
X-Gm-Message-State: AOJu0YxHLohTtUYckYKvOVQNTreFQOqx1231Ym8YmPGCUKb43+FMrAWU
 V2ZA4SzkwasV+6r8O1antTOxjSO4UpPHqlCWDpnSYP12/vs8btwB/UTNQ9h2V3UjoWWkbAMcOmV
 th6yT+6v7eyYzB/sQscacHB+/O0qfg1ddp5qJ92Pa4oOoHl634ukjIqfLoKUMiV0ENKMfteg8w8
 zSd+2qj3KAhfOHk6O//L/h2JWIAoCrpA==
X-Gm-Gg: ASbGncuOT+jhH0EzaokMoTqraDyMY7Tx8DJfK9b6GJgdrdaqO73p5YnbxbSpjOGlpzL
 5KffCE/ASFGi8eEcRPWEsmV739H+Yp63TlQ4rLw7opSVyWq0Fcmc9r0WprsX2H4Y2HpNbVg1ShT
 9ugx+N3thhiF38mnS844v0La6aybTXY8ydmZEP6YMpDW2GyI0fOm/aoDINvVZ4A78uwFqd2RjUY
 QO1S2eUH28QY0qtUBYUYoIScSipThMounVfLxToOPzGyXuvOawv
X-Received: by 2002:a05:6000:18a4:b0:38a:a043:eacc with SMTP id
 ffacd0b85a97d-38aa043ee63mr13471003f8f.1.1736964563965; 
 Wed, 15 Jan 2025 10:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsQagTnv3I232z/fF9csz2PfqcKqFVckBWArMJFh1/V1+WthI3USsAGzvwQvuny/3VxqL0FQ==
X-Received: by 2002:a05:6000:18a4:b0:38a:a043:eacc with SMTP id
 ffacd0b85a97d-38aa043ee63mr13470976f8f.1.1736964563583; 
 Wed, 15 Jan 2025 10:09:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac707sm31022335e9.15.2025.01.15.10.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:22 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/48] intel_iommu: Add an internal API to find an address
 space with PASID
Message-ID: <1075645d430e291404d19c88fc80d989669fa4c8.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

This will be used to implement the device IOTLB invalidation

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241212083757.605022-13-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c45a486bf8..9aa807593e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -70,6 +70,11 @@ struct vtd_hiod_key {
     uint8_t devfn;
 };
 
+struct vtd_as_raw_key {
+    uint16_t sid;
+    uint32_t pasid;
+};
+
 struct vtd_iotlb_key {
     uint64_t gfn;
     uint32_t pasid;
@@ -1859,29 +1864,32 @@ static inline bool vtd_is_interrupt_addr(hwaddr addr)
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
 }
 
-static gboolean vtd_find_as_by_sid(gpointer key, gpointer value,
-                                   gpointer user_data)
+static gboolean vtd_find_as_by_sid_and_pasid(gpointer key, gpointer value,
+                                             gpointer user_data)
 {
     struct vtd_as_key *as_key = (struct vtd_as_key *)key;
-    uint16_t target_sid = *(uint16_t *)user_data;
+    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
     uint16_t sid = PCI_BUILD_BDF(pci_bus_num(as_key->bus), as_key->devfn);
-    return sid == target_sid;
+
+    return (as_key->pasid == target->pasid) && (sid == target->sid);
+}
+
+static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
+                                                    uint16_t sid,
+                                                    uint32_t pasid)
+{
+    struct vtd_as_raw_key key = {
+        .sid = sid,
+        .pasid = pasid
+    };
+
+    return g_hash_table_find(s->vtd_address_spaces,
+                             vtd_find_as_by_sid_and_pasid, &key);
 }
 
 static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
-    uint8_t bus_num = PCI_BUS_NUM(sid);
-    VTDAddressSpace *vtd_as = s->vtd_as_cache[bus_num];
-
-    if (vtd_as &&
-        (sid == PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn))) {
-        return vtd_as;
-    }
-
-    vtd_as = g_hash_table_find(s->vtd_address_spaces, vtd_find_as_by_sid, &sid);
-    s->vtd_as_cache[bus_num] = vtd_as;
-
-    return vtd_as;
+    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
 }
 
 static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
-- 
MST


