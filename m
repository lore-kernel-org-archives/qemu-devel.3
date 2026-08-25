Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA153C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXs-0004TV-8I; Tue, 25 Aug 2026 15:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXq-0004SA-2b
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXo-0003w3-C5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5rJL39r60/35LZLysmBCrpC68JHwhbcZtjRUJEvMqk=;
 b=OBs3G7HdoBK5ptBKT6k5MbPtC23BnKMik+ns1eOZyoAzX2N16Hzh73easR1Fg/O45TIGex
 GrNaVTNyfgVfZk0Rw0828oVwirTxxOBlfrNqxnYcmppRG1J95MucujXvJWiCdEaDMS/zBk
 I2Gji8G6BabtTrEDp24Io2lRLuBUaRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-w0zfAu-aOKqMuVGjfgSuig-1; Tue,
 25 Aug 2026 15:10:44 -0400
X-MC-Unique: w0zfAu-aOKqMuVGjfgSuig-1
X-Mimecast-MFC-AGG-ID: w0zfAu-aOKqMuVGjfgSuig_1787685042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125E4185BE9D; Tue, 25 Aug 2026 19:10:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3528F1800765; Tue, 25 Aug 2026 19:10:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:17 +0400
Subject: [PATCH v4 10/49] net/qapi: add x-query-usernet command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-10-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHnCN1wUPqmnc7z9wgYcRi2LRujCzQvgaLo
 JbwUpNZQmaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5WQXEACbciJfEAFrFqIaVnpvFE8QHje/J/3X4UPjMVd+5wO66KSLf2os+3BfW74Pb5xvYmliSbJ
 w9clKeqrEqx0MwoLprxmACk73jYPaGKD3UIR5P3T8oySz2iHpctAg6hDTWMR4mCaHNtp51/6DtZ
 79xOxF9HNj9S7Mkui96TsbSD8SwmPvaNSg31YLB3WsX9AHJZQVvfsC6BAVGVq9stiVNF1XHxe2K
 4t9Yq4ijyvjK88e01O+JlSPEle0tdr+WFaHtw34A8JRIo4SkFQb92Ny9lHxc2qC+1SsZQeVqRQ5
 OxP9ONLZ/KA4TXk3O9Wsf2jpckhwQGVQZZ4sDjguWG6cApmrNGbb6ItTYSNy92W1/rpAMYUxl0P
 WsvWg9mCH31TygaWhHSli7c9iaQ8DX4bSktUAevId/KXimMED6I5wfhNQY3uupZxK3UPNNCbAfH
 A7oNwM/yHj/WRpyl5xDwr9X/K/v+1BzgpKdLVOKJnK/aJWHebgIP2GbgjBgRZFGGPWyGDqp5cFI
 Dt9QGw3tOoEhF/IfbnneJNQ2AlfpWl+GOp5BDgXBtdbB5rJQsL3Du3TnEutUHS7Wdhefs00Rc5b
 NRDq047aTs/6rLczvZHbQKxH8r/iZAR50NXRouREnko0DEMAaXOSuMXomfuWGGYr4Lm8mazewSD
 IIWjPN/UxICbgHQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


