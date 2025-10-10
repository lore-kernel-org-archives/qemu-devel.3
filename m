Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94091CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EfC-0004r6-Hy; Fri, 10 Oct 2025 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7EfB-0004qj-2M
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:04:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7Eev-0002mS-BW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:04:06 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-634a3327ff7so4394292a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760108627; x=1760713427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jE3/A1A6rbTabepj/157O0KCLJ3XQ2GMimeBliGbCgM=;
 b=xwq/Swkcy7LqjyE3c65qwgbKIqnJjhEdGXfceYrknSLLzd9UBkFK9HNZrW+nxMqp4X
 2X0mGhnf5d1sZs0rJ3n1ruQHNZ4vVFDr+0XznfXKZJPtgjc68UZ10t482VcGmo6UNjRc
 LVUTE+cJjU0Cds6J24/3b9viV5zdyLL84HE4/oSOQBE48VMS9MLKICs1dzPjb3RedIRX
 eYEdUohpDLCg76XP+ZKyZFRLbhjQ6DfZGTVN6uvgf1i8mJHUgX6TBEBxcUI5Jyn35Jsl
 GJYss54mOTfkQ9wyZ4nVm2JY69DDKP/CukB6851O+UxfI9NnbPAlpS5ylu2rrMYzsMii
 PVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760108627; x=1760713427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jE3/A1A6rbTabepj/157O0KCLJ3XQ2GMimeBliGbCgM=;
 b=TC3nEI5aZho9/LEejGNxUOPRM4S4rRfP+ERUui+upaHIerVQGcuUHj5d1nuhICMHZz
 7Nve7+edlmAqOg1RTVPjHjY6xx7rMI7jqOps9VMYRkMsidtSLkBzNEsXHnDpwodI46kJ
 Jp0MISqE4iveQsBT3+h8AvmRG2hJTL5SUy51yVq7G2Ot2PpSYYd8ETVSuRRzKRpO0QjB
 WFuDkb4z4Oy/H9o5If0+ix3YDLu8U1woIAgN/GCBWBTKoXD4xcZyH3wmYOyjiiHS81FY
 v7ainbN9qpNrsn3BJBgBWVm9YX5p22ha0AIX7eoO+T65A9hUPK+7A7O6VYPksBsbe9Sg
 ruLQ==
X-Gm-Message-State: AOJu0YzM5NwgsBYEwrns+21jABRIdh0AjeoXXAvq28yLaI76GxQ51Twc
 DpmnwWiECYfVSfYHzu93WrZ9vEea8Lt1/1mlCsZtXa2wsserpHKV1DHKz9F2x3i4ryoiCnZ/wIq
 Vq1SnD0pRuccyCZTLXqhm4GH5ews3g+jxPDsqzQUhMQ==
X-Gm-Gg: ASbGncvuRP8jLgz4kUYO0w9ZMmqqTq9Nz8A1HulP4d16fRzTWArfSx72lBK7KkVxFuZ
 shOqm3r5oMTcs61wrc0mDGLUkRHgy4Xb0g7jnIazkBKA8RlJjBRk9SFI+FJCllztQzCZ8wQ8q0E
 r4ajRBP8JEEvj105G5c23RBbH5bnaz7LoFtH5MRL8bDG6IeYgxFSbbJTp6TimxcHMTTMP5cv8O+
 yX/UhA2o4sx9nug1BADoWO7AQhBEneDTIdNGw==
X-Google-Smtp-Source: AGHT+IFw6rVlti2LgqCA3UqHN10MgPcEDEqo3WGiN+JibXd1c7f4eoVkes3jD/9BrfQXTk8SkDf/lQxLzkiIasTVjk0=
X-Received: by 2002:a05:6402:254a:b0:627:f3b4:c01a with SMTP id
 4fb4d7f45d1cf-639d5c3eda9mr10835952a12.17.1760108625632; Fri, 10 Oct 2025
 08:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251010145756.787800-1-pbonzini@redhat.com>
In-Reply-To: <20251010145756.787800-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Oct 2025 18:03:19 +0300
X-Gm-Features: AS18NWA23RdTBLjMt6PY6pIXzULJDqnriIptZ5Zx2m05pDYUkss91gMQTOfEse0
Message-ID: <CAAjaMXaLwRCds-e1=dQr-nHMRjZriw6-PC_MgJMUL8pup26V-A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bits: disable double_parens check
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, Oct 10, 2025 at 5:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> It is showing in the output of the bits! macro when using the nightly
> toolchain, though it's not clear if it is intentional or a bug.
> Shut it up for now.
>
> Link: https://github.com/rust-lang/rust-clippy/issues/15852
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  rust/qemu-macros/src/lib.rs | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> index 3e21b67b471..9157f77a4dd 100644
> --- a/rust/qemu-macros/src/lib.rs
> +++ b/rust/qemu-macros/src/lib.rs
> @@ -401,7 +401,14 @@ pub fn bits_const_internal(ts: TokenStream) -> Token=
Stream {
>      let ts =3D proc_macro2::TokenStream::from(ts);
>      let mut it =3D ts.into_iter();
>
> -    BitsConstInternal::parse(&mut it)
> -        .unwrap_or_else(syn::Error::into_compile_error)
> -        .into()
> +    let out =3D BitsConstInternal::parse(&mut it)
> +        .unwrap_or_else(syn::Error::into_compile_error);
> +
> +    // https://github.com/rust-lang/rust-clippy/issues/15852
> +    quote! {
> +        {
> +            #[allow(clippy::double_parens)]
> +            #out
> +        }
> +    }.into()
>  }
> --
> 2.51.0
>

