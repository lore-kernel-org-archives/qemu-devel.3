Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8C5C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4MY1-00017k-3S; Wed, 09 Sep 2026 13:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4MY0-00017U-2J
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4MXy-0004eB-IL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 13:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788976641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4v3mW10Ipprj3R5TPPbrP6YSI8nMwCr8UrUntQ//omc=;
 b=QA3p3vqsxyv4TEhxJzaC6EkHElvS3n+xfs0WSSH+OcyHhWdodNv7lBuTtDsvW3PqM52HUZ
 B+bxbK2SOggeCmkVHFcbh4yc+fUP5qDQm9utOhGrHaARXwCI7GvrnWRQOwvLMrfkmnY+mR
 wVle5F2pWBG8gFDEmn1oUh6/lXXov8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-m5p7TfRPNRSQQwa2za5taQ-1; Wed,
 09 Sep 2026 13:57:19 -0400
X-MC-Unique: m5p7TfRPNRSQQwa2za5taQ-1
X-Mimecast-MFC-AGG-ID: m5p7TfRPNRSQQwa2za5taQ_1788976638
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E8701955F3D; Wed,  9 Sep 2026 17:57:18 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67C5C195608C; Wed,  9 Sep 2026 17:57:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/14] system: check security for machine types
Date: Wed,  9 Sep 2026 18:56:48 +0100
Message-ID: <20260909175656.1572689-7-berrange@redhat.com>
In-Reply-To: <20260909175656.1572689-1-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This wires up the machine creation code to apply the compat policy
security check.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index ca54da26c5..f54449b43e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2201,11 +2201,18 @@ static void qemu_create_machine_containers(Object *machine)
     }
 }
 
-static void qemu_create_machine(QDict *qdict)
+static bool qemu_create_machine(QDict *qdict)
 {
+    Error *local_err = NULL;
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
     object_set_machine_compat_props(machine_class->compat_props);
 
+    if (!object_class_check_security(OBJECT_CLASS(machine_class),
+                                     &local_err)) {
+        error_report_err(local_err);
+        return false;
+    }
+
     current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
@@ -2237,6 +2244,8 @@ static void qemu_create_machine(QDict *qdict)
                                      false, &error_abort);
         qobject_unref(default_opts);
     }
+
+    return true;
 }
 
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -3790,7 +3799,9 @@ void qemu_init(int argc, char **argv)
     /* Transfer QemuOpts options into machine options */
     parse_memory_options();
 
-    qemu_create_machine(machine_opts_dict);
+    if (!qemu_create_machine(machine_opts_dict)) {
+        exit(1);
+    }
 
     /*
      * Load incoming CPR state before any devices are created, because it
-- 
2.55.0


