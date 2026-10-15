Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C54CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSO-0002p3-EW; Thu, 15 Oct 2026 08:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSM-0002oH-TD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSK-0005IT-OV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fREmhUQtKJU3j1+MSYYCp5cEcdJ/20AGuBPbHsf21zQ=;
 b=VYPJM3PXqWZsSV3QI+BatTUZSUcIQ2Sb3+wImwg3XppD729bR0u5bKk2BUIPUrGPnUlEWN
 s2mO3lhPRMVXxbuko821u3Hg6wXKfqg+XsHr6M7S804mMrOWUVZLytiSagV5Qrx2+h5+Xb
 FHJ+WknGLALQCq+Y7E8xaN6oP2p2+DA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-avZnk_1bP4enoISQFdpmsg-1; Thu,
 15 Oct 2026 12:21:05 +0000
X-MC-Unique: avZnk_1bP4enoISQFdpmsg-1
X-Mimecast-MFC-AGG-ID: avZnk_1bP4enoISQFdpmsg_1792066864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9DE180062D; Thu, 15 Oct 2026 12:21:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E78A180057F; Thu, 15 Oct 2026 12:21:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hugo Komatsu <hugo.komatsu@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/8] vfio-user: reject failover during init
Date: Thu, 15 Oct 2026 14:20:50 +0200
Message-ID: <20261015122055.888209-4-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hugo Komatsu <hugo.komatsu@nutanix.com>

Virtio-net failover is a networking feature that relies on a primary
and standby device pair. This is not currently supported for vfio-user.
Refuse initialization if this property is set.

Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260813110731.80-1-hugo.komatsu@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e7573d4a9f088c1afc8ed2709932842247abf6ac..983e1d4ad470bfa887a3a60e88e2f255f0ed085a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -266,6 +266,11 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    if (pdev->failover_pair_id) {
+        error_setg(errp, "vfio-user: failover is not supported");
+        return;
+    }
+
     sock_name = udev->socket->u.q_unix.path;
 
     vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
-- 
2.56.0


