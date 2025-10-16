Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7933FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GvR-0006fd-LH; Thu, 16 Oct 2025 01:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9GvP-0006fP-M5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9GvN-0006du-1a
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760593994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FusJHuTU0d3rqfeP3TFtC5qUj6uIOywB1uzJbBrTiNQ=;
 b=YyCpb37jwvhkIOM93gkp/6ugQpRhNZO8f2QQAwi5cLCA4SXQQP7MCTIbv1ldAUrKycqMUI
 sP8kWqvq3Y+ezvzJZfYzYuoJm159NOAPyMpZvDB2/AwcfatymRNV8kftreUdM/DWeB3TJ9
 cuobtGGf38HqJbQj71P1jG6YQ1f6zuQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-4BAaMlv8Pue5B4Zlj1iRGw-1; Thu, 16 Oct 2025 01:53:13 -0400
X-MC-Unique: 4BAaMlv8Pue5B4Zlj1iRGw-1
X-Mimecast-MFC-AGG-ID: 4BAaMlv8Pue5B4Zlj1iRGw_1760593992
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-33428befc5bso615300a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760593992; x=1761198792;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FusJHuTU0d3rqfeP3TFtC5qUj6uIOywB1uzJbBrTiNQ=;
 b=atEptGMBgVT98UeIB5DpKIGYbid2JpLSlwQUevLSjCKvz3dZEQFvBitT3IYX8oRU+w
 sf1ciNfn1UCSnR527vmHtCodbtyhvljAse0JCyCJ2lTjvcDkAE5OxDWSxxOjAAckf3c3
 JtAnwwILOUhEFuZrUa4e1hKWkUl0BWEjLbM1/m/1k5oEOP5soR3csFyOfq+pNz4pt1Q9
 tEDtIog0JyfvrcBFULlpStV9niMFPpQRBn92nVnoiri/TkvYZYqH/rboxttWTFWTy4AV
 oskG6KshzSCrJg1KyTrGXeQSO2Lojw/nweGl6bv0FafIg0vg7xpeGTQhSsbreZPs1zeF
 R2wg==
X-Gm-Message-State: AOJu0Yy07F33U4TVx7FtiLwMSZ934nlb2shsdKcHwpudCfyiEYaOJ4D6
 WjSOEw2MI/j+LmmBSRO7OXL9pi4Ay5hojG6rFvY7xB6ovEFBGxnl+9zZsFAbTjZrPd/qX+oYUgu
 qaS3C+gduUWlqgsYcAreK2aebrjxsou9yeujH5+g9cQ9E7gh/Qco3To/B++m5vVSV2rw=
X-Gm-Gg: ASbGncvICOFUeH8DM/lDTB1fa2voIMbliIdS7kzX8Q0ooAmQvo6UByOQDqsrMetOBAj
 C3/xOBuJBjcvruGe+yf5o0ltRZsISxEpwLJS52z7OgxGvLvmtqV/U5SlJaLl6ey0l62qTcwLWCv
 PzH8jtbWShXp9RzmWWcjMjccfc4h3msmg3Qxh9MfbEbVzwQac3mPqu3LkZ9W8K/xrnazmQFi3c5
 hrj8zhH43r+43+BJObpLnBN+g5KgZXNrGdlYJQEKOjjlMS4Y2fVrh2agw/CUQLMvw85d0tKM6bf
 7LLrV4nAm1GxcABStkJP2FoRmi+GEGu1t0+LtbYk/YAGqdCcRe7reSmhpyNN18FOQSkNvShrIba
 sh73N/Cm926lgM3U=
X-Received: by 2002:a17:90b:5408:b0:33b:b020:596a with SMTP id
 98e67ed59e1d1-33bb0205cf2mr1143601a91.10.1760593991875; 
 Wed, 15 Oct 2025 22:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/2VQPRIxPhF965t/dRQG1oAAmWlUesayDX55Z1OpXdQ0LEyrT68mhZHiA6KsngxNSn3bfkQ==
X-Received: by 2002:a17:90b:5408:b0:33b:b020:596a with SMTP id
 98e67ed59e1d1-33bb0205cf2mr1143574a91.10.1760593991353; 
 Wed, 15 Oct 2025 22:53:11 -0700 (PDT)
Received: from smtpclient.apple ([122.162.208.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bb662553dsm398071a91.9.2025.10.15.22.53.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:53:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v3 4/5] igvm: track memory regions created
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251015112342.1672955-5-kraxel@redhat.com>
Date: Thu, 16 Oct 2025 11:22:56 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C49B146D-D623-49AB-806D-D072FF33E440@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-5-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 15 Oct 2025, at 4:53=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Keep a linked list of the memory regions created by igvm.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm.c | 20 ++++++++++++++------
> 1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index ee5ee74c7a66..1690fb334bf5 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -28,6 +28,11 @@ typedef struct QIgvmParameterData {
>     uint32_t index;
> } QIgvmParameterData;
>=20
> +typedef struct QIgvmMemoryRegion {
> +    QTAILQ_ENTRY(QIgvmMemoryRegion) next;
> +    MemoryRegion mr;
> +} QIgvmMemoryRegion;
> +
> /*
>  * Some directives are specific to particular confidential computing =
platforms.
>  * Define required types for each of those platforms here.
> @@ -73,6 +78,7 @@ typedef struct QIgvm {
>     uint32_t compatibility_mask;
>     unsigned current_header_index;
>     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
> +    QTAILQ_HEAD(, QIgvmMemoryRegion) memory_regions;
>     IgvmPlatformType platform_type;
>=20
>     /*
> @@ -185,7 +191,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>                                   int region_identifier, Error **errp)
> {
>     ERRP_GUARD();
> -    MemoryRegion *igvm_pages =3D NULL;
> +    QIgvmMemoryRegion *pages =3D NULL;
>     Int128 gpa_region_size;
>     MemoryRegionSection mrs =3D
>         memory_region_find(get_system_memory(), addr, size);
> @@ -219,20 +225,21 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>          */
>         g_autofree char *region_name =3D
>             g_strdup_printf("igvm.%X", region_identifier);
> -        igvm_pages =3D g_new0(MemoryRegion, 1);
> +        pages =3D g_new0(QIgvmMemoryRegion, 1);
>         if (ctx->cgs && ctx->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> +            if (!memory_region_init_ram_guest_memfd(&pages->mr, NULL,
>                                                     region_name, size, =
errp)) {
>                 return NULL;
>             }
>         } else {
> -            if (!memory_region_init_ram(igvm_pages, NULL, =
region_name, size,
> +            if (!memory_region_init_ram(&pages->mr, NULL, =
region_name, size,
>                                         errp)) {
>                 return NULL;
>             }
>         }
> -        memory_region_add_subregion(get_system_memory(), addr, =
igvm_pages);
> -        return memory_region_get_ram_ptr(igvm_pages);
> +        memory_region_add_subregion(get_system_memory(), addr, =
&pages->mr);
> +        QTAILQ_INSERT_TAIL(&ctx->memory_regions, pages, next);
> +        return memory_region_get_ram_ptr(&pages->mr);
>     }
> }
>=20
> @@ -928,6 +935,7 @@ int qigvm_process_file(IgvmCfg *cfg, =
ConfidentialGuestSupport *cgs,
>     }
>=20
>     QTAILQ_INIT(&ctx.parameter_data);
> +    QTAILQ_INIT(&ctx.memory_regions);
>=20
>     for (ctx.current_header_index =3D 0;
>          ctx.current_header_index < (unsigned)header_count;
> --=20
> 2.51.0
>=20


