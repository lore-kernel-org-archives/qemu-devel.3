Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127B5C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoWK-0001BS-Ux; Tue, 13 May 2025 08:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEoWD-00018d-95
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uEoW6-00057G-F9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747138426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWMbWUnoNvl8pM5xguHwTent+6bCwWzYj9aHH84WV58=;
 b=Wy5T2mmMcQxlnI0j3Ksf5PMN9AHiKsk/FU7m9EmqQGq8BCCjGJmhSHd6PqKSUHule8T+jV
 DkAx5sZzbbIi61xp9vF0EKk5MrloqvGxM2KpyS0eT5okdTNTeetUlbqLevz8Z7oT6tvohB
 rlWmnkJUva66vR7uP8gGOqb/5XexMgc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-EL1mwkmkOC2ie-9hEWN10A-1; Tue, 13 May 2025 08:13:45 -0400
X-MC-Unique: EL1mwkmkOC2ie-9hEWN10A-1
X-Mimecast-MFC-AGG-ID: EL1mwkmkOC2ie-9hEWN10A_1747138424
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso41708195e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 05:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747138424; x=1747743224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWMbWUnoNvl8pM5xguHwTent+6bCwWzYj9aHH84WV58=;
 b=TlnSx+hWN0pDDBnRt+hH8NPYxXXxod5tWfdeOxVFL0Ie5PDsMjI7G3TvBex6c4EgDF
 oJyPsy2tx+Hg8Zgq5S+ZBiPI80PtmGmugYKSIgF7y+CCFg9cLCSJG6yHBZwF7bQw4Wm5
 4kiHMCtQp8IOkuEAbw+8gML+pCAaIs/M48f4T4MWB5moffKp3VczDvbqjLcjlFnoY4Ak
 6gsIsjz2H6Rg860iRv6R//UMvopfM/0RgSfnh3v0mrAIRIdXeY8T4HS/2CaQ7llJh4L1
 Akh5/OnK/GmjlD82oUwS8sRw5cgMUM8JJRwOINEQj+4NptB1kLVNKhEEk2vmekwmOJDJ
 Zgeg==
X-Gm-Message-State: AOJu0YxN0WLyZF0XJnb3nSdHp2EZ/fUXZoO0+D9Zo49gTA61W4/FXr6m
 w0o/+H1nn48bZI5DNo7Nt3J4xphnq7MGmsWc6qDn2M83gyDQgPgp6sP6LC+HzAt3g6xHh4BhZg/
 PhUCgNDRr83to0Z0igd9/7+zSeDIE34J4xracNbZfGT81l3G4eskE
X-Gm-Gg: ASbGnct1/t+14t6mwEBP+tpEyx5nCHXESJAtOD5gZ+2P9ewb1ScyAt/qMP7LScKM37b
 xJ8r5wBJS9eFJtULC/J1i9dviumLRjVD8AUk+GBvat2/r8lRjt9Ciar4HdbFplnYWCJyvjfKZSi
 nJ6SbcdtMjany1lV95YR3LYE2VVGbRjNXzbT1SOVW5U4E8QJ8gGQMkM/esV6Wyi6XbfLwcBWQvS
 Mnc9eiYnqg4QyhrN9cdA3zNs75+bC5Ylu9CoJ0m+8uVpDwyxhK4/8fVsiZPEl/zEMBa0Hb7v+s/
 D4Yvxx7lB4YVAh/gERVr5mbo2C8Unrdi
X-Received: by 2002:a05:600c:4454:b0:442:c98f:d8cf with SMTP id
 5b1f17b1804b1-442d6d4b7d5mr175534545e9.16.1747138423920; 
 Tue, 13 May 2025 05:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf2hMRZ6MBDRRE4UYYeQRBCxdQgIi3iPwbsai6l9p/9ayeDFe6mD1TJQUoZSjp2DqR3McS1Q==
X-Received: by 2002:a05:600c:4454:b0:442:c98f:d8cf with SMTP id
 5b1f17b1804b1-442d6d4b7d5mr175534175e9.16.1747138423493; 
 Tue, 13 May 2025 05:13:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7b83sm202395945e9.33.2025.05.13.05.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 05:13:43 -0700 (PDT)
Date: Tue, 13 May 2025 14:13:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: yuanminghao <yuanmh12@chinatelecom.cn>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
In-Reply-To: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon,  3 Mar 2025 13:02:17 -0500
yuanminghao <yuanmh12@chinatelecom.cn> wrote:

> > > Global used_memslots or used_shared_memslots is updated to 0 unexpectly  
> > 
> > it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> > It's likely a bug somewhere else.

I haven't touched this code for a long time, but I'd say if we consider multiple
devices, we shouldn't do following:

static void vhost_commit(MemoryListener *listener)
    ...
    if (dev->vhost_ops->vhost_backend_no_private_memslots &&                     
        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {                
        used_shared_memslots = dev->mem->nregions;                               
    } else {                                                                     
        used_memslots = dev->mem->nregions;                              
    }

where value dev->mem->nregions gets is well hidden/obscured
and hard to trace where tail ends => fragile.

CCing David (accidental victim) who rewrote this part the last time,
perhaps he can suggest a better way to fix the issue.



> > Please describe a way to reproduce the issue.
> >   
> Hi, Igor Mammedov,
>   Sorry for the late response, here are the steps to reproduce the issue:
> 
>   1.start a domain with 1Core 1GiB memory, no network interface.
>   2.print used_memslots with gdb
>     gdb -p ${qemupid} <<< "p used_memslots"
>     $1 = 0
>   3.attach a network interface net1
>   cat>/tmp/net1.xml <<EOF  
>   <interface type='network'>
>     <mac address='52:54:00:12:34:56'/>
>     <source network='default'/>
>     <model type='virtio'/>
>   </interface>
>   EOF
>   virsh attach-device dom /tmp/net1.xml --live
>   4.print current used_memslots with gdb
>     gdb -p ${qemupid} <<< "p used_memslots"
>     $1 = 2
>   5.attach another network interface net2
>   cat>/tmp/net2.xml <<EOF  
>   <interface type='network'>
>     <mac address='52:54:00:12:34:78'/>
>     <source network='default'/>
>     <model type='virtio'/>
>   </interface>
>   EOF
>   virsh attach-device dom /tmp/net2.xml --live
>   6.print current used_memslots with gdb
>     gdb -p ${qemupid} <<< "p used_memslots"
>     $1 = 2
>   7.detach network interface net2
>   virsh detach-device dom /tmp/net2.xml --live
>   8.print current used_memslots with gdb
>     gdb -p ${qemupid} <<< "p used_memslots"
>     $1 = 0
> After detaching net2, the used_memslots was reseted to 0, which was expected to be 2.
> 
> > > when a vhost device destroyed. This can occur during scenarios such as live
> > > detaching a vhost device or restarting a vhost-user net backend (e.g., OVS-DPDK):
> > >  #0  vhost_commit(listener) at hw/virtio/vhost.c:439
> > >  #1  listener_del_address_space(as, listener) at memory.c:2777
> > >  #2  memory_listener_unregister(listener) at memory.c:2823
> > >  #3  vhost_dev_cleanup(hdev) at hw/virtio/vhost.c:1406
> > >  #4  vhost_net_cleanup(net) at hw/net/vhost_net.c:402
> > >  #5  vhost_user_start(be, ncs, queues) at net/vhost-user.c:113
> > >  #6  net_vhost_user_event(opaque, event) at net/vhost-user.c:281
> > >  #7  tcp_chr_new_client(chr, sioc) at chardev/char-socket.c:924
> > >  #8  tcp_chr_accept(listener, cioc, opaque) at chardev/char-socket.c:961
> > >
> > > So we skip the update of used_memslots and used_shared_memslots when destroying
> > > vhost devices, and it should work event if all vhost devices are removed.
> > >
> > > Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
> > > ---
> > >  hw/virtio/vhost.c         | 14 +++++++++-----
> > >  include/hw/virtio/vhost.h |  1 +
> > >  2 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 6aa72fd434..2258a12066 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -666,11 +666,13 @@ static void vhost_commit(MemoryListener *listener)
> > >      dev->mem = g_realloc(dev->mem, regions_size);
> > >      dev->mem->nregions = dev->n_mem_sections;
> > > 
> > > -    if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> > > -        dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> > > -        used_shared_memslots = dev->mem->nregions;
> > > -    } else {
> > > -        used_memslots = dev->mem->nregions;
> > > +    if (!dev->listener_removing) {
> > > +        if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> > > +            dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> > > +            used_shared_memslots = dev->mem->nregions;
> > > +        } else {
> > > +            used_memslots = dev->mem->nregions;
> > > +        }
> > >      }
> > > 
> > >      for (i = 0; i < dev->n_mem_sections; i++) {
> > > @@ -1668,7 +1670,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
> > >      }
> > >      if (hdev->mem) {
> > >          /* those are only safe after successful init */
> > > +        hdev->listener_removing = true;
> > >          memory_listener_unregister(&hdev->memory_listener);
> > > +        hdev->listener_removing = false;
> > >          QLIST_REMOVE(hdev, entry);
> > >      }
> > >      migrate_del_blocker(&hdev->migration_blocker);
> > > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > > index a9469d50bc..037f85b642 100644
> > > --- a/include/hw/virtio/vhost.h
> > > +++ b/include/hw/virtio/vhost.h
> > > @@ -133,6 +133,7 @@ struct vhost_dev {
> > >      QLIST_HEAD(, vhost_iommu) iommu_list;
> > >      IOMMUNotifier n;
> > >      const VhostDevConfigOps *config_ops;
> > > +    bool listener_removing;
> > >  };
> > > 
> > >  extern const VhostOps kernel_ops;  
> 


