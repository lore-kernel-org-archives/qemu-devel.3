Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2A3CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0YK-0003Lm-AL; Fri, 26 Jun 2026 03:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wd0YD-0003IZ-J7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wd0YA-00024t-R9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 03:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782457229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEzjn/Ovqn1/PLEOwxiqN+Lnr2r5N+J+o0vtlYXYeEU=;
 b=SwR2XlDMiM1+Ef9azKVppiaLQcBiG+CwfCzzAt4nDYcy4Y+H4Frcsbotapw/qoBvzfumvg
 tnLE8hoz1WyPKlv+EakL/l4UwdYiQufXF3u9xUS0M1PeBAcjavrzXTTIrFWiPeXfAu9PW+
 uI1x7AopVH430iFEjiePLLkm1W9RduM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-UOBFRvbfOmCifb0C8LGm5A-1; Fri, 26 Jun 2026 03:00:28 -0400
X-MC-Unique: UOBFRvbfOmCifb0C8LGm5A-1
X-Mimecast-MFC-AGG-ID: UOBFRvbfOmCifb0C8LGm5A_1782457227
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-845bbdc86ebso939138b3a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782457227; x=1783062027; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEzjn/Ovqn1/PLEOwxiqN+Lnr2r5N+J+o0vtlYXYeEU=;
 b=czFtDKvHQ7cxNkkFobmKrv1hlfAVRTk2ji6aneB/Th8XOGr2KRXXee7IQppyKG4Cow
 SPdmQrr+e0bGkZ3geXhargpSWyis9dhMauDsKEaDJi4nYqf80SRsygxusnKG1xnbrZqf
 mUokV7UDRpR1ykg21BvV2D7bndUoVA7MLnLh7Xckytmuv3v31lhKqIItyPba4UMktSW7
 GCR10EHvs5HY7+3lxusQqS9qnRYItaM2MP19jz7zk+Rn0CasLgCG9+LkMX7lkOgQse6R
 NlqzhnB9k25k3AwX5baOe6XMNfArwLcqX2jszc2HbURU967qX0PQnn1qIVOFxlYDgXX5
 ShSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782457227; x=1783062027;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEzjn/Ovqn1/PLEOwxiqN+Lnr2r5N+J+o0vtlYXYeEU=;
 b=UhxpzoKCwx7v38BiM6PmYAMFdW9urznwyF+HYF2SwVI4IQiN/JWyyn8aOwvlMCwi6O
 6KOP9G/8CK0zVepLGSTMEwCdWqaKPWbY8gYNm9rnhHTekv3t5KurWglGoRsAJY5wFW1v
 +tElpXViBvOoxjaC2eENYIm3tVDOxAgJLtNFiurOHDV1RzorSmhQ92WAEOIQJJxn4vmX
 aVfugN2rh2MjiC5tt1rIrMAH7ZrDk3xNEd3KYcBL2W51XIm2LXz349qfgKcco5Jvtd90
 xDiaPZLOn1VPXlYMwAugy4HnzN5+p1e25bwGi8fTiR1Jn+RcyD9eE6r3cKRSRbNhg6+b
 a/HA==
X-Gm-Message-State: AOJu0YyRXPtxD5ABxfj6amtt91rEfN6YQQWjHo7LqtMRBQojoGvKfkDk
 t7d2iZC4nIWezCNCCkvAUmc7vU7k8H2ySH231335Rd41tdIuRYlDvnW/OsY+nTPUkNTliqXcBY4
 bFjOFZNc49HaNifNxbYym8zVC9ibawOKU+er5I1zAqe0nnKZH1hDCSfOu
X-Gm-Gg: AfdE7ckykwxNMXpNfOJtCjg/v1q0mHZd64d6ZIeirMaQJMBwtNns4Rh3YeMJSKWnWi0
 NbQZlUu2XXy8u3HmPOIhTLCY9MNW7G7dizI33Lr1xaPEjEX0L+W6nJ6NqrpfIT8U7uwYVqvXP9F
 LjIEgZkAs9dzbnSb+dJLlmf++XWH6w9hJR/5THhsPLRMcD4eKnzRYmx0nPeuRV4fZzkQn0GeOcW
 LCceb2Xe61sNrHj7mjz91I9GSxT8x1D0z3yUTHVIqNryubkdVK6DG5eCCsPzWI0mcux8wZtyIGZ
 QMdu1wfeVp9J74QwNrbKorJpFOK9kd/1P9zF7RoZoS44zhtZIJItu1Ts3UDnQT05GPvNjusJ4jH
 oOHrgDv0C6F5SFg/JDYSnTrv6i8UWwG7o8cdt684JTwexxIsdAGVRPqP4BAFCdnbN
X-Received: by 2002:a05:6a00:2348:b0:842:3d8d:babb with SMTP id
 d2e1a72fcca58-84591b23f63mr14468732b3a.2.1782457226792; 
 Fri, 26 Jun 2026 00:00:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2348:b0:842:3d8d:babb with SMTP id
 d2e1a72fcca58-84591b23f63mr14468685b3a.2.1782457226260; 
 Fri, 26 Jun 2026 00:00:26 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a413c7ecsm6940062b3a.56.2026.06.26.00.00.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jun 2026 00:00:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 2/8] igvm: track memory regions
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260624055339.46862-3-anisinha@redhat.com>
Date: Fri, 26 Jun 2026 12:30:10 +0530
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B635DC40-CC9E-4D92-BD1D-0289DC1B4EC5@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-3-anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 24 Jun 2026, at 11:23=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Memory regions added by the current IGVM needs to be tracked so that =
they can be
> freed when a new IGVM is loaded.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm-cfg.c            |  1 +
> backends/igvm.c                | 17 +++++++++--------
> include/system/igvm-internal.h |  6 ++++++
> 3 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index e1f09855f6..38438a7b1e 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error =
**errp)
>     IgvmCfg *igvm =3D IGVM_CFG(uc);
>=20
>     igvm->file =3D qigvm_file_init(igvm->filename, errp);
> +    QTAILQ_INIT(&igvm->memory_regions);
> }
>=20
> OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 2995e82cee..1c9751812d 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -206,7 +206,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>                                   int region_identifier, Error **errp)
> {
>     ERRP_GUARD();
> -    MemoryRegion *igvm_pages =3D NULL;
> +    IgvmMemoryRegion *imr =3D NULL;
>     Int128 gpa_region_size;
>     MemoryRegionSection mrs =3D
>         memory_region_find(get_system_memory(), addr, size);
> @@ -240,23 +240,24 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>          */
>         g_autofree char *region_name =3D
>             g_strdup_printf("igvm.%X", region_identifier);
> -        igvm_pages =3D g_new0(MemoryRegion, 1);
> +        imr =3D g_new0(IgvmMemoryRegion, 1);
>         if (ctx->machine_state->cgs &&
>             ctx->machine_state->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> +            if (!memory_region_init_ram_guest_memfd(&imr->mr, NULL,
>                                                     region_name, size, =
errp)) {
> -                g_free(igvm_pages);
> +                g_free(imr);
>                 return NULL;
>             }
>         } else {
> -            if (!memory_region_init_ram(igvm_pages, NULL, =
region_name, size,
> +            if (!memory_region_init_ram(&imr->mr, NULL, region_name, =
size,
>                                         errp)) {
> -                g_free(igvm_pages);
> +                g_free(imr);
>                 return NULL;
>             }
>         }
> -        memory_region_add_subregion(get_system_memory(), addr, =
igvm_pages);
> -        return memory_region_get_ram_ptr(igvm_pages);
> +        memory_region_add_subregion(get_system_memory(), addr, =
&imr->mr);
> +        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
> +        return memory_region_get_ram_ptr(&imr->mr);
>     }
> }
>=20
> diff --git a/include/system/igvm-internal.h =
b/include/system/igvm-internal.h
> index b55b35328a..cab74cfd1d 100644
> --- a/include/system/igvm-internal.h
> +++ b/include/system/igvm-internal.h
> @@ -18,6 +18,11 @@
> #include "system/confidential-guest-support.h"
> #include <igvm/igvm.h>
>=20
> +typedef struct IgvmMemoryRegion {
> +    QTAILQ_ENTRY(IgvmMemoryRegion) next;
> +    MemoryRegion mr;
> +} IgvmMemoryRegion;
> +
> struct IgvmCfg {
>     Object parent_obj;
>=20
> @@ -29,6 +34,7 @@ struct IgvmCfg {
>     char *filename;
>     IgvmHandle file;
>     ResettableState reset_state;
> +    QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
> };
>=20
> typedef struct QIgvmParameterData {
> --=20
> 2.42.0
>=20


