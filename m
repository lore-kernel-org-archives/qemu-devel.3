Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CACCE77170
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgF-0003aS-O0; Thu, 05 Dec 2024 19:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgD-0003ZA-5D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMg9-0005ki-T9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=of03+bL8atAVQ8Sx7MKVcupnwu+B9QuMvu36EUykEjA=;
 b=NHOV1QF4BJsqGRRu1Z5+5vs11Lzxjjg8jSVL361T3IrIsldtisNt9xeWkpTfiD36XxzXbT
 k+hnnIlKjG968G4TdRac5EZY3ZLm/j9E8e7uC0OZpv6KVmLzQhHusnkTYA2JwY7LFEFLc8
 B100Hca/+6PWoc/QN9bH8OleU5cbeWQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-gVYBKsjnOAO6leXwWcEFDQ-1; Thu, 05 Dec 2024 19:58:43 -0500
X-MC-Unique: gVYBKsjnOAO6leXwWcEFDQ-1
X-Mimecast-MFC-AGG-ID: gVYBKsjnOAO6leXwWcEFDQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88cde9cedso28575866d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446722; x=1734051522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=of03+bL8atAVQ8Sx7MKVcupnwu+B9QuMvu36EUykEjA=;
 b=AIYWUoIHyEvMwCcVc5D/uSWcaJhgW4oicaWBkQnchzFDB91BvgOerB4HXbRVYrqR2L
 mKYJfKxNDzXX6TNF8KxLBAMzfGNU0EDLutNWlHTXGC18kisFvY4VBbw6+xsXZMe2umGb
 x6qnsoltrudSlI5zpDlIePsjye/PQK8z8LjxFoZqTBQW+yOEjZz/YMwOMnmBicf6EEQh
 Ox/JGuiRwpCx5SB3Yzv0BifExmZl2mxeIjNFuTAtZFCw7OEId406o/Tg3ZC+qE5Zcgf0
 TxiuocmMbXStxvGz1dyAG3Yaar0BY0pZq7Ejl0g71zu+1R+aTbEvGudIYoB6Zb6keQUE
 3vsg==
X-Gm-Message-State: AOJu0YxDoT9ZeDibxCCvi2pnwmTdfdqQc3hHYotb62FfdG8zvGmQw6oR
 TpoqzMTFyDxUYWx0agTmQ/0IttywsD6bOZXx7Na0XWifhuLHkAN67j9rbEy+gJ/wcdd2kKWrO9H
 hbF4DTdStAtz7B6iS7WC2MTb7DIs111bmr6CcQ/oP3+3Gr9RyCCzaeWynvbymr+8M/7RMG2n+Po
 9gIWaxiE4v0y5LkQLch11N/tfwuSTX+GimmQ==
X-Gm-Gg: ASbGncvRCTWaufHCucyN+GJXfqzKOdD2DssNITbofsR2liIR6TJtY3Xs4QI6/PWcs0X
 h2qYeitCm6nLPegHO3dX0mqz0dmfj4gXHEJSZcNvWFs/sgt+YKwSER2/7t5lVN5WM0ryK89Acjr
 oo2vsEQmrSISHNjCyAkF7Y9DgDchaAmaoWOPOtY3/OpYypaWO4WqeJ0OcQyPS1bKouVNjaEvIwy
 XaX1GZZ7fdIL1rStBSvxdQfSpRC1tBWFuLkgCeMLcBIhlvUc2DpqoKk9+vPTre/0mzltBpd6fyU
 sApipkAXcNYyOBdkTSC/sAnM+A==
X-Received: by 2002:a05:6214:226b:b0:6d8:80e8:d567 with SMTP id
 6a1803df08f44-6d8e7171871mr19171456d6.18.1733446722285; 
 Thu, 05 Dec 2024 16:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHqSvKx0Fdgv1BuBiyzutcmeiZvriVu0GpdIByj+uT5tm34qvjtlNTSxZPTwVTAIRnWWSCGw==
X-Received: by 2002:a05:6214:226b:b0:6d8:80e8:d567 with SMTP id
 6a1803df08f44-6d8e7171871mr19171086d6.18.1733446721867; 
 Thu, 05 Dec 2024 16:58:41 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:40 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 2/7] migration/multifd: Allow to sync with sender threads
 only
Date: Thu,  5 Dec 2024 19:58:29 -0500
Message-ID: <20241206005834.1050905-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Teach multifd_send_sync_main() to sync with threads only.

We already have such requests, which is when mapped-ram is enabled with
multifd.  In that case, no SYNC messages will be pushed to the stream when
multifd syncs the sender threads because there's no destination threads
waiting for that.  The whole point of the sync is to make sure all threads
flushed their jobs.

So fundamentally we have a request to do the sync in different ways:

  - Either to sync the threads only,
  - Or to sync the threads but also with the destination side.

Mapped-ram did it already because of the use_packet check in the sync
handler of the sender thread.  It works.

However it may stop working when e.g. VFIO may start to reuse multifd
channels to push device states.  In that case VFIO has similar request on
"thread-only sync" however we can't check a flag because such sync request
can still come from RAM which needs the on-wire notifications.

Paving way for that by allowing the multifd_send_sync_main() to specify
what kind of sync the caller needs.  We can use it for mapped-ram already.

No functional change intended.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h        | 19 ++++++++++++++++---
 migration/multifd-nocomp.c |  7 ++++++-
 migration/multifd.c        | 15 +++++++++------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..bd337631ec 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -19,6 +19,18 @@
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
 
+typedef enum {
+    /* No sync request */
+    MULTIFD_SYNC_NONE = 0,
+    /* Sync locally on the sender threads without pushing messages */
+    MULTIFD_SYNC_LOCAL,
+    /*
+     * Sync not only on the sender threads, but also push "SYNC" message to
+     * the wire (which is for a remote sync).
+     */
+    MULTIFD_SYNC_ALL,
+} MultiFDSyncReq;
+
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 void multifd_send_channel_created(void);
@@ -28,7 +40,7 @@ void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(void);
+int multifd_send_sync_main(MultiFDSyncReq req);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
@@ -143,7 +155,7 @@ typedef struct {
     /* multifd flags for each packet */
     uint32_t flags;
     /*
-     * The sender thread has work to do if either of below boolean is set.
+     * The sender thread has work to do if either of below field is set.
      *
      * @pending_job:  a job is pending
      * @pending_sync: a sync request is pending
@@ -152,7 +164,8 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
-    bool pending_sync;
+    MultiFDSyncReq pending_sync;
+
     MultiFDSendData *data;
 
     /* thread local variables. No locking required */
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..219f9e58ef 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -345,6 +345,8 @@ retry:
 
 int multifd_ram_flush_and_sync(void)
 {
+    MultiFDSyncReq req;
+
     if (!migrate_multifd()) {
         return 0;
     }
@@ -356,7 +358,10 @@ int multifd_ram_flush_and_sync(void)
         }
     }
 
-    return multifd_send_sync_main();
+    /* File migrations only need to sync with threads */
+    req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
+
+    return multifd_send_sync_main(req);
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..2248bd2d46 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -523,7 +523,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(void)
+int multifd_send_sync_main(MultiFDSyncReq req)
 {
     int i;
     bool flush_zero_copy;
@@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
          */
-        assert(qatomic_read(&p->pending_sync) == false);
-        qatomic_set(&p->pending_sync, true);
+        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
+        qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -635,14 +635,17 @@ static void *multifd_send_thread(void *opaque)
              */
             qatomic_store_release(&p->pending_job, false);
         } else {
+            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
+
             /*
              * If not a normal job, must be a sync request.  Note that
              * pending_sync is a standalone flag (unlike pending_job), so
              * it doesn't require explicit memory barriers.
              */
-            assert(qatomic_read(&p->pending_sync));
+            assert(req != MULTIFD_SYNC_NONE);
 
-            if (use_packets) {
+            /* Only push the SYNC message if it involves a remote sync */
+            if (req == MULTIFD_SYNC_ALL) {
                 p->flags = MULTIFD_FLAG_SYNC;
                 multifd_send_fill_packet(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
@@ -654,7 +657,7 @@ static void *multifd_send_thread(void *opaque)
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             }
 
-            qatomic_set(&p->pending_sync, false);
+            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
             qemu_sem_post(&p->sem_sync);
         }
     }
-- 
2.47.0


