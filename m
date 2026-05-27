Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D1CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDMP-0002eV-NL; Wed, 27 May 2026 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDMA-0002cH-CR
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wSDM3-0001IN-DW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779884840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ecoeh+dXW+2sbY1dM3bn6PVG7tvn/OHmgWQlApnH9Ls=;
 b=OmWAr/R6gWlMPMtjxQR0Dc6ziD+Ys1lAKZTvdfTDlpc8amRDXziAILLjWdIG7qdLuOJvny
 chh9YTy+oH8CIW2K1DySCmqu38OmF34mHBspgxgCs8rbCWp3AZXXHCtbnjHld2dAk2TVKa
 CAE5VpKBJq8W3r0U5Su5VXcSAnTjrh4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-rVzwigFqMIKtbQWe7KGEVQ-1; Wed,
 27 May 2026 08:27:16 -0400
X-MC-Unique: rVzwigFqMIKtbQWe7KGEVQ-1
X-Mimecast-MFC-AGG-ID: rVzwigFqMIKtbQWe7KGEVQ_1779884835
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D4F195608A; Wed, 27 May 2026 12:27:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D24230001BB; Wed, 27 May 2026 12:27:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/7] vfio-user: disconnect container when device info query
 fails
Date: Wed, 27 May 2026 14:26:57 +0200
Message-ID: <20260527122700.1589764-5-clg@redhat.com>
In-Reply-To: <20260527122700.1589764-1-clg@redhat.com>
References: <20260527122700.1589764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vfio_user_device_attach() connects the vfio-user container before querying
VFIO_USER_DEVICE_GET_INFO.  If the device info query fails,
vfio_device_prepare() has not run yet, so vbasedev->bcontainer is still
NULL and the later vfio_device_detach() cleanup path cannot reach the new
container.

Disconnect the container before returning the attach failure so the listener,
RAM discard state, object reference and address space reference are released
on this error path.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260522065637.4109499-1-zhaoguohan@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/container.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 796289a469033ef47fa7199dbe30d02f0ba83ada..dc23b06eebf1da5cccaab9b648becb986623213d 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -309,7 +309,12 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    return vfio_user_device_get(container, vbasedev, errp);
+    if (!vfio_user_device_get(container, vbasedev, errp)) {
+        vfio_user_container_disconnect(container);
+        return false;
+    }
+
+    return true;
 }
 
 static void vfio_user_device_detach(VFIODevice *vbasedev)
-- 
2.54.0


