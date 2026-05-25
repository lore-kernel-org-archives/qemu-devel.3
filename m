Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C08ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 14:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRVyn-0005RD-N0; Mon, 25 May 2026 10:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRVyf-0005QY-Ew
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRVya-0001H7-Od
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779718093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFzNjyQRbnmOZr6PooTu1RoGYysXRqX63anLdpW4JXc=;
 b=iui6to+LGOAU8IDp33NyESTVJYKBX7wuVvOeBnEbMiawtPAMAmyiZ3F/EaQ2yV1bZdsEUI
 NMp/b75Q+qo9AJ7fAb+n1aNSoQJ3SUX4VKO0sYfSQe1DolINzLb/3Gy51SomvZ2sgwEsuX
 NyNHV6v/zv9YyP+Nkxn1CEt6DnL4Oug=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-AlIA_bvRMa2TnNxPvwRtFQ-1; Mon, 25 May 2026 10:08:11 -0400
X-MC-Unique: AlIA_bvRMa2TnNxPvwRtFQ-1
X-Mimecast-MFC-AGG-ID: AlIA_bvRMa2TnNxPvwRtFQ_1779718091
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36603ad6709so8121555a91.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779718091; x=1780322891; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFzNjyQRbnmOZr6PooTu1RoGYysXRqX63anLdpW4JXc=;
 b=I4E5hsIWP6puqacthbNCjcFcA3H++zG6bykQNVhZHKN7oOMYkp3eSjSSEArwWt40gb
 YnsgxyItC1nWLUCZ0JWLt4dfGQ3lE9LeZXDFMPtJNzqW9celezYDjkhrYSX9B1DKhKZJ
 meKQHaWT++NjljVDsrAwCxiNjdkq+ZYzyE4d+MC0ejttG1XA8QD5U92kqlZmC5a1M1Go
 qnVlwOwaQttvwaP9KuooQq/hyZzjWtfEICfQgNbIsD/SG/DY05Ihhq47GE/GF5nRKESR
 QmIiKQ8TjM+2BezfsAXVrrxHQ8lmkEL3qV0Hm3bOiOiXmU8sXJNiUujTrMP+wlHlAOLg
 HB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718091; x=1780322891;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFzNjyQRbnmOZr6PooTu1RoGYysXRqX63anLdpW4JXc=;
 b=AuuVSMa7BPhrniWtMMK9+HBN4kKU5mwOp84XggGzRcp/FgMwL+DQ9g4xrf7a2fpYhi
 bEDfHpirs90juaO20pKhcTzrkTywFV0cloCaiFjQ5XjxMFVHfABe8foN698hmCK4BULF
 OV29YL9mZWIgT+i3oU/g4P1+D3NOkzGNMaeY/LHZR2uxpaWgqE/q6ysBlrlAUvluAiX+
 5apSbKVJ5iVEPhW8Gkzz3cmqB/t9HVDH1s172YmdC9gS9p7Ok/g/VGqm0Pe4yMKuYRgb
 Dnq2tts/PrNAQmR9AZC4D/iv29RcFvcyl9UdO0qh9Tzfbd903AhoP/UFi/XN8JKtxgVY
 Hx0w==
X-Gm-Message-State: AOJu0YxM0FRBZ8+njqqGYjQ3PeSqhQGJFuPS8njJIGc7p+6l1+eNPNdt
 7/3RbM7FarAOSDtExWf1ySvrbtxSfkUXsIrL/r4rsf3BRrFzS1cUmxU+4lzM+8c8KcwxcK4mf+P
 6acv7yMwbIiVAQxd0sRU9u6A5P/rJWCSaA5VjlxO/NGBhplMWAwzakkQJ
X-Gm-Gg: Acq92OHiAVFHD3GOFVCm2ec5TP8Ulcclev0AS0vRsCArhfTICJ0IkaTKGQS8tMiBLSe
 RozPnQyVCbrF7e2CwEKz3WeNJCcwTRjxUeqY8LVMToJQDTEwwbsly2qKUQSauMEaz4TzICg2g+d
 Z4bFvA7+qRGVpmaefCIcPjfD2a7j5EcBlIzugdbDqENlNYIZPOyLebJQN6tnWcFJJop8h8ZYNZj
 drdKhj/5F9Nci+XbKmJjy+DJWe2zk5yFkQAYR+1ShSFVBje4VqpO+zBimfEZYj+9sQeZFnDKHQt
 mmucY4ZJRZhcLTU4cJKDptLbRTQVKrSkiy7V1p8knPnFjnSoSE2X1NJfU7mwZ0x/VTiN7Am5+r+
 U7Ezjcz45cgtXzpGdz7WLxUdzNKHC65O8kuHMeJWGSNlPkjLkahC88DcD3KDTzg6GOwvt3Qet43
 PQlvKkdjThWA==
X-Received: by 2002:a17:90b:198c:b0:36a:9f69:6df3 with SMTP id
 98e67ed59e1d1-36a9f69ca06mr5934816a91.24.1779718090556; 
 Mon, 25 May 2026 07:08:10 -0700 (PDT)
X-Received: by 2002:a17:90b:198c:b0:36a:9f69:6df3 with SMTP id
 98e67ed59e1d1-36a9f69ca06mr5934737a91.24.1779718089765; 
 Mon, 25 May 2026 07:08:09 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:1c00:31c5:adbe:82eb:af87:7a11])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a721c7baasm12700942a91.9.2026.05.25.07.08.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 May 2026 07:08:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] igvm: fix handling of optional variable header types
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
Date: Mon, 25 May 2026 19:37:55 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4ED1F4C8-B56E-4997-99CB-C509629F13C7@redhat.com>
References: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 25 May 2026, at 4:26=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> The IGVM spec defines bit 31 of the variable header type as an
> optional flag: if set, a loader that does not recognize the header
> type may safely skip it. If clear, the loader must reject the file.
>=20
> Currently, all the types with the optional bit set are not
> recognized as valid headers.
>=20
> Implement optional header handling by masking bit 31 before matching
> against the handler table, and skip with a warning any unrecognized
> header that has the optional bit set.
>=20
> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> backends/igvm.c | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index c347d0c17e..408917f826 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -26,6 +26,7 @@
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>=20
> +#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
>=20
> /*
>  * Some directives are specific to particular confidential computing =
platforms.
> @@ -139,8 +140,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t =
type, Error **errp)
>     const uint8_t *header_data;
>     int result;
>=20
> +    /*
> +     * Bit 31 of the variable header type indicates that the header =
is
> +     * optional and can be safely ignored by a loader that does not
> +     * support it. If the bit is clear, the file cannot be loaded.
> +     * =
https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.ht=
ml
> +     */
> +    IgvmVariableHeaderType base_type =3D type & =
~IGVM_VHT_OPTIONAL_BIT;
> +
>     for (handler =3D 0; handler < G_N_ELEMENTS(handlers); handler++) {
> -        if (handlers[handler].type !=3D type) {
> +        if (handlers[handler].type !=3D base_type) {
>             continue;
>         }
>         header_handle =3D igvm_get_header(ctx->file, =
handlers[handler].section,
> @@ -166,6 +175,13 @@ static int qigvm_handler(QIgvm *ctx, uint32_t =
type, Error **errp)
>         igvm_free_buffer(ctx->file, header_handle);
>         return result;
>     }
> +
> +    if (type & IGVM_VHT_OPTIONAL_BIT) {
> +        warn_report("IGVM: Skipping unsupported optional header type =
0x%"
> +                    PRIX32, type);
> +        return 0;
> +    }
> +

I think this check should be at the top of the loop. If the bit is set, =
simply return with that warning message. No further processing is =
needed.


>     error_setg(errp,
>                "IGVM: Unknown header type encountered when processing =
file: "
>                "(type 0x%X)",
> @@ -787,7 +803,8 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>          header_index++) {
>         IgvmVariableHeaderType typ =3D igvm_get_header_type(
>             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
> -        if (typ =3D=3D IGVM_VHT_SUPPORTED_PLATFORM) {
> +        IgvmVariableHeaderType base_type =3D typ & =
~IGVM_VHT_OPTIONAL_BIT;
> +        if (base_type =3D=3D IGVM_VHT_SUPPORTED_PLATFORM) {
>             header_handle =3D igvm_get_header(
>                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, =
header_index);
>             if (header_handle < 0) {
> @@ -947,7 +964,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState =
*machine_state,
>          ctx.current_header_index++) {
>         IgvmVariableHeaderType type =3D igvm_get_header_type(
>             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, =
ctx.current_header_index);
> -        if (!onlyVpContext || (type =3D=3D IGVM_VHT_VP_CONTEXT)) {
> +        IgvmVariableHeaderType base_type =3D type & =
~IGVM_VHT_OPTIONAL_BIT;
> +        if (!onlyVpContext || base_type =3D=3D IGVM_VHT_VP_CONTEXT) {
>             if (qigvm_handler(&ctx, type, errp) < 0) {
>                 goto cleanup_parameters;
>             }
>=20
> ---
> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
> change-id: 20260525-igvm_optional-ca1592b613be
>=20
> Best regards,
> --=20
> Luigi Leonardi <leonardi@redhat.com>
>=20


