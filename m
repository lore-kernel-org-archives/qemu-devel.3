Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCli-0001fJ-5x; Wed, 29 May 2024 02:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCClg-0001eo-HG
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sCCle-0005sM-KH
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716963993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5o65ZxxHtLh+QTTdQSSYj01W9SQJYxql/oLicv2uXDY=;
 b=Ca+sdwtBn1Nc4nUNyOoEjJDneSP+BuX10vSVydfUgMZ6kDYrZjwN1oRFRcs2EX3MMljqhk
 63PftEbmtCCfDEflQoBymCJzJKjKmBpyceJmZgiu3ypPHmornGfsp94Dg010Gvz8JKYv+v
 71GTpwvN2RCFlPJmxqMq0sZAAtUX4Z8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-5gI7Z8YzN9Ob3mcuvAgrUA-1; Wed, 29 May 2024 02:26:29 -0400
X-MC-Unique: 5gI7Z8YzN9Ob3mcuvAgrUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34EBC800CA5;
 Wed, 29 May 2024 06:26:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF4E3286E;
 Wed, 29 May 2024 06:26:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9C1B21E668F; Wed, 29 May 2024 08:26:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Alex Williamson <alex.williamson@redhat.com>,  Avihai
 Horon <avihaih@nvidia.com>,  Eric Auger <eric.auger@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 1/9] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
In-Reply-To: <20240516124658.850504-2-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Thu, 16 May 2024 14:46:50 +0200")
References: <20240516124658.850504-1-clg@redhat.com>
 <20240516124658.850504-2-clg@redhat.com>
Date: Wed, 29 May 2024 08:26:27 +0200
Message-ID: <878qztp20c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I had a look at this before I realized it's already in.  I'm sending
this out not to demand any change, but only to point out an issue to be
avoided in future work.

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> We will use the Error object to improve error reporting in the
> .log_global*() handlers of VFIO. Add documentation while at it.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>  hw/vfio/common.c                      |  4 ++--
>  hw/vfio/container-base.c              |  4 ++--
>  hw/vfio/container.c                   |  6 +++---
>  4 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio=
-container-base.h
> index 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a=
9845866c4a8c090 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -82,7 +82,7 @@ int vfio_container_add_section_window(VFIOContainerBase=
 *bcontainer,
>  void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>                                         MemoryRegionSection *section);
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start);
> +                                           bool start, Error **errp);
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontaine=
r,
>                                        VFIOBitmap *vbmap,
>                                        hwaddr iova, hwaddr size);
> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>      void (*detach_device)(VFIODevice *vbasedev);
> +
>      /* migration feature */
> +
> +    /**
> +     * @set_dirty_page_tracking
> +     *
> +     * Start or stop dirty pages tracking on VFIO container
> +     *
> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
> +     *              page tracking
> +     * @start: indicates whether to start or stop dirty pages tracking
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> -                                   bool start);
> +                                   bool start, Error **errp);

Note for later: this is always called via
vfio_container_set_dirty_page_tracking().

>      int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>                                VFIOBitmap *vbmap,
>                                hwaddr iova, hwaddr size);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739f=
b7106c0c77df737 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1076,7 +1076,7 @@ static bool vfio_listener_log_global_start(MemoryLi=
stener *listener,
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          ret =3D vfio_devices_dma_logging_start(bcontainer);
>      } else {
> -        ret =3D vfio_container_set_dirty_page_tracking(bcontainer, true);
> +        ret =3D vfio_container_set_dirty_page_tracking(bcontainer, true,=
 NULL);
>      }
>=20=20
>      if (ret) {
> @@ -1096,7 +1096,7 @@ static void vfio_listener_log_global_stop(MemoryLis=
tener *listener)
>      if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>          vfio_devices_dma_logging_stop(bcontainer);
>      } else {
> -        ret =3D vfio_container_set_dirty_page_tracking(bcontainer, false=
);
> +        ret =3D vfio_container_set_dirty_page_tracking(bcontainer, false=
, NULL);
>      }
>=20=20
>      if (ret) {

Note for later: all callers pass NULL to ignore the new Error.

> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e36=
8d7dff78a6d65aa 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerB=
ase *bcontainer,
>  }
>=20=20
>  int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
> -                                           bool start)
> +                                           bool start, Error **errp)
>  {
>      if (!bcontainer->dirty_pages_supported) {
>          return 0;
>      }
>=20=20
>      g_assert(bcontainer->ops->set_dirty_page_tracking);
> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, e=
rrp);
>  }
>=20=20
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontaine=
r,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd1=
86fc958e24f28f7 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBas=
e *bcontainer, hwaddr iova,
>=20=20
>  static int
>  vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> -                                    bool start)
> +                                    bool start, Error **errp)
>  {
>      const VFIOContainer *container =3D container_of(bcontainer, VFIOCont=
ainer,
>                                                    bcontainer);
> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContain=
erBase *bcontainer,
>      ret =3D ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>      if (ret) {
>          ret =3D -errno;
> -        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
> -                     dirty.flags, errno);
> +        error_setg_errno(errp, errno, "Failed to set dirty tracking flag=
 0x%x",
> +                         dirty.flags);

Silent improvement: errno is now reported symbolically (like "Operation
not permitted") instead of numerically (like "1").  Worth mentioning in
the commit message.

Since the callers pass NULL to ignore the Error, this error condition is
now silent, I believe.

I figure you correct this in later patches.  If we accept temporary loss
of error reporting, the commit message should mention it.  Loss of error
reporting is easy enough to avoid, though: have the callers pass a
pointer to a local @err, and on failure report it with
error_report_err().

>      }
>=20=20
>      return ret;


