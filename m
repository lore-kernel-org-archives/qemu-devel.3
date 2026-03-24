Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5321EE9A74A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4y43-0005X0-Ns; Tue, 24 Mar 2026 05:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4y41-0005WU-Tc
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4y3z-0004I8-QH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774344518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is5VTulEglzsM1YxFzwN6z4DTzjQ6TP4WZSQkm920L0=;
 b=MqHj0YPdTcbg46ciHbMoijqV2NpOWrfvvLH5Um+SDPzTZWkDmU+md3ORU/5ze0GHPbuLm5
 liqDBmAxs5HKa87FUORUpi7yaZ2r5Zk4LCkvOmkYUzIgLnVX/LNLqxPY+S0ISkdxq2yzQM
 CAmp8Rtg0HacDJoYSz9ODPNiWQb09hg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Yb9kpFTSMeOfDscq1n_9yw-1; Tue, 24 Mar 2026 05:28:37 -0400
X-MC-Unique: Yb9kpFTSMeOfDscq1n_9yw-1
X-Mimecast-MFC-AGG-ID: Yb9kpFTSMeOfDscq1n_9yw_1774344516
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-794b240c0d3so148347417b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 02:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774344516; cv=none;
 d=google.com; s=arc-20240605;
 b=IOGnFYAimzpUcA0VjkK9NLXJgymQoqrlG6fdk0NvAgs0YEXXDMlZYcvvceQvfsO4pj
 Mxaolj+LZ2WOeKFSuGyQj8BoiW40MJOKFxcGne5WDy1rJ8VmTxYYDlJpyZyEMk60fTgT
 sd2zN3tFZUjZbl8vrCN1Uekj3FhJqwIv72mR832Z1giGST3ddQb7IDSgsVH1Ghr7PM7g
 eQp9zkwfo3m1F6ulDlLz5mli7aATuOffurhINglOXm/RQv3GoANev6pEcRs3AJouBv6y
 fxw589Z2sNMDP/1VoOLvAtY6v6+DAZGjoqCwbibP8qksbPmOgTmS1fxNAkeLylhCXUQa
 Df/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Is5VTulEglzsM1YxFzwN6z4DTzjQ6TP4WZSQkm920L0=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=el9GQJweMoEROoPKs/VDO46sisvs71UcxwAhEP4hObWDLkQpxcMAZrSWnMzPg1F60W
 Ff1DgDT4r+Izz+UTGd39FyAo3pMeKPgHzMlr/podL7ETkZJ20skYovdXjnjLjWm3TALM
 OC3mOj10kj38+dhyvoZObyICAi3OmoxMdflFlzvAACRGLuxiL1E1PNex4+NWM3Cl1nzf
 EwFlypzAKPhNl1T4xjxQHRoNbXrNRT9BP3wJ8G7FwACfFxRvyfOb7wI5XgMOs+/c9Njj
 yLny/1BjRX/7EjP3PIj31DnnAxBgxzVBcr5Klv4hqi2njfEzLge4yhkwVP5LpQG8qdUr
 JM2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774344516; x=1774949316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Is5VTulEglzsM1YxFzwN6z4DTzjQ6TP4WZSQkm920L0=;
 b=iRpgLu5bfKs1UpQe0yywm9lLbZQqqUIkVxmkuO5+X5HSY3q7CemxYRAD3eE2g8hzJV
 p3ua0anFxFmjpQ4/AsSfZTt1dCgLtHrQ6aowWeB8kUdvRV8LOvzajUftsRYkHPm4PQGX
 zaj6lE5bkiUyeCxfbVMPQuLv9UtuCBFPvlRek/wIJeriOvbHHzlaUKXzpyjQdgzKwL6k
 kFvVlHrZk2z+nNrwIAAZPDqZV7ElWYBMtQVc64HlEHL3E4pYpEOPn3yw7/+6fIUFVMor
 ysiCXJw5hWz23+nPmnHKxCTnSgdW8eXn5gqxyCPYphU3aMdE3OFsCYwLmmGztW5ntFmi
 5Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774344516; x=1774949316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Is5VTulEglzsM1YxFzwN6z4DTzjQ6TP4WZSQkm920L0=;
 b=FORZy67tyWg3cZAqEowJJbyMbEwjULdI8X/wOaT/3tAT3kXEBKrv7cdM9vJkyG7pco
 u3LN1+iwbGlJa2sJ6toOEb72PFcqYb0s8xE6vmCbmtU+D0biWiUlkMbM4tJJO+prEPWj
 LGx+josemstv0wm10injYDfcqThS09BK3JjJ0jxKNf/9po4IGPhElbV56IcLTGwl53gF
 8GbPN1gMpf+zE5+rJjZMkElCw7MQiaK5yrjlEfI9T4HfvukiRy3c6DYdQucYr9qfLiH8
 pskJ+/yvS17aY39xacvZXc5vS76flQBCGjSoLilfcvLyb86nOLUKDS7OPIfHtfcB9+Kg
 CHsA==
X-Gm-Message-State: AOJu0Ywbi8CQ/l8fQwFc/ASOI+uPHuozLe9epwabVJTOVvDYjB6MNUEr
 26uO0CY2gaJlloF5FePndhI23h4G9bNGq/49L2TIrKb2ESzmraq57FnSC3OmIMo0CY90iwy0geg
 ZsBU1RZZoN1ss4Uzw9gSB98fw9QgmhIvKFhwO/fS8xCqfq1VRshzLhK0sNiAFkTiyw9CMsQ0BjZ
 bR8gtr22pWQ9/8kxGJvoyG0phR0PEf8XM=
X-Gm-Gg: ATEYQzwcwFGubiupfYWB79cG589I2Sg90iTiAMdtRDoNdWjg+WHVL3PaTD1iH6YdqJ3
 l8ECS28LDSOqQUdbewh7WO/t4kUaeKHzviuLhYpgKSrGXk8uP71c4nirPgOqybj9HWUExEHMRuk
 EVA37ndQ7NlPDzd2wPR8RNF2xOKkdJEQMyePlIYKDNURRJ1qrZOl11F8+J2RLTFzLNKSUxS4iKE
 byEMQ==
X-Received: by 2002:a05:690c:f09:b0:79a:bf27:fe61 with SMTP id
 00721157ae682-79ac2eceb50mr26166677b3.14.1774344516540; 
 Tue, 24 Mar 2026 02:28:36 -0700 (PDT)
X-Received: by 2002:a05:690c:f09:b0:79a:bf27:fe61 with SMTP id
 00721157ae682-79ac2eceb50mr26166327b3.14.1774344516099; Tue, 24 Mar 2026
 02:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-3-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-3-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 10:27:59 +0100
X-Gm-Features: AaiRm50VX31bSBaVDS2noKIO1Rzrci99kaxDOtCSMeU4JqwoahMs78mBUsjkI-w
Message-ID: <CAJaqyWfsr8GUfcXPz6xwcXn3TA2_k4o8+_ySr6znExj34p5VtA@mail.gmail.com>
Subject: Re: [RFC v2 02/14] virtio,virtio-net: add initial early VMSD for
 setup-phase migration
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 20, 2026 at 3:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Adds a separate VMStateDescription for virtio-net that uses the
> .early_setup feature. With this feature, we can migrate a virtio-net
> device's state earlier, before the stop-and-copy phase.
>
> Future patches will utilize this to move control plane operations out of
> the stop-and-copy phase to reduce the downtime latency caused by
> migrating a virtio-net device.
>
> A VirtIODevMigration migration data structure is also introduced here
> for VirtIODevices to help track the current state of a migration.
>
> The early_load member is used to signal that a VirtIODevice is being
> loaded early and to not throw an error regarding vring indices.
> Inconsistent indices shouldn't be an issue for a device so long as the
> final indices are eventually loaded before the device starts.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c        | 53 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio.c         | 14 +++++++++-
>  include/hw/virtio/virtio.h |  9 +++++++
>  3 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 12b3456ca2..ddd6ed6e62 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3864,6 +3864,37 @@ static bool failover_hide_primary_device(DeviceLis=
tener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static int virtio_net_early_pre_load(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    vdev->migration->early_load =3D true;
> +    return 0;
> +}
> +
> +static int virtio_net_early_post_load(void *opaque, int version_id)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    vdev->migration->early_load =3D false;
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_virtio_net_early =3D {
> +    .name =3D "virtio-net-early",
> +    .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
> +    .version_id =3D VIRTIO_NET_VM_VERSION,
> +    .early_setup =3D true,
> +    .pre_load =3D virtio_net_early_pre_load,
> +    .post_load =3D virtio_net_early_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -4046,6 +4077,21 @@ static void virtio_net_device_realize(DeviceState =
*dev, Error **errp)
>              n->rss_data.specified_hash_types.on_bits |
>              n->rss_data.specified_hash_types.auto_bits;
>      }
> +
> +    if (n->early_mig) {
> +        if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VH=
OST_USER) {
> +            /*
> +             * vhost-user backend is not currently supported for the ear=
ly
> +             * migration path.
> +             */
> +            n->early_mig =3D false;
> +        } else {
> +            vdev->migration =3D g_new0(VirtIODevMigration, 1);
> +            vdev->migration->early_load =3D false;
> +
> +            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_earl=
y, n);
> +        }
> +    }
>  }
>
>  static void virtio_net_device_unrealize(DeviceState *dev)
> @@ -4090,6 +4136,13 @@ static void virtio_net_device_unrealize(DeviceStat=
e *dev)
>      g_free(n->rss_data.indirections_table);
>      net_rx_pkt_uninit(n->rx_pkt);
>      virtio_cleanup(vdev);
> +
> +    if (n->early_mig) {
> +        g_free(vdev->migration);
> +        vdev->migration =3D NULL;

Nit: You can use g_clear_pointer(vdev->migration, g_free) here.

> +
> +        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
> +    }
>  }
>
>  static void virtio_net_reset(VirtIODevice *vdev)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8fcf6cfd0b..48de4a430b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3323,6 +3323,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int ve=
rsion_id)
>      int32_t config_len;
>      uint32_t num;
>      uint32_t features;
> +    bool inconsistent_indices;
>      BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> @@ -3460,6 +3461,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>          if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
>
> +            /*
> +             * Ring indices will be inconsistent for a VMStateDescriptio=
n
> +             * performing an early load. This shouldn't be an issue as t=
he
> +             * final indices will get sent later once the source has bee=
n
> +             * stopped.
> +             */
> +            inconsistent_indices =3D vdev->migration && vdev->migration-=
>early_load;
> +
>              /*
>               * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
>               * only the region cache needs to be set up.  Legacy devices=
 need
> @@ -3481,12 +3490,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
>
>              nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
>              /* Check it isn't doing strange things with descriptor numbe=
rs. */
> -            if (nheads > vdev->vq[i].vring.num) {
> +            if (!inconsistent_indices && nheads > vdev->vq[i].vring.num)=
 {
>                  virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>                               "inconsistent with Host index 0x%x: delta 0=
x%x",
>                               i, vdev->vq[i].vring.num,
>                               vring_avail_idx(&vdev->vq[i]),
>                               vdev->vq[i].last_avail_idx, nheads);
> +                inconsistent_indices =3D true;
> +            }
> +            if (inconsistent_indices) {
>                  vdev->vq[i].used_idx =3D 0;
>                  vdev->vq[i].shadow_avail_idx =3D 0;
>                  vdev->vq[i].inuse =3D 0;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 6344bd7b68..4c886eb48b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -99,6 +99,14 @@ enum virtio_device_endian {
>      VIRTIO_DEVICE_ENDIAN_BIG,
>  };
>
> +/**
> + * struct VirtIODevMigration - Common VirtIODevice migration structure
> + * @early_load: Flag to indicate an early virtio_load for the device.
> + */
> +typedef struct VirtIODevMigration {
> +    bool early_load;
> +} VirtIODevMigration;
> +
>  /**
>   * struct VirtIODevice - common VirtIO structure
>   * @name: name of the device
> @@ -168,6 +176,7 @@ struct VirtIODevice
>       */
>      EventNotifier config_notifier;
>      bool device_iotlb_enabled;
> +    VirtIODevMigration *migration;

Can we use something like net "struct VirtIONetMigTmp" for this so
VirtIODevice does not need to be expanded?

>  };
>
>  struct VirtioDeviceClass {
> --
> 2.51.0
>


