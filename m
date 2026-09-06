Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A73C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38Sx-00049o-7i; Sun, 06 Sep 2026 04:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Sv-00048q-PO
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38Ss-00085h-Or
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M14ZvGPaLzlE8Fg8EGzxYLG+xEb3zc779TfIX9KCdno=;
 b=YN8SxrD0kHkXjzvVy1Q/emCGcKhYdQyy0bkCJ6xzUGPz2ay+bWXZSYz3OIbat8EujEZzCt
 XXKIcEHACyVW37FLzbQmI0NpJNRjZgDLFGpqPm/x0cd1Fy1E6oEpHZnbZWfEU9v1VvO+Ig
 ZCgPHDXDz69BVKFXWLA5XGDGX5dXdss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-TNZTv6_rMW2-m1kbwlsXCA-1; Sun,
 06 Sep 2026 04:42:58 -0400
X-MC-Unique: TNZTv6_rMW2-m1kbwlsXCA-1
X-Mimecast-MFC-AGG-ID: TNZTv6_rMW2-m1kbwlsXCA_1788684176
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1C491954234; Sun,  6 Sep 2026 08:42:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7AF41956042; Sun,  6 Sep 2026 08:42:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:35 +0400
Subject: [PATCH 4/9] tests/qtest: add qtest_qmp_job_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-4-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vMUZqjDWeGCv7rylFTtKHn8cBAXxiSSUDpyTUJ14zWE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5Cdw7aCylKX3h92bvG3av3WbIbDk+NPC57
 9T8CB99l/aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5ee/D/4h+damfCDzjmprRq5c2aBGd0bWDcHq7iRN3/A30bqYvmftWC0ssn04dB5WYae1cftV6al
 MXnX17z4iXI9u9pQ/cU/cJNqqYNeM1Z2JmugyMZmtN8W1Z/R+FXhHjLgU9ycqIVPBM3+whFkNU8
 aazfN2aPM0RfADqj7XGHw9gVSV3EgaEtI5achGR5rDwM4fU3uMlvKLfL5nwjWEffnMxyb8GRVs8
 8UY2QyXkpdCLL5how/ojegN/7rpfAVC0fjNuyJF4W59jQWVVf7Yd3oFxFhJ4Zu0J3GMuMlr62eF
 jeHcu8d+3CGHcTLMH4KUUaV1Mgn1sd0xHxMcnzP02oOGg/+E3SRLEjp9F5OqR2Nm83WDIChPDY2
 e4SoFp4wnymu2RuL9JzWB9M+r4LwoDwqtGqTSliJfGu+9uOusLTeaWkqu6bnm8NFWgPJdeAMzbP
 qyLlrdgwe6lyrZfO3v2+sqnW++Or24KrH6IqgxbF2dsY1gjizq4OirJKVOuY/Sv5lfvYA2opf0o
 vMa0Qajq8sAbfskzqYzekPhAOz/NrpXEcJMyHWIVFYhN1SVdOcvCOpUXl6Wa+lHjMWqhhWyCt0n
 B6lU1m7UHX2RwfvbHYvHcrgK4E8PWjk2rP/wOzS5dT7xw/WXcPVon0cDnm91g8ngQ6RLB6yZx9f
 6aP2q6Sr+n7wtyg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Add a helper to wait for job conclusion, used in next changes.

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


