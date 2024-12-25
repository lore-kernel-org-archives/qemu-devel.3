Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70031E7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKC2-000716-GC; Wed, 25 Dec 2024 00:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKC0-00070j-VI
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:24 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKBz-0008Hr-5g
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:24 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef89dbd8eeso4429834a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105462; x=1735710262;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b7RpjOm/DRzNyiYtGsOFcg7Tby9rNOjO2BBVF9kv5qg=;
 b=ZbubS6a2P/9VicKMcLQKuC0qHJ0RXTJAWdohjkPZG2yafMGE0/SB+Ufq+TJnDFMDsM
 EQmfZiNSJrp6yD+thi/UK96dF/w2QDdOEJtndZHSZdcihMlG57UgFXuuSUDwuv63dBOT
 ncFi7h8Djs+NsmBja3Ngf34rbrdsU+2oVrC9mJdDd7ClWnWd2tKyUa8UuDXUxTOwpxXh
 /eD/CpSmLnizmVgh90T+H6ohXwcFjvZ5gXkctA2P3+4wxcG0uNAWkCmhGjOstrhNNf56
 CV4y3fvXtJLeUuFvn3HZBcayKhvoAZz/W+vaps6IdGIgpw8piJZpOrwsJOhVaBW/OuhC
 9/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105462; x=1735710262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7RpjOm/DRzNyiYtGsOFcg7Tby9rNOjO2BBVF9kv5qg=;
 b=KIq1aNAPiy9LaTvr51FCzbSemYVT1vbSLs/IAjKuZcw5m8hNiDJzSjDTb3i4aLhZxP
 sdKJq1rz39i9UoTuW92ZokjLSD+zr1UnwmK8ToRXPDLxrnXy2StmI3XGvKTdD+B0xBeG
 xlju0kZK1YC7+nCbAVTJthMdpKh+tecCdYKRsUGOVZc2JdHrQ2AU6NVPPiePa9nEXtT2
 I6qU2omutkhSUArALTIq1ceD6eO0ArDs3Nwny7grytycRUEPMMlMt/LxEM3Y72VsAw8O
 zWKa9Jd/Ab92OdlkvKR5nP/WxqXPxa27mcMfsA7LnI236iZ4w77UkbRYSpxpua3JnwTY
 j8CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ASUxQxS085a0EQRpGfiysbmBodRJYv3RRUoRa8vaw/mYHk9dTUxav7iJFsWf2G8M3ZcfVO5oGOJ8@nongnu.org
X-Gm-Message-State: AOJu0YxWqmsqldyTbD+ZgF2kXnzxUczMK/KFQAprN1cdyc/AoOubR9Lt
 CLnaMXvJ7U69+xjzjavin6uad/jWnAvtYO2GL3KI/Wz4czKhzAHGAoDDSLjkb3U=
X-Gm-Gg: ASbGncsBYYyO4+NBkC9dO1pwjJcNBfH+yWvQIQK0vLHoOXxsSfHGacBFgfCUrot1ae6
 DSW6o08BqgaqfE0SWxSnt3aruMs6uVpnkIK7Q+v/54ape2y5rMdU0ftC/KyfXVTVQW7HBsLvA5X
 d8L5/vbjifXmSoZAQcdO2BW/KGyH2ToNf60m/C2N2YTsyjvH1PNjFAv17wGV2XhhTG+k1JPDFyh
 UCGH9XaUJDONv0Z9S2NG5FwH9jQvogmRGOXgOycc6neIMzPVTB1Xf/M+ljh
X-Google-Smtp-Source: AGHT+IGa2l6dwZz0j525YolHjw3IJJJPuYTmsAG3f7lXGhmQOcauWO7gJ255qeBXcHHq2uDXWiRqHQ==
X-Received: by 2002:a17:90b:54d0:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2f452e4a7f6mr28970252a91.20.1735105461854; 
 Tue, 24 Dec 2024 21:44:21 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f2ee26b131sm14653894a91.44.2024.12.24.21.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:13 +0900
Subject: [PATCH 1/8] futex: Check value after qemu_futex_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-1-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

futex(2) - Linux manual page
https://man7.org/linux/man-pages/man2/futex.2.html
> Note that a wake-up can also be caused by common futex usage patterns
> in unrelated code that happened to have previously used the futex
> word's memory location (e.g., typical futex-based implementations of
> Pthreads mutexes can cause this under some conditions).  Therefore,
> callers should always conservatively assume that a return value of 0
> can mean a spurious wake-up, and use the futex word's value (i.e.,
> the user-space synchronization scheme) to decide whether to continue
> to block or not.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/futex.h              |  9 +++++++++
 tests/unit/test-aio-multithread.c |  4 +++-
 util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 91ae88966e12..f57774005330 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
     qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
 }
 
+/*
+ * Note that a wake-up can also be caused by common futex usage patterns in
+ * unrelated code that happened to have previously used the futex word's
+ * memory location (e.g., typical futex-based implementations of Pthreads
+ * mutexes can cause this under some conditions).  Therefore, callers should
+ * always conservatively assume that it is a spurious wake-up, and use the futex
+ * word's value (i.e., the user-space synchronization scheme) to decide whether
+ * to continue to block or not.
+ */
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 08d4570ccb14..8c2e41545a29 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)
     prev = qatomic_xchg(&mutex_head, id);
     if (prev != -1) {
         qatomic_set(&nodes[prev].next, id);
-        qemu_futex_wait(&nodes[id].locked, 1);
+        while (qatomic_read(&nodes[id].locked) == 1) {
+            qemu_futex_wait(&nodes[id].locked, 1);
+        }
     }
 }
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b2e26e21205b..eade5311d175 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -428,17 +428,21 @@ void qemu_event_wait(QemuEvent *ev)
 
     assert(ev->initialized);
 
-    /*
-     * qemu_event_wait must synchronize with qemu_event_set even if it does
-     * not go down the slow path, so this load-acquire is needed that
-     * synchronizes with the first memory barrier in qemu_event_set().
-     *
-     * If we do go down the slow path, there is no requirement at all: we
-     * might miss a qemu_event_set() here but ultimately the memory barrier in
-     * qemu_futex_wait() will ensure the check is done correctly.
-     */
-    value = qatomic_load_acquire(&ev->value);
-    if (value != EV_SET) {
+    while (true) {
+        /*
+         * qemu_event_wait must synchronize with qemu_event_set even if it does
+         * not go down the slow path, so this load-acquire is needed that
+         * synchronizes with the first memory barrier in qemu_event_set().
+         *
+         * If we do go down the slow path, there is no requirement at all: we
+         * might miss a qemu_event_set() here but ultimately the memory barrier
+         * in qemu_futex_wait() will ensure the check is done correctly.
+         */
+        value = qatomic_load_acquire(&ev->value);
+        if (value == EV_SET) {
+            break;
+        }
+
         if (value == EV_FREE) {
             /*
              * Leave the event reset and tell qemu_event_set that there are
@@ -452,7 +456,7 @@ void qemu_event_wait(QemuEvent *ev)
              * like the load above.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                return;
+                break;
             }
         }
 

-- 
2.47.1


