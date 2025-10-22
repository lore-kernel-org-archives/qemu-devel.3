Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB71CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoG-000137-CM; Wed, 22 Oct 2025 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoE-00012O-9k
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoC-00073N-Et
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIgk14H79IoHwc8VkRMemli5WpxFeVxv6tNapfdMzPA=;
 b=Syi8RsX+tlM6dMl+SKwKOoUKq7kCnQKpP0NCPAsNJwfMqZIynXZgqSTyB5B1r4uNlZrEg6
 4RUGU1UU8+fioBGGS8L+FQdQ+lXgsB5sG11wTQCeKkraKhopM/ub9lRPy93GQwFAHMGLB3
 ccmZeXyXag7hfz4QFj9f75NwRTX9Ymk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-JFRAwkF6MiKjKacdLzt7sQ-1; Wed,
 22 Oct 2025 08:19:12 -0400
X-MC-Unique: JFRAwkF6MiKjKacdLzt7sQ-1
X-Mimecast-MFC-AGG-ID: JFRAwkF6MiKjKacdLzt7sQ_1761135551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32FDE1956089; Wed, 22 Oct 2025 12:19:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82C5A180044F; Wed, 22 Oct 2025 12:19:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/12] vfio/listener: Add an assertion for unmap_all
Date: Wed, 22 Oct 2025 14:18:42 +0200
Message-ID: <20251022121846.874152-9-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Currently the maximum of iommu address space is 64bit. So when a maximum
iommu memory section is deleted, it's in scope [0, 2^64). Add a
assertion for that.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251009040134.334251-4-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 1b6e5065a3267ab08d2d3fea3c5b4965a80947e8..2d7d3a464577ee258fac869e508e1b79aef2b53e 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -715,6 +715,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         bool unmap_all = false;
 
         if (int128_eq(llsize, int128_2_64())) {
+            assert(!iova);
             unmap_all = true;
             llsize = int128_zero();
         }
-- 
2.51.0


