Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C1BC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Eci-00068y-QG; Thu, 17 Sep 2026 12:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcU-0005rQ-RZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcL-0006sj-AS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSZY2PhwDM9Fxaivu9DK/zZyur+tKhVl6Df8R3YZRwc=;
 b=GBjqa4UQYC65H3oSgUL2JIFtc9BaejXw+WPGyFI2GcvLVritHuXRiRyQ9mBBtMeSt4rygz
 lSDOt3wDHogSDImeLbN7qAd4yP9VcNcNWm7UpawkEiXS4H3FEsjn2O9dkXmQtj/xjZI/ON
 kv65IX4dshRUnXZBkNg3pLenY6soVWg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-MkMX_e8CMTWzm7bRPAlvYg-1; Thu,
 17 Sep 2026 12:05:39 -0400
X-MC-Unique: MkMX_e8CMTWzm7bRPAlvYg-1
X-Mimecast-MFC-AGG-ID: MkMX_e8CMTWzm7bRPAlvYg_1789661138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62803182E6BE; Thu, 17 Sep 2026 16:05:38 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EB7F300022B; Thu, 17 Sep 2026 16:05:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/14] system: check security for machine types
Date: Thu, 17 Sep 2026 17:05:17 +0100
Message-ID: <20260917160525.1275388-7-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index ca54da26c54..f54449b43e7 100644
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


