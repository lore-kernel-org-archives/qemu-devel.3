Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA5606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FbMHM33b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtz-0005xs-SS; Thu, 12 Nov 2026 08:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtx-0005wP-FA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtv-0002yh-Sp
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ugvuoln11bq7jPfoM7ohSVFem72ITV9HCZSrAhhzFg=;
 b=FbMHM33bjKvXSvQKKPksKMXuEAfa7jO0KySAf59lxjjXlNf6rANTBr4vAjCMSu1ujs6uMK
 hng/WbUjibhRiZAVhH5b0iwpj2IdsTNvjQm3ttl6NhgOXWEkQj1FCIhHoy4heJps0b+Fs3
 MRhUwFBeYkn0gGjqzAWTa+6XtjCOf7A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-upCHXbiBO3G4Iv3Hv2AEaQ-1; Thu,
 12 Nov 2026 08:31:37 -0500
X-MC-Unique: upCHXbiBO3G4Iv3Hv2AEaQ-1
X-Mimecast-MFC-AGG-ID: upCHXbiBO3G4Iv3Hv2AEaQ_1794490296
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EF501899FC9; Thu, 12 Nov 2026 13:31:36 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC7F1956087; Thu, 12 Nov 2026 13:31:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 21/48] hw: drop 'alias' field from MachineClass
Date: Thu, 12 Nov 2026 13:30:27 +0000
Message-ID: <20261112133054.1977618-22-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Everything is converted to use the AliasedClass 'aliases' field
now.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 16 ++++------------
 include/hw/core/boards.h   |  1 -
 system/vl.c                |  4 +---
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 787c69e176f..ade5a31c239 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -175,6 +175,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         if (alc->aliases) {
             strList **aliases = &info->aliases;
             size_t i;
+            int len;
             info->has_aliases = true;
             for (i = 0; alc->aliases[i] != NULL; i++) {
                 /*
@@ -182,21 +183,12 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
                  * we report machine types to the user, hence must
                  * strip the typename suffix
                  */
-                int len = strlen(alc->aliases[i]) - strlen(TYPE_MACHINE_SUFFIX);
+                len = strlen(alc->aliases[i]) - strlen(TYPE_MACHINE_SUFFIX);
                 QAPI_LIST_APPEND(aliases,
                                  g_strndup(alc->aliases[i], len));
             }
-            if (!mc->alias) {
-                int len = strlen(alc->aliases[0]) - strlen(TYPE_MACHINE_SUFFIX);
-                info->alias = g_strndup(alc->aliases[0], len);
-            }
-        }
-        if (mc->alias) {
-            info->alias = g_strdup(mc->alias);
-            if (!info->aliases) {
-                strList **aliases = &info->aliases;
-                QAPI_LIST_APPEND(aliases, g_strdup(mc->alias));
-            }
+            len = strlen(alc->aliases[0]) - strlen(TYPE_MACHINE_SUFFIX);
+            info->alias = g_strndup(alc->aliases[0], len);
         }
 
         info->name = g_strdup(mc->name);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index ea1e26a8c52..0a5517a2a13 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -270,7 +270,6 @@ struct MachineClass {
 
     const char *family; /* NULL iff @name identifies a standalone machtype */
     char *name;
-    const char *alias;
     const char *desc;
     const char *deprecation_reason;
 
diff --git a/system/vl.c b/system/vl.c
index f4e17173f96..fb5d55f3d68 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -852,7 +852,7 @@ static ObjectClass *find_machine(const char *name, GSList *machines,
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
 
-        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+        if (!strcmp(mc->name, name)) {
             return OBJECT_CLASS(mc);
         }
     }
@@ -1598,8 +1598,6 @@ static void machine_help_func(const QDict *qdict)
                              strlen(TYPE_MACHINE_SUFFIX)),
                        alc->aliases[i], mc->desc, mc->name);
             }
-        } else if (mc->alias) {
-            printf("%-25s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
         printf("%-25s %s%s%s%s\n", mc->name, mc->desc,
                mc->is_default ? " (default)" : "",
-- 
2.56.1


