Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5646CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMz0c-0008Dc-E4; Tue, 12 May 2026 22:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz0a-0008DT-E2
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:07:36 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz0W-0007vD-8a
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:07:34 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bccd251d622so566939966b.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778638050; cv=none;
 d=google.com; s=arc-20240605;
 b=NDtWgVKpGnT8O/ANNif/xrEfnwy2sCzoP6GTg0LbjQ804uk6qMiJ7GMC3JwGYno7XX
 hjhvG5mBvXbyzoH/WlpUjUVVzjdnO2AG9gisZMi045e59qc8smQH/IaCgzBOmhuNbpFu
 Ab43u7II8ZOeqo7ukp0uMD5bh8SrqcFW+thm1sarxa9vmE4ti9oXkqma1unmZ8qFSFmb
 I7geQ9fqoO4lCUClB85PzFlsLhSyglAu6fPKpU8cJjw2NICSLDJBML2wvI4HLzf56z1Z
 hacqZkZZ5gZgk0cxAEl7mBbRp0xgZeO0gBpZ2LKOlsWlxRTNn0XNOBmSqbRsH6GFPVsW
 5YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K8o1mLp0C0lp5dz61Mc/YxHcbbKbVzrwv9lux3SkrCo=;
 fh=GJpzZP0+Pf7IJLAkk7GGIc2jeyRGihtCPQbHClgK+cI=;
 b=UsL5MkW0oUyHUEj8yAd8pqQ8sWfGAuOFjx4/h3dgq1b2DwPVBVaVSq9uEjp9Bp3SPJ
 CLLS2/gJroXksdDnpAhT6JD0KIl0bZTtFQDOyPDwKuDuYwiPPcVnUnzVxCNRmznZzvfb
 YKlZJC/fW9gPOKjEAD44ssMhBRYJV0ijrxeuUXcdcS5avQySEMm4rXCDLJOyhVXG+t/S
 TyUq6NvPtTr8InM0Jv95CCDyOmwxEZfCe0jryQ/eSpJSFNAwl9QR4Ans4TdmDinLZqkJ
 HQfLlz5SG1garShXm9vFdQPbl8Bjl2iMffgh85s+x90a6p4Xj1WUvDtR1VFfdySsjlhv
 oz6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778638050; x=1779242850; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8o1mLp0C0lp5dz61Mc/YxHcbbKbVzrwv9lux3SkrCo=;
 b=Rstmvf/889W2CNzBQx4Q/LSwbfiUWSedmLXjOkW5KhydecQQThAgr1UR1rFrv/uW+4
 tOvdHKepIo/qrCyjwsj0RIEEwsE6c0YXNKoUkxTY619T66Q3wII12MRXV0/4ovSyaOw6
 ymVrhHYOcUNcbnEOR5BIDZXQHnW6+wMhwucGW9/X+064e9pM7Kc8aAyUX9b91xQ1AtA7
 WyunxdKQKvvMO4Vai/f+otJsa3Alo+DqnzsrlILHl2X0UenwMY/c5mlj9DgFULkwZ6bx
 f5n4e343kkAXKEFv3tIkSXy+nmmBcC5fFfFfZxkhfUpwTIeHt6n7TEBOhG19zvwVJyFp
 OUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778638050; x=1779242850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8o1mLp0C0lp5dz61Mc/YxHcbbKbVzrwv9lux3SkrCo=;
 b=gXTSqDQAHFC1AQ9LWWv2q8sa5UdYRZFmFxr70SY9j6u63FPLsDyjOMmfhYBZIohhIq
 +aKc0p4xY2lvG2o5I8DQrxnMfCG0AmLQUDcS1/YUO6YY1xO0YoRPev19wVMpjKsBiudh
 VOQBJFVaOeBiDXYn30Dyx/okeAHUIN0WNpRMJrSClxDJE12CY/4pkO26TrVqsvlIxVBV
 rBljXx2rVDFU07n15HLprahVg5GdMBb6Ii6cuj+wZqb90dWKC64rR9szKf0swRiHf+YC
 s5Enj0/a9KUelJyHGrNrEoQ4SsyyJScSrRZUorck4mCuEZ3ZjaAxY+lwnavBeUX/Q+6g
 mdsw==
X-Gm-Message-State: AOJu0Yxx5KrewMy0H8sxBfG3TB28m0BYUZ9Tk3Ezjw9CoV/zChDodBaZ
 wD7dP1J+I6iMYwdvgmm48ZW5AsUaOIj5eHzx4BrYJhsAiokPXzOpFKvaxPckH7ALWhJk77JcFab
 +tHyujqQw1Y4gsjG3GsGacmDemUJ5TQ2p9Q==
X-Gm-Gg: Acq92OG1v9kBLnJcDF3ZRj5dQ0rxyNr8Lpi1N94pzT0Tb4lE7ucd3lBseaVvS9BIhGN
 hqKj1VOyQD/kgi9MvKy1VkjYlftyqgNI/pWCMmEtC+xGztjHOjRwMGGfqC/++NdqFtkbqeigVxu
 pSKu1eJ400e1vE2apHMsF4Sskm0+n5kI6wVaoBCb+x/69p7Z5xBO6nInr/U3aNmo0MjndOZlLhz
 CBWwaBeDwrc/B0ZZD7Dq8OzMKDBlBKaEM3tgHWfLlkXsUUt0QIZI2zDY6g1IWJUhdb/w70Uhghl
 jgJk0mL63JMFZ48JRjaNpQTIFoq8RaMeDP5FqQ==
X-Received: by 2002:a17:907:f497:b0:bd3:2407:86bd with SMTP id
 a640c23a62f3a-bd3c1403499mr61109866b.33.1778638050399; Tue, 12 May 2026
 19:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <20260510-qom-qapi-v1-47-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-47-48ba6a1a1fa5@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:07:02 +1000
X-Gm-Features: AVHnY4JRLmRNPdIDrsou9ty1w3FjKDD-Kr13DBcTdQStvVP10qJ1Q28UXVO2j7U
Message-ID: <CAKmqyKOFhLhCtZG66-RS1NPuqMF5=icgRW80VwFNVkGyKP1ZVw@mail.gmail.com>
Subject: Re: [PATCH 47/54] target/riscv: convert PropertyInfo definitions to
 use qapi_type
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 10, 2026 at 11:53=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Mechanical conversion of all local PropertyInfo definitions in
> target/riscv/cpu.c
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 235764462cb..bd01884fb30 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1467,7 +1467,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *=
v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmu_num =3D {
> -    .type =3D "uint8",
> +    .qapi_type =3D &uint8_type_info,
>      .description =3D "pmu-num",
>      .get =3D prop_pmu_num_get,
>      .set =3D prop_pmu_num_set,
> @@ -1509,7 +1509,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor =
*v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmu_mask =3D {
> -    .type =3D "uint32",
> +    .qapi_type =3D &uint32_type_info,
>      .description =3D "pmu-mask",
>      .get =3D prop_pmu_mask_get,
>      .set =3D prop_pmu_mask_set,
> @@ -1541,7 +1541,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, c=
onst char *name,
>  }
>
>  static const PropertyInfo prop_mmu =3D {
> -    .type =3D "bool",
> +    .qapi_type =3D &bool_type_info,
>      .description =3D "mmu",
>      .get =3D prop_mmu_get,
>      .set =3D prop_mmu_set,
> @@ -1573,7 +1573,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, c=
onst char *name,
>  }
>
>  static const PropertyInfo prop_pmp =3D {
> -    .type =3D "bool",
> +    .qapi_type =3D &bool_type_info,
>      .description =3D "pmp",
>      .get =3D prop_pmp_get,
>      .set =3D prop_pmp_set,
> @@ -1613,7 +1613,7 @@ static void prop_num_pmp_regions_get(Object *obj, V=
isitor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_num_pmp_regions =3D {
> -    .type =3D "uint8",
> +    .qapi_type =3D &uint8_type_info,
>      .description =3D "num-pmp-regions",
>      .get =3D prop_num_pmp_regions_get,
>      .set =3D prop_num_pmp_regions_set,
> @@ -1651,7 +1651,7 @@ static void prop_pmp_granularity_get(Object *obj, V=
isitor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmp_granularity =3D {
> -    .type =3D "uint32",
> +    .qapi_type =3D &uint32_type_info,
>      .description =3D "pmp-granularity",
>      .get =3D prop_pmp_granularity_get,
>      .set =3D prop_pmp_granularity_set,
> @@ -1726,7 +1726,7 @@ static void prop_priv_spec_get(Object *obj, Visitor=
 *v, const char *name,
>  }
>
>  static const PropertyInfo prop_priv_spec =3D {
> -    .type =3D "str",
> +    .qapi_type =3D &str_type_info,
>      .description =3D "priv_spec",
>      /* FIXME enum? */
>      .get =3D prop_priv_spec_get,
> @@ -1759,7 +1759,7 @@ static void prop_vext_spec_get(Object *obj, Visitor=
 *v, const char *name,
>  }
>
>  static const PropertyInfo prop_vext_spec =3D {
> -    .type =3D "str",
> +    .qapi_type =3D &str_type_info,
>      .description =3D "vext_spec",
>      /* FIXME enum? */
>      .get =3D prop_vext_spec_get,
> @@ -1802,7 +1802,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, =
const char *name,
>  }
>
>  static const PropertyInfo prop_vlen =3D {
> -    .type =3D "uint16",
> +    .qapi_type =3D &uint16_type_info,
>      .description =3D "vlen",
>      .get =3D prop_vlen_get,
>      .set =3D prop_vlen_set,
> @@ -1843,7 +1843,7 @@ static void prop_elen_get(Object *obj, Visitor *v, =
const char *name,
>  }
>
>  static const PropertyInfo prop_elen =3D {
> -    .type =3D "uint16",
> +    .qapi_type =3D &uint16_type_info,
>      .description =3D "elen",
>      .get =3D prop_elen_get,
>      .set =3D prop_elen_set,
> @@ -1879,7 +1879,7 @@ static void prop_cbom_blksize_get(Object *obj, Visi=
tor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_cbom_blksize =3D {
> -    .type =3D "uint16",
> +    .qapi_type =3D &uint16_type_info,
>      .description =3D "cbom_blocksize",
>      .get =3D prop_cbom_blksize_get,
>      .set =3D prop_cbom_blksize_set,
> @@ -1915,7 +1915,7 @@ static void prop_cbop_blksize_get(Object *obj, Visi=
tor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_cbop_blksize =3D {
> -    .type =3D "uint16",
> +    .qapi_type =3D &uint16_type_info,
>      .description =3D "cbop_blocksize",
>      .get =3D prop_cbop_blksize_get,
>      .set =3D prop_cbop_blksize_set,
> @@ -1951,7 +1951,7 @@ static void prop_cboz_blksize_get(Object *obj, Visi=
tor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_cboz_blksize =3D {
> -    .type =3D "uint16",
> +    .qapi_type =3D &uint16_type_info,
>      .description =3D "cboz_blocksize",
>      .get =3D prop_cboz_blksize_get,
>      .set =3D prop_cboz_blksize_set,
> @@ -1987,7 +1987,7 @@ static void prop_mvendorid_get(Object *obj, Visitor=
 *v, const char *name,
>  }
>
>  static const PropertyInfo prop_mvendorid =3D {
> -    .type =3D "uint32",
> +    .qapi_type =3D &uint32_type_info,
>      .description =3D "mvendorid",
>      .get =3D prop_mvendorid_get,
>      .set =3D prop_mvendorid_set,
> @@ -2023,7 +2023,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v=
, const char *name,
>  }
>
>  static const PropertyInfo prop_mimpid =3D {
> -    .type =3D "uint64",
> +    .qapi_type =3D &uint64_type_info,
>      .description =3D "mimpid",
>      .get =3D prop_mimpid_get,
>      .set =3D prop_mimpid_set,
> @@ -2080,7 +2080,7 @@ static void prop_marchid_get(Object *obj, Visitor *=
v, const char *name,
>  }
>
>  static const PropertyInfo prop_marchid =3D {
> -    .type =3D "uint64",
> +    .qapi_type =3D &uint64_type_info,
>      .description =3D "marchid",
>      .get =3D prop_marchid_get,
>      .set =3D prop_marchid_set,
>
> --
> 2.54.0
>
>

