Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A86CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoqk-0007SL-VM; Wed, 20 May 2026 17:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqR-0006xC-Rl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqQ-0004ua-2P
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXCdTl3XnS/yX4EcgpbdGYdHJ0t5E9Vy5BN4DTXZ7Pk=;
 b=dEH3rdYKj9Ycwrt+0XnWQKkauBL6IhqWmfrVAPXZ6SgLWHuxThdiRT+oZ7YUDlLSUCDvkm
 FbY2FSI0N/tRK7RkO9I8x51km1g6MKFgm3qHfxrMwhcoLKPbXKMr7JW/hzM/Yp9VGsc+Hc
 eIlWK4utKqMqNM2dH0gnWPGdmASBiGw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-CNevShqjPt-N63Pe09jgFg-1; Wed,
 20 May 2026 17:52:47 -0400
X-MC-Unique: CNevShqjPt-N63Pe09jgFg-1
X-Mimecast-MFC-AGG-ID: CNevShqjPt-N63Pe09jgFg_1779313967
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30BBE195609D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EB881800465; Wed, 20 May 2026 21:52:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:28 +0400
Subject: [PATCH 27/40] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-27-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=28lV59NbZNzsPX8tOyozxy6UDf8rQI/n99c7klYsbi4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDr8d7rBXS1WQWqBdrf08GX94PSCjYTDTAL
 wzQe92E3y2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5R61D/9fnlBbTgZeetXskKohEb1hXKQ7uQvbqq5tgj5CCnX48VdwYy7C5ot+P7Z/iO0yLFGt2rM
 c3Ug+ql8w9CK3dgx7mN/dOuUHMIfoE9nww6d7uSdEGTwb5oM9FET9t7KrZXtTG2/wzabmKZ5p//
 kBaQ+K5+TIxY1QQnC5MoFivPuv8yjFP/MXFrKH9FwyNTs+M5ElhI4p0yjRijL1GcHGEKORiajS4
 aKPB+zQ4w2ztleWAd/vEjkeEwONM0SwpE8lXMgFFP8idXlEFql+nQVbcKjrEO7xmmb0SDaJNYTw
 iOHs5tJ4oEFv4nuCvz/qSfo5fyPgcrUOnDm3lHKeEn4L602Eu7vcotI/izErEA5T5UNeB5oFQZa
 zOKaw83FEiDI7JpXrrwV0AaR/k+EKNVdhHFIn/apcCYgQF7ZqGhY1otWBXSXR66uFqDoM0lb2Aa
 cAiWpWrNjZT1aEdIuLc7WD4m4B0HrjRfsFRwDj7ozRLkw27+MTqdWmekYhB5DnQYDne/plueXt4
 j3N5W+crrkdej7htH4XRLNY9FZPXWVxC7uLViDwd3yGOWEj99Oi262Y0sxCLqOvUKau7iD06oP9
 3A4qPfIOmJKgctbSgS6VR6fjkgbpbU6Imk3nyAzxlCJrzwGC/ZUr3ljpEhDudgaVXvGOXLLVz7q
 FcApppfKaO/FnZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The test_cdrom_param() function uses qtest_hmp() to run "info block",
which depends on the human-monitor-command QMP endpoint. Replace it
with the QMP query-block command so the test works when HMP is
disabled (-Dhmp=disabled).

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


