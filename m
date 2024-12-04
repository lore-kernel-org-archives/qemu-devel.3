Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F6E77169
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcz-0003KZ-3t; Tue, 03 Dec 2024 19:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcc-0003G5-M0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdca-0005r8-Im
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lm/P/jIwMwruD4XzBa8oclsmE6F53aZByJkttYW/WWw=;
 b=CudD6YNavcgUin+Co1LDKeJguuXrz51e2Lq12tnKFZMgyENJA3PJdLjnXEhbao45tJHlYs
 ndsXf7nZcC/k3ymCb/G0jYCxeuv3Mpqc7CjZwlTsiQcXKRDe1F5GCFOHqcfgRMLoBAcH0C
 MuHACCjQh3sLnvxpwVT08UbYOd0vWqk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-YIuoHBM3Nv6sHeFW8imlqw-1; Tue, 03 Dec 2024 19:52:02 -0500
X-MC-Unique: YIuoHBM3Nv6sHeFW8imlqw-1
X-Mimecast-MFC-AGG-ID: YIuoHBM3Nv6sHeFW8imlqw
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b66724f242so822266185a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273520; x=1733878320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lm/P/jIwMwruD4XzBa8oclsmE6F53aZByJkttYW/WWw=;
 b=CqeqIp9sCgYXJsKrsxKav5Bo40wdwWkFQY/LPIqMoWybvlmL6VFEtrqCFD1PQR0SGP
 FA1om7jYy1OX4FSc2BQh3ZUpuguwikAsasLoF3E28o3+hHcC/wCa4jFy7AA0RrMAXRe9
 IJqbZ9DYev3Ki9x9kUfrGTV2o7ZVOkkcFbKQIArpliBfCV2hjEhWgflT8yHNF1toctit
 g+9WUHRMKxM+/T2yfJzj/vv19aTUno5KdVjStaPhLyjFgcXBgqyXLIKn63AZcu29fFfD
 QR30qqe6LbB6kivZu7uaFlimQqNoJUlqfiyW1hBGoSjZdjhZ1VDxwiZZEHK0Tzw2t0OP
 u7YQ==
X-Gm-Message-State: AOJu0YygxlTme90vBwFOuObscDeOu42wLtx2tUcw0fvHhDMzxylTAzSs
 qr5qe/GWFjm1t9ENTfOXM2ZNMtJCbHyyZrgZuLKjsBWCgVxUhtCzGjgbIpbp1J0n0WcY6+YUwyP
 KvP3oWglLjrVI8jSw0Ervj4R06nZQF6UOohGo/2RPVEsdnCg6ieXJTHY0k1sVKHgWJ4OiesMlKC
 opLuxRrU4fSLh5XWYN9Uk68bZGBB0DvsuXBg==
X-Gm-Gg: ASbGncv8zGYhSDx/Y1+nSuv0MExktuE60urM5ysjl2wDqd4FvSQbrse/HbrkQ5lz/Vq
 5JFgnPjyhpusfPKASqhbemSjjNQ26j8Aa/USJBNIsUd66JIRLO+ICe5UhOtASoGy6Ga3e+a1KPB
 mzBP6clgCK/TRhDbVEXrsX41eGaoGtwSs2+PovAcAxiUpB9XPfFCIsHNjmyrf1Pnl66ErFijdq0
 dMEXD8rljsho2A9SAO5taGOSK9GWpocQSsbRnspNKM1u9UqvmZE5uquGWEhNa5A1o9ECeT+pMRZ
 aE5s4M6m9vEAh6rNId09wYFt1Q==
X-Received: by 2002:a05:620a:2408:b0:7b6:6365:1b72 with SMTP id
 af79cd13be357-7b6a5d2073emr613217985a.3.1733273519901; 
 Tue, 03 Dec 2024 16:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3ehHw+bMA4K4ztxLeKi6Ucp6THmJxt72TbRS5NcTYNqQyu7e332g7IaAHGL4zeTDyoJ21Cw==
X-Received: by 2002:a05:620a:2408:b0:7b6:6365:1b72 with SMTP id
 af79cd13be357-7b6a5d2073emr613213785a.3.1733273519486; 
 Tue, 03 Dec 2024 16:51:59 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:57 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 09/11] tests/qtest/migration: Don't use hardcoded strings
 for -serial
Date: Tue,  3 Dec 2024 19:51:36 -0500
Message-ID: <20241204005138.702289-10-peterx@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stop using hardcoded strings for -serial so we can in the next patches
perform more than one migration in a row. Having the serial path
hardcoded means we cannot reuse the code when dst becomes the new src.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241125144612.16194-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.h |  2 +
 tests/qtest/migration-helpers.c |  8 ++++
 tests/qtest/migration-test.c    | 68 ++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 72dba369fb..c7a36a33d6 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -20,6 +20,7 @@ typedef struct QTestMigrationState {
     bool resume_seen;
     bool suspend_seen;
     bool suspend_me;
+    char *serial;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -64,5 +65,6 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 #endif
 void migration_test_add(const char *path, void (*fn)(void));
 void migration_event_wait(QTestState *s, const char *target);
+char *migrate_get_unique_serial(const char *tmpfs);
 
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3f8ba7fa8e..7c0b54ce0e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -528,3 +528,11 @@ void migration_event_wait(QTestState *s, const char *target)
         qobject_unref(response);
     } while (!found);
 }
+
+char *migrate_get_unique_serial(const char *tmpfs)
+{
+    static int i;
+
+    assert(i < INT_MAX);
+    return g_strdup_printf("%s/serial_%d", tmpfs, i++);
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index eafc2da806..1452778c81 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -192,9 +192,8 @@ static void bootfile_create(char *dir, bool suspend_me)
  * we get an 'A' followed by an endless string of 'B's
  * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
-static void wait_for_serial(const char *side)
+static void wait_for_serial(const char *serialpath)
 {
-    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
 
     do {
@@ -216,7 +215,7 @@ static void wait_for_serial(const char *side)
             break;
 
         default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            fprintf(stderr, "Unexpected %d on %s\n", readvalue, serialpath);
             g_assert_not_reached();
         }
     } while (true);
@@ -818,16 +817,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
         src_state = (QTestMigrationState) { };
         src_state.suspend_me = args->suspend_me;
+        src_state.serial = migrate_get_unique_serial(tmpfs);
 
         cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                      "-machine %s,%s "
                                      "-name source,debug-threads=on "
                                      "-m %s "
-                                     "-serial file:%s/src_serial "
+                                     "-serial file:%s "
                                      "%s %s %s %s %s",
                                      kvm_opts ? kvm_opts : "",
                                      machine, machine_opts,
-                                     memory_size, tmpfs,
+                                     memory_size, src_state.serial,
                                      arch_opts ? arch_opts : "",
                                      arch_source ? arch_source : "",
                                      shmem_opts ? shmem_opts : "",
@@ -841,17 +841,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     dst_state = (QTestMigrationState) { };
+    dst_state.serial = migrate_get_unique_serial(tmpfs);
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
-                                 "-serial file:%s/dest_serial "
+                                 "-serial file:%s "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs, uri,
+                                 memory_size, dst_state.serial, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
@@ -911,8 +912,10 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
     qtest_quit(to);
 
     cleanup("migsocket");
-    cleanup("src_serial");
-    cleanup("dest_serial");
+    unlink(src_state.serial);
+    g_free(src_state.serial);
+    unlink(dst_state.serial);
+    g_free(dst_state.serial);
     cleanup(FILE_TEST_FILENAME);
 }
 
@@ -1290,7 +1293,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                              "                'port': '0' } } ] } }");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
     wait_for_suspend(from, &src_state);
 
     migrate_qmp(from, to, NULL, NULL, "{}");
@@ -1314,7 +1317,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     /* Make sure we get at least one "B" on destination */
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
 
     if (uffd_feature_thread_id) {
         read_blocktime(to);
@@ -1719,7 +1722,7 @@ static void test_precopy_common(MigrateCommon *args)
 
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial("src_serial");
+        wait_for_serial(src_state.serial);
         wait_for_suspend(from, &src_state);
     }
 
@@ -1796,7 +1799,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
         }
 
-        wait_for_serial("dest_serial");
+        wait_for_serial(dst_state.serial);
     }
 
 finish:
@@ -1871,7 +1874,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     migrate_ensure_converge(from);
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     if (stop_src) {
         qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
@@ -1898,7 +1901,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
     wait_for_resume(to, &dst_state);
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
 
     if (check_offset) {
         file_check_offset_region();
@@ -2041,7 +2044,7 @@ static void test_ignore_shared(void)
     migrate_set_capability(to, "x-ignore-shared", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2051,7 +2054,7 @@ static void test_ignore_shared(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     /* Check whether shared RAM has been really skipped */
@@ -2669,7 +2672,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     migrate_set_capability(from, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2733,7 +2736,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     }
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     /*
      * 'uri' and 'channels' validation is checked even before the migration
@@ -2823,7 +2826,7 @@ static void test_migrate_auto_converge(void)
     migrate_set_capability(from, "pause-before-switchover", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2885,7 +2888,7 @@ static void test_migrate_auto_converge(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     test_migrate_end(from, to, true);
@@ -3296,7 +3299,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, NULL, NULL, "{}");
 
@@ -3307,7 +3310,8 @@ static void test_multifd_tcp_cancel(void)
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
     qtest_wait_qemu(to);
-    qtest_quit(to);
+    unlink(dst_state.serial);
+    g_free(dst_state.serial);
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
@@ -3345,7 +3349,7 @@ static void test_multifd_tcp_cancel(void)
     wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
     test_migrate_end(from, to2, true);
 }
@@ -3488,13 +3492,16 @@ static QTestState *dirtylimit_start_vm(void)
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
 
+    src_state = (QTestMigrationState) { };
+    src_state.serial = migrate_get_unique_serial(tmpfs);
+
     bootfile_create(tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
-                          "-serial file:%s/vm_serial "
+                          "-serial file:%s "
                           "-drive file=%s,format=raw ",
-                          tmpfs, bootpath);
+                          src_state.serial, bootpath);
 
     vm = qtest_init(cmd);
     return vm;
@@ -3503,7 +3510,8 @@ static QTestState *dirtylimit_start_vm(void)
 static void dirtylimit_stop_vm(QTestState *vm)
 {
     qtest_quit(vm);
-    cleanup("vm_serial");
+    unlink(src_state.serial);
+    g_free(src_state.serial);
 }
 
 static void test_vcpu_dirty_limit(void)
@@ -3519,7 +3527,7 @@ static void test_vcpu_dirty_limit(void)
     vm = dirtylimit_start_vm();
 
     /* Wait for the first serial output from the vm*/
-    wait_for_serial("vm_serial");
+    wait_for_serial(src_state.serial);
 
     /* Do dirtyrate measurement with calc time equals 1s */
     calc_dirty_rate(vm, 1);
@@ -3612,7 +3620,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
     migrate_set_capability(from, "pause-before-switchover", true);
 
     /* Wait for the serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 }
 
 /*
@@ -3751,7 +3759,7 @@ static void test_migrate_dirty_limit(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     test_migrate_end(from, to, true);
-- 
2.47.0


