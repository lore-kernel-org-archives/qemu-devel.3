Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC10C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezSl-0004Pm-Cg; Tue, 27 Feb 2024 10:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSa-0004IR-V5
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSR-0005HO-Qw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709048007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ygEJha1k0iwErA+UUXIpGWsdgck9M5i+PDDxNYeDpU=;
 b=ZQ4p2C7gE00pvFj+gcfrAz9MtkjKSD65dmx/ZXwg2RgMpNsBFEZlgZ9xNSARlOGrCEMTe/
 7YuK1TvgLUUvqGSOn5rC10ruEpX5kz5LW78bfK8fqrhBOtSdNLFRRvMOebG2n/7TokwoUP
 /KF/y885iAMq+gQtxMDWp0NxX1JffHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Y-xZB9KsNhSqfO3bWPKF0Q-1; Tue, 27 Feb 2024 10:33:23 -0500
X-MC-Unique: Y-xZB9KsNhSqfO3bWPKF0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E335881B6F;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0974620229A4;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0707C21E6691; Tue, 27 Feb 2024 16:33:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com, philmd@linaro.org, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, peterx@redhat.com,
 farosas@suse.de
Subject: [PATCH v7 3/3] migration: simplify exec migration functions
Date: Tue, 27 Feb 2024 16:33:21 +0100
Message-ID: <20240227153321.467343-4-armbru@redhat.com>
In-Reply-To: <20240227153321.467343-1-armbru@redhat.com>
References: <20240227153321.467343-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Simplify the exec migration code by using list utility functions.

As a side effect, this also fixes a minor memory leak.  On function return,
"g_auto(GStrv) argv" frees argv and each element, which is wrong, because
the function does not own the individual elements.  To compensate, the code
uses g_steal_pointer which NULLs argv and prevents the destructor from
running, but argv is leaked.

Fixes: cbab4face57b ("migration: convert exec backend ...")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/exec.c | 57 +++++++-----------------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b8fb..20e6cccf8c 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/type-helpers.h"
 #include "qemu/error-report.h"
 #include "channel.h"
 #include "exec.h"
@@ -39,51 +40,16 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-/* provides the length of strList */
-static int
-str_list_length(strList *list)
-{
-    int len = 0;
-    strList *elem;
-
-    for (elem = list; elem != NULL; elem = elem->next) {
-        len++;
-    }
-
-    return len;
-}
-
-static void
-init_exec_array(strList *command, char **argv, Error **errp)
-{
-    int i = 0;
-    strList *lst;
-
-    for (lst = command; lst; lst = lst->next) {
-        argv[i++] = lst->value;
-    }
-
-    argv[i] = NULL;
-    return;
-}
-
 void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
-    QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    QIOChannel *ioc = NULL;
+    g_auto(GStrv) argv = strv_from_str_list(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_outgoing(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
@@ -105,19 +71,12 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    g_auto(GStrv) argv = strv_from_str_list(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_incoming(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
-- 
2.43.0


