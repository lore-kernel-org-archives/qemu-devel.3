Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC04C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQl2-0004Vb-57; Fri, 09 May 2025 12:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uDQkx-0004A7-9G
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uDQku-0000LZ-SO
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746808761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srMI2g/tjPiWuM4zYo5KPb3LCL/1N2Q2GBGNV9AwH04=;
 b=OP4Y/afu7tYm7bzjPFixEvGJ1CaxJYLo5WoAhIwnAgvXSvooPdieOCCuL7n9wtA32hOW5p
 eRNVw+qFyn9vF9/FqaZuV2H1igHIUqGDPaYwbALiw32M+5kuAwgeaS1K1BWj42OvIRRRCi
 GdGVClW8jUThqv9030qlL4S3TdMqiX0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-V6CpBsh9NtWt2_VXSJjEbg-1; Fri, 09 May 2025 12:39:20 -0400
X-MC-Unique: V6CpBsh9NtWt2_VXSJjEbg-1
X-Mimecast-MFC-AGG-ID: V6CpBsh9NtWt2_VXSJjEbg_1746808759
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b1798d69so933410f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746808758; x=1747413558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srMI2g/tjPiWuM4zYo5KPb3LCL/1N2Q2GBGNV9AwH04=;
 b=AkHEUZGnO9CNzG7sujGYg2WuTrpG7LDj0+tYsqFS4/PeK/pPBjP+7KNqA2gTdphpY1
 j6bSdifKqV/DwGs3b9p9tHXmmd6CnjhDlBCXyDHtpqAjqXUhrgvrAcosartdUTzYlJ7Q
 12r8YhmAnxzTlItxJQtQi86O7BMvSifD76jwDH4VI/DUIH4T2wrgyb+BG2FaKgl9c4NZ
 aZp9bq55B93mWx/vrnu6xRU4XfXPAZjRIhrsN+ob+ZFGElMxXux0MN9E2T9dPsFUZWqC
 9++PMlyRKlChTsnf/Q+PvotdQIQuGLvsW464aY7z5Ggp9IBNHVFwsv812H8DzHbq77aN
 AgRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPcf7zLK1/hVXJTxq8HsGX9iFCh2RyrpmseV5HakIpkGr4sgzxbCplVJLapdfZxl8p00+1ZS5AGlmo@nongnu.org
X-Gm-Message-State: AOJu0Ywcc17BSq8V/XJc74BjLPdPxuGeLmiCxRwGbNtL0kwKhHWp5OVV
 wGKiYBr3inXs4WszntOkR7zkQOQ0Ns8wmJtGbrln73tqfCD1ZtzWnxPFEYyz1J7heU+2hiPa5PF
 yqW3SkGUU3nCEWlLOpEjUizw+C/C/m8/ZEQ4xWbW5K7nWft+txf3uuy61sKhY
X-Gm-Gg: ASbGncugCATY1FbGWk1JYoUFXyqpEhpyHyXCNs+4Zy+VC8wGqawOc/JXngjJvY/o/SJ
 2g0XPwWb++mUmhzfalRBC9DxOc12uiEX6qbniCyybWcVp5UJ7vcqCsubmQNsW/QfKRQMtBfBc6e
 e+bLcAodtnD+PZVDAOmsDRN6pEDyB+1hFlwfXI1VhvujGj9HUuWhLtgqmS4VMDk4Ol1TzMHMtwD
 uYfRdfHy1Eoxl7CUnN3dT3+9EoRipGm1emZmCgKvL3R6M6blBkGdO9EH/zSIaIEELcay//7gXOI
 0tBy6Q==
X-Received: by 2002:a05:6000:430d:b0:3a0:ac96:bd41 with SMTP id
 ffacd0b85a97d-3a1f643c6a4mr3670864f8f.27.1746808758551; 
 Fri, 09 May 2025 09:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHavhplC+6nqM3oY2QAmbhpJgYS4h5A+nbfoCPON8HNgBtcIo/NH4FgUtyf7lfstgX2yK7DnA==
X-Received: by 2002:a05:6000:430d:b0:3a0:ac96:bd41 with SMTP id
 ffacd0b85a97d-3a1f643c6a4mr3670843f8f.27.1746808758196; 
 Fri, 09 May 2025 09:39:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ee95asm3809235f8f.11.2025.05.09.09.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 09:39:17 -0700 (PDT)
Date: Fri, 9 May 2025 12:39:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: yuanminghao <yuanmh12@chinatelecom.cn>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250509123901-mutt-send-email-mst@kernel.org>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

Igor, WDYT?

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


