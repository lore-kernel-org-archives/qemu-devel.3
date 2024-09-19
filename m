Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE0CDD566
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr65E-00010z-Qu; Wed, 18 Sep 2024 21:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sr65C-00010E-Tv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 21:35:47 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sr65A-0004QW-Ul
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 21:35:46 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-68518bc1407so3082557b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726709743; x=1727314543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+KAxMpxoyRSjFMZowl3Lnxq8wuVXNRVxinGAz4ryuI=;
 b=NjK15IRZhpOTbKfP8m7wAqwVj6kq/qNW6b1YSZQczcvXLswXwuO44kF8lXLC9U1TmR
 zic/uPm3ohk2Y7e4Y4+wia7W+31+1mj73PuZy4evJFyaePQQ1aOWB/pyXiTE1OWPDVe8
 BTtY7Yie+Vdj5/D504X+X6cIt0xvDVI8SazXRpRrbykwt2TkM8blJCTS8qvcmqbo7Bcc
 iPoTy6st2O9g+7+VMUzSnfOCS/KVphq4AE8IThLSD+eqkAcEzvXGJOR95ETPtUzbt25+
 e6JajR8cUep57/p/3EXvBOqiyr91AYK3DXxV1AmRyBRs2DtZm0+ieIIy56dLThbCVlw5
 uwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726709743; x=1727314543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+KAxMpxoyRSjFMZowl3Lnxq8wuVXNRVxinGAz4ryuI=;
 b=MaUzH40++tSmRAM0MfWCX64Q/YSidojlkZQv+xWoczFislUur6k9IAORiO97ltSrOc
 HJjtqOaWyvXZcoZ/Vk1q+A4RY7b6EjzmI05g89vwBCzZb+PVkhXK23hYPRolb2nKJhV7
 uUiAlG0+F0d58LugcURKHKu9yRWQEkhJBSmFj5Q52sTRxXQ9QnrjlULV3wNYkpwT5gLG
 1Sfa9IhnoibE7C9B/Xyl8uuCse/RYR1EO9MG8XrTKJzt4iGM30AraBYMIBSU/KILFivk
 aTTY+cd2JjzzbdPOLFqjuRh5y+45tB2tUE0BMQSUCpCzl2+RAvbvzVUltmridUjG4uyf
 Ltgw==
X-Gm-Message-State: AOJu0Yw6jnbBrT/qTlKgYmam9mJtRlZrOa5UCbyGmsPkFKfpIc93CHh+
 WVDG9LY8Ly/s8JdBGKRFenxvBJzQTglp+ROdQVnDta/NRQuDut6eUT0uebmufHVw1rCwEfVzXxz
 evtlK7J6WTGSvvKTOLmZ+sEgd1rI=
X-Google-Smtp-Source: AGHT+IH5yWV2MTB8GD8ZBPOObocuxasEfpd0rtreicJN6RTpSYFBYudUl1giVLvL8zdlJ72EkJJA4I6ks7sihkMucqk=
X-Received: by 2002:a05:690c:7091:b0:6db:3b2f:a18a with SMTP id
 00721157ae682-6dbcc2610b5mr199461987b3.11.1726709742955; Wed, 18 Sep 2024
 18:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240913080800.40816-1-yaozhenguo@jd.com>
In-Reply-To: <20240913080800.40816-1-yaozhenguo@jd.com>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Thu, 19 Sep 2024 09:35:31 +0800
Message-ID: <CA+WzARnvD-S8pMb7Uma6Sw=20RfcTuGDj+gZo_cxqkqgXvypJg@mail.gmail.com>
Subject: Re: [PATCH V1] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
To: alex.bennee@linaro.org, mst@redhat.com, sgarzare@redhat.com
Cc: qemu-devel@nongnu.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x1134.google.com
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

yaozhenguo <yaozhenguo1@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=94 16:08=E5=86=99=E9=81=93=EF=BC=9A
>
> During the process of hot-unplug in vhost-user-net NIC, vhost_user_cleanu=
p
> may add same rcu node to rcu list. Function calls are as follows:
>
> vhost_user_cleanup
>     ->vhost_user_host_notifier_remove
>         ->call_rcu(n, vhost_user_host_notifier_free, rcu);
>     ->g_free_rcu(n, rcu);
>
> When this happens, QEMU will abort in try_dequeue:
>
> if (head =3D=3D &dummy && qatomic_mb_read(&tail) =3D=3D &dummy.next) {
>     abort();
> }
>
> Backtrace is as follows:
> 0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> 1  raise () at /usr/lib64/libc.so.6
> 2  abort () at /usr/lib64/libc.so.6
> 3  try_dequeue () at ../util/rcu.c:235
> 4  call_rcu_thread (0) at ../util/rcu.c:288
> 5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
> 6  start_thread () at /usr/lib64/libc.so.6
> 7  clone3 () at /usr/lib64/libc.so.6
>
> Reason for the abort is that adding two identical nodes to the rcu list w=
ill
> cause it becomes a ring. After dummy node is added to the tail of the lis=
t in
> try_dequeue, the ring is opened. But lead to a situation that only one no=
de is
> added to list and rcu_call_count is added twice. This will cause try_dequ=
eue
> abort.
>
> This issue happens when n->addr !=3D 0 in vhost_user_host_notifier_remove=
. It can
> happens in a hotplug stress test with a 32queue vhost-user-net type NIC.
> Because n->addr is set in VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG func=
tion.
> during device hotplug process and it is cleared in vhost_dev_stop during =
device
> hot-unplug. Since VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is a message=
 sent
> by DPDK to qemu, it is asynchronous. So, there is no guaranteed order bet=
ween
> the two processes of setting n->addr and clearing n->addr. If setting n->=
addr
> in hotplug occurs after clearing n->addr in hotunplug, the issue will occ=
ur.
> So, it is necessary to merge g_free_rcu and vhost_user_host_notifier_free=
 into
> one rcu node.
>
> Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNo=
tifiers")
>
> Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> ---
>  hw/virtio/vhost-user.c         | 34 ++++++++++++++++++----------------
>  include/hw/virtio/vhost-user.h |  1 +
>  2 files changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561da..b2da3cf 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1185,9 +1185,16 @@ static int vhost_user_set_vring_num(struct vhost_d=
ev *dev,
>
>  static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
>  {
> -    assert(n && n->unmap_addr);
> -    munmap(n->unmap_addr, qemu_real_host_page_size());
> -    n->unmap_addr =3D NULL;
> +    if (n->unmap_addr) {
> +        munmap(n->unmap_addr, qemu_real_host_page_size());
> +        n->unmap_addr =3D NULL;
> +    }
> +    if (n->need_free) {
> +        memory_region_transaction_begin();
> +        object_unparent(OBJECT(&n->mr));
> +        memory_region_transaction_commit();
> +        g_free(n);
> +    }
>  }
>
>  /*
> @@ -1195,17 +1202,20 @@ static void vhost_user_host_notifier_free(VhostUs=
erHostNotifier *n)
>   * under rcu.
>   */
>  static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
> -                                            VirtIODevice *vdev)
> +                                            VirtIODevice *vdev, bool fre=
e)
>  {
>      if (n->addr) {
>          if (vdev) {
> +            memory_region_transaction_begin();
>              virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, fals=
e);
> +            memory_region_transaction_commit();
>          }
>          assert(!n->unmap_addr);
>          n->unmap_addr =3D n->addr;
>          n->addr =3D NULL;
> -        call_rcu(n, vhost_user_host_notifier_free, rcu);
>      }
> +    n->need_free =3D free;
> +    call_rcu(n, vhost_user_host_notifier_free, rcu);
>  }

This brings up another problem. When the device is initialized,
problems may occur when the execution times of
vhost_user_get_vring_base and
vhost_user_backend_handle_vring_host_notifier are relatively close,
and the same node is submitted to the rcu list. This happened during
our regression testing. Therefore, modifications must be made to avoid
this problem.

vhost_user_get_vring_base
    vhost_user_host_notifier_remove(n, dev->vdev, false);
vhost_user_backend_handle_vring_host_notifier
    vhost_user_host_notifier_remove(n, dev->vdev, false);
>
>  static int vhost_user_set_vring_base(struct vhost_dev *dev,
> @@ -1280,7 +1290,7 @@ static int vhost_user_get_vring_base(struct vhost_d=
ev *dev,
>
>      VhostUserHostNotifier *n =3D fetch_notifier(u->user, ring->index);
>      if (n) {
> -        vhost_user_host_notifier_remove(n, dev->vdev);
> +        vhost_user_host_notifier_remove(n, dev->vdev, false);
>      }
>
>      ret =3D vhost_user_write(dev, &msg, NULL, 0);
> @@ -1562,7 +1572,7 @@ static int vhost_user_backend_handle_vring_host_not=
ifier(struct vhost_dev *dev,
>       * new mapped address.
>       */
>      n =3D fetch_or_create_notifier(user, queue_idx);
> -    vhost_user_host_notifier_remove(n, vdev);
> +    vhost_user_host_notifier_remove(n, vdev, false);
>
>      if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
>          return 0;
> @@ -2737,13 +2747,7 @@ static void vhost_user_state_destroy(gpointer data=
)
>  {
>      VhostUserHostNotifier *n =3D (VhostUserHostNotifier *) data;
>      if (n) {
> -        vhost_user_host_notifier_remove(n, NULL);
> -        object_unparent(OBJECT(&n->mr));
> -        /*
> -         * We can't free until vhost_user_host_notifier_remove has
> -         * done it's thing so schedule the free with RCU.
> -         */
> -        g_free_rcu(n, rcu);
> +        vhost_user_host_notifier_remove(n, NULL, true);
>      }
>  }
>
> @@ -2765,9 +2769,7 @@ void vhost_user_cleanup(VhostUserState *user)
>      if (!user->chr) {
>          return;
>      }
> -    memory_region_transaction_begin();
>      user->notifiers =3D (GPtrArray *) g_ptr_array_free(user->notifiers, =
true);
> -    memory_region_transaction_commit();
>      user->chr =3D NULL;
>  }
>
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 324cd86..a171f29 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
>      void *addr;
>      void *unmap_addr;
>      int idx;
> +    bool need_free;
>  } VhostUserHostNotifier;
>
>  /**
> --
> 1.8.3.1
>

