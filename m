Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C53C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHt-0000Wd-IO; Mon, 14 Jul 2025 19:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGw-0005Yl-R2
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGv-0005ai-Ab
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HayVIjzAuMFMde366rDMxb9WI+k5iPArbzwUirFkhKc=;
 b=XZ4vGV0ZkO5PF9HqpQ1ZqcmzqWKMm7O+Ftoj8nDbGpDLfQuTTqvtC3YEQ/h8B7/YQs6s5O
 a7eXd8YC/d6f1aNOzdVr2a2lN2uEwFWMvXaEzwm/MXa2x7DFRbwQq/7RWCLC9jyvwD+MSJ
 GTqrEVqw7L9oxC6C3i0vxJESWqDzcsk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-OMPWg11INdmIjCiP_BMkaQ-1; Mon, 14 Jul 2025 19:07:43 -0400
X-MC-Unique: OMPWg11INdmIjCiP_BMkaQ-1
X-Mimecast-MFC-AGG-ID: OMPWg11INdmIjCiP_BMkaQ_1752534462
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b604541741so926399f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534462; x=1753139262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HayVIjzAuMFMde366rDMxb9WI+k5iPArbzwUirFkhKc=;
 b=WlSb3mHQtubFyfLd5DZm/Q6eKqn8RSIXEsBrAuoZZpc8HM9yEeUciSPqtNW4eq+Atl
 4v12zRP6/AZZi5grhKhVGp88ZJ0ZYJMC3bZM/P6FNE9iOXVL51ApZGuBjW1Oc/p1qbcb
 81x0sw3sswtHMFCCC8NhDWM7/KKMJfOJg++cGgxrQjI391mTMzJa2bjrL0P2IIlQCEPd
 hhIovzZrxJifHYLfY2XBkV4eCERh7FxDnrvIffeCGKIUsjkqfPBuZtqmFGZbiWwc3ZB6
 wbLVZh0QbkpNgsSKS+tB5vmcqruZ9v8FSoP/b5GgNxuNDDaoTcceWzj4/XohhxAnC2Ts
 66CA==
X-Gm-Message-State: AOJu0YytVwoAc3vJlovygJGys1vaY3izz5JxyHMa8+nKCopQpSJG7vx3
 +Z/XAAdInZeB28OJMCuiz5RnxhAoxzXhs4W6yowEDc+NEdbj+A8cz8LYIfyiexDBSP+LCg7+Ht0
 /yLSHdgYGi++35o4gCBrHb07xFxdX4cWeVSbtelT78mlfMNvXzeq9Y9qdql3zlTYUcF8ItTeaVL
 cyIjYAZC8VhxPUqL6nXICw0WsBRH/a65xXjQ==
X-Gm-Gg: ASbGncs+WsrfAiKxIAPQmxMpAjfxYaQXrQo9BtL/vqIRQ6pUiXx/YEQ5rJ+BiGFmPo1
 8Sqa1OT5yXvVZUiGTh+e9B0UWToQfBuMlTG6HeSFXaA2ARZ6bGNg1v9RcJx5++yxlRhfZr5SLFY
 4jK7pDHlsYyOLge0DfTm4eajjU2/VW3EHX1rbKBXaNhQGbop8x0WnQAlKhGPFy4qq4BkaSMwrLb
 qGETEsjoWq/j5bEbEOLc8tWg46VmH/Q2o9yvkqlRcMBwfY8nRFtvFTFptbLzejJbGMnvxNsXCRr
 VPYYR+9r5sAgznrngrnQkP+ZeFSoYdGQ
X-Received: by 2002:a05:6000:1a85:b0:3a6:d7e9:4309 with SMTP id
 ffacd0b85a97d-3b5f2e1b7c9mr11408937f8f.29.1752534462147; 
 Mon, 14 Jul 2025 16:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcA0V1PSlQEy/73nklhQV5wQuTs8JHELTpaahLdOBjrOFTLkOAMv5zJvhbCNOmviEHzZmfGA==
X-Received: by 2002:a05:6000:1a85:b0:3a6:d7e9:4309 with SMTP id
 ffacd0b85a97d-3b5f2e1b7c9mr11408919f8f.29.1752534461697; 
 Mon, 14 Jul 2025 16:07:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561dd91072sm32582915e9.14.2025.07.14.16.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 34/97] intel_iommu: Implement vtd_get_iotlb_info from
 PCIIOMMUOps
Message-ID: <ed916128d87a043d6024cf220532a91ea173e451.1752534227.git.mst@redhat.com>
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-7-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 71497f1936..affa7768e6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4733,10 +4733,20 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static void vtd_get_iotlb_info(void *opaque, uint8_t *addr_width,
+                               uint32_t *min_page_size)
+{
+    IntelIOMMUState *s = opaque;
+
+    *addr_width = s->aw_bits;
+    *min_page_size = VTD_PAGE_SIZE;
+}
+
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
     .set_iommu_device = vtd_dev_set_iommu_device,
     .unset_iommu_device = vtd_dev_unset_iommu_device,
+    .get_iotlb_info = vtd_get_iotlb_info,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
MST


