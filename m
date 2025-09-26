Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0277ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29Rl-0000BS-2c; Fri, 26 Sep 2025 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v29RO-0008Qe-0E
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1v29RA-0001NI-JT
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758896916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPKXcXjAPYCfX35UEQNZMVseemAwd0ULz9h/hHPOhy4=;
 b=Gvoitbe9sixATN66rsISKytkVNCGn7N3nfkpeJsQAdkXNUgkRrtX3jHUsw2ZM2iTth4VDZ
 S3PsQC1VsghFHT2Y0N1rp35N+ehj6M49BOqLS5Wnz9rE8b3O1SAO5iZaqW/c0SFfwg535k
 KiNpRyGibEIYlMPFzgmaYeh/kJ9DTfQ=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-5oA9YZbbPXaIvudrr9BYJA-1; Fri, 26 Sep 2025 10:28:32 -0400
X-MC-Unique: 5oA9YZbbPXaIvudrr9BYJA-1
X-Mimecast-MFC-AGG-ID: 5oA9YZbbPXaIvudrr9BYJA_1758896912
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-374bc37f3b0so10313fac.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758896911; x=1759501711;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bPKXcXjAPYCfX35UEQNZMVseemAwd0ULz9h/hHPOhy4=;
 b=hpdYL6mJHgYkaa7CCk0Ih9P2yztOnCyIvE3Y+OWBBxBPmavEK0DTD+rs3Q9K7FqnVL
 H7PcipVsX1+Zx8Th0sl7Eftu6hDQH0lBk+3XLohXxwDS4ARCU9OQFRU1vJgH2PAAmSeJ
 UX8l8n3zKWg2UwA/dhIcgn/R1iZn7hrGBQ3dPm18sGGqlxSTEziqG1mWXLEtT5y3n5cn
 RTjK5nWNT+6Rocm31V9ypkxw/mQABPsxxWYOqbyDKTYmolB/klB8y4xl6aTPmLybNhgc
 GCLtjxg0akVnLe+jA41SgDXuZIMlvNu3RbKcPCgMazN9QBU3za3r2bOyDjuXxm3ERPlf
 O1bQ==
X-Gm-Message-State: AOJu0YzjoReoNLw3kgQjeZwp7B6aeSoI9DBrtz9gSDvugo27XLazkuoA
 hBOJkHtixt5Mn2F3A2BvA/5gkkEARQyu6JsJLSAncuD7ZC1H3rvDWLTIdxQFN931ZGsp1wMKpAt
 r3/tu2jkNRplnbTnk6VBeTyk+uhOt0oNoKoBq4gWlBSX65cEjiW5hU82r43ji8Jqr
X-Gm-Gg: ASbGncsN/OIi7f2bgIUY4YtNzkezUGN06Yo2pWCzTiavXf1I8RCWi82kSSJ6DRzZyGi
 XYQbsJWVN8oqEf/l763BkEL/W2xHZuJ5pUlk4xtHtLAo5knGVI7qonuRF9X9Ndxf5v8byBmP4BU
 f1GXK6hZNB0zT8dRs8CgCKj1NzxusNTOJkOxhinxFYiuzWYCPeQWmUVz4+3mP+wdEjkfjkn1P/F
 9Ftl2uAGGHQGBBKxI9FMByJX9FYM/bw8ggrBorAqGUaE/nSTIgBUJKMOrXNjKNF94lJNwlQmlaL
 XlOpeKeYwXsQXgLEXvSmTxzMr4/nEO7lItAqvnBHpZg=
X-Received: by 2002:a05:6871:7417:b0:332:dfb2:2341 with SMTP id
 586e51a60fabf-35eeb6d70f0mr1659045fac.6.1758896910805; 
 Fri, 26 Sep 2025 07:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4JEZ2qYEKNypXvN+LNOkazYjGSJLJr4tk9f1f5cRU8u/0GMyh2yX+9DqAYJTOPaeZezjrw==
X-Received: by 2002:a05:6871:7417:b0:332:dfb2:2341 with SMTP id
 586e51a60fabf-35eeb6d70f0mr1659035fac.6.1758896910313; 
 Fri, 26 Sep 2025 07:28:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a3d46f3fsm1451115fac.9.2025.09.26.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:28:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 08:28:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] vfio: Remove workaround for kernel DMA unmap overflow bug
Message-ID: <20250926082826.5be6fa67.alex.williamson@redhat.com>
In-Reply-To: <20250926085423.375547-1-clg@redhat.com>
References: <20250926085423.375547-1-clg@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 26 Sep 2025 10:54:23 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> A kernel bug was introduced in Linux v4.15 via commit 71a7d3d78e3c
> ("vfio/type1: Check for address space wrap-around on unmap"), which
> added a test for address space wrap-around in the vfio DMA unmap path.
> Unfortunately, due to an integer overflow, the kernel would
> incorrectly detect an unmap of the last page in the 64-bit address
> space as a wrap-around, causing the unmap to fail with -EINVAL.
>=20
> A QEMU workaround was introduced in commit 567d7d3e6be5 ("vfio/common:
> Work around kernel overflow bug in DMA unmap") to retry the unmap,
> excluding the final page of the range.
>=20
> The kernel bug was then fixed in Linux v5.0 via commit 58fec830fc19
> ("vfio/type1: Fix dma_unmap wrap-around check"). Since the oldest
> supported LTS kernel is now v5.4, kernels affected by this bug are
> considered deprecated, and the workaround is no longer necessary.
>=20
> This change reverts 567d7d3e6be5, removing the workaround.
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1662291
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/container-legacy.c | 20 +-------------------
>  hw/vfio/trace-events       |  1 -
>  2 files changed, 1 insertion(+), 20 deletions(-)
>=20
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index c0f87f774a00805cab4a8f3b3386ddd99c3d9111..25a15ea8674c159b7e624425c=
52953240b8c1179 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -147,25 +147,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOConta=
iner *bcontainer,
>          need_dirty_sync =3D true;
>      }
> =20
> -    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        /*
> -         * The type1 backend has an off-by-one bug in the kernel (71a7d3=
d78e3c
> -         * v4.15) where an overflow in its wrap-around check prevents us=
 from
> -         * unmapping the last page of the address space.  Test for the e=
rror
> -         * condition and re-try the unmap excluding the last page.  The
> -         * expectation is that we've never mapped the last page anyway a=
nd this
> -         * unmap request comes via vIOMMU support which also makes it un=
likely
> -         * that this page is used.  This bug was introduced well after t=
ype1 v2
> -         * support was introduced, so we shouldn't need to test for v1. =
 A fix
> -         * is queued for kernel v5.0 so this workaround can be removed o=
nce
> -         * affected kernels are sufficiently deprecated.
> -         */
> -        if (errno =3D=3D EINVAL && unmap.size && !(unmap.iova + unmap.si=
ze) &&
> -            container->iommu_type =3D=3D VFIO_TYPE1v2_IOMMU) {
> -            trace_vfio_legacy_dma_unmap_overflow_workaround();
> -            unmap.size -=3D 1ULL << ctz64(bcontainer->pgsizes);
> -            continue;
> -        }
> +    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          return -errno;
>      }
> =20
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e3d571f8c845dad85de5738f8ca768bdfc336252..7496e1b64b5de0168974a251e=
ab698399a6a1d54 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -112,7 +112,6 @@ vfio_container_disconnect(int fd) "close container->f=
d=3D%d"
>  vfio_group_put(int fd) "close group->fd=3D%d"
>  vfio_device_get(const char * name, unsigned int flags, unsigned int num_=
regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
>  vfio_device_put(int fd) "close vdev->fd=3D%d"
> -vfio_legacy_dma_unmap_overflow_workaround(void) ""
> =20
>  # region.c
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t d=
ata, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


