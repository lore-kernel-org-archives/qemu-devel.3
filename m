Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECB2E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGyT-0003Fm-72; Thu, 05 Dec 2024 13:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyR-0003FT-40
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyP-0001BD-7V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733424792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oU6sdpSxbjYvs7LHQsSk+DpOiW4s4G0ZXBz9eAqpeBw=;
 b=htlTQMXUvjKoyG+bx40177Vw6R9Vnp4jXowH3PkLExNg+OhzrzxglqpbaabfyF7+M9puU2
 MCp8qQytrhDudyYT5B3sZI90PhO/Wo/sRjwdkaWjPBY6IKNg+MGL9l9ZsUT/J6UO2Gox9W
 JIr6ioQJkjXgSUvzN4W/FRcDA0YBkuk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-hH_SJjogM4-wYlLdxRdZ9A-1; Thu, 05 Dec 2024 13:53:09 -0500
X-MC-Unique: hH_SJjogM4-wYlLdxRdZ9A-1
X-Mimecast-MFC-AGG-ID: hH_SJjogM4-wYlLdxRdZ9A
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b69c165661so138723085a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733424789; x=1734029589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oU6sdpSxbjYvs7LHQsSk+DpOiW4s4G0ZXBz9eAqpeBw=;
 b=jK0kBNf0/mEEQpccghWQdx7aGYARFUpPz+4xXej184xgWjZGOK6+D70UHL01VYruRQ
 GT1uuE2bkuCxFEMJ0W1mpa8GsJozaeIQccj5K6Q1qY0vB2lvlBH04kEBv6SFiDHV9i+H
 Ejj26cyd53rD46GVQ/Z/5pQkXnpqu4VL6UMGbuvodByahHrmUrLyk8LNbuNFjZCrk5qM
 zlFA+X4VGsW/SgVy+6x0QkQMVnkICr6Opl4AIYirjJ0tW1UgVtNKfMc/qD2RLVWtYZWX
 M4LIwawurL6aAP1E9N/RrL/kuv4vxMbi67FpHvBjSniHzBcexNE44qJfnW1JLWWEslGk
 4mwA==
X-Gm-Message-State: AOJu0YwhVyqRApNaSvnqwTg1seaWZrWtCw3ORg35Mvq2QBftSSEgTak6
 wM48pxUfRi1HsdP20FpUTRIU7lLMlpuKUShCcIFFfsMNKjPgJBsQCBthaOirsdEU47fjHvIb77l
 e/M804Agy4IFBxCyEQI1X2hteuGaQL+dvpJMaE18r9gs61T2w+UxFpkXb+iB8dVccJ6H0VyZQAW
 5CpGq+ru62Dip6Hz25DGkkfcCYFAoVtEawBA==
X-Gm-Gg: ASbGncuuaZfsogg0+Hsz4K7uF0Yeq9TzN6J8xJBjqtmA0hg0MbDAJf6sA/hjNtXtpNg
 mCE+o9j5vxaIitxLVHJNVlzwXYynt28ip7DnbF/x4Q80plEGd4GtaoEze8ntLwKxpMUdpxwKB6h
 +K/c2+Ak5ptjiDc4/StpgIyl/u75tcs/i2a1xa2nFpk/NNT+jBl+R690IQocFx2YNBefSUxxkvD
 +UQy2Ncriso9QtFTsI5Xhfte5xo8WpIBcJ3v/jrEfGZpJSjGmw1lr4+fFp6MbqSz1ybw7ofKRW+
 o1wrND//BjvV6RB9X5peYwmfSQ==
X-Received: by 2002:a05:620a:450b:b0:7b6:72f6:210c with SMTP id
 af79cd13be357-7b6bcac8d57mr39007285a.11.1733424788905; 
 Thu, 05 Dec 2024 10:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG5GTDZ3OwJZtx7+qJXvAp5F2tyrjCofpitciW/1NhQ8GIHNCw9DCxVdRfjJ0krV3EIwzv/Q==
X-Received: by 2002:a05:620a:450b:b0:7b6:72f6:210c with SMTP id
 af79cd13be357-7b6bcac8d57mr39004285a.11.1733424788437; 
 Thu, 05 Dec 2024 10:53:08 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a841b8sm86150485a.87.2024.12.05.10.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 10:53:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] migration/multifd: Allow to sync with sender threads only
Date: Thu,  5 Dec 2024 13:53:03 -0500
Message-ID: <20241205185303.897010-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205185303.897010-1-peterx@redhat.com>
References: <20241205185303.897010-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
  - Or to sync the threads but also with the destination side

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
 migration/multifd.h        | 16 +++++++++++++---
 migration/multifd-nocomp.c |  8 +++++++-
 migration/multifd.c        | 14 ++++++++------
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 50d58c0c9c..6b2f60a917 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -19,6 +19,15 @@
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
 
+typedef enum {
+    /* No sync request */
+    MULTIFD_SYNC_NONE = 0,
+    /* Sync on the sender threads without pushing messages */
+    MULTIFD_SYNC_THREADS,
+    /* Sync on the sender threads, meanwhile push "SYNC" message to the wire */
+    MULTIFD_SYNC_THREADS_AND_NOTIFY,
+} MultiFDSyncReq;
+
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 void multifd_send_channel_created(void);
@@ -28,7 +37,7 @@ void multifd_recv_shutdown(void);
 bool multifd_recv_all_channels_created(void);
 void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
-int multifd_send_sync_main(void);
+int multifd_send_sync_main(MultiFDSyncReq req);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
@@ -143,7 +152,7 @@ typedef struct {
     /* multifd flags for each packet */
     uint32_t flags;
     /*
-     * The sender thread has work to do if either of below boolean is set.
+     * The sender thread has work to do if either of below field is set.
      *
      * @pending_job:  a job is pending
      * @pending_sync: a sync request is pending
@@ -152,7 +161,8 @@ typedef struct {
      * cleared by the multifd sender threads.
      */
     bool pending_job;
-    bool pending_sync;
+    MultiFDSyncReq pending_sync;
+
     MultiFDSendData *data;
 
     /* thread local variables. No locking required */
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 55191152f9..f64c4c9abd 100644
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
@@ -356,7 +358,11 @@ int multifd_ram_flush_and_sync(void)
         }
     }
 
-    return multifd_send_sync_main();
+    /* File migrations only need to sync with threads */
+    req = migrate_mapped_ram() ?
+        MULTIFD_SYNC_THREADS : MULTIFD_SYNC_THREADS_AND_NOTIFY;
+
+    return multifd_send_sync_main(req);
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/multifd.c b/migration/multifd.c
index 498e71fd10..77645e87a0 100644
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
@@ -635,14 +635,16 @@ static void *multifd_send_thread(void *opaque)
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
+            if (req == MULTIFD_SYNC_THREADS_AND_NOTIFY) {
                 p->flags = MULTIFD_FLAG_SYNC;
                 multifd_send_fill_packet(p);
                 ret = qio_channel_write_all(p->c, (void *)p->packet,
@@ -654,7 +656,7 @@ static void *multifd_send_thread(void *opaque)
                 stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             }
 
-            qatomic_set(&p->pending_sync, false);
+            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
             qemu_sem_post(&p->sem_sync);
         }
     }
-- 
2.47.0


