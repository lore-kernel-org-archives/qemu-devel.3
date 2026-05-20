Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858ACD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYf-00014Y-9g; Wed, 20 May 2026 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYd-000149-NI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYb-0007ED-Qj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoHGI7NaPvj5cSGbscsqHu1zPlGjHvSW5S0lgsmipWo=;
 b=A4rkJlgx4VCAhIPMVf43N00ZMrzCtlGjvZpIUesA7ydTgA5jEcD7bPU9oBItXcgLbN0xy8
 pehrvW536aAqH5BjrQ6bR/cDB++HTKK9ujDnJKZun8IhGn8vKIZXS+37lvHD/ZYcgaT/76
 ArqTXe2cqojHV7PcV+rd1USXahFlGJY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-klZegBDONta75IFPrhi52g-1; Wed, 20 May 2026 17:34:23 -0400
X-MC-Unique: klZegBDONta75IFPrhi52g-1
X-Mimecast-MFC-AGG-ID: klZegBDONta75IFPrhi52g_1779312863
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b46c014a26so168415756d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312862; x=1779917662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoHGI7NaPvj5cSGbscsqHu1zPlGjHvSW5S0lgsmipWo=;
 b=sqrOYyNaw7qykIKBXBQqr+kLHfBp4OwKBdhAdNbFMuRExNo3IXz7XM6ED9XqC0B3yT
 iryOJtT9Q0S3m1I8y9FTISKgeb+BXjKNfYCvpVVlehToQqH+gMfbcGH2lqNC7Zd8JiTA
 mU5NyvX67HvWXK07kaQKxMkkAY/N4SnG6Q6zlhMUIA5Tw26FtQSNf8Nv6dLnujO+esJp
 X8R/JMkQ138295I9B5qwb012m8sIFr0nPNOYausJRHIaoULw8JnUnL/863bDtrcBuglV
 oM3D/sW5pXZjm6zpHvJ2Uo7ishwEoCpf0gjVm+t50ZOXishEWWKIGVUSl/OFdPLtoI1v
 JR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312862; x=1779917662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hoHGI7NaPvj5cSGbscsqHu1zPlGjHvSW5S0lgsmipWo=;
 b=id83GenS5+zJPbnAcAJ/iiRgSsm7IZkbZafmxoSDcyTt9Hig3PWWMaVfb8RL+DyGT9
 e6JFQKXCq9NbZaguXxXb7NOKKu57X0yJehgpyaobQQLyYE0ZjrRzpZBjOXJJlUKM9Wy/
 /+lWYM2xgnOSgOLNAOUgb5jA6Fdw56gGw5gpNVkMSQAvdPn8qEkufWkwa0IT+1y/fhuW
 ban+SY+GKfjGTdfFsr71EwXnRAouflku+g/5C51k5j/xKccngxEToQXSX4OQgOPjccMK
 VvKx9k81Cl4qX6xPI4emC/vCRSvVbIurk4cyCYM49jZBsAMZ5Ith9nRzRx/7YPAQrwYA
 8cHw==
X-Gm-Message-State: AOJu0YyAUyOPO/5abqeJQNjtobs4xx79f2ipyI8Khe4UA65VB/S5Ov65
 +ZidJYu726aC955zGNh47WuQziOJJQ4VJ3HVSZE84xN73PUfXDsHboH2tE36CCilcWxoj5FSw4U
 Q9rR/d6qFnZSDD3cXf2+uP2PWwa/MzmYACOwHvgCo9Yo6bBjob7/KkeRBjkmuRmK6U+iTVUYJB3
 85OE4wOCZvOT4lhDMtPJLHNwH0T3lPRBkQ0xt1UQ==
X-Gm-Gg: Acq92OEdFRbGiwSVMCdipPEZGZ5fS1ke7fsukqzOdDAGc8V1xaajChhYIdFfOCU+o2v
 QpPlN8mD1eCQEDiWeJik2KEsXZVxO1N6AjVglBFtZIGUbOJF+0vZwjLmrfRnq1XLqMqoWnZUO+b
 equr4eyCPA/6v8zWBG9aFJP9eml5uPxRIYwsLDvwJnoVP11bzYfjcDz005xnyQ7Ia3Wwc5HhIwy
 ylvYBVGOtJw+fHp3ZIjzITsFjkJ1bIcMX8QlRoQNR/1XjRG3AnmN7mbAVH6zeNeFcxRKcj3b4/1
 x/0fPL8TCW8tM5Dukt+JCElMZUSOHI0KzjxZ8anJxw+1UWst0imFfzfQmhyAX+j6GvOB1wKLBUx
 JRAPih6KssWr//BmG4p2XQ/QTNnd/4LEvHm3pZ6DZW+EW
X-Received: by 2002:a05:6214:3bc7:b0:8c4:975c:25a7 with SMTP id
 6a1803df08f44-8cc6e37e422mr3369696d6.25.1779312862510; 
 Wed, 20 May 2026 14:34:22 -0700 (PDT)
X-Received: by 2002:a05:6214:3bc7:b0:8c4:975c:25a7 with SMTP id
 6a1803df08f44-8cc6e37e422mr3369086d6.25.1779312861893; 
 Wed, 20 May 2026 14:34:21 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 07/29] tests/qtest/migration: Move cpr transfer logic into
 cpr-tests.c
Date: Wed, 20 May 2026 17:33:35 -0400
Message-ID: <20260520213357.40646-8-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

There's some amount of cpr-transfer logic at precopy_common, which in
retrospect was a bad idea. For just two tests, that's too much code to
be in the common function. Move it to the cpr file. We'll need this
cleanup for subsequent improvements.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  3 --
 tests/qtest/migration/cpr-tests.c | 57 ++++++++++++++++++++++++++++---
 tests/qtest/migration/framework.c | 36 +++----------------
 3 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index bb534b8110..3ccc6a99d2 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -181,9 +181,6 @@ typedef struct {
      */
     const char *connect_channels;
 
-    /* Optional: the cpr migration channel, in JSON or dotted keys format */
-    const char *cpr_channel;
-
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 63ca5f3996..48c98f0089 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -15,6 +15,9 @@
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
+#include "qapi/error.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 
 
 static char *tmpfs;
@@ -42,10 +45,56 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
     test_file_common(args, true);
 }
 
-static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+static int test_transfer(MigrateCommon *args, const char *cpr_channel,
+                         bool incoming_defer)
 {
+    QTestState *from, *to;
+    QObject *obj, *out_channels = qobject_from_json(args->connect_channels,
+                                                    &error_abort);
+    QList *channels_list;
+
+    /*
+     * The cpr channel must be included in outgoing channels, but not in
+     * migrate-incoming channels.
+     */
+    channels_list = qobject_to(QList, out_channels);
+    obj = migrate_str_to_channel(cpr_channel);
+    qlist_append(channels_list, obj);
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return -1;
+    }
+
     migrate_set_parameter_str(from, "mode", "cpr-transfer");
-    return NULL;
+
+    wait_for_serial("src_serial");
+
+    qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+    wait_for_stop(from, get_src());
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, NULL, out_channels, "{}");
+
+    qtest_connect(to);
+    qtest_qmp_handshake(to, NULL);
+    if (incoming_defer) {
+        QObject *in_channels = qobject_from_json(args->connect_channels,
+                                                 &error_abort);
+
+        migrate_incoming_qmp(to, NULL, in_channels, "{}");
+    }
+
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+
+    qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+
+    wait_for_resume(to, get_dst());
+    wait_for_serial("dest_serial");
+
+    migrate_end(from, to, true);
+
+    return 0;
 }
 
 /*
@@ -86,15 +135,13 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
     args->listen_uri = incoming_defer ? "defer" : uri;
     args->connect_channels = connect_channels;
-    args->cpr_channel = cpr_channel;
-    args->start_hook = test_mode_transfer_start;
 
     args->start.opts_source = opts;
     args->start.opts_target = opts_target;
     args->start.defer_target_connect = true;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
-    if (test_precopy_common(args) < 0) {
+    if (test_transfer(args, cpr_channel, incoming_defer) < 0) {
         close(cpr_sockfd);
         unlink(cpr_path);
     }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 49c7f37e60..4cd07be1d5 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -20,7 +20,6 @@
 #include "ppc-util.h"
 #include "qapi/error.h"
 #include "qobject/qjson.h"
-#include "qobject/qlist.h"
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -833,10 +832,7 @@ int test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    QObject *in_channels = NULL;
-    QObject *out_channels = NULL;
-
-    g_assert(!args->cpr_channel || args->connect_channels);
+    QObject *channels = NULL;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
@@ -869,40 +865,16 @@ int test_precopy_common(MigrateCommon *args)
         }
     }
 
-    /*
-     * The cpr channel must be included in outgoing channels, but not in
-     * migrate-incoming channels.
-     */
     if (args->connect_channels) {
-        if (args->start.defer_target_connect &&
-            !strcmp(args->listen_uri, "defer")) {
-            in_channels = qobject_from_json(args->connect_channels,
-                                            &error_abort);
-        }
-        out_channels = qobject_from_json(args->connect_channels, &error_abort);
-
-        if (args->cpr_channel) {
-            QList *channels_list = qobject_to(QList, out_channels);
-            QObject *obj = migrate_str_to_channel(args->cpr_channel);
-
-            qlist_append(channels_list, obj);
-        }
+        channels = qobject_from_json(args->connect_channels, &error_abort);
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, out_channels, "{}");
+        migrate_qmp_fail(from, args->connect_uri, channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, out_channels, "{}");
-
-    if (args->start.defer_target_connect) {
-        qtest_connect(to);
-        qtest_qmp_handshake(to, NULL);
-        if (!strcmp(args->listen_uri, "defer")) {
-            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
-        }
-    }
+    migrate_qmp(from, to, args->connect_uri, channels, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
-- 
2.53.0


