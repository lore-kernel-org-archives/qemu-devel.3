Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C2C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwru-0007oC-FM; Thu, 25 Apr 2024 07:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrq-0007lf-P9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:18 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrn-00089U-Q5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:18 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2dd041acff1so9300301fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042933; x=1714647733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLZ+JSbydZ+0P9XLjVkCEIbh5VWxC42GBVm2ZIIKLSk=;
 b=J4G96lAURIAg+kmcYhgjVDW9HYr8wnW1rI66EHq9itxF++2G7BpXZcwRrHgspLFJz4
 qXJTpVMA6A2XKRpDYkHZBFX8QDaLENEum298A7VBXw2BMfsS8QoTdQ28D7fT21wi4a1D
 CsXRg96wAghBks2Imv6xfFZjyZiPfg1PEEEeI3IjEREz2VbKN5E5+h/a7Mw39G+emooP
 IEWrMMiz9Bcjkev0ZR9KT9uCTNR+ar/BdFTgRDywXF6PSbbyXcvquk897uBj+GWe50Uq
 VpyUyv7T6C1Dnpr++Csov+MXkZFOhEUBUTHaWUj1pl/1iSRU/YikE65P4g1Gm9hIbiHD
 lUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042933; x=1714647733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLZ+JSbydZ+0P9XLjVkCEIbh5VWxC42GBVm2ZIIKLSk=;
 b=ffuy7P8zXZeuSPIP6zmD14irKv+c+Wk/lp5rsmLPzaxGy2caDll2Ss2e4ipnzzwiFi
 TBHDg8mgQm8Q8P9lVZf4zB8Q4hADG5IR/Rd041irekAc27v0EYR5VLASlgNKi98PF4aG
 JYN7MYe0zITWifDyNNIazovrxUGslCHwLJtBpxbtcFJcfk2fiNl62ai28q2wqV38Rbl8
 GYfWJBVu3V05SxNtNO9cTHdtOBPKHjrKJRIp+BvAjP2M25kxIiMooLwV+VNWxQ0YSDEn
 C7q4Chhs6rNTO1/qO5/gqNdTKYCHWcT5RuNYWOjexPxaxldlMGKZ5CEJTJu6UV94GNjP
 8xqg==
X-Gm-Message-State: AOJu0YxJhgKQkZwQV1LlUZn0z3RJnmzas0cVWirIufHKulMc1Gqux/Go
 itGlXPjZxiCiu/PQd7kl7kiZ6SXoVA1e4y30ASX0w1sftbL24KXi5O8kU8cNsy+G15kheN91cT1
 Z
X-Google-Smtp-Source: AGHT+IEIwEKtRxzjDxE5XZKOER0BztzWhqxqJNsv78wTLrxRgsPNwlOo5sgeR9LyeZoBJnnXiQJaKA==
X-Received: by 2002:a2e:88d1:0:b0:2dd:2fc:3cd with SMTP id
 a17-20020a2e88d1000000b002dd02fc03cdmr3419727ljk.29.1714042933255; 
 Thu, 25 Apr 2024 04:02:13 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 bi14-20020a05600c3d8e00b0041b5944a197sm1195465wmb.45.2024.04.25.04.02.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 02/22] qmp: add dump machine type compatibility properties
Date: Thu, 25 Apr 2024 13:01:35 +0200
Message-ID: <20240425110157.20328-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

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
Message-ID: <20240318213550.155573-3-davydov-max@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json           | 67 +++++++++++++++++++++++++++++++++++--
 hw/core/machine-qmp-cmds.c  | 23 ++++++++++++-
 tests/qtest/fuzz/qos_fuzz.c |  2 +-
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2df407e877..3e9cc3f17d 100644
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
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index c20829b9ae..5972100b1f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -64,7 +64,8 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     return head;
 }
 
-MachineInfoList *qmp_query_machines(Error **errp)
+MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
+                                    Error **errp)
 {
     GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineInfoList *mach_list = NULL;
@@ -96,6 +97,26 @@ MachineInfoList *qmp_query_machines(Error **errp)
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
2.41.0


