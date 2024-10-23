Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69606CDDE66
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Yxs-0007bn-UJ; Wed, 23 Oct 2024 06:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Yxq-0007be-Rz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:51:42 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Yxp-0004xJ-8m
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:51:42 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso7117412a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729680699; x=1730285499; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4PiDI5cPpjmWDlBlJK/6O6CptQymgbsl26CDU/NUMBc=;
 b=ZLbbyyOeo8IHVNGJLfjwU/UVwLoi/4hKu1wX4cAnSAx6o2uv/ml+dTtH9fO5yhnSxp
 lJ7iI25Z0c+MAW0DCOKzAlZlOZ5zWphALR78hTiqiTQC4igcKYWvDEKmNQw7Eh0gbIn8
 FxeKXd/l4VIshIw+IEbJcjOqrM48yCSD/byVu8lubm1eaKfloat7KRcpSrJFi2BcMrZc
 AC31cGZcYS5Zcd0gxnRU2hpv4ninnArISXLzSzC+oATlxVeDusVwB7cdfAFI6wEkMBNG
 nure++hDKtHt1Fe+ubEURXH3X48HWGMkpYMfhMxf3wR3/U0oN/TC06/S3tPtCoKok2V5
 YtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729680699; x=1730285499;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PiDI5cPpjmWDlBlJK/6O6CptQymgbsl26CDU/NUMBc=;
 b=UlNLnawcui7ZFQxcTTcOdnyz7Blwwo3lKJXy83kGFRwWvcWAEl2QirrHhjZ/fKfdIF
 qirqdaliTdSqkNduNcG+tX1vUWSGFGRivCmbvgWrv2r+El81YLMuI0bBe8dUyhtbZOUy
 69xPLcWC69CjC+PmSVX2EXnOb5PdrOco7uTrnZ6nKVdKEBTTY272AfgawoVdq/ecN83W
 ipAUQ/SXkxC8jfP0jETvwFkGyg0ug8/eqZ3OstWBQ8ag8KzPDQN3tt8MuPe5o8NrwZ39
 I8eFYN3GVQERkTd/TXk+A0if7uFnLw3yA7k6Hxtc3BOe13W0b62X0a3dJgpENcNdeHhL
 dHCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnywy3UEHU5Ps/020L9Y7SKDEFnWB+odlUW/2BaJSW00fBXsBPwXNCrpJcZnX6kxIiF5A++FvtjMbd@nongnu.org
X-Gm-Message-State: AOJu0YybpUmz6c1ptsh7g440VhKHaW4IUxEf/GsrpRbODyHbI+4aFKH4
 mA75A7pE08Iufhcydr2j4w7R+b1vpTd/TPwv503QvFYXqMZ//P7xRoZ99MO8KK4=
X-Google-Smtp-Source: AGHT+IHnT8J2y7ohykaO9SnmD8xgQruK8bt5dZ/2+2JB7YECAXWDYOxNed7ewV2bVuZp8PV8SsQ0Dw==
X-Received: by 2002:a50:c8cd:0:b0:5c8:9f3e:e57 with SMTP id
 4fb4d7f45d1cf-5cb8acdd791mr1342905a12.18.1729680698841; 
 Wed, 23 Oct 2024 03:51:38 -0700 (PDT)
Received: from meli-email.org (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a654b9sm4298513a12.34.2024.10.23.03.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 03:51:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:38:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 09/13] rust: clean up define_property macro
User-Agent: meli 0.8.7
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-10-pbonzini@redhat.com>
In-Reply-To: <20241021163538.136941-10-pbonzini@redhat.com>
Message-ID: <lt261.tyno4xdeejj0@linaro.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Hello Paolo,

On Mon, 21 Oct 2024 19:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Use the "struct update" syntax to initialize most of the fields to zero,
>and simplify the handmade type-checking of $name.

Note: It wasn't meant for type checking but for making sure the linker 
doesn't strip the symbol (hence the #[used] attribute). These were left 
over when I was debugging linker issues and slapped #[used] everywhere 
but they are not needed in this case indeed.

>
>Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
> 1 file changed, 6 insertions(+), 23 deletions(-)
>
>diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
>index 2219b9f73d0..5aba426d243 100644
>--- a/rust/qemu-api/src/device_class.rs
>+++ b/rust/qemu-api/src/device_class.rs
>@@ -29,44 +29,27 @@ macro_rules! device_class_init {
> macro_rules! define_property {
>     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
>         $crate::bindings::Property {
>-            name: {
>-                #[used]
>-                static _TEMP: &::core::ffi::CStr = $name;
>-                _TEMP.as_ptr()
>-            },
>+            // use associated function syntax for type checking
>+            name: ::core::ffi::CStr::as_ptr($name),
>             info: $prop,
>             offset: ::core::mem::offset_of!($state, $field)
>                 .try_into()
>                 .expect("Could not fit offset value to type"),
>-            bitnr: 0,
>-            bitmask: 0,
>             set_default: true,
>             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
>-            arrayoffset: 0,
>-            arrayinfo: ::core::ptr::null(),
>-            arrayfieldsize: 0,
>-            link_type: ::core::ptr::null(),
>+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }

Call it personal taste but I don't like emulating C's zero initializer 
syntax in Rust :) Is it that much trouble to explicitly write down every 
field in a macro, anyway? No strong preference here though.

>         }
>     };
>     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
>         $crate::bindings::Property {
>-            name: {
>-                #[used]
>-                static _TEMP: &::core::ffi::CStr = $name;
>-                _TEMP.as_ptr()
>-            },
>+            // use associated function syntax for type checking
>+            name: ::core::ffi::CStr::as_ptr($name),
>             info: $prop,
>             offset: ::core::mem::offset_of!($state, $field)
>                 .try_into()
>                 .expect("Could not fit offset value to type"),
>-            bitnr: 0,
>-            bitmask: 0,
>             set_default: false,
>-            defval: $crate::bindings::Property__bindgen_ty_1 { i: 0 },
>-            arrayoffset: 0,
>-            arrayinfo: ::core::ptr::null(),
>-            arrayfieldsize: 0,
>-            link_type: ::core::ptr::null(),
>+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
>         }
>     };
> }
>-- 
>2.46.2
>

