Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F168C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc4c-00013q-OU; Fri, 04 Jul 2025 04:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4I-0000Rg-JZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4G-0001TF-9U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCPfFcP9oUXLZaiFPDdAPRro3sCjt0xf3z+EAHTgsxo=;
 b=CjROZgHxJ6pxKH+ZX4GHHeN1lNwkYS1EJktciI3ydDGSxQayJvngi1lKcZVjw7Axhm/+cv
 UCTYJzTuT6pMHcDORov6xR1VAP/ZfmvguznzPqs5LIbdUJVMQEn7mWRebJkzKzjxDfOC1g
 GZ37nKc1F+00vYBWGkP4yZeGnxdIrTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-b3e20PBPMayy0-Wff0XAYg-1; Fri,
 04 Jul 2025 04:46:46 -0400
X-MC-Unique: b3e20PBPMayy0-Wff0XAYg-1
X-Mimecast-MFC-AGG-ID: b3e20PBPMayy0-Wff0XAYg_1751618805
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64167180028D; Fri,  4 Jul 2025 08:46:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B0B195E74A; Fri,  4 Jul 2025 08:46:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/27] vfio/container: delete old cpr register
Date: Fri,  4 Jul 2025 10:45:27 +0200
Message-ID: <20250704084528.1412959-27-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

vfio_cpr_[un]register_container is no longer used since they were
subsumed by container type-specific registration.  Delete them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-21-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  4 ----
 hw/vfio/cpr.c              | 13 -------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 287837249589e269f87e33ba2635e8682a764e82..80ad20d2169086052b66d0df526406b8de7985d4 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -45,10 +45,6 @@ void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
 
-bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
-                                 Error **errp);
-void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
-
 bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
                                          Error **errp);
 void vfio_iommufd_cpr_unregister_container(
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0e903cdd2f7071a363eecd4ec8784b6f9c8f7e1d..af0f12a7adf5a3bc331afcedae3a4e23309e4d2e 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -29,19 +29,6 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
-{
-    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
-                                vfio_cpr_reboot_notifier,
-                                MIG_MODE_CPR_REBOOT);
-    return true;
-}
-
-void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
-{
-    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
-}
-
 #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
     g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
 
-- 
2.50.0


