Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84391606A33D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RCa+ii7F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUv0-0006me-5S; Thu, 12 Nov 2026 08:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuR-0006Vo-1r
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuN-0004u3-O5
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcsPAP6A9rO42+7PFbjtLt/31ignVRJz/1PtJ6upYDE=;
 b=RCa+ii7FiRoCpZdSML05czfX9fq9TZf6StX2Xs7lYqxF0/8igNX8rvqZPQZXFxpOF8SuO9
 8fU81z66BRZ7Dc3wO+mE0aj9ZY9xmwnSH8BYr5ww0GQ3OhWKCGXdJSmFXQ0PqsjwP+AM09
 BoUcMGDhGrjYB3iRYCpOT2gHzBnpKsQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-lRhHEQErM-yndS6aWiNGhg-1; Thu,
 12 Nov 2026 08:31:58 -0500
X-MC-Unique: lRhHEQErM-yndS6aWiNGhg-1
X-Mimecast-MFC-AGG-ID: lRhHEQErM-yndS6aWiNGhg_1794490317
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B654D1956088; Thu, 12 Nov 2026 13:31:57 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C6131956089; Thu, 12 Nov 2026 13:31:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 33/48] system: filter machines based on target during creation
Date: Thu, 12 Nov 2026 13:30:39 +0000
Message-ID: <20261112133054.1977618-34-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When creating a machine instance, validate that it is creatable
on the current selected target.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0afcc18866d..ca10e193f2b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -845,16 +845,21 @@ static bool usb_parse(const char *cmdline, Error **errp)
 /* machine registration */
 
 static ObjectClass *find_machine(const char *name, GSList *machines,
-                                 Error **errp)
+                                 bool creatable, Error **errp)
 {
     GSList *el;
     g_autofree char *typename = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *mc = el->data;
+        ObjectClass *oc = el->data;
+        MachineClass *mc = MACHINE_CLASS(oc);
 
         if (!strcmp(mc->name, name)) {
-            return OBJECT_CLASS(mc);
+            if (creatable) {
+                return target_specific_class_check(oc, errp);
+            } else {
+                return oc;
+            }
         }
     }
 
@@ -1551,7 +1556,8 @@ static void machine_help_func(const QDict *qdict)
     machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
         Error *local_err = NULL;
-        ObjectClass *machine_class = find_machine(type, machines, &local_err);
+        ObjectClass *machine_class =
+            find_machine(type, machines, false, &local_err);
         if (local_err) {
             error_report_err(local_err);
             return;
@@ -1697,7 +1703,7 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 
     if (machine_type) {
         machine_class = MACHINE_CLASS(
-            find_machine(machine_type, machines, errp));
+            find_machine(machine_type, machines, true, errp));
         qdict_del(qdict, "type");
     } else {
         machine_class = find_default_machine(machines);
-- 
2.56.1


