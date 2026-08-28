Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B067C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvKn-0006kE-IX; Fri, 28 Aug 2026 08:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKl-0006do-Vv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKk-0002PY-5l
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5rJL39r60/35LZLysmBCrpC68JHwhbcZtjRUJEvMqk=;
 b=Jqo9VCxJvLG8sBhUqhClfpIj/4L8fs9PG7c+coKbuU0wq51gT71ZkIowuAEIL/lOEWfIPG
 VntcUxvl0klSW9McaHwu0O/5cOD/Go9HE5uJad1UXnrbUoc88/G/FTqgFXv9IsG5O8NeD7
 FWWSr7z5L2u0FHwfwtJPuErwdIGdZI0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-Irc6v8_nMZeR6qI15XSRUw-1; Fri,
 28 Aug 2026 08:05:18 -0400
X-MC-Unique: Irc6v8_nMZeR6qI15XSRUw-1
X-Mimecast-MFC-AGG-ID: Irc6v8_nMZeR6qI15XSRUw_1787918716
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 885F9190FFB5; Fri, 28 Aug 2026 12:05:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1D8E1955F7B; Fri, 28 Aug 2026 12:05:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:07 +0400
Subject: [PATCH v5 10/50] net/qapi: add x-query-usernet command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-10-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=f+pBY7K9E3HdtzS9Ahsq3e8j7aQZanCIxcPzFBfxZu8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk40IAs8gvDJ8KX1crPeTvV8mDBQbuNA9iLR
 L6GwgJmW5WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5QRMEACmuXN75MNqPq0auqXx45QMPE36Rqw2ps0KBWK6lwuz6sXtPLrJNNWwVWFIJtaFGZCWY7W
 1TOvc9rB7JrtfuYqWA4ZELljcxHgssSrdNXcaccPSIFG62qRvxOpkbroJhUgd7KPfegkcWRY+yE
 5yrUYLRQCdddMYq+yLoNCzgxqnIlMdwjBAbamMq8Pyrgk5bVirIqS80RkaIewo5nXGneYSJh56t
 5fX8l7O8Yb5VO1mMMaps4gBzN+TY93S5PBNdHABCkfD6Fvz47BxctPIcF9F0uNz/iruLzWB6O/6
 VZCTWqnw8iKVaHQTC+IQGrkxOz6eWQprKJWNlqyRY1wivJNBpFEWxziJwMrOzDWf0AlGsyqUUEV
 XRtR/N0b/v7Q9jnG967J2jfbGcnaLT9BwIT1X33rOFrK25YO+KVB/r4WSsystk5IBQNFc0tq9yH
 zMF5mxDSo1dDmungOl2HQKK4jeMLUFlVPLd9orUmpccUqTrSxq0qL/VXeeBTd4kBTrEC9TZBPPe
 m3UpfSI49+CQGyZ+974NXQNJd1o9BNlykgR4r7sDPXbje4HulA/iEyCG37gWdHzelBl8ejH3Gfe
 hdLy6TqMBxueDNVElmHaE4tl3P5YVDPeu8LAfN8tDERI4AvmvL6GlzwrmDKOK16uAwkZwxDqKze
 FR3uISe1sKlJfCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a QMP command to query user-mode network stack (slirp) connection
states, providing a structured alternative to "info usernet" HMP.

The new command returns a list of UsernetInfo, with hub-id, hub-name,
and connection info for each slirp stack. It is marked unstable as it
is meant for debugging.

Rewrite hmp_info_usernet() as a thin wrapper over qmp_x_query_usernet()
so the HMP and QMP paths share the same implementation.

This is part of the effort to decouple HMP from QEMU core.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 net/slirp.c   | 34 ++++++++++++++++++++++++++++------
 qapi/net.json | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9e9941fe73e7..517dd23be14b 100644
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
 
diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c5e..5d3342fba23b 100644
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
+# Since: 11.2
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
+# Since: 11.2
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

-- 
2.55.0.543.g5ebe2ebe4ea8


