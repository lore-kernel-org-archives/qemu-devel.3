Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33EBC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Ph-0006VF-L5; Fri, 28 Aug 2026 16:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pc-0005xa-Be
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PY-0008D8-78
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzC5K76Tb+dXHF6/UefJwgU7djajUKZNMrpyzqlVvG4=;
 b=LR1arw/W6EOLswkRYgQ+DIRo8Y3D29dTHi+se9mAX9RLf7ucKOXyumLIkJInS8mGfwdzV1
 SZuyv6B8UB84C7M2POqN2f9F2uh2YY13DSDMOrlwcJCJhUf6kuM/F3sB/cKuAsxinRAdX4
 Wg9FvpoN0Zt8+eqPWqq1zJZbyfhbEcc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-hpgfvsxmP_-XDRCBwDK4eg-1; Fri,
 28 Aug 2026 16:42:47 -0400
X-MC-Unique: hpgfvsxmP_-XDRCBwDK4eg-1
X-Mimecast-MFC-AGG-ID: hpgfvsxmP_-XDRCBwDK4eg_1787949766
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E00B19540EA; Fri, 28 Aug 2026 20:42:46 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC0E71955F0A; Fri, 28 Aug 2026 20:42:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:52 +0400
Subject: [GIT PULL 13/50] tests/qtest/qmp-test: don't depend on
 human-monitor-command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-13-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Markus Armbruster <armbru@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oMwmTRZhG9dX41Lg0h+wnNJGCaH/n5gXgI0kuR3Yxzc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUIqEl31CT3tyt0xBNy0GWHGuX7/JDwDPhl
 AOaxUTycUqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5eDnEAChQPqQs2H9cGrIgW8zBdiEHZDDXeTQtAvZhKidYbzs2xe1Q38rLmRRiM1YnLZKLur5TlQ
 Rp+GykmP41+6AUz+ovw56HpTUYWVeSKow0gEZ48LGKKBnHfCP4D8kzXOvOtRg+xSeGXaJ0Gtptn
 sO/z1Ut8IjYtPabtAtDD0VE+3Y242xt9iS/O4R5N6nRzxwCwDBksRT2eAoqLOcKV/a+E2b0upz1
 0jgzY8q8hjsXBRBeX8BqJkWH5QqIei/iJZ7VTeqDNlykMa5Fb+fjpAbMrjKyEqUJNpJP2/tm2kn
 Os/IYnbbQfb2RX7Xyy6HY57d/y++mXIi4wYkzZXcuO/Q4JCggoL4/avunz6KaXvZNbe++NbM7/N
 c7QU+ViXy0alvDvpS2lB/ijC94QOn2ckBqL16wNI9Is6ZjN22nDcuoJSgVej9Y2ctPdM3yFonwS
 onCdjVs49AJO9Z49FETutSOiSoGgJS5ogh4nkf9Fsp44X3XnpQOpP0+stiUhzbcGa6gRmf4VEfO
 rAX36IKn7MUkJjaMdLGWgMAS5GlM1Ji/Q2KfSeza1iv1Lx9MKvVUtqrGox1p0H3wixqp3N9DkSX
 zaE+MrqrIUXqiKgnto688f0QW2erEzose3qEIerp5NMi4fXB6CrDwRFawb+OKGuNHFCnMw6g5ne
 /czlZkFNZSEjWMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The test was using 'human-monitor-command' (which requires HMP) to
verify that an integer 'id' is echoed back on failure. Replace with
'query-name' for the success case and 'block_resize' (missing
required args) for the failure case, so the test works regardless of
HMP availability.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-13-9227de146347@redhat.com>
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


