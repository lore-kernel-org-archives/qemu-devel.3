Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530EC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLB-0007UR-Hg; Fri, 28 Aug 2026 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvL9-0007Gz-4n
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvL7-0002l7-6g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfMcQcx6b8V1GGc85U1OGllXkTDW5Em7kmZJjqakvXg=;
 b=bYhfrFcdCc+BEk+XnvY//UFLAHScR2+yPeqoRviJAuVUrzVi3Df6OY8YkjGV6d/hG4ewAS
 DfJF0KIDKZpfQ87RmpQdmk1WuRggo0iNuhDbq1fq+QaNEXljp6SCz4C7FTYwaozEglxr22
 syWo9FFnPirRjYx4yFSHAz7YLS8TQFM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-6F12snoTObqbzJV0BUkraA-1; Fri,
 28 Aug 2026 08:05:40 -0400
X-MC-Unique: 6F12snoTObqbzJV0BUkraA-1
X-Mimecast-MFC-AGG-ID: 6F12snoTObqbzJV0BUkraA_1787918739
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8655195E908; Fri, 28 Aug 2026 12:05:38 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F0BD1955F05; Fri, 28 Aug 2026 12:05:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:12 +0400
Subject: [PATCH v5 15/50] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-15-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5wY91W0L9laNoGmdtIKhtW9LqkeXAMcQEZWY3DWeEYU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4xkMBI3Gl1Wf1Btbk0cqkzjGduqUEtzct2
 OuJtAaBB8yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5eGQEACu6xedg64arOYOHe3ZHbnNx5Gor5QqDuHu4qbQPbTH8Z4A9HQ10d6uVhOi6H21CwM/vsY
 zX0LpOswhlFJ0gbfh2B2OliYBsx0+GVHO/N27uCxLkgtS+imiga05ZukyeYdWfNsjpexeWQ0+L5
 nmSUzLu5i5QMkEs8aJRZijV7u8jn7+QEKd2EEAcIeUxeChQUoDhQj/I/Irh2py/Lq8QnYPKmK28
 ejA3vuwJ8ym+p684mmRxM9yQQpLEVXvpQMao7QtwH/nD+0+loK7Io2z4kga3aMQZJrzk6Uu9ohP
 eklEtC+/pUS0N0tgjHSTsK/vUflY0GJ0YiBGMFNEWrD+AAIwE9wxJ5my+9Dlhb2ecdtFBk8mLd6
 LfWC5jbB3N9gR86aXZcp2dVklxhkpAUce6r4dMgwVgGUyXKAFF2CSUc/vxIh3GSvKTCnb8bmTvl
 GH/4MnE2IFRjZEVirxSFWeUfIrTUO2s53DR5Hr9f2d7LRAqnGWOGQk46+wwvo3tV0+ITHJrg5xy
 6TPQwIgJQyzgHyck1m0krDrXh9zw0qDWaLNwigcq4prEKEXeVxHP941SLxIqqAfrOwQlC2M8okn
 Xbun2KBOmjThWEPE2X+ZbmgEsACTmk4pmZ4j5XrnKY6/RoACeGMkkRLVspTbR3+A2T7VT0YCNzi
 dkXIs3IWLjzig3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Reviewed-by: Denis V. Lunev <den@openvz.org>
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


