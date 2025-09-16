Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABAACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySeX-0006ee-22; Tue, 16 Sep 2025 06:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySeW-0006eH-7P
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:11:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySeT-00083E-6y
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:11:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso619188466b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758017466; x=1758622266; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVPY7uekT7ttZ1PK4mcFTnDMT/Mh7ZY2HqvheGzOtU4=;
 b=oEwrjq+GNIMYKcnvEq4OiJouhRvKtxI5REW1dK29oJjYFYdtPtgS+3oFhBT4IBXREW
 4liBa2CsN+H2zGs78OdAhKVJhxjK/6KuAPUpOTnuMODcHN7LHWFocCZiNdpDUf+EW5HM
 K5AQcTbSBLeVxJ5k1qhizETo2KG2P+Fi9m+Ml4fwL+kX5kCnVeDCUWWV4ZNngv+9UasF
 TNu2nU0ZapnzgES21jC25eDg35uMpspOZcdcXoFI7/ccWUzzPTtW9T1IpEFwWm2Ozkq0
 1aj01Cx1wTIDupnu1MhUGwsdZAM93aPkThRUFRtnh7HX5ltyKjqyTGyjytE63oj9r9aD
 AItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758017466; x=1758622266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVPY7uekT7ttZ1PK4mcFTnDMT/Mh7ZY2HqvheGzOtU4=;
 b=jSgGH5KpWQkzOUPyYcyD5WEhMdIjcY4LnYWRXWC/G8nZgssNXlWrFW+VpMePyZxMFB
 G+kmnHW5o2BBynLfbdabvoIspttEC06UlbDsTFzNMJe7Dr6Y5feOrJqqv4hjug9MP5nN
 dPCFlae7OvrTh4k9TSdaOXlgSN6xp94JKUbO9kngbdqnn/2FsMLKI25duE2aFcZfdAHC
 aKPprRYaqJT2opJDNxBKksjfwOF18T4Ju/zby5dzyskpaYbZ4bwwCbA5KLL4akTdWvPk
 Ip8bqoKHnqlxtCdzvpsNbQmDfAfXn54jMfJeueqe2OKU3chr3AxKnvUn3RYnH+OXiCdY
 YRsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDFRHfWLRE9Jey8D2w9lH4jkkQaC2jUsPfvI8MQrixC/NCFQL/g2LHlR9KaenLVSlBsfCMxsVsJ3EP@nongnu.org
X-Gm-Message-State: AOJu0YxjWndI3qVFOFm6gKJxyhpOh2pCUHnptRqV9TBD1sOwvWnndRLk
 H2fZIknudjI57zaG9ZSkFLUjK8f7RyZbr/LDM58st2Y37nYb0uQlSvTa0CVGfwh2A5mCOkUsNnG
 exMQ5MDZBosTgNThYIdU8WPvBmuPkpwglqX+m0A1WTg==
X-Gm-Gg: ASbGnctIKM6OXgj5t2V8HvBHOkj87aUtZvRaGnCUtXIdORAQhDYOcVxlDztTCT8kBM7
 B6jrk+EpZxITSg3IlxKn3it7FR/3STwgqbDtIoO/49i2BNVj0l+Z4GhGe2n2NFzuDsDr52UlODP
 rcVnSe53xQO7F+W8GDnnYO2/28Ruyi9gJDlCZxWKBY0295sAvoqpQb3DJ0fcFnp4j/xr0+Xa7QZ
 +KJWow2
X-Google-Smtp-Source: AGHT+IFxk4/rK/TiR6ty6xI1vTGob9miOCjR+xMMXdwKQVDJGYcntW9P8Es7y71I7RR8gtommKGFKEOW3QXYCYKkTaU=
X-Received: by 2002:a17:906:6a02:b0:b07:6538:4dc5 with SMTP id
 a640c23a62f3a-b07c37b82a8mr1460077566b.64.1758017465584; Tue, 16 Sep 2025
 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-8-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-8-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 13:10:39 +0300
X-Gm-Features: AS18NWBESi6M1krANzHKZch9WuTciZPFirSuXRS8OnET6hs1MHWxFDwBr3ZDA8I
Message-ID: <CAAjaMXYSDGCr4H_Pk8gOHn6NbsOp0+q==V7GgdtR_60tT4FCPw@mail.gmail.com>
Subject: Re: [PATCH 07/12] rust/qdev: Rename PropertyInfo field from VALUE to
 BASE_INFO
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 16, 2025 at 11:34=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> Bit property info will added next. To distinguish different info fields,
> rename `VALUE` to `BASE_INFO`, then it can better reflect that it
> represents the basic property info.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

You can squash this patch to the bit info one

>  rust/hw/core/src/qdev.rs    | 12 ++++++------
>  rust/qemu-macros/src/lib.rs |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index 2735e2b2c109..d887046d8de1 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -109,13 +109,13 @@ pub trait ResettablePhasesImpl {
>  ///
>  /// # Safety
>  ///
> -/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
> +/// This trait is marked as `unsafe` because `BASE_INFO` must be a valid=
 raw
>  /// reference to a [`bindings::PropertyInfo`].
>  ///
>  /// Note we could not use a regular reference:
>  ///
>  /// ```text
> -/// const VALUE: &bindings::PropertyInfo =3D ...
> +/// const BASE_INFO: &bindings::PropertyInfo =3D ...
>  /// ```
>  ///
>  /// because this results in the following compiler error:
> @@ -131,22 +131,22 @@ pub trait ResettablePhasesImpl {
>  /// It is the implementer's responsibility to provide a valid
>  /// [`bindings::PropertyInfo`] pointer for the trait implementation to b=
e safe.
>  pub unsafe trait QDevProp {
> -    const VALUE: *const bindings::PropertyInfo;
> +    const BASE_INFO: *const bindings::PropertyInfo;
>  }
>
>  /// Use [`bindings::qdev_prop_bool`] for `bool`.
>  unsafe impl QDevProp for bool {
> -    const VALUE: *const bindings::PropertyInfo =3D addr_of!(bindings::qd=
ev_prop_bool);
> +    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_bool);
>  }
>
>  /// Use [`bindings::qdev_prop_uint64`] for `u64`.
>  unsafe impl QDevProp for u64 {
> -    const VALUE: *const bindings::PropertyInfo =3D addr_of!(bindings::qd=
ev_prop_uint64);
> +    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_uint64);
>  }
>
>  /// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
>  unsafe impl QDevProp for chardev::CharBackend {
> -    const VALUE: *const bindings::PropertyInfo =3D addr_of!(bindings::qd=
ev_prop_chr);
> +    const BASE_INFO: *const bindings::PropertyInfo =3D addr_of!(bindings=
::qdev_prop_chr);
>  }
>
>  /// Trait to define device properties.
> diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> index ed4064d6e110..b43ca31bae30 100644
> --- a/rust/qemu-macros/src/lib.rs
> +++ b/rust/qemu-macros/src/lib.rs
> @@ -272,7 +272,7 @@ macro_rules! str_to_c_str {
>              },
>          )?;
>          let field_ty =3D field.ty.clone();
> -        let qdev_prop =3D quote! { <#field_ty as ::hwcore::QDevProp>::VA=
LUE };
> +        let qdev_prop =3D quote! { <#field_ty as ::hwcore::QDevProp>::BA=
SE_INFO };
>          let set_default =3D defval.is_some();
>          let defval =3D defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }=
));
>          properties_expanded.push(quote! {
> --
> 2.34.1
>

