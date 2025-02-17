Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D3BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1Kl-0007pl-PA; Mon, 17 Feb 2025 08:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk1KW-0007hR-O8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tk1KR-0002Cl-0g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739799509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6Q3/4kBd6uZrg2PFq/lKlbRT35bb/VWc43lgrQZIFQ=;
 b=RJHcJGuZ9IXOcyKovyYJE8vAP7aynADK9DAWtPXFoiIxiJAI6Qd2dAiz2CbhZLW8TYUHkc
 Z/ly/rlcgwOPmviJHRvojTq6caZtNChT3dJNUo7IkSFVb9MKzQinEb9aBFwGtOv6wu4wtD
 mh2FZxhdczypEmOd5R2+UyDOlhrJVrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-Js9VRgwuP9O8vKGh1-C53w-1; Mon,
 17 Feb 2025 08:38:23 -0500
X-MC-Unique: Js9VRgwuP9O8vKGh1-C53w-1
X-Mimecast-MFC-AGG-ID: Js9VRgwuP9O8vKGh1-C53w_1739799502
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD90B19783B5; Mon, 17 Feb 2025 13:38:22 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B16C41800360; Mon, 17 Feb 2025 13:38:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH v2 5/5] docs/devel/reset: Document reset expectations for DMA
 and IOMMU
Date: Mon, 17 Feb 2025 14:36:49 +0100
Message-ID: <20250217133746.6801-6-eric.auger@redhat.com>
In-Reply-To: <20250217133746.6801-1-eric.auger@redhat.com>
References: <20250217133746.6801-1-eric.auger@redhat.com>
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

To avoid any translation faults, the IOMMUs are expected to be
reset after the devices they protect. Document that we expect
DMA requests to be stopped during the 'enter' or 'hold' phase
while IOMMUs should be reset during the 'exit' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 docs/devel/reset.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index adefd59ef9..0b8b2fa5f4 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -143,6 +143,11 @@ The *exit* phase is executed only when the last reset operation ends. Therefore
 the object does not need to care how many of reset controllers it has and how
 many of them have started a reset.
 
+DMA capable devices are expected to cancel all outstanding DMA operations
+during either 'enter' or 'hold' phases. IOMMUs are expected to reset during
+the 'exit' phase and this sequencing makes sure no outstanding DMA request
+will fault.
+
 
 Handling reset in a resettable object
 -------------------------------------
-- 
2.47.1


