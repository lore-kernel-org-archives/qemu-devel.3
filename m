Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAA7E6F096
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Pt-0001vg-Uz; Tue, 23 Dec 2025 09:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PE-00018y-KM
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PB-0003mZ-Bu
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jPQ5dffedF6AMX+DvLvM5fScMcZBixifZ8t89hQKCU=;
 b=MWZSMwb6onR2wMC/XJqnbUX2OLsjPJneUcE5aXxYRFuT43ypLbdiwLVF6V43reBDme0G9R
 cEcl9bOLi9xT3tK8X+UkFfmd7vcBhrGWIvNCk/VOxjx3zQJt5KIlBuWFuGIMGJxWjLVM7F
 /6/vybu+e5eVzGG2NFJ0INdwD9FbqJE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-s-EAT9goOASOgpVOzXXa9w-1; Tue, 23 Dec 2025 09:30:26 -0500
X-MC-Unique: s-EAT9goOASOgpVOzXXa9w-1
X-Mimecast-MFC-AGG-ID: s-EAT9goOASOgpVOzXXa9w_1766500226
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b17194d321so640922585a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500225; x=1767105025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jPQ5dffedF6AMX+DvLvM5fScMcZBixifZ8t89hQKCU=;
 b=kJIWeVdVNY5wEmp27wCMzPypWlFo5DzwhveFdHdR2M4egtvWVTlQcbDgiWU3TF0QcU
 leFlB9dC/2r5s9TVEZijrENo+a6WyjFkyZ5BnOiJlA+IUQ8GA8FmB7OYUZ0Qa64X3rZ0
 HY2XvOiFtJUCHArdqQZ0Ich8xv8r9FKyutJPk7J3v9fb7fwYM3Pva5CYalTmk/jn823e
 Ek2vVyXVqE2zJL0HTt7r+xjb39vRpo6GHXbXfRoJciPsrc7FhallXQPnAJMKaUXPDEf8
 QLhHkvjSg+rMXlMZ0AZnEIi7Dr1GEGqAlZb4E+rsgdl5U+FLJBJuGONdYEJ8KrHIQcSL
 mIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500225; x=1767105025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1jPQ5dffedF6AMX+DvLvM5fScMcZBixifZ8t89hQKCU=;
 b=m7uQXjRf0K7CzeuNjTrWFHXu61yZh0H19GLmxcE8Ms/54AHUtA4FLxSHGHvKA1hr/B
 m5Y9vFFt/eRTt2PA06Ykfi9oLtap9j9+5TL9m7gqULjOxM79Sbpwjj2H9ITrV7ZGW2uB
 D6iH0CevObj6Kpjjp1+xX04Sib4pBZP8F0Lk4CMVG2XGpwluzBhJPeNwgsGP+9k9LIAC
 gCUZj0kBjoHRqxut4tC7Oj6WZ1NuwcffHVa0lhmAuTBFoTagumiJwzH4VuB1DZKUYrv1
 H+t8vtYXBwcMbe0X9lta0dTQQeP+ZIQnwIqvdofa+AZIx4awLDrn7L7ycrjFNSnkfkNJ
 G5rw==
X-Gm-Message-State: AOJu0YwKKPurOVuZ+ltMmU9Ie8hvc8vISzn0xkExQs9Tj0gJflYRJbas
 zRkFlFPf4A9fkIuP6U+XQ4DlZEBaPYuw7lNltlgrsepFk5gxgl56iiLXSddGaPDeJcOv55F6DCI
 LO5pP/2y7mMNt6XyUKg18ZtXln9/bGmaMy2q7hveZaYl80TE5+s6jia15A1qCsV1d48uOppXErg
 daXFawSwsK6mz4w9SW7/Tx7mbRd+ivtrVEyltLWg==
X-Gm-Gg: AY/fxX52nQ6B0k/qYfXr5vyNlF04P3+5mZhOeRR3ySpnL90K+/KvANmqVHugSTwhKM6
 ObxTYO4USDiHMuG+8I4+dZa+4wJn8Yu3YJ1HnWZLgKRLMaOZXevax/I1YObsBMzQeJcgja57eRm
 FUJWNEHzyhAcsZySJP38IJxKwTs/pWnirNPhN9/9wapg2rZ6cTT/dqRAH+qfVMe9zpjyNJc6V//
 T8uPOotXVgtU2+LOfg4PPhj7Kiy97wSPFftvs6b+ZdSluG2eMrQyNS1oPCy9/HEzz4VN85Q4rke
 oIXOqIsBWzrcduFdPdEl4JEh4qIsX2rBjLyQxmZTumDcEoHSjhO43EEszjyY7tKWWDOVQXzNEsm
 pB/8=
X-Received: by 2002:ae9:f814:0:b0:8c0:e5ac:af12 with SMTP id
 af79cd13be357-8c0e5acaff4mr1306380085a.5.1766500224964; 
 Tue, 23 Dec 2025 06:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE20V+f+mztYilAiFhJ4BHRIViOFskcGzx6dT7bvJyY8aHHQy6E6NyRldGvonhS9N8/wQAArw==
X-Received: by 2002:ae9:f814:0:b0:8c0:e5ac:af12 with SMTP id
 af79cd13be357-8c0e5acaff4mr1306366985a.5.1766500223936; 
 Tue, 23 Dec 2025 06:30:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:23 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 18/31] tests/qtest/migration: Add a NULL parameters test for TLS
Date: Tue, 23 Dec 2025 09:29:46 -0500
Message-ID: <20251223142959.1460293-19-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

Make sure the TLS options handling is working correctly with a NULL
parameter. This is relevant due to the usage of StrOrNull for the
tls-creds, tls-authz and tls-hostname options.

With this, all manners of passing TLS options are somehow covered by
the tests, we should not need to do manual testing when touching TLS
options code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251215220041.12657-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/migration-qmp.h |  1 +
 tests/qtest/migration/migration-qmp.c |  9 +++++
 tests/qtest/migration/tls-tests.c     | 56 +++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 44482d250f..940ffd5950 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -36,6 +36,7 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                const char *value);
 void migrate_set_parameter_strv(QTestState *who, const char *parameter,
                                 char **strv);
+void migrate_set_parameter_null(QTestState *who, const char *parameter);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
 void migrate_ensure_non_converge(QTestState *who);
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index c803fcee9d..5c46ceb3e6 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -458,6 +458,15 @@ void migrate_set_parameter_strv(QTestState *who, const char *parameter,
     qtest_qmp_assert_success(who, command, parameter);
 }
 
+void migrate_set_parameter_null(QTestState *who, const char *parameter)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: null } }",
+                             parameter);
+    migrate_check_parameter_str(who, parameter, "");
+}
+
 static long long migrate_get_parameter_bool(QTestState *who,
                                             const char *parameter)
 {
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 21e9fec87d..e0e8a7335c 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -507,6 +507,57 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
+{
+    struct TestMigrateTLSPSKData *data =
+        g_new0(struct TestMigrateTLSPSKData, 1);
+
+    migrate_set_parameter_null(from, "tls-creds");
+    migrate_set_parameter_null(to, "tls-creds");
+
+    return data;
+}
+
+static void test_precopy_tcp_no_tls(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_no_tls,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void *
+migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .authzclient = true,
+    };
+    TestMigrateTLSX509Data *data = migrate_hook_start_tls_x509_common(from, to,
+                                                                      &args);
+    migrate_set_parameter_null(from, "tls-hostname");
+    migrate_set_parameter_null(to, "tls-hostname");
+
+    return data;
+}
+
+static void test_precopy_tcp_tls_no_hostname(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_no_host,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
+        .start.hide_stderr = true,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_TASN1
 static void test_precopy_tcp_tls_x509_default_host(void)
 {
@@ -799,6 +850,11 @@ void migration_test_add_tls(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/no-tls",
+                       test_precopy_tcp_no_tls);
+    migration_test_add("/migration/precopy/tcp/tls/no-hostname",
+                       test_precopy_tcp_tls_no_hostname);
+
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-- 
2.50.1


