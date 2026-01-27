Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C5D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCq-0005sP-NC; Tue, 27 Jan 2026 13:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBq-0003FZ-Ev
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBo-0000og-Hl
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYZ2iNE8RQmcMqy3VCVQZ24wJOchHkbRFDeNGZism28=;
 b=f3Fb0EgM/JKjd/zv82W2acHs+5JSudvcRrbrUnCiF3kExvqiu4ZOzm4HGlCyZg2Xg6PsFT
 TS17HqdM3xdWhDwmCHHyY2er7+oez7NELH/3N853ogQZ4oha9N5TIj9pJKNTTEzH9X0gxp
 6xqqNfgOou94IEcWNUc4GnEERhGrhwc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-lV97wPN2PpOVHn7f8nQyeg-1; Tue, 27 Jan 2026 13:53:22 -0500
X-MC-Unique: lV97wPN2PpOVHn7f8nQyeg-1
X-Mimecast-MFC-AGG-ID: lV97wPN2PpOVHn7f8nQyeg_1769540002
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c5296c7e57so790626185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769540002; x=1770144802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYZ2iNE8RQmcMqy3VCVQZ24wJOchHkbRFDeNGZism28=;
 b=AIYbTMtMMXi7USbDON71/0A+srNAbmusPX3ShVeLYd5tCEYWbxqaoNIfRBm2UgDoTK
 EOsi/icOjyVNJvvo2XP4W0TDKsYJiJsRz/1asngoojT9COT1aFbs6rPqpCZ0avspQvUZ
 iac0yxoDwBG4oN34lSgcHwQm48gNO3hQNXBQtGsJF3VpXlSryMzr2Yl+dXLNBtKrPa+M
 8hNxE0OtnKV5mmOdvVz5uK9axh+2SKRkgxwy/ZguwZKbKfV3QQxZTShKU7o7PJRZLoMT
 CyJcBJYskziHiGkkoufkaj08lTif00ydua1o1wWzzvArO2zOy2eDsxGfyO15RRNZQ7po
 /6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540002; x=1770144802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYZ2iNE8RQmcMqy3VCVQZ24wJOchHkbRFDeNGZism28=;
 b=hkHAyOJDDF5BsBmIC4rlSw5dNbNKKxb37EoClxNRKseFfjTUKvPFqht8we4e95lgSn
 R8jMbhVzxnURu15YeYpbHY/P3KwlNdmwgNGkw8q/8LjXV0PrxDVgqQGoE/ImZw5T4iqT
 SuCg9MIuCdE3dIRR7NRaUHepyTMvO8TC+p/k+3nnsXskHtmdIphJzW/xZb1VY8nouwNR
 wQ3H1Sbonaggzv4eD6Q1XZTMekqK6d+j7DDFarcEK8RM9Cno6IOSMDSFj6UlyEuvWDod
 mK+6aZZg1AubzQhGwgyxzwUnYGTU7Adx9MD+ReruwsZ/VKJp8DCSXleOYlQHhRTAodkK
 HF2w==
X-Gm-Message-State: AOJu0Yz2rS3EGsfkQFhlUWiN3Dx1/+K2kDFoixIMp7pdRBEVZ+5bz3Le
 WTsq2Jj3usW0vpSUjT3gg2++hIxojBkeYTW7AOs3++G7tk8Livz+7gh2swHc2Aws6IvJbH35tsK
 /PHBxaVAZ1moTV5u8pmCG4MPfOeXZ/E3xjYXrJUks4WgfqS47IgDqUyt5yU4painbWMVcvBbrLk
 o7xH4kDm0j0mnEMtycXLxQNlw5X8NIz/UHrhqZGQ==
X-Gm-Gg: AZuq6aJhJbcLsch+Ki2Vh4Mldy6F5/CbilX1tLbWKdEQ8aE+WsC/2xrXpKKd2Ls8c75
 88ZAwjq9YffXQ18YMXGQZjaMJ+rt3kz8w6eq+taJT/5w+l6LciCQUyWakCENNo5YEHneZaevSjt
 xTmhM36b/2az94wPO+rpBQ2MLhNOi/oxs0SeXLEBnzQO1P2f3rTT0L/VpcqGtVVGNLapgzcKAVU
 lzSTlFl+HWhFnSQ2PtQLVfSXNo0iJN4Ql8hZWuEGmQa1cat1Igia54LX7b6S3DF3IdrNrJ38d4Q
 L5O44QKYVkUNn6P2YL/Li25+r++4WoIAO8+GQGnETAL+fL/H15/ufci+5HVyqFd3P35AC2HMwxE
 d
X-Received: by 2002:a05:620a:3728:b0:8b2:e058:de83 with SMTP id
 af79cd13be357-8c70b85b1abmr303110985a.15.1769540001835; 
 Tue, 27 Jan 2026 10:53:21 -0800 (PST)
X-Received: by 2002:a05:620a:3728:b0:8b2:e058:de83 with SMTP id
 af79cd13be357-8c70b85b1abmr303107485a.15.1769540001315; 
 Tue, 27 Jan 2026 10:53:21 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 21/24] migration/bg-snapshot: Cleanup error paths
Date: Tue, 27 Jan 2026 13:52:51 -0500
Message-ID: <20260127185254.3954634-22-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Cleanup bg_migration_thread() function on error handling.  First of all,
early_fail is almost only used to say if BQL is taken.  Since we already
have separate jumping labels, we don't really need it, hence removed.

Also, since local_err is around, making sure every failure path will set a
proper error string for the failure, then propagate to MigrationState.error.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2cbeebc9ba..ddf6faab46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3616,7 +3616,6 @@ static void *bg_migration_thread(void *opaque)
     int64_t setup_start;
     MigThrError thr_error;
     QEMUFile *fb;
-    bool early_fail = true;
     Error *local_err = NULL;
     int ret;
 
@@ -3662,10 +3661,7 @@ static void *bg_migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_error_propagate(s, local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
-        goto fail_setup;
+        goto fail;
     }
 
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
@@ -3675,11 +3671,13 @@ static void *bg_migration_thread(void *opaque)
     bql_lock();
 
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
-        goto fail;
+        error_setg(&local_err, "Failed to stop the VM");
+        goto fail_with_bql;
     }
 
     if (qemu_savevm_state_non_iterable(fb)) {
-        goto fail;
+        error_setg(&local_err, "Failed to save non-iterable devices");
+        goto fail_with_bql;
     }
 
     qemu_savevm_state_end_precopy(s, fb);
@@ -3692,9 +3690,9 @@ static void *bg_migration_thread(void *opaque)
 
     /* Now initialize UFFD context and start tracking RAM writes */
     if (ram_write_tracking_start()) {
-        goto fail;
+        error_setg(&local_err, "Failed to start write tracking");
+        goto fail_with_bql;
     }
-    early_fail = false;
 
     /*
      * Start VM from BH handler to avoid write-fault lock here.
@@ -3726,21 +3724,22 @@ static void *bg_migration_thread(void *opaque)
     }
 
     trace_migration_thread_after_loop();
+    goto done;
+
+fail_with_bql:
+    bql_unlock();
 
 fail:
-    if (early_fail) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                MIGRATION_STATUS_FAILED);
-        bql_unlock();
-    }
+    /* local_err is guaranteed to be set when reaching here */
+    migrate_error_propagate(s, local_err);
+    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
 
-fail_setup:
+done:
     bg_migration_iteration_finish(s);
-
     qemu_fclose(fb);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-
     return NULL;
 }
 
-- 
2.50.1


