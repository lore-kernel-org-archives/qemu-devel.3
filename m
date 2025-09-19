Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A3CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYYB-0004Wn-TG; Fri, 19 Sep 2025 06:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYY8-0004W0-AS
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:41:08 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYY3-0002Ri-Ev
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:41:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b2400dcc55eso183548766b.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758278456; x=1758883256; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aEt007MFCxdsNdLlFX2BT1JYIAZLIIaNocOP/kZ5RY=;
 b=FnKC+daUHFJELTID50ixGyyTVkI7km/twjE9KU5z4GsusBMZXaJUDhMzA9bmGK5Zwn
 RHEMwwirmcOxfVn9PFPV/XcIgw+NXDEk6+2izjuoxEtCf/srEwqczUfeH1xUZj2w6QFr
 D8oSHIimzf68cpZnP+1uVjnq2vnRftSnSpemVxmfJI6FWC8E6S96FSq1u6xI5s0LBJ7f
 YdiTlhrbUAHu+2mJOCwYwl0bnLvtmLCbQqGUeeUHqDn++azXIzn27LsYS0Eigbfna75U
 iFnPQfpVZ+Lkt7jKiK+i0DAopSd8iypIjQMMs4raU4GLYbjbZhd1I6FE+zcSxFrpLXzt
 Hj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758278456; x=1758883256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7aEt007MFCxdsNdLlFX2BT1JYIAZLIIaNocOP/kZ5RY=;
 b=oKw+PQvjso9mwGD+ejkrFvi94rCm3q08f4RFCqCy/KetuNElYRb+nyBnIvsn2E92+e
 3RvaU86n/Ox4LQXtQFujWODTYI/ZN+qFR5WS9d/36MbxPp0CymXkMqzwhl8bQurDwSvg
 LNSz/49vzn8Sp42wfhiA4MjQqwpZHZYCUBkVtPPVyOUV2jv2gr9zkp/XBccPInKSwtAW
 ihIYae2dW2jVknv6CDr9TscLkIChVDpoda5yxIoq5CISOUKj81sQ1l8gNVDtegzK2QaU
 tRviQjOCWUoEK6Ej019+qVwL1XlPm5pdBG2CaF0WeFBXB6YLQH1ShGqx/ASgmVblqgGe
 ejHA==
X-Gm-Message-State: AOJu0YxlPWmzVD0r8Vnhk8TT+91oyxVc3v6kajegnX3umsHnrSl373nb
 NJfyRQ6gXWKhEJWla9biwxAK3R3bIWsYpFJ6JCAtaaX7rmJv8J2IV3KPg7CB9uU1Ogr8Jd1WyvG
 0iV1JaODUY+zUToAeW+wZIPbfYGnzTYSiGVhlaNuLYA==
X-Gm-Gg: ASbGnctqCaVEAlbaMeIGHVwryB3j7K6l/0X4XFF+KB0Og6tu3vh7Z3CRWUBHnG4o0ph
 KufLCY+fw3xAha+3KhfuzScwSTX9bHGj62ZMWkmG5fh/VGpsgJt2qWhgIxSgGD4HjIoHhphkkLB
 C8ywjNqFNPdpnYu3d/YDtPE/cM20bwA4hDdH1OFYKLVb1QT2CYfYFo0z2ZOeLuhkZLoXA+RtOnF
 49hqw==
X-Google-Smtp-Source: AGHT+IH6HhMfUUQ3xDfUbNKCOK7AKy/PEA3hxI9gmklDLQImpAI7pgGg8W4VpKno0WyulAatKZZ1/94AKGpXLmWsQ2U=
X-Received: by 2002:a17:906:c155:b0:b07:dbf9:a2a2 with SMTP id
 a640c23a62f3a-b24ef5853camr293852266b.20.1758278456533; Fri, 19 Sep 2025
 03:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250919101642.121190-1-pbonzini@redhat.com>
In-Reply-To: <20250919101642.121190-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 19 Sep 2025 13:40:30 +0300
X-Gm-Features: AS18NWByc9Lx3Fseivfzm8Z1dLQWk0O-QDlIPo1S6BP_7zbIBfRbqvZb6ww9oFM
Message-ID: <CAAjaMXbk-sr4MAejAb8vkz_Yd1u+=k3cfnCWzeOvdWigHPiu0A@mail.gmail.com>
Subject: Re: [PATCH] rust: build: remove "protocol: rust: from doctests
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 1:17=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> It is added already by rust.doctest.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/bql/meson.build       | 1 -
>  rust/common/meson.build    | 1 -
>  rust/migration/meson.build | 1 -
>  rust/qom/meson.build       | 1 -
>  rust/util/meson.build      | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/rust/bql/meson.build b/rust/bql/meson.build
> index 2e0d8a88ed3..305d7111897 100644
> --- a/rust/bql/meson.build
> +++ b/rust/bql/meson.build
> @@ -46,6 +46,5 @@ bql_rs =3D declare_dependency(link_with: [_bql_rs],
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
>  rust.doctest('rust-bql-rs-doctests',
>       _bql_rs,
> -     protocol: 'rust',
>       dependencies: bql_rs,
>       suite: ['doc', 'rust'])
> diff --git a/rust/common/meson.build b/rust/common/meson.build
> index 7fcfa87d362..89dc11b594c 100644
> --- a/rust/common/meson.build
> +++ b/rust/common/meson.build
> @@ -34,6 +34,5 @@ rust.test('rust-common-tests', _common_rs,
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
>  rust.doctest('rust-common-doctests',
>       _common_rs,
> -     protocol: 'rust',
>       dependencies: common_rs,
>       suite: ['doc', 'rust'])
> diff --git a/rust/migration/meson.build b/rust/migration/meson.build
> index 26e4c98bcf7..3843b364c69 100644
> --- a/rust/migration/meson.build
> +++ b/rust/migration/meson.build
> @@ -49,6 +49,5 @@ migration_rs =3D declare_dependency(link_with: [_migrat=
ion_rs],
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
>  rust.doctest('rust-migration-rs-doctests',
>       _migration_rs,
> -     protocol: 'rust',
>       dependencies: migration_rs,
>       suite: ['doc', 'rust'])
> diff --git a/rust/qom/meson.build b/rust/qom/meson.build
> index 3b60d2be0bd..d7622a9e0b1 100644
> --- a/rust/qom/meson.build
> +++ b/rust/qom/meson.build
> @@ -38,6 +38,5 @@ qom_rs =3D declare_dependency(link_with: [_qom_rs], dep=
endencies: [qemu_macros, qo
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
>  rust.doctest('rust-qom-rs-doctests',
>       _qom_rs,
> -     protocol: 'rust',
>       dependencies: qom_rs,
>       suite: ['doc', 'rust'])
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index ba6213bf3b8..eb101495870 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -60,7 +60,6 @@ rust.test('rust-util-tests', _util_rs,
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
>  rust.doctest('rust-util-rs-doctests',
>       _util_rs,
> -     protocol: 'rust',
>       dependencies: util_rs,
>       suite: ['doc', 'rust']
>  )
> --
> 2.51.0
>
>

