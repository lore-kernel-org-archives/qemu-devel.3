Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD8F54AC6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52uV-00016X-On; Tue, 24 Mar 2026 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w52uT-0000xz-L9
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w52uP-0007Cn-Up
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774363145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ov/NSJsoNWajQFZio4bFHJ6tDL3Ks5Im4Xcs49JMzrM=;
 b=fD1rqf/UWpcuo3AYSPLV+Lg5vpY/WxA9u8GIvGoFUrQ0wxuwm5Bf89hpIJOiqCJtLW+0Gv
 rxB0hsKC3rR3dGvicboQIYcbPsRokFeBRNYv12rTdfjc2dqER4NSMpeP7nfYEb5dwz0a6R
 C4anIXPRtOV+EnFVBt7xUpZMnXR2NPA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-kdos_MTrM2SSKu355rQbJA-1; Tue, 24 Mar 2026 10:39:04 -0400
X-MC-Unique: kdos_MTrM2SSKu355rQbJA-1
X-Mimecast-MFC-AGG-ID: kdos_MTrM2SSKu355rQbJA_1774363143
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-794b240c0d3so156501397b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363143; cv=none;
 d=google.com; s=arc-20240605;
 b=eMr5hMlizKUZW5twAJYdCkrvrZ/K2mwjmZJN4oBAfuCuNkpEkGh9h380u/6N+J0h9z
 BdWPU8+m3f+Uzdz8LRWMdfnC7NtYE7/SFlfOJ1sX9Ijf+kT6gljBfflvAWcOhfQ4VgzT
 RvZvcKufZAjC3kAL0gE3sFFe5lVI2qukDEbbmvapx4l0Yvyau9O0pzULAqBx0YEIMVuz
 bYp3OYLj1NmarF/Xbgw983ZSbhsm2OO8Z22nPURM9nlyED9pgy1C7c/IWlGlMQlhZdXN
 GF4/rSjUy7kVppTr4olZfwz6JUyN5Kf8UVvv6df1nAultEV8jGpwVwFMhMFd6Ldj58KP
 F8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ov/NSJsoNWajQFZio4bFHJ6tDL3Ks5Im4Xcs49JMzrM=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=ARGIxNy3tWkzeDpIe/IerYYNih3ckos6CMz2Y+gn1fanUrJUp2nfkagrPmSZ37ZeRv
 /QPNs281tUDaTOWTCzqIRMd1HYnjpB/4QGkurnkCDsbxpeAHOn+9bIW0zJMEtrsZxnnz
 wSiIbTvrd2sOFv8j1RLQO8J3l0EiY2/jMRu7LyCcglmQ7nobb5gm3ye76rEV5SvEH3It
 lKxDaIYpt2AOeAkG1URmCNV/JUMQFtk5Ykwqxz4GbNDQkYIbYF5aVF8pmwV1xFJXex1v
 wEs+m00UjbsK8BaeRjLVaOzOZjbepgDBcn3Gllm6sk8EkDdCA/y37tkXQik/+FVa5YV7
 iWVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774363143; x=1774967943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov/NSJsoNWajQFZio4bFHJ6tDL3Ks5Im4Xcs49JMzrM=;
 b=SdlOCMHBUPlqtPJuKUAotHGrTS4gAOMhb734zr8WupMEf0QdSk7Wb7jch8CIMvx25U
 Bm423E1gpRCHHI+lJ2uuU+XLAPqK+VOc76tWkKiVCp2z8JVYF1G6LVWirSLaJf3LA9ns
 Ea9n8kZwSguqXplWO2rQ+u+7hyaD6W6BSoDR/68ziBEG2lm0GyrltRYn1n/1nqpcU+MO
 8ROHIvWsjxGJqLgc16HoE757DrAkYPe+07ORMI6Ru674ISq1J4N6Dd+lEiSAxZsBpWmR
 5fL7ygmM8mpR5FnamXuVFmOoRZSkDumbfd2K4VsidVre5Iq1fdHjBtRmkZRsH6YBVfPu
 rrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363143; x=1774967943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ov/NSJsoNWajQFZio4bFHJ6tDL3Ks5Im4Xcs49JMzrM=;
 b=RB6lyV55pLewezAF5V4zaNn3bllqed9MC2w2ZAKL2GDBEWUrKPPGvV3zkzuFLgDFKK
 H5Mu013aWfQ7HG/ZVzC8OFJOFZaiUIV6ywXyD4GQe7EBz4x9bcOdvPPplw6I+EKTaCv4
 1isfjNLezURG+uGuC9KDHCEKT5YD11s7liRx9XVndg6lGNNjMQ6d1V9VukSzyFMBGzVV
 kO/P6qo5o2gSYwBIubVs7vQG9sFB/z041urwdVDUia4x8yunK+gw5POQG5+5xcWEJOv3
 qeQob7Ey+xuFuW0TsjZV5pv4N/eNNLDvGANSOverW3DHu0VRRNWkLoiDJg7Lbdz1TYrK
 vnyQ==
X-Gm-Message-State: AOJu0YwhPms4WKOzjNE3leXTUhBSRDFN870vBfPhJV++8fhiyV14TzzL
 ryyKowe+KB9lEvUtZNaVoyc9FbIKiOeaAHdKqSRroAesSqO5yXzgWTF/weQ6rDvXuPURTyc/fDr
 zUIWb19lstGCPlUtFzYnm4hIR1y9otZ4t4+Xmp8gI7N5mdq6ztUTCLl/vYkyAZH1fVp2q/Dfpp1
 0moNc4gk/J4bHbXkhWsYrFKdsr/H89R6U=
X-Gm-Gg: ATEYQzxDymy36o9tsiumLpKqLrFiA4KCyhz1oseMeFMGZR+tLZxJucSbZs7wFtWw7SK
 ihPPR7j91sY23R+mHuDYMlQOFKBzaaQk1l7VGbS0bl6tDCgN49zXq/jmuTu7P4PmNTIl0k7adiX
 n8eMeQpH/qUUBwp07/05/zjZRSBas+kAYzSnJ9DQu0UiOfauAtrtlutOuPIv3hGZ8Gvp4d+TJIW
 jagQg==
X-Received: by 2002:a05:690c:9688:b0:79a:b409:b5e0 with SMTP id
 00721157ae682-79ac2d4bd21mr36501127b3.0.1774363143261; 
 Tue, 24 Mar 2026 07:39:03 -0700 (PDT)
X-Received: by 2002:a05:690c:9688:b0:79a:b409:b5e0 with SMTP id
 00721157ae682-79ac2d4bd21mr36500707b3.0.1774363142642; Tue, 24 Mar 2026
 07:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-3-jonah.palmer@oracle.com>
 <CAJaqyWfsr8GUfcXPz6xwcXn3TA2_k4o8+_ySr6znExj34p5VtA@mail.gmail.com>
 <cf9b156f-725c-4443-b25f-b82911cd10bc@oracle.com>
In-Reply-To: <cf9b156f-725c-4443-b25f-b82911cd10bc@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 15:38:26 +0100
X-Gm-Features: AaiRm509CAHw5LcDKk9S2RhbbMoKwpZCoqQdsua2ukUfT0RjL4BSpVvpsHpBJzE
Message-ID: <CAJaqyWcMZC3NCQ4qHTypPfiNe--SpeXue7FCrOob4iAoj-FSiQ@mail.gmail.com>
Subject: Re: [RFC v2 02/14] virtio,virtio-net: add initial early VMSD for
 setup-phase migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 3:29=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/24/26 5:27 AM, Eugenio Perez Martin wrote:
> > On Fri, Mar 20, 2026 at 3:25=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> Adds a separate VMStateDescription for virtio-net that uses the
> >> .early_setup feature. With this feature, we can migrate a virtio-net
> >> device's state earlier, before the stop-and-copy phase.
> >>
> >> Future patches will utilize this to move control plane operations out =
of
> >> the stop-and-copy phase to reduce the downtime latency caused by
> >> migrating a virtio-net device.
> >>
> >> A VirtIODevMigration migration data structure is also introduced here
> >> for VirtIODevices to help track the current state of a migration.
> >>
> >> The early_load member is used to signal that a VirtIODevice is being
> >> loaded early and to not throw an error regarding vring indices.
> >> Inconsistent indices shouldn't be an issue for a device so long as the
> >> final indices are eventually loaded before the device starts.
> >>
> >> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >> ---
> >>   hw/net/virtio-net.c        | 53 ++++++++++++++++++++++++++++++++++++=
++
> >>   hw/virtio/virtio.c         | 14 +++++++++-
> >>   include/hw/virtio/virtio.h |  9 +++++++
> >>   3 files changed, 75 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 12b3456ca2..ddd6ed6e62 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3864,6 +3864,37 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >>       return qatomic_read(&n->failover_primary_hidden);
> >>   }
> >>
> >> +static int virtio_net_early_pre_load(void *opaque)
> >> +{
> >> +    VirtIONet *n =3D opaque;
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> +
> >> +    vdev->migration->early_load =3D true;
> >> +    return 0;
> >> +}
> >> +
> >> +static int virtio_net_early_post_load(void *opaque, int version_id)
> >> +{
> >> +    VirtIONet *n =3D opaque;
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >> +
> >> +    vdev->migration->early_load =3D false;
> >> +    return 0;
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_virtio_net_early =3D {
> >> +    .name =3D "virtio-net-early",
> >> +    .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
> >> +    .version_id =3D VIRTIO_NET_VM_VERSION,
> >> +    .early_setup =3D true,
> >> +    .pre_load =3D virtio_net_early_pre_load,
> >> +    .post_load =3D virtio_net_early_post_load,
> >> +    .fields =3D (const VMStateField[]) {
> >> +        VMSTATE_VIRTIO_DEVICE,
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >>   static void virtio_net_device_realize(DeviceState *dev, Error **errp=
)
> >>   {
> >>       VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >> @@ -4046,6 +4077,21 @@ static void virtio_net_device_realize(DeviceSta=
te *dev, Error **errp)
> >>               n->rss_data.specified_hash_types.on_bits |
> >>               n->rss_data.specified_hash_types.auto_bits;
> >>       }
> >> +
> >> +    if (n->early_mig) {
> >> +        if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER=
_VHOST_USER) {
> >> +            /*
> >> +             * vhost-user backend is not currently supported for the =
early
> >> +             * migration path.
> >> +             */
> >> +            n->early_mig =3D false;
> >> +        } else {
> >> +            vdev->migration =3D g_new0(VirtIODevMigration, 1);
> >> +            vdev->migration->early_load =3D false;
> >> +
> >> +            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_e=
arly, n);
> >> +        }
> >> +    }
> >>   }
> >>
> >>   static void virtio_net_device_unrealize(DeviceState *dev)
> >> @@ -4090,6 +4136,13 @@ static void virtio_net_device_unrealize(DeviceS=
tate *dev)
> >>       g_free(n->rss_data.indirections_table);
> >>       net_rx_pkt_uninit(n->rx_pkt);
> >>       virtio_cleanup(vdev);
> >> +
> >> +    if (n->early_mig) {
> >> +        g_free(vdev->migration);
> >> +        vdev->migration =3D NULL;
> >
> > Nit: You can use g_clear_pointer(vdev->migration, g_free) here.
> >
>
> Ack. Will do!
>
> >> +
> >> +        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, =
n);
> >> +    }
> >>   }
> >>
> >>   static void virtio_net_reset(VirtIODevice *vdev)
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 8fcf6cfd0b..48de4a430b 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -3323,6 +3323,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int=
 version_id)
> >>       int32_t config_len;
> >>       uint32_t num;
> >>       uint32_t features;
> >> +    bool inconsistent_indices;
> >>       BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> >>       VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> >>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> >> @@ -3460,6 +3461,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, in=
t version_id)
> >>           if (vdev->vq[i].vring.desc) {
> >>               uint16_t nheads;
> >>
> >> +            /*
> >> +             * Ring indices will be inconsistent for a VMStateDescrip=
tion
> >> +             * performing an early load. This shouldn't be an issue a=
s the
> >> +             * final indices will get sent later once the source has =
been
> >> +             * stopped.
> >> +             */
> >> +            inconsistent_indices =3D vdev->migration && vdev->migrati=
on->early_load;
> >> +
> >>               /*
> >>                * VIRTIO-1 devices migrate desc, used, and avail ring a=
ddresses so
> >>                * only the region cache needs to be set up.  Legacy dev=
ices need
> >> @@ -3481,12 +3490,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
> >>
> >>               nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].l=
ast_avail_idx;
> >>               /* Check it isn't doing strange things with descriptor n=
umbers. */
> >> -            if (nheads > vdev->vq[i].vring.num) {
> >> +            if (!inconsistent_indices && nheads > vdev->vq[i].vring.n=
um) {
> >>                   virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x=
 "
> >>                                "inconsistent with Host index 0x%x: del=
ta 0x%x",
> >>                                i, vdev->vq[i].vring.num,
> >>                                vring_avail_idx(&vdev->vq[i]),
> >>                                vdev->vq[i].last_avail_idx, nheads);
> >> +                inconsistent_indices =3D true;
> >> +            }
> >> +            if (inconsistent_indices) {
> >>                   vdev->vq[i].used_idx =3D 0;
> >>                   vdev->vq[i].shadow_avail_idx =3D 0;
> >>                   vdev->vq[i].inuse =3D 0;
> >> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >> index 6344bd7b68..4c886eb48b 100644
> >> --- a/include/hw/virtio/virtio.h
> >> +++ b/include/hw/virtio/virtio.h
> >> @@ -99,6 +99,14 @@ enum virtio_device_endian {
> >>       VIRTIO_DEVICE_ENDIAN_BIG,
> >>   };
> >>
> >> +/**
> >> + * struct VirtIODevMigration - Common VirtIODevice migration structur=
e
> >> + * @early_load: Flag to indicate an early virtio_load for the device.
> >> + */
> >> +typedef struct VirtIODevMigration {
> >> +    bool early_load;
> >> +} VirtIODevMigration;
> >> +
> >>   /**
> >>    * struct VirtIODevice - common VirtIO structure
> >>    * @name: name of the device
> >> @@ -168,6 +176,7 @@ struct VirtIODevice
> >>        */
> >>       EventNotifier config_notifier;
> >>       bool device_iotlb_enabled;
> >> +    VirtIODevMigration *migration;
> >
> > Can we use something like net "struct VirtIONetMigTmp" for this so
> > VirtIODevice does not need to be expanded?
> >
>
> I wanted to keep it under VirtIODevice because it's meant to hold
> migration scratch state that's common for all VirtIODevices, not just
> virtio-net. For example, it could be reusable by other virtio devices in
> the future if they were to implement their own early-migration path.
>
> If we made this for virtio-net only, we'd need to modify generic virtio
> code (e.g. an extra callback) just for retrieving the state. I thought
> that this would be the cleaner way to go about handling common
> VirtIODevice state.
>

I wasn't clear enough. My goal was to move it to a struct allocated
only at migration time, not through all the live of the device.

Moving the allocation and freeing of the struct to
virtio_net_early_pre_load / virtio_net_early_post_load is a first
step. Removing the pointer altogether, the same way VirtIONet doesn't
need a pointer to hold VirtIONetMigTmp, would be even better. But I
see how keeping it live during all the migration may be problematic to
achieve it.


