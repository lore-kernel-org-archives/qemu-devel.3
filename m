Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B81C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pa-0005pZ-5I; Fri, 28 Aug 2026 16:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PO-0005dN-SZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PN-00087c-6M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2W7gEbcQvoW+FTos9Dgma/aM4XpWbxnIXFt8Gt9QKQ=;
 b=SgAw7AaJFu5mF8y80GaNMSMKqQXG3rLGXuWcJcgZQTuv99iTlMfnZfG3nQGnwkSyUKeIQZ
 wwHPDXqnFy/NI9gdgHvyTwJvl2EzTQhMMAfyoE5DotHC+OcUdDLvexfHJTIBGAFAANVoDA
 g8UZdrmzKOGuEcD57RTow8WYel6hbH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-eNycyH0HONannZz1vc6cSQ-1; Fri,
 28 Aug 2026 16:42:37 -0400
X-MC-Unique: eNycyH0HONannZz1vc6cSQ-1
X-Mimecast-MFC-AGG-ID: eNycyH0HONannZz1vc6cSQ_1787949756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28FE7190A34A; Fri, 28 Aug 2026 20:42:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44C113001D3D; Fri, 28 Aug 2026 20:42:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:49 +0400
Subject: [GIT PULL 10/50] net/qapi: add x-query-usernet command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-10-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=F3SoeJDBt3rrzT1cQF1tnvqxl7EEFuI+x4m5q9N397Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUtkfxV1YxhjIZqQgi5qmrXTdo9d20Xv0II
 yU/jKSfr/2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5YQkD/9nFWG07kz2b7CxG4GvUDheEwHZpXVzRI5SkEfGdgkLzqKTZddT4T8vdkk3hCGPaSSN1VL
 GqyF7juWkx9+ToeXhopat+qyDVjYQwvFHR3vNd8yUztYOBxkYtjeUSES1avWziBX0ACc9oXkfXd
 1XU7/PkCUdkxjDlNsOC4D724HrlckYjD96fg5/Wzbf7cC7nVqQtHeagK/ka1xGBMmrFKHHm6Q50
 K/OgdQlsSCP9tK2jOpL8arbXbEX8KqbNULk+2RFRKJRXgURf6OASd44cVybMN9XiBd33xP85Ws5
 hsiAZtAWPFCtYSXesu15ejC6satpEOsfOYRu+zaXRxLUf9N7NxfAV0O2n3emZGgmJvAv9Zv+5BD
 vmdtgL/lTYhZQGHrrcLOec5+iYOszm8Z+vluykV1x/iaYx4KN8ypOtgGgjuhTjm+c8j7iHDwAFO
 eBMZHXOmDCLiYMmJQ0Ztub6rXc/40okQsB86BI5mCk8oK+xjnX8mqb+FYN90X1dYVhsEWKPkUqk
 9bNQ3ZDN0BHLMHT42ViZJ8I37MKG8tOi30NKpEXBnFnSzJQVFATf2MmNn2EDIzdpP550a/0eIth
 xC76H4NtDxfJIh0s3Sg7qSinGObPJgZRfVA1UAeq2BQ5/qe8BUF6pnlHbXYgbYejAw91sD4FeoI
 dbSBDfexVnGOHAw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
Message-ID: <20260828-qemu-no-hmp-v5-10-9227de146347@redhat.com>
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


