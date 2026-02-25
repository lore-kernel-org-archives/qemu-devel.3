Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41537E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7d5-0005AV-Qo; Wed, 25 Feb 2026 00:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv7d3-0005AN-Sm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vv7d1-0007SF-6L
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771998005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxS379o7r+4yfEJ82c2Qi0MQdCRLN+3GOza9T1cyYLA=;
 b=UqvvI+pXgt8CW9TKBqKHdjLy0r8eGFZJ2Q8wmZ04G/G2v3+2p+A/SqpcSl6SzwyjQUOYz6
 v/SZQzX/mwZPTSREjyNlNsfKybTGtQei5AAbZgZb8AzwUj9GHmOobWrDUDvfb2YVmBo4vd
 TppG94FK70L0iye+MFh95Fde1KCqZ6A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-CEKfmimjN7WuGZB7L8hZhQ-1; Wed,
 25 Feb 2026 00:40:03 -0500
X-MC-Unique: CEKfmimjN7WuGZB7L8hZhQ-1
X-Mimecast-MFC-AGG-ID: CEKfmimjN7WuGZB7L8hZhQ_1771998002
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A9B618004A9; Wed, 25 Feb 2026 05:40:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 954161800465; Wed, 25 Feb 2026 05:40:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CDB421E692D; Wed, 25 Feb 2026 06:39:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hamilton <dahamilt0@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
In-Reply-To: <20260224190004.84187-2-dahamilt0@gmail.com> (David Hamilton's
 message of "Tue, 24 Feb 2026 14:00:03 -0500")
References: <20260224190004.84187-1-dahamilt0@gmail.com>
 <20260224190004.84187-2-dahamilt0@gmail.com>
Date: Wed, 25 Feb 2026 06:39:59 +0100
Message-ID: <87qzq9xtxs.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

David Hamilton <dahamilt0@gmail.com> writes:

> The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
> ignored. Propagate the error to the caller via errp.
>
> Resolves the TODO comment at the call site.
>
> Signed-off-by: David Hamilton <dahamilt0@gmail.com>
> ---
>  hw/misc/ivshmem-pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
> index a3a43f53bd..45b0e20363 100644
> --- a/hw/misc/ivshmem-pci.c
> +++ b/hw/misc/ivshmem-pci.c
> @@ -449,6 +449,7 @@ static void setup_interrupt(IVShmemState *s, int vect=
or, Error **errp)
>          ivshmem_has_feature(s, IVSHMEM_MSI);
>      PCIDevice *pdev =3D PCI_DEVICE(s);
>      Error *err =3D NULL;
> +    int ret;
>=20=20
>      IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
>=20=20
> @@ -464,9 +465,13 @@ static void setup_interrupt(IVShmemState *s, int vec=
tor, Error **errp)
>          }
>=20=20
>          if (!msix_is_masked(pdev, vector)) {
> -            kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
> +            ret =3D kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NUL=
L,
>                                                 s->msi_vectors[vector].vi=
rq);
> -            /* TODO handle error */
> +            if (ret < 0) {
> +                error_setg(errp, "Failed to configure irqfd notifier"
> +                            " for vector %d, vector");

Scratch ", vector".

> +                return;
> +            }
>          }
>      } else {
>          /* it will be delayed until msix is enabled, in write_config */

qapi/error.h:

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

Please make the function return false on error, true on success.

This will simplify the next patch.


