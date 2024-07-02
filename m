Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3886C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapL-00046p-IF; Tue, 02 Jul 2024 06:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapJ-00045T-L5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapG-000751-2m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aODMIpY0nJshcSdUoxiUED5/MnuwzU8JRKEfwRevDuw=;
 b=LhDodixTmhbY06Kji46v+1DiR2sHo4Q+fq1iN8taQmiulHGdcEiJ0sT9ucGXVfw9/EgIGY
 J+plbMOTAFwbSPi8BdWh5ae8MELKiqv0BTEbIbDer+brX6DlPC9D5FsYb4axXZB+dGLDU0
 d1pGWTafv6SSKRz+aKBxmsup4iz0Aes=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-Vr3LSq8BOl-qKrCZKNdoWg-1; Tue,
 02 Jul 2024 06:33:24 -0400
X-MC-Unique: Vr3LSq8BOl-qKrCZKNdoWg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7041E19560B2; Tue,  2 Jul 2024 10:33:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E448B19560AA; Tue,  2 Jul 2024 10:33:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 03/12] tests/qtest: Use qtest_add_data_func_full()
Date: Tue,  2 Jul 2024 12:33:01 +0200
Message-ID: <20240702103310.347201-4-thuth@redhat.com>
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

A test function may not be executed depending on the test command line
so it is wrong to free data with a test function. Use
qtest_add_data_func_full() to register a function to free data.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240627-san-v2-10-750bb0946dbd@daynix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/device-introspect-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 5b0ffe43f5..587da59623 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -266,7 +266,6 @@ static void test_device_intro_concrete(const void *args)
 
     qobject_unref(types);
     qtest_quit(qts);
-    g_free((void *)args);
 }
 
 static void test_abstract_interfaces(void)
@@ -310,12 +309,12 @@ static void add_machine_test_case(const char *mname)
 
     path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
     args = g_strdup_printf("-M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 
     path = g_strdup_printf("device/introspect/concrete/nodefaults/%s", mname);
     args = g_strdup_printf("-nodefaults -M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 }
 
@@ -330,7 +329,7 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
     if (g_test_quick()) {
         qtest_add_data_func("device/introspect/concrete/defaults/none",
-                            g_strdup(common_args), test_device_intro_concrete);
+                            common_args, test_device_intro_concrete);
     } else {
         qtest_cb_for_every_machine(add_machine_test_case, true);
     }
-- 
2.45.2


