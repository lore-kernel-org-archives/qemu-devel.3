Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7252CCD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlG1-0002Zu-Jm; Sat, 09 May 2026 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlG0-0002Zd-GV
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlFz-0004ed-08
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft7O6WQ69pApNehW/oK2r/bRdEodC47wXhhbmZXZ944=;
 b=CrWVHTSBNDpYvLJjYQQ41tzbhWLD+SA6PleaAq6tyo0+Kc9KfGYf649LWISoGyKiAY+uc/
 feU/p8CG8a37c/j5644q3glySqpsejVQH/c1aDdLutrdGvuh7v+D9cu0sjsMM3KCuLcrEN
 AukQA4RxZ9bpien8RAiYhhKw3jKY+2E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-Mdetfjc6MYWBn1iyLuDfRA-1; Sat,
 09 May 2026 13:14:22 -0400
X-MC-Unique: Mdetfjc6MYWBn1iyLuDfRA-1
X-Mimecast-MFC-AGG-ID: Mdetfjc6MYWBn1iyLuDfRA_1778346861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F3C19560B5; Sat,  9 May 2026 17:14:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A6CA1800240; Sat,  9 May 2026 17:14:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 03/33] tests/qtest/dbus-vmstate: Honor QTEST_LOG env variable
Date: Sat,  9 May 2026 21:13:24 +0400
Message-ID: <20260509171356.1157879-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Don't hide QEMU error messages unconditionally, make the tests that
expect to fail honor QTEST_LOG and show every output if the variable
is set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260429190550.20122-4-farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 51c5fdb995a..05e598a3e3c 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -324,17 +324,18 @@ test_dbus_vmstate_missing_src(char *name, MigrateCommon *args)
 {
     Test test = { .id_list = "idA,idC",
         .result = MIG_TEST_FAIL };
+    bool silent = !getenv("QTEST_LOG");
 
     /* run in subprocess to silence QEMU error reporting */
-    if (g_test_subprocess()) {
-        test_dbus_vmstate(&test);
-        check_not_migrated(&test.srcA, &test.dstA);
-        check_not_migrated(&test.srcB, &test.dstB);
+    if (silent && !g_test_subprocess()) {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_passed();
         return;
     }
 
-    g_test_trap_subprocess(NULL, 0, 0);
-    g_test_trap_assert_passed();
+    test_dbus_vmstate(&test);
+    check_not_migrated(&test.srcA, &test.dstA);
+    check_not_migrated(&test.srcB, &test.dstB);
 }
 
 static void
@@ -343,18 +344,19 @@ test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
     Test test = { .id_list = "idA,idB",
                   .without_dst_b = true,
                   .result = MIG_TEST_FAIL };
+    bool silent = !getenv("QTEST_LOG");
 
     /* run in subprocess to silence QEMU error reporting */
-    if (g_test_subprocess()) {
-        test_dbus_vmstate(&test);
-        assert(test.srcA.save_called);
-        assert(test.srcB.save_called);
-        assert(!test.dstB.save_called);
+    if (silent && !g_test_subprocess()) {
+        g_test_trap_subprocess(NULL, 0, 0);
+        g_test_trap_assert_passed();
         return;
     }
 
-    g_test_trap_subprocess(NULL, 0, 0);
-    g_test_trap_assert_passed();
+    test_dbus_vmstate(&test);
+    assert(test.srcA.save_called);
+    assert(test.srcB.save_called);
+    assert(!test.dstB.save_called);
 }
 
 static void log_func(const gchar *log_domain, GLogLevelFlags log_level,
-- 
2.54.0


