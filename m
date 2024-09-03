Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE863CD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 10:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slQUA-0001yB-4Y; Tue, 03 Sep 2024 06:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1slQTu-0001x1-HD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 06:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1slQTN-0007sN-59
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 06:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725358082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7o0+0S29v3SpT2ZlWdg3tdgm0Pn7fGxvu4plwitVmxs=;
 b=g4+Pf7/hxjjQVn/UFyxrEY86CmiS+nYBayHy981kv5pUwibpSPh88UkCFEzb/mbq5C1GJj
 XsxBHdy2/R/a/U/LLajE2bbQpmAq5SP1+/ZIcFtyJI6QAt+rbk6WtDRl8xMGIPpsZIUi74
 eS6zQnnvCrBHa0g5GbCYBHAxxRZ2MBY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-bi5Af-HsOrOlsrZ656lS_A-1; Tue, 03 Sep 2024 06:05:09 -0400
X-MC-Unique: bi5Af-HsOrOlsrZ656lS_A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3df2de4cab1so3251360b6e.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 03:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725357908; x=1725962708;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7o0+0S29v3SpT2ZlWdg3tdgm0Pn7fGxvu4plwitVmxs=;
 b=m1PnrPQNKYtujJGx31mhF35etnkNYNtac6LaiQPb/xRI4faQZU+1pA9UqxEfb/WOHo
 od8M82dPzRLVb/tkDI5XXjxY0QTQ5n+cDFiLwW0VpMAPNRnr9IIOjCQjYMsNYSVtHwBK
 qmrTkaXK176JDcPbY7fmvggYsK6rdu97AzFVIJka0hsRQfir6FakRBVTJ3YPzk3ghKe0
 vZqquxqI+Avfv/73lk6Oo4/HkOguspMKuUt47IZjrBU6JmbK1nIFlDBT1bPKOoU/Q/OA
 apFiTUCFYW+lvor5dz+TtyWZa3wEjpJH/SN1ncFb4ccsPHxQPGopCRj9KUCv4poqedpA
 ljgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo0KQN7pD0uhyaYZCAZ5Ox8PO/5CkRt952zHoguqQFGuzvyQu3XNmeQ/wB3IBpYebkeI1JvW7K3oui@nongnu.org
X-Gm-Message-State: AOJu0YyPub589W+nDL9hZylDaCs7jtwA+6Ert9qDQoJ9ea+r8P5EmszR
 L92XvFlP/q6wQQch0wo7Eecp7C/wAIvB2wh65hdvpkXyhGAegmfp2imsYY/qTOdY9kaSoDEiTXr
 SS82iXkXfvdIo/iPWDAWTWvaI37nG4rimZyidUz8tTI1vo4yftaV/
X-Received: by 2002:a05:6808:1385:b0:3db:209e:7222 with SMTP id
 5614622812f47-3df1c0ca13emr10363809b6e.15.1725357908641; 
 Tue, 03 Sep 2024 03:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3hnQbSpVAauqlvXMHkK+3WIFFaOHSjqhYpYD/tlcJ0i2xOqffGjrziU+ta5TaWRIR8TYg2w==
X-Received: by 2002:a05:6808:1385:b0:3db:209e:7222 with SMTP id
 5614622812f47-3df1c0ca13emr10363782b6e.15.1725357908125; 
 Tue, 03 Sep 2024 03:05:08 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.98.235])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cef706sm48235371cf.58.2024.09.03.03.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 03:05:07 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:05:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zhenguo Yao <yaozhenguo1@gmail.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Subject: Re: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
Message-ID: <mdf6u6quk6khvdqtvlc3w3ppynsvornfg7hycyqhbowdcsyxnc@7gjaz5mxqds6>
References: <20240807095508.54750-1-yaozhenguo@jd.com>
 <axcmkj7i723brvr4cfed6bcdu3epwk3lz5ikpmngz5nrginjx5@otbycci7thov>
 <CA+WzARk-_GWGsGqKT84irMn1mNtZ=rx5t7tcvTP6+0eV4GXWsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+WzARk-_GWGsGqKT84irMn1mNtZ=rx5t7tcvTP6+0eV4GXWsA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Aug 28, 2024 at 02:50:57PM GMT, Zhenguo Yao wrote:
>I am very sorry that my previous description was not accurate. Below I
>will describe the steps to reproduce this problem and my analysis in
>detail.The conditions for reproducing this problem are quite
>demanding. First, let me introduce my environment. I use DPDK vdpa to
>drive
>DPU to implement a vhost-user type network card. DPDK vdpa software
>communicates with QEMU through the vhost protocol. The steps to
>reproduce are as follows:
>
>1. Start a Windows virtual machine.
>2. Use the vish command to hotplug and unplug a 32 queues
>vhost-user-net network card.
>3. After a while, QEMU will crash.
>
>I added some logs to locate this problem. The following is how I
>located the root cause of this problem based on logs and code
>analysis. The steps to reproduce the problem involve hot plugging and
>hot unplugging of network cards. Hot plugging of network cards
>involves two processes. Process A is to insert the device into qemu,
>and process B is the process of guest operating system initializing
>the network card. When process A is completed, the virsh attach-device
>command returns. At this time, you can call virsh detach-device to
>perform hot unplug operations. Generally, this will not be a problem
>because the network card initializes very quickly. However, since my
>network card is a vhost-user type network card, and it is implemented
>by DPDK vdpa, there is an asynchronous situation. When the Guest
>operating system is initializing the network card, some messages from
>vhost-user returned to QEMU may be delayed. The problem occurs here.
>
>For example, the message VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is
>responsible for assigning the value of VhostUserHostNotifier->addr,
>which is the hot plug process B. There are also two processes for hot
>unplugging devices. libvirt will send two QMP commands to qemu: one is
>device_del and the other is netdev_del. If this message arrives after
>the first hot unplug command, there will be problems. The following is
>a detailed analysis: The key function of the device_del command
>execution: virtio_set_status->vhost_dev_stop. In the vhost_dev_stop
>function, all queues will be traversed and
>vhost_user_get_vring_base-->vhost_user_host_notifier_remove will be
>called because VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG has not
>arrived in some queues at this time, so VhostUserHostNotifier->addr
>has no value at this time, so nothing will be done at this time. For
>those with values, vhost_user_host_notifier_free will be submitted to
>the rcu thread
>and clear n->addr.
>
>Next, libvirt will send the netdev_del QMP command.
>netdev_del--> vhost_user_cleanup
>
>Because some queues VhostUserHostNotifier->addr are not empty at this
>time, there will be the following call path:
>
>1. vhost_user_host_notifier_remove->call_rcu(n,
>vhost_user_host_notifier_free, rcu);
>2. g_free_rcu(n, rcu);

Got it, so call_rcu() and g_free_rcu() must be avoided on the same node
in any case, right?

I went through docs/devel/rcu.txt and code, it's not explicit, but it
seems clear that only one should be used for cleanup.

>
>The same rcu was submitted twice. In call_rcu1, if two identical nodes
>are added to the node list, only one will be successfully added, but
>rcu_call_count will be added twice. When rcu processes rcu node, it
>will check whether rcu_call_count is empty. If not, it will take the
>node from node list. Because the actual node in node list is one less
>than rcu_call_count, it will cause rcu_call_count to be not empty, but
>there is no node in node list. In this way, rcu thread will abort, the
>code is as follows:
>if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
>    abort();
>}
>This is the reason why QEMU crashed. Since the latest QEMU cannot run
>in our environment due to incompatibility of vhost-user messages, and
>this problem is difficult to reproduce, I was unable to reproduce the
>problem on the latest qemu. However, from the upstream code, since
>VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is asynchronous, we cannot
>assume that all VhostUserHostNotifier->addr in vhost_user_cleanup are
>empty. If addr is not empty, there will be a problem. Otherwise,
>vhost_user_host_notifier_remove is not necessary to call in
>vhost_user_cleanup.
>
>Therefore, the two tasks of vhost_user_host_notifier_free and free
>VhostUserHostNotifier need to be placed in a rcu node, and use
>n->need_free to determine whether it is free VhostUserHostNotifier.

yeah, thank you for this detailed analysis, now it's clear.

My suggestion is to put some of it in the commit description as well,
maybe a summary with the main things.

>
>Stefano Garzarella <sgarzare@redhat.com> 于2024年8月27日周二 16:00写道：
>>
>> On Wed, Aug 07, 2024 at 05:55:08PM GMT, yaozhenguo wrote:
>> >When hotplug and hotunplug vhost-user-net device quickly.
>>
>> I'd replace the . with ,
>>
>> >qemu will crash. BT is as below:
>> >
>> >0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
>> >1  raise () at /usr/lib64/libc.so.6
>> >2  abort () at /usr/lib64/libc.so.6
>> >3  try_dequeue () at ../util/rcu.c:235
>> >4  call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:288
>> >5  qemu_thread_start (args=0x55b10d9ceaa0) at ../util/qemu-thread-posix.c:541
>> >6  start_thread () at /usr/lib64/libc.so.6
>> >7  clone3 () at /usr/lib64/libc.so.6
>> >
>> >1. device_del qmp process
>> >
>> >virtio_set_status
>> >  vhost_dev_stop
>> >    vhost_user_get_vring_base
>> >      vhost_user_host_notifier_remove
>> >
>> >vhost_user_slave_handle_vring_host_notifier maybe called asynchronous after
>>   ^
>> Now it's called vhost_user_backend_handle_vring_host_notifier, I'd
>> suggest to use the new name.
>>
>> >vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will
>> >not
>> >all call_rcu because of notifier->addr is NULL at this time.
>>
>> s/all/call ?
>>
>Yes
>> >
>> >2. netdev_del qmp process
>> >
>> >vhost_user_cleanup
>> >       vhost_user_host_notifier_remove
>> >       g_free_rcu
>> >
>> >vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_head
>>
>> s/sumbit/submit
>>
>Sorry about this mistake

don't apologize, it can happen ;-)

I usually use `--codespell` with ./scripts/checkpatch.pl

>> >to rcu node list. rcu_call_count add twice but only one node is added.
>> >rcu thread will abort when calling try_dequeue with node list is empty.
>>
>> What's not clear to me is how 1 and 2 are related, could you explain
>> that?
>>
>Libvirt will send two QMP commands in succession when the network card
>is hot-unplugged, which can help understand the problem. However, I
>did not describe it clearly. Please see the detailed description at
>the top.

yep, now I got it.

>> >Fix this by moving g_free(n) to vhost_user_host_notifier_free.
>> >`
>> >Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
>> >Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
>> >---
>> > hw/virtio/vhost-user.c         | 23 +++++++++++------------
>> > include/hw/virtio/vhost-user.h |  1 +
>> > 2 files changed, 12 insertions(+), 12 deletions(-)
>> >
>> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> >index 00561daa06..7ab37c0da2 100644
>> >--- a/hw/virtio/vhost-user.c
>> >+++ b/hw/virtio/vhost-user.c
>> >@@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>> >     assert(n && n->unmap_addr);
>> >     munmap(n->unmap_addr, qemu_real_host_page_size());
>> >     n->unmap_addr = NULL;
>> >+    if (n->need_free) {
>> >+        memory_region_transaction_begin();
>> >+        object_unparent(OBJECT(&n->mr));
>> >+        memory_region_transaction_commit();
>> >+        g_free(n);
>> >+    }
>> > }
>> >
>> > /*
>> >@@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>> >  * under rcu.
>> >  */
>> > static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>> >-                                            VirtIODevice *vdev)
>> >+                                            VirtIODevice *vdev, bool free)
>> > {
>> >     if (n->addr) {
>> >         if (vdev) {
>> >@@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
>> >         assert(!n->unmap_addr);
>> >         n->unmap_addr = n->addr;
>> >         n->addr = NULL;
>> >+        n->need_free = free;
>> >         call_rcu(n, vhost_user_host_notifier_free, rcu);
>> >     }
>> > }
>> >@@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>> >
>> >     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
>> >     if (n) {
>> >-        vhost_user_host_notifier_remove(n, dev->vdev);
>> >+        vhost_user_host_notifier_remove(n, dev->vdev, false);
>> >     }
>> >
>> >     ret = vhost_user_write(dev, &msg, NULL, 0);
>> >@@ -1562,7 +1569,7 @@ static int 
>> >vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
>> >      * new mapped address.
>> >      *)
>> >     n = fetch_or_create_notifier(user, queue_idx);
>> >-    vhost_user_host_notifier_remove(n, vdev);
>> >+    vhost_user_host_notifier_remove(n, vdev, false);
>> >
>> >     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>> >         return 0;
>> >@@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer data)
>> > {
>> >     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
>> >     if (n) {
>> >-        vhost_user_host_notifier_remove(n, NULL);
>> >-        object_unparent(OBJECT(&n->mr));
>> >-        /*
>> >-         * We can't free until vhost_user_host_notifier_remove has
>> >-         * done it's thing so schedule the free with RCU.
>> >-         */
>> >-        g_free_rcu(n, rcu);
>> >+        vhost_user_host_notifier_remove(n, NULL, true);
>>
>> I'm not sure I understand the problem well, but could it be that now we
>> don't see the problem anymore, but we have a memory leak?
>>
>> Here for example could it be the case that `n->addr` is NULL and
>> therefore `vhost_user_host_notifier_free` with `n->need_free = true`
>> will never be submitted?
>>
>Please see the detailed description at the top.

I see it, but my question is still there.

I mean, in vhost_user_host_notifier_free() should we call the new steps
you added (object_unparent, g_free, etc.), also if `n->addr` is NULL ?

>> >     }
>> > }
>> >
>> >@@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
>> >     if (!user->chr) {
>> >         return;
>> >     }
>> >-    memory_region_transaction_begin();
>> >     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers,
>> >     true);
>> >-    memory_region_transaction_commit();
>>
>> This is no longer necessary, because the `user->notifiers` free function
>> no longer calls `object_unparent(OBJECT(&n->mr))`, right?
>>
>> Maybe it's worth mentioning in the commit description.
>>
>Yes, I originally thought so. But after reading the code carefully, I
>found that my understanding was not correct.It is still needed here,
>because the user->notifiers free function will call
>virtio_queue_set_host_notifier_mr. This should also require
>memory_region_transaction_commit. Is this correct?

yeah, I think so. For examples virtio_pci_set_host_notifier_mr() is
calling memory_region_add_subregion_overlap() or
memory_region_del_subregion()

Thanks,
Stefano

>
>> >     user->chr = NULL;
>> > }
>> >
>> >diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>> >index 324cd8663a..a171f29e0b 100644
>> >--- a/include/hw/virtio/vhost-user.h
>> >+++ b/include/hw/virtio/vhost-user.h
>> >@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>> >     void *addr;
>> >     void *unmap_addr;
>> >     int idx;
>> >+    bool need_free;
>> > } VhostUserHostNotifier;
>> >
>> > /**
>> >--
>> >2.43.0
>> >
>>
>


