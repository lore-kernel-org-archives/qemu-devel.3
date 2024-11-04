Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F806D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Ij-0002V8-I9; Mon, 04 Nov 2024 16:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ie-0002Bf-PO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Id-0005PX-8K
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlEJlaD4rUuzda7f+a8uqDdCRzttqpEXwtLO90XFWes=;
 b=hECaGtn83+pob7Ae833LUY+dVPS2iJlG/Vrnch8Mr67LDYi7Eetiia1N3pttNKZFF7i7AC
 FW1W3ZlBK/p/p1+tL1iGfE/PzOmyTMy9beCsXApuBCH2U4Bpxyrxpcps+ucIi58Xlje8Ju
 gIqmsbrn0f1+CzKxUTyWP5nZwoRYIpU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-uOmstuEKPYmvZB70NbgKGA-1; Mon, 04 Nov 2024 16:07:45 -0500
X-MC-Unique: uOmstuEKPYmvZB70NbgKGA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so2040294f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754464; x=1731359264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlEJlaD4rUuzda7f+a8uqDdCRzttqpEXwtLO90XFWes=;
 b=DS2ifeZ+j4r43u6jNYyGHZbpJFiXbjVJmLtUCuP6bmkDq2HRSmlVoEKdRbNgx+dQvz
 LMK0E/ZqV8jeKfLayJLDN4ge+rtFuyKEHpMRGswPpaFC6Hxm9WyqiyCMS+AJksnNk5Ea
 Stshl56jIL8IqdHciYVA0JDQ5gQJIRZpn0N2FuIGDtFjE8ul2ZXdyJEcSUA60iHF/FbL
 N+bVxBlIbkce1y73PbC5wg9xkEqOTRMoxWxWs11h+NEypAfGZrDTU+YoUBC6ZXkNssmo
 VjAOHPXc457DWSen118En8/sX0mfg9f8wM/KqQicJtNZv4InTjCWzuEEv6vmDDl2KAZ0
 ewJw==
X-Gm-Message-State: AOJu0YwQDozKlS0b8Ul4p/16QklyU+nCp1b4RShOFQTD3ZNMC4AxAT54
 tA8q9ZXM4To9ekTgfRBMCzwuUXmRCGikA3v8rCfGzI47m5MD/82YgmwbQsdMAQRfhjA/WVMEKa9
 LbTvHkFmesUOorgNprOWi5wuI7pLNcXiX7ysptr7CfH1xD77XteLJQNQt3fZ4BfLpOIw6piyke8
 EIcLzobstK5pCgDh6qyZdvjcQ2Hcqzdg==
X-Received: by 2002:adf:e84f:0:b0:37d:4956:b0c2 with SMTP id
 ffacd0b85a97d-3806122f97emr23131446f8f.58.1730754463982; 
 Mon, 04 Nov 2024 13:07:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo0EeQBfWx0HoVLiVSOHZMoydRGICAHX+9E9mzd4tPJCajEwJMtYYqFdptKkUMDdamaW3m/A==
X-Received: by 2002:adf:e84f:0:b0:37d:4956:b0c2 with SMTP id
 ffacd0b85a97d-3806122f97emr23131427f8f.58.1730754463475; 
 Mon, 04 Nov 2024 13:07:43 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7bf7sm14347574f8f.9.2024.11.04.13.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:42 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 32/65] amd_iommu: Check APIC ID > 255 for XTSup
Message-ID: <b12cb3819baf6d9ee8140d4dd6d36fa829e2c6d9.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
to support vcpu w/ APIC ID > 255.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Message-Id: <20240927172913.121477-6-santosh.shukla@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 38297376e7..13af7211e1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
+#include "kvm/kvm_i386.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* AMD IOMMU with x2APIC mode requires xtsup=on */
+    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+        exit(EXIT_FAILURE);
+    }
+    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+        exit(EXIT_FAILURE);
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
MST


