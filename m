Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59298EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9w-0006gK-Ak; Wed, 04 Feb 2026 14:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9t-0006Rz-IY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9r-0007kn-Sn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iYHpq6gBH13+yNuTw9POcqr/nFbgK0msqGQRhhW0KQM=;
 b=Uiuh28cLTJlGSKDo5jdY9XoSVI+chP/FRobKV0+94SS4Ng/AU7qVZf7MDLEXqBGEGGrB9e
 zBPLe94vTa0qyNvND4AvS/7k7I4toGPR3SRcF2ulHzHSQHBWu2tYdVGmSILZsqe95rD84e
 ZAmrJxdx6j0EvnHTUCIVNDgUVmLWgk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-s47mjBugNUWEXEA-CvoeHg-1; Wed, 04 Feb 2026 14:03:21 -0500
X-MC-Unique: s47mjBugNUWEXEA-CvoeHg-1
X-Mimecast-MFC-AGG-ID: s47mjBugNUWEXEA-CvoeHg_1770231800
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so1268265e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231800; x=1770836600; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iYHpq6gBH13+yNuTw9POcqr/nFbgK0msqGQRhhW0KQM=;
 b=RcfxAfBBuPwVblmalKsDz9UjzLmFkSUIjAFLHV05TtYA07YlXOBY7Co4ozWtmS7hDT
 k42pAt55VJbuAGqCKiB6oJNgUDghhSuts051R9HbjOu4V4P31l1UvHqv1QIWrxegKXuy
 uldT4JMzISYjNRpPiWppgtOQA3jjUw01mkdriXEiVn9Cw7jjpC7vehGxjOz+u2XXUlAC
 wluyZ6ttqagvhsPTeKAI7zeHVzR+RaMOONVVKKdcBlBwwSKg1/6WoVzgNM97AUQ5XH+A
 fe1Ba3gFXcz4kqloG+azvxbwgCLIJiFbbV3JBiNvNhxvtfzAWUBXBIFAIewnGYZWbZ+9
 zQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231800; x=1770836600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYHpq6gBH13+yNuTw9POcqr/nFbgK0msqGQRhhW0KQM=;
 b=cZh7bY/NkSxsa6WVbcf7kPEY9cleMYu2pqGETdx7S0gcacXcrlTFsMMILBq3qLtYY9
 wExfV1n5hQO+dncF+9uE3QR4elcpFRiX/Fd7v4ST+DBDUJKSt7okvqu3o/GLJ4VypmnL
 q+4F4cwn+W8O1Pzi/zf2mJbVEqnAQpy3AfY5Vclzyq2NaB0JJyYLkemKj6q1njav9vGy
 DTXZ3gH3rpZvXg89Mhdt+e7Waqms5hUgiIElsk8Ql3aQ2yw1bvLZKDcbEtLqtbdDuujS
 oKvCaBUth0JPFlo5jiq9y0JWhBOJb+kN/sinVB+m1QyUhzniy2GWR2JpXw79uGnmDQkD
 WRkw==
X-Gm-Message-State: AOJu0YxPBamVxuHBr5q8ZxD4qS7wATRGxxJLyF37dVLZ4tVtb5MLYcHW
 yLdVPHo3Zxs3ftw+wtxRiUeNbrfAPEC3ghTNHfrToUc5YkSsbZ1E1MSDmng5YB8xzCjUL+SGLMu
 RkMuB4QPT87jEjZ7Fld7N2Igivxgn8llsYCTy9azgP4BoS4tQh0HRFJ72PKgRCjxOcqmQ8xmPoF
 ZETWUa90jPSHjiLDaHZXI0HyFYq/wli76Itw==
X-Gm-Gg: AZuq6aKdsBs4LUmg9mFZrn2oUL0xkZJfclLtyvqgklk6/2AoG84fZY1HtAxpPr6inRn
 OYWB9zFOyGPMwX7RyhzcbBmjpnPJ+aWDplqV73Be/YZTfLIXb8UOgsY4mOQc+rCQZ1Hk6/bTLEL
 edIPhMZVt6BGTFk/ogatpNE3KXWn5D7kmWgBMHPOLFLgjDF/YGjqRvqgIogVCgJsE5rGuEqtPCX
 Nq9X9aGpUA9mLDW1g0rkRA4T+ZBUJXafePgOmSV+ld51zlpyasd/EMB0XGq3ijG9T3ksxyT0oiD
 +ylzABNlZeDIRgeZs1G6EcgrdCOGDo4ULSLWretXQo0k3zENrVCq40eTXueecxTEHv+30Dx2Uk1
 OTe4fott5x3iFBxIghFB4a6oB89c44rYW2Q==
X-Received: by 2002:a05:600c:1daa:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-4830e98ad5fmr55903825e9.34.1770231799724; 
 Wed, 04 Feb 2026 11:03:19 -0800 (PST)
X-Received: by 2002:a05:600c:1daa:b0:47a:9560:5944 with SMTP id
 5b1f17b1804b1-4830e98ad5fmr55903385e9.34.1770231799359; 
 Wed, 04 Feb 2026 11:03:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fc0a3bbsm50076705e9.1.2026.02.04.11.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:18 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 12/51] intel_iommu: Add an IOMMU index for pre-translated
 addresses
Message-ID: <bb64650c07ef1f604cd8443910392dcaf220b0e1.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-2-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 13 +++++++++++++
 hw/i386/intel_iommu_internal.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e8a6f50a5a..80b21a6468 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5601,6 +5601,17 @@ static const TypeInfo vtd_info = {
     .class_init    = vtd_class_init,
 };
 
+static int vtd_attrs_to_index(IOMMUMemoryRegion *iommu_mr, MemTxAttrs attrs)
+{
+    return attrs.address_type == PCI_AT_TRANSLATED ?
+            VTD_IDX_TRANSLATED : VTD_IDX_UNTRANSLATED;
+}
+
+static int vtd_num_indexes(IOMMUMemoryRegion *iommu)
+{
+    return VTD_IDX_COUNT;
+}
+
 static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
                                                const void *data)
 {
@@ -5609,6 +5620,8 @@ static void vtd_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->translate = vtd_iommu_translate;
     imrc->notify_flag_changed = vtd_iommu_notify_flag_changed;
     imrc->replay = vtd_iommu_replay;
+    imrc->attrs_to_index = vtd_attrs_to_index;
+    imrc->num_indexes = vtd_num_indexes;
 }
 
 static const TypeInfo vtd_iommu_memory_region_info = {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index a2ca79f925..be757c290d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -688,6 +688,13 @@ typedef struct VTDPIOTLBInvInfo {
 /* Bits to decide the offset for each level */
 #define VTD_LEVEL_BITS           9
 
+/* IOMMU Index */
+typedef enum VTDIOMMUIndex {
+    VTD_IDX_UNTRANSLATED = 0, /* Default */
+    VTD_IDX_TRANSLATED = 1,
+    VTD_IDX_COUNT = 2, /* Number of supported indexes */
+} VTDIOMMUIndex;
+
 typedef struct VTDHostIOMMUDevice {
     IntelIOMMUState *iommu_state;
     PCIBus *bus;
-- 
MST


