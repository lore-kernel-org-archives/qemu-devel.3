Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F46CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPop3-0000YW-BU; Wed, 20 May 2026 17:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPop1-0000U6-TI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoox-0004SH-Lb
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gc5N08QNN+OjdBiGrYotMBQ3e65sybYUrp28BmT1vc=;
 b=UAtKvXcyq95sj0wDpfW6Tk/G5Mmh93TTB1MKS/ElCcs9z51wHEb0TBHyN60tqbT7MlkZmN
 hgxThXc1HZ6rgmhfHaqG10ORUJ+wCUhom+dtdxuDY0/IUJT4KpvgormoBhFh4nf/17lEy9
 oR1FQ1J94unI7ctpz4Iwccx/Wkrlttk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-xpVSGeZDMzq4qLeq_6eOUQ-1; Wed,
 20 May 2026 17:51:15 -0400
X-MC-Unique: xpVSGeZDMzq4qLeq_6eOUQ-1
X-Mimecast-MFC-AGG-ID: xpVSGeZDMzq4qLeq_6eOUQ_1779313874
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7638319560B9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 279FC1684; Wed, 20 May 2026 21:51:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:12 +0400
Subject: [PATCH 11/40] net/qapi: add x-query-usernet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-11-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3306;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E94/3MiB0VgFNkT6H5WYvo+WLMYYtQvL8sNhmBto3GA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyCIJUcHQUEVAeLhrIxeNpH0vcY1R111Ykjx
 8i7XL1uR7mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sggAKCRDa6OEJdZac
 5Sz4EACSKn9Q7uK9HhopMQYh9rT8Gp4HtVyqAhdc/jHs8WQFwMMr/+ssHoPF/hd6t1LWQlUPVLk
 0WLTE7uCgR6yZVbhlSgdAhGvjouPbuPh1S+XTd8GKEwFykBqw1R6hY0GO0r/j2qUlgwoodV+u0T
 JyO+4a5KjbfWRCTJzYKTQ9s7c7qzvazY0NY3l080Nr4GSFMRUCzhx62f35Me1yXkKorCbo4L10G
 ltBvzBYor/TG4AaasQ6jRev3o9OruoqP++CuV7C336kHM+cKhe1UW29w7d1dCdoXIKIbJy49fAm
 UHwAz/b68Pl3QHkmGpVe4x9a8wN2VoIktd17dtTRHUwK5heEASj1PIBnYFIeRTpHFZurXz98Tue
 R7YK1zxyFbRMnBxfBOwLhP/Y6fc3w41r5EtleZSwtDwTjvQ7d7Op4c7yt4UDtQs8TzgeKuOMIMs
 YUNVGI/F48f+NYlfb+KVvri0wONLwmOPmamIIB5iibhDML720uTrMNbPN+pXIo2gp7+bDmabfqJ
 emH69++6vbs2rRWWUhVFkuc4jg9DDkVE3fZavw4fA7VcK1vxX3oXRE7aofrCTNy+N9lJ9YOP6jT
 jWEGlbo5sJwPuRkoOE8BVtExvwpUl+8hsrfyq8dRrs3PmOeFcb/AdjbGOdfyDOw52hpJBqez4mm
 XSVGMPFkjjl0jZQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Add a QMP equivalent to hmp "info usernet", so we can disable HMP.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/net.json | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/slirp.c   | 34 ++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 118bd349651..dd56215fd15 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1191,3 +1191,47 @@
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
index 04925f33187..d3ed5ec9cb8 100644
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
@@ -1199,18 +1200,39 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
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


