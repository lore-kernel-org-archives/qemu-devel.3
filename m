Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D8C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYd1-0006L7-3X; Mon, 10 Jun 2024 02:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYd0-0006Kc-0v
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYcy-0007Nu-AT
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:35:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42198492353so5002215e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001334; x=1718606134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cLqCWiC1J/ZUjSxyI/3+bTiT19Rcz0X6qNntKz3//M=;
 b=axOykuzGwvcOsvrU2gkkVYghweAZoFgjy36rfNuLfz52qfdcKTPFmoL2iX0BPaaf2n
 zYplR3g+66uP8msH162wQj0Hh8FzAfG1rhxH1AuwO3IAu6sK5WGRhR0po90Y5VLv2IEz
 TRaUrwPBjQopRUCupMjFOZUGkpJnl/rwLN5MC6lS8d5qvGMNg1QWmpkAA+Gm6KY/VIqU
 UgdZNd8AYZdanT4UCNyZNcUSD+iWHyzPDDV/Xse2m4fwTB1bnDIr/1ALFXY6c2ZbITbT
 sQqovD2dtfNPVrn12Veoj2sWJwOC1AuGRLQanCwuZ+/jT80ai9XOefMGaSWBRLG2JOGG
 serQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001334; x=1718606134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cLqCWiC1J/ZUjSxyI/3+bTiT19Rcz0X6qNntKz3//M=;
 b=pypibmQKvn+mQpkkaIjC0or+I06OPa1ssdeVPPbIowoFmdJswN3Mc2nRACcWPue8i2
 gDV2N7cRJzNDIvJS8v1GD2ON1HckGhfq5wgDt5E7T5dtGkSaAVI8M5cqYQz35VBOT1/b
 QwUoOiMl/Y+FO3l9fxkK+UMHGClnW9LZ0MRxAS+42gl/KlE5Bp2Qoo4MoeDsY5i5Jrm1
 T+L4XMur0yCKekWg1Ey8gQ4bV2zI14gWZxOu5jgBDwyrdO9Q1FhnK5QIO6wGmXxCS2AA
 0O4po/A+uZLQ2iHnG2SOJZAozlqp+/VgsGsM959QBm8E77f7wHMhyPl4Wl3g5t1T05wl
 CPtQ==
X-Gm-Message-State: AOJu0YxQnKG5x0UzZNXgQCo9UtPm0N1ii55WV9kndFSuQNY9R+zxzm2M
 QoAjo2ANosHqc9d7KfHKoouNpw2ThdxGnKE1jLH8LelQhdvAd3rWaChZAEFoNIpfXgDkMB6m42i
 M
X-Google-Smtp-Source: AGHT+IEojMPBFu+PLUW0SXOmJHDF8O3UILz2bwhIh5nlqWn3DpEg9JC7hk6RyAil/HtLB8oP3w/Dfw==
X-Received: by 2002:a05:600c:3547:b0:421:dd8c:3588 with SMTP id
 5b1f17b1804b1-421dd8c3951mr10554165e9.21.1718001334369; 
 Sun, 09 Jun 2024 23:35:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f29116506sm123147f8f.60.2024.06.09.23.35.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:35:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Don Porter <porter@cs.unc.edu>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] hw/intc: Introduce x-query-interrupt-controllers QMP
 command
Date: Mon, 10 Jun 2024 08:35:17 +0200
Message-ID: <20240610063518.50680-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610063518.50680-1-philmd@linaro.org>
References: <20240610063518.50680-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a counterpart to the HMP "info pic" command. It is being
added with an "x-" prefix because this QMP command is intended as an
adhoc debugging tool and will thus not be modelled in QAPI as fully
structured data, nor will it have long term guaranteed stability.
The existing HMP command is rewritten to call the QMP command.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 17 +++++++++++++++++
 hw/core/machine-qmp-cmds.c | 29 +++++++++++++++++++++++++++++
 monitor/hmp-cmds.c         | 33 ---------------------------------
 hmp-commands-info.hx       |  2 +-
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 453feb9347..1283d14493 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1864,3 +1864,20 @@
 { 'command': 'dumpdtb',
   'data': { 'filename': 'str' },
   'if': 'CONFIG_FDT' }
+
+##
+# @x-query-interrupt-controllers:
+#
+# Query information on interrupt controller devices
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: Interrupt controller device information
+#
+# Since: 9.1
+##
+{ 'command': 'x-query-interrupt-controllers',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ]}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 5972100b1f..130217da8f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -361,6 +361,35 @@ HumanReadableText *qmp_x_query_irq(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+static int qmp_x_query_intc_foreach(Object *obj, void *opaque)
+{
+    InterruptStatsProvider *intc;
+    InterruptStatsProviderClass *k;
+    GString *buf = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
+        intc = INTERRUPT_STATS_PROVIDER(obj);
+        k = INTERRUPT_STATS_PROVIDER_GET_CLASS(obj);
+        if (k->print_info) {
+            k->print_info(intc, buf);
+        } else {
+            g_string_append_printf(buf,
+                                   "Interrupt controller information not available for %s.\n",
+                                   object_get_typename(obj));
+        }
+    }
+
+    return 0;
+}
+
+HumanReadableText *qmp_x_query_interrupt_controllers(Error **errp)
+{
+    g_autoptr(GString) buf = g_string_new("");
+    object_child_foreach_recursive(object_get_root(),
+                                   qmp_x_query_intc_foreach, buf);
+    return human_readable_text_from_str(buf);
+}
+
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
 {
     GuidInfo *info;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index fbff7fdb57..45ee3a9e1f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,9 +25,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/type-helpers.h"
 #include "qemu/cutils.h"
-#include "hw/intc/intc.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
 
@@ -83,37 +81,6 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
     qapi_free_VersionInfo(info);
 }
 
-static int hmp_info_pic_foreach(Object *obj, void *opaque)
-{
-    InterruptStatsProvider *intc;
-    InterruptStatsProviderClass *k;
-    Monitor *mon = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_INTERRUPT_STATS_PROVIDER)) {
-        intc = INTERRUPT_STATS_PROVIDER(obj);
-        k = INTERRUPT_STATS_PROVIDER_GET_CLASS(obj);
-        if (k->print_info) {
-            g_autoptr(GString) buf = g_string_new("");
-            g_autoptr(HumanReadableText) info = NULL;
-
-            k->print_info(intc, buf);
-            info = human_readable_text_from_str(buf);
-            monitor_puts(mon, info->human_readable_text);
-        } else {
-            monitor_printf(mon, "Interrupt controller information not available for %s.\n",
-                           object_get_typename(obj));
-        }
-    }
-
-    return 0;
-}
-
-void hmp_info_pic(Monitor *mon, const QDict *qdict)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   hmp_info_pic_foreach, mon);
-}
-
 void hmp_quit(Monitor *mon, const QDict *qdict)
 {
     monitor_suspend(mon);
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 20a9835ea8..cfd4ad5651 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -174,7 +174,7 @@ ERST
         .args_type  = "",
         .params     = "",
         .help       = "show PIC state",
-        .cmd        = hmp_info_pic,
+        .cmd_info_hrt = qmp_x_query_interrupt_controllers,
     },
 
 SRST
-- 
2.41.0


