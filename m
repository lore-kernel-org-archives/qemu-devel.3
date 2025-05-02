Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B6BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 11:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAoKl-0003MS-NY; Fri, 02 May 2025 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAoKi-0003JL-Cj
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:13:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAoKf-0005SQ-OK
 for qemu-devel@nongnu.org; Fri, 02 May 2025 07:13:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso7529205e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746184408; x=1746789208; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vCSzSM8DVg7QoR9d8k2QuiqD9XO+t9hB/HzFzaCSTC4=;
 b=iu2XedDtOTDlNhv/GWAgXbLYwaJWBFWqz93WqfQ42PS9sVC926b5Ml/E/Pv6vHtmEO
 tuSuZ8tCEnzkn4MkMT5D3NWANNh3kDRnGj8nszJvMdcRqme5vtLq8Plr3P8vafhJ7A/a
 1sp9p4BQS8lhpwCjM7TrWsIc8DZcAXEOEWzJlmBzi1Eawm3CkOymy6gvaq85GoiZwf3R
 r1Xpr9EJ4yma7uUm5oUZtRmZd1H2RhKqhTQoT7MvkAck1jdFUaFO2sbHsrvy2XoKY6fB
 IWs3rPJMk7607FNY1xnCGK5iwH/k+rewdsb5DXxt8YHIEj0j6FWC+Iu/zWgizLuwHqzn
 A+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746184408; x=1746789208;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCSzSM8DVg7QoR9d8k2QuiqD9XO+t9hB/HzFzaCSTC4=;
 b=Mv2/BtjfPpoqHf71q7ZOXHwPh7rg/Bg1dudub+uvqSUOa4xdYRVrPzdJIehHJEhWHw
 ujsUDTAKTu79z2GjueV6f0JRnExc6JN/klJdwW1jO9vUiXzFELsyHc1TBMWRPWMxuK42
 0g+BPHXWQ4mEXiUnGlU79aU2WnSSvjTCBNVUXH0v5HssQkllJmq8fp3hBY7N0yzcsgpn
 dwGTiGBowNJXxXi7zRUeUm9CYk0ZTxsgI2cEakb1eHNcAVWGD2YEAlu3C+IroCOB90WV
 gqzCgc4HhcUjqMnE6W/Uu0CoC8ObrNIX4ixGrQoRrNBTxWgejYd29dHGItCD28wKiceQ
 EZGg==
X-Gm-Message-State: AOJu0YzWlLtMpw3goTL0SOYIX7GIR5dQYLnflSQWNaYkmdHryErKa8b9
 +gls0T7hNpMOgOEEhqyHwp4lcGqq67IJKp/2BzTs0Q6kWhM6IYqjEDKziWAuD96OletfJ8GVwau
 2ubk=
X-Gm-Gg: ASbGncsYhwfvlzN6p8LBXnHA9LbbOqJUCqdWWEQ3y+CBsISkwMqGdYCQEhEcmWJ3ZHF
 Ez61DR+QK3o4+5gr9HeJry59bCvy4ZAxyBRtNTTmr8JzvAgdHblwwGtfc2RW7ZFV/HfWUsFXcUZ
 S4XLSEB4f+isHcMoClPROvhQwUG7vUWjZtsTUIG2BSBRKnpAlYFbA+5MhRirsBjvUfvyBooxhNd
 Z7MAl+a8cNmAbfnWFMasFMUxK7lR1ztBK28qYpR8Xnl44YY2K/ulEUm3xpeniUgcEQah9LLUG2V
 ATxYXw+qw+YeU+1uiI7wg/k4vtAcU5Hbr5r2aK/j/8TvUXo/ts1GlULgL1Eq0ht29l+FSc2Yser
 UK4pE3w==
X-Google-Smtp-Source: AGHT+IEtY9ApAwYjqJsfX/M+WyF2XjM33ktO4Ztx6xi9paV5/dinGzPv6ajf9gPE9zPfApUJImhDZg==
X-Received: by 2002:a05:600c:a40a:b0:43d:ed:acd5 with SMTP id
 5b1f17b1804b1-441c0453151mr4493005e9.10.1746184408000; 
 Fri, 02 May 2025 04:13:28 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee171sm41109015e9.17.2025.05.02.04.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 04:13:27 -0700 (PDT)
Date: Fri, 02 May 2025 14:09:10 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 8/9] rust: enable clippy::ptr_cast_constness
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-9-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-9-pbonzini@redhat.com>
Message-ID: <svmsie.1mbmcen6stmg8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Fri, 02 May 2025 13:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> docs/devel/rust.rst             | 2 --
> rust/Cargo.toml                 | 2 +-
> rust/clippy.toml                | 2 +-
> rust/hw/char/pl011/Cargo.toml   | 2 +-
> rust/hw/timer/hpet/Cargo.toml   | 2 +-
> rust/hw/timer/hpet/src/hpet.rs  | 2 +-
> rust/qemu-api-macros/Cargo.toml | 2 +-
> rust/qemu-api/Cargo.toml        | 2 +-
> rust/qemu-api/src/cell.rs       | 2 +-
> rust/qemu-api/src/chardev.rs    | 2 +-
> rust/qemu-api/src/qom.rs        | 4 ++--
> rust/qemu-api/src/timer.rs      | 2 +-
> 12 files changed, 12 insertions(+), 14 deletions(-)
>

These:

>diff --git a/rust/clippy.toml b/rust/clippy.toml
>index 5d190f91dec..933e46a2ffb 100644
>--- a/rust/clippy.toml
>+++ b/rust/clippy.toml
>@@ -1,2 +1,2 @@
> doc-valid-idents = ["PrimeCell", ".."]
>-msrv = "1.63.0"
>+msrv = "1.77.0"

>diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
>index f2296cad58b..4766badd73e 100644
>--- a/rust/hw/char/pl011/Cargo.toml
>+++ b/rust/hw/char/pl011/Cargo.toml
>@@ -9,7 +9,7 @@ resolver = "2"
> publish = false
> keywords = []
> categories = []
>-rust-version = "1.63.0"
>+rust-version = "1.77.0"
> 
> [lib]
> crate-type = ["staticlib"]

>diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
>index 147f216e725..c6c48b2f887 100644
>--- a/rust/hw/timer/hpet/Cargo.toml
>+++ b/rust/hw/timer/hpet/Cargo.toml
>@@ -5,7 +5,7 @@ edition = "2021"
> authors = ["Zhao Liu <zhao1.liu@intel.com>"]
> license = "GPL-2.0-or-later"
> description = "IA-PC High Precision Event Timer emulation in Rust"
>-rust-version = "1.63.0"
>+rust-version = "1.77.0"
> 
> [lib]
> crate-type = ["staticlib"]

>diff --git a/rust/qemu-api-macros/Cargo.toml 
>b/rust/qemu-api-macros/Cargo.toml
>index 89dee1cfb39..8344b1f939d 100644
>--- a/rust/qemu-api-macros/Cargo.toml
>+++ b/rust/qemu-api-macros/Cargo.toml
>@@ -9,7 +9,7 @@ resolver = "2"
> publish = false
> keywords = []
> categories = []
>-rust-version = "1.63.0"
>+rust-version = "1.77.0"
> 
> [lib]
> proc-macro = true
>diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
>index c5b7b2464e9..be00ef1ae9b 100644
>--- a/rust/qemu-api/Cargo.toml
>+++ b/rust/qemu-api/Cargo.toml
>@@ -12,7 +12,7 @@ resolver = "2"
> publish = false
> keywords = []
> categories = []
>-rust-version = "1.63.0"
>+rust-version = "1.77.0"
> 
> [dependencies]
> qemu_api_macros = { path = "../qemu-api-macros" }

msrv/rust-version bumps could instead go in the patch that also updates 
meson.build version.

Otherwise,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

