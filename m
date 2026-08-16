Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE69C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJB-0000Zt-O4; Sun, 16 Aug 2026 15:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIu-00005D-TS
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIs-0007T6-TP
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awsGiKws/Oc72EBonW3yVf4RQnkpQdBbgtMuliluxhg=;
 b=DigsCAfnrklGv+BJe6bL+NYThPS5qDUle2LpDZVyWamgnpnijKYP7uv5Mu+f2/E+hFevdX
 MV2k+DgXegnjaWAF3218JzFbHH8vdTZng/9vChvgZ0jqr9SyidP6MqDzNlPUH+Oe0GLzl+
 zreYR8FqJ75kkQHKwP9K0CFBiTemLw8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-fBI3YJIQMCikYKiTCp-u6g-1; Sun,
 16 Aug 2026 15:13:45 -0400
X-MC-Unique: fBI3YJIQMCikYKiTCp-u6g-1
X-Mimecast-MFC-AGG-ID: fBI3YJIQMCikYKiTCp-u6g_1786907625
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA6A0195608A; Sun, 16 Aug 2026 19:13:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D670C30001A2; Sun, 16 Aug 2026 19:13:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:40 +0400
Subject: [PATCH v3 13/49] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-13-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LYlALLNnLGBmvLJkUw/CVWFy33xbwEoBffB+2rz9Cl0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguxzrD1VnZ1vVvL58TJDHlr2PKWNh21Duq6z
 UV1MEbW4j+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsQAKCRDa6OEJdZac
 5aC4EACG9+uvegKK7V50rrQVzW9Z2Hhb37zDkJTau6nN8Woygh69frO+Zre6funuGUyCm/an0WL
 ur2+Ej3QdpimwjVbqrEhc0B55og5JOaVDiikcT/OFWK4hMCQ9PlK3xjpUdGyhbRwlUXDSx689so
 G7PpZppjz9E1byK/ehiGv0ODb2OTz0ALE9+cHySffwO2itJNPlObfmRm0+iMNAjqIN7z8nwRWbS
 zZYseI2gQGTfESL43I/G9udT6V9eCStEcJLBxq/VhwOSyHdXmtyNYWaOxi2yG3yiWgDaPz9/drC
 ObOrWCUmv3ECezdU8skxbc3VyEB26/ZmFeBJIUZ8x/W6WM1LEp7uG0gQwMsFsrfpJNHTNC1rij9
 cpvGHCFn4EYdItYr+MFmMJE0jOka3hyRQco930/0lcsCAvXGoM7oe3xU7SCXw62e21I/k7kTMG1
 ZJZfALszcOvabnyL/xSDH+QA4GrUCIszo1FofLJW8hXu5aj72ZCxOXFuue9PBNvTFNv72x8uReJ
 hyNYjvUdc8BIt6erP65ZuRlm8PTJ7g76FUygkKMEjP6kMpodMq7TGpOQCwhRyDsl/Rdfbvi0ePI
 PjPza5EZJKJ59YBAa1zHID5ksRRhAYoDy35ZaNbuvA1BQF56mLnuHy2uk2uIv+at5SIfUxZu2gh
 oU1SbHSoNVt917Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The test was using 'human-monitor-command' (which requires HMP) to
verify that an integer 'id' is echoed back on failure. Replace with
'query-name' for the success case and 'block_resize' (missing
required args) for the failure case, so the test works regardless of
HMP availability.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 3a325a04e07b..927ab053f8ab 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
     g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
     qobject_unref(resp);
 
-    /* Test command failure with 'id' */
-    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
+    /* Test integer 'id' is echoed back on success */
+    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
+    qobject_unref(resp);
+
+    /* Test integer 'id' is echoed back on failure */
+    resp = qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
+    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 3);
     qmp_expect_error_and_unref(resp, "GenericError");
 
     qtest_quit(qts);
@@ -487,6 +492,7 @@ static void test_qmp_monitor_remove_cli(void)
     qtest_quit(qts);
 }
 
+#ifdef CONFIG_HMP
 static void test_qmp_monitor_remove_hmp(void)
 {
     QTestState *qts;
@@ -504,6 +510,7 @@ static void test_qmp_monitor_remove_hmp(void)
 
     qtest_quit(qts);
 }
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -521,7 +528,9 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/monitor-chardev-in-use",
                     test_qmp_monitor_chardev_in_use);
     qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
+#ifdef CONFIG_HMP
     qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
+#endif
 
     return g_test_run();
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


