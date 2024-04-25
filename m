Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwjS-00038t-HV; Thu, 25 Apr 2024 06:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzwjR-00038T-1Y
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzwjP-0003g4-DV
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714042414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KB2hxhS45wiBLaDg9H2Z2IQHbS5Ev3rZnxNYuk2+6HA=;
 b=PxEXyZPIZYF++lXv9GoFPx7iVB5OPvM4k99CQAorYrrw1dcNP5wTTtqlucY0OPod02uqYV
 yJ9HN7vz+d+10XuGkKquXTYHMwFyFP1tvZfSqAXSGwayAeqye0KJMF44bLKv7KyWwK2AsK
 /VPDMnGB70GGsh1GiFPpIj97CuI5IB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-KcQo_978Pi6Ab01SfvaIiQ-1; Thu, 25 Apr 2024 06:53:32 -0400
X-MC-Unique: KcQo_978Pi6Ab01SfvaIiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CECED800935;
 Thu, 25 Apr 2024 10:53:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE4E151BF;
 Thu, 25 Apr 2024 10:53:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCD8721E66E5; Thu, 25 Apr 2024 12:53:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Tony Krowiak <akrowiak@linux.ibm.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/4] vfio/ap: Make vfio_ap_register_irq_notifier()
 return a bool
In-Reply-To: <20240425090214.400194-3-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Thu, 25 Apr 2024 11:02:12 +0200")
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-3-clg@redhat.com>
Date: Thu, 25 Apr 2024 12:53:30 +0200
Message-ID: <87r0et67dh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

> Since vfio_ap_register_irq_notifier() takes and 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h Rules
> section.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/ap.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 03f8ffaa5e2bf13cf8daa2f44aa4cf17809abd94..8bb024e2fde4a1d72346dee4b=
662d762374326b9 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -70,7 +70,7 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>      }
>  }
>=20=20
> -static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
> +static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                            unsigned int irq, Error **errp)
>  {
>      int fd;
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
> -        return;
> +        return false;
>      }
>=20=20
>      if (event_notifier_init(notifier, 0)) {
>          error_setg_errno(errp, errno,
>                           "vfio: Unable to init event notifier for irq (%=
d)",
>                           irq);
> -        return;
> +        return false;
>      }
>=20=20
>      fd =3D event_notifier_get_fd(notifier);
> @@ -122,6 +122,8 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevic=
e *vapdev,
>          qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>          event_notifier_cleanup(notifier);
>      }
> +
> +    return true;
>  }
>=20=20
>  static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
> @@ -167,8 +169,7 @@ static void vfio_ap_realize(DeviceState *dev, Error *=
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

This patch is fine as is, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>


