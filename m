Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E52CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 06:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1runTP-0004wp-HI; Thu, 11 Apr 2024 01:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1runTO-0004wb-8F
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 01:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1runTM-0000g6-Cn
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 01:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712815183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMGbiH0LwuW9DxzY4C/VTqAbFFjKdrM8DGiI0pI5P+U=;
 b=XRLNw6b4THIwEW1lHWT0nPSbrFbC9xOJP/lqiFOiV5B+4bIZCOZO/Jcr6o/JExXNSs+ha3
 AC0B77qWQ6ed4LDIrNu0GlddiDv7YdDo4xgzo2B8uZlAQ0eRfbjO1tYfgaf1kEf8DGxXPj
 LCNOPXt3cjLz9v8X4ukhzj7zXQ67ssA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-aptzTin3PcuU-0ajE6IUdg-1; Thu, 11 Apr 2024 01:59:41 -0400
X-MC-Unique: aptzTin3PcuU-0ajE6IUdg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-516c5810897so5975434e87.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 22:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712815180; x=1713419980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMGbiH0LwuW9DxzY4C/VTqAbFFjKdrM8DGiI0pI5P+U=;
 b=UdtE0PGA7dmuuRjgt132JqOmJQcA8Y2BAOUdvQPKhF7fmEpO0qjwQ2Tbv6SXyQSu91
 w3RojfE1N2E31vmlUJCB6W7TNJUAg6JTXVz2gD4vglBTXXTAmO9mCUwrhta2p+8bOTxc
 7pG81xhTr6dEhwQR1iOARWh9af+1TtICeXuetFqmHhaFMc7w1HaqMFdv1U2cQgkXh6k4
 uighJkHtFNVTAZL7GQv+Uyk7asce7+X1a7nxz15XCB1GkC6SdXfSKSJzjX4QnoSUyBcT
 +X4Resi6Hf0uCn1rE4gMlBfDbeejRruYqK7MybAB6p1O4pRa4ZO5qT0J6O5gJDCem09l
 5IaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHe4tRlAOcfF4Hl2rqhLsV2BwguuHAotLQvMX6tZNDH7kEhGXFgmFOhX4zpfRWNL6HSuxUunRSxgnTdMZbgXwl1sgRgiM=
X-Gm-Message-State: AOJu0Yzs3jYKvVRECHAZx/+YDWVBQcjkRMGYKB6u1vYND6nNxkD2tzy5
 /ieqhBRhTtRj4bqpTMeemEgWhmy+8D/MKsAjl0GGYBhq4cl+eeT5SROhlbm46ACDNO8ejkfMW26
 CvtNNK6EkauYapmib8AKLPsIcVWedjU2MYeCgFNZx1cafZwqy8ki7tHUk4sMEqVdagz6ijejZdl
 rWmJRtwJEQpIZzjCySxMAPIY6u6QI=
X-Received: by 2002:a19:2d0b:0:b0:513:c54d:d4a with SMTP id
 k11-20020a192d0b000000b00513c54d0d4amr3336436lfj.5.1712815180134; 
 Wed, 10 Apr 2024 22:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWJogMLshHeOZRy2IC5syeZFNlyOS7P6WonRlMrHzYD9khmGQYfKcFtl/h4pohL7UivV8qXjsrCEEjSxuo44E=
X-Received: by 2002:a19:2d0b:0:b0:513:c54d:d4a with SMTP id
 k11-20020a192d0b000000b00513c54d0d4amr3336426lfj.5.1712815179798; Wed, 10 Apr
 2024 22:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240411041130.449406-1-lulu@redhat.com>
 <20240411015436-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240411015436-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 11 Apr 2024 13:59:02 +0800
Message-ID: <CACLfguUbJ+Wyxr+2SAsA1UnvUk7JLX5nv=QPCbch5t4g=UJsZw@mail.gmail.com>
Subject: Re: [PATCH v4] virtio-pci: Fix the crash that the vector was used
 after released.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 11, 2024 at 1:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 11, 2024 at 12:11:30PM +0800, Cindy Lu wrote:
> > During the booting process of the non-standard image, the behavior of t=
he
> > called function in qemu is as follows:
> >
> > 1. vhost_net_stop() was triggered by guest image. This will call the fu=
nction
> > virtio_pci_set_guest_notifiers() with assgin=3D false,
> > virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vec=
tor 0
> >
> > 2. virtio_reset() was triggered, this will set configure vector to VIRT=
IO_NO_VECTOR
> >
> > 3.vhost_net_start() was called (at this time, the configure vector is
> > still VIRTIO_NO_VECTOR) and then call virtio_pci_set_guest_notifiers() =
with
> > assgin=3Dtrue, so the irqfd for vector 0 is still not "init" during thi=
s process
> >
> > 4. The system continues to boot and sets the vector back to 0. After th=
at
> > msix_fire_vector_notifier() was triggered to unmask the vector 0 and  m=
eet the crash
> >
> > To fix the issue, we need to support changing the vector after VIRTIO_C=
ONFIG_S_DRIVER_OK is set.
> >
> > (gdb) bt
> > 0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Ds=
igno@entry=3D6, no_tid=3Dno_tid@entry=3D0)
> >     at pthread_kill.c:44
> > 1  0x00007fc87148ec53 in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at pthread_kill.c:78
> > 2  0x00007fc87143e956 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/posix/raise.c:26
> > 3  0x00007fc8714287f4 in __GI_abort () at abort.c:79
> > 4  0x00007fc87142871b in __assert_fail_base
> >     (fmt=3D0x7fc8715bbde0 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =
assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "../accel/=
kvm/kvm-all.c", line=3D1837, function=3D<optimized out>) at assert.c:92
> > 5  0x00007fc871437536 in __GI___assert_fail
> >     (assertion=3D0x5606413efd53 "ret =3D=3D 0", file=3D0x5606413ef87d "=
../accel/kvm/kvm-all.c", line=3D1837, function=3D0x5606413f06f0 <__PRETTY_F=
UNCTION__.19> "kvm_irqchip_commit_routes") at assert.c:101
> > 6  0x0000560640f884b5 in kvm_irqchip_commit_routes (s=3D0x560642cae1f0)=
 at ../accel/kvm/kvm-all.c:1837
> > 7  0x0000560640c98f8e in virtio_pci_one_vector_unmask
> >     (proxy=3D0x560643c65f00, queue_no=3D4294967295, vector=3D0, msg=3D.=
.., n=3D0x560643c6e4c8)
> >     at ../hw/virtio/virtio-pci.c:1005
> > 8  0x0000560640c99201 in virtio_pci_vector_unmask (dev=3D0x560643c65f00=
, vector=3D0, msg=3D...)
> >     at ../hw/virtio/virtio-pci.c:1070
> > 9  0x0000560640bc402e in msix_fire_vector_notifier (dev=3D0x560643c65f0=
0, vector=3D0, is_masked=3Dfalse)
> >     at ../hw/pci/msix.c:120
> > 10 0x0000560640bc40f1 in msix_handle_mask_update (dev=3D0x560643c65f00,=
 vector=3D0, was_masked=3Dtrue)
> >     at ../hw/pci/msix.c:140
> > 11 0x0000560640bc4503 in msix_table_mmio_write (opaque=3D0x560643c65f00=
, addr=3D12, val=3D0, size=3D4)
> >     at ../hw/pci/msix.c:231
> > 12 0x0000560640f26d83 in memory_region_write_accessor
> >     (mr=3D0x560643c66540, addr=3D12, value=3D0x7fc86b7bc628, size=3D4, =
shift=3D0, mask=3D4294967295, attrs=3D...)
> >     at ../system/memory.c:497
> > 13 0x0000560640f270a6 in access_with_adjusted_size
> >
> >      (addr=3D12, value=3D0x7fc86b7bc628, size=3D4, access_size_min=3D1,=
 access_size_max=3D4, access_fn=3D0x560640f26c8d <memory_region_write_acces=
sor>, mr=3D0x560643c66540, attrs=3D...) at ../system/memory.c:573
> > 14 0x0000560640f2a2b5 in memory_region_dispatch_write (mr=3D0x560643c66=
540, addr=3D12, data=3D0, op=3DMO_32, attrs=3D...)
> >     at ../system/memory.c:1521
> > 15 0x0000560640f37bac in flatview_write_continue
> >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., ptr=3D0x7fc87=
1e9c028, len=3D4, addr1=3D12, l=3D4, mr=3D0x560643c66540)
> >     at ../system/physmem.c:2714
> > 16 0x0000560640f37d0f in flatview_write
> >     (fv=3D0x7fc65805e0b0, addr=3D4273803276, attrs=3D..., buf=3D0x7fc87=
1e9c028, len=3D4) at ../system/physmem.c:2756
> > 17 0x0000560640f380bf in address_space_write
> >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, att=
rs=3D..., buf=3D0x7fc871e9c028, len=3D4)
> >     at ../system/physmem.c:2863
> > 18 0x0000560640f3812c in address_space_rw
> >     (as=3D0x560642161ae0 <address_space_memory>, addr=3D4273803276, att=
rs=3D..., buf=3D0x7fc871e9c028, len=3D4, is_write=3Dtrue) at ../system/phys=
mem.c:2873
> > --Type <RET> for more, q to quit, c to continue without paging--
> > 19 0x0000560640f8aa55 in kvm_cpu_exec (cpu=3D0x560642f205e0) at ../acce=
l/kvm/kvm-all.c:2915
> > 20 0x0000560640f8d731 in kvm_vcpu_thread_fn (arg=3D0x560642f205e0) at .=
./accel/kvm/kvm-accel-ops.c:51
> > 21 0x00005606411949f4 in qemu_thread_start (args=3D0x560642f292b0) at .=
./util/qemu-thread-posix.c:541
> > 22 0x00007fc87148cdcd in start_thread (arg=3D<optimized out>) at pthrea=
d_create.c:442
> > 23 0x00007fc871512630 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64=
/clone3.S:81
> > (gdb)
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Empty line is needed before the signature :)
>
will fix this
>
> > ---
> >  hw/virtio/virtio-pci.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 1a7039fb0c..f124a9e20b 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1570,7 +1570,22 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >          } else {
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> > +        vector =3D vdev->config_vector;
> >          vdev->config_vector =3D val;
> > +        /*
> > +         * If the device uses irqfd and the vector changes after DRIVE=
R_OK is
> > +         * set, we need to release the old vector and set up the new o=
ne.
> > +         */
> > +        if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +            (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enable=
d()) &&
> > +            (val !=3D vector)) {
> > +            if (vector !=3D VIRTIO_NO_VECTOR) {
> > +                kvm_virtio_pci_vector_release_one(proxy, VIRTIO_CONFIG=
_IRQ_IDX);
> > +            }
> > +            if (val !=3D VIRTIO_NO_VECTOR) {
> > +                kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ=
_IDX);
> > +            }
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_STATUS:
> >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1611,6 +1626,21 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +
> > +        /*
> > +         * If the device uses irqfd and the vector changes after DRIVE=
R_OK is
> > +         * set, we need to release the old vector and set up the new o=
ne.
> > +         */
> > +        if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +            (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enable=
d()) &&
> > +            (val !=3D vector)) {
> > +            if (vector !=3D VIRTIO_NO_VECTOR) {
> > +                kvm_virtio_pci_vector_release_one(proxy, vdev->queue_s=
el);
> > +            }
> > +            if (val !=3D VIRTIO_NO_VECTOR) {
> > +                kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel);
> > +            }
> > +        }
>
>
> same as above just a different vector, yes?
> Add a function, avoid duplicating code, please.
>
sure, will change this
thanks
cindy
>
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> >          if (val =3D=3D 1) {
> > --
> > 2.43.0
>


