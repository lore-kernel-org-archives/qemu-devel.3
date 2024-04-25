Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A107C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwmd-0006Gl-Q4; Thu, 25 Apr 2024 06:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzwmb-0006GG-Pr
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzwmZ-0005g8-L3
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714042610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MP+Hlzr6QfRaZ+IO6VQcYPI9gXCiaBSyIq6qNp1JEYE=;
 b=HyeVdqzUnDsdeV9SL4njdfesqx6dcOEv5P1xlaze7mWjEY/6rR4+dIElec75zbPZqd9lzF
 RjGFnCL9HTxxwRzoiM+twWMhTofKEQjJkXzI8mSG1mVQzYEPlca3kqKyR1hbC9ocbBUuWm
 6nZkGNuC+v5UepHLQfnsaJgwa6icE6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-RgysRa4uPN2g4X4v-ssWXg-1; Thu,
 25 Apr 2024 06:56:46 -0400
X-MC-Unique: RgysRa4uPN2g4X4v-ssWXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F173C000AA;
 Thu, 25 Apr 2024 10:56:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2CB040C6DAE;
 Thu, 25 Apr 2024 10:56:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0285521E66C8; Thu, 25 Apr 2024 12:56:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 4/4] vfio/ccw: Make vfio_ccw_register_irq_notifier()
 return a bool
In-Reply-To: <20240425090214.400194-5-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Thu, 25 Apr 2024 11:02:14 +0200")
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-5-clg@redhat.com>
Date: Thu, 25 Apr 2024 12:56:44 +0200
Message-ID: <87il056783.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

> Since vfio_ccw_register_irq_notifier() takes an 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h Rules
> section.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/ccw.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6764388bc47a970329fce2233626ccb8178e0165..1c630f6e9abe93ae0c2b5615d=
4409669f096c8c9 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -379,7 +379,7 @@ read_err:
>      css_inject_io_interrupt(sch);
>  }
>=20=20
> -static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
> +static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>                                             unsigned int irq,
>                                             Error **errp)
>  {
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
> @@ -439,6 +439,8 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDev=
ice *vcdev,
>          qemu_set_fd_handler(fd, NULL, NULL, vcdev);
>          event_notifier_cleanup(notifier);
>      }
> +
> +    return true;
>  }
>=20=20
>  static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
> @@ -602,20 +604,18 @@ static void vfio_ccw_realize(DeviceState *dev, Erro=
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
            */
           error_report_err(err);

Not this patch's problem, but here goes anyway: since this isn't an
error, we shouldn't use error_report_err().  Would warn_report_err() be
appropriate?  info_report_err() doesn't exist, but it could.

Preferably with errp instead of &err (two times):
Reviewed-by: Markus Armbruster <armbru@redhat.com>


