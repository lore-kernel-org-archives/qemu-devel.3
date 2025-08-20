Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C285ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopm5-0007ox-6Q; Wed, 20 Aug 2025 16:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uopm3-0007oh-1c
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uopm1-0001da-BM
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755723068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IRC0nGkCk8ki5GSJSzFl5yax48hZFIql2OHvwhdQRck=;
 b=gh4maqsLJRU+jGBbtn57Gs8mMtFbq+DnTSqQocoQ9TvzScZvTuoaGdvr+VOlj0dQgGGDY1
 hgMRVOR81p4MwYmjgr1J9L4WL35j8d/Jb6dkZvvNuBUGA0cIgqUGSQgbYz7Qc1e2TF0S2m
 LR75qNsKhEwWrkiO5FXDOQfZFikavfE=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-b2nj0-kgPGaCNoSIiVfRmg-1; Wed, 20 Aug 2025 16:51:07 -0400
X-MC-Unique: b2nj0-kgPGaCNoSIiVfRmg-1
X-Mimecast-MFC-AGG-ID: b2nj0-kgPGaCNoSIiVfRmg_1755723066
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e950984545fso106434276.0
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755723066; x=1756327866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRC0nGkCk8ki5GSJSzFl5yax48hZFIql2OHvwhdQRck=;
 b=j98SnFJfNNOD7jCCeXD1k+8tVFU+ltTD1RIjmBlX57IFABbVN8puseaMmJ9yyNz85F
 ltZ7UZajaMSlUCJcVt+Icwz2Rq+CkF2cD4t3DnkLMw8MA6bx7KYC9rrbWruY+kob9nsL
 nWTW4vYr9sGmPsRHPbKAVPlGtS36G4GbQd2QYRp3uDeHD6haJ2O4y6drj2+bt7HTWT8G
 ZKvwx1uCZh16Nfpqna6WYVQQ0LIQxBvImA9O3R4TxTjwL923GW7OM58/ZSNlmPYsleox
 hV1mNLSbSlSRaQGojqdgFcbZhK+aOsDA6eIx7wtLtSc88hj4elub0XVvJzTYi9k1NA/J
 iY2w==
X-Gm-Message-State: AOJu0YydMMBMBL7874TAb57I5yidpeFgzC4ldh+HTO1aY7Z2tw4VyhB7
 ywkb1ZxC7rEBNM1+pQmayhGryDS3OhG1ZqVQnYzNA7urdBK51dOrLULCZ+DCoxpT39lU3fxJnSK
 WBaYRvAxIKgbYt5s6CdibgadIzD66kgXW/IzpfNyPT+zrrwXx5TmkrkZaNVoxP3729ZNJr1yeXZ
 hZmIU7PXhhuoNcGLS1DmQn6imAZcmkp28Hm/7A8g==
X-Gm-Gg: ASbGnctvyew13d7w5Sz95v9ohoyFWfZGEZMpF5WWaesSmrkEVGTrA+DPpjUYQLwOvzq
 VG+k7DcnLhjZo+L7bTdpkj65HjUkpBeW7glWqOP8avGO33rlanTur+ryMYZ0eqw+fZLwCfyKujw
 R1XJrH018EKqKqwL79GEKQy7Cm5CgkeqepgjwYNLXlgoU6M7ghLNQ+EsaFHE33mHoIKknFaZBmQ
 AUNe7xFPc3vA4kvlXEJ1X3quO+M6eNf/PET8hspxr/t9KX3C+H2LMa5FazYU88gL/IEXx3oXsLY
 w3Ui0zL6WE3Y1nuCrpUEoohhGjRUNw==
X-Received: by 2002:a05:6902:188d:b0:e90:5a65:24b7 with SMTP id
 3f1490d57ef6-e95088c5419mr267428276.11.1755723065877; 
 Wed, 20 Aug 2025 13:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuhAFxthbbcI8o73XucTNLQZxnpD1nmw/aOVfCptlcfw76djej1VHDVTsyWKEgI0K1y6Qrag==
X-Received: by 2002:a05:6902:188d:b0:e90:5a65:24b7 with SMTP id
 3f1490d57ef6-e95088c5419mr267376276.11.1755723065282; 
 Wed, 20 Aug 2025 13:51:05 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e94ee7b9ec3sm1566404276.17.2025.08.20.13.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 13:51:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH RFC] bql: Fix bql_locked status with condvar APIs
Date: Wed, 20 Aug 2025 16:50:51 -0400
Message-ID: <20250820205051.24424-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
whether the current thread is holding the BQL lock.

It's a pretty handy variable.  Function-wise, QEMU have codes trying to
conditionally take bql, relying on the var reflecting the locking status
(e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look at
the variable (in reality, co_tls_bql_locked), to see which thread is
currently holding the bql.

When using that as a debugging facility, sometimes we can observe multiple
threads holding bql at the same time. It's because QEMU's condvar APIs
bypassed the bql_*() API, hence they do not update bql_locked even if they
have released the mutex while waiting.

It can cause confusion if one does "thread apply all p co_tls_bql_locked"
and see multiple threads reporting true.

Fix this by moving the bql status updates into the mutex debug hooks.  Now
the variable should always reflect the reality.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/main-loop.h  | 18 ++++++++++++++++++
 util/qemu-thread-common.h |  7 +++++++
 stubs/iothread-lock.c     |  9 +++++++++
 system/cpus.c             | 14 ++++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 4e2436b196..44fb430f5b 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -270,6 +270,24 @@ void rust_bql_mock_lock(void);
  */
 bool bql_locked(void);
 
+/**
+ * mutex_is_bql:
+ *
+ * @mutex: the mutex pointer
+ *
+ * Returns whether the mutex is the BQL.
+ */
+bool mutex_is_bql(QemuMutex *mutex);
+
+/**
+ * set_bql_locked:
+ *
+ * @locked: update status on whether the BQL is locked
+ *
+ * NOTE: this should normally only be invoked when the status changed.
+ */
+void bql_update_status(bool locked);
+
 /**
  * bql_block: Allow/deny releasing the BQL
  *
diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
index 2af6b12085..09331843ba 100644
--- a/util/qemu-thread-common.h
+++ b/util/qemu-thread-common.h
@@ -14,6 +14,7 @@
 #define QEMU_THREAD_COMMON_H
 
 #include "qemu/thread.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 
 static inline void qemu_mutex_post_init(QemuMutex *mutex)
@@ -39,6 +40,9 @@ static inline void qemu_mutex_post_lock(QemuMutex *mutex,
     mutex->line = line;
 #endif
     trace_qemu_mutex_locked(mutex, file, line);
+    if (mutex_is_bql(mutex)) {
+        bql_update_status(true);
+    }
 }
 
 static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
@@ -49,6 +53,9 @@ static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
     mutex->line = 0;
 #endif
     trace_qemu_mutex_unlock(mutex, file, line);
+    if (mutex_is_bql(mutex)) {
+        bql_update_status(false);
+    }
 }
 
 #endif
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 6050c081f5..c89c9c7228 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -34,3 +34,12 @@ void bql_block_unlock(bool increase)
     assert((new_value > bql_unlock_blocked) == increase);
     bql_unlock_blocked = new_value;
 }
+
+bool mutex_is_bql(QemuMutex *mutex)
+{
+    return false;
+}
+
+void bql_update_status(bool locked)
+{
+}
diff --git a/system/cpus.c b/system/cpus.c
index 256723558d..0bf677c4a2 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -517,6 +517,18 @@ bool qemu_in_vcpu_thread(void)
 
 QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
 
+bool mutex_is_bql(QemuMutex *mutex)
+{
+    return mutex == &bql;
+}
+
+void bql_update_status(bool locked)
+{
+    /* This function should only be used when an update happened.. */
+    assert(bql_locked() != locked);
+    set_bql_locked(locked);
+}
+
 static uint32_t bql_unlock_blocked;
 
 void bql_block_unlock(bool increase)
@@ -557,14 +569,12 @@ void bql_lock_impl(const char *file, int line)
 
     g_assert(!bql_locked());
     bql_lock_fn(&bql, file, line);
-    set_bql_locked(true);
 }
 
 void bql_unlock(void)
 {
     g_assert(bql_locked());
     g_assert(!bql_unlock_blocked);
-    set_bql_locked(false);
     qemu_mutex_unlock(&bql);
 }
 
-- 
2.50.1


