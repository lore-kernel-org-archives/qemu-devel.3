Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF30C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJH-0007Hb-4H; Tue, 08 Sep 2026 04:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJG-0007HI-Cj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJF-0007H2-09
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkIrdElfeW1EwKlyXLCMJxCcIAp+LN1RtWIxRrsNopg=;
 b=Fjl00qYgNe6p4BXJxFlNCErGF49QXL5ITyN9mIxr+7oREAuf7f2zO63lH3dOPrISJhlc0Y
 F2QqXFl9uRWc1YFCyLXkeLMo7+S44u3v1GA1Gr/E6XI83ialCv9HWY0eAbnfIwp/jrutIl
 W0Rc75bgeA5J7XFcZTGaN/SJ1OR0yPU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-WU2DviBTOoWYgeZVb74ujw-1; Tue,
 08 Sep 2026 04:36:02 -0400
X-MC-Unique: WU2DviBTOoWYgeZVb74ujw-1
X-Mimecast-MFC-AGG-ID: WU2DviBTOoWYgeZVb74ujw_1788856561
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39BF1800742; Tue,  8 Sep 2026 08:36:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCE7C180034F; Tue,  8 Sep 2026 08:36:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:38 +0400
Subject: [GIT PULL 06/10] tests/qtest: add qtest_qmp_job_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-6-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h9iGsvL7MMHY6Qm8hZ2uOnGK9+m0yedLi5VjofxU7do=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jYRWdX/cMNvOe3T8Mtwm+sfJ5VUyHG6xCJM
 3L7XyHEHwSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5dZ6D/0Xo7rUXKu1T2y6PFklzvFaAXTmZVI3jof/mIrFWATsklQ0MGkpEJ+F/8B1/AIlkQLezGo
 DiIGPx2uDRwTWdrsNFTNmiB7hRGrBoG/RL0eNNEbWXR9XohZUN7pSPcWMIv1zhltnctINLJgsb/
 7mh9alfkeD0IqMeV+CYWM/Vy3Qe89Fd70zmN0Mcj45//n85hpyzvOcophg5E0g28CpD6IxO23CE
 t9Y4ekZBCnBcsGXlqIY3OfBDsqH01RVSqhexNmf2nAjl0TKgxEPeQDIaV3HJTydjxNOETT4RZUE
 OQmdEeZy5NW81N2qs5NJJkMBD/XpGfsVPUgW8kQe66HMNhTC3t1H1lfT3jpLVyt+Pcbkui/Jqq+
 vBBdzMo/lwR8tU97TgEaQqRxt3CisrIZrLpjFH9YFnnTA7MhE9LLPwWsccwWcbtDUBkZyvsRl4J
 E2adqQXcHta1g0Y46c36kfh8c5MA+wZt9PzgI2mpg3qzxc97oI4JK6PH/wMV+v3axIKRUJjq7TI
 vDm605TPliCGnhe8XGHc2nIvQ8MaRgYQcvZk07eMaLeNFd/uT1YSsReRygCZte9VXuf2IuOR/4Q
 +yAvsFtEySNlhnM8cFZNtwlKqvmD67GynvNqBl9HqS5r7kDX7j0VBbU6ITEWREYgctSBkN1zGMV
 FyBx0kVqdLAErYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


