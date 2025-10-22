Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C851CCF9E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXo3-0000zM-42; Wed, 22 Oct 2025 08:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXo0-0000yp-BH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXny-00071W-EV
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/vHRPUGqrgjZdNlDXp3raXYca232VkVWeH0CgAlUCo=;
 b=XT2KGwUPA7f/b6UnCtcdRIpOEn9JijBp71jDhbTz0Nuf+EMnJcKxd0hoHrJq+7i3VUCSaF
 0ihK5m/9BJb3dC1meYNSNYMZirm0TOlKtZsn52yR+o1LnBSfJ50QTDqxA3iDBpS7wa9X10
 YMSPb5TPbEOu+guh6UP/OmN8k6XeI5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-E2Xfwm_SNtitePvU3StDeg-1; Wed,
 22 Oct 2025 08:18:57 -0400
X-MC-Unique: E2Xfwm_SNtitePvU3StDeg-1
X-Mimecast-MFC-AGG-ID: E2Xfwm_SNtitePvU3StDeg_1761135536
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C76A1954190; Wed, 22 Oct 2025 12:18:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 355891800451; Wed, 22 Oct 2025 12:18:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/12] vfio/cpr-legacy: drop an erroneous assert
Date: Wed, 22 Oct 2025 14:18:36 +0200
Message-ID: <20251022121846.874152-3-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_legacy_cpr_dma_map() is not only used in post_load on destination
but also error recovery path on source side. Assert it for destination
is wrong.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250928085432.40107-3-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-legacy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index b4581e8f859323c1c45560f7d345b34f1ed9bd85..7184c9399128e71a658da51ba10c2440f1e54d92 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -52,8 +52,6 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
         .size = size,
     };
 
-    g_assert(cpr_is_incoming());
-
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
         return -errno;
     }
-- 
2.51.0


