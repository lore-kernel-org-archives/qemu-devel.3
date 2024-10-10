Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C3CF11D2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syri6-0004A8-20; Thu, 10 Oct 2024 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1syri4-00049r-Qf
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:52:00 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1syri2-0001KL-RO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:52:00 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6e3121be692so7549517b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728561118; x=1729165918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdJlEYewMVj1/zJDzRAZoKp6fBi1EKaatF1w1pBNi4k=;
 b=RazKSgXNfUIdKOvoeueP8/xP6HQqaAFjKUC3fddVjVJYjZay9xkobSvlDUpOJm8vTA
 pd1qyhJHDTTwD3ewlYcKFTKs3mq1x038lVQAXvRsdTY/SfunpeBaPaW6INdmRbhailZW
 s55hUffIBybzECfypSa0t4zWHn1gjLJYJLia1ozv+ODvfvizP725yzP3GQUaLgLm0h4A
 kxpmuBTyvqRbrOsvc0QMSnqe0J3YpBfR/wmz2ku65sVaP6FPFrZA4FJv/+5BxnkJRUlI
 5MsCl5QaTWmAkFzerGIREwZmkOJJ4wdpYPoeAUXDQi606CDcLb3D8r9Ry1XQoGHzLBBV
 iFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728561118; x=1729165918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdJlEYewMVj1/zJDzRAZoKp6fBi1EKaatF1w1pBNi4k=;
 b=PqVmCq3asqyFWO+pQzOXCaBckSZZD9MyZvHTh/DPCkNUz3b2kdv/aJpVq8qCUpSygW
 op0EbvcCVgibZPt0whxM8o9guOjgfUFMpc1euiP8Wxrc+SrtppX7qJ8868gOx7pbkzFs
 Pp8QYG+oj6KOlzj/NHktxEt58gcfR7zS49h0HwZ2C8mQ89K3FCTDTrMZ63Qlz+wPHVBk
 TcvvmI7bG7g/p+f8JsdmMneqpLu9EwBWPYJukOpMqMObmA+rVP+6LTdgX/L2Aq/vCLZq
 C70UwiizEiDTKMHwhu6ofdiUGBwQlGqHC52V3SV2wAeUPbB6mPqb0TufOcVUhHbGgUpp
 cZIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr7978c1AV19AdAh9QW7rRgzvJ7DEEQb1ZdYrAqABC7nT1bjRm7rX30wSIEuVlStyhXQn2w/xGAEP0@nongnu.org
X-Gm-Message-State: AOJu0YyiuBkVTDrdIadbLsfXbtKtXYFidYYiEcwunVC3SpIOv3LUWv2V
 39YN9DNUthzXIe70fWg9vMyCz0LbyuRINRLj5B7mM9CZkjJ7mqB8gGaxyoNDm0UKGyTdm3FYqU8
 4lB15o77KBS/RfG14R0r4M4gocrE=
X-Google-Smtp-Source: AGHT+IGmKgUJdHkYA1fOpv1WJV9QM97qFLCZiaiFatUkdvxAdsuGOjhODiyspZdGwZCq5S0LuFEK2gb5KP9sraOcrG4=
X-Received: by 2002:a05:690c:448c:b0:6e2:446f:422c with SMTP id
 00721157ae682-6e322142d3amr58071757b3.21.1728561117751; Thu, 10 Oct 2024
 04:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241010061824.74819-1-yaozhenguo@jd.com>
 <hgkoxnyvewuo54otuoc32aaa4vh7o7qkmq3u7g4c4omy66giwp@3cbqzkx4oezj>
In-Reply-To: <hgkoxnyvewuo54otuoc32aaa4vh7o7qkmq3u7g4c4omy66giwp@3cbqzkx4oezj>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Thu, 10 Oct 2024 19:51:46 +0800
Message-ID: <CA+WzAR=f2iEFkSRqP++O-0hEz5NOKR6wj0dDCxbELmUJ4opKRw@mail.gmail.com>
Subject: Re: [PATCH V3] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org, 
 yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x112f.google.com
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

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=881=
0=E6=97=A5=E5=91=A8=E5=9B=9B 16:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 10, 2024 at 02:18:24PM GMT, yaozhenguo wrote:
> >During the hot-unplugging of vhost-user-net type network cards,
> >the vhost_user_cleanup function may add the same rcu node to
> >the rcu linked list.
> >The function call relationship in this case is as follows:
> >
> >vhost_user_cleanup
> >    ->vhost_user_host_notifier_remove
> >        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
> >    ->g_free_rcu(n, rcu);
> >
> >When this happens, QEMU will abort in try_dequeue:
> >
> >if (head =3D=3D &dummy && qatomic_mb_read(&tail) =3D=3D &dummy.next) {
> >    abort();
> >}
> >
> >backtrace is as follows::
> >0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> >1  raise () at /usr/lib64/libc.so.6
> >2  abort () at /usr/lib64/libc.so.6
> >3  try_dequeue () at ../util/rcu.c:235
> >4  call_rcu_thread (0) at ../util/rcu.c:288
> >5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
> >6  start_thread () at /usr/lib64/libc.so.6
> >7  clone3 () at /usr/lib64/libc.so.6
> >
> >The reason for the abort is that adding two identical nodes to
> >the rcu linked list will cause the rcu linked list to become a ring,
> >but when the dummy node is added after the two identical nodes,
> >the ring is opened. But only one node is added to list with
> >rcu_call_count added twice. This will cause rcu try_dequeue abort.
> >
> >This happens when n->addr !=3D 0. In some scenarios, this does happen.
> >For example, this situation will occur when using a 32-queue DPU
> >vhost-user-net type network card for hot-unplug testing, because
> >VhostUserHostNotifier->addr will be cleared during the processing of
> >VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG. However,it is asynchronous,
> >so we cannot guarantee that VhostUserHostNotifier->addr is zero in
> >vhost_user_cleanup. Therefore, it is necessary to merge g_free_rcu
> >and vhost_user_host_notifier_free into one rcu node.
> >
> >Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostN=
otifiers")
> >Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> >---
> >   V1->V2: add n->addr check in vhost_user_get_vring_base and vhost_user=
_backend_handle_vring_host_notifier to prevent submit same node to rcu list=
.
> >   V2->V3: 1. change "free" to "destroy"
> >           2. move "!n->addr && !destroy" checking to vhost_user_host_no=
tifier_remove
> >           3. move "!n" checking to vhost_user_host_notifier_remove
> >---
> > hw/virtio/vhost-user.c         | 43 ++++++++++++++++++----------------
> > include/hw/virtio/vhost-user.h |  1 +
> > 2 files changed, 24 insertions(+), 20 deletions(-)
>
> Some checkpatch errors:
>
> $ ./scripts/checkpatch.pl --strict --branch master..HEAD --codespell
> ERROR: braces {} are necessary for all arms of this statement
> #98: FILE: hw/virtio/vhost-user.c:1207:
> +    if (!n)
> [...]
>
> ERROR: braces {} are necessary for all arms of this statement
> #100: FILE: hw/virtio/vhost-user.c:1209:
> +    if (!destroy && !n->addr)
> [...]
>
> total: 2 errors, 0 warnings, 96 lines checked
>
I will fix it later.
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 00561daa06..f80d0af76f 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1185,9 +1185,16 @@ static int vhost_user_set_vring_num(struct vhost_=
dev *dev,
> >
> > static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
> > {
> >-    assert(n && n->unmap_addr);
> >-    munmap(n->unmap_addr, qemu_real_host_page_size());
> >-    n->unmap_addr =3D NULL;
> >+    if (n->unmap_addr) {
> >+        munmap(n->unmap_addr, qemu_real_host_page_size());
> >+        n->unmap_addr =3D NULL;
> >+    }
> >+    if (n->destroy) {
> >+        memory_region_transaction_begin();
> >+        object_unparent(OBJECT(&n->mr));
> >+        memory_region_transaction_commit();
> >+        g_free(n);
> >+    }
> > }
> >
> > /*
> >@@ -1195,17 +1202,25 @@ static void vhost_user_host_notifier_free(VhostU=
serHostNotifier *n)
> >  * under rcu.
> >  */
> > static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
> >-                                            VirtIODevice *vdev)
> >+                                            VirtIODevice *vdev, bool de=
stroy)
> > {
> >+    if (!n)
> >+        return;
> >+    if (!destroy && !n->addr)
>
> IIUC if `destroy` is false and `n->addr` is NULL, we don't have anything
> to do, so we can early return, right?
>
Yes.
> Maybe we can put a comment on that condition.
>
> >+        return;
>
> Better to use a single if here in this way:
>        if (!n || (!destroy && !n->addr)) {
>            return;
>        }
>
Got it!
> The rest LGTM!
>
> Thanks,
> Stefano
>
> >+
> >     if (n->addr) {
> >         if (vdev) {
> >+            memory_region_transaction_begin();
> >             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, fal=
se);
> >+            memory_region_transaction_commit();
> >         }
> >         assert(!n->unmap_addr);
> >         n->unmap_addr =3D n->addr;
> >         n->addr =3D NULL;
> >-        call_rcu(n, vhost_user_host_notifier_free, rcu);
> >     }
> >+    n->destroy =3D destroy;
> >+    call_rcu(n, vhost_user_host_notifier_free, rcu);
> > }
> >
> > static int vhost_user_set_vring_base(struct vhost_dev *dev,
> >@@ -1279,9 +1294,7 @@ static int vhost_user_get_vring_base(struct vhost_=
dev *dev,
> >     struct vhost_user *u =3D dev->opaque;
> >
> >     VhostUserHostNotifier *n =3D fetch_notifier(u->user, ring->index);
> >-    if (n) {
> >-        vhost_user_host_notifier_remove(n, dev->vdev);
> >-    }
> >+    vhost_user_host_notifier_remove(n, dev->vdev, false);
> >
> >     ret =3D vhost_user_write(dev, &msg, NULL, 0);
> >     if (ret < 0) {
> >@@ -1562,7 +1575,7 @@ static int vhost_user_backend_handle_vring_host_no=
tifier(struct vhost_dev *dev,
> >      * new mapped address.
> >      */
> >     n =3D fetch_or_create_notifier(user, queue_idx);
> >-    vhost_user_host_notifier_remove(n, vdev);
> >+    vhost_user_host_notifier_remove(n, vdev, false);
> >
> >     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> >         return 0;
> >@@ -2736,15 +2749,7 @@ static int vhost_user_set_inflight_fd(struct vhos=
t_dev *dev,
> > static void vhost_user_state_destroy(gpointer data)
> > {
> >     VhostUserHostNotifier *n =3D (VhostUserHostNotifier *) data;
> >-    if (n) {
> >-        vhost_user_host_notifier_remove(n, NULL);
> >-        object_unparent(OBJECT(&n->mr));
> >-        /*
> >-         * We can't free until vhost_user_host_notifier_remove has
> >-         * done it's thing so schedule the free with RCU.
> >-         */
> >-        g_free_rcu(n, rcu);
> >-    }
> >+    vhost_user_host_notifier_remove(n, NULL, true);
> > }
> >
> > bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **er=
rp)
> >@@ -2765,9 +2770,7 @@ void vhost_user_cleanup(VhostUserState *user)
> >     if (!user->chr) {
> >         return;
> >     }
> >-    memory_region_transaction_begin();
> >     user->notifiers =3D (GPtrArray *) g_ptr_array_free(user->notifiers,=
 true);
> >-    memory_region_transaction_commit();
> >     user->chr =3D NULL;
> > }
> >
> >diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-us=
er.h
> >index 324cd8663a..9a3f238b43 100644
> >--- a/include/hw/virtio/vhost-user.h
> >+++ b/include/hw/virtio/vhost-user.h
> >@@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
> >     void *addr;
> >     void *unmap_addr;
> >     int idx;
> >+    bool destroy;
> > } VhostUserHostNotifier;
> >
> > /**
> >--
> >2.41.0
> >
>

