Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A876C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 16:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUqoT-0002LF-9P; Fri, 19 Jul 2024 12:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sUqoR-0002KX-SE
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sUqoN-0007pW-J9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721407822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fDGEhgETPFGWm1mU0kUKJSfa5SsMMKk3fUWrUk/6QkM=;
 b=aKHXfwVdMBvaTl/fP51ydB8EuASZ6jsA5EMHfEToGYr5mAk/sWNETUP6+qtd3lhCNzYh7W
 xzrY1CKWlIAD6d4sElEsmk4CIlf7t2FGC/QhMwD+MoJ77hpOx+Rp1Key2e3/CdMfNPfYdp
 rEMPg/j0NqQJlW5PI4nXGrodBuNQWnY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-fDXLnDiLNESg4BvFu0uklA-1; Fri,
 19 Jul 2024 12:50:20 -0400
X-MC-Unique: fDXLnDiLNESg4BvFu0uklA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85B9D1955D42; Fri, 19 Jul 2024 16:50:19 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 333891955F40; Fri, 19 Jul 2024 16:50:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH] hw/vfio/container: Fix SIGSEV on
 vfio_container_instance_finalize()
Date: Fri, 19 Jul 2024 18:50:11 +0200
Message-ID: <20240719165011.1751831-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In vfio_connect_container's error path, the base container is
removed twice form the VFIOAddressSpace QLIST: first on the
listener_release_exit label and second, on free_container_exit
label, through object_unref(container), which calls
vfio_container_instance_finalize().

Let's remove the first instance.

Fixes: 938026053f4 ("vfio/container: Switch to QOM")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/container.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 425db1a14c..d8b7c533af 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -657,7 +657,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     return true;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
-    QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     memory_listener_unregister(&bcontainer->listener);
     if (vioc->release) {
-- 
2.41.0


