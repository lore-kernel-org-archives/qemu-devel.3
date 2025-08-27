Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFz-0006sP-70; Wed, 27 Aug 2025 17:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFd-0006iu-Da
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFX-0006rO-7M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWSJYlk138FmAFVvxr4mdnjck2zH0Iu2R9tmAoocuGM=;
 b=JEFdfcYujQTCEfl8hxb/qZ+FiXKjGt99cyDqqYl26dDsWanwmj5zMQb67LiHoITcHuCs9c
 lurzh2ziYebVUHyRikFKeUuwrWExcxakk7w0Oo5Urbnc5F5npyvJbZRdQuQAgamPcGBzGy
 pGSxO62/oKrXcyQTJBqPByytaWUyQns=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-s1_5xZwVPLKBQ71b0HpkYA-1; Wed, 27 Aug 2025 17:00:04 -0400
X-MC-Unique: s1_5xZwVPLKBQ71b0HpkYA-1
X-Mimecast-MFC-AGG-ID: s1_5xZwVPLKBQ71b0HpkYA_1756328404
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71d605339dbso3010507b3.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328403; x=1756933203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWSJYlk138FmAFVvxr4mdnjck2zH0Iu2R9tmAoocuGM=;
 b=Et2hHt3zautpasWgBYWDbZKcebA5YEASGK2SfZv7CJXhr/g08qO8uT/SDAKif+uvHD
 YyJ7EdgxVncOMQjb+Ji6HD/cJuF3pWOnI8Yso0rH7Hh/tu993SiUqfFSZZI5wzjLca2R
 SG6EQPu/ape+SRst0BFYVvvrNfSAxikKORIbEKicksoo3M6XJTkTvM4vPUq8/uk6Hxg7
 /btSv3/ldw9OChYjhuOkNVogh9AKoPMuW09eY+0YDSx/v1lQP9fjVecXhWXQTfj1pR7l
 JP2zw75lOz/rQLirLbeIE6iAIjZc4EclTtOaNo5A6+9AMorPR5bf95wE79czxLpLRrVR
 0K/g==
X-Gm-Message-State: AOJu0YwGZtcWqyFgBN7J4O8c3sK0taEmhZgTrmfFe5pfNr6gNYdYgpeL
 uc39UqDvdnohjRXV+VU+vjkkfjsfwKkeh/k1t3/cSfyHFxzqN7zjZIUeR81J6+qckdxvaxRwGe+
 Y7J3vq+S4WG0JYkXStnmPQB4YsEiwoMnw1ZKPhG4NixH0/VlSyRBlUxmLk4QqIiQtg3IulpFGKC
 OITCEd7xcyHo3vpOXsirUMEMTOlwNembb3HEV0GQ==
X-Gm-Gg: ASbGncukBQ5uU8GunxYL4adu+j6Yniicjl5hMkrIyVjZ1KZA9P4ZKeqh2X4dhALyW/3
 18JdiVGC4gzl+4BgfqP1PsUfSBCmA35KHWHGKZ1HCng3XEbXjvusQqN2+4o57bix8UIUX1tEeJI
 nWEM9KNLXOTsclUFIfXpdTA4tbaj4A7+KHORx3uMaUV37qSdqmvbao+T976Ev3C40Da+XxiZ7L+
 YalX6kJXdirolDuIV9CbHLfTD/Qxd8JkooUkNtbmWn5jWSKXd/aomzmZPR2TAJ/BZEBUv0/IrzQ
 JCVpulh0j2fxksZAGwQmsf4rTXTDkLiuPqPyy49VrcIVtAMZFPIGQQJoKcdOyQT2REvZh5DoBR0
 1PDqqsXsGRLqBmgcnIvg=
X-Received: by 2002:a05:6902:110e:b0:e95:34cf:9b55 with SMTP id
 3f1490d57ef6-e9534cfa905mr19201920276.12.1756328403472; 
 Wed, 27 Aug 2025 14:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkpx0budwaHrDidhF7vzeiefKfIffbE7jmdijfNTP7rqs5nhQI/GsOctMgsj45yLrZwawenQ==
X-Received: by 2002:a05:6902:110e:b0:e95:34cf:9b55 with SMTP id
 3f1490d57ef6-e9534cfa905mr19201850276.12.1756328402854; 
 Wed, 27 Aug 2025 14:00:02 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.14.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 14:00:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 6/9] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
Date: Wed, 27 Aug 2025 16:59:45 -0400
Message-ID: <20250827205949.364606-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
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

Now after threadified dest VM load during precopy, we will always in a
thread context rather than within a coroutine.  We can remove this path
now.

With that, migration_started_on_destination can go away too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 102 +++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 61 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2b995513aa..7751262460 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,7 +29,6 @@
 #include "qemu/rcu.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
-#include "qemu/coroutine.h"
 #include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
@@ -357,13 +356,6 @@ typedef struct RDMAContext {
     /* Index of the next RAMBlock received during block registration */
     unsigned int    next_src_index;
 
-    /*
-     * Migration on *destination* started.
-     * Then use coroutine yield function.
-     * Source runs in a thread, so we don't care.
-     */
-    int migration_started_on_destination;
-
     int total_registrations;
     int total_writes;
 
@@ -1353,66 +1345,55 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     struct rdma_cm_event *cm_event;
 
     /*
-     * Coroutine doesn't start until migration_fd_process_incoming()
-     * so don't yield unless we know we're running inside of a coroutine.
+     * This is the source or dest side, either during precopy or
+     * postcopy.  We're always in a separate thread when reaching here.
+     * Poll the fd.  We need to be able to handle 'cancel' or an error
+     * without hanging forever.
      */
-    if (rdma->migration_started_on_destination &&
-        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE &&
-        qemu_in_coroutine()) {
-        yield_until_fd_readable(comp_channel->fd);
-    } else {
-        /* This is the source side, we're in a separate thread
-         * or destination prior to migration_fd_process_incoming()
-         * after postcopy, the destination also in a separate thread.
-         * we can't yield; so we have to poll the fd.
-         * But we need to be able to handle 'cancel' or an error
-         * without hanging forever.
-         */
-        while (!rdma->errored && !rdma->received_error) {
-            GPollFD pfds[2];
-            pfds[0].fd = comp_channel->fd;
-            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
-            pfds[0].revents = 0;
-
-            pfds[1].fd = rdma->channel->fd;
-            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
-            pfds[1].revents = 0;
-
-            /* 0.1s timeout, should be fine for a 'cancel' */
-            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
-            case 2:
-            case 1: /* fd active */
-                if (pfds[0].revents) {
-                    return 0;
-                }
+    while (!rdma->errored && !rdma->received_error) {
+        GPollFD pfds[2];
+        pfds[0].fd = comp_channel->fd;
+        pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+        pfds[0].revents = 0;
+
+        pfds[1].fd = rdma->channel->fd;
+        pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+        pfds[1].revents = 0;
+
+        /* 0.1s timeout, should be fine for a 'cancel' */
+        switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
+        case 2:
+        case 1: /* fd active */
+            if (pfds[0].revents) {
+                return 0;
+            }
 
-                if (pfds[1].revents) {
-                    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
-                        return -1;
-                    }
+            if (pfds[1].revents) {
+                if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
+                    return -1;
+                }
 
-                    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
-                        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
-                        rdma_ack_cm_event(cm_event);
-                        return -1;
-                    }
+                if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
+                    cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                     rdma_ack_cm_event(cm_event);
+                    return -1;
                 }
-                break;
+                rdma_ack_cm_event(cm_event);
+            }
+            break;
 
-            case 0: /* Timeout, go around again */
-                break;
+        case 0: /* Timeout, go around again */
+            break;
 
-            default: /* Error of some type -
-                      * I don't trust errno from qemu_poll_ns
-                     */
-                return -1;
-            }
+        default: /* Error of some type -
+                  * I don't trust errno from qemu_poll_ns
+                  */
+            return -1;
+        }
 
-            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
-                /* Bail out and let the cancellation happen */
-                return -1;
-            }
+        if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
+            /* Bail out and let the cancellation happen */
+            return -1;
         }
     }
 
@@ -3817,7 +3798,6 @@ static void rdma_accept_incoming_migration(void *opaque)
         return;
     }
 
-    rdma->migration_started_on_destination = 1;
     migration_fd_process_incoming(f);
 }
 
-- 
2.50.1


