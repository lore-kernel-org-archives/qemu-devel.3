Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA16C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZdN-0006kC-Om; Wed, 23 Jul 2025 09:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueZao-0005rU-20
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueZal-0003Zp-On
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4FODRQNCnTMr2DNYg0zQMcKWGKTJnag5io3LmsuPTNg=;
 b=MqA9LuTlr/Z1Guaf0BByylS2ci9XBw2SsxYE6dBnHL4/1GZfgLgkpLzQzKX7EjVIxpGEqE
 K4mgSbXysMiyyP4CozOXSntOfYrQ9//ozmUa6vOixJSuUDnLd1EAm7cIDQUXgv0GynbUFn
 rLzzOfX+F8jIeTKJHh82upAJYR+9Bk4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-QfZDVVgkOnKkk2K_SAoO4A-1; Wed,
 23 Jul 2025 09:33:02 -0400
X-MC-Unique: QfZDVVgkOnKkk2K_SAoO4A-1
X-Mimecast-MFC-AGG-ID: QfZDVVgkOnKkk2K_SAoO4A_1753277581
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253961944D04; Wed, 23 Jul 2025 13:33:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC3C19560A0; Wed, 23 Jul 2025 13:33:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 079A521E6925; Wed, 23 Jul 2025 15:32:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
 aharivel@redhat.com
Subject: [PATCH 2/2] vfio scsi ui: Error-check
 qio_channel_socket_connect_sync() the same way
Date: Wed, 23 Jul 2025 15:32:57 +0200
Message-ID: <20250723133257.1497640-3-armbru@redhat.com>
In-Reply-To: <20250723133257.1497640-1-armbru@redhat.com>
References: <20250723133257.1497640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

qio_channel_socket_connect_sync() returns 0 on success, and -1 on
failure, with errp set.  Some callers check the return value, and some
check whether errp was set.

For consistency, always check the return value, and always check it's
negative.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/vfio-user/proxy.c     | 2 +-
 scsi/pr-manager-helper.c | 9 ++-------
 ui/input-barrier.c       | 5 +----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 2275d3fe39..2c03d49f97 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -885,7 +885,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
 
     sioc = qio_channel_socket_new();
     ioc = QIO_CHANNEL(sioc);
-    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+    if (qio_channel_socket_connect_sync(sioc, addr, errp) < 0) {
         object_unref(OBJECT(ioc));
         return NULL;
     }
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 6b86f01b01..aea751fb04 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -105,20 +105,15 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         .u.q_unix.path = path
     };
     QIOChannelSocket *sioc = qio_channel_socket_new();
-    Error *local_err = NULL;
-
     uint32_t flags;
     int r;
 
     assert(!pr_mgr->ioc);
     qio_channel_set_name(QIO_CHANNEL(sioc), "pr-manager-helper");
-    qio_channel_socket_connect_sync(sioc,
-                                    &saddr,
-                                    &local_err);
+    r = qio_channel_socket_connect_sync(sioc, &saddr, errp);
     g_free(path);
-    if (local_err) {
+    if (r < 0) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return -ENOTCONN;
     }
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 9793258aac..0a2198ca50 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -490,7 +490,6 @@ static gboolean input_barrier_event(QIOChannel *ioc G_GNUC_UNUSED,
 static void input_barrier_complete(UserCreatable *uc, Error **errp)
 {
     InputBarrier *ib = INPUT_BARRIER(uc);
-    Error *local_err = NULL;
 
     if (!ib->name) {
         error_setg(errp, QERR_MISSING_PARAMETER, "name");
@@ -506,9 +505,7 @@ static void input_barrier_complete(UserCreatable *uc, Error **errp)
     ib->sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(ib->sioc), "barrier-client");
 
-    qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (qio_channel_socket_connect_sync(ib->sioc, &ib->saddr, errp) < 0) {
         return;
     }
 
-- 
2.49.0


