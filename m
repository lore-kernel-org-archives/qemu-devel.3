Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5DC3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00uZ-0006Uq-AF; Wed, 02 Apr 2025 12:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u00uW-0006UZ-Vx
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u00uU-0004ws-VI
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DcQ9JPLY+NQxqPGKqdH2kZ8J76Ha4VJ87KnNMmTr3I=;
 b=d80S1NrZRHyrYIyGGOP7oqAn7yr0K325dm50DGDgTuaga5BioDld6ACBBq4Gagz7uaPOJg
 F0c1im1aheraCQCqAQ3KRA6dLxj0OAF1813z/VqV1MMXHvg2/Q2bv/X91kco2qkGN/zPu6
 RxXAQuYiLFVeaX2N0yw0aQ/w+b8dylc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-teiIyNUmPCK-IuA39JlFRg-1; Wed, 02 Apr 2025 12:25:47 -0400
X-MC-Unique: teiIyNUmPCK-IuA39JlFRg-1
X-Mimecast-MFC-AGG-ID: teiIyNUmPCK-IuA39JlFRg_1743611146
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so56157275e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611146; x=1744215946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DcQ9JPLY+NQxqPGKqdH2kZ8J76Ha4VJ87KnNMmTr3I=;
 b=hMukMPSwkSs+3n17bMnUVTXg7Ta3H5C1QdjFvWgwtJbZ3R937lRPMj+g/78zWj7CkA
 JWFzi7TcK0VpPV9/qIRhoqoxelaDkVlUFclmaXTOdJVV7gcK5g1GZTAt12JRm+FOdIJN
 MEj9/Ndc5BhTP01vlO5OIidJpWcVwzb1cTGcoKH8X4Je72RGya9tRmxDIEDnTK7zNtBO
 7VtgJR39m8Cuth7XGiPhTY0UQWRZb//CGWLlShySbfyyjgZniszsvuEct6JaT9J9GfLe
 5BTLCx5s8Y/PhPFLH3+d3AZv5PaPSxedvNGVBnzQ64QS6xKtEYlMCybaJRXSF0xNJwnN
 Ug0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJDYxaZhJciPMlCujfngxWndbI03rTeAf1K+x8wKiIXUTcnBOJo1dL/Gd+pLBrGsCoSUZTc6vEZam@nongnu.org
X-Gm-Message-State: AOJu0YwgZFimC9JO3cZwZ7lh7XgC4a852etE3eRHFUJ6aeQTxprBvIi2
 StNKVavkXL1uAwfsF91L1cF78o8TQg8Tv54dQ5B0hGN9bK1wy2JY0X8mSVo/KtxQNCFB3h4sXS2
 7yYpR420/2b4nUUCqhotDsMZ+5xe6WAUM4LSROVBtw3hXfBpWpkwY
X-Gm-Gg: ASbGnctk+1PhbkuhKQzmBCvNuWQYMh1wPcEC51SsWyktMAKUJ4xiHoEdl/sQaqzoTPW
 e9Ya1jnxXlsNWsThPIcdzqiWL9/pqo+sKIRnFV/tsufyJ2SH8BjBWgQ0//pAeLOPyez8isnR73q
 rlhIF/u2UD/UdMb01a5FrU0aBvSPCaKu4ed4Uh6yAQh4vr7LfAzo2+NFCijTW3vhmFrgEbY7u7C
 GLwRCDt7mT5POVOUEzdUKeKu9rVqsbs1nKc2gC5oOi07rXjums5uuC0If5NAOHJaFGcwbO/rvoT
 4RMJHpsTcA==
X-Received: by 2002:a05:600c:1388:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43db622a2a1mr126665945e9.11.1743611145649; 
 Wed, 02 Apr 2025 09:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAGcr9BCI02U4lPAWoQkAXrQzSvuzxDHqZJM6nD7/u9TqIai4v7jVIsjPJuyKwYGW2qSdrPA==
X-Received: by 2002:a05:600c:1388:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-43db622a2a1mr126665735e9.11.1743611145224; 
 Wed, 02 Apr 2025 09:25:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a41e8sm17669689f8f.92.2025.04.02.09.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:25:44 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:25:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yuanminghao <yuanmh12@chinatelecom.cn>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250402122528-mutt-send-email-mst@kernel.org>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Mar 03, 2025 at 01:02:17PM -0500, yuanminghao wrote:
> > > Global used_memslots or used_shared_memslots is updated to 0 unexpectly
> > 
> > it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> > It's likely a bug somewhere else.
> > 
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

Igor were you looking at this?

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


