Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C3CCA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3L9-00069s-8T; Mon, 01 Sep 2025 08:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3L5-0005xb-8m
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Ks-0005ek-Q9
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=Br0eDufuCl1H/A9/QpQKIm91QMS3pZxtsWEd1doI9uo=;
 b=havIK17HXhhbxlck7/tq/Fu5e5jgc4KnWuImxNbOxq33N544kSN6Pf0xQQRa4j7yCtIrsD
 VFr4Gx/wUPZBdqE2btjtDwDbUCdMcSy+aeIChC8MhLzCmbetwNTnEOq3BG4xC9ziINgC1I
 QU3J/vOAD3A6UdH2W4k4SVwXEYXijik=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-YqTMfVk7MYyKxYpDCZZ1hQ-1; Mon,
 01 Sep 2025 08:08:28 -0400
X-MC-Unique: YqTMfVk7MYyKxYpDCZZ1hQ-1
X-Mimecast-MFC-AGG-ID: YqTMfVk7MYyKxYpDCZZ1hQ_1756728507
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32D84180034A; Mon,  1 Sep 2025 12:08:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C22A619560B4; Mon,  1 Sep 2025 12:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2252A21E6935; Mon, 01 Sep 2025 14:08:24 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:08:24 +0200
Resent-Message-ID: <87ldmy4bpj.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:19:06 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0A9621E6935; Mon, 01 Sep 2025 13:19:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 3/3] vfio scsi ui: Error-check
 qio_channel_socket_connect_sync() the same way
Date: Mon,  1 Sep 2025 13:19:06 +0200
Message-ID: <20250901111906.2403307-4-armbru@redhat.com>
In-Reply-To: <20250901111906.2403307-1-armbru@redhat.com>
References: <20250901111906.2403307-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qio_channel_socket_connect_sync() returns 0 on success, and -1 on
failure, with errp set.  Some callers check the return value, and some
check whether errp was set.

For consistency, always check the return value, and always check it's
negative.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250723133257.1497640-3-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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



