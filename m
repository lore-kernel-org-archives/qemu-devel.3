Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2254FC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJA-0000Uh-9S; Sun, 16 Aug 2026 15:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIy-0000BL-El
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIv-0007Tl-48
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUCHRq2Ok04LdmPe7Y32jbNNusp9xmvBIAs7AR4+PV8=;
 b=O0dZ0A1TkcP7VvuXqLIX6+NPZ5tqajNhDkKaVeoWY9J3BDU3hQ9w6Q/z0kj1/OIh+Mq5Ci
 yCUfFfJrp4CebkYzk+EZYdBQOCzPd4KWHmHSYCZklvW7pshVYvF5AhbUwjDlRAijPKCErx
 DNVuDDcDBNQRe+xbKjl59827n3AM/fc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-R0UlX5KaM1GWaUzbWm2kyw-1; Sun,
 16 Aug 2026 15:13:53 -0400
X-MC-Unique: R0UlX5KaM1GWaUzbWm2kyw-1
X-Mimecast-MFC-AGG-ID: R0UlX5KaM1GWaUzbWm2kyw_1786907632
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFEDE195608B; Sun, 16 Aug 2026 19:13:51 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE01F30001A2; Sun, 16 Aug 2026 19:13:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:42 +0400
Subject: [PATCH v3 15/49] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-15-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T/T/dWIHE7tVy83U045hqtVQSWYIwyZRSt/Bfc8zxxU=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqCC7Gja6NvFIRm6AlpWRm1UzZyf6JmPNM7+E5Hxqr2YwySM
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqgguxAAoJENro4Ql1lpzliIMP/0fd
 LgWZjQJFufEMyhfGeGkSz5CF7cXN21S5M4fkMyUEBUrhw80APTsgYkpTELItnQmCWLsA7T2fCPc
 vw6O6yWxsDYptCpN8nAC6AfV0kSxRBVY7VA1tqm4/xnlwg4GQOTil3wtCIg1MRpebjtkv62iuPT
 ROUiRp5/BwAEYX9Ftip3gGl/uD4pjX9AGDHQNze3ve3zOZPvwmdjMTLdX4nLsDClpAJkaFfvVz9
 MN9WwFF09nEgvZgiZ6lIdgBMRKAg8rV98c+60U1h9IcIqC8OXLv1PJzkdrbcI1ojIaDLqRYSzMS
 gK0BniM/XIwsNT9UiqSeo86+euSzVGKnGweI6jBU+w20iuLk8job+MkTW9jUpqff6QlB+OR/i5e
 w30JQ8GHaabceCUm67ZX0OBrTaJl3OYTDPAjbTscQ/LMP+vYntUrX/R6y26Q+3FXg09DZWFM8D2
 xfeDOSSrO5pXilTSdoLdX/P9rS8MDH3TRCQqFxe7jc9DxDw0YxGpa09vgq0dn9TJJ93nxBdP7Bz
 fgVmt7kXrNCPm2XGpI44jzns0SFFfgbgR6+dDBBNdf1cFdBLxVC7rtKzX0ye8YDCavwlW5qOjEq
 Te+XeTABfi+t9X7E97gq8LDGE1QPopaskzqH7/qED56xSSIqyT+2losSf7Zz5/9rrNGgRd39rGn
 KDzri
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

The test_cdrom_param() function uses qtest_hmp() to run "info block",
which depends on the human-monitor-command QMP endpoint. Replace it
with the QMP query-block command so the test works when HMP is
disabled (-Dhmp=disabled).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/cdrom-test.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index a65854d2bc53..bf997be6d690 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -14,6 +14,7 @@
 #include "libqtest.h"
 #include "boot-sector.h"
 #include "qobject/qdict.h"
+#include "qobject/qlist.h"
 
 static char isoimage[] = "cdrom-boot-iso-XXXXXX";
 
@@ -92,17 +93,35 @@ cleanup:
 
 /**
  * Check that at least the -cdrom parameter is basically working, i.e. we can
- * see the filename of the ISO image in the output of "info block" afterwards
+ * see the filename of the ISO image in the output of "query-block" afterwards
  */
 static void test_cdrom_param(gconstpointer data)
 {
     QTestState *qts;
-    char *resp;
+    QDict *response;
+    QList *ret;
+    QListEntry *entry;
+    bool found = false;
 
     qts = qtest_initf("-M %s -cdrom %s", (const char *)data, isoimage);
-    resp = qtest_hmp(qts, "info block");
-    g_assert(strstr(resp, isoimage) != 0);
-    g_free(resp);
+    response = qtest_qmp(qts, "{'execute': 'query-block'}");
+    g_assert(response && qdict_haskey(response, "return"));
+    ret = qdict_get_qlist(response, "return");
+
+    QLIST_FOREACH_ENTRY(ret, entry) {
+        QDict *entry_dict = qobject_to(QDict, entry->value);
+        QDict *inserted = qdict_get_qdict(entry_dict, "inserted");
+        if (inserted) {
+            const char *file = qdict_get_str(inserted, "file");
+            if (file && strstr(file, isoimage)) {
+                found = true;
+                break;
+            }
+        }
+    }
+
+    g_assert(found);
+    qobject_unref(response);
     qtest_quit(qts);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


