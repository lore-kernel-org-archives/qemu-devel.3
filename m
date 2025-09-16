Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA9CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVWq-0005rO-OU; Tue, 16 Sep 2025 09:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVWG-0005V1-Dh; Tue, 16 Sep 2025 09:14:53 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVWA-0006a1-Pv; Tue, 16 Sep 2025 09:14:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 83C7BC0262;
 Tue, 16 Sep 2025 16:14:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5EQRob1Gj0U0-NwCTS7A7; Tue, 16 Sep 2025 16:14:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028458;
 bh=MNlmMd6mGnz88Xb18uWmdi7nOu8lfIjb8YU+w/HXckE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=C4Pkm9GbyomO+TvPVIXm0bFQn704a8w6AAlDpuOdeAEBn3aDDcz8/8hBZ3jdl/qTL
 qx7GNJX4yeuie6BOw5IM2aXnO+4aEMwPXvnIcZVAqXxlCu5U49NbxusR9glIk1OsFd
 9e0zdgQMc0qT9qTjOC8iHV0gMOd2VH9r/8cNFEXA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 vsementsov@yandex-team.ru, leiyang@redhat.com, marcandre.lureau@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 13/13] util/vhost-user-server: vu_message_read(): improve
 error handling
Date: Tue, 16 Sep 2025 16:14:02 +0300
Message-ID: <20250916131403.368343-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1. Drop extra error_report_err(NULL), it will just crash, if we get
here.

2. Get and report error of qemu_set_blocking(), instead of aborting.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.48.1


