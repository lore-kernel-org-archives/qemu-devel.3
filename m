Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF45DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYl-00015i-Lx; Wed, 20 May 2026 17:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYk-00015U-TJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYi-0007F8-W2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7f6K3MBcV2u7y7s25cXpahSIeN8CJUpok59sEYFMOnM=;
 b=M+DG9UaywNVO8qxAagSh4XhRXNsGys4Y3q+1sn5qhK09mXTIWklKvyDTMFpsWHepZjwihi
 cA78NF77tWe6ufBiCX6XVnHeQ8PYW+aN50PiEe0xohHqvc6hSNNI9qu2ioPthbRHK+dj34
 4ARa4rjjaDKCDhhJmjCoMza4AXTlhpI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-IvhPcS8SNmu7VPGyIZ6amA-1; Wed, 20 May 2026 17:34:31 -0400
X-MC-Unique: IvhPcS8SNmu7VPGyIZ6amA-1
X-Mimecast-MFC-AGG-ID: IvhPcS8SNmu7VPGyIZ6amA_1779312870
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b4bebd2b2aso152650986d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312870; x=1779917670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7f6K3MBcV2u7y7s25cXpahSIeN8CJUpok59sEYFMOnM=;
 b=cBRrbCTjQwn+BNAXDGtZBjDzQT6dL2tfnCQ+OIPOHf8WA244goQOJEmsy1aQPcHcvn
 4fJbYwMe1T7uTDETorxaMK15GbNpBOqE0/D/6eyrtgSfqMMQa7NxNGyJ4xsrF0cb2At9
 Q0eajChN4DuaOy1wv7re0OhMCqVGa+k4DQBcAqHxqHN3dVZRQpnFxgg9juNhRHBK0I3+
 /9z4XSYSr0T3IRWyNMGVWY/JHP7h1IRbgM9j5VNYwdEASHi7+Mbizd2bGXy5IxPCtAQ1
 itSlDWoTfxEd62cFV+f56dpjVhTjy+hzdUEXV7IVtiHGgIY9s5jCV/FvIyMzeZVKheDk
 QeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312870; x=1779917670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7f6K3MBcV2u7y7s25cXpahSIeN8CJUpok59sEYFMOnM=;
 b=F6wzVgP2iFNYLgQOJlkiT1+zpezifFW2TEzHafjGBpSzgnFTfQsDtpMmhXETv3aVRg
 b7z3VdCeBO8K1Yl0mR40CcQfTts/5pZC8WUkc/kLt8kPIwf9tZrjAW2wo8ee8XXIX1dh
 T5pl+nrtDW01fkwMbuRPEsl5N4TUX++PjFRwqxKdTuZUU1EIXfVUiopRdOVpJUEthOzn
 3z1XrkDauGgorBYkZyb1tO+SFxExCGE3/C/hFO3nlFAVpZ31xjVPLTWHBEE1h5yG86uT
 10yORZzKUF3nmmGoVZobpFIp5zd3BjN3KQ3/4rj8caJAp6Uc+k1teS8bmRtOa3CvDOEV
 sL+A==
X-Gm-Message-State: AOJu0YyX36W8MTWtca5rYMJ+iWKwQdf3//NWcBsdRKJnS4p6caL9WMS9
 YoCoP/6L1/YGfNkmyAyfi9vcBp3fjh4VMqVviUfKSIqlXPEBdzFmAH4YdjgC68hxzw/u4naXQ2b
 PnqeeJVk5spEIUxByQI3c+Oz6fweQJx6kjW35Cnv7BrJ+mFNdEEQusjHS2vNYFZFjVFIu6w3x6o
 M6tyPgE7KFGQB5oN498OwAydivPfaRtpsGp0xwZw==
X-Gm-Gg: Acq92OGm79HTjFUE2pVWXr5Sz12LkmHZBw+bA+sRTe5aLqc9+qKzYgRgMYcUZ87Rn/2
 abddyGBEJJ6FZXIWL67D7WNhcaBveWNU3a0P7TW6Qz7LYanfkhMQ03aK7d+aF0AbkpcctEojctL
 h3xph4VrPRY7ZIqWg+h4YUzCshVmsN3BZDfsHtHSAfqPoxADMbtbIUfmwuNOltTXrXJMSQbK8/L
 8CFxS08sORU1VXfv4cO3ZVVc0NhFwEPzDg/uMYdMa4NxXSbQaA5S/nYsxlc/B3isUc0w5rjSZlU
 3PMA2ZUA99DcvEgt3wm5jbe2YW1kv1HRYZy6p/ur0n3N0jPPbFHEE3BLc6v3dINI7HXnq/SwVTM
 Yc85Q1wSzKAHnmqUZ6YgLZmdJzZstQtUy0JS+J330aWHe
X-Received: by 2002:a05:6214:5403:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8cc6e8fc4f7mr2235066d6.3.1779312870234; 
 Wed, 20 May 2026 14:34:30 -0700 (PDT)
X-Received: by 2002:a05:6214:5403:b0:89c:6692:1d83 with SMTP id
 6a1803df08f44-8cc6e8fc4f7mr2234636d6.3.1779312869712; 
 Wed, 20 May 2026 14:34:29 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 10/29] tests/qtest/migration: Group unix migration tests
Date: Wed, 20 May 2026 17:33:38 -0400
Message-ID: <20260520213357.40646-11-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Remove some repetition when defining unix: tests by introducing a
_common function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h         |  1 +
 tests/qtest/migration/compression-tests.c |  6 +----
 tests/qtest/migration/framework.c         |  9 +++++++
 tests/qtest/migration/precopy-tests.c     | 30 +++--------------------
 tests/qtest/migration/tls-tests.c         | 12 ++-------
 5 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 3ccc6a99d2..825209ee74 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -240,6 +240,7 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args,
                                    PostcopyRecoveryFailStage fail_stage);
 int test_precopy_common(MigrateCommon *args);
+void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 845e622cd5..7f2856b7f8 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -123,10 +123,6 @@ migrate_hook_start_xbzrle(QTestState *from,
 
 static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_xbzrle;
     args->iterations = 2;
     /*
@@ -137,7 +133,7 @@ static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 
     args->start.caps[MIGRATION_CAPABILITY_XBZRLE] = true;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void *
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 3802c6f57d..1d13b897a9 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -934,6 +934,15 @@ finish:
     return 0;
 }
 
+void test_precopy_unix_common(MigrateCommon *args)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    test_precopy_common(args);
+}
+
 static void file_dirty_offset_region(void)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 0426319199..849aef3ed6 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -37,62 +37,40 @@ static char *tmpfs;
 
 static void test_precopy_unix_plain(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * The simplest use case of precopy, covering smoke tests of
      * get-dirty-log dirty tracking.
      */
     args->live = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_suspend_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * despite being live, the test is fast because the src
      * suspends immediately.
      */
     args->live = true;
-
     args->start.suspend_me = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_suspend_notlive(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     args->start.suspend_me = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_dirty_ring(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * Besides the precopy/unix basic test, cover dirty ring interface
      * rather than get-dirty-log.
      */
     args->live = true;
-
     args->start.use_dirty_ring = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 #ifdef CONFIG_RDMA
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 87898af260..0677ca661e 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -424,14 +424,10 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
 
 static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 #ifdef CONFIG_TASN1
@@ -454,14 +450,10 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 static void test_precopy_unix_tls_x509_override_host(char *name,
                                                      MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.53.0


