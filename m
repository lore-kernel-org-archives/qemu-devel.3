Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001C5C54E68
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKea-0000nr-Sy; Mon, 18 Mar 2024 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeW-0000ml-0r
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:16 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davydov-max@yandex-team.ru>)
 id 1rmKeS-0004p1-Fj
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:36:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5a2f:0:640:431a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id DA3F060C90;
 Tue, 19 Mar 2024 00:36:08 +0300 (MSK)
Received: from davydov-max-nux.yandex-team.ru (unknown
 [2a02:6b8:b081:b660::1:2d])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pZLCWv3IeqM0-HmVUIZ2D; Tue, 19 Mar 2024 00:36:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710797768;
 bh=P9+dUE+W1PPWsKgu9qcSIQgkYsZKNQJ0c4ZPj/oComg=;
 h=Cc:Message-Id:References:Date:In-Reply-To:Subject:To:From;
 b=SRe3b7QPbFiO3G6O3mfk4UO+xuabwSnffH5K+Q9QLiCZiPWrw72IcCND0Y42OQZVd
 QQHAbMchVQgx4WGm3H5fFvcePIlCWB2HqBahJWOSvN9zRE8VipS9TM7WfmLlUrspZJ
 HQmXtGYLBJVj0Q/VW59UOeY6wMAhuI+zWlNnsx2M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: davydov-max@yandex-team.ru, vsementsov@yandex-team.ru,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: [PULL v2 2/4] qmp: add dump machine type compatibility properties
Date: Tue, 19 Mar 2024 00:35:48 +0300
Message-Id: <20240318213550.155573-3-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318213550.155573-1-davydov-max@yandex-team.ru>
References: <20240318213550.155573-1-davydov-max@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=davydov-max@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To control that creating new machine type doesn't affect the previous
types (their compat_props) and to check complex compat_props inheritance
we need qmp command to print machine type compatibility properties.
This patch adds the ability to get list of all the compat_props of the
corresponding supported machines for their comparison via new optional
argument of "query-machines" command. Since information on compatibility
properties can increase the command output by a factor of 40, add an
argument to enable it, default off.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/machine-qmp-cmds.c  | 23 ++++++++++++-
 qapi/machine.json           | 67 +++++++++++++++++++++++++++++++++++--
 tests/qtest/fuzz/qos_fuzz.c |  2 +-
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 4b72009cd3..2fac989623 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -65,7 +65,8 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     return head;
 }
 
-MachineInfoList *qmp_query_machines(Error **errp)
+MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
+                                    Error **errp)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineInfoList *mach_list = NULL;
@@ -97,6 +98,26 @@ MachineInfoList *qmp_query_machines(Error **errp)
             info->default_ram_id = g_strdup(mc->default_ram_id);
         }
 
+        if (compat_props && mc->compat_props) {
+            int i;
+            info->compat_props = NULL;
+            CompatPropertyList **tail = &(info->compat_props);
+            info->has_compat_props = true;
+
+            for (i = 0; i < mc->compat_props->len; i++) {
+                GlobalProperty *mt_prop = g_ptr_array_index(mc->compat_props,
+                                                            i);
+                CompatProperty *prop;
+
+                prop = g_malloc0(sizeof(*prop));
+                prop->qom_type = g_strdup(mt_prop->driver);
+                prop->property = g_strdup(mt_prop->property);
+                prop->value = g_strdup(mt_prop->value);
+
+                QAPI_LIST_APPEND(tail, prop);
+            }
+        }
+
         QAPI_LIST_PREPEND(mach_list, info);
     }
 
diff --git a/qapi/machine.json b/qapi/machine.json
index bb5a178909..2de4d16a39 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -135,6 +135,26 @@
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
+##
+# @CompatProperty:
+#
+# Property default values specific to a machine type, for use by
+# scripts/compare-machine-types.
+#
+# @qom-type: name of the QOM type to which the default applies
+#
+# @property: name of its property to which the default applies
+#
+# @value: the default value (machine-specific default can overwrite
+#     the "default" default, to avoid this use -machine none)
+#
+# Since: 9.1
+##
+{ 'struct': 'CompatProperty',
+  'data': { 'qom-type': 'str',
+            'property': 'str',
+            'value': 'str' } }
+
 ##
 # @MachineInfo:
 #
@@ -166,6 +186,14 @@
 #
 # @acpi: machine type supports ACPI (since 8.0)
 #
+# @compat-props: The machine type's compatibility properties.  Only
+#     present when query-machines argument @compat-props is true.
+#     (since 9.1)
+#
+# Features:
+#
+# @unstable: Member @compat-props is experimental.
+#
 # Since: 1.2
 ##
 { 'struct': 'MachineInfo',
@@ -173,18 +201,53 @@
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
-            '*default-ram-id': 'str', 'acpi': 'bool' } }
+            '*default-ram-id': 'str', 'acpi': 'bool',
+            '*compat-props': { 'type': ['CompatProperty'],
+                               'features': ['unstable'] } } }
 
 ##
 # @query-machines:
 #
 # Return a list of supported machines
 #
+# @compat-props: if true, also return compatibility properties.
+#     (default: false) (since 9.1)
+#
+# Features:
+#
+# @unstable: Argument @compat-props is experimental.
+#
 # Returns: a list of MachineInfo
 #
 # Since: 1.2
+#
+# Example:
+#
+#     -> { "execute": "query-machines", "arguments": { "compat-props": true } }
+#     <- { "return": [
+#               {
+#                  "hotpluggable-cpus": true,
+#                  "name": "pc-q35-6.2",
+#                  "compat-props": [
+#                       {
+#                          "qom-type": "virtio-mem",
+#                          "property": "unplugged-inaccessible",
+#                          "value": "off"
+#                       }
+#                   ],
+#                   "numa-mem-supported": false,
+#                   "default-cpu-type": "qemu64-x86_64-cpu",
+#                   "cpu-max": 288,
+#                   "deprecated": false,
+#                   "default-ram-id": "pc.ram"
+#               },
+#               ...
+#        }
 ##
-{ 'command': 'query-machines', 'returns': ['MachineInfo'] }
+{ 'command': 'query-machines',
+  'data': { '*compat-props': { 'type': 'bool',
+                               'features': [ 'unstable' ] } },
+  'returns': ['MachineInfo'] }
 
 ##
 # @CurrentMachineParams:
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index e403d373a0..b71e945c5f 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -46,7 +46,7 @@ static void qos_set_machines_devices_available(void)
     MachineInfoList *mach_info;
     ObjectTypeInfoList *type_info;
 
-    mach_info = qmp_query_machines(&error_abort);
+    mach_info = qmp_query_machines(false, false, &error_abort);
     machines_apply_to_node(mach_info);
     qapi_free_MachineInfoList(mach_info);
 
-- 
2.34.1


