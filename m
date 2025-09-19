Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFADCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZgL-0004db-C0; Fri, 19 Sep 2025 07:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZgI-0004RS-GV
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZg4-00019z-QS
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/nPgGoxBal0yhdLm799HPkz/9tEha6vwLh4qn0x4io=;
 b=ISD6ySah1p3G13D17ZpYEfvgmTEXUaeNyN1RYgLRxd1fXHP81LC0FZjyV6upc1jfdMeTiB
 wDPSjldfyZwGklGSfwa4wrpxAECczUexNzVMCTLdNfTXRnLYaEFC7COF1+tXlwsB+Var6J
 HDohvWjEQBBVxH3nRIWNslVN9itVkIQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-_QGoYI_lP0u-9i_WIN13rw-1; Fri,
 19 Sep 2025 07:53:14 -0400
X-MC-Unique: _QGoYI_lP0u-9i_WIN13rw-1
X-Mimecast-MFC-AGG-ID: _QGoYI_lP0u-9i_WIN13rw_1758282792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECDE3195608A; Fri, 19 Sep 2025 11:53:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E0E11955F21; Fri, 19 Sep 2025 11:53:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 16/16] util/vhost-user-server: vu_message_read(): improve error
 handling
Date: Fri, 19 Sep 2025 12:50:17 +0100
Message-ID: <20250919115017.1536203-17-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

1. Drop extra error_report_err(NULL), it will just crash, if we get
here.

2. Get and report error of qemu_set_blocking(), instead of aborting.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/vhost-user-server.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 04c72a92aa..1dbe409f82 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -62,7 +62,7 @@ static void vmsg_close_fds(VhostUserMsg *vmsg)
     }
 }
 
-static void vmsg_unblock_fds(VhostUserMsg *vmsg)
+static bool vmsg_unblock_fds(VhostUserMsg *vmsg, Error **errp)
 {
     int i;
 
@@ -74,13 +74,16 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
      */
     if (vmsg->request == VHOST_USER_ADD_MEM_REG ||
         vmsg->request == VHOST_USER_SET_MEM_TABLE) {
-        return;
+        return true;
     }
 
     for (i = 0; i < vmsg->fd_num; i++) {
-        /* TODO: handle error more gracefully than aborting */
-        qemu_set_blocking(vmsg->fds[i], false, &error_abort);
+        if (!qemu_set_blocking(vmsg->fds[i], false, errp)) {
+            return false;
+        }
     }
+
+    return true;
 }
 
 static void panic_cb(VuDev *vu_dev, const char *buf)
@@ -123,7 +126,6 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
 
     vmsg->fd_num = 0;
     if (!ioc) {
-        error_report_err(local_err);
         goto fail;
     }
 
@@ -177,7 +179,10 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
     } while (read_bytes != VHOST_USER_HDR_SIZE);
 
     /* qio_channel_readv_full will make socket fds blocking, unblock them */
-    vmsg_unblock_fds(vmsg);
+    if (!vmsg_unblock_fds(vmsg, &local_err)) {
+        error_report_err(local_err);
+        goto fail;
+    }
     if (vmsg->size > sizeof(vmsg->payload)) {
         error_report("Error: too big message request: %d, "
                      "size: vmsg->size: %u, "
-- 
2.50.1


