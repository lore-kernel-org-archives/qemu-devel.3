Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D055606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3R3Uypu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxnw-00041z-Dj; Fri, 27 Nov 2026 10:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxnv-00040B-2j
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxnt-0000NO-Gp
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 10:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795793041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOkuwtRdx773n3D8VJSyKBTOUkFO8NaKaymLH0+m48Y=;
 b=C3R3Uypuu/4Qx5WA+3hI66tLhCCgykJGsvHxTwNzcjn/yfD0Pu5ZHV5rVUqBFufyNIc/Bm
 m1yXluafdBk4OJvzScSKT5VdH23SeUU80vd+v59iEXEptw7dpOSiG4kIiZC+a1CEJygtfa
 29OAvrxSjPz++XGceExTtY7o3idR2dk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-fzMYQSRlOkmmeGKDafh9Mg-1; Fri,
 27 Nov 2026 15:23:58 +0000
X-MC-Unique: fzMYQSRlOkmmeGKDafh9Mg-1
X-Mimecast-MFC-AGG-ID: fzMYQSRlOkmmeGKDafh9Mg_1795793038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C77A1955F19; Fri, 27 Nov 2026 15:23:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE46718004FC; Fri, 27 Nov 2026 15:23:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 630A321E692D; Fri, 27 Nov 2026 16:23:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowangio@gmail.com,
	mst@redhat.com,
	Nikolay N Zorin <zorin@swemel.ru>
Subject: [PATCH 1/1] virtio-net: Fix crash in reporting of
 virtio_net_get_vhost() failure
Date: Fri, 27 Nov 2026 16:23:54 +0100
Message-ID: <20261127152354.626137-2-armbru@redhat.com>
In-Reply-To: <20261127152354.626137-1-armbru@redhat.com>
References: <20261127152354.626137-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost_user_net_save_state() and vhost_user_net_load_state() pass
@local_error to error_reportf_err() when virtio_net_get_vhost()
failed.  @local_error is null then.  Use error_report() instead.

While there, tidy up extra space in a nearby error message.

Fixes: 60f543ad917f ("virtio-net: vhost-user: Implement internal migration")
Reported-by: Nikolay N Zorin <zorin@swemel.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/net/virtio-net.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 36edb768b17..6ebc5b1d2fc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3587,9 +3587,8 @@ static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
 
     vhdev = virtio_net_get_vhost(vdev);
     if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+        error_report("Error getting vhost back-end of %s device %s",
+                     vdev->name, vdev->parent_obj.canonical_path);
         return -1;
     }
 
@@ -3615,16 +3614,15 @@ static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
 
     vhdev = virtio_net_get_vhost(vdev);
     if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
+        error_report("Error getting vhost back-end of %s device %s",
+                     vdev->name, vdev->parent_obj.canonical_path);
         return -1;
     }
 
     ret = vhost_load_backend_state(vhdev, f, &local_error);
     if (ret < 0) {
         error_reportf_err(local_error,
-                          "Error loading  back-end state of %s device %s: ",
+                          "Error loading back-end state of %s device %s: ",
                           vdev->name, vdev->parent_obj.canonical_path);
         return ret;
     }
-- 
2.55.0


