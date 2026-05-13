Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF47CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMyzc-0007hz-Pb; Tue, 12 May 2026 22:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyzZ-0007eT-Ty
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:06:34 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMyzR-0007b7-Lo
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:06:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba545100a13so1061744766b.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637984; cv=none;
 d=google.com; s=arc-20240605;
 b=UCmMcFHOuRQxmSIxrL82TYHvBZU6kp+h0z7CxPrhvEqdSXN9nqSoMVIBiFJ0zaZx1p
 hw1iUNN1zb/IG0+qRvvrIzE08vp4XvgSXyWEuhehV0pp7/26nvn1cIwKTNOFSSxmiar0
 cmI1WAeq20mVs4kXbwfcDWiJ9j9unWxfnpgtPFLSrUjPWoVQlm8KlmGgf+hU3qJQqT2E
 P5RVjoHWBGcyPXUqLav4mAC4dV4WCsyaMmpXMGm3IYJflCrucCAEVoDBlbx9esx+6jRb
 FnhZwHFw2G8rua+4OeHTa3VD8i7U8aDKhrlemsVT5ykt55TZr7TLhvYRsqRUfMpp7pjx
 L0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gAX02NUPc0aaBRoouBCKRWGzbNiAE0I8NoZ5OyMCp2k=;
 fh=GJpzZP0+Pf7IJLAkk7GGIc2jeyRGihtCPQbHClgK+cI=;
 b=DpOS0jTArKeRtekWFq6sl85KBcSjrvbUAHsay08OkgczNTCQ6f6fw44yayNc6laYKo
 1UrqNsE/E8mpp0+bW1PenvaHwUexh8h17VtHayMROJRHe4Mltp3PByc1l0NFyQM9vanZ
 PwSPGUTbDMbBdYUdYPB9L77hogxCzhs65fHMX37+IG3w9hZWj8+NUMMZ3YOnoxvV9xfb
 ySlNZoY2y/jBzSK4q3nRWHrER3TIjCtI5iryMDW+VzECKVvDnzTrpZWBaFWa6R1lPj6g
 D3173eXoGELn6EIZIzWxX9QhLO+e+QJaBRIaJuVx4hbCV0LvpkFtUdPd2o81sjRn/+W2
 zpsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778637984; x=1779242784; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAX02NUPc0aaBRoouBCKRWGzbNiAE0I8NoZ5OyMCp2k=;
 b=gQFkQz+gErCl2taXvZGCil8nBoXwKbfmT969+IEj6FT4xmsWrQjlV0RyR1ZCf6gEl1
 SjQdBdI6fF1R2E8tA8FdQG0dOTD6LGn9P+/9R0y9Kbn/LCuZ1alSJoNjxhoP79Pv2TSG
 ko/ODOnzbUOOI3Eb5vtEn3Jaf20uVAvP3baUYP/0twcuoBMMGfI0IQo0svFx/1xPBiL0
 fXLPAnABv4u7GokTkNcL+HFge9GgPVAEXXw4T6KRL49G4bYSiWvVGYzMM6pREM16hl4I
 NN6m0EDTbTfp3ixUpSek/b0iBZr2rrtgq3MNgxBAy/S4TvUZCEiZn2aJLcA9G3iQbjc+
 vyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778637984; x=1779242784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gAX02NUPc0aaBRoouBCKRWGzbNiAE0I8NoZ5OyMCp2k=;
 b=eZYA4AHjosLQESnoHtaCtf4JPfKY924bOJezb4ekPZGCAss/Yzum6O/dq24dI9nsFD
 /XGqVD9F67zVUHIUsdFL74wtj3MkFGZvAV10bIPBstrUx0TYsq0xR+JWLqz/HnhvEz0b
 kgXCLo05dq+oxzAdz2ShKhTRypvsJn40r0uwWCD7Vz9Uqyor4bVXXWUSrXrTk8NQp8fD
 H2uBa1qkDQzSHXSe6OF6YowDOiroGO7z+pAiKrBHmuOgPG9q80orkxflcTuxvBo3hlyu
 5LFHOWDH2qblW3Gj8Ik5pltpnqYYWVuP25S5tG5SkoJQgq6RbyKBLkgmE0B6NYJ4zle0
 4eLQ==
X-Gm-Message-State: AOJu0YypXs4YomW9n2ZvxJ2JUfc/5RtxElZcw1CdinDOygNgdipsk9lO
 v6bnmctYa6jbwW7Qz5eIB4puY8I2ZFDl1auYn35g0ytKIET0ECpyqGbK7lS80puUosaUu1ho93q
 gv0RABFd2Cviym78ZjvaioXRMeqIcJxc=
X-Gm-Gg: Acq92OF+4891D3VYaSpj+2B+Ehw74+Wzbkt5P3enKOmpsZJbpsT33dAIWED5cxKN/0G
 ugzkXOtJweC60snhKiLAtUFxmjGzdHnkP+7B4P2s0oAy1jWZTnH6C7qUJM27x7SwBXhyrPGdEqH
 IWnXpHYgCU1iuOIJnG5ADgOOTQdruAovkLoEGGZ/mzODmkBz+YbebGk2L+6VdimKDrXbYL4dCTL
 wW6VifSRd4rXXOxdr1qwW1+EPS2NCu7W6RKR5PUqQF+dO/LqvVye8s+HOqlRlzFMKQLiN4hLBnR
 nHe7w2+c91BhLxBQh0VE4zduvO6A4OgBOCNo1g==
X-Received: by 2002:a17:906:c104:b0:bd3:23d6:acb7 with SMTP id
 a640c23a62f3a-bd3bf98a9f2mr79501466b.14.1778637983820; Tue, 12 May 2026
 19:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
 <20260510-qom-qapi-v1-46-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-46-48ba6a1a1fa5@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:05:56 +1000
X-Gm-Features: AVHnY4KeaeSvtBUZkrh8dCxzas1uJJr-yXXRaBjCg5yVZzAcm_Du_I1IGTMavHk
Message-ID: <CAKmqyKNrrGQikjbba0Be2uwQgOWFJ-TyW03RC9kjax865YRCPQ@mail.gmail.com>
Subject: Re: [PATCH 46/54] target/riscv: fix incorrect QAPI types and u8
 casting
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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
> "pmu_num" is u8, "pmu_mask" is u32, so is "pmp-granularity"
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7d0cf88d48d..235764462cb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1467,7 +1467,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *=
v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmu_num =3D {
> -    .type =3D "int8",
> +    .type =3D "uint8",
>      .description =3D "pmu-num",
>      .get =3D prop_pmu_num_get,
>      .set =3D prop_pmu_num_set,
> @@ -1503,13 +1503,13 @@ static void prop_pmu_mask_set(Object *obj, Visito=
r *v, const char *name,
>  static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>  {
> -    uint8_t pmu_mask =3D RISCV_CPU(obj)->cfg.pmu_mask;
> +    uint32_t pmu_mask =3D RISCV_CPU(obj)->cfg.pmu_mask;
>
> -    visit_type_uint8(v, name, &pmu_mask, errp);
> +    visit_type_uint32(v, name, &pmu_mask, errp);
>  }
>
>  static const PropertyInfo prop_pmu_mask =3D {
> -    .type =3D "int8",
> +    .type =3D "uint32",
>      .description =3D "pmu-mask",
>      .get =3D prop_pmu_mask_get,
>      .set =3D prop_pmu_mask_set,
> @@ -1651,6 +1651,7 @@ static void prop_pmp_granularity_get(Object *obj, V=
isitor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmp_granularity =3D {
> +    .type =3D "uint32",
>      .description =3D "pmp-granularity",
>      .get =3D prop_pmp_granularity_get,
>      .set =3D prop_pmp_granularity_set,
>
> --
> 2.54.0
>
>

