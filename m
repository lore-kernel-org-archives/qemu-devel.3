Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F0BCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 06:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruRRj-0000fh-0U; Wed, 10 Apr 2024 02:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruRRh-0000fT-Ap
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruRRf-0002r3-AJ
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712730510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obxfaaRAdKiIY0VH4+TPlZldDKORkwC6Ld4RJwLas2k=;
 b=UBNd+2g4Dlr6tlhhBe/s5F3wfD6GIqeRrhXDdaX+0w0d1Kr6JHXxQe0SldM+OcBO+AJLk6
 94NmlaYA6WpFsnUVjLekQQWBnoJFBlc8Arw3KtSGInzuEugCaqCwsKOvG3kxF/QSAS8pkz
 5Kdo8md3X3Xp0x/51ZDGc3siXfMJdz4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-HtAjRCQ-Mpea0xgfHMj-GQ-1; Wed, 10 Apr 2024 02:28:27 -0400
X-MC-Unique: HtAjRCQ-Mpea0xgfHMj-GQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-516da5d2043so3711788e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 23:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712730506; x=1713335306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obxfaaRAdKiIY0VH4+TPlZldDKORkwC6Ld4RJwLas2k=;
 b=kmalz/cBsr7b+25mjBWNaAQnvvZeVWFji5UUjNSdqgJjC/y/D6cQ7O28nueRfbSLpe
 QeRz3jd9e41a8Z0gA9LMAJ7b2mJsQ2ehPhSQNrRg3wWeAR8MKc/HoJAY3zSZ3Qz+9ZVI
 PcrnkRQDjHdyw59NMW9DDwidOzmnvnF8u12ePjKIwlCfvAWh1j1OttJHxJBM1FGTyFgm
 b/duC/7BSjtQA6Zl7fa/xRoSmfhbsS4U5whUMDMJV5QX2PL74WExiYbp1vYrntgTgXxx
 CkW2vJoZtUwyrZjnJxoaBZLk67RFN5TwX7MZtd1MRCCS6gYjWzsz2vqYuPvgLBz7IQZI
 zabA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGlo+/kiX2igRyCnZOtaPzXpxBRPuGiPsrYf1DAf1aQQcZkZLSAr3EaICH6o92kFKhCbI4Bld5j8E+cZW6IRPGqj9mZgw=
X-Gm-Message-State: AOJu0Yzdhha1ARekP/Aa0I8spIfBo+8dXGMh6w7cMhH4+bpnj9Q/NReK
 g36/GXm1SXZr8VEs56zZV1KSHmwOBc+5mvignyUjFjD6xHldqpoZjTb/W272nFF5JT/Y0bWXZ5g
 X4xeMyy0UTxNpu7BNbXVCCw2hq2g83bzlzqEotr2yD6kkrXLPC+P5w46NnWmHz7rTjEX9FkyLGG
 wLwhugjaKvwME7WNoRLnV5fxCUo6Y=
X-Received: by 2002:ac2:5f87:0:b0:516:d09b:cbe4 with SMTP id
 r7-20020ac25f87000000b00516d09bcbe4mr1230661lfe.53.1712730505990; 
 Tue, 09 Apr 2024 23:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS5D0TfEs1//ITsheJdGjOpghC2RLFQVqgvwnbTQikkLlc3awnxSRh7udpUWY9zdBz1pTVeS0SP3UzPW15e90=
X-Received: by 2002:ac2:5f87:0:b0:516:d09b:cbe4 with SMTP id
 r7-20020ac25f87000000b00516d09bcbe4mr1230644lfe.53.1712730505542; Tue, 09 Apr
 2024 23:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240410052926.417674-1-lulu@redhat.com>
 <20240410052926.417674-2-lulu@redhat.com>
 <CACGkMEuDqp7DGtL8feYry2bL+USprSRes-7fiG=Q8b-jcTvokQ@mail.gmail.com>
In-Reply-To: <CACGkMEuDqp7DGtL8feYry2bL+USprSRes-7fiG=Q8b-jcTvokQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Apr 2024 14:27:45 +0800
Message-ID: <CACLfguXh5EmfFGnJuK3UHBPb0oPFx507RGggaRKUG-q67hUv3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-pci: Fix the crash that the vector was used
 after released.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

On Wed, Apr 10, 2024 at 1:36=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Apr 10, 2024 at 1:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When the guest triggers vhost_stop and then virtio_reset, the vector wi=
ll the
> > IRQFD for this vector will be released and change to VIRTIO_NO_VECTOR.
> > After that, the guest called vhost_net_start,  (at this time, the confi=
gure
> > vector is still VIRTIO_NO_VECTOR),  vector 0 still was not "init".
> > The guest system continued to boot, set the vector back to 0, and then =
met the crash.
> >
> > To fix this, we need to call the function "kvm_virtio_pci_vector_use_on=
e()"
> > when the vector changes back from VIRTIO_NO_VECTOR
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
> > ---
> >  hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 1a7039fb0c..344f4fb844 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -880,6 +880,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIP=
roxy *proxy, int queue_no)
> >      int ret;
> >      EventNotifier *n;
> >      PCIDevice *dev =3D &proxy->pci_dev;
> > +    VirtIOIRQFD *irqfd;
> >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >
> > @@ -890,10 +891,19 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPC=
IProxy *proxy, int queue_no)
> >      if (vector >=3D msix_nr_vectors_allocated(dev)) {
> >          return 0;
> >      }
> > +    /*
> > +     * if the irqfd still in use, means the irqfd was not
> > +     * release before and don't need to set up
> > +     */
> > +    irqfd =3D &proxy->vector_irqfd[vector];
> > +    if (irqfd->users !=3D 0) {
> > +        return 0;
> > +    }
>
> kvm_virtio_pci_vq_vector_use() has a similar check and it looks to me
> kvm_virtio_pci_irqfd_use() can work when users > 0.
>
> Any reason we need an extra check here?
>
> Thanks
>
in function kvm_virtio_pci_vq_vector_use(). this will not init the
irqfd, but there will be an
    irqfd->users++;
so the user number will be wrong in this irqfd, There will be check
for this in other function
sunch like kvm_virtio_pci_vq_vector_release()
{
    VirtIOIRQFD *irqfd =3D &proxy->vector_irqfd[vector];

    if (--irqfd->users =3D=3D 0) {
        kvm_irqchip_release_virq(kvm_state, irqfd->virq);
    }
}
this will cause problem
thanks
Cindy


> >      ret =3D kvm_virtio_pci_vq_vector_use(proxy, vector);
> >      if (ret < 0) {
> >          goto undo;
> >      }
> > +
> >      /*
> >       * If guest supports masking, set up irqfd now.
> >       * Otherwise, delay until unmasked in the frontend.
> > @@ -1570,7 +1580,19 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >          } else {
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> > +        vector =3D vdev->config_vector;
> >          vdev->config_vector =3D val;
> > +        /*
> > +         *if the val was change from NO_VECTOR, this means the vector =
maybe
> > +         * release before, need to check if need to set up
> > +         */
> > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VE=
CTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            /* check if use irqfd*/
> > +            if (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_ena=
bled()) {
> > +                kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ=
_IDX);
> > +            }
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_STATUS:
> >          if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > @@ -1611,6 +1633,19 @@ static void virtio_pci_common_write(void *opaque=
, hwaddr addr,
> >              val =3D VIRTIO_NO_VECTOR;
> >          }
> >          virtio_queue_set_vector(vdev, vdev->queue_sel, val);
> > +
> > +        /*
> > +         *if the val was change from NO_VECTOR, this means the vector =
maybe
> > +         * release before, need to check if need to set up
> > +         */
> > +
> > +        if ((val !=3D VIRTIO_NO_VECTOR) && (vector =3D=3D VIRTIO_NO_VE=
CTOR) &&
> > +            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +            /* check if use irqfd*/
> > +            if (msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_ena=
bled()) {
> > +                kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel);
> > +            }
> > +        }
> >          break;
> >      case VIRTIO_PCI_COMMON_Q_ENABLE:
> >          if (val =3D=3D 1) {
> > --
> > 2.43.0
> >
>


