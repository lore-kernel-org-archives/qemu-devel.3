Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34481CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySV4-0004aP-Ec; Tue, 16 Sep 2025 06:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySUo-0004Bu-PK
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:01:12 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySUm-0007JC-Ds
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:01:10 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b042cc39551so872111666b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758016866; x=1758621666; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9zZhr/cBmyMqoJPq7F1A7QHp7oKqo/gSSYmV5LJALY=;
 b=RReqVUIilwEjqFXx5/M6oVIgllHNmQ6GiszB4m4ot5ZYmZBW1ZTPNhBn7QU4iAarSh
 aUAYLOOlavPrfmivJ1AwiYRCC7oidjL7lNVaY8pxvSjTvPYkDILjmG9MFndpvzi3EcBR
 Q3oz8bzARTSnR5DnoTaDrq8c/OneuUrUr6XRK/UZ1Ev8UCPp6Jg8jLC/sqiLlUqQatLS
 u1NA6K+Obvp527PGwy9Bqs6IOHL7onL20Og0uPRsKtBYsgwmQ+AJTzjzMU6D+Mr2DdNk
 1F4q9iqvZDR0RqLQ6hrZNv/eIb170aJb4SiicIxhMiJDKHzt2/M8ijvBKaXMfq3GexLV
 U40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758016866; x=1758621666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9zZhr/cBmyMqoJPq7F1A7QHp7oKqo/gSSYmV5LJALY=;
 b=HzY526KCamcStuSTFwGXXjKad1zj+/4zJoLoJ6A2R4zqcRDR4+zvCITKH5/2JBOXKJ
 4TZHsbNHM3X7NUILWCjD1jhkaCJ0do4w71H9fgGvFJds5/ydv6nkMvObG4Ot5MloOsw2
 Q74N1bAVYpfFvt5C1LjB9RLcUAMAXDQup3sRgEGOoIwgYkcGRMdMhqAw7qs7tEM3PLXs
 OZJ+FUs4k+zbki4haVvgQUi5cOkFez3Yd0AkFh+eKPKlLrSZIqCzlM4KM2P5l6UgDZG9
 4OP6sh8vafhcpIMo/zQmjkcgLD5pkkejojLq7jmbxdr8C3BsBWc5OGjrVDoN7Qg2WfDb
 O7pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN33n63io3BkanUmB1yr6pUIFS7tHyMozBtFM67/B3tzsG50lV4ZuQ0AJtIAsYHZv25RWYPjohQMJh@nongnu.org
X-Gm-Message-State: AOJu0YxHf+fvJWkYrbdRs5fxbBhBvL4EXXmfB6d2e6iPTgR3i4XEOeJC
 aF4KVwr/w+VaNSwu5btn5wZnQB4eSj+7GV25tetan2MqTQyNIf/oacUWofuuEw8stuVS5eMQnc4
 UebPybr1aaXj6tfjWyU9WzZRQepsE2EjD3P6hD3MZgg==
X-Gm-Gg: ASbGncuQn7A6kgyJVeobppGksCXAZWBnKKqAZ6/Ct6D/oHjjvmTL2FJHP/M1jdRZClp
 3ssSQI5k9ebXkdotWdDMqiX1pPhrJpu9r9BLFd9+7Id0N+tRNKCS6NYxevvTJLEwgujzP//fv7N
 NjGw9IHqc73ab1TZR9+023FZmvHyBAy0pjN3C0UZc1yKsNI8A7qgcKQakSzoFNjy2B+WtkOz3cZ
 XdDTRsP
X-Google-Smtp-Source: AGHT+IHkPEzX0/RZnpQXSEc9IHspHnI6c6iALVGIJaBF8g+MbvJFIxX0lX1yl0smkMZC31YwB5gkSUkWW1wDBxduqko=
X-Received: by 2002:a17:906:f5a2:b0:b04:65b4:707 with SMTP id
 a640c23a62f3a-b07c353eb4fmr1505717666b.13.1758016866360; Tue, 16 Sep 2025
 03:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-5-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-5-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 13:00:40 +0300
X-Gm-Features: AS18NWClx_pMNMtGfdG_SrJnW0bv4lgs4QhyDFJd5TKRS4EIxYgUGvCtHktg87o
Message-ID: <CAAjaMXYc_1naU04HvEHqLF0T9cAjZ16gCdGro_kNTpe2gnsr-g@mail.gmail.com>
Subject: Re: [PATCH 04/12] rust/common/uninit: Fix Clippy's complaints about
 lifetime
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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
> Clippy complains about the following cases and following its suggestion
> to fix these warnings.
>
> warning: the following explicit lifetimes could be elided: 'a
>   --> common/src/uninit.rs:38:6
>    |
> 38 | impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
>    |      ^^                                   ^^
>    |
>    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/master/index.html#needless_lifetimes
>    =3D note: `#[warn(clippy::needless_lifetimes)]` on by default
> help: elide the lifetimes
>    |
> 38 - impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
> 38 + impl<T, U> Deref for MaybeUninitField<'_, T, U> {
>    |
>
> warning: the following explicit lifetimes could be elided: 'a
>   --> common/src/uninit.rs:49:6
>    |
> 49 | impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
>    |      ^^                                      ^^
>    |
>    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/master/index.html#needless_lifetimes
> help: elide the lifetimes
>    |
> 49 - impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
> 49 + impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
>    |
>
> warning: `common` (lib) generated 2 warnings (run `cargo clippy --fix --l=
ib -p common` to apply 2 suggestions)
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/common/src/uninit.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/common/src/uninit.rs b/rust/common/src/uninit.rs
> index e7f9fcd2e3fb..8d021b1dfc6e 100644
> --- a/rust/common/src/uninit.rs
> +++ b/rust/common/src/uninit.rs
> @@ -35,7 +35,7 @@ pub const fn parent_mut(f: &mut Self) -> *mut T {
>      }
>  }
>
> -impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
> +impl<T, U> Deref for MaybeUninitField<'_, T, U> {
>      type Target =3D MaybeUninit<U>;
>
>      fn deref(&self) -> &MaybeUninit<U> {
> @@ -46,7 +46,7 @@ fn deref(&self) -> &MaybeUninit<U> {
>      }
>  }
>
> -impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
> +impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
>      fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
>          // SAFETY: self.child was obtained by dereferencing a valid muta=
ble
>          // reference; the content of the memory may be invalid or uninit=
ialized
> --
> 2.34.1
>

