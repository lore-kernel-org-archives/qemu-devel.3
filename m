Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41E7CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVe-0001WD-8z; Thu, 25 Jun 2026 17:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVZ-0001Hu-Kc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVV-0003kK-H6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09tB3jSORQpBG3yYGaO0m63lpZkUd3XoKXR5lh13pEA=;
 b=hM8GCoFr/SWC3XmHz1sSZz5Jy0EHyfAWy+4AI2hl+JGxm+nVWXFGlTn/BJnPysrWCmt09f
 EzG/WtWGlwuehtN8djzGLH2XS8w+1aav+EqdQYIsQ4bhwN2SvJZAh7rsTpJ1huKPxciPwB
 d2Me69Sp9/jJpEgS7LVnjp5hh0oCveQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-aSPdG3ODPyqo_9F87iuSLw-1; Thu,
 25 Jun 2026 17:21:05 -0400
X-MC-Unique: aSPdG3ODPyqo_9F87iuSLw-1
X-Mimecast-MFC-AGG-ID: aSPdG3ODPyqo_9F87iuSLw_1782422464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6117B180AD4B; Thu, 25 Jun 2026 21:21:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18C7C18001D2; Thu, 25 Jun 2026 21:21:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:18 +0400
Subject: [PATCH v2 17/39] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-17-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=advw8TM6wPK904i74p/bG/x1uSjxzUPiXdbN5Flf4Sg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdICf8rmYUoHyN7iQjShs66Wf+sFR9iQNuj
 OAaVFS8RtSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5dwqD/426By7UGlZODpUZg/NMy9yTMoLm5x0NGzeWzgqAJ7ZcZCmBIvOo6WKFHgvjqN2+tUUsYE
 PKpaTMdNRlyvqfOwmdmUGPSYr5pDgG6UQVTHLNfny6H9W8HH7i3+SKY9fxKpNWBZC22543Hl4Td
 wBySBM1P6DavJDWO01CY05WnLDFo/YKQwglS8uPhgo4eUzF+RaKYum6LsNdEdxLDqRLS93fFvdH
 LQ6ONzLDNiPDjooFFxySte9nSjxmG0ClTVR13rEnj00B8R1WC/+vKXjnWEOAFAkfiWRMdjy9vUu
 TjQAp47mxoWdMidwe3q0K3gVtR+NuCzBMbZUBaSSsrth+5LUp/PKZFoRnRxMcizAw5+CYQq+dBY
 szbE3nv+OYOhIHQ+hwQgKcDAjQWuIoowW3kR6+BtOJ1QhYvZ23aubdZ6PoVKwBsfO8hCi6oFiwh
 UfJolhmZB12xPOgS0Hf9OXkMVi6ZKUYx1mY1tY0rbU7r5eoqHGkFt/VVoujtVzGFlds3xVTqFoE
 W0KeABweJjiM/nsugC5rN4ARlSst9ZPVL8fOmLyl9dvkMsOG4Ru2pUiPK5wTHoRyJXxKqEaV41e
 X1V2cCQfbCT7rwWBXIZCQbpknG/iuhdenRuHO/Bc/E6ogfKoPz8b2InBmYH8Um9JZjgiFszMXeE
 txtvTbUN2DRECyA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The test_cdrom_param() function uses qtest_hmp() to run "info block",
which depends on the human-monitor-command QMP endpoint. Replace it
with the QMP query-block command so the test works when HMP is
disabled (-Dhmp=disabled).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/cdrom-test.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index a65854d2bc5..bf997be6d69 100644
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
2.54.0


