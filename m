Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E04C61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYE-0005AO-75; Tue, 25 Aug 2026 15:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYB-0004zL-VK
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywY7-00042U-Ti
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfMcQcx6b8V1GGc85U1OGllXkTDW5Em7kmZJjqakvXg=;
 b=gi2ccwhlDc7QUaLTX0bmISuSDp4Zrf5fWSzEOylnk1DldcM1bVPJG84CLV/TF054hrUFkD
 mjxvefaz4G/YlwE4Y2BKm9Y67prs5toZtrdu4p+gwgcUcSWrJ7vSosBPa9xGS50aqQYdLX
 uE8Q6zjyviMigMkSZSS7+Ho78aa84UM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-IqzHG08mOISL4VdtFNSW7g-1; Tue,
 25 Aug 2026 15:11:04 -0400
X-MC-Unique: IqzHG08mOISL4VdtFNSW7g-1
X-Mimecast-MFC-AGG-ID: IqzHG08mOISL4VdtFNSW7g_1787685063
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA78A1955F1F; Tue, 25 Aug 2026 19:10:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 124CF18005B4; Tue, 25 Aug 2026 19:10:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:22 +0400
Subject: [PATCH v4 15/49] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-15-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHpFLCpWxiyhDCzSYNJKbPhoM5EhWYc8mLt
 9bhHEipto2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5chCD/9JEG9mBQ46LLQikbV2yDnb9B65mVDcd9Vz0bjFp0hFFeoQnPv56F4w0GdDLfJbtI9VP5O
 DN6UiWV55DJkgjTyPtjlm3a4xDHjKDk2VG/rN6IqNKaWW0HofzcOpuHR0KWUMeMWxV2rc0CaJNF
 xX+PbUs+o3YQ+z/7q9FduosLlf8FYT7uPb36XNLvgFS7fMlx3OMLV/79KSccI7BpY2F91IAqGJf
 BprWXoC2L1WerdX4f2fgFSWw90T4gdX6FBGpJH6ZPOZNlWrsp12paNySfCfpLemikbFAyA4ExAj
 2904nbEXvdTvYEMZJjJAuIC5kttT0bt0IEf2larue8N1svAHo2YfryB6M03vdXnMe7dwQM2MDmd
 RtegoqPwL3YNgpMBWYdGXHRrYioyZyozE/BymyTg1e+ciAUpELa3yfSpdYfIIvLnTiwo1gikHpj
 VprTONqxzGJVNfWXPrylkwalNtM/LbOyL0YYQyBjGrNpKnRVSzS+bG+Gox9cJB7HO0PasD8X8Rg
 y3FQFdujQFbaLF6gqpgt+TE1pfwHoUCPWIfZOXtN6DVnSlh5Fuz0YksBGEos5hDLf0BYrIzZdiR
 05X2LX3OTzrg22TL4+T8A9XfAPLDb110wyXH2cIIPQ9MOqQ7Alv2lRtrNIfYQ5el/DypshTTAv/
 pd6imMODKO17U1w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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


