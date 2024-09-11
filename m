Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D8EE0201
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDWk-0007Vi-Am; Tue, 10 Sep 2024 22:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1soDWj-0007Uc-1I
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:56:17 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1soDWg-0005MF-Kq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:56:16 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6daf46ee332so57638767b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726023373; x=1726628173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VId14iZtBEyGUpU9tGHRVxeMivY5MMKE+hnPBF4Qk0E=;
 b=LJOTOCdT2Bkfhnud8G6M5EV0RXx87lX9D0utew3XKotr0YpXmyJQ3IqDc4IdSjZpdc
 x3muJOehU/f15VEaVA5DttnDrVfrgoS+Pc095CEX3ztCdffYvaa3d15Wa/zVy6QEtG7C
 WmbLaOHw+NqIKrsfrsvlnQsU+LOwQih9z5fNbsfdDoy6pKZ40hjfVWdi1upOnPK/o5uS
 QDMzmj0i25XwXkJ0jdvVWMz9xc10RWVA+k/sLOEnIZ9HmcnrJosRmuHeMuRFzPt4gv3N
 ZrHUJsZPojoP2Isbhl0+HiqCqUzAcD7b0NapcnP/iEev1S/5+3WGzvH6blg38J/vXcTy
 obwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726023373; x=1726628173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VId14iZtBEyGUpU9tGHRVxeMivY5MMKE+hnPBF4Qk0E=;
 b=rELIocbzqIFpzIdOzK3EhStEK918bmPhZ/6yH+MIUcuTRoWAg9tj5HIvSSzigTRhLm
 j3jeh/rlEkk3noy0VuqtpEG+mhxiUiNLS8UHmY0F2agRX9q7qpOLLgSY4zKUf/QaPM7I
 /HPkqdGU5LJUlCe58BfqFuUyQ6aHpctf1FyWYR1MKQuZj9vTL192Xz5pUDtJh2rXRlNO
 cuAPECosm5Pq7ftcp/qp9r9TqZzKvfTlQk/8FOUtLYgC1k1as90VGi0VwGGCxEJcp147
 HWVJuPJBbmraA3luaOc771Bviqq7rcSSgbbjcLpzJMtMKjXMjkWgLUByRe1VACZp6wod
 OXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKD/H7UJ8bpQjcCgMhuneCLvpi67y+Oy6OsEyqhqQo2YKh945bdOJgVNPChZfIiQrm9edNdj8Zruzg@nongnu.org
X-Gm-Message-State: AOJu0Yyz/dcsUdvA4sm547e6Aea1xQSKjhCerkjLxwMc0t5MWnm4NbYd
 SjObi2RHjpWtFdFO/4u6flCfzM24PJ6YsgiFiuNH6Xi7T4WvfyeMIQL2Grmkl7arbqCVBHxI1EU
 oWadF3KHUWJREClS9vFX2baS9Gkg=
X-Google-Smtp-Source: AGHT+IFuFtMETSLhk546imhx/69xv1z+sUWGxkGYuXGYksl8JxFFz4ofNP+dz/Wif9wt77OJqSJpmDReKJtNn6iH8UY=
X-Received: by 2002:a05:690c:688c:b0:6d3:b708:7b1a with SMTP id
 00721157ae682-6db45165782mr195378407b3.42.1726023372709; Tue, 10 Sep 2024
 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240807095508.54750-1-yaozhenguo@jd.com>
 <axcmkj7i723brvr4cfed6bcdu3epwk3lz5ikpmngz5nrginjx5@otbycci7thov>
 <CA+WzARk-_GWGsGqKT84irMn1mNtZ=rx5t7tcvTP6+0eV4GXWsA@mail.gmail.com>
 <mdf6u6quk6khvdqtvlc3w3ppynsvornfg7hycyqhbowdcsyxnc@7gjaz5mxqds6>
In-Reply-To: <mdf6u6quk6khvdqtvlc3w3ppynsvornfg7hycyqhbowdcsyxnc@7gjaz5mxqds6>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Wed, 11 Sep 2024 10:56:01 +0800
Message-ID: <CA+WzARnN1RnWp_6tU7mj-V2bA+hvngv1U3Qsc=LziaLYbbbjhg@mail.gmail.com>
Subject: Re: [PATCH] virtio/vhost-user: fix qemu crash when hotunplug
 vhost-user-net device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=BA=8C 18:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Aug 28, 2024 at 02:50:57PM GMT, Zhenguo Yao wrote:
> >I am very sorry that my previous description was not accurate. Below I
> >will describe the steps to reproduce this problem and my analysis in
> >detail.The conditions for reproducing this problem are quite
> >demanding. First, let me introduce my environment. I use DPDK vdpa to
> >drive
> >DPU to implement a vhost-user type network card. DPDK vdpa software
> >communicates with QEMU through the vhost protocol. The steps to
> >reproduce are as follows:
> >
> >1. Start a Windows virtual machine.
> >2. Use the vish command to hotplug and unplug a 32 queues
> >vhost-user-net network card.
> >3. After a while, QEMU will crash.
> >
> >I added some logs to locate this problem. The following is how I
> >located the root cause of this problem based on logs and code
> >analysis. The steps to reproduce the problem involve hot plugging and
> >hot unplugging of network cards. Hot plugging of network cards
> >involves two processes. Process A is to insert the device into qemu,
> >and process B is the process of guest operating system initializing
> >the network card. When process A is completed, the virsh attach-device
> >command returns. At this time, you can call virsh detach-device to
> >perform hot unplug operations. Generally, this will not be a problem
> >because the network card initializes very quickly. However, since my
> >network card is a vhost-user type network card, and it is implemented
> >by DPDK vdpa, there is an asynchronous situation. When the Guest
> >operating system is initializing the network card, some messages from
> >vhost-user returned to QEMU may be delayed. The problem occurs here.
> >
> >For example, the message VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is
> >responsible for assigning the value of VhostUserHostNotifier->addr,
> >which is the hot plug process B. There are also two processes for hot
> >unplugging devices. libvirt will send two QMP commands to qemu: one is
> >device_del and the other is netdev_del. If this message arrives after
> >the first hot unplug command, there will be problems. The following is
> >a detailed analysis: The key function of the device_del command
> >execution: virtio_set_status->vhost_dev_stop. In the vhost_dev_stop
> >function, all queues will be traversed and
> >vhost_user_get_vring_base-->vhost_user_host_notifier_remove will be
> >called because VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG has not
> >arrived in some queues at this time, so VhostUserHostNotifier->addr
> >has no value at this time, so nothing will be done at this time. For
> >those with values, vhost_user_host_notifier_free will be submitted to
> >the rcu thread
> >and clear n->addr.
> >
> >Next, libvirt will send the netdev_del QMP command.
> >netdev_del--> vhost_user_cleanup
> >
> >Because some queues VhostUserHostNotifier->addr are not empty at this
> >time, there will be the following call path:
> >
> >1. vhost_user_host_notifier_remove->call_rcu(n,
> >vhost_user_host_notifier_free, rcu);
> >2. g_free_rcu(n, rcu);
>
> Got it, so call_rcu() and g_free_rcu() must be avoided on the same node
> in any case, right?
>
Yes
> I went through docs/devel/rcu.txt and code, it's not explicit, but it
> seems clear that only one should be used for cleanup.
>
If two identical nodes are added to a singly linked list in
succession, the singly linked list will become a loop. However, the
rcu linked list is somewhat special, as it has a dummy node. When
queue_pop pops this dummy node, it will be added back to the end of
the queue. This will open the loop that was just formed, and thus
cause the abort in this problem.

> >
> >The same rcu was submitted twice. In call_rcu1, if two identical nodes
> >are added to the node list, only one will be successfully added, but
> >rcu_call_count will be added twice. When rcu processes rcu node, it
> >will check whether rcu_call_count is empty. If not, it will take the
> >node from node list. Because the actual node in node list is one less
> >than rcu_call_count, it will cause rcu_call_count to be not empty, but
> >there is no node in node list. In this way, rcu thread will abort, the
> >code is as follows:
> >if (head =3D=3D &dummy && qatomic_mb_read(&tail) =3D=3D &dummy.next) {
> >    abort();
> >}
> >This is the reason why QEMU crashed. Since the latest QEMU cannot run
> >in our environment due to incompatibility of vhost-user messages, and
> >this problem is difficult to reproduce, I was unable to reproduce the
> >problem on the latest qemu. However, from the upstream code, since
> >VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is asynchronous, we cannot
> >assume that all VhostUserHostNotifier->addr in vhost_user_cleanup are
> >empty. If addr is not empty, there will be a problem. Otherwise,
> >vhost_user_host_notifier_remove is not necessary to call in
> >vhost_user_cleanup.
> >
> >Therefore, the two tasks of vhost_user_host_notifier_free and free
> >VhostUserHostNotifier need to be placed in a rcu node, and use
> >n->need_free to determine whether it is free VhostUserHostNotifier.
>
> yeah, thank you for this detailed analysis, now it's clear.
>
> My suggestion is to put some of it in the commit description as well,
> maybe a summary with the main things.
>
Yes=EF=BC=8CI will submit another patch with a description and summary of t=
he problem.
> >
> >Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=8C 16:00=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Wed, Aug 07, 2024 at 05:55:08PM GMT, yaozhenguo wrote:
> >> >When hotplug and hotunplug vhost-user-net device quickly.
> >>
> >> I'd replace the . with ,
> >>
> >> >qemu will crash. BT is as below:
> >> >
> >> >0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> >> >1  raise () at /usr/lib64/libc.so.6
> >> >2  abort () at /usr/lib64/libc.so.6
> >> >3  try_dequeue () at ../util/rcu.c:235
> >> >4  call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at ../util/rcu.c:288
> >> >5  qemu_thread_start (args=3D0x55b10d9ceaa0) at ../util/qemu-thread-p=
osix.c:541
> >> >6  start_thread () at /usr/lib64/libc.so.6
> >> >7  clone3 () at /usr/lib64/libc.so.6
> >> >
> >> >1. device_del qmp process
> >> >
> >> >virtio_set_status
> >> >  vhost_dev_stop
> >> >    vhost_user_get_vring_base
> >> >      vhost_user_host_notifier_remove
> >> >
> >> >vhost_user_slave_handle_vring_host_notifier maybe called asynchronous=
 after
> >>   ^
> >> Now it's called vhost_user_backend_handle_vring_host_notifier, I'd
> >> suggest to use the new name.
> >>
> >> >vhost_user_host_notifier_remove. vhost_user_host_notifier_remove will
> >> >not
> >> >all call_rcu because of notifier->addr is NULL at this time.
> >>
> >> s/all/call ?
> >>
> >Yes
> >> >
> >> >2. netdev_del qmp process
> >> >
> >> >vhost_user_cleanup
> >> >       vhost_user_host_notifier_remove
> >> >       g_free_rcu
> >> >
> >> >vhost_user_host_notifier_remove and g_free_rcu will sumbit same rcu_h=
ead
> >>
> >> s/sumbit/submit
> >>
> >Sorry about this mistake
>
> don't apologize, it can happen ;-)
>
> I usually use `--codespell` with ./scripts/checkpatch.pl
>
Great! I learned a new skill.

> >> >to rcu node list. rcu_call_count add twice but only one node is added=
.
> >> >rcu thread will abort when calling try_dequeue with node list is empt=
y.
> >>
> >> What's not clear to me is how 1 and 2 are related, could you explain
> >> that?
> >>
> >Libvirt will send two QMP commands in succession when the network card
> >is hot-unplugged, which can help understand the problem. However, I
> >did not describe it clearly. Please see the detailed description at
> >the top.
>
> yep, now I got it.
>
> >> >Fix this by moving g_free(n) to vhost_user_host_notifier_free.
> >> >`
> >> >Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHo=
stNotifiers")
> >> >Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> >> >---
> >> > hw/virtio/vhost-user.c         | 23 +++++++++++------------
> >> > include/hw/virtio/vhost-user.h |  1 +
> >> > 2 files changed, 12 insertions(+), 12 deletions(-)
> >> >
> >> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> >index 00561daa06..7ab37c0da2 100644
> >> >--- a/hw/virtio/vhost-user.c
> >> >+++ b/hw/virtio/vhost-user.c
> >> >@@ -1188,6 +1188,12 @@ static void vhost_user_host_notifier_free(Vhos=
tUserHostNotifier *n)
> >> >     assert(n && n->unmap_addr);
> >> >     munmap(n->unmap_addr, qemu_real_host_page_size());
> >> >     n->unmap_addr =3D NULL;
> >> >+    if (n->need_free) {
> >> >+        memory_region_transaction_begin();
> >> >+        object_unparent(OBJECT(&n->mr));
> >> >+        memory_region_transaction_commit();
> >> >+        g_free(n);
> >> >+    }
> >> > }
> >> >
> >> > /*
> >> >@@ -1195,7 +1201,7 @@ static void vhost_user_host_notifier_free(Vhost=
UserHostNotifier *n)
> >> >  * under rcu.
> >> >  */
> >> > static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n=
,
> >> >-                                            VirtIODevice *vdev)
> >> >+                                            VirtIODevice *vdev, bool=
 free)
> >> > {
> >> >     if (n->addr) {
> >> >         if (vdev) {
> >> >@@ -1204,6 +1210,7 @@ static void vhost_user_host_notifier_remove(Vho=
stUserHostNotifier *n,
> >> >         assert(!n->unmap_addr);
> >> >         n->unmap_addr =3D n->addr;
> >> >         n->addr =3D NULL;
> >> >+        n->need_free =3D free;
> >> >         call_rcu(n, vhost_user_host_notifier_free, rcu);
> >> >     }
> >> > }
> >> >@@ -1280,7 +1287,7 @@ static int vhost_user_get_vring_base(struct vho=
st_dev *dev,
> >> >
> >> >     VhostUserHostNotifier *n =3D fetch_notifier(u->user, ring->index=
);
> >> >     if (n) {
> >> >-        vhost_user_host_notifier_remove(n, dev->vdev);
> >> >+        vhost_user_host_notifier_remove(n, dev->vdev, false);
> >> >     }
> >> >
> >> >     ret =3D vhost_user_write(dev, &msg, NULL, 0);
> >> >@@ -1562,7 +1569,7 @@ static int
> >> >vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
> >> >      * new mapped address.
> >> >      *)
> >> >     n =3D fetch_or_create_notifier(user, queue_idx);
> >> >-    vhost_user_host_notifier_remove(n, vdev);
> >> >+    vhost_user_host_notifier_remove(n, vdev, false);
> >> >
> >> >     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> >> >         return 0;
> >> >@@ -2737,13 +2744,7 @@ static void vhost_user_state_destroy(gpointer =
data)
> >> > {
> >> >     VhostUserHostNotifier *n =3D (VhostUserHostNotifier *) data;
> >> >     if (n) {
> >> >-        vhost_user_host_notifier_remove(n, NULL);
> >> >-        object_unparent(OBJECT(&n->mr));
> >> >-        /*
> >> >-         * We can't free until vhost_user_host_notifier_remove has
> >> >-         * done it's thing so schedule the free with RCU.
> >> >-         */
> >> >-        g_free_rcu(n, rcu);
> >> >+        vhost_user_host_notifier_remove(n, NULL, true);
> >>
> >> I'm not sure I understand the problem well, but could it be that now w=
e
> >> don't see the problem anymore, but we have a memory leak?
> >>
> >> Here for example could it be the case that `n->addr` is NULL and
> >> therefore `vhost_user_host_notifier_free` with `n->need_free =3D true`
> >> will never be submitted?
> >>
> >Please see the detailed description at the top.
>
> I see it, but my question is still there.
>
> I mean, in vhost_user_host_notifier_free() should we call the new steps
> you added (object_unparent, g_free, etc.), also if `n->addr` is NULL ?
>
This is indeed a problem, there is a memory leak. I will fix it in the
next version.
> >> >     }
> >> > }
> >> >
> >> >@@ -2765,9 +2766,7 @@ void vhost_user_cleanup(VhostUserState *user)
> >> >     if (!user->chr) {
> >> >         return;
> >> >     }
> >> >-    memory_region_transaction_begin();
> >> >     user->notifiers =3D (GPtrArray *) g_ptr_array_free(user->notifie=
rs,
> >> >     true);
> >> >-    memory_region_transaction_commit();
> >>
> >> This is no longer necessary, because the `user->notifiers` free functi=
on
> >> no longer calls `object_unparent(OBJECT(&n->mr))`, right?
> >>
> >> Maybe it's worth mentioning in the commit description.
> >>
> >Yes, I originally thought so. But after reading the code carefully, I
> >found that my understanding was not correct.It is still needed here,
> >because the user->notifiers free function will call
> >virtio_queue_set_host_notifier_mr. This should also require
> >memory_region_transaction_commit. Is this correct?
>
> yeah, I think so. For examples virtio_pci_set_host_notifier_mr() is
> calling memory_region_add_subregion_overlap() or
> memory_region_del_subregion()
>
I will add it back in the next version.
> Thanks,
> Stefano
>
> >
> >> >     user->chr =3D NULL;
> >> > }
> >> >
> >> >diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost=
-user.h
> >> >index 324cd8663a..a171f29e0b 100644
> >> >--- a/include/hw/virtio/vhost-user.h
> >> >+++ b/include/hw/virtio/vhost-user.h
> >> >@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
> >> >     void *addr;
> >> >     void *unmap_addr;
> >> >     int idx;
> >> >+    bool need_free;
> >> > } VhostUserHostNotifier;
> >> >
> >> > /**
> >> >--
> >> >2.43.0
> >> >
> >>
> >
>

