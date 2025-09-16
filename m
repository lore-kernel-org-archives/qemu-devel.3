Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6DCCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySna-0002Vs-2Z; Tue, 16 Sep 2025 06:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySnP-0002MA-5H
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:20:24 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySnM-0000ne-J0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:20:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b0473327e70so262443466b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758018017; x=1758622817; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw/wjxliZDSj8JvRwsa1dpja2LrMHrTyuaXLoozbE9w=;
 b=zr1zN6kXKZVv6T96GxX6NQ/wrzHQ7NshaIg0SWX0bP+Jt38qMcTPjK79r7DbjZh0cO
 bpygnZ6OA3Im716ywlLhMTTo/35g1jRySprJhDKF8CsIMRk7qj4MKSSbCEr9t8UleqFK
 Z17ZNS3WwvTyjCHF0APAVmGmyYTihMz0k0WnB+P4F1P7JcLLoMg2SL2HJTbsPy5NSPYU
 pyXDbnu4tIrBRSyfahuS8Hi8Kgzc3bPvV9KgWKhaSVvcXxpTzLaAZlhoEUvWnrpnOouP
 rcm0pdU8wzDUWz0gb2F7FJTDO+TDiIIA5RA6E8CelyIOcghFkTwoodoONI6nz7f9iesc
 lUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758018017; x=1758622817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fw/wjxliZDSj8JvRwsa1dpja2LrMHrTyuaXLoozbE9w=;
 b=cqC7dFV4AFmFKhojR4+fyqvpuvxPbviKyoaF5LFo48bhdgwY+qokWMmXCInZUBa+hP
 k7uJh1zAnEdQq2UT0bayemsXFLr2byrpCFC7gpNdTVCBN9oPfqpWts/N6PKAzsF9WD4/
 Pr5js8wSTZDc9E4eTeAjOUvOOTd7vMRoxLCmNUbQxANFPhnUIWMw1h+7yA4BITM8QLLc
 ++LqFcpN/icQ2gI6G1f2J4vau+zr5eIUSYoyjc10vjeqJVKfXDMv2gm5hq+YMrE4cC53
 +wxqfA/HSY14gKU/epJqszWtn4027FnS5ShBXp4PHEBBpm9RX4qbrfMwu2AAEZscXbhL
 r27A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXxuKoq18YuHdpJUcqXkcPUF2PaX20jA4IQyi//3089e20Pdm9wzTZG5AMNGM5Pn5YsPfEgpmvvRa4@nongnu.org
X-Gm-Message-State: AOJu0YzNI19/c7m+3u/pDa6I3UkKDOKBnwKcSM/Qi4zn2ACRbxQTMDk2
 tdZr7lqx2dyCx3baQ0XNAlJXJQYnamhN6j8grhmrYPhtXVQCsb7blyweAlRJScUJ9DBUrvygqcT
 QijjbLnUw1xAmQuu4m4Greiyhv0YrqzfWVCe+tzx1wQ==
X-Gm-Gg: ASbGncv6YxybnyvxOQsKHjEWnr19ijvYzqVJuQ+onDLStcEz7SqId3vBCoK9UfRjRgV
 IXpTVgXJPL/9FtX0QTNdP9xmqlMnWP93wFcf2k49s2zV98ZZcfpq9oujOJ9VKCfbwHslYuJoMX5
 zxolcCfEb1ss9L9h23mQSpStcWBIJ+16OuEvhbMy/e6EBuYveQg/t59WYkow8U+6XtsFAKQKLfV
 AYA1yfY
X-Google-Smtp-Source: AGHT+IE1GBIydRoX5P8Nc+MnGeslCswHihhmkY2s2WrFRy0Evh0eUI4FYYLvQIljznNScu7SyrFtZlvGvwjQ0+kSR0Q=
X-Received: by 2002:a17:907:3f89:b0:b04:3bfe:5b20 with SMTP id
 a640c23a62f3a-b07c38295fbmr1649957766b.30.1758018017305; Tue, 16 Sep 2025
 03:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-13-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-13-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 13:19:51 +0300
X-Gm-Features: AS18NWDFGpAaxu0D9scCyky5HoAKpT5quRYXz1Ujc-bxH20MJv1y5dWwwSd0WgI
Message-ID: <CAAjaMXaNCc2hE-n+TwxfGauhT+f+5rj2tL9j1iDbf0bOLdgWfw@mail.gmail.com>
Subject: Re: [PATCH 12/12] rust/qdev: Drop declare_properties &
 define_property macros
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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
> After HPET's #property conversion, there's no use case for
> declare_properties & define_property. So get rid of them for now.
>
> In future, if there's something that #property really cannot resolve,
> they can be brought back.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/hw/core/src/qdev.rs | 53 ----------------------------------------
>  1 file changed, 53 deletions(-)
>
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index a8cd9e3c2fd5..a32ada4c175e 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -248,59 +248,6 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
>      }
>  }
>
> -#[macro_export]
> -macro_rules! define_property {
> -    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit =3D =
$bitnr:expr, default =3D $defval:expr$(,)*) =3D> {
> -        $crate::bindings::Property {
> -            // use associated function syntax for type checking
> -            name: ::std::ffi::CStr::as_ptr($name),
> -            info: $prop,
> -            offset: ::std::mem::offset_of!($state, $field) as isize,
> -            bitnr: $bitnr,
> -            set_default: true,
> -            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defva=
l as u64 },
> -            ..::common::zeroable::Zeroable::ZERO
> -        }
> -    };
> -    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default =
=3D $defval:expr$(,)*) =3D> {
> -        $crate::bindings::Property {
> -            // use associated function syntax for type checking
> -            name: ::std::ffi::CStr::as_ptr($name),
> -            info: $prop,
> -            offset: ::std::mem::offset_of!($state, $field) as isize,
> -            set_default: true,
> -            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defva=
l as u64 },
> -            ..::common::zeroable::Zeroable::ZERO
> -        }
> -    };
> -    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) =3D=
> {
> -        $crate::bindings::Property {
> -            // use associated function syntax for type checking
> -            name: ::std::ffi::CStr::as_ptr($name),
> -            info: $prop,
> -            offset: ::std::mem::offset_of!($state, $field) as isize,
> -            set_default: false,
> -            ..::common::zeroable::Zeroable::ZERO
> -        }
> -    };
> -}
> -
> -#[macro_export]
> -macro_rules! declare_properties {
> -    ($ident:ident, $($prop:expr),*$(,)*) =3D> {
> -        pub static $ident: [$crate::bindings::Property; {
> -            let mut len =3D 0;
> -            $({
> -                _ =3D stringify!($prop);
> -                len +=3D 1;
> -            })*
> -            len
> -        }] =3D [
> -            $($prop),*,
> -        ];
> -    };
> -}
> -
>  unsafe impl ObjectType for DeviceState {
>      type Class =3D DeviceClass;
>      const TYPE_NAME: &'static CStr =3D
> --
> 2.34.1
>

