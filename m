Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A92BD0EE1C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNytb-0005Hw-K3; Tue, 25 Nov 2025 14:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNytX-00058N-LU
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:40:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNytU-0005R4-U6
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764099607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WppK9tBLLYzjda47L86tYLs3pd8frQrxbyKCRqR3RkI=;
 b=bebjgWsuWDqvtkstHL9m4nnjnrwQL0StihRHn2PuXbXczxwYQxFzPboinD37Z48i91lvlx
 opJj6D7VhYrLP1cH8PXD9w5YtWkIcCXYWvEQBeQdF6wqHw2aCPc+vyHPPwXdLLkixAmN3j
 SCNay7te5Oqn7yvdjIT3pNq9bL4oxU0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-AyNAdsU8Ndaj-lBUmn4Y_g-1; Tue, 25 Nov 2025 14:40:06 -0500
X-MC-Unique: AyNAdsU8Ndaj-lBUmn4Y_g-1
X-Mimecast-MFC-AGG-ID: AyNAdsU8Ndaj-lBUmn4Y_g_1764099606
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88233d526baso194380576d6.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764099606; x=1764704406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WppK9tBLLYzjda47L86tYLs3pd8frQrxbyKCRqR3RkI=;
 b=bdzU3CzO80PHXXB2h9zivPs958lgZZkMjb5cw3DobSA5dlX+fZcHtGfduPgS1/hv8b
 vKFn0MM56NBqLnhZhFsWESSsCCDwgejH392rbMZttBFtWkBdf79kGoW6Ktum73IXzXvu
 2qUQmM2WcRYlWwzgUz3fh3+8jXMP/U3czMjKlgmrwzSmmRZ2NYnAqR3WaEPowO2BPvHx
 w6lGpu6DS9z1JKOoIqZMJnCjmCNVLeuTHnbEHcH+uHYGZ66Zev8siBtxVJ9XrP8TyvnS
 snMl7u1c1pL0KWbxaCLmXrpzCYgyeUwQJgM6MCiA8fiXBmyq7WS+armlmpijZDIfRbt+
 yftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764099606; x=1764704406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WppK9tBLLYzjda47L86tYLs3pd8frQrxbyKCRqR3RkI=;
 b=L9M5hLprJY+IINmo+OyzOr3S0gtQThAxe1W5jiq89iOcm21tH2HZDeWhBYsLfBdiHY
 wB6W2w0YPnYOa2AoNmPls8ygthmSfjQDaAAlpw9UX/Oq9gfIgEZWc37IdhdJlODXo9ox
 jABv8jH7aoYEjxzmGk/csWcPAR/ekzYqhk/W19vRdEVQAKSlIlqo0ougmDU61e/Mqm//
 RNFNmxR5CHNlYNiIBjebIh+VtJL/nJSO1bBimFZuUer6EyK7YhGWWJqRvaVasajnp8v8
 mFZ7q6YchIriGXZubS76nfQl8eCJNxpmvo1D34Pb0x8TelDXapUXsiQSMqPA4S5ZVFsO
 FfVQ==
X-Gm-Message-State: AOJu0YzNyOU9lXL/FVCSgbN+lwDIiheWx8wTX7cc+X+iVg6PTLgUNTWt
 JqTQvvR0B09Py1c8nlqjL2npgmVSoQNEN9XVpgdhtEaitz8hioNqguIEMt7+PNgea6pQmP+J7+a
 DhuR0BHb8W41Bpyj5ewxFl0Nn6495ixNn6HB0i9UX0zC24AJFK+9OMl3Ixd44BxvU4QmQ+PDt8y
 b2IZIV1iB/gYvpMF8kdTBFuTk9zDocpo9g4Zlhuw==
X-Gm-Gg: ASbGncsoBhqze4yot/8lYig5VCS8W1wva4DItxnVuK1+0hqIwt1qQFdVg10WbzFX3TS
 thz7Ix40kxMQgTMg8hSn6orlRptOD3pNUXEgALbARs8lG/SjyVv1mygmRtioMw3+QJuRy+3Xk4s
 1NLqOiZsv+A5RxYb4VyizL8HeySLMzkr7hHPrgOvbMmGl5Zw8QYJ/O72PEFizYPYYy3uZhOElQ1
 o65gQhbS2qCEreLgPyuVM/1GsMwurdfxUiGvTV9Gq8e8KFVhXYZalDLaPmvz85KL/z6P3P41/RI
 tY5jsmzSQfS1lQO9GqCkM5Q5zYzuRGlTZogaShGFPFcmYBh5zPoz8PyUl+blzlOZGY5CFuU0HdC
 zKWY=
X-Received: by 2002:a05:6214:2426:b0:880:535d:d191 with SMTP id
 6a1803df08f44-8847c496a6emr215862406d6.16.1764099605737; 
 Tue, 25 Nov 2025 11:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8lNncFYR0/NCFUrKanfeMro1eeqhuZQLI4785y7sdihfZgqLcItsvbk0mW/UW5VzFJselPQ==
X-Received: by 2002:a05:6214:2426:b0:880:535d:d191 with SMTP id
 6a1803df08f44-8847c496a6emr215861926d6.16.1764099605258; 
 Tue, 25 Nov 2025 11:40:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e599ac9sm129901416d6.49.2025.11.25.11.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 11:40:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Pawel Zmarzly <pzmarzly0@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 michel@michel-slm.name
Subject: [PATCH RFC] tests/migration-test: Add mapped-ram + ignore-shared test
Date: Tue, 25 Nov 2025 14:40:03 -0500
Message-ID: <20251125194003.833842-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It was broken, add a test for it.

NOTE: here we do not really need any shared memory blocks, enabling of both
of the features alone would cover the ramblock layout difference that the
bug triggers.

Cc: Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: michel@michel-slm.name
Signed-off-by: Peter Xu <peterx@redhat.com>
---

RFC because currently master branch is broken with it, so need to merge
only after a proper fix lands.

Pawel, feel free to take this with your fix when repost, or I'll manage.
---
 tests/qtest/migration/file-tests.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4d78ce0855..ab1b477bdf 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -137,6 +137,22 @@ static void test_precopy_file_mapped_ram(void)
     test_file_common(&args, true);
 }
 
+static void test_precopy_file_mapped_ram_ignore_share(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        },
+    };
+
+    test_file_common(&args, true);
+}
+
 static void test_multifd_file_mapped_ram_live(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -324,6 +340,8 @@ void migration_test_add_file(MigrationTestEnv *env)
 
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
+    migration_test_add("/migration/precopy/file/mapped-ram/ignore-share",
+                       test_precopy_file_mapped_ram_ignore_share);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
                        test_precopy_file_mapped_ram_live);
 
-- 
2.50.1


