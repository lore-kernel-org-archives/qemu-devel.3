Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C601CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 21:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umfok-0004Cz-6G; Thu, 14 Aug 2025 17:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umfoi-0004Ce-OV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 17:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1umfof-000200-MJ
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 17:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755208133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LpbJ4WC/HRL9bNpOa0eGeEubmFrwqk3LMkv8DJqicQ=;
 b=gOxtSIygoIwbgeTOvMeqkJgeYE3+j5Be9X8/dLzJ+/ZqZ7w7qqYDYPO36/a+zoTW5vWzCq
 fTELZh1NhyV6BwuR0r7vejZTkHlxGi1JPcLNOL3sl4eiCS7JfxRLz65F1iIZ78hF1phKew
 oZG5N9NwULBksV+FAjDT5v/r4xrMUqM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-dmH_mG47PEqlp32teDZ6Sg-1; Thu, 14 Aug 2025 17:48:51 -0400
X-MC-Unique: dmH_mG47PEqlp32teDZ6Sg-1
X-Mimecast-MFC-AGG-ID: dmH_mG47PEqlp32teDZ6Sg_1755208129
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3e56ff9e1f8so1901685ab.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 14:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755208129; x=1755812929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8LpbJ4WC/HRL9bNpOa0eGeEubmFrwqk3LMkv8DJqicQ=;
 b=mIDkZpVRPWJYFPUDr0gFp3WEKSHsemO+fgHG7LhjxaLuyCrDFP1deQ4WukdXoRI5c1
 BC8NZf8GU4cLkBbNwopZxHrO3qgtUs40djsAWr1pWI+xPjFm2gPbTN6ZR7VLwURpwWaa
 sgqmPjO25oqirRjs94cOIgdOuQuiSS89AmlBzhPGxoaMjfMN+GxnLGeM+uINaBeAH9Tu
 EibsHgvqMk9L+ktSI+HAQmlsJt6nGXJEJEVKrVGFM7oiKiZV7lVGZzxwKYCCvyv8XI7b
 3N2ZXCywUnmizn64vzaL/CCCov5+llqWjfRSWg2Y/1YYWH3IuINYQSn7/paNvmSRpc4u
 8YMg==
X-Gm-Message-State: AOJu0YyLvwDRG+BUZyUVW1PkOUTGeXvLRxB3JD4UAfHEMlO9gFrIegha
 1+sg/aLYRjH6czahyLgeyLiccOHRYQuPFsHyhi7GhzPNLP+Wm+OPwryu5EpqoaFvJqtlrJiAGjc
 4jZ04FwhdCu4ogW8izIK/uZvXNTjxoxpR8kVHJfYd3Qiqom0i3nuzN+ji
X-Gm-Gg: ASbGnctf3uzqh3MEbcpg0l6Gcy6MvBbbeegBtynHZQWp+n64TyGeeVCnL+BTr/L17fj
 0ylB/8odoFH6aU7c3zdC00Tp57BNTuVXl/gyuf/WcrVf6sgLUgJ9Ais2uKrI4cGY8Sw4xO+aSNX
 PQNfb4T4JD3VaazuEBu3ONIVf4bOobpO8WimerDXVM3st4ziAbsev2ym2PThvrRYSZS2kMRwtxQ
 YucXZiIPwgxeKMuScKEf5+XhIQ05pY5djic+sH8ggB7hwYDazIniy0j3z3q10YybkMCeO38MWww
 eVgK9vkQ+LPuiYodNarSlbM8k+5q7Dq0hUEZU+yfCh4=
X-Received: by 2002:a05:6e02:1fc9:b0:3df:3902:8b8c with SMTP id
 e9e14a558f8ab-3e57094e0c4mr26548445ab.3.1755208129149; 
 Thu, 14 Aug 2025 14:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb4aCtNW8DcqO6DgwoZmHTaMkON6JQZbYwhNCQN3p7hwKrLKjj7ducToF4YRLJsYOHYNRuTw==
X-Received: by 2002:a05:6e02:1fc9:b0:3df:3902:8b8c with SMTP id
 e9e14a558f8ab-3e57094e0c4mr26548365ab.3.1755208128732; 
 Thu, 14 Aug 2025 14:48:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e5418db19csm56661085ab.2.2025.08.14.14.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:48:48 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:48:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
Message-ID: <20250814154846.4bea4710.alex.williamson@redhat.com>
In-Reply-To: <20250814153419.1643897-1-clg@redhat.com>
References: <20250814153419.1643897-1-clg@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Thu, 14 Aug 2025 17:34:19 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
> limit of 65535, which is configurable via the 'dma_max_mappings'
> module parameter. When this limit is reached, QEMU issues a warning
> and fails the mapping operation, but allows the VM to continue
> running, potentially causing issues later. This scenario occurs with
> SEV-SNP guests, which must update all IOMMU mappings during
> initialization.
>=20
> To address this, update vfio_ram_discard_register_listener() to accept
> an 'Error **' parameter and propagate the error to the caller. This
> change will halt the VM immediately, at init time, with the same error
> message.
>=20
> Additionally, the same behavior will be enforced at runtime. While
> this might be considered too brutal, the rarity of this case and the
> planned removal of the dma_max_mappings module parameter make it a
> reasonable approach.
>=20
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/listener.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 184c15e05fcb388cf0848e97e1eb283f17a50ad4..bc40ec8613c71a12b8c0dfdea=
497a14a446ac1fd 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -250,8 +250,9 @@ int vfio_ram_discard_notify_populate(RamDiscardListen=
er *rdl,
>      return 0;
>  }
> =20
> -static void vfio_ram_discard_register_listener(VFIOContainerBase *bconta=
iner,
> -                                               MemoryRegionSection *sect=
ion)
> +static bool vfio_ram_discard_register_listener(VFIOContainerBase *bconta=
iner,
> +                                               MemoryRegionSection *sect=
ion,
> +                                               Error **errp)
>  {
>      RamDiscardManager *rdm =3D memory_region_get_ram_discard_manager(sec=
tion->mr);
>      int target_page_size =3D qemu_target_page_size();
> @@ -316,13 +317,15 @@ static void vfio_ram_discard_register_listener(VFIO=
ContainerBase *bcontainer,
> =20
>          if (vrdl_mappings + max_memslots - vrdl_count >
>              bcontainer->dma_max_mappings) {
> -            warn_report("%s: possibly running out of DMA mappings. E.g.,=
 try"
> +            error_setg(errp, "%s: possibly running out of DMA mappings. =
E.g., try"
>                          " increasing the 'block-size' of virtio-mem devi=
es."
>                          " Maximum possible DMA mappings: %d, Maximum pos=
sible"
>                          " memslots: %d", __func__, bcontainer->dma_max_m=
appings,
>                          max_memslots);
> +            return false;
>          }
>      }
> +    return true;
>  }
> =20
>  static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcon=
tainer,
> @@ -576,7 +579,9 @@ void vfio_container_region_add(VFIOContainerBase *bco=
ntainer,
>       */
>      if (memory_region_has_ram_discard_manager(section->mr)) {
>          if (!cpr_remap) {
> -            vfio_ram_discard_register_listener(bcontainer, section);
> +            if (!vfio_ram_discard_register_listener(bcontainer, section,=
 &err)) {
> +                goto fail;
> +            }
>          } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
>                                                             section)) {
>              error_setg(&err,

LGTM

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


