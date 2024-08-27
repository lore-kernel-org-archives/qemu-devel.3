Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5005C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 08:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sir7u-0007TL-IA; Tue, 27 Aug 2024 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sir7q-0007SX-PI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 04:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sir7n-0005te-Uf
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 04:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724745621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCHXKdncPEF0pXj2YMx/6rrQ+p2qzZeXUaUP8uc9fLE=;
 b=S1m2ZeEDD9FVmSX3n5FzEOtyn3a2/dUMKiawWR+2OZ6F6VBwVEVX6jLmAJ+cmEoVuMsYvw
 TXBCFc8XOGw8XoDRfJ8EaODe3h1/c/fJmh/icXhUByx1Pz25kXWvIqQl63qC+UAZnfnMIc
 ysdBHOPAZ6q4A3BguTmRMl8eDniBj6k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ZtrSrQrDOYOjv7kQAy2i-g-1; Tue, 27 Aug 2024 04:00:19 -0400
X-MC-Unique: ZtrSrQrDOYOjv7kQAy2i-g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5bec5a6557cso2642244a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 01:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724745618; x=1725350418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCHXKdncPEF0pXj2YMx/6rrQ+p2qzZeXUaUP8uc9fLE=;
 b=Ilpb3g8Ga5+vbKsRxpvMq7MUjvgx9KHW2hovB5p1KXa8HroqU5GX0ALb+jXH9fMIkL
 tLVZ5u1DOjQSDHu/SW+1z9U8hnYsnnKMlFNfbm8Gn1psgNPf7MzCXRu2PKyDQvGiYc47
 bo90gkW8j8WOFzZ8YHsi49eMvRH7sXbK2hSCp6b0s4fC8G+nJbR2K/YQf59R2UlPfhIC
 lHWQsiF5L34YaEqua+Eq6L8tZFGidUUx/gipm1INhMuKSBuDAijG50hzDFsTTdrm99DR
 h4a9wPk8Vuq48tmAIa6ClICnXlZRJHo3Eb+vvw1ZBmYU89nw7WhgeoxDYtcmRZUh6V/S
 V7Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWklWrP7maxCMqzN4f0o9nCwGSUokuS8PLc1RqCNJ+GQcRNehlayOHfCyMo3Fpohu7/oQiH6kbj2kHG@nongnu.org
X-Gm-Message-State: AOJu0Yw3FV5tjyZPXUsSxocikNrGLqDuzwp0u1RTgD1l+TajI+nkzJfo
 bsxgCAKYxhVtN75gGZESxwqHvjLhmf7lVCwxBAO3CzbjXRAmZfDg0ZCnqOwT4YM9/9Vgj0A7Tub
 F6cac7jYRTavueCGMECzdCRQxGlG6KNLnE3nW+qOr87FEr3fLcBly
X-Received: by 2002:a05:6402:5c9:b0:58b:1a5e:c0e7 with SMTP id
 4fb4d7f45d1cf-5c0891b421bmr10545776a12.35.1724745617835; 
 Tue, 27 Aug 2024 01:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7+wCTg+Oyo7RTzMgdgsV9H1e/ouzbic3zycjz1YJ+Ke3UcUsVL7mRr3VmuBkXHtPJWWKIcw==
X-Received: by 2002:a05:6402:5c9:b0:58b:1a5e:c0e7 with SMTP id
 4fb4d7f45d1cf-5c0891b421bmr10545724a12.35.1724745616765; 
 Tue, 27 Aug 2024 01:00:16 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.170.38])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb213739sm695457a12.54.2024.08.27.01.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 01:00:16 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:00:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Subject: Re: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
Message-ID: <axcmkj7i723brvr4cfed6bcdu3epwk3lz5ikpmngz5nrginjx5@otbycci7thov>
References: <20240807095508.54750-1-yaozhenguo@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240807095508.54750-1-yaozhenguo@jd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 05:55:08PM GMT, yaozhenguo wrote:
>When hotplug and hotunplug vhost-user-net device quickly.

I'd replace the . with ,

>qemu will crash. BT is as below:
>
>0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
>1  raise () at /usr/lib64/libc.so.6
>2  abort () at /usr/lib64/libc.so.6
>3  try_dequeue () at ../util/rcu.c:235
>4  call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:288
>5  qemu_thread_start (args=0x55b10d9ceaa0) at ../util/qemu-thread-posix.c:541
>6  start_thread () at /usr/lib64/libc.so.6
>7  clone3 () at /usr/lib64/libc.so.6
>
>1. device_del qmp process
>
>virtio_set_status
>  vhost_dev_stop
>    vhost_user_get_vring_base
>      vhost_user_host_notifier_remove
>
>vhost_user_slave_handle_vring_host_notifier maybe called asynchronous after
  ^
Now it's called vhost_user_backend_handle_vring_host_notifier, I'd 
suggest to use the new name.

>vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will 
>not
>all call_rcu because of notifier->addr is NULL at this time.

s/all/call ?

>
>2. netdev_del qmp process
>
>vhost_user_cleanup
>       vhost_user_host_notifier_remove
>       g_free_rcu
>
>vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_head

s/sumbit/submit

>to rcu node list. rcu_call_count add twice but only one node is added.
>rcu thread will abort when calling try_dequeue with node list is empty.

What's not clear to me is how 1 and 2 are related, could you explain 
that?

>Fix this by moving g_free(n) to vhost_user_host_notifier_free.
>`
>Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
>Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
>---
> hw/virtio/vhost-user.c         | 23 +++++++++++------------
> include/hw/virtio/vhost-user.h |  1 +
> 2 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 00561daa06..7ab37c0da2 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>     assert(n && n->unmap_addr);
>     munmap(n->unmap_addr, qemu_real_host_page_size());
>     n->unmap_addr = NULL;
>+    if (n->need_free) {
>+        memory_region_transaction_begin();
>+        object_unparent(OBJECT(&n->mr));
>+        memory_region_transaction_commit();
>+        g_free(n);
>+    }
> }
>
> /*
>@@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>  * under rcu.
>  */
> static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>-                                            VirtIODevice *vdev)
>+                                            VirtIODevice *vdev, bool free)
> {
>     if (n->addr) {
>         if (vdev) {
>@@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>         assert(!n->unmap_addr);
>         n->unmap_addr = n->addr;
>         n->addr = NULL;
>+        n->need_free = free;
>         call_rcu(n, vhost_user_host_notifier_free, rcu);
>     }
> }
>@@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>
>     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
>     if (n) {
>-        vhost_user_host_notifier_remove(n, dev->vdev);
>+        vhost_user_host_notifier_remove(n, dev->vdev, false);
>     }
>
>     ret = vhost_user_write(dev, &msg, NULL, 0);
>@@ -1562,7 +1569,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
>      * new mapped address.
>      */
>     n = fetch_or_create_notifier(user, queue_idx);
>-    vhost_user_host_notifier_remove(n, vdev);
>+    vhost_user_host_notifier_remove(n, vdev, false);
>
>     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>         return 0;
>@@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer data)
> {
>     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
>     if (n) {
>-        vhost_user_host_notifier_remove(n, NULL);
>-        object_unparent(OBJECT(&n->mr));
>-        /*
>-         * We can't free until vhost_user_host_notifier_remove has
>-         * done it's thing so schedule the free with RCU.
>-         */
>-        g_free_rcu(n, rcu);
>+        vhost_user_host_notifier_remove(n, NULL, true);

I'm not sure I understand the problem well, but could it be that now we 
don't see the problem anymore, but we have a memory leak?

Here for example could it be the case that `n->addr` is NULL and 
therefore `vhost_user_host_notifier_free` with `n->need_free = true` 
will never be submitted?

>     }
> }
>
>@@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
>     if (!user->chr) {
>         return;
>     }
>-    memory_region_transaction_begin();
>     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, 
>     true);
>-    memory_region_transaction_commit();

This is no longer necessary, because the `user->notifiers` free function 
no longer calls `object_unparent(OBJECT(&n->mr))`, right?

Maybe it's worth mentioning in the commit description.

>     user->chr = NULL;
> }
>
>diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>index 324cd8663a..a171f29e0b 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>     void *addr;
>     void *unmap_addr;
>     int idx;
>+    bool need_free;
> } VhostUserHostNotifier;
>
> /**
>-- 
>2.43.0
>


