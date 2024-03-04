Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FEAC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1tE-00066O-7U; Mon, 04 Mar 2024 01:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sc-0005Zp-AI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sV-0000Bi-4W
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NotQ5xIVKyws1mpCsTlsyJuN2gRQCKdulXiWWxT8xE=;
 b=SsIoAtB19C6a+Xqi2cTnKQrGJOpdB1SaYiV+1zDJKp5tCpfkJghWlHNQzrNEOIP+EOVWLc
 t0qINo8vJVjkzt4qpy6OK0+M74X5lZWqJ6UGmXj7ghPK045cmH/gwVjfTA1bnIwO3dNNf4
 VuY+NeUvyzMAj/B1Ub6xGVgWuYpK4rg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-wHchecvuMV6CWDi9PK9kPw-1; Mon, 04 Mar 2024 01:32:40 -0500
X-MC-Unique: wHchecvuMV6CWDi9PK9kPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 822AC1064F8D;
 Mon,  4 Mar 2024 06:32:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C7A11121306;
 Mon,  4 Mar 2024 06:32:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D72421E66F1; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Steve Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 18/18] migration: simplify exec migration functions
Date: Mon,  4 Mar 2024 07:32:36 +0100
Message-ID: <20240304063236.213955-19-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20240227153321.467343-4-armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.44.0


