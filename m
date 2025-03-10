Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706ACC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treqd-0000NM-H4; Mon, 10 Mar 2025 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treqa-00007d-1w
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:15:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treqQ-0008D3-OQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:15:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so37035345e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619704; x=1742224504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7J8UWUXia4S/l3hOcieA10+PUQa1P2XxB/lqNf2FKU=;
 b=u2edDDQoQ+k8qevtx2BHo65gs2nyKwVFcmOSVYAV/8/yZVbWOT+cSXlKF9HE/m1Fht
 gW5dN84HT1V0flxNPaGXfQVO+QzA8rKkMz3Ac1tYadVFlXgmyjwL7V+S8rOrzmUP2IUb
 RdAryFKHkfjMnmdpk6+VzXDJC1tDRQIhiArzrYTab8JCRZLVCrc+USo/72cic1KOD76O
 d/jtpoj/nNdWedkb9YgzfjM/l+N9V0yw00KW2Pos+f+cTjIV6RylN6phLHm0FJZhjZPA
 5wIW4bSZ9pYqS21l1pS2lE/tojv2akCEZRIPLvfszASMjooXoz+t47/ffBP5Sh9BBE4n
 j0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619704; x=1742224504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7J8UWUXia4S/l3hOcieA10+PUQa1P2XxB/lqNf2FKU=;
 b=LMJ48om12HZaFUUxOOkr2WWUxVWyg2Tcri+vkN8vhqKIwgZUNuKX+x+xuIsIb8H6j4
 QZEd9/iyAWd3Yc3/1glRaSFkOUx3EIcUYn7c0KxY+vptezWhJXNjWHSKn8vWTAYrDIU/
 3B7O3ZkqhopD0AN51YISJHqdZ1dwGQSnjoqb46rtk6RJ/DxrEpAIIcyiSxNJurl9W4PM
 Jj6gaPAGvqWZxjN0fdn08VhkEbSHShJn2wRpbQ7fmsMy3/O7w/QK/6UQPFj9LEwJWRw8
 SxlZzwZMVxiyxGtgXmlrrzVYoemthfbZR23zEsQBYyjPCjnVnb4u50kjAAHIoA9C0VEw
 5YbQ==
X-Gm-Message-State: AOJu0Yxo/3Q//R1CI/c5TWZquwelfxtY4kdqeQZtvEfga6aaSAD6z7PS
 nSKGqXuHUT1eDdBVMVQLZoRydNcmNjU8E+ae0aH03QosdJiAgN6gQS2JHI62yymdF2nkaLnOJgp
 Dec8=
X-Gm-Gg: ASbGncvphAjFB4ocA3IpoQ6JiLDUH7aG9ORx1U8pU/DlKFGXxoxOUyOCLJO1rb6CWbA
 9w6uTgn7tMiWVvTxmUHhTEgyrhuZXZa5FO0lIzCHMqWv89WnqNFFwiINL/kgO2keuOF7yG6upQE
 WQwqfxIXLmQuyNFUwD42R7oE/dv2i1EgwGD+/lH565F3mvjsc5ugWtkqOzaJkHuUD27FlIYEi2O
 PEcqwahnOhI0MqIhGX4EPS26ZEUIDFIMq4Ckjqy5OecstZJtTcbHHjR7MHiArVkU7Ef+yXAvEcS
 cNgP4sZH6FCQIBOFUzsBnotb1qVffkuX6qpQSfquitfdMUf6eVhDW2cYzMjZeLcCMs4jFgyOBRm
 Tx4Frmzcl4I6XmLak/uQ=
X-Google-Smtp-Source: AGHT+IHNn3qDhQ1EQFcHNEdBrWFTofR5+myaotDnj7aa1BD6sSCoZc72fTRPLUuYlXdw43o1f/awkQ==
X-Received: by 2002:a05:600c:4710:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-43cf470795dmr34821045e9.12.1741619703758; 
 Mon, 10 Mar 2025 08:15:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cea7f2afasm42638805e9.3.2025.03.10.08.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 08:15:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 4/4] qapi/machine: Make @dump-skeys command generic
Date: Mon, 10 Mar 2025 16:14:14 +0100
Message-ID: <20250310151414.11550-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310151414.11550-1-philmd@linaro.org>
References: <20250310151414.11550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Reduce misc-target.json by one target specific command.

Error message is returned for machines not implementing
TYPE_DUMP_SKEYS_INTERFACE:

  $ qemu-system-aarch64 -M virt -S -qmp stdio
  {"QMP": {"version": {"qemu": {"micro": 50, "major": 9}}, "capabilities": ["oob"]}}
  { "execute": "qmp_capabilities" }
  {"return": {}}
  { "execute": "dump-skeys", "arguments": { "filename": "/tmp/foo" }  }
  {"error": {"class": "GenericError", "desc": "Storage keys information not available for this architecture"}}

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 18 ++++++++++++++++++
 qapi/misc-target.json      | 19 -------------------
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 hw/s390x/s390-skeys.c      |  6 +-----
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..a9ff8076317 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,21 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @dump-skeys:
+#
+# Dump the storage keys for an s390x guest
+#
+# @filename: the path to the file to dump to
+#
+# Since: 2.5
+#
+# .. qmp-example::
+#
+#     -> { "execute": "dump-skeys",
+#          "arguments": { "filename": "/tmp/skeys" } }
+#     <- { "return": {} }
+##
+{ 'command': 'dump-skeys',
+  'data': { 'filename': 'str' } }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8c..42e4a7417dc 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -274,25 +274,6 @@
   'returns': 'SevAttestationReport',
   'if': 'TARGET_I386' }
 
-##
-# @dump-skeys:
-#
-# Dump guest's storage keys
-#
-# @filename: the path to the file to dump to
-#
-# Since: 2.5
-#
-# .. qmp-example::
-#
-#     -> { "execute": "dump-skeys",
-#          "arguments": { "filename": "/tmp/skeys" } }
-#     <- { "return": {} }
-##
-{ 'command': 'dump-skeys',
-  'data': { 'filename': 'str' },
-  'if': 'TARGET_S390X' }
-
 ##
 # @GICCapability:
 #
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..fd8b4e0b44c 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -25,6 +25,7 @@
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "hw/s390x/storage-keys.h"
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
@@ -406,3 +407,16 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     info->guid = qemu_uuid_unparse_strdup(&vms->guid);
     return info;
 }
+
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    ObjectClass *mc = object_get_class(qdev_get_machine());
+    ObjectClass *oc = object_class_dynamic_cast(mc, TYPE_DUMP_SKEYS_INTERFACE);
+
+    if (!oc) {
+        error_setg(errp, "Storage keys information not available"
+                         " for this architecture");
+        return;
+    }
+    DUMP_SKEYS_INTERFACE_CLASS(oc)->qmp_dump_skeys(filename, errp);
+}
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index fd1123b0f35..067ea037268 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
@@ -219,11 +220,6 @@ out:
     fclose(f);
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
-{
-    s390_qmp_dump_skeys(filename, errp);
-}
-
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
-- 
2.47.1


