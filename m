Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDAC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wj6-0000Vm-8O; Mon, 07 Sep 2026 06:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wip-0000PG-Re
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wim-00048K-Pw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788777423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkIrdElfeW1EwKlyXLCMJxCcIAp+LN1RtWIxRrsNopg=;
 b=bkRO2lALe+JsEeynyddL/80k3js4AXpL5tLtSRlf2VjeWz2oRIMJSWTWVwUqzokh6SIm3K
 v7DW/xiCMfILT5A4Iu84bHSOZpjiLrN7QoilNm0lLx3jj1uDwd58jdRwrtf/4eAVqWR4Km
 huDwy24A8miokrhaq/W88cXG0wrJMhQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-p0EESdlpNUKHuMiLJzZxVQ-1; Mon,
 07 Sep 2026 06:30:55 -0400
X-MC-Unique: p0EESdlpNUKHuMiLJzZxVQ-1
X-Mimecast-MFC-AGG-ID: p0EESdlpNUKHuMiLJzZxVQ_1788777053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DBC11955F76; Mon,  7 Sep 2026 10:30:53 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 692DF1800577; Mon,  7 Sep 2026 10:30:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:30:24 +0400
Subject: [PATCH v2 06/10] tests/qtest: add qtest_qmp_job_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-nohmp-v2-6-6d952d972c21@redhat.com>
References: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
In-Reply-To: <20260907-nohmp-v2-0-6d952d972c21@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpJCqpLMceCW6kMUUAVwmJolZ84/hbM3U/W3r
 7LuuG9km6+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6SQgAKCRDa6OEJdZac
 5S0mEACfYKvpwnUPu+oGsWjI+Wqwltf4YMokxd9iOcpiHpHwf25+nf6/rZZKE2MdTii8lFpg0Z8
 GJGiHL4QwZ1exyrNEN0JRD9m3ZF8wjri315KbX9LPbAfIFW9SSLXb5+per/jteeoqJukPGGItCx
 hXPXiFITugQX1vbzXO1b/pZkK+MC9z3yYNBCvzYPdBRWmwm37K13DQICgeirXROa+wlIPkAkavt
 0MfnehlZHwKWsbDO3EofXmNqmLSGXKW4BUX+MDAJloAbg/6FBAD5dbqGYJxe+Gij7K4/MOpWWG7
 2+P683gyrJN8qIST7qY5TBofU4hG780W4mswfre6c41qpSNsvJCeYfF9zUHFgbC8ftQJ5OlDdj+
 O+b37BsWyM1BLxujQW1wJd2BWi11sg9H0FHseozQOmd2/Ai8ti25SFC2vCYsdOwMSrYmNR1GWro
 FSYF0Vyz3X6qnjU9qJ2KZzNsrYPte6cNgOCPLWhCc7tycU7nlWBTLSBuQxncNm5p3SKi+glcz+i
 8iNH9+9/x3bHe9ilqvALFpc6/8so16EKw2L8Y0sTyZnQenGObq+TdaNtk6IElCxSElrwmAfsjNR
 dGHAmQI9m2AHXc/rBCp1wXsVNSaSBCQq/Mv5z9MJLDyOZv+pJgwdvfC/6j0SDsQFI41eb1g3GLA
 Il3B0OlMT+Dxz4A==
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


