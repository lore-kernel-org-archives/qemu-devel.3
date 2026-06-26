Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183B8CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd0UM-0008Sv-4a; Fri, 26 Jun 2026 02:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wd0UK-0008Se-46
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wd0UI-00083d-2v
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782456988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utjZV4PQ+Y039fIdDNhaFjZMkYnvCIQ9kWkQ24ZQHTg=;
 b=TEXverre4oj9KLUMwg7Gn34Jzl9wlyiIuFkWUNwtSFUAX/LMhg8pbJgTL6o+amUpXmyDHx
 53dzYz+EuNsLTVac7Yl7amyjo2jhxZiLE1A5afCijPGzCTiAJNiV6Bcb6iUqt6xgljEoB3
 tm+f1PY39K563PWYCu+CR4FcsSgd5MU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-PeRgKdu5PvqPEqWpTcMnYQ-1; Fri, 26 Jun 2026 02:56:26 -0400
X-MC-Unique: PeRgKdu5PvqPEqWpTcMnYQ-1
X-Mimecast-MFC-AGG-ID: PeRgKdu5PvqPEqWpTcMnYQ_1782456986
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c2d0a8b5beso6128005ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782456985; x=1783061785; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utjZV4PQ+Y039fIdDNhaFjZMkYnvCIQ9kWkQ24ZQHTg=;
 b=rMARmJzjoqBsxrnYCjJygCp5RCAlSzHRGO2M3W1rgNuq1ylK0GGiV3C88zjgv0H1SN
 xfHzRvIbP7PRITM8aEcSSJtgvJkdwa1FtAQV1iP84SW52l7s7MFlSJ4/J8r7r1My77HH
 31g+ucch07z+xNE45i1wNx69uVq56JxGPJaF5+vwQpVENhv45JcoojzPDxTax7CT/f7J
 rN6AYWNjti5CdiQo+xmz2i9U4v0PYK5Sl+it1lXtcpFD0MQf066xAIOwwaJdtCtKxID3
 dH5a5vOT8PF3wMIAYLNtP1shmvC/bUm4dad3er7I9HqWfas37zjWoJRyRTfwXGIPNWfL
 iEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782456985; x=1783061785;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utjZV4PQ+Y039fIdDNhaFjZMkYnvCIQ9kWkQ24ZQHTg=;
 b=N91cZwXsn4kIdMwRVUbHPm8NkTmniamoBqUxNwyluaC8cfjVtb/KoaQuqMENCcHTkk
 vjfpZcvgT0NotvKBmFtVbZDbddiDbFlrBFLPlpdyygRvclEXfMNnAYOG36iDMllx2FE2
 TV3Qk12dnSuqVVph5Z660dhFeVNcbz51Cb9PSKvdb/HowOLIMYD3pK1VWNyiZCx+yJjM
 dijY6l+bRcN5+UoBXioG/SLlUpODxjLrauASnampmtIrQfbBOO5rolvKvJLV98WC0742
 Fag/Kx1pvXWTiiyKZ7CQ4ssmlFw8mDhRP70nhkHmoRBiHxs4trtYoXeW7213Tkp4PS5w
 PIMQ==
X-Gm-Message-State: AOJu0YwL3bSTE6Uz8ModkoPPVuJWcQQkdMFPlOetoJ0eGsvFCSCHbFZV
 MM7Z398b4rSTYGM/HNEuP8lCXsMb1JL+eBCI+W0pjGJW7j8MI3/ILNA5dtOXT97tbjkZIXeu+h0
 zZ9dBtlJbCL3PeCmC3597S1wiCgiIf7BkRGi92QSO0jdoJA/4rQoMU5+Z
X-Gm-Gg: AfdE7cnzg7ZMOS2YdY7o2HmdUQm182+vmBf1sbEePm4zG6Lw17AMrTRD4l0TT+aiPVl
 xppy5Y5WgGSCGNXttEdd82IqLy13I653qQCk46rAzHwwwHL3YCUzuz/3Uh7SEyVrF0+OVJ9eeOr
 GwhVBnNCcwn//6JzYAm5fOnE+PU0npIf04WhIaLMxAwNTYF6isvIPceDUyHm2+beEPXv9J+OG7E
 tZr/Qn00YVsq1sRa7YfFTdvp4LSBQd40ZOdYrHAHBkleki9VaJfNY6UMn77IKntcIm0mKcBHPhK
 1EC0ifkDmtAT3L4TGpIO4Gehat+OUcd0YZEHH1Zbf5jX6f5un0gDv3oMsDhSHVUJxNlC66uiRm8
 qZAdORNJNH0xMQEDBp9K/VWQnRJmv1nqzmA2t2mozKXZDPD3WGXka38CkOmIU0n33
X-Received: by 2002:a17:902:ced0:b0:2c7:f116:3dbf with SMTP id
 d9443c01a7336-2c7fc65a71dmr53415965ad.7.1782456985363; 
 Thu, 25 Jun 2026 23:56:25 -0700 (PDT)
X-Received: by 2002:a17:902:ced0:b0:2c7:f116:3dbf with SMTP id
 d9443c01a7336-2c7fc65a71dmr53415385ad.7.1782456984673; 
 Thu, 25 Jun 2026 23:56:24 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac88f2sm34755775ad.3.2026.06.25.23.56.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jun 2026 23:56:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 1/8] igvm: store IgvmCfg pointer in QIgvm
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260624055339.46862-2-anisinha@redhat.com>
Date: Fri, 26 Jun 2026 12:26:07 +0530
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4367E627-8061-4751-9A1D-0EDA3AE57BA3@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-2-anisinha@redhat.com>
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
> Store a pointer to IgvmCfg instead of only IgvmFile in QIgvm.  Allows =
to
> store additional state in the (persistent) IgvmCfg struct.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm.c                | 57 ++++++++++++++++++++--------------
> include/system/igvm-internal.h |  2 +-
> 2 files changed, 34 insertions(+), 25 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 3f4b97a5d4..2995e82cee 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -164,7 +164,8 @@ static int qigvm_handler(QIgvm *ctx, =
IgvmVariableHeaderType raw_type,
>         if (handlers[handler].type !=3D type) {
>             continue;
>         }
> -        header_handle =3D igvm_get_header(ctx->file, =
handlers[handler].section,
> +        header_handle =3D igvm_get_header(ctx->cfg->file,
> +                                        handlers[handler].section,
>                                         ctx->current_header_index);
>         if (header_handle < 0) {
>             error_setg(
> @@ -173,7 +174,7 @@ static int qigvm_handler(QIgvm *ctx, =
IgvmVariableHeaderType raw_type,
>                 (int)header_handle);
>             return -1;
>         }
> -        header_data =3D igvm_get_buffer(ctx->file, header_handle);
> +        header_data =3D igvm_get_buffer(ctx->cfg->file, =
header_handle);
>         if (header_data !=3D NULL) {
>             header_data +=3D sizeof(IGVM_VHS_VARIABLE_HEADER);
>             result =3D handlers[handler].handler(ctx, header_data, =
errp);
> @@ -184,7 +185,7 @@ static int qigvm_handler(QIgvm *ctx, =
IgvmVariableHeaderType raw_type,
>                     header_handle, type);
>             result =3D -1;
>         }
> -        igvm_free_buffer(ctx->file, header_handle);
> +        igvm_free_buffer(ctx->cfg->file, header_handle);
>         return result;
>     }
>=20
> @@ -330,7 +331,8 @@ static int qigvm_process_mem_region(QIgvm *ctx, =
unsigned start_index,
>=20
>     for (page_index =3D 0; page_index < page_count; page_index++) {
>         data_handle =3D igvm_get_header_data(
> -            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + =
start_index);
> +            ctx->cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
> +            page_index + start_index);
>         if (data_handle =3D=3D IGVMAPI_NO_DATA) {
>             /* No data indicates a zero page */
>             memset(&region[page_index * page_size], 0, page_size);
> @@ -343,7 +345,7 @@ static int qigvm_process_mem_region(QIgvm *ctx, =
unsigned start_index,
>             return -1;
>         } else {
>             zero =3D false;
> -            data_size =3D igvm_get_buffer_size(ctx->file, =
data_handle);
> +            data_size =3D igvm_get_buffer_size(ctx->cfg->file, =
data_handle);
>             if (data_size < page_size) {
>                 memset(&region[page_index * page_size], 0, page_size);
>             } else if (data_size > page_size) {
> @@ -353,14 +355,14 @@ static int qigvm_process_mem_region(QIgvm *ctx, =
unsigned start_index,
>                            page_index + start_index);
>                 return -1;
>             }
> -            data =3D igvm_get_buffer(ctx->file, data_handle);
> +            data =3D igvm_get_buffer(ctx->cfg->file, data_handle);
>             if (data =3D=3D NULL) {
>                 error_setg(errp, "IGVM: No buffer for handle %d", =
data_handle);
> -                igvm_free_buffer(ctx->file, data_handle);
> +                igvm_free_buffer(ctx->cfg->file, data_handle);
>                 return -1;
>             }
>             memcpy(&region[page_index * page_size], data, data_size);
> -            igvm_free_buffer(ctx->file, data_handle);
> +            igvm_free_buffer(ctx->cfg->file, data_handle);
>         }
>     }
>=20
> @@ -397,7 +399,8 @@ static int qigvm_process_mem_page(QIgvm *ctx,
>             ctx->region_start =3D page_data->gpa;
>             ctx->region_start_index =3D ctx->current_header_index;
>         } else {
> -            if (!qigvm_page_attrs_equal(ctx->file, =
ctx->current_header_index,
> +            if (!qigvm_page_attrs_equal(ctx->cfg->file,
> +                                        ctx->current_header_index,
>                                         page_data,
>                                         &ctx->region_prev_page_data) =
||
>                 ((ctx->region_prev_page_data.gpa +
> @@ -460,7 +463,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, =
const uint8_t *header_data,
>         return 0;
>     }
>=20
> -    data_handle =3D igvm_get_header_data(ctx->file, =
IGVM_HEADER_SECTION_DIRECTIVE,
> +    data_handle =3D igvm_get_header_data(ctx->cfg->file,
> +                                       IGVM_HEADER_SECTION_DIRECTIVE,
>                                        ctx->current_header_index);
>     if (data_handle < 0) {
>         error_setg(errp, "Invalid VP context in IGVM file. Error code: =
%X",
> @@ -468,7 +472,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, =
const uint8_t *header_data,
>         return -1;
>     }
>=20
> -    data =3D (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
> +    data =3D (uint8_t *)igvm_get_buffer(ctx->cfg->file, data_handle);
>     if (data =3D=3D NULL) {
>         error_setg(errp, "IGVM: No buffer for handle %d", =
data_handle);
>         result =3D -1;
> @@ -477,7 +481,8 @@ static int qigvm_directive_vp_context(QIgvm *ctx, =
const uint8_t *header_data,
>=20
>     if (ctx->machine_state->cgs) {
>         result =3D ctx->cgsc->set_guest_state(
> -            vp_context->gpa, data, igvm_get_buffer_size(ctx->file, =
data_handle),
> +            vp_context->gpa, data,
> +            igvm_get_buffer_size(ctx->cfg->file, data_handle),
>             CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
>     } else if (target_arch() =3D=3D SYS_EMU_TARGET_X86_64) {
>         result =3D qigvm_x86_set_vp_context(data, =
vp_context->vp_index, errp);
> @@ -490,7 +495,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, =
const uint8_t *header_data,
>     }
>=20
> exit:
> -    igvm_free_buffer(ctx->file, data_handle);
> +    igvm_free_buffer(ctx->cfg->file, data_handle);
>     if (result < 0) {
>         return result;
>     }
> @@ -803,7 +808,8 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>     uint32_t compatibility_mask_sev_snp =3D 0;
>     uint32_t compatibility_mask =3D 0;
>=20
> -    header_count =3D igvm_header_count(ctx->file, =
IGVM_HEADER_SECTION_PLATFORM);
> +    header_count =3D igvm_header_count(ctx->cfg->file,
> +                                     IGVM_HEADER_SECTION_PLATFORM);
>     if (header_count < 0) {
>         error_setg(errp,
>                    "Invalid platform header count in IGVM file. Error =
code: %X",
> @@ -814,11 +820,11 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>     for (header_index =3D 0; header_index < (unsigned)header_count;
>          header_index++) {
>         IgvmVariableHeaderType typ =3D igvm_get_header_type(
> -            ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
> +            ctx->cfg->file, IGVM_HEADER_SECTION_PLATFORM, =
header_index);
>         typ =3D igvm_vht_type(typ);
>         if (typ =3D=3D IGVM_VHT_SUPPORTED_PLATFORM) {
>             header_handle =3D igvm_get_header(
> -                ctx->file, IGVM_HEADER_SECTION_PLATFORM, =
header_index);
> +                ctx->cfg->file, IGVM_HEADER_SECTION_PLATFORM, =
header_index);
>             if (header_handle < 0) {
>                 error_setg(errp,
>                            "Invalid platform header in IGVM file. "
> @@ -827,11 +833,11 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>                 return -1;
>             }
>             platform =3D
> -                (IGVM_VHS_SUPPORTED_PLATFORM =
*)(igvm_get_buffer(ctx->file,
> +                (IGVM_VHS_SUPPORTED_PLATFORM =
*)(igvm_get_buffer(ctx->cfg->file,
>                                                                 =
header_handle));
>             if (platform =3D=3D NULL) {
>                 error_setg(errp, "IGVM: No buffer for handle %d", =
header_handle);
> -                igvm_free_buffer(ctx->file, header_handle);
> +                igvm_free_buffer(ctx->cfg->file, header_handle);
>                 return -1;
>             }
>=20
> @@ -862,7 +868,7 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>             } else if (platform->platform_type =3D=3D =
IGVM_PLATFORM_TYPE_NATIVE) {
>                 compatibility_mask =3D platform->compatibility_mask;
>             }
> -            igvm_free_buffer(ctx->file, header_handle);
> +            igvm_free_buffer(ctx->cfg->file, header_handle);
>         }
>     }
>     /* Choose the strongest supported isolation technology */
> @@ -939,7 +945,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState =
*machine_state,
>         error_setg(errp, "No IGVM file loaded.");
>         return -1;
>     }
> -    ctx.file =3D cfg->file;
> +    ctx.cfg =3D cfg;
>     trace_igvm_process_file(cfg->file, onlyVpContext);
>=20
>     ctx.machine_state =3D machine_state;
> @@ -961,7 +967,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState =
*machine_state,
>         goto cleanup;
>     }
>=20
> -    header_count =3D igvm_header_count(ctx.file, =
IGVM_HEADER_SECTION_DIRECTIVE);
> +    header_count =3D igvm_header_count(ctx.cfg->file,
> +                                     IGVM_HEADER_SECTION_DIRECTIVE);
>     if (header_count <=3D 0) {
>         error_setg(
>             errp, "Invalid directive header count in IGVM file. Error =
code: %X",
> @@ -975,7 +982,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState =
*machine_state,
>          ctx.current_header_index < (unsigned)header_count;
>          ctx.current_header_index++) {
>         IgvmVariableHeaderType raw_type =3D igvm_get_header_type(
> -            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, =
ctx.current_header_index);
> +            ctx.cfg->file, IGVM_HEADER_SECTION_DIRECTIVE,
> +            ctx.current_header_index);
>         if (!onlyVpContext || igvm_vht_type(raw_type) =3D=3D =
IGVM_VHT_VP_CONTEXT) {
>             if (qigvm_handler(&ctx, raw_type, errp) < 0) {
>                 goto cleanup_parameters;
> @@ -993,7 +1001,7 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState =
*machine_state,
>     }
>=20
>     header_count =3D
> -        igvm_header_count(ctx.file, =
IGVM_HEADER_SECTION_INITIALIZATION);
> +        igvm_header_count(ctx.cfg->file, =
IGVM_HEADER_SECTION_INITIALIZATION);
>     if (header_count < 0) {
>         error_setg(
>             errp,
> @@ -1006,7 +1014,8 @@ int qigvm_process_file(IgvmCfg *cfg, =
MachineState *machine_state,
>          ctx.current_header_index < (unsigned)header_count;
>          ctx.current_header_index++) {
>         IgvmVariableHeaderType type =3D
> -            igvm_get_header_type(ctx.file, =
IGVM_HEADER_SECTION_INITIALIZATION,
> +            igvm_get_header_type(ctx.cfg->file,
> +                                 IGVM_HEADER_SECTION_INITIALIZATION,
>                                  ctx.current_header_index);
>         if (qigvm_handler(&ctx, type, errp) < 0) {
>             goto cleanup_parameters;
> diff --git a/include/system/igvm-internal.h =
b/include/system/igvm-internal.h
> index 7f131c4d03..b55b35328a 100644
> --- a/include/system/igvm-internal.h
> +++ b/include/system/igvm-internal.h
> @@ -43,7 +43,7 @@ typedef struct QIgvmParameterData {
>  * file.
>  */
> struct QIgvm {
> -    IgvmHandle file;
> +    IgvmCfg *cfg;
>     MachineState *machine_state;
>     ConfidentialGuestSupportClass *cgsc;
>     uint32_t compatibility_mask;
> --=20
> 2.42.0
>=20


