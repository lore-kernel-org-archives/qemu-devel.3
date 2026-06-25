Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D1CDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrV9-0008P6-FG; Thu, 25 Jun 2026 17:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrV7-0008Ky-EG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrV5-0003fK-EL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFZW4htD7KstfFIhfIJGqYLKdEI7sRcsvA10/+qg6Ps=;
 b=FE8rQjkuMtp59g2yyzUVhVsPcJlqBk3HNxWCWhU7s/NHrRMC3j+XanEglDbIhPTxK9ve98
 fYaJ9/s6o79nHi6PusRfNOUB77il3MUd2NO1BPR9hH65lBZeFwTKtq1tq2d1ghVrGEKkr/
 NvY1xtDybUqJhl9lm65aac+maJDRpUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-m6pFOMUfOC6STH7M3lEnZA-1; Thu,
 25 Jun 2026 17:20:38 -0400
X-MC-Unique: m6pFOMUfOC6STH7M3lEnZA-1
X-Mimecast-MFC-AGG-ID: m6pFOMUfOC6STH7M3lEnZA_1782422438
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF6CE1801373; Thu, 25 Jun 2026 21:20:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DDC6195608D; Thu, 25 Jun 2026 21:20:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:13 +0400
Subject: [PATCH v2 12/39] net/qapi: add x-query-usernet command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-12-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3738;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RVZlR73SwAw8gRicRiqQ2wSi7+LVPpMuKf/GFhWwXd0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtc3CJ3ll40uoAhMfUg5cMTnZvC2a/7fZtXW
 8EXLOxHae+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5RzsD/0YpdPhSvTS0dTMzvvcVob7AVbw220CQE3mWTSMOYhXMAwJCCYtuN7m5oiVoAwUghQvLAZ
 TmJv6Q3WI5/ppEE/j98GaZ4i0yj8p375NZ/ucreE1XiwCmPwC1CrWqBczzvulseYsGR+kgdmJoP
 7RGQhumKYei0mFtV1n3uLDucJS/V/TayiMuiI0NKUKD/HChWeGsZE04ZzpRu0TRER5ZSOHgGswy
 0eUfS3PA+daBKe2CtTOYjD14mk9hnMNdNT8oJP66gw9J7GSN1LJH4zWK83GreapMwMVe/05NDeX
 1IjQg/VNe18FQfJNCyDmJCcjy8vUZl+OICBCJp8qBC7hhFQDmB2kZM2LkrwHnR8cMZLGs60Yd57
 WSFtHP+9EyK6AiM8YAYW90b4DZd8CPCNvggyQKVi9dcmikiYafZrKmepsW3rFgQ2HY9GuOzwWer
 OK98UmK/1L56dNUbFIrEwrYicRYpxSRgn2aHrowz73iwS3zNFwPL145PvKF3GGJic8S8vdrXvQw
 5CaYdzoy1z/bwHFqkejD/kI3vtCMA5sED5nvfJCBqNwJZXgeoDGq7oMI1S45A6t9kidPNJ4FQ8p
 qII3D2qjZiprry9kl6zWOqoxqMJ19F+iXB+kbSaL6q+D/nGzL92blagZPvvu+kGKQmWkGatBArV
 tjQ4HSOEiIpZerw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a QMP command to query user-mode network stack (slirp) connection
states, providing a structured alternative to "info usernet" HMP.

The new command returns a list of UsernetInfo, with hub-id, hub-name,
and connection info for each slirp stack. It is marked unstable as it
is meant for debugging.

Rewrite hmp_info_usernet() as a thin wrapper over qmp_x_query_usernet()
so the HMP and QMP paths share the same implementation.

This is part of the effort to decouple HMP from QEMU core.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 qapi/net.json | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/slirp.c   | 34 ++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c5..08ec7f37946 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1261,3 +1261,47 @@
 ##
 { 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
+
+##
+# @UsernetInfo:
+#
+# Information about a user-mode network stack (slirp).
+#
+# @hub-id: The hub id, if available.
+#
+# @hub-name: The name of the hub.
+#
+# @info: Network information from slirp.
+#
+# Since: 11.1
+##
+{ 'struct': 'UsernetInfo',
+  'data': {
+    '*hub-id': 'int',
+    'hub-name': 'str',
+    'info': 'str' },
+  'if': 'CONFIG_SLIRP' }
+
+##
+# @x-query-usernet:
+#
+# Query user-mode network stack connection states.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: list of user-mode network stack information.
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "x-query-usernet" }
+#     <- { "return": [ { "hub-id": 0, "hub-name": "vnet",
+#                        "info": "..." } ] }
+##
+{ 'command': 'x-query-usernet',
+  'returns': ['UsernetInfo'],
+  'if': 'CONFIG_SLIRP',
+  'features': [ 'unstable' ] }
diff --git a/net/slirp.c b/net/slirp.c
index 9e9941fe73e..517dd23be14 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -43,6 +43,7 @@
 #include "system/system.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-net.h"
 #include "qobject/qdict.h"
 #include "util.h"
 #include "migration/register.h"
@@ -1200,18 +1201,39 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
     return -1;
 }
 
-void hmp_info_usernet(Monitor *mon, const QDict *qdict)
+UsernetInfoList *qmp_x_query_usernet(Error **errp)
 {
+    UsernetInfoList *head = NULL, **tail = &head;
     SlirpState *s;
 
     QTAILQ_FOREACH(s, &slirp_stacks, entry) {
+        UsernetInfo *ui = g_new0(UsernetInfo, 1);
         int id;
-        bool got_hub_id = net_hub_id_for_client(&s->nc, &id) == 0;
-        char *info = slirp_connection_info(s->slirp);
+
+        if (net_hub_id_for_client(&s->nc, &id) == 0) {
+            ui->has_hub_id = true;
+            ui->hub_id = id;
+        }
+        ui->hub_name = g_strdup(s->nc.name);
+        ui->info = slirp_connection_info(s->slirp);
+
+        QAPI_LIST_APPEND(tail, ui);
+    }
+
+    return head;
+}
+
+void hmp_info_usernet(Monitor *mon, const QDict *qdict)
+{
+    g_autoptr(UsernetInfoList) list = NULL;
+    UsernetInfoList *entry;
+
+    list = qmp_x_query_usernet(&error_abort);
+    for (entry = list; entry; entry = entry->next) {
+        UsernetInfo *ui = entry->value;
         monitor_printf(mon, "Hub %d (%s):\n%s",
-                       got_hub_id ? id : -1,
-                       s->nc.name, info);
-        g_free(info);
+                       ui->has_hub_id ? (int)ui->hub_id : -1,
+                       ui->hub_name, ui->info);
     }
 }
 

-- 
2.54.0


