Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE35C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHd-00072I-5R; Mon, 14 Jul 2025 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGs-00056O-JZ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGq-0005Zh-MG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY1CafZoPIMOlw/PLwu/eKU/EDB03DMpyVt647qA4CY=;
 b=az0e0lVchND8xE7rJr2wcUCHm3lyzkA4k7aG/uJRIuBV1UDpix3fcIjDRyS/r/poCdwuIf
 idNwC8NsuQeR0XtQg+KWPUeNLzkqllrExpFo5/pKZ/dAD62dVPpQRCAfIAZB7bbkDiexvs
 lp6k74JMQIFsG0n0n3LowJeS0iX++BM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-_dugEBA7MVO0qakTdqpjSg-1; Mon, 14 Jul 2025 19:07:38 -0400
X-MC-Unique: _dugEBA7MVO0qakTdqpjSg-1
X-Mimecast-MFC-AGG-ID: _dugEBA7MVO0qakTdqpjSg_1752534458
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561bc2f477so9107445e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534457; x=1753139257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY1CafZoPIMOlw/PLwu/eKU/EDB03DMpyVt647qA4CY=;
 b=qiv9gWED1li7HJucDB/o65omZd1V+DPUXh4fzk3Jiyc8moWzhF/RkSHNgfiU/tEvOa
 RJ3vfN8A+TDblTPu/CFMqoxmshCjPlEx0jRIvg6N56sFONXfIkNHryHMID6j0U+fQzG6
 5PAlxL/aBEP6w+935etQCUJM55hnp02EWqXwx9otjjMlBaVIIZIixhd+bQuyQ9T4rITI
 vXst/EGB2xdSCQpxQuCqc4hmw10/3J7RMq+bY2EAL+BigG+XQEpnZK8Ntp4ewnRXSMW4
 SEvajIGVGCU/qkRD+mMYhJH/ZHEurj7f4ohxkfAr7EsHhggzPmVdi4uCaFcwru4P+sDL
 ssHg==
X-Gm-Message-State: AOJu0Yw2WmzspmJ92Zpl82g9Gfr/pIVvPJ3nzMQna4N3DWnzLoigjAHn
 8qKjg2YEF2s5NWnsJP6cCFDtBc9WrzBddnTJFTVblA+VF7gsyc4PNeBADt8aFWC6o3+WyW1SjSk
 4ILMUDhisO/F/num8NnKbTmZAy3pjEp/0HxZblL6jprGxMffQgP6htweKlZyiYfeshRuPlTEah7
 oIHv8ACqvyBXZX2Y/KdZz6APqfahPU0CufCQ==
X-Gm-Gg: ASbGncuo5W/Pez0Nse4WYvfkvDZyQMPLHgAzBKHQZK2sj+xWwffVUA8mAn0rm9nMWq4
 WEKWlmXAVs22IvZLy9cyGWXUilkoMyTYwp9w5OvtCQNqQRzOQBDTYdo2rCNlPWSIuHhY5n1igE3
 aZVsvaJRnvvStpRi3k1k9oVmnXkCcRjj96GkyOgIj4cTPKfR52OvWLMSQeNAs97ECSrkFZ7w+S0
 p4mj/+tRyIi8y7an7lBbXBGgmqsQgAg2ZcM0gM2Ag+QySsVOZYNSCGlWzXyRPgh5eQdql9UdGEY
 DG5ZGxc5Gk6OGWRpFC8K4zh8t16k4RCv
X-Received: by 2002:a05:600c:5304:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-456207efef8mr37274975e9.4.1752534457334; 
 Mon, 14 Jul 2025 16:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcFYybJggufEbzOX96y2d2esVowJa8RFy3Jo8JJYmaYVQSByVesTs8TgD2sFEsOnGtO76Xcg==
X-Received: by 2002:a05:600c:5304:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-456207efef8mr37274715e9.4.1752534456835; 
 Mon, 14 Jul 2025 16:07:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2025sm13799780f8f.31.2025.07.14.16.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:35 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 32/97] intel_iommu: Fill the PASID field when creating an
 IOMMUTLBEntry
Message-ID: <6d968a2728ec46bb18eaa4c7e5f1ccea8987927f.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

PASID value must be used by devices as a key (or part of a key)
when populating their ATC with the IOTLB entries returned by the IOMMU.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-5-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 69d72ad35c..0fb4350d48 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2503,6 +2503,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                         .translated_addr = 0,
                         .addr_mask = size - 1,
                         .perm = IOMMU_NONE,
+                        .pasid = vtd_as->pasid,
                     },
                 };
                 memory_region_notify_iommu(&vtd_as->iommu, 0, event);
@@ -3090,6 +3091,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
     event.entry.iova = addr;
     event.entry.perm = IOMMU_NONE;
     event.entry.translated_addr = 0;
+    event.entry.pasid = vtd_dev_as->pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
 
@@ -3672,6 +3674,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb = {
         /* We'll fill in the rest later. */
         .target_as = &address_space_memory,
+        .pasid = vtd_as->pasid,
     };
     bool success;
 
-- 
MST


