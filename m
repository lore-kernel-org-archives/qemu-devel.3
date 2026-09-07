Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D0AC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ZBH-0004e7-W5; Mon, 07 Sep 2026 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBD-0004Rp-Ct
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3ZBB-0006WZ-07
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788786872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkIrdElfeW1EwKlyXLCMJxCcIAp+LN1RtWIxRrsNopg=;
 b=C192MzzdEh3Z2vv8mXvVzhkQBxFQUtwCdDa8qvFlLTABgWM+EVuE1TqgDSTf25a9XTMUFO
 uvTOo1R34pu7QUBuZDI3WAKsi8IisyG2MEAb+e+U2Qz7kVcgWxoM8xphtVAJSEnrPqhiv8
 zrSBWX5eEVaZx+IzffiibasNZBQYo4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-OX5vrTA3MDeeJ3BHAWp2_g-1; Mon,
 07 Sep 2026 09:14:29 -0400
X-MC-Unique: OX5vrTA3MDeeJ3BHAWp2_g-1
X-Mimecast-MFC-AGG-ID: OX5vrTA3MDeeJ3BHAWp2_g_1788786867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FA171800EC7; Mon,  7 Sep 2026 13:14:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A17AC30001A2; Mon,  7 Sep 2026 13:14:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 17:14:00 +0400
Subject: [PATCH v3 6/9] tests/qtest: add qtest_qmp_job_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v3-6-c11e7d0d3d7d@redhat.com>
References: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
In-Reply-To: <20260907-nohmp-v3-0-c11e7d0d3d7d@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h9iGsvL7MMHY6Qm8hZ2uOnGK9+m0yedLi5VjofxU7do=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnriXLGSEC4p0WfK+IOfmjT8Molq4mpgNKgKfg
 +IgbFzUOoqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap64lwAKCRDa6OEJdZac
 5XPAEACiQRJAO1OYVGPHTORO4Q8uzkQnuEeF0R9K7F9p3ojIwhIgcbb03POsUeEp/OQ9eNewJu5
 9Xs8N/JHb7IkdIMvvpJHNqkFT7OdGPSQ3Z2QxwpvnIpBmfRr2Ion4KQnMzOOdJQBsBtt3yjvrSd
 OzPuY+DHgK4sNEVlAyZyNv2wD5AjUZducj2E0FAVXNg+wlw502c1wOON3tuapWIOsB02N57o/3N
 yqJB6T9XASIzKXdYUMEp3albXjBNswyTCKj62KPVkInYFJfqi0qQb+vlNToUiooNmdW46ipOcDm
 DqAw9lCxaO5P9GJkw3b55823E7viXNnFGDWbI+aLEPK1HFQ+9FMZrgOXAZfz+1jhQGYADgpjL9K
 Rv39NlqIUoap7NrkYBKIygkMoiauwJx3kEA23Mpz3H1GHCrsZYWbUwX1NR/vCjSWEkK4xrz7Vps
 fIlcGYJypkM7TbL7lnPDGRzWX44baKUai8Dy9WJdl2PqtK2ZOHq8IQq9HK/kNuoRwo2WFQpmVDw
 fTx96qHraZNggrP7sfDZXg2icQbjnkI1yqVHgU6U2GTmfrCZWQG4EDPSDNvMl7nXFczCxNH2K2w
 O/CCraN7FXXgJ60DgyI3bmTVyrgEQfwjN0wqjlsFfS8wMCyh7GBpfZgNyxgr+WFLjFUl64+Wppj
 mUw2RXlPWCSSChw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a helper to wait for job conclusion, used in next changes.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.c | 37 +++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 28bb72bfaecf..370f79a3b6fb 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -984,6 +984,43 @@ void qtest_qmp_eventwait(QTestState *s, const char *event)
     qobject_unref(response);
 }
 
+void qtest_qmp_job_wait(QTestState *s, const char *job_id)
+{
+    QDict *response, *data, *error;
+    QList *jobs;
+    const QListEntry *entry;
+
+    for (;;) {
+        response = qtest_qmp_eventwait_ref(s, "JOB_STATUS_CHANGE");
+        data = qdict_get_qdict(response, "data");
+        if (!strcmp(qdict_get_str(data, "id"), job_id) &&
+            !strcmp(qdict_get_str(data, "status"), "concluded")) {
+            qobject_unref(response);
+            break;
+        }
+        qobject_unref(response);
+    }
+
+    response = qtest_qmp(s, "{ 'execute': 'query-jobs' }");
+    g_assert(qdict_haskey(response, "return"));
+    jobs = qobject_to(QList, qdict_get(response, "return"));
+    g_assert(jobs);
+    QLIST_FOREACH_ENTRY(jobs, entry) {
+        QDict *job = qobject_to(QDict, qlist_entry_obj(entry));
+        if (!strcmp(qdict_get_str(job, "id"), job_id)) {
+            g_assert_null(qdict_get_try_str(job, "error"));
+            break;
+        }
+    }
+    qobject_unref(response);
+
+    response = qtest_qmp(s,
+        "{ 'execute': 'job-dismiss', 'arguments': { 'id': %s } }", job_id);
+    error = qdict_get_qdict(response, "error");
+    g_assert_null(error);
+    qobject_unref(response);
+}
+
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
 {
     char *cmd;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 58491ca53ab7..f06e061d214b 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -398,6 +398,17 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
  */
 QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
 
+/**
+ * qtest_qmp_job_wait:
+ * @s: #QTestState instance to operate on.
+ * @job_id: job identifier to wait for.
+ *
+ * Wait for a QMP job to reach "concluded" status by consuming
+ * JOB_STATUS_CHANGE events, then dismiss the job.
+ * Asserts that the job completed without error.
+ */
+void qtest_qmp_job_wait(QTestState *s, const char *job_id);
+
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.

-- 
2.55.0.543.g5ebe2ebe4ea8


