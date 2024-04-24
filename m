Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B75C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 13:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzcZv-0005ef-TW; Wed, 24 Apr 2024 09:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcZq-0005b1-EX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzcZn-0005Ss-7I
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 09:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713964937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqNxfH4iSIyHlRgfEyR9QrZvXdtjL8orPxiaveBRl6M=;
 b=CBycC9wK26zfZxtwVfwJWEOeVBi7NaHGxRfnQcvKk7ZvF71J3CVq5gzSKt6gEDOPzJ0t0G
 Teu0/bwGDEDD63dT0xEKQ0QOADgF4+DGiD+/gaSnb78kbgwFDbD5HpuzU9YWWuZdbYoYxA
 FLNGI/tz4lC8C0q8sWNFDJjYEkE6620=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-JQZscybyNb-CMxj_xdlpUw-1; Wed, 24 Apr 2024 09:22:14 -0400
X-MC-Unique: JQZscybyNb-CMxj_xdlpUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA51518065B2;
 Wed, 24 Apr 2024 13:22:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA325490EE;
 Wed, 24 Apr 2024 13:22:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AC1B21E6811; Wed, 24 Apr 2024 15:22:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,  Tony Krowiak
 <akrowiak@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,  Jason Herne
 <jjherne@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/ap: Use g_autofree variable
In-Reply-To: <20240424125432.215886-1-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 24 Apr 2024 14:54:32 +0200")
References: <20240424125432.215886-1-clg@redhat.com>
Date: Wed, 24 Apr 2024 15:22:12 +0200
Message-ID: <87il06uc8r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> Also change the return value of vfio_ap_register_irq_notifier() to be
> a bool since it takes and 'Error **' argument. See the qapi/error.h
> Rules section.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Split the patch?

If not, the bigger part by far is the return value change, so I'd put
that into the subject.

> ---
>  hw/vfio/ap.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 7c4caa5938636937680fec87e999249ac84a4498..8bb024e2fde4a1d72346dee4b=
662d762374326b9 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -70,14 +70,14 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>      }
>  }
>=20=20
> -static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
> +static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                            unsigned int irq, Error **errp)
>  {
>      int fd;
>      size_t argsz;
>      IOHandler *fd_read;
>      EventNotifier *notifier;
> -    struct vfio_irq_info *irq_info;
> +    g_autofree struct vfio_irq_info *irq_info =3D NULL;
>      VFIODevice *vdev =3D &vapdev->vdev;
>=20=20
>      switch (irq) {
> @@ -87,13 +87,13 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevic=
e *vapdev,
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
> @@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDev=
ice *vapdev,
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
> @@ -123,9 +123,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevic=
e *vapdev,
>          event_notifier_cleanup(notifier);
>      }
>=20=20
> -out_free_info:
> -    g_free(irq_info);
> -
> +    return true;
>  }
>=20=20
>  static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
> @@ -171,8 +169,7 @@ static void vfio_ap_realize(DeviceState *dev, Error *=
*errp)
>          goto error;
>      }
>=20=20
> -    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
> -    if (err) {
> +    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &e=
rr)) {
>          /*
>           * Report this error, but do not make it a failing condition.
>           * Lack of this IRQ in the host does not prevent normal operatio=
n.
            */
           error_report_err(err);

Not this patch's problem, but here goes anyway: since this isn't an
error, we shouldn't use error_report_err().  Would warn_report_err() be
appropriate?  info_report_err() doesn't exist, but it could.

       }

       return;

Reviewed-by: Markus Armbruster <armbru@redhat.com>


