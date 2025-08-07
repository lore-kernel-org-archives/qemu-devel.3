Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D557AC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzkg-0001NP-EF; Thu, 07 Aug 2025 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujzka-0001JZ-Gq
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:29:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujzkY-0000go-Kz
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 08:29:40 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6155e75a9acso1547703a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754569777; x=1755174577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLuWjuObH0hdqtraSsu5F50TkfggzDjqnfB7BJtWoVY=;
 b=HtKzgso59tU/EnpGFulq4mg0wvf8XOLU02XRNaOiGjuPXGzz08TJF/57yM6HayWw1P
 R+wvtYeV774FW+1dMk5TS8Yeu+w4FEo2BHhzYf5Zaaw3gbRWU7W9Cj24/UWdwksWvnru
 jw/iuElcE1M/6j6Mjt5LobBRVG3Lx8iSs59UOkf8rCToKeg+jcLPl2foP59S9c+iAXyD
 kL0LCngKi9toidLK1ovYA9gJzKU5/ax3t1RuYkEu9cu3mEpGLakHK0hM6E8BgZu3s1iW
 w92HL4D8fBFsVDIa5vcc3l7LWC1Us7QTH/r+pHGCFwM7mg0EgXfi6ng7sdj5EFZS5tMn
 WYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754569777; x=1755174577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLuWjuObH0hdqtraSsu5F50TkfggzDjqnfB7BJtWoVY=;
 b=NkShv2g61J3CQrp84xw3MZYepfsMd9quiNOEB45MuI+bsdmcT9GNljcUmhtDl+bd++
 8GfVqZeCG25FE7mvKVY34+mIequw9LnLEppto48WdknqMv3/46MKllkdbzyFZKs472EJ
 SzqNcL5JwfDsAoyOy7zA3GP0mRRuSvqNUjT+fI4CP0MCXP6c/ip/EldzlIrr0KfqbwDJ
 TqQOvM/+Ei2T+nPW3A0m930I+fqOzfwoN11T3VorVoq5lsoL40FXY9wjxTR4akkq+joF
 9V1m5e5C74R8r5XjZVtBIE7yVdQkZgA/YzqJNuc6eXFEKilxgEOE+RUnwX1vXzF6OT7I
 6aHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Sd3eEh1v1+JEimSXluRteMOp37eP13UH8L11orvzzziitLW5NYLEb7EfeUL9rcTGxg6lZX1H7zZ4@nongnu.org
X-Gm-Message-State: AOJu0Yw8tCv2Vo/FssVB2kf8HVUGnC2CaB6qLRMd9eeSdTaG4oitOotb
 57cDJw3I/i3bwU6PnroqVGHsZLTKMHWywxBLH9sCQthKKjgwZxKo0wl0Yr8oM31ww1tf511YknM
 9FYygIT6ehL30MAnAWb+HY7XIdN3AVkHdx0qSqqAPXA==
X-Gm-Gg: ASbGncv2/3aPyFlAmWAHK0nUks/7KslXvzWufKdQWrScfgKTcJhcep1BjudyOP9gUdK
 0l7fjcrzZudRY+SbmOqcX3jXYe68yiB5d5c3ONpV0vnjCx530M2Z3qJOzQ6/LdcEtlQeJuMYzi3
 Jt3pGiFQjmxNPei9Y2uGC0p+QmsyQMnIrqNKxc/w4RuegIysHzGfDLCZdtTSnYFHbeY0NelhRGO
 +0OnV8s
X-Google-Smtp-Source: AGHT+IEdE8O/oaHfKrzyQCsRfDNTbtxqq2QXRKTLiXTlQQdFKtycmAcZJbE9T/sTwYG8S3hOHAlfRZgRqhofjWJTp9c=
X-Received: by 2002:a05:6402:5210:b0:615:a2ec:667b with SMTP id
 4fb4d7f45d1cf-61796141dc0mr5562404a12.20.1754569776489; Thu, 07 Aug 2025
 05:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
In-Reply-To: <20250807123027.2910950-14-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 7 Aug 2025 15:29:09 +0300
X-Gm-Features: Ac12FXzOtzgiGM5SJYAlQSRveIb7qp-WUQLn_qkkTOu-7G5R3n4ZkVIy44ClGLM
Message-ID: <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, Aug 7, 2025 at 3:09=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrote=
:
>
> Add rcu_read_lock() & rcu_read_unlock() bindings, then they can be used
> in memory access.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  rust/qemu-api/meson.build |  1 +
>  rust/qemu-api/src/lib.rs  |  1 +
>  rust/qemu-api/src/rcu.rs  | 26 ++++++++++++++++++++++++++
>  rust/qemu-api/wrapper.h   |  1 +
>  4 files changed, 29 insertions(+)
>  create mode 100644 rust/qemu-api/src/rcu.rs
>
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index a362d44ed396..d40472092248 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -68,6 +68,7 @@ _qemu_api_rs =3D static_library(
>        'src/prelude.rs',
>        'src/qdev.rs',
>        'src/qom.rs',
> +      'src/rcu.rs',
>        'src/sysbus.rs',
>        'src/timer.rs',
>        'src/uninit.rs',
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 86dcd8ef17a9..4705cf9ccbc5 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -26,6 +26,7 @@
>  pub mod module;
>  pub mod qdev;
>  pub mod qom;
> +pub mod rcu;
>  pub mod sysbus;
>  pub mod timer;
>  pub mod uninit;
> diff --git a/rust/qemu-api/src/rcu.rs b/rust/qemu-api/src/rcu.rs
> new file mode 100644
> index 000000000000..30d8b9e43967
> --- /dev/null
> +++ b/rust/qemu-api/src/rcu.rs
> @@ -0,0 +1,26 @@
> +// Copyright (C) 2025 Intel Corporation.
> +// Author(s): Zhao Liu <zhao1.liu@intel.com>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
> +//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
> +

How about a RAII guard type? e.g. RCUGuard and runs `rcu_read_unlock` on Dr=
op.

Destructors are not guaranteed to run or run only once, but the former
should happen when things go wrong e.g. crashes/aborts. You can add a
flag in the RCUGuard to make sure Drop runs unlock only once (since it
takes &mut and not ownership)

> +use crate::bindings;
> +
> +/// Used by a reader to inform the reclaimer that the reader is
> +/// entering an RCU read-side critical section.
> +pub fn rcu_read_lock() {
> +    // SAFETY: no return and no argument, everything is done at C side.
> +    unsafe { bindings::rcu_read_lock() }
> +}
> +
> +/// Used by a reader to inform the reclaimer that the reader is
> +/// exiting an RCU read-side critical section.  Note that RCU
> +/// read-side critical sections may be nested and/or overlapping.
> +pub fn rcu_read_unlock() {
> +    // SAFETY: no return and no argument, everything is done at C side.
> +    unsafe { bindings::rcu_read_unlock() }
> +}
> +
> +// FIXME: maybe we need rcu_read_lock_held() to check the rcu context,
> +// then make it possible to add assertion at any RCU critical section.

This would be less necessary with Drop, maybe.

> diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
> index 15a1b19847f2..ce0ac8d3f550 100644
> --- a/rust/qemu-api/wrapper.h
> +++ b/rust/qemu-api/wrapper.h
> @@ -69,3 +69,4 @@ typedef enum memory_order {
>  #include "qemu/timer.h"
>  #include "system/address-spaces.h"
>  #include "hw/char/pl011.h"
> +#include "qemu/rcu.h"
> --
> 2.34.1
>

