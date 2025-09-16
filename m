Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B496CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySUe-0003sE-CQ; Tue, 16 Sep 2025 06:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySUR-0003pZ-Cl
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:00:49 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySUL-0007Hb-Uv
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:00:45 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b042cc39551so872023366b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758016839; x=1758621639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVls5VU3JEjGQ+uodD9dv4bGeKWVlOnJf9GTnykaWZM=;
 b=KclI4BsB66tCQsvGXjZ4c2SOU7xWFYpcZvnGFJkSH859eK6LaoZBPq0xN/4ZdR2Deq
 XasMe7VExtaZwZP3OsqdBIT2nOlHXKMnIzLxlk9zv2FyrIz5/lAZdCVNIhuVUiqLQxkQ
 o1t89s97Ah3OwehCa3Ny3WclaP7+o/V/30Yton3HLoJGcakSmOF9nruXB1kJy2ct9jhY
 coG0DM5+N7bzuv8P9tOmcEqgDYThcIN0oEEpMLF3b41lJOZMIZR9e/pi2ZBG87INJEX3
 LyFqsfbfZhQE15wEJAJRGDy5ZfV9mqxUglrsmlRBkSRo8lFLmFmhjCy6EozNH8f3Hs+O
 DMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758016839; x=1758621639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVls5VU3JEjGQ+uodD9dv4bGeKWVlOnJf9GTnykaWZM=;
 b=BLMLdSsSFe7JsSzQPE89DygMnGwBbqaeyu4tej7cHq33Q8caBaWKCMTEsDuEaB+eZf
 tHK1wOKbDAXs/VHi64AF1dVfSX0Xeh+BBnwlTlNdWBNeVdQDAQy8L5z6m4r7uqBr+i4s
 kIDPqsTib2Y1zrmU16t8/caVhp2GziLMwEWlIzTpOAdLtLQz29av4OCdUdUXR1b07/Fv
 +t6vVf21A0rY/IgPGdJQjexO2hgpP8D6BHW4asi/sXGdSmtE/0FFjK9swi63X0XCh3/H
 /ogNzu6GUiXDp3RtXw1h+Suc15DI4TIqtlzCpUeToMD31B+k17P7G7d8pL2D/JY5ugmY
 0Atg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkjWm61bAJcbPRVlKjWdW7e86D3Cukb+MmhbyshPHPyLXze+exdzVkNRrqeOhm4i771gyBASoShkrc@nongnu.org
X-Gm-Message-State: AOJu0YwcOKhyerDXQhPow5dcWSUShpu3mkC+gmDYOsJPyU/l8R4XfEHu
 iweyFKaR2c7gemGXvIydWkO+uOo+fg1U9lGpziWgCa2WoHH208yM+kXCZKPQkV1PQZyNX1V19WE
 pMOWj1n23fRgN43PtUc5El0idx4CySBfQ2TZa0d5bTg==
X-Gm-Gg: ASbGncsjU94+0VpOS9e6sYctVOdgqqfz9Tcpv/8us1QLxJmsHgforZaMC8j7lV7Wj/v
 rWsRYbcDVHyCB9WJxH9vhZ+jvHArWjANpNrGNkpSEiZs22m1l5rb2GJrutspL9DlrpiMnVaf8bq
 9KH4Hy470uunWFpnDzxEzdgnk2nDPyNgvBlZHTBR0fiZzuBjUrvUWdCFvO2JEe7jRGVcYX4swwS
 N03zytlHr5RHg9jlcw=
X-Google-Smtp-Source: AGHT+IF6+aT70m+Rgv3kzi92PNuzebLr37fgQ+Z/3IN4loNvBdmXmGzo3aA+x/qK1dCLNh+GAlP7+EwzPS4ebf+nZ10=
X-Received: by 2002:a17:906:ef07:b0:b07:b645:e5b8 with SMTP id
 a640c23a62f3a-b07c37de7d8mr1586149666b.30.1758016838892; Tue, 16 Sep 2025
 03:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-4-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-4-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 13:00:11 +0300
X-Gm-Features: AS18NWAEiqBTk3kGzK2OpWSWx3KG8AReMftuRm9Z-6XM-QJa3f1jqaPYFsHapgc
Message-ID: <CAAjaMXZPPaAsEae6PbsVdqFYszb5ra3SWoZD56sj-ueSg=0iVA@mail.gmail.com>
Subject: Re: [PATCH 03/12] rust/qemu-macros: Fix Clippy's complaints about
 lambda parameter naming
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, Sep 16, 2025 at 11:34=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> error: `rename` shadows a previous, unrelated binding
>    --> qemu-macros/src/lib.rs:265:14
>     |
> 265 |             |rename| -> Result<proc_macro2::TokenStream, Error> {
>     |              ^^^^^^
>     |
> note: previous binding is here
>    --> qemu-macros/src/lib.rs:245:30
>     |
> 245 |         let DeviceProperty { rename, defval } =3D prop;
>     |                              ^^^^^^
>     =3D help: for further information visit https://rust-lang.github.io/r=
ust-clippy/master/index.html#shadow_unrelated
>     =3D note: requested on the command line with `-D clippy::shadow-unrel=
ated`
>
> Rename the lambda parameter to "prop_rename" to fix the above clippy
> error.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/qemu-macros/src/lib.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> index 830b4326985b..ed4064d6e110 100644
> --- a/rust/qemu-macros/src/lib.rs
> +++ b/rust/qemu-macros/src/lib.rs
> @@ -262,8 +262,8 @@ macro_rules! str_to_c_str {
>
>          let prop_name =3D rename.map_or_else(
>              || str_to_c_str!(field_name.to_string(), field_name.span()),
> -            |rename| -> Result<proc_macro2::TokenStream, Error> {
> -                match rename {
> +            |prop_rename| -> Result<proc_macro2::TokenStream, Error> {
> +                match prop_rename {
>                      DevicePropertyName::CStr(cstr_lit) =3D> Ok(quote! { =
#cstr_lit }),
>                      DevicePropertyName::Str(str_lit) =3D> {
>                          str_to_c_str!(str_lit.value(), str_lit.span())
> --
> 2.34.1
>

