Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A05BCED606
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 06:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syPva-0002IW-5J; Wed, 09 Oct 2024 02:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1syPvX-0002HM-7d
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:12:04 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1syPvU-0007QN-Ux
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:12:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so1868100a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728454319; x=1729059119; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tBiL8B6tsvKLlCGkFPF3Jl5286OTVzD16H8WMO6FY3w=;
 b=TskSwBSM6N2oTHXmCGVh5AYhEfaXU+UcbimeSpgCSurGW+2Ws5434eEFMsE1sg+gMd
 kyMLQilAmHzQCFIwFBMIuNQALy1PZBIKXXGDxBBzfnYQkB9xTXeZxmL1+/WlStYfvoBo
 yGpxQTgJQivezz0MmMbQiK3UDHqnncNERTZrUNHDMPUakDwcwxdXDt98NoElJDMg9DFu
 X3dNj/YYjWg7tZWn7RdC6ghn4Tdbe8xGypzmU6A+WU43fXS4V8FWiYxKsszjuI0kwReP
 5xiVTvCms6EISkjGDB4gUGw7mBXrBhy/gB7h7L/fePy1AelST6+EBRUPihY+qKnfYhtK
 yDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728454319; x=1729059119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBiL8B6tsvKLlCGkFPF3Jl5286OTVzD16H8WMO6FY3w=;
 b=vrXZm2hdyBt3E7cNcIj9+0hcMYHQC4rx5dZ81ZFBQ45WBAINQu4UTph4xQCM5HMdpD
 3JFC2zTg/d8dIQrA6kzXP3cTmK+evfrJ/ChPub/xQEO72OhVwddPoRYRehKnlxV9L9rN
 CwFCw1Vd+eA2LMtfzY5tYCjBh4RkkNYkb0nKEYKr4Qe9VT+/yZzQOz5+pFnzIuNOwTv6
 SpS2oV0BbhCM2RQBkc+XEplwNB28uevQnkKLMX9UbLSgGtby0FWQDsq14gyiIXZAyk+F
 iLeE/9EOlewrupt+OeHvSRGVMH829eQKdXP3yWf38d/Nc7Ixp1wPmbtqLIuSZq7vpM6F
 01eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc15kITzrNA6G5OxCXMK7h5O91KVONnNLu8I3nemKY2vylgsBElPxor9EfWpWDrhjud41tOofdfZ9Z@nongnu.org
X-Gm-Message-State: AOJu0Yx71V9LblmYzpIAJPeY+ivz6YwtJgYVAazyaP5uuEuTbPqstrds
 TlGO269f63ugb2leNtziO638sXJEa5ehltUrQREfZuhjFkUL8BlkjFu9FnZg
X-Google-Smtp-Source: AGHT+IGI77aYdjwnPA7CGgSlKbtyG38hZCP7bijg5RB9bpXWSjoNMySMWdWPx+Ab9RQTq+ATc6b+lA==
X-Received: by 2002:a05:6a20:6b96:b0:1d8:a67b:9219 with SMTP id
 adf61e73a8af0-1d8a67b92d0mr954909637.15.1728454318884; 
 Tue, 08 Oct 2024 23:11:58 -0700 (PDT)
Received: from ZBMAC-b2a081fc7 ([124.156.142.54])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f680c63esm7740372a12.9.2024.10.08.23.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 23:11:58 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:11:54 +0800
From: Zhenguo Yao <yaozhenguo1@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 yaozhenguo@jd.com
Subject: Re: [PATCH V2] virtio/vhost-user: fix qemu abort when hotunplug
 vhost-user-net device
Message-ID: <ZwYeqpGQIfC60Gui@ZBMAC-b2a081fc7>
References: <20240919072944.21262-1-yaozhenguo@jd.com>
 <akeix6af5fnabwotvaxdvr6ag3xyeuopgsurs3yqtyetwnli2s@cutfouykwadf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akeix6af5fnabwotvaxdvr6ag3xyeuopgsurs3yqtyetwnli2s@cutfouykwadf>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-pg1-x52f.google.com
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

On Tue, Oct 01, 2024 at 02:21:55PM +0200, Stefano Garzarella wrote:
> On Thu, Sep 19, 2024 at 03:29:44PM GMT, yaozhenguo wrote:
> > During the process of hot-unplug in vhost-user-net NIC, vhost_user_cleanup
> > may add same rcu node to rcu list. Function calls are as follows:
> > 
> > vhost_user_cleanup
> >    ->vhost_user_host_notifier_remove
> >        ->call_rcu(n, vhost_user_host_notifier_free, rcu);
> >    ->g_free_rcu(n, rcu);
> > 
> > When this happens, QEMU will abort in try_dequeue:
> > 
> > if (head == &dummy && qatomic_mb_read(&tail) == &dummy.next) {
> >    abort();
> > }
> > 
> > Backtrace is as follows:
> > 0  __pthread_kill_implementation () at /usr/lib64/libc.so.6
> > 1  raise () at /usr/lib64/libc.so.6
> > 2  abort () at /usr/lib64/libc.so.6
> > 3  try_dequeue () at ../util/rcu.c:235
> > 4  call_rcu_thread (0) at ../util/rcu.c:288
> > 5  qemu_thread_start (0) at ../util/qemu-thread-posix.c:541
> > 6  start_thread () at /usr/lib64/libc.so.6
> > 7  clone3 () at /usr/lib64/libc.so.6
> > 
> > Reason for the abort is that adding two identical nodes to the rcu list will
> > cause it becomes a ring. After dummy node is added to the tail of the list in
> > try_dequeue, the ring is opened. But lead to a situation that only one node is
> > added to list and rcu_call_count is added twice. This will cause try_dequeue
> > abort.
> > 
> > This issue happens when n->addr != 0 in vhost_user_host_notifier_remove. It can
> > happens in a hotplug stress test with a 32queue vhost-user-net type NIC.
> > Because n->addr is set in VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG function.
> > during device hotplug process and it is cleared in vhost_dev_stop during device
> > hot-unplug. Since VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG is a message sent
> > by DPDK to qemu, it is asynchronous. So, there is no guaranteed order between
> > the two processes of setting n->addr and clearing n->addr. If setting n->addr
> > in hotplug occurs after clearing n->addr in hotunplug, the issue will occur.
> > So, it is necessary to merge g_free_rcu and vhost_user_host_notifier_free into
> > one rcu node.
> > 
> > Fixes: 503e355465 ("virtio/vhost-user: dynamically assign VhostUserHostNotifiers")
> > 
> > Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> > ---
> > 
> > V1->V2:
> >    add n->addr check in vhost_user_get_vring_base and vhost_user_backend_handle_vring_host_notifier
> >    to prevent submit same node to rcu list.
> > 
> > ---
> > hw/virtio/vhost-user.c         | 39 +++++++++++++++++++++------------------
> > include/hw/virtio/vhost-user.h |  1 +
> > 2 files changed, 22 insertions(+), 18 deletions(-)
> > 
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 00561da..ba4c09c 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -51,7 +51,6 @@
> > #else
> > #define VHOST_USER_MAX_RAM_SLOTS 512
> > #endif
> > -
> > /*
> >  * Maximum size of virtio device config space
> >  */
> > @@ -1185,9 +1184,16 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
> > 
> > static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
> > {
> > -    assert(n && n->unmap_addr);
> > -    munmap(n->unmap_addr, qemu_real_host_page_size());
> > -    n->unmap_addr = NULL;
> > +    if (n->unmap_addr) {
> > +        munmap(n->unmap_addr, qemu_real_host_page_size());
> > +        n->unmap_addr = NULL;
> > +    }
> > +    if (n->need_free) {
> > +        memory_region_transaction_begin();
> > +        object_unparent(OBJECT(&n->mr));
> > +        memory_region_transaction_commit();
> > +        g_free(n);
> > +    }
> > }
> > 
> > /*
> > @@ -1195,17 +1201,20 @@ static void vhost_user_host_notifier_free(VhostUserHostNotifier *n)
> >  * under rcu.
> >  */
> > static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,
> > -                                            VirtIODevice *vdev)
> > +                                            VirtIODevice *vdev, bool free)
> 
> What about `destroy` instead of `free`?
> 
> In that way is more clear that it should be true when called by
> `vhost_user_state_destroy()`.
> 
Yes, "destroy" is better.
> > {
> >     if (n->addr) {
> >         if (vdev) {
> > +            memory_region_transaction_begin();
> >             virtio_queue_set_host_notifier_mr(vdev, n->idx, &n->mr, false);
> > +            memory_region_transaction_commit();
> >         }
> >         assert(!n->unmap_addr);
> >         n->unmap_addr = n->addr;
> >         n->addr = NULL;
> > -        call_rcu(n, vhost_user_host_notifier_free, rcu);
> >     }
> 
> Instead of checking n->addr in the caller, I suggest to move the check
> here:
> 
>       if (destroy || n->unmap_addr) {
>           s->destroy = destroy;
>           call_rcu(n, vhost_user_host_notifier_free, rcu);
>       }
> 
> Thanks,
> Stefano

I think there will be other problem with this modification. Because the
interval between two submissions to the rcu list may be relatively short.
During this period, it is possible that the rcu thread has been scheduled away. 
Therefore, the rcu task submitted for the first time does not run. It is still  
possible to submit two identical rcu nodes to the rcu list.                     
                                                                                
Below is this situation:                      
                                                                                
1: destroy == false and n->addr != NULL                                         
                                                                                
vhost_user_get_vring_base                                                       
  -> vhost_user_host_notifier_remove;                                           
  n->unmap_addr = n->addr;                                                      
  n->addr = NULL;                                                               
   -> call_rcu                                                                  
                                                                                
2: destroy == false and n->addr == NULL but n->unmap_addr != NULL               
  Because rcu thread has been scheduled away, n->unmap_addr has not been         
  cleared yet                                                                   
                                                                                
vhost_user_backend_handle_vring_host_notifier                                   
  -> vhost_user_host_notifier_remove;                                           
   -> call_rcu                                                                  
                                                                                
So, I think below modification may be better:                                   
                                                                                
static void vhost_user_host_notifier_remove(VhostUserHostNotifier *n,           
                                            VirtIODevice *vdev, bool destroy)   
{                                                                               
+    if (!destroy && !n->addr)                                                  
+        return;                                                                
}                                                           
> 
> > +    n->need_free = free;
> > +    call_rcu(n, vhost_user_host_notifier_free, rcu);
> > }
> > 
> > static int vhost_user_set_vring_base(struct vhost_dev *dev,
> > @@ -1279,8 +1288,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
> >     struct vhost_user *u = dev->opaque;
> > 
> >     VhostUserHostNotifier *n = fetch_notifier(u->user, ring->index);
> > -    if (n) {
> > -        vhost_user_host_notifier_remove(n, dev->vdev);
> > +    if (n && n->addr) {
> > +        vhost_user_host_notifier_remove(n, dev->vdev, false);
> >     }
> > 
> >     ret = vhost_user_write(dev, &msg, NULL, 0);
> > @@ -1562,7 +1571,9 @@ static int vhost_user_backend_handle_vring_host_notifier(struct vhost_dev *dev,
> >      * new mapped address.
> >      */
> >     n = fetch_or_create_notifier(user, queue_idx);
> > -    vhost_user_host_notifier_remove(n, vdev);
> > +    if (n && n->addr) {
> > +        vhost_user_host_notifier_remove(n, vdev, false);
> > +    }
> > 
> >     if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> >         return 0;
> > @@ -2737,13 +2748,7 @@ static void vhost_user_state_destroy(gpointer data)
> > {
> >     VhostUserHostNotifier *n = (VhostUserHostNotifier *) data;
> >     if (n) {
> > -        vhost_user_host_notifier_remove(n, NULL);
> > -        object_unparent(OBJECT(&n->mr));
> > -        /*
> > -         * We can't free until vhost_user_host_notifier_remove has
> > -         * done it's thing so schedule the free with RCU.
> > -         */
> > -        g_free_rcu(n, rcu);
> > +        vhost_user_host_notifier_remove(n, NULL, true);
> >     }
> > }
> > 
> > @@ -2765,9 +2770,7 @@ void vhost_user_cleanup(VhostUserState *user)
> >     if (!user->chr) {
> >         return;
> >     }
> > -    memory_region_transaction_begin();
> >     user->notifiers = (GPtrArray *) g_ptr_array_free(user->notifiers, true);
> > -    memory_region_transaction_commit();
> >     user->chr = NULL;
> > }
> > 
> > diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> > index 324cd86..a171f29 100644
> > --- a/include/hw/virtio/vhost-user.h
> > +++ b/include/hw/virtio/vhost-user.h
> > @@ -54,6 +54,7 @@ typedef struct VhostUserHostNotifier {
> >     void *addr;
> >     void *unmap_addr;
> >     int idx;
> > +    bool need_free;
> > } VhostUserHostNotifier;
> > 
> > /**
> > -- 
> > 1.8.3.1
> > 
> 

