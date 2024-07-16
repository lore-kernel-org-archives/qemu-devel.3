Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED3CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTels-0006Sy-UP; Tue, 16 Jul 2024 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelo-0006CB-Lf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTeln-0000Od-Bi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvRk7/vnzWK99OFXCu80rCuujpBBeYujjUCGgbqJY8E=;
 b=O4LIpT229IKt2jUnWpagfrSZ7C72fHlBCZLKcRee2mF7cwmkn9XvE03hAnNqj1E6N+YDNO
 8diFGK9O29mdD1ZScFGOAC9VvpyPtdyNpi0OfW6eGHhaIbA+NUDIupidh8m8ZcSqo5Rka1
 zJBL6F9Q24DabTUax3mSCyohN5HG+Ng=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-nbLm-52IOC2sG1xBSU7uLg-1; Tue,
 16 Jul 2024 05:46:49 -0400
X-MC-Unique: nbLm-52IOC2sG1xBSU7uLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B281955D63; Tue, 16 Jul 2024 09:46:48 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45513300018E; Tue, 16 Jul 2024 09:46:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH 4/6] virtio-iommu: Remove the end point on detach
Date: Tue, 16 Jul 2024 11:45:06 +0200
Message-ID: <20240716094619.1713905-5-eric.auger@redhat.com>
In-Reply-To: <20240716094619.1713905-1-eric.auger@redhat.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We currently miss the removal of the endpoint in case of detach.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2de41ab412..440dfa6e92 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -786,6 +786,7 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
     if (QLIST_EMPTY(&domain->endpoint_list)) {
         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
     }
+    g_tree_remove(s->endpoints, GUINT_TO_POINTER(ep_id));
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
2.41.0


