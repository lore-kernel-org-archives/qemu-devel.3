Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3465C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapR-00048D-0C; Tue, 02 Jul 2024 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapP-00047l-DG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapN-000769-UK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XduJ0TCBnplDVugYYmZN5o8ZkVImVBc1PGz+/I5i4k=;
 b=OHejST+rcq9eniGPGiI8xKjWB6KBEHkXv4o1hivMMTQvlUAL1xwKPTEbw6DNAotYTIuzhN
 /Y6gTknRLMRk2ZobQ6NO5HEB37VdxctM5AVZlBj6/tJ3zmwRi9MdGJH5vmLQqL5891rgCY
 gJWsNTiWg/MiTZK60lHpGUr8YcC7kUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-mTWvgJHZMpuw7UtLa_Zoag-1; Tue,
 02 Jul 2024 06:33:36 -0400
X-MC-Unique: mTWvgJHZMpuw7UtLa_Zoag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D3CE1955F03; Tue,  2 Jul 2024 10:33:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3D4319560AA; Tue,  2 Jul 2024 10:33:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 06/12] tests/qtest: Free paths
Date: Tue,  2 Jul 2024 12:33:04 +0200
Message-ID: <20240702103310.347201-7-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240627-san-v2-14-750bb0946dbd@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/qos-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 5da4091ec3..114f6bef27 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -33,7 +33,6 @@
 static char *old_path;
 
 
-
 /**
  * qos_set_machines_devices_available(): sets availability of qgraph
  * machines and devices.
@@ -191,6 +190,12 @@ static void subprocess_run_one_test(const void *arg)
     g_test_trap_assert_passed();
 }
 
+static void destroy_pathv(void *arg)
+{
+    g_free(((char **)arg)[0]);
+    g_free(arg);
+}
+
 /*
  * in this function, 2 path will be built:
  * path_str, a one-string path (ex "pc/i440FX-pcihost/...")
@@ -295,10 +300,13 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     if (path->u.test.subprocess) {
         gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
                                                  qtest_get_arch(), path_str);
-        qtest_add_data_func(path_str, subprocess_path, subprocess_run_one_test);
-        g_test_add_data_func(subprocess_path, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, subprocess_path,
+                                 subprocess_run_one_test, g_free);
+        g_test_add_data_func_full(subprocess_path, path_vec,
+                                  run_one_test, destroy_pathv);
     } else {
-        qtest_add_data_func(path_str, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, path_vec,
+                                 run_one_test, destroy_pathv);
     }
 
     g_free(path_str);
-- 
2.45.2


