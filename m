Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A477C3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 23:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGnGM-0003uG-Qv; Sun, 18 May 2025 19:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uGnGK-0003u1-9A
 for qemu-devel@nongnu.org; Sun, 18 May 2025 19:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uGnGI-0008MB-3V
 for qemu-devel@nongnu.org; Sun, 18 May 2025 19:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747610257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q09rFplXxfXhzt322MMEgoG78Kqgi4iG3jVKzswQ2CI=;
 b=Rekppd6Y8e1x6Dw/ALoJ2d9Uwbt6S8qNHtsNm30Z1TrG2hkt/Gbc31qUCPZjVf4ITEYUge
 mECQK9M3zb7+hedG5I9bKzR33kV9jkgGcZC7NTB6bl97HTezCtNNdWdKjDgudyVWj4MAJa
 UyVqI6IacOa6s7mZIBDkGzOI/nI3EcE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ThkuPjLzPN6LZq84akslUg-1; Sun, 18 May 2025 19:17:35 -0400
X-MC-Unique: ThkuPjLzPN6LZq84akslUg-1
X-Mimecast-MFC-AGG-ID: ThkuPjLzPN6LZq84akslUg_1747610255
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-85b3e93e052so68212239f.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 16:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747610255; x=1748215055;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q09rFplXxfXhzt322MMEgoG78Kqgi4iG3jVKzswQ2CI=;
 b=RvARDKmA8zP+1lDZ8xn6kROJm9MSA1sKa1m4ISktd1UCIURZ15WyTmzYIUXjIyGv6o
 VrKUwxMAa8nzpc3y7rUYtJs+nXOaoSMPoZsXWj6bOJ4OOpHTgQWL3dzHvDYb34rbwKOg
 O/sSgVSYP822r/8L2QoFIAfOv4IWd0pCGakAG2r+lwSDKELqn52l/nLhq83uMqgupq77
 6DxaA7ewHsA8oXMLayzHtU/8DyxnLw5Yz+loC1NqMlKdRVCOGEV1aK/QBzEQ+MDnGAVw
 8AtNb9CZg4oBdo+j9/ktP4udzRWzo6Bv40qzGWQrWxbOZ+CYtd3pmqXwyYcdCnH2/h7q
 yy2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGxdhVRQgxEtYS2WPkqAFuWLJseJ4kCjoZdSaWa4G0E5uTcnWtjGCcSHwnXHvpBzzoBoltPDpqzrvC@nongnu.org
X-Gm-Message-State: AOJu0YzC23vRTjTprx0QUz60zZBjdecKE2WJburUcxx78Ip/EPWZDyGo
 c62tVc1PHcl56iup0Dv6pJ2tX4K+OMoapuXcB4dtcRj4rg1IgNcPBwa8AkemeySaW/VxDSQLBzI
 e/J3rJ5z3SxQHKeO3/dAEQfQ6jHAIbKrQ10ZIF9D6aAm0wJMVKJ5uXzAj
X-Gm-Gg: ASbGncvGpUcPSRfk2MmyjpRgyU99770ds4+gV4FK4NlwL3Pi2u0X1K/WZU/WwoVjYHP
 jfXnf+3VyPDxHzHGJm7ZjRGWpX6aVz9J0s2XQW5EC1yM+bw9wufLtZvwoRwJ4/+MikwRcSahk/Y
 EVTyjeuZQFqntAmzuxXTXFRSXJ82AeEhtOwQqzZl6Swfm90SbuzL6nlrQ5jJM46wo1JvRbxGd7t
 l0RW1jaDKCyQKFlO44N5t0f5A6S5Z7CyRTDk0coLQCcDAdlGgi/4kUJk+ahe12KkOg5F7YCE56/
 Mkc+osFF9s/q5PY=
X-Received: by 2002:a05:6e02:2197:b0:3d4:712e:29ed with SMTP id
 e9e14a558f8ab-3db8437e424mr31487535ab.7.1747610255113; 
 Sun, 18 May 2025 16:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Xps+hB/m4qT+eB1NwQIY6Alb6Qk7exONTHLRs7Q1kPouWdnG4wXnntP48HKrqtdr+MG1MQ==
X-Received: by 2002:a05:6e02:2197:b0:3d4:712e:29ed with SMTP id
 e9e14a558f8ab-3db8437e424mr31487465ab.7.1747610254774; 
 Sun, 18 May 2025 16:17:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3db8443adfcsm16846415ab.44.2025.05.18.16.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 16:17:32 -0700 (PDT)
Date: Sun, 18 May 2025 17:17:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "edmund.raile" <edmund.raile@protonmail.com>
Cc: "clg@kaod.org" <clg@kaod.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "edmund.raile@proton.me"
 <edmund.raile@proton.me>
Subject: Re: [PATCH] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <20250518171730.1ba5bc31.alex.williamson@redhat.com>
In-Reply-To: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
References: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, 18 May 2025 22:09:33 +0000
"edmund.raile" <edmund.raile@protonmail.com> wrote:

> Restore SR-IOV Intel iGPU VF passthrough capability:
> Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk and
> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
> respected despite subsequent attempt of automatic
> IGD opregion detection.
>=20
> Fixes: 7be29f2f1a3f ("Merge tag 'pull-vfio-20250509' of https://github.co=
m/legoater/qemu into staging")

Can you bisect to a specific commit from the merge?  The merge may be
where the issue was introduced to mainline, but the merge commit itself
is more than likely not the source of the issue.  Thanks,

Alex

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
> ---
> This patch fixes a regression in QEMU=E2=80=99s VFIO IGD quirk handling t=
hat
> established automatic IGD opregion detection which ignores=20
> x-igd-opregion=3Doff necessary for SR-IOV VF passthrough of
> Intel iGPUs using i915-sriov-dkms.
>=20
> Please review and provide feedback.
> Let me know if additional testing or changes are needed.
>=20
> Kind regards,
> Edmund Raile.
>=20
>  hw/vfio/igd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7952d15a0..e54a2a2f00 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice =
*vdev, Error **errp)
>          return true;
>      }
> =20
> +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
> +    if (!vdev->igd_opregion) {
> +        return true;
> +    }
> +
>      /* IGD device always comes with OpRegion */
>      if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
>          return true;
> @@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevic=
e *vdev, Error **errp)
>          return true;
>      }
> =20
> +    /* Respect x-igd-opregion=3Doff by skipping OpRegion handling */
> +    if (!vdev->igd_opregion) {
> +        return true;
> +    }
> +
>      /* FIXME: Cherryview is Gen8, but don't support GVT-g */
>      gen =3D igd_gen(vdev);
>      if (gen !=3D 8 && gen !=3D 9) {


