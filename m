Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A444CF07BF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 08:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syoPI-0003eJ-SZ; Thu, 10 Oct 2024 04:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1syoPG-0003e2-M1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1syoPE-0005PG-Am
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728548418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xMErXb4WbToGTuB6R8DGHTKXDL2G4YCt9Ujp5uhNnc=;
 b=aej6IxIiSOzrZTxoYk/ohxZXfbeBMN0JDY8YmQIQXf+hcP09q6gwPnv8K7wkkQntsGQYH5
 PufFGrXtk75Zbf0/VxLmOvsLce5+ElMwg9IdYRpxEw2JUbPTby4fNLny21aCx7mXQOMRs5
 NG5KevTS3+Mb2csomKzCrNGWVzQGMxE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-22E63EuZPLSL5ywBngvGDg-1; Thu, 10 Oct 2024 04:20:15 -0400
X-MC-Unique: 22E63EuZPLSL5ywBngvGDg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a996c29edaaso47728966b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 01:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728548414; x=1729153214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xMErXb4WbToGTuB6R8DGHTKXDL2G4YCt9Ujp5uhNnc=;
 b=A+Q23VPsul0znFHVzxfp3z01UzpXFt5yUdOmrvl9CVyYd9/I3vvN1KVOzHcIr0+lGy
 At6zk4HtImaYdckQWMfylW56/cr2SUS9fatQIkfwnVJjp5fwWNr3kTn33WDToVssksXI
 mTBeL4N6KcBF7S9h93w1zndOEbMvsb6lb+SMZnSBzrG7EUa9g7lfR0cnnjcV7SJyd9/p
 ISucHq/mZTXIycTxLtNCSqiTRnapEk6yNWZNlL1w+g8Gvmsb/1zOZ3fJOJK3myg1aSbE
 xXjwaHuLbEjxdVjDcEgbG0Du0g4Zb65L2FcU5G5s+BZORqwg7hi8LbTp/zLvdMB7PYOy
 t9pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckixzK5QsTAtnO2vbbbj7VzOA7zE2Ag0TD6oh/KB64Qq5XhxFh0bf2MWY1aqk/uDpk+rI6KELEb40@nongnu.org
X-Gm-Message-State: AOJu0YwTDsIlPZYBvP4UHKJwN46yDZoKJQjG170ZfxR16Ca8gmOaHrMx
 gI2+K8kCLTAno1Bctss5VOQB4HhxCdH7el78gPOcrPks0zytE95c+zfv7Evp5N8HJaIBOvr5Tz1
 mv3q702LrZvmUIiSx2lo8Wps0oJA3ymqIEjxASF5biTu9X9z1QLSw
X-Received: by 2002:a17:907:e698:b0:a99:42a3:db9b with SMTP id
 a640c23a62f3a-a998d3156cemr468075366b.48.1728548414013; 
 Thu, 10 Oct 2024 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBDHCVrDuQzn+hwwtEGKz1SOFZVK+D8CZgrXj67xXX7bGHZM3EH7fdNjjFpeWdL1Eer9qGoA==
X-Received: by 2002:a17:907:e698:b0:a99:42a3:db9b with SMTP id
 a640c23a62f3a-a998d3156cemr468071666b.48.1728548413222; 
 Thu, 10 Oct 2024 01:20:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80c0723sm52163766b.135.2024.10.10.01.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 01:20:12 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:20:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Subject: Re: [PATCH V3] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Message-ID: <hgkoxnyvewuo54otuoc32aaa4vh7o7qkmq3u7g4c4omy66giwp@3cbqzkx4oezj>
References: <20241010061824.74819-1-yaozhenguo@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241010061824.74819-1-yaozhenguo@jd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 10, 2024 at 02:18:24PM GMT, yaozhenguo wrote:
>During the hot-unplugging of vhost-user-net type network cards,
>the vhost_user_cleanup function may add the same rcu node to
>the rcu linked list.
>The function call relationship in this case is as follows:
>
>vhost_user_cleanup
>    ->vhost_user_host_notifier_remove
>        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
>    ->g_free_rcu(n, rcu);
>
>When this happens, QEMU will abort in try_dequeue:
>
>if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
>    abort();
>}
>
>backtrace is as follows::
>0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
>1  raise () at /usr/lib64/libc.so.6
>2  abort () at /usr/lib64/libc.so.6
>3  try_dequeue () at ../util/rcu.c:235
>4  call_rcu_thread (0) at ../util/rcu.c:288
>5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
>6  start_thread () at /usr/lib64/libc.so.6
>7  clone3 () at /usr/lib64/libc.so.6
>
>The reason for the abort is that adding two identical nodes to
>the rcu linked list will cause the rcu linked list to become a ring,
>but when the dummy node is added after the two identical nodes,
>the ring is opened. But only one node is added to list with
>rcu_call_count added twice. This will cause rcu try_dequeue abort.
>
>This happens when n->addr != 0. In some scenarios, this does happen.
>For example, this situation will occur when using a 32-queue DPU
>vhost-user-net type network card for hot-unplug testing, because
>VhostUserHostNotifier->addr will be cleared during the processing of
>VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG. However,it is asynchronous,
>so we cannot guarantee that VhostUserHostNotifier->addr is zero in
>vhost_user_cleanup. Therefore, it is necessary to merge g_free_rcu
>and vhost_user_host_notifier_free into one rcu node.
>
>Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
>Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
>---
>   V1->V2: add n->addr check in vhost_user_get_vring_base and vhost_user_backend_handle_vring_host_notifier to prevent submit same node to rcu list.
>   V2->V3: 1. change "free" to "destroy"
>           2. move "!n->addr && !destroy" checking to vhost_user_host_notifier_remove
>           3. move "!n" checking to vhost_user_host_notifier_remove
>---
> hw/virtio/vhost-user.c         | 43 ++++++++++++++++++----------------
> include/hw/virtio/vhost-user.h |  1 +
> 2 files changed, 24 insertions(+), 20 deletions(-)

Some checkpatch errors:

$ ./scripts/checkpatch.pl --strict --branch master..HEAD --codespell
ERROR: braces {} are necessary for all arms of this statement
#98: FILE: hw/virtio/vhost-user.c:1207:
+    if (!n)
[...]

ERROR: braces {} are necessary for all arms of this statement
#100: FILE: hw/virtio/vhost-user.c:1209:
+    if (!destroy && !n->addr)
[...]

total: 2 errors, 0 warnings, 96 lines checked

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 00561daa06..f80d0af76f 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1185,9 +1185,16 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
>
> static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
> {
>-    assert(n && n->unmap_addr);
>-    munmap(n->unmap_addr, qemu_real_host_page_size());
>-    n->unmap_addr = NULL;
>+    if (n->unmap_addr) {
>+        munmap(n->unmap_addr, qemu_real_host_page_size());
>+        n->unmap_addr = NULL;
>+    }
>+    if (n->destroy) {
>+        memory_region_transaction_begin();
>+        object_unparent(OBJECT(&n->mr));
>+        memory_region_transaction_commit();
>+        g_free(n);
>+    }
> }
>
> /*
>@@ -1195,17 +1202,25 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>  * under rcu.
>  */
> static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>-                                            VirtIODevice *vdev)
>+                                            VirtIODevice *vdev, bool destroy)
> {
>+    if (!n)
>+        return;
>+    if (!destroy && !n->addr)

IIUC if `destroy` is false and `n->addr` is NULL, we don't have anything 
to do, so we can early return, right?

Maybe we can put a comment on that condition.

>+        return;

Better to use a single if here in this way:
       if (!n || (!destroy && !n->addr)) {
           return;
       }

The rest LGTM!

Thanks,
Stefano

>+
>     if (n->addr) {
>         if (vdev) {
>+            memory_region_transaction_begin();
>             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, false);
>+            memory_region_transaction_commit();
>         }
>         assert(!n->unmap_addr);
>         n->unmap_addr = n->addr;
>         n->addr = NULL;
>-        call_rcu(n, vhost_user_host_notifier_free, rcu);
>     }
>+    n->destroy = destroy;
>+    call_rcu(n, vhost_user_host_notifier_free, rcu);
> }
>
> static int vhost_user_set_vring_base(struct vhost_dev *dev,
>@@ -1279,9 +1294,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>     struct vhost_user *u = dev->opaque;
>
>     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
>-    if (n) {
>-        vhost_user_host_notifier_remove(n, dev->vdev);
>-    }
>+    vhost_user_host_notifier_remove(n, dev->vdev, false);
>
>     ret = vhost_user_write(dev, &msg, NULL, 0);
>     if (ret < 0) {
>@@ -1562,7 +1575,7 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
>      * new mapped address.
>      */
>     n = fetch_or_create_notifier(user, queue_idx);
>-    vhost_user_host_notifier_remove(n, vdev);
>+    vhost_user_host_notifier_remove(n, vdev, false);
>
>     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>         return 0;
>@@ -2736,15 +2749,7 @@ static int vhost_user_set_inflight_fd(struct vhost_dev *dev,
> static void vhost_user_state_destroy(gpointer data)
> {
>     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
>-    if (n) {
>-        vhost_user_host_notifier_remove(n, NULL);
>-        object_unparent(OBJECT(&n->mr));
>-        /*
>-         * We can't free until vhost_user_host_notifier_remove has
>-         * done it's thing so schedule the free with RCU.
>-         */
>-        g_free_rcu(n, rcu);
>-    }
>+    vhost_user_host_notifier_remove(n, NULL, true);
> }
>
> bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
>@@ -2765,9 +2770,7 @@ void vhost_user_cleanup(VhostUserState *user)
>     if (!user->chr) {
>         return;
>     }
>-    memory_region_transaction_begin();
>     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
>-    memory_region_transaction_commit();
>     user->chr = NULL;
> }
>
>diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>index 324cd8663a..9a3f238b43 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>     void *addr;
>     void *unmap_addr;
>     int idx;
>+    bool destroy;
> } VhostUserHostNotifier;
>
> /**
>-- 
>2.41.0
>


