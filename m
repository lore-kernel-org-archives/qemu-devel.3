Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1672C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzcf2-0007mH-Li; Wed, 24 Apr 2024 09:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcey-0007lX-R1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcew-0006RK-Fm
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713965257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvqSkn4GGbipLUKNGsqGoTdNyo8oa3kL77zI9iK2hZs=;
 b=eeHbK6ttycRT0tkCW5OAiuAMslkeJFH9gbcvrMfLTDjlD/SigVZAOub5yNP8921jD6KQXE
 2WueFxm4ZF3h5A/9KrX2urCiVTF3qL8pIJcvM3BgttyFf9A9yLIoww1f6vBcjYETxkRtRY
 CB4wxCZu8kwz2dK2Jl9csvgHH2t6D1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-N8ng-lCXNCmcJw2wm96QAA-1; Wed, 24 Apr 2024 09:27:33 -0400
X-MC-Unique: N8ng-lCXNCmcJw2wm96QAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79038834FB1;
 Wed, 24 Apr 2024 13:27:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55215C13FA7;
 Wed, 24 Apr 2024 13:27:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 664BA21E66C8; Wed, 24 Apr 2024 15:27:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/ccw: Use g_autofree variable
In-Reply-To: <20240424125441.215953-1-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 24 Apr 2024 14:54:41 +0200")
References: <20240424125441.215953-1-clg@redhat.com>
Date: Wed, 24 Apr 2024 15:27:32 +0200
Message-ID: <87cyqeubzv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> Also change the return value of vfio_ccw_register_irq_notifier() to be
> a bool since it takes and 'Error **' argument. See the qapi/error.h
> Rules section.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

My comments on "[PATCH] vfio/ap: Use g_autofree variable" apply.

More inline.

> ---
>  hw/vfio/ccw.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 90e4a534371684c08e112364e1537eb8979f73f4..1c630f6e9abe93ae0c2b5615d=
4409669f096c8c9 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -379,12 +379,12 @@ read_err:
>      css_inject_io_interrupt(sch);
>  }
>=20=20
> -static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
> +static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                             unsigned int irq,
>                                             Error **errp)
>  {
>      VFIODevice *vdev =3D &vcdev->vdev;
> -    struct vfio_irq_info *irq_info;
> +    g_autofree struct vfio_irq_info *irq_info =3D NULL;
>      size_t argsz;
>      int fd;
>      EventNotifier *notifier;
> @@ -405,13 +405,13 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWD=
evice *vcdev,
>          break;
>      default:
>          error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
> -        return;
> +        return false;
>      }
>=20=20
>      if (vdev->num_irqs < irq + 1) {
>          error_setg(errp, "vfio: IRQ %u not available (number of irqs %u)=
",
>                     irq, vdev->num_irqs);
> -        return;
> +        return false;
>      }
>=20=20
>      argsz =3D sizeof(*irq_info);
> @@ -421,14 +421,14 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWD=
evice *vcdev,
>      if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>                irq_info) < 0 || irq_info->count < 1) {
>          error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> +        return false;
>      }
>=20=20
>      if (event_notifier_init(notifier, 0)) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for irq (%=
d)",
>                           irq);
> -        goto out_free_info;
> +        return false;
>      }
>=20=20
>      fd =3D event_notifier_get_fd(notifier);
> @@ -440,8 +440,7 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDev=
ice *vcdev,
>          event_notifier_cleanup(notifier);
>      }
>=20=20
> -out_free_info:
> -    g_free(irq_info);
> +    return true;
>  }
>=20=20
>  static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
> @@ -605,20 +604,18 @@ static void vfio_ccw_realize(DeviceState *dev, Erro=
r **errp)
>          goto out_region_err;
>      }
>=20=20
> -    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
> -    if (err) {
> +    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &e=
rr)) {

Please pass errp instead of &err.

>          goto out_io_notifier_err;
>      }
>=20=20
>      if (vcdev->crw_region) {
> -        vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX, &e=
rr);
> -        if (err) {
> +        if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDE=
X,
> +                                            &err)) {

Likewise.

>              goto out_irq_notifier_err;
>          }
>      }
>=20=20
> -    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &err);
> -    if (err) {
> +    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &=
err)) {
>          /*
>           * Report this error, but do not make it a failing condition.
>           * Lack of this IRQ in the host does not prevent normal operatio=
n.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


