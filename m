Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD36E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Ow-00010V-3y; Tue, 23 Dec 2025 09:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oq-0000wj-Go
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oo-0003es-MJ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb1DUlJQ4GnVRgU92F0kkwFwuzusrXZvVQZu8EFnPos=;
 b=fWU9YobwqO6QyZQcrYpc30R2GoK8XiZD+Y5deo91jsFVZadYLdlId6t/9jvV5/hLL+f4sE
 Lf8eqRsBXvgKs9WDI+uPnkcBvBhP6OHLhHkCa9hXZtyiuALGN9H7zFin2oYU1+V/Hv3xCq
 pGlhl04pXyFjOvbvEWCyXJBCi0cyE+w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-7xJv2OJNNlOmoPkyeTTX3A-1; Tue, 23 Dec 2025 09:30:04 -0500
X-MC-Unique: 7xJv2OJNNlOmoPkyeTTX3A-1
X-Mimecast-MFC-AGG-ID: 7xJv2OJNNlOmoPkyeTTX3A_1766500204
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so1259095285a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500204; x=1767105004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jb1DUlJQ4GnVRgU92F0kkwFwuzusrXZvVQZu8EFnPos=;
 b=tn/gz5ce2nntUSgXaR788+4zPcHhcKrxcms2nfYJMyi5P0rFE/I3r/oLZJk5VDnRl/
 o+MBRzANzdwD6FAeIUy0PxklpKU1naS+CsIM+o2e1Oa4PLIFHGq+PYTDxXOI36fWIqbD
 7RjeznKO11Uxgolt/m/SQCQnx3+i8zOrbnLY3wOzh6/YXew9IgRN87HQPw9EYg2E20iP
 lrwtLsIjGVyI1LdbbW2VsgPGCRw532zo2zdJZF0UpG6Iz7aip3/TcDWLSKTbv+8n5GNz
 NsgE1cqPxYgQjs+4rC6Qdcv2Z/xJaoCREGwI23NJGIVf6ENC0hbefxgOEQ8MNde4Oial
 lXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500204; x=1767105004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jb1DUlJQ4GnVRgU92F0kkwFwuzusrXZvVQZu8EFnPos=;
 b=egA4aEFZ1DVuqzFX6Ziyd71KCyK9MwoPHu57vv1Mz7t9pfPwSA2aUh8ag4znmu9XQh
 KQ+Wli/iHG+ntKDkbkccVKelbPppSlvnUVbcoD+6W5Jzu2pyfj26tsqKi8584qMbrz/n
 J4CVQpXNCMmztLBx9hjHye5J8Nhm2vLyizOYUOsDSd/ZAR7Sn5RmRwDgQ7CA8HTC7oxS
 wf2OvGx2/JKWVQ9kLxNsyqoFDIZxsShQdS3YMt23HqZIE51/4x9TYGLb+3thDX3cKILJ
 3CAgOOazyRK4ZRbIVn6mgIxxBpEa0V00aZK0FIKjegPdI0huMOIDrzUu5oVnsTa+3xfH
 K56g==
X-Gm-Message-State: AOJu0YzKTzH01ZoZ/T3VpNo1rbiEcBZLmfdinE7UToezX6C2CS+3gqfY
 73VA/UUcVhER5qFKC6Xdpq0aZYWMuX6Ow1TvyZ3LiDCdyRckKSioqEqKLOv4qwsU9DR2H00c/qr
 1c8Z1hArtIgY1mi8TIkilmymt0bQwkZzLLy7+vFrestI19+eeVtOd0FiAywfa73j7tMVgTYaVMT
 8VxBWSeLaHrEIxwCR09MFE0GCD+TFWz6p/InFIOA==
X-Gm-Gg: AY/fxX5wOvhxSP9TuiaXbtlucbg0c45tjJDnO/lWzMQIag6Gx9B3oK2xp+GWUBY2X3A
 F5m7KzfuGsIKLPSZU0dFB13hwLFoNWvQU+pEcMPzPwlCoDE5LPhyfTZ8DsXZhRsDj9mH+7CKt8W
 wCaP9UNB0HTNleL2tIGu1+eeeaI9tdeoJAiDKwm5ZZ80psbzJ5QfdcZxKrDS5LSvPIEeJd2Efa3
 wb8s9xCDCHKBoZANsbw9le0rydH174TlIjwbV4en3RxpkRaeTsWGrzjm0kdinK4tDLQ1Mfo66Fx
 gRgu9VOjokGZO+Nsp/yt7iLBKiF94c0pnh5ad03OyBSzzOg4J31ySTXv2z1B/l4F8p1RUhaCLEO
 6EbE=
X-Received: by 2002:a05:620a:4626:b0:8bb:9f02:489e with SMTP id
 af79cd13be357-8c08fac0621mr2252342985a.74.1766500203545; 
 Tue, 23 Dec 2025 06:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlY3WGyuGEN0JcEoitTu8cUBQeAHdLH0s8twOu8NBJn0aFFmrJeDm+/j3O+eJ+Pd+QVgpviQ==
X-Received: by 2002:a05:620a:4626:b0:8bb:9f02:489e with SMTP id
 af79cd13be357-8c08fac0621mr2252337885a.74.1766500202980; 
 Tue, 23 Dec 2025 06:30:02 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Pawel Zmarzly <pzmarzly0@gmail.com>
Subject: [PULL 01/31] migration: fix parsing snapshots with x-ignore-shared
 flag
Date: Tue, 23 Dec 2025 09:29:29 -0500
Message-ID: <20251223142959.1460293-2-peterx@redhat.com>
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

From: Pawel Zmarzly <pzmarzly0@gmail.com>

Snapshots made with mapped-ram and x-ignore-shared flags are
not parsed properly.

The ignore-shared feature adds and extra field in the stream, which
needs to be consumed on the destination side. Even though mapped-ram has
a fixed header format, the ignore-shared is part of the "generic" stream
infomation so the mapped-ram code is currently skipping that be64 read
which incorrectly offsets every subsequent read from the stream.

The current ignore-shared handling can simply be moved earlier in the code
to encompass mapped-ram as well since the ignore-shared doubleword is the
first one read when parsing the ramblock section of the stream.

Co-authored-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251126121233.542473-1-pzmarzly0@gmail.com
[peterx: enhance commit log per fabiano]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c                    | 21 +++++++++++----------
 tests/qtest/migration/file-tests.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..7d024b88b5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4205,6 +4205,17 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 
     assert(block);
 
+    if (migrate_ignore_shared()) {
+        hwaddr addr = qemu_get_be64(f);
+        if (migrate_ram_is_ignored(block) &&
+            block->mr->addr != addr) {
+            error_report("Mismatched GPAs for block %s "
+                         "%" PRId64 "!= %" PRId64, block->idstr,
+                         (uint64_t)addr, (uint64_t)block->mr->addr);
+            return -EINVAL;
+        }
+    }
+
     if (migrate_mapped_ram()) {
         parse_ramblock_mapped_ram(f, block, length, &local_err);
         if (local_err) {
@@ -4244,16 +4255,6 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             return -EINVAL;
         }
     }
-    if (migrate_ignore_shared()) {
-        hwaddr addr = qemu_get_be64(f);
-        if (migrate_ram_is_ignored(block) &&
-            block->mr->addr != addr) {
-            error_report("Mismatched GPAs for block %s "
-                         "%" PRId64 "!= %" PRId64, block->idstr,
-                         (uint64_t)addr, (uint64_t)block->mr->addr);
-            return -EINVAL;
-        }
-    }
     ret = rdma_block_notification_handle(f, block->idstr);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4d78ce0855..c196a703ff 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -303,6 +303,22 @@ static void migration_test_add_file_smoke(MigrationTestEnv *env)
                        test_multifd_file_mapped_ram_dio);
 }
 
+static void test_precopy_file_mapped_ram_ignore_shared(void)
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
 void migration_test_add_file(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -329,6 +345,8 @@ void migration_test_add_file(MigrationTestEnv *env)
 
     migration_test_add("/migration/multifd/file/mapped-ram",
                        test_multifd_file_mapped_ram);
+    migration_test_add("/migration/multifd/file/mapped-ram/ignore-shared",
+                       test_precopy_file_mapped_ram_ignore_shared);
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
 
-- 
2.50.1


