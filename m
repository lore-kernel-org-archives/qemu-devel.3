Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B1DD43FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 08:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCxHK-0001x0-L8; Mon, 18 Nov 2024 03:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGh-0001YT-MO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:38:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGg-000465-8j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731919075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFMW8k47U5OHurm3wQXHfDb8dU2AP+okgUT5HYiHDCc=;
 b=bpLxMWyk6RwGoizGhsYk5Ch/z2eH+fZdl834MNY4B6UJ2u1Dec/sPefPZfpl4vFPyhM4hR
 oAAO4rx2CljknhRXoybKXEALqz0Mcjlc60Q3i3+XZdTyjU5XPIQpCt5AJwLW0NvmuTl6gL
 bGDAEZLWEWJtTuYjqwqhTWsseZgWZgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-VlvcK9zbMZe7wNECLEo8QQ-1; Mon,
 18 Nov 2024 03:37:53 -0500
X-MC-Unique: VlvcK9zbMZe7wNECLEo8QQ-1
X-Mimecast-MFC-AGG-ID: VlvcK9zbMZe7wNECLEo8QQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4CD419560B2; Mon, 18 Nov 2024 08:37:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E09771956054; Mon, 18 Nov 2024 08:37:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 3/3] vfio/container: Fix container object destruction
Date: Mon, 18 Nov 2024 09:37:37 +0100
Message-ID: <20241118083737.174219-4-clg@redhat.com>
In-Reply-To: <20241118083737.174219-1-clg@redhat.com>
References: <20241118083737.174219-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When commit 96b7af4388b3 intoduced a .instance_finalize() handler,
it did not take into account that the container was not necessarily
inserted into the container list of the address space. Hence, if
the container object is destroyed, by calling object_unref() for
example, before vfio_address_space_insert() is called, QEMU may
crash when removing the container from the list as done in
vfio_container_instance_finalize(). This was seen with an SEV-SNP
guest for which discarding of RAM fails.

To resolve this issue, use the safe version of QLIST_REMOVE().

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: Eric Auger <eric.auger@redhat.com>
Fixes: 96b7af4388b3 ("vfio/container: Move vfio_container_destroy() to an instance_finalize() handler")
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 809b15767425a48f2404b08fc409ee5684af2094..6f86c37d971ec38426dacd471bca837c0d0df806 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -103,7 +103,7 @@ static void vfio_container_instance_finalize(Object *obj)
     VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
     VFIOGuestIOMMU *giommu, *tmp;
 
-    QLIST_REMOVE(bcontainer, next);
+    QLIST_SAFE_REMOVE(bcontainer, next);
 
     QLIST_FOREACH_SAFE(giommu, &bcontainer->giommu_list, giommu_next, tmp) {
         memory_region_unregister_iommu_notifier(
-- 
2.47.0


