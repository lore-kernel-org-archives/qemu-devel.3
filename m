Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6A0E9A764
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4zH2-0005Rr-Nx; Tue, 24 Mar 2026 06:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zGm-0005RD-LY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4zGj-0000Fm-1U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 06:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774349149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cESUk+FyTMPX/FUqfRvt5lNRyHH3XkdHcxJPyAOlmQ=;
 b=SPd/VVI8WvdjtinFUX0aC8reOlRRw5Mnf+bqWV32dG/gWbkEXOS582ECg4CliBg06GVZb8
 MoV2C9k6AkiC5HfjQrBicCJT2+U803IrXO2+4MyBln75Yrsj9N77Lmx2q6bUIHue8rEDwW
 x+/Wh7G2YOVYl1yEiUBnkoTvMbt8/IU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-dGIBygymOZ-f2XFad6_j4g-1; Tue, 24 Mar 2026 06:45:48 -0400
X-MC-Unique: dGIBygymOZ-f2XFad6_j4g-1
X-Mimecast-MFC-AGG-ID: dGIBygymOZ-f2XFad6_j4g_1774349148
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79064868702so37720807b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 03:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774349148; cv=none;
 d=google.com; s=arc-20240605;
 b=aSkxLVQYw02WVtAzQgKmA4szCIsQOVk1w+D8YWLL0DFxiYeJeJ8X4xpGKJth1GcB1B
 NKwBY4Ay4z3veqoNOproZCc/tbm8eEZFVvab7TtRF6bVhZUp0Peq3SCuJFpnYZvTxtWI
 hQDtkmaAOdHaHEQq6fzfXbzW5zJ9kJdGF4gPyXvQLOqCTZ0t5SKfSaM+nn2wqEah9ci4
 k0P8C1ZN9RhX2EoiP47Eq1c+52P1TDalHJPpp+iJIoR1v123K+JxPmgPfxQzbe3GvFAU
 rDdHtx9FAxo1pue2I/c6H0Ydn/1RGHn1Ofkpp1/cSZTqrJX2OTFbFvDeDiMz0IOnnB6v
 eMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3cESUk+FyTMPX/FUqfRvt5lNRyHH3XkdHcxJPyAOlmQ=;
 fh=YABNQfmvUMl7qMn0Pg+rjVUhb9BD90dDpz1/2AdAcYo=;
 b=BA2UAeq3X99dhdkk5Uap8HEhqibw0Kwe1nw5FwACjhLiLBSs+634ZZC8wvVdKMEBHD
 t5DU0MNUAUN9y6n4aaxnb1icfKT1E/AffZy5oL9jjqc+QqvWS8ndGuzKK2Lf9jruHteR
 vTvkoVDUMqcZ1LImjrSTt3NiqyAGc62aSNfvvqGveTrRJlihpMDgXuanyXLlDiKNE7Bc
 vVO+XXrrXAmPhsZz9IjevwEVZ2iG+bEact8q55j3mUt3YUiCTLrxHsGYpTEGXEXmW0Md
 F/W2PTBr8Zkwk+VsTv8tlgtOr/E1xD4TaW2//GlskwE7UvIGxhT6kiijqv/XB/7URkSM
 mgQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774349148; x=1774953948; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cESUk+FyTMPX/FUqfRvt5lNRyHH3XkdHcxJPyAOlmQ=;
 b=UlHnZNEmjDc9RmHPd1WejpZgPeadX4Y6/zQAcP0FogEvFucIIgBDG3nzPVeluifNb9
 lFNuxyAkzrQVA6hUvlVgJt+6A1ZQIFWYbJuLA3errvvUBrSDHnE/YAbmZ0m+7OsdAoKt
 Zikh3ARu07xyp58zX6nUuP5Z2ZXknvuTIpZCsrEhjO8wuW3Azau28QXAXkpcTG/qQOm0
 t5llKiKLBWvPHIKmgvcWTIiwkHJgR1/cnPf34ZynvLukCwBbWhr4z/zuhfNeKNxU7Uxw
 z/4+Kzp3m6LhNujfZyA1i/aW9yjHyhKr/iUByjOJuI9sM0Ody7g/XJRgNdWQOg/1s4vr
 WWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349148; x=1774953948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3cESUk+FyTMPX/FUqfRvt5lNRyHH3XkdHcxJPyAOlmQ=;
 b=Sr0SHeianeOOav+vO6B/FxGVq0zOyz0ti2AS1grHzCYIAfDSfA8JI25ugsyVbtWwuL
 qzpLqu6h8oy+4UHwFboIDqwq7HpeAQXKxYiZA931gGDbYIEjst9+v9p+i0eEqA/9cHrX
 hYOYGEWP36aijPtQbjH1eEnoOZByT6d5RJcYC0ear3enWIkF/n6n5zaSPSDRVsTPmF4v
 /hUmVUtDbvc9xuGlDvz202kXkQqednCRgDbNxNfI1MRJKkaLbrwHJjM+bRMSU3jGUzed
 eGXYuc2fn5MoMvK262Wq4X9UvSGtw6jjqJp3tvcsrw1TrY0WzZJ5N43HgOAItw4W5l72
 jYQA==
X-Gm-Message-State: AOJu0YzZeqrAbQsd0ow+cPgEQO4wDwXLEDAVivgtopC5byPKgu7AMkCY
 95mqYFSE+PNnDxjhHpLVOVUpUKhquPBf2MPb4y2EgxPnLvkfX+8M8ZzgI3KH4LsymVBUqrFk1h0
 UJU3uAH64GyR6Wz03M/mOTmmicsc3a2sCT/2GvSI3U3BPZIZ8T3HH6RfXKGUT9vnWm0DHr2ry4T
 ACyXGos9WUpU1oB1t3Ytkoq73gXe8AgqQ=
X-Gm-Gg: ATEYQzzQKQ6Owhc2752dZTVf4AHuWDNMimnoqSFiVnyNZCGfuYEzy8vKotinFvw0X3+
 N0aXxb6M2FE+Vg+9QL9SHDegpyUf/4at00HW6a93Mok6fKB29vkcE9inmlbTATBU/YGPoJLwUxH
 Aytupxc16Fga1/G4LkijyAb/6JHzCZ9Nf0hpfa3iYT58N0lgpJK+DtH6o/BmAsCNvPY6cXEMQLs
 kfVeQ==
X-Received: by 2002:a05:690c:7446:b0:794:d3e6:a503 with SMTP id
 00721157ae682-79a90b09fe6mr167322667b3.24.1774349147802; 
 Tue, 24 Mar 2026 03:45:47 -0700 (PDT)
X-Received: by 2002:a05:690c:7446:b0:794:d3e6:a503 with SMTP id
 00721157ae682-79a90b09fe6mr167322457b3.24.1774349147357; Tue, 24 Mar 2026
 03:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 24 Mar 2026 11:45:11 +0100
X-Gm-Features: AaiRm528jH5gGV88zC6vXBqHctKfROyrE1GiO3-cDS4jJZGmEq5YFRmaQMjrQg4
Message-ID: <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com, 
 Juraj Marcin <jmarcin@redhat.com>
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

On Fri, Mar 20, 2026 at 3:20=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> This patch introduces the mechanism in which this series will use to
> detect VirtIODevice & VirtIONet state deltas, starting with the
> VirtIODevice's 'status' member of a virtio-net device.
>
> Before we send the device's state early, we save each piece of its state
> in a temporary structure via virtio_net_early_pre_save. Later, once the
> source VM has been paused,

While I ack this approach should cover 99% of cases=E2=80=94as I think it i=
s
unlikely the guest changes device properties during a live migration=E2=80=
=94I
still believe these changes should be sent when the guest modifies the
property, before it is paused. That way we shrink the downtime even
more. This comparison fits naturally: Instead of sending one state and
then the deltas at the switchover, we send the state and then the
delta for every change.

However, I'm happy enough with this approach because it is more
self-contained within the migration code. It also reduces the state
sent over the migration channel if the guest changes its device status
many times.

CCing Juraj as we discussed this at the virtio-net upstream meeting.

> we compare the current values of those pieces
> to what we saved earlier. If any mismatch is found, virtio-net's VMSD
> (vmstate_virtio_net) is enabled and resends all state and device prep
> work (as it's normally done today when live migrating a virtio-net
> device).
>
> Once all relevant delta checks are in place, a no-delta case will skip
> vmstate_virtio_net and only resend updated VQ indices.
>
> For this patch, keep a temporary always-true fallback in
> virtio_net_has_delta/virtio_net_needed until follow-up patches cover the
> remaining VirtIONet & VirtIODevice deltas.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c        | 40 ++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 42 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5d71ad235e..2733e0130c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3864,6 +3864,16 @@ static bool failover_hide_primary_device(DeviceLis=
tener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static int virtio_net_early_pre_save(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +    VirtIODevMigration *vdev_mig =3D vdev->migration;
> +
> +    vdev_mig->status_early =3D vdev->status;
> +    return 0;
> +}
> +
>  static int virtio_net_early_pre_load(void *opaque)
>  {
>      VirtIONet *n =3D opaque;
> @@ -3887,6 +3897,7 @@ static const VMStateDescription vmstate_virtio_net_=
early =3D {
>      .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
>      .version_id =3D VIRTIO_NET_VM_VERSION,
>      .early_setup =3D true,
> +    .pre_save =3D virtio_net_early_pre_save,
>      .pre_load =3D virtio_net_early_pre_load,
>      .post_load =3D virtio_net_early_post_load,
>      .fields =3D (const VMStateField[]) {
> @@ -4231,10 +4242,39 @@ static bool dev_unplug_pending(void *opaque)
>      return vdc->primary_unplug_pending(dev);
>  }
>
> +static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
> +{
> +    VirtIODevMigration *vdev_mig =3D vdev->migration;
> +
> +    /* Has the VirtIODevice's status changed? */
> +    if (vdev->status !=3D vdev_mig->status_early) {
> +        return true;
> +    }

To clarify my point, I think we should add something like this:

if (vdev->status !=3D status) {
  // process it.
  virtio_send_status_update_to_destination()
}

At virtio_net_set_status, or similar.

> +
> +    /*
> +     * Always return true for now until we're able to detect all possibl=
e
> +     * changes to a VirtIONet device.
> +     */
> +    return true;
> +}
> +
> +static bool virtio_net_needed(void *opaque)
> +{
> +    VirtIONet *n =3D opaque;
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> +
> +    if (!n->early_mig) {
> +        return true;
> +    }
> +
> +    return virtio_net_has_delta(n, vdev);
> +}
> +
>  static const VMStateDescription vmstate_virtio_net =3D {
>      .name =3D "virtio-net",
>      .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
>      .version_id =3D VIRTIO_NET_VM_VERSION,
> +    .needed =3D virtio_net_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_VIRTIO_DEVICE,
>          VMSTATE_END_OF_LIST()
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 74fed8c324..752c46ce53 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -102,9 +102,11 @@ enum virtio_device_endian {
>  /**
>   * struct VirtIODevMigration - Common VirtIODevice migration structure
>   * @early_load: Flag to indicate an early virtio_load for the device.
> + * @status_early: Device status at the time it was sent early.
>   */
>  typedef struct VirtIODevMigration {
>      bool early_load;
> +    uint8_t status_early;
>  } VirtIODevMigration;
>
>  /**
> --
> 2.51.0
>


