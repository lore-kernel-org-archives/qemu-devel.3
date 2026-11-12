Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54803606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PmrrkZiV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtd-0005mk-H1; Thu, 12 Nov 2026 08:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUta-0005jO-4T
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtY-0001Ia-17
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lwn56zNkYqAvYtlO4GevRmmSKH6d6k6649k/+dHppWw=;
 b=PmrrkZiV3s03MByH6mgXmB/7jw/qtQKv2iKygfs97T/G691HQnooA8JgGJnE9bx5HY0+Ed
 +LLXBGhjD5pt0l5D2l0wAcSJKDlmvCtkr+Ovf1Okyy1FU38hM4atQhnO1tChir2wyr8Mxh
 uMNrhItqEHMqcsyDsHFfAPGPrcmCZAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-dBH6RHHuO9efW6v6C6ZeEQ-1; Thu,
 12 Nov 2026 08:31:12 -0500
X-MC-Unique: dBH6RHHuO9efW6v6C6ZeEQ-1
X-Mimecast-MFC-AGG-ID: dBH6RHHuO9efW6v6C6ZeEQ_1794490271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E89C1800548; Thu, 12 Nov 2026 13:31:11 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E51FE1956089; Thu, 12 Nov 2026 13:31:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/48] qapi: report multiple aliases in MachineInfo
Date: Thu, 12 Nov 2026 13:30:13 +0000
Message-ID: <20261112133054.1977618-8-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MachineInfo struct is extended to report the list of aliases
from the TYPE_ALIASED interface, in preference to the traditional
alias from the TYPE_MACHINE struct.

Initially we use 'alias' to fill the 'aliases' field in QOM. As
machines get converted to set 'aliases', the first 'aliases'
element will get used to fill 'alias. This provides backcompat
during the transition phase.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 25 +++++++++++++++++++++++++
 qapi/machine.json          |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 0558d6d703c..787c69e176f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -33,6 +33,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
+#include "qom/object_interfaces.h"
 
 /*
  * QMP query for enabled and present accelerators
@@ -163,6 +164,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
+        AliasedClass *alc = ALIASED_CLASS(mc);
 
         info = g_malloc0(sizeof(*info));
         if (mc->is_default) {
@@ -170,8 +172,31 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
             info->is_default = true;
         }
 
+        if (alc->aliases) {
+            strList **aliases = &info->aliases;
+            size_t i;
+            info->has_aliases = true;
+            for (i = 0; alc->aliases[i] != NULL; i++) {
+                /*
+                 * We record type names internally, but publically
+                 * we report machine types to the user, hence must
+                 * strip the typename suffix
+                 */
+                int len = strlen(alc->aliases[i]) - strlen(TYPE_MACHINE_SUFFIX);
+                QAPI_LIST_APPEND(aliases,
+                                 g_strndup(alc->aliases[i], len));
+            }
+            if (!mc->alias) {
+                int len = strlen(alc->aliases[0]) - strlen(TYPE_MACHINE_SUFFIX);
+                info->alias = g_strndup(alc->aliases[0], len);
+            }
+        }
         if (mc->alias) {
             info->alias = g_strdup(mc->alias);
+            if (!info->aliases) {
+                strList **aliases = &info->aliases;
+                QAPI_LIST_APPEND(aliases, g_strdup(mc->alias));
+            }
         }
 
         info->name = g_strdup(mc->name);
diff --git a/qapi/machine.json b/qapi/machine.json
index 18d9dce849b..c25a492a4e8 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -163,6 +163,8 @@
 #
 # @alias: an alias for the machine name
 #
+# @aliases: a list of aliases for the machine type name (since 12.0)
+#
 # @is-default: whether the machine is default
 #
 # @cpu-max: maximum number of CPUs supported by the machine type
@@ -202,6 +204,7 @@
 ##
 { 'struct': 'MachineInfo',
   'data': { 'name': 'str', '*alias': 'str',
+            '*aliases': ['str'],
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
-- 
2.56.1


