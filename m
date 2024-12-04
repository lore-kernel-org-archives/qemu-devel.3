Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65C4E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcd-0003GP-82; Tue, 03 Dec 2024 19:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdca-0003EW-2S
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcX-0005mR-Bp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FO857v8PXpejg9RDiLcW7mg3vTpTDPgqvs32Ru5PZEU=;
 b=cgsSaEKFm/jRc71xrQh3fpTmo3h2QCbA59L8Ryed5tgz6y8tIsYjVhsk7rfwSJF6FWiiPY
 6JTDdUJBrvbjTqFfe9DiF49DEasidp6u3PLPsZy0371JioSjZgbLGnR6kezRaIUpt3Rjt6
 7hy+i/wFP0JfrNfB2akCDtJXvWKjqEM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-vnQLAfvnNgKX0kpvKATMgQ-1; Tue, 03 Dec 2024 19:51:58 -0500
X-MC-Unique: vnQLAfvnNgKX0kpvKATMgQ-1
X-Mimecast-MFC-AGG-ID: vnQLAfvnNgKX0kpvKATMgQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b674755f8eso973410185a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273517; x=1733878317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FO857v8PXpejg9RDiLcW7mg3vTpTDPgqvs32Ru5PZEU=;
 b=I2bu++OonTWgtHmP65KJocWMDePR/a3pzjIcUozgLNck9e5MZCzSV6mU18lJYKYHOZ
 RIp9iiR2NpcLFFLxO1p+d5C3rB1pmK6TZJx7lpiEosswnCt9syPp8gU8fmIp2ud9N/Dj
 b0SSc5HFLPLSk/ppYV23uQBQBCUjB6WXSipCRtYIveasWU+E5lHcywXcnsomyPaQWd20
 OaRQV4r01+mfqAOsUYh8l/NSSRO6I5fWlhxu0jmUZ0nQmLeFzkff2CgoTJyX3BiEoj1X
 tpRYxTYxXfEOUqBZdhGsxGfVCk0UadFsF6SdcYoVCR7Mj+NCGI28vn28AvMWjsL5fbxX
 V8kg==
X-Gm-Message-State: AOJu0Yx7MBvd/7AWC5qZVlcJzZIEQruGK9fxJbbwCNFC+BvLrh+IIgDA
 eaoSYBWMp4fHjf9IFsqE8F43qW/P57XUcPSXbuaOANVwzGTEzYia4r6rI0x9ZtVIj1j8cYlkLG1
 3FpOpCJpD2jVG6znSU6fN5K/grcjaQ1pO2jsEsUL8sWJuEHlHSBj1GoBPwxP00XvlQs5MH7fVxF
 cyJUGGeHTb4n+h6WOHL7GxIGztw5G740HJlA==
X-Gm-Gg: ASbGncvloFhhusYeBB1DEd4245PZZZ8p3J61+x6I7OsY/m03+UyukErrGqxjlGx99dd
 zYIn6heB1XdgSUBbqqM83AbhfXolFsYuo3S7XAc24iFySif97BCJA978778kL4SF/g8yXt4nUpQ
 JwdoSl5TJw0+6ndOE7/4pNJvDHMiFnACpuzRP69jPsp6XyNBVBzeuwfss4hiIZSthho8SiLnIlv
 rCon8TY3YYfwBvpk8EAYO7JT1UsTs1xd+CPZ6vYkWWA0gE+XgVCXL16vjY6AyWzQM804UIhS6H+
 TbEF4lSp3z+YnnZ0D1J63Cn9qg==
X-Received: by 2002:a05:620a:4055:b0:7b1:49f7:90ba with SMTP id
 af79cd13be357-7b6a5d2aaeemr445151785a.8.1733273517145; 
 Tue, 03 Dec 2024 16:51:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9rF+JJXp5CLxVWRXQlAO86ovXcvfXhQo2/q858VposVDTqkI5X6HSAIkJIvy6d+u5ez8+zw==
X-Received: by 2002:a05:620a:4055:b0:7b1:49f7:90ba with SMTP id
 af79cd13be357-7b6a5d2aaeemr445147985a.8.1733273516606; 
 Tue, 03 Dec 2024 16:51:56 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 08/11] tests/qtest/migration: Move more code under
 only_target
Date: Tue,  3 Dec 2024 19:51:35 -0500
Message-ID: <20241204005138.702289-9-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204005138.702289-1-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The only_target option's purpose is to make sure only the destination
QTestState machine is initialized. This allows the test code to retain
an already initialized source machine (e.g. for doing ping pong
migration).

We have drifted from that a bit when adding new code, so move some
lines under only_target to restore the functionality.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241125144612.16194-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 44 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74d3000198..eafc2da806 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -717,7 +717,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *arch_target = NULL;
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
-    g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
@@ -735,10 +734,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
@@ -817,27 +813,35 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_test_message("Using machine type: %s", machine);
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name source,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s/src_serial "
-                                 "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_size, tmpfs,
-                                 arch_opts ? arch_opts : "",
-                                 arch_source ? arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
-                                 args->opts_source ? args->opts_source : "",
-                                 ignore_stderr);
     if (!args->only_target) {
+        g_autofree gchar *cmd_source = NULL;
+
+        src_state = (QTestMigrationState) { };
+        src_state.suspend_me = args->suspend_me;
+
+        cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+                                     "-machine %s,%s "
+                                     "-name source,debug-threads=on "
+                                     "-m %s "
+                                     "-serial file:%s/src_serial "
+                                     "%s %s %s %s %s",
+                                     kvm_opts ? kvm_opts : "",
+                                     machine, machine_opts,
+                                     memory_size, tmpfs,
+                                     arch_opts ? arch_opts : "",
+                                     arch_source ? arch_source : "",
+                                     shmem_opts ? shmem_opts : "",
+                                     args->opts_source ? args->opts_source : "",
+                                     ignore_stderr);
+
         *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
     }
 
+    dst_state = (QTestMigrationState) { };
+
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
@@ -870,7 +874,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Always enable migration events.  Libvirt always uses it, let's try
      * to mimic as closer as that.
      */
-    migrate_set_capability(*from, "events", true);
+    if (!args->only_target) {
+        migrate_set_capability(*from, "events", true);
+    }
     migrate_set_capability(*to, "events", true);
 
     return 0;
-- 
2.47.0


