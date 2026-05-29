Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649E9CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4rx-0004vj-2E; Fri, 29 May 2026 17:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qt-0003XB-Qw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qp-000330-E0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36c68964315so114378a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090475; x=1780695275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEcYVF/Udwni2eBZbL7aCWlWBBoaU7ySIMUFrl8fTXY=;
 b=EjQSpE7ZgS51BmMlSGUpqHs3rNyj7UhKrDGNQeurdTQe1QX7+Wcz8eCtnt4tmS81Uk
 g7gwuyAcyzz/YiDPju7ZSIPSdh/8ADK388ylqhpNeXAr2tNw3JYhtx9SpFaL1p9uipek
 B9DSEGMRyA7gmJgre3iS2YbHrtGew+gBpKHOV1/ipgSPpxXqyRSI/+cH7d+XlIIT73Aq
 0iicivQHHGrsPIFB9MdJBn6HC4tNItCzknxRopFMx+E9LG+pS5GxkNy8KY0K6Pz/jMiz
 W1P44uOh5HNH4DekkBmX+bWTirWo31Wq/zkQwUZjIsZKXxT/WL80JDyDUH8rDl58B8OA
 6pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090475; x=1780695275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jEcYVF/Udwni2eBZbL7aCWlWBBoaU7ySIMUFrl8fTXY=;
 b=EBIHciYYILzSuztfeRLss/51pBLHq6thxZZROrBuz8j4Xgus3ZAAE88FoZMnDXHBra
 t1fx4u5xmjRjYWsH3+XaTTpYPejafF6B8HlE5fTUbiebrTuOcDDPS2CsyLZ8OAqGze9G
 ++QW8Bo5cKqr7OZ/k8twAeI+emUTyep9jyTwi+7l0zX0N4t7Y1JelvpnwQsw4Ixw4iZe
 82EcUXmyFGp/oQEKGiexoFQb73n7afs9mRG0Q0Vnw2/DfizoOclXrZIsx+h/xBzPB3xt
 xmqoX8FG79M6/uBaesKq+t9+I3+OBQt4PS/e70FnBalWr175pM6Y35XCtX+iRP2OI0w3
 tBIg==
X-Gm-Message-State: AOJu0Yy281+8hwt5uNEI3m0khsePXX3ryFq0KDzS472UsB9UpXkr2ssx
 XlX1hse13aoJk20JIewLDhrLrr4FbJ5rZp9QhCgXcQLvmKta+asU6PctYl7dRqfyz50=
X-Gm-Gg: Acq92OFbGEIXYxxYis37my3STOwvu0dMmHPOZ85gJSdXxInNu0eoZ/c61EgE8p3wjbQ
 P82NS/p5786CpektyDXmYoUQHkXavyb1bWJStKR/VmR4KWjZmD01LQ9apmZxaSIewztUGYfLusM
 4kXqtDHARjeh2ZOCTnoeVaVsWgbcWXLkw7HuyEVYpjqTmqjrHKTvOTpQ5mbl/r8a3wKzsiVjwJc
 nrgohx1FxDq5QpiiT4grO6hzEKDl0FaR3qX2UVzsQNM3c3KHULVClxEWiYKBqBRJOFLnZI2SXOh
 38+TAZXD2q2wiATS9MChak8EOVZlZXDK+7tKA6xsZi8V1j4JRgdgfdg1nb39Y1oVnYW0VtVUVl4
 OwKYw6fZdkVkEBx3oY6CSNHRRq4KMUtuwUJCF9tZJoaXkU5SuPmxO0Ba5HZ9Pwbqtxx7XUmLP3F
 cdm9clDxRmd8f39bQXniit0nVcnudHQR9rSFcYN8BPDyT5l6q6zxa8Hea8cdXrtXksiyejXSxmH
 g==
X-Received: by 2002:a05:6a20:9f0b:b0:3a2:dbaa:82ee with SMTP id
 adf61e73a8af0-3b427bc4170mr1196675637.9.1780090474660; 
 Fri, 29 May 2026 14:34:34 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:34 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 15/15] iothread: simplify API by merging
 iothread_get_aio_context variants
Date: Sat, 30 May 2026 05:33:21 +0800
Message-ID: <20260529213321.96271-16-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Simplify the interface by merging iothread_ref_and_get_aio_context()
into iothread_get_aio_context(). The updated function now requires a
'holder' parameter, ensuring that every retrieval of an AioContext for
long-term use is automatically registered in the IOThread's holder list.

Update all callers across block, virtio, scsi, net, and monitor
subsystems to match the new signature. This cleanup reduces code
redundancy and improves the reliability of IOThread introspection.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c           | 5 ++---
 hw/block/dataplane/xen-block.c  | 4 ++--
 hw/block/virtio-blk.c           | 4 ++--
 hw/scsi/virtio-scsi-dataplane.c | 4 ++--
 hw/vfio-user/proxy.c            | 3 +--
 hw/virtio/iothread-vq-mapping.c | 3 +--
 hw/virtio/virtio-balloon.c      | 2 +-
 include/system/iothread.h       | 6 +++---
 iothread.c                      | 9 ++-------
 monitor/monitor.c               | 2 +-
 net/colo-compare.c              | 2 +-
 11 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b6c07f69b5..acd061e86e 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -146,7 +146,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             .u.block_node.node_name = (char *)holder_name,
         };
 
-        new_ctx = iothread_ref_and_get_aio_context(iothread, &holder);
+        new_ctx = iothread_get_aio_context(iothread, &holder);
         multithread_count = 1;
         local_iothreads = g_new0(IOThread *, 1);
         local_iothreads[0] = iothread;
@@ -190,8 +190,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 goto fail;
             }
             local_iothreads[i] = iothread;
-            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
-                                                                     &holder);
+            multithread_ctxs[i++] = iothread_get_aio_context(iothread, &holder);
         }
         assert(i == multithread_count);
     }
diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index b5bf8d359f..46bfd62f5a 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -628,8 +628,8 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
         };
 
         dataplane->iothread = iothread;
-        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
-                                                          &io_holder);
+        dataplane->ctx = iothread_get_aio_context(dataplane->iothread,
+                                                  &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index d8dc1dd136..d1d2bd7025 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1502,8 +1502,8 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
             .u.qom_object.qom_path = (char *)path,
         };
-        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(conf->iothread,
+                                                   &io_holder);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index c71f33b41e..76ab22610f 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -78,8 +78,8 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
             .u.qom_object.qom_path = (char *)path,
         };
-        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread,
+                                                   &io_holder);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 756f368849..24af3c791b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -942,8 +942,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("VFIO user", errp);
     }
 
-    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
-                                                  &io_holder);
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread, &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 2cb48dd387..727358a483 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -99,8 +99,7 @@ bool iothread_vq_mapping_apply(
             .u.qom_object.qom_path = (char *)holder,
         };
 
-        AioContext *ctx = iothread_ref_and_get_aio_context(iothread,
-                                                           &io_holder);
+        AioContext *ctx = iothread_get_aio_context(iothread, &io_holder);
 
         if (node->value->vqs) {
             uint16List *vq;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e9d023b4ec..4405a87ed0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -903,7 +903,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
         precopy_add_notifier(&s->free_page_hint_notify);
 
         s->free_page_bh = aio_bh_new_guarded(
-                      iothread_ref_and_get_aio_context(s->iothread, &io_holder),
+                      iothread_get_aio_context(s->iothread, &io_holder),
                       virtio_ballloon_get_free_page_hints, s,
                       &dev->mem_reentrancy_guard);
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index 064c05e78d..e5db215954 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -70,15 +70,15 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+
 /*
  * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
  * the AioContext, recommend migrating to the new API with IOThreadHolder
  * as much as possible.
  */
 AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const IOThreadHolder *holder);
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
diff --git a/iothread.c b/iothread.c
index 5949785b32..9bc8e359c1 100644
--- a/iothread.c
+++ b/iothread.c
@@ -469,13 +469,8 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
-{
-    return iothread->ctx;
-}
-
-AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
-                                             const IOThreadHolder *holder)
+AioContext *iothread_get_aio_context(IOThread *iothread,
+                                     const IOThreadHolder *holder)
 {
     /* Add IOThreadHolder to the list */
     iothread_ref(iothread, holder);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 7eec6f967d..4d00cf499c 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -617,7 +617,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
             .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
             .u.monitor_name.monitor_name = (char *)mon->id,
         };
-        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &holder);
+        mon->ctx = iothread_get_aio_context(mon_iothread, &holder);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 4f180936e3..820ea4d824 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -973,7 +973,7 @@ static void colo_compare_iothread(CompareState *s)
         .u.qom_object.qom_path = (char *)path,
     };
 
-    AioContext *ctx = iothread_ref_and_get_aio_context(s->iothread, &io_holder);
+    AioContext *ctx = iothread_get_aio_context(s->iothread, &io_holder);
 
     s->iothread_ctx = ctx;
     s->worker_context = iothread_get_g_main_context(s->iothread);
-- 
2.49.0


