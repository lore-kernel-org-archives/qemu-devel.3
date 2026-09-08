Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE01C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sVA-0004D5-CA; Tue, 08 Sep 2026 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV9-0004Cn-9z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sV7-0002dl-Qb
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkIrdElfeW1EwKlyXLCMJxCcIAp+LN1RtWIxRrsNopg=;
 b=ciwkkRVX0i7Sww/k4F7lY3Af11o0nXO6pZMeHiRrfpPrqX622sgMxEQW4KbbR7F8zq5gC6
 vUfsutqnsunKq8v/q1Uq1lgizBmTi/xRpl5j/DVHJUe49IoMl3cLPiAT3Fp+z93hnWrON/
 k3+ae38QFPPxz3cR6TwRSMSisAeRjxg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-t3t0W5qLNRy_-YFgm84hKw-1; Tue,
 08 Sep 2026 05:52:21 -0400
X-MC-Unique: t3t0W5qLNRy_-YFgm84hKw-1
X-Mimecast-MFC-AGG-ID: t3t0W5qLNRy_-YFgm84hKw_1788861140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0EE61944F0D; Tue,  8 Sep 2026 09:52:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D1E430001A2; Tue,  8 Sep 2026 09:52:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:55 +0400
Subject: [GIT PULL 06/10] tests/qtest: add qtest_qmp_job_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-6-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h9iGsvL7MMHY6Qm8hZ2uOnGK9+m0yedLi5VjofxU7do=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6OcwrF4/XvbVeNEA2SzaqNKgNMdQRH1WjL
 BLLsoVXPfqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5VwED/9fkwQ6muwUuF4gP9MKYTLifo6vRDUsR/LTYDKow3dJHlhL4PYNM1iuuFukcWnSxFfaIY5
 zUQBTD8DQ3yq8nERN66gcW/g601nU4R0JbT10TE/J9Nlcbp2ybU/Bgg/4HqhGGlSDFROzII66aZ
 T/LoX0ppKNKU86X9rC9FBNRvyKfCOKvFNcXqJGSE7JKilUSWlbNVNJpAuZ+dvxCcb8+fTQct1OZ
 FNQIfvEdT4ZwHLHWjc5sP6s+5XJhDyBUVZhg+LcqhjOjthYgMXPUnyelpSUhUu04X7rzDMQ+xxO
 Fe2LzGsXFJIuAKVh+J0q9Lr5TXjZ+pg06Ut+WOGNQFhUUtwucTtNRvYPgutsN66dQRbJ6v9V3fx
 Xr1/WGjzGVcCTHgRCWt/4N/tfnnO4lQL33HKSfHvNnL4E5kZLXOtWQUSjOdbPr3iw7nt1k5G9PR
 vlWdNg+cAXv+7bEhj8pjjZxNv94Z3dwMRmG3DZqHG7hUGx2SVqekoCQ7q0Xh/6MTCc/THJH7nm+
 l6ElmlUUZ2Kh5vfpv5x5pzpCeObXr7LH2B1IKfnT6MSpEmC9zgs0GJiCcCLphLZpDEHCdsJlsKR
 MF9Cs0Z+Nh0EfqagknzKtw5sxtto/l1spCUxQ3mbYV+rog5LpNDKi5OhLwEY7cQMa6XjSUdUQpi
 iBtS1bkbR+dX0Ug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


