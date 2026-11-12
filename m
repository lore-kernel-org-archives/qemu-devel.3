Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714C606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dGEVXToW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtj-0005qu-68; Thu, 12 Nov 2026 08:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtg-0005pm-9N
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUte-0001ki-Pn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tx67dajEb5MwQkM63ainQDS0KtI3/omZOdYN0DWawIg=;
 b=dGEVXToWZs2BJVQKaHTejQePhXZa7GXUf1baFZJgBmHhOKbz//oCD9bi9fxy7N0P60REF+
 mCHorydfxmC2c7SU8aNrs2uqNemNstjA4QPoTGKroN2L82Roe1dI1qEEYulFkeP4/NxZwM
 vBCYwH2AFwT7HlfDgtNfvWU0EpkU6ZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Iem5twsIPY2hEPfeUhc5vQ-1; Thu,
 12 Nov 2026 08:31:17 -0500
X-MC-Unique: Iem5twsIPY2hEPfeUhc5vQ-1
X-Mimecast-MFC-AGG-ID: Iem5twsIPY2hEPfeUhc5vQ_1794490276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C733E195606B; Thu, 12 Nov 2026 13:31:16 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B252195608D; Thu, 12 Nov 2026 13:31:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/48] system: resolve multiple aliases when creating machines
Date: Thu, 12 Nov 2026 13:30:16 +0000
Message-ID: <20261112133054.1977618-11-berrange@redhat.com>
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

Use aliased_class_resolve() to lookup a machine class when
no primary QOM type or MachineClass alias matches.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index daf0637fb5e..f4e17173f96 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -843,19 +843,22 @@ static bool usb_parse(const char *cmdline, Error **errp)
 /***********************************************************/
 /* machine registration */
 
-static MachineClass *find_machine(const char *name, GSList *machines)
+static ObjectClass *find_machine(const char *name, GSList *machines,
+                                 Error **errp)
 {
     GSList *el;
+    g_autofree char *typename = NULL;
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
 
         if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
-            return mc;
+            return OBJECT_CLASS(mc);
         }
     }
 
-    return NULL;
+    typename = g_strdup_printf("%s" TYPE_MACHINE_SUFFIX, name);
+    return aliased_class_resolve(TYPE_MACHINE, typename, errp);
 }
 
 static MachineClass *find_default_machine(GSList *machines)
@@ -1572,11 +1575,14 @@ static void machine_help_func(const QDict *qdict)
 
     machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
-        ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
-        if (machine_class) {
-            type_print_class_properties(object_class_get_name(machine_class));
+        Error *local_err = NULL;
+        ObjectClass *machine_class = find_machine(type, machines, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
             return;
         }
+        type_print_class_properties(object_class_get_name(machine_class));
+        return;
     }
 
     printf("Supported machines are:\n");
@@ -1696,10 +1702,8 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
     MachineClass *machine_class = NULL;
 
     if (machine_type) {
-        machine_class = find_machine(machine_type, machines);
-        if (!machine_class) {
-            error_setg(errp, "unsupported machine type: \"%s\"", machine_type);
-        }
+        machine_class = MACHINE_CLASS(
+            find_machine(machine_type, machines, errp));
         qdict_del(qdict, "type");
     } else {
         machine_class = find_default_machine(machines);
-- 
2.56.1


