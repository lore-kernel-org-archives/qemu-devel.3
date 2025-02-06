Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB7C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2nD-0002G9-04; Thu, 06 Feb 2025 09:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg2nB-0002FG-0r
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tg2n9-0006ne-8M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738851818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZbyIXKI1FZ4Jn6pIwE6+ydtpYa2SRS3JE57gu/CUhA=;
 b=g5b1tBe1lYNK0e+s+42O+erSXeqTlaXXHo/8nTaaLXk9WfSXJlzYXIbNF2gdim04e3PO2r
 u/UHipALHzMECZW36sHUGQeYGhaIgxKdssv7OJBiS7HbaXliRZFu5SgjpojodJ7ukOr8Zi
 uR4/RjuabA1/J0mDi7IAS+XPKr4g3kA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-R_3ApZWdPwSVLanzbywnhw-1; Thu,
 06 Feb 2025 09:23:37 -0500
X-MC-Unique: R_3ApZWdPwSVLanzbywnhw-1
X-Mimecast-MFC-AGG-ID: R_3ApZWdPwSVLanzbywnhw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79CD31800875; Thu,  6 Feb 2025 14:23:36 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EF051800360; Thu,  6 Feb 2025 14:23:28 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH 3/5] hw/i386/intel_iommu: Tear down address spaces before
 IOMMU reset
Date: Thu,  6 Feb 2025 15:21:54 +0100
Message-ID: <20250206142307.921070-4-eric.auger@redhat.com>
In-Reply-To: <20250206142307.921070-1-eric.auger@redhat.com>
References: <20250206142307.921070-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

No bug report for this, but logically tearing down of existing address
space should happen before reset of IOMMU state / registers, because the
current address spaces may still rely on those information.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 21a8bf45f8..1bd9ae403b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4702,8 +4702,8 @@ static void vtd_reset_exit(Object *obj, ResetType type)
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(obj);
 
     trace_vtd_reset_exit();
-    vtd_init(s);
     vtd_address_space_refresh_all(s);
+    vtd_init(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.47.1


