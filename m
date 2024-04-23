Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58333C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnd-0007DD-A2; Tue, 23 Apr 2024 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmb-0004ME-Nu
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmY-0008VP-H1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bV6hCJ7qQo40huP00kw85XkgnvXtd5S1oXCGjI30BM=;
 b=BlCucIRmcQzNH8b4rNF6fenzb1KaWS6kAM/CyifkR/C1777+MhGG9LAiNngnF+PEcL0Uka
 TgfCo9u+/JcWGnpieA5IaZhRcBKaXfYIxHFuhX67E+AhPOwwPK4hsjBGRd2vf6pMDQCkXH
 DX1WAGdfeQReggOqWEyAgohHd41btq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Os0pdHg-P9-kQ_vXygKMcA-1; Tue, 23 Apr 2024 11:10:01 -0400
X-MC-Unique: Os0pdHg-P9-kQ_vXygKMcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2825D812C55;
 Tue, 23 Apr 2024 15:10:01 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BDD3200AFA2;
 Tue, 23 Apr 2024 15:10:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/63] util/qemu-config: Extract QMP commands to
 qemu-config-qmp.c
Date: Tue, 23 Apr 2024 17:08:54 +0200
Message-ID: <20240423150951.41600-7-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QMP is irrelevant for user emulation. Extract the code
related to QMP in a different source file, which won't
be build for user emulation binaries. This avoid pulling
pointless code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240404194757.9343-5-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240408155330.522792-7-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/config-file.h |   3 +
 monitor/qemu-config-qmp.c  | 206 +++++++++++++++++++++++++++++++++++++
 util/qemu-config.c         | 204 +-----------------------------------
 monitor/meson.build        |   1 +
 4 files changed, 212 insertions(+), 202 deletions(-)
 create mode 100644 monitor/qemu-config-qmp.c

diff --git a/include/qemu/config-file.h b/include/qemu/config-file.h
index b82a778123f..51b310fa3b4 100644
--- a/include/qemu/config-file.h
+++ b/include/qemu/config-file.h
@@ -8,6 +8,9 @@ QemuOptsList *qemu_find_opts(const char *group);
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp);
 QemuOpts *qemu_find_opts_singleton(const char *group);
 
+extern QemuOptsList *vm_config_groups[];
+extern QemuOptsList *drive_config_groups[];
+
 void qemu_add_opts(QemuOptsList *list);
 void qemu_add_drive_opts(QemuOptsList *list);
 int qemu_global_option(const char *str);
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
new file mode 100644
index 00000000000..24477a0e448
--- /dev/null
+++ b/monitor/qemu-config-qmp.c
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "hw/boards.h"
+
+static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
+{
+    CommandLineParameterInfoList *param_list = NULL;
+    CommandLineParameterInfo *info;
+    int i;
+
+    for (i = 0; desc[i].name != NULL; i++) {
+        info = g_malloc0(sizeof(*info));
+        info->name = g_strdup(desc[i].name);
+
+        switch (desc[i].type) {
+        case QEMU_OPT_STRING:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+            break;
+        case QEMU_OPT_BOOL:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
+            break;
+        case QEMU_OPT_NUMBER:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
+            break;
+        case QEMU_OPT_SIZE:
+            info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
+            break;
+        }
+
+        info->help = g_strdup(desc[i].help);
+        info->q_default = g_strdup(desc[i].def_value_str);
+
+        QAPI_LIST_PREPEND(param_list, info);
+    }
+
+    return param_list;
+}
+
+/* remove repeated entry from the info list */
+static void cleanup_infolist(CommandLineParameterInfoList *head)
+{
+    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
+
+    cur = head;
+    while (cur->next) {
+        pre_entry = head;
+        while (pre_entry != cur->next) {
+            if (!strcmp(pre_entry->value->name, cur->next->value->name)) {
+                del_entry = cur->next;
+                cur->next = cur->next->next;
+                del_entry->next = NULL;
+                qapi_free_CommandLineParameterInfoList(del_entry);
+                break;
+            }
+            pre_entry = pre_entry->next;
+        }
+        cur = cur->next;
+    }
+}
+
+/* merge the description items of two parameter infolists */
+static void connect_infolist(CommandLineParameterInfoList *head,
+                             CommandLineParameterInfoList *new)
+{
+    CommandLineParameterInfoList *cur;
+
+    cur = head;
+    while (cur->next) {
+        cur = cur->next;
+    }
+    cur->next = new;
+}
+
+/* access all the local QemuOptsLists for drive option */
+static CommandLineParameterInfoList *get_drive_infolist(void)
+{
+    CommandLineParameterInfoList *head = NULL, *cur;
+    int i;
+
+    for (i = 0; drive_config_groups[i] != NULL; i++) {
+        if (!head) {
+            head = query_option_descs(drive_config_groups[i]->desc);
+        } else {
+            cur = query_option_descs(drive_config_groups[i]->desc);
+            connect_infolist(head, cur);
+        }
+    }
+    cleanup_infolist(head);
+
+    return head;
+}
+
+static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty *prop)
+{
+    CommandLineParameterInfo *info;
+
+    info = g_malloc0(sizeof(*info));
+    info->name = g_strdup(prop->name);
+
+    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOffAuto")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
+    } else if (g_str_equal(prop->type, "int")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
+    } else if (g_str_equal(prop->type, "size")) {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
+    } else {
+        info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+    }
+
+    if (prop->description) {
+        info->help = g_strdup(prop->description);
+    }
+
+    return info;
+}
+
+static CommandLineParameterInfoList *query_all_machine_properties(void)
+{
+    CommandLineParameterInfoList *params = NULL, *clpiter;
+    CommandLineParameterInfo *info;
+    GSList *machines, *curr_mach;
+    ObjectPropertyIterator op_iter;
+    ObjectProperty *prop;
+    bool is_new;
+
+    machines = object_class_get_list(TYPE_MACHINE, false);
+    assert(machines);
+
+    /* Loop over all machine classes */
+    for (curr_mach = machines; curr_mach; curr_mach = curr_mach->next) {
+        object_class_property_iter_init(&op_iter, curr_mach->data);
+        /* ... and over the properties of each machine: */
+        while ((prop = object_property_iter_next(&op_iter))) {
+            if (!prop->set) {
+                continue;
+            }
+            /*
+             * Check whether the property has already been put into the list
+             * (via another machine class)
+             */
+            is_new = true;
+            for (clpiter = params; clpiter != NULL; clpiter = clpiter->next) {
+                if (g_str_equal(clpiter->value->name, prop->name)) {
+                    is_new = false;
+                    break;
+                }
+            }
+            /* If it hasn't been added before, add it now to the list */
+            if (is_new) {
+                info = objprop_to_cmdline_prop(prop);
+                QAPI_LIST_PREPEND(params, info);
+            }
+        }
+    }
+
+    g_slist_free(machines);
+
+    /* Add entry for the "type" parameter */
+    info = g_malloc0(sizeof(*info));
+    info->name = g_strdup("type");
+    info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
+    info->help = g_strdup("machine type");
+    QAPI_LIST_PREPEND(params, info);
+
+    return params;
+}
+
+CommandLineOptionInfoList *qmp_query_command_line_options(const char *option,
+                                                          Error **errp)
+{
+    CommandLineOptionInfoList *conf_list = NULL;
+    CommandLineOptionInfo *info;
+    int i;
+
+    for (i = 0; vm_config_groups[i] != NULL; i++) {
+        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
+            info = g_malloc0(sizeof(*info));
+            info->option = g_strdup(vm_config_groups[i]->name);
+            if (!strcmp("drive", vm_config_groups[i]->name)) {
+                info->parameters = get_drive_infolist();
+            } else {
+                info->parameters =
+                    query_option_descs(vm_config_groups[i]->desc);
+            }
+            QAPI_LIST_PREPEND(conf_list, info);
+        }
+    }
+
+    if (!option || !strcmp(option, "machine")) {
+        info = g_malloc0(sizeof(*info));
+        info->option = g_strdup("machine");
+        info->parameters = query_all_machine_properties();
+        QAPI_LIST_PREPEND(conf_list, info);
+    }
+
+    if (conf_list == NULL) {
+        error_setg(errp, "invalid option name: %s", option);
+    }
+
+    return conf_list;
+}
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 42076efe1ef..a90c18dad25 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,16 +1,14 @@
 #include "qemu/osdep.h"
 #include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "hw/boards.h"
 
-static QemuOptsList *vm_config_groups[48];
-static QemuOptsList *drive_config_groups[5];
+QemuOptsList *vm_config_groups[48];
+QemuOptsList *drive_config_groups[5];
 
 static QemuOptsList *find_list(QemuOptsList **lists, const char *group,
                                Error **errp)
@@ -55,204 +53,6 @@ QemuOpts *qemu_find_opts_singleton(const char *group)
     return opts;
 }
 
-static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
-{
-    CommandLineParameterInfoList *param_list = NULL;
-    CommandLineParameterInfo *info;
-    int i;
-
-    for (i = 0; desc[i].name != NULL; i++) {
-        info = g_malloc0(sizeof(*info));
-        info->name = g_strdup(desc[i].name);
-
-        switch (desc[i].type) {
-        case QEMU_OPT_STRING:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-            break;
-        case QEMU_OPT_BOOL:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
-            break;
-        case QEMU_OPT_NUMBER:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
-            break;
-        case QEMU_OPT_SIZE:
-            info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
-            break;
-        }
-
-        info->help = g_strdup(desc[i].help);
-        info->q_default = g_strdup(desc[i].def_value_str);
-
-        QAPI_LIST_PREPEND(param_list, info);
-    }
-
-    return param_list;
-}
-
-/* remove repeated entry from the info list */
-static void cleanup_infolist(CommandLineParameterInfoList *head)
-{
-    CommandLineParameterInfoList *pre_entry, *cur, *del_entry;
-
-    cur = head;
-    while (cur->next) {
-        pre_entry = head;
-        while (pre_entry != cur->next) {
-            if (!strcmp(pre_entry->value->name, cur->next->value->name)) {
-                del_entry = cur->next;
-                cur->next = cur->next->next;
-                del_entry->next = NULL;
-                qapi_free_CommandLineParameterInfoList(del_entry);
-                break;
-            }
-            pre_entry = pre_entry->next;
-        }
-        cur = cur->next;
-    }
-}
-
-/* merge the description items of two parameter infolists */
-static void connect_infolist(CommandLineParameterInfoList *head,
-                             CommandLineParameterInfoList *new)
-{
-    CommandLineParameterInfoList *cur;
-
-    cur = head;
-    while (cur->next) {
-        cur = cur->next;
-    }
-    cur->next = new;
-}
-
-/* access all the local QemuOptsLists for drive option */
-static CommandLineParameterInfoList *get_drive_infolist(void)
-{
-    CommandLineParameterInfoList *head = NULL, *cur;
-    int i;
-
-    for (i = 0; drive_config_groups[i] != NULL; i++) {
-        if (!head) {
-            head = query_option_descs(drive_config_groups[i]->desc);
-        } else {
-            cur = query_option_descs(drive_config_groups[i]->desc);
-            connect_infolist(head, cur);
-        }
-    }
-    cleanup_infolist(head);
-
-    return head;
-}
-
-static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty *prop)
-{
-    CommandLineParameterInfo *info;
-
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup(prop->name);
-
-    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOffAuto")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
-    } else if (g_str_equal(prop->type, "int")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
-    } else if (g_str_equal(prop->type, "size")) {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
-    } else {
-        info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-    }
-
-    if (prop->description) {
-        info->help = g_strdup(prop->description);
-    }
-
-    return info;
-}
-
-static CommandLineParameterInfoList *query_all_machine_properties(void)
-{
-    CommandLineParameterInfoList *params = NULL, *clpiter;
-    CommandLineParameterInfo *info;
-    GSList *machines, *curr_mach;
-    ObjectPropertyIterator op_iter;
-    ObjectProperty *prop;
-    bool is_new;
-
-    machines = object_class_get_list(TYPE_MACHINE, false);
-    assert(machines);
-
-    /* Loop over all machine classes */
-    for (curr_mach = machines; curr_mach; curr_mach = curr_mach->next) {
-        object_class_property_iter_init(&op_iter, curr_mach->data);
-        /* ... and over the properties of each machine: */
-        while ((prop = object_property_iter_next(&op_iter))) {
-            if (!prop->set) {
-                continue;
-            }
-            /*
-             * Check whether the property has already been put into the list
-             * (via another machine class)
-             */
-            is_new = true;
-            for (clpiter = params; clpiter != NULL; clpiter = clpiter->next) {
-                if (g_str_equal(clpiter->value->name, prop->name)) {
-                    is_new = false;
-                    break;
-                }
-            }
-            /* If it hasn't been added before, add it now to the list */
-            if (is_new) {
-                info = objprop_to_cmdline_prop(prop);
-                QAPI_LIST_PREPEND(params, info);
-            }
-        }
-    }
-
-    g_slist_free(machines);
-
-    /* Add entry for the "type" parameter */
-    info = g_malloc0(sizeof(*info));
-    info->name = g_strdup("type");
-    info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-    info->help = g_strdup("machine type");
-    QAPI_LIST_PREPEND(params, info);
-
-    return params;
-}
-
-CommandLineOptionInfoList *qmp_query_command_line_options(const char *option,
-                                                          Error **errp)
-{
-    CommandLineOptionInfoList *conf_list = NULL;
-    CommandLineOptionInfo *info;
-    int i;
-
-    for (i = 0; vm_config_groups[i] != NULL; i++) {
-        if (!option || !strcmp(option, vm_config_groups[i]->name)) {
-            info = g_malloc0(sizeof(*info));
-            info->option = g_strdup(vm_config_groups[i]->name);
-            if (!strcmp("drive", vm_config_groups[i]->name)) {
-                info->parameters = get_drive_infolist();
-            } else {
-                info->parameters =
-                    query_option_descs(vm_config_groups[i]->desc);
-            }
-            QAPI_LIST_PREPEND(conf_list, info);
-        }
-    }
-
-    if (!option || !strcmp(option, "machine")) {
-        info = g_malloc0(sizeof(*info));
-        info->option = g_strdup("machine");
-        info->parameters = query_all_machine_properties();
-        QAPI_LIST_PREPEND(conf_list, info);
-    }
-
-    if (conf_list == NULL) {
-        error_setg(errp, "invalid option name: %s", option);
-    }
-
-    return conf_list;
-}
-
 QemuOptsList *qemu_find_opts_err(const char *group, Error **errp)
 {
     return find_list(vm_config_groups, group, errp);
diff --git a/monitor/meson.build b/monitor/meson.build
index 5269492cf05..a71523a1ce8 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -4,6 +4,7 @@ system_ss.add(files(
   'fds.c',
   'hmp-cmds.c',
   'hmp.c',
+  'qemu-config-qmp.c',
 ))
 system_ss.add([spice_headers, files('qmp-cmds.c')])
 
-- 
2.44.0



