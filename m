Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69C0CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwVV-0001rb-OQ; Fri, 31 Oct 2025 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwVA-0001bj-Rs
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:17:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwV4-000262-4d
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:17:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so21515525e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945448; x=1762550248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+hL1p9xHiljbn6FnSyNn5FKbD53Ap2Pki2ai6nICBPA=;
 b=j3kwFGwPk9Aa45WdOq4MDSPUTgw1zztNtKn3SS4UkmArxArewOBZyCS0F3rxS48Mob
 DAV+3Kp336d9LTfZtzq4S/AEmNTl2Qs2WpI42zXGaqOG+tsR/YGnbpyhd6nJCWjSvpwL
 JdH0SDCiJi8WKRVJEcQIRYcZBff5tgiSTml7LZzNuTC7ojwKDAphhywLTJWPDOUGxi/q
 ptrlt7thft+Si7K7dzah1bEYg3bg86CaV5sQ/4MNcjy3+1FwY/xXmYEEJ97tGMPOlxxB
 EpL+PouCts24m3Zxq0hcc0z800oVU8r4TmY9XrAjCq62JccSdQuPOp6X9tbh86DNE55n
 owGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945448; x=1762550248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hL1p9xHiljbn6FnSyNn5FKbD53Ap2Pki2ai6nICBPA=;
 b=ZUA0bBxelf9eFKVjHbo7jIcwsAPUGTfr/tprv/D0r6ZtWNAjhXqVSKaRGIzSs/ll7W
 6KAtjls00VTGauU9g/pPiHw6I6uLr3vbwQdh0LcrA+23P8c1Fa33B9ZrdSW68A2K+44e
 RtzoWXCYcO7Djimwjgv3m8l08z9pmcNFyRJ6swCmRU+7Khu+2QJRSvxQagkqHPa1fCxX
 jtBDEtugHOoSqTkv8Uu6BYX1vkHrzk3vhluL0uZEzzmTxXmoU4B6ryYlV2wKue1ZNzAM
 TD6S9Ii/yO/ZE4AJSijhJocCezwEqb19/jLxNykUuD0RqT78muA3ctJFrZLV0Nqn1uJf
 6PXg==
X-Gm-Message-State: AOJu0Yx0tt4JDi7+S3N5ZYnCxBP102lywJcIu2ayC+EcQIOZQRJhz/8V
 Jn21CvUol0SxgNJ7kPPvneZfF9h0oj3CuKke43o7WLr+yzO4B1yQ9anZBFI3sl8mxHrigZVZGwu
 P6hkFXkRgOA==
X-Gm-Gg: ASbGncsDU2DFkVSmt38KEYYd7Qt0NTZKSBpNX2xHAVTUf1M13s25kIbSyCDlHAy1wQg
 k9luZPG+bcsodArn5S8BzH89rnHAfSoXHSMZ56uuF1+lQv0WbaBRrjUMF9Bqeo3AWK00PdnDIer
 3zl/R7QmUSSIwOXbhQ2jEgMqag2LRYzOEMeDVOCmTfr5UTkTonUHim+50MkK8vVrXt5nLC8PYJY
 VifsOdaxw4zEMpEozlcjOOJFp2/nQEi1a3h/IingN5uwfUuE11Xcis2FgGEq+PtX7/icI9bQ2xE
 AgYnb5gWiJ0ldrC4scs7C/2MYwBk59gpTC92YYSV3axIwKh6ePhaBcXTfXFMUcUw2uhzbcrCNWl
 e+PxPre+QwjEssw33WNFoPxePt4AUIoT/gbZC0YSyHjPHZycJNu1gHaZLCqQMVJgtCZ5vsvDtmZ
 12GlDofppyvDi7tT9u1MnMbUoxQwsWqiZhvHijcpMYAC95hiMlyQRK7He8wjbY1ciA
X-Google-Smtp-Source: AGHT+IEMHz1YqJhZGGsNzIfMUO1GwtweBBw0SE+LjfqukBDKL57lfe5NC2HubPFy4Q5JqBUCRFrRNA==
X-Received: by 2002:a05:600c:19d4:b0:475:dd59:d8da with SMTP id
 5b1f17b1804b1-477308c8e97mr45147505e9.40.1761945448296; 
 Fri, 31 Oct 2025 14:17:28 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383ba6sm14941555e9.10.2025.10.31.14.17.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:17:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] bql: Fix bql_locked status with condvar APIs
Date: Fri, 31 Oct 2025 22:15:13 +0100
Message-ID: <20251031211518.38503-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250904223158.1276992-1-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/main-loop.h  | 18 ++++++++++++++++++
 util/qemu-thread-common.h |  7 +++++++
 stubs/iothread-lock.c     |  9 +++++++++
 system/cpus.c             | 14 ++++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 4e2436b1968..0d55c636b21 100644
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
+ * bql_update_status:
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
index 2af6b120853..09331843ba9 100644
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
index 6050c081f53..c89c9c7228f 100644
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
index 74f5a5bd4e2..ef2d2f241fa 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -524,6 +524,18 @@ bool qemu_in_vcpu_thread(void)
 
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
@@ -564,14 +576,12 @@ void bql_lock_impl(const char *file, int line)
 
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
2.51.0


