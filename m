Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D35CDDE5E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Yh8-0001bL-8T; Wed, 23 Oct 2024 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Yh6-0001b7-M2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:34:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Yh4-0002qM-NS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:34:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso6362358f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729679660; x=1730284460; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F6t0P4IRraux0i655ttAiXksDqW472MbqwgVD8WXawo=;
 b=ao2odWd4zBVlYe9jJF/Jv0afh+wRqdudhzCXLRkO1TenTTBIblXNXY93NE7oghYCj7
 fhvAUfA9rSLsHfq/tEgsrrGb3vshf1sUhw/biHJy6p3VKOmjYRRhUifP9efOjgToZW7x
 MbfjLCJgxR2RPq17KA/avvRUs4rhXH6KGzGPhoXPcb5wFxDpNRnvv3NoFwkjHWL7ei6P
 usjFVdJ8IHeQi7EH1dfaSEqSQXqV4zfVso2GljPAlUw+yTlxmAgA9sNTowUNvwGkOlOJ
 HFAAnPfsVwQnQ8Or7wV4xrcipxFENpmRE3TPg8PxYT1PvJxTw10Swd6GQO/O0JE1sZ5Y
 NhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729679660; x=1730284460;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6t0P4IRraux0i655ttAiXksDqW472MbqwgVD8WXawo=;
 b=vE68XsqFPNGy7LnL5ot8vbBHUiHCTaALsDxaLjrHvt4eIIkpDhLvVsLvJTtkhJ4716
 EDtNLNBfKTqTf2oTkQeED0gxuA9TC/XqXDcVsqcUL1WdL9TRKh4HsnjtF35BdzR0450U
 TjHuU6ZTQJZ3C0047090M6OtTzjGocyTMQOAKTuVmV0m1BgNtTcgiQ5ic2NQqSFw60QR
 3NOGxRQn5b6pfc1wHOpmPTVpboo7V5Hf31n+4DmEsqOCu++yH6G1f3SPKBGbUtFHu2jw
 k2OAr5rGxmzWGi2zz5x1MwoYtSThu4ynnQwMi+s/vNO2NaS9Sf51GZG0qubVeLsIWT9W
 dk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDjGSHeRUxPmXKkhJDg0uC3NIfKxDFW5ueDP1MpaT6MzDaXu0KEE/2Getwcg90Q1uST/wLugNArRSS@nongnu.org
X-Gm-Message-State: AOJu0YzBaC+sKZ1QgLANbaA+MlF3xRANhy1cMHDoCpYiUKODez6ayPRn
 XOySrBQKhvQqKRNbW9EwSuOUzHMZIdnwzmAyyP946c+PYSAS2d/5CnFdgJg0T6A=
X-Google-Smtp-Source: AGHT+IE7oL8WjCyV+AXeF5TcGJEsTQZ3Q4Z04khXNHVuVJKJFQxbOrg0/KUp1dxxPsvkqkeuAO+VPg==
X-Received: by 2002:a05:6000:546:b0:37d:61aa:67de with SMTP id
 ffacd0b85a97d-37efcf7bf73mr1593468f8f.42.1729679660586; 
 Wed, 23 Oct 2024 03:34:20 -0700 (PDT)
Received: from meli-email.org (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a915a114asm454618166b.222.2024.10.23.03.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 03:34:20 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:29:50 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 01/13] meson: import rust module into a global variable
User-Agent: meli 0.8.7
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-2-pbonzini@redhat.com>
In-Reply-To: <20241021163538.136941-2-pbonzini@redhat.com>
Message-ID: <lt1d7.lvtvfw4qqc8g@linaro.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Mon, 21 Oct 2024 19:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> meson.build                      | 1 +
> rust/qemu-api-macros/meson.build | 2 +-
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/meson.build b/meson.build
>index d26690ce204..ffd78b6cbb3 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
> 
> not_found = dependency('', required: false)
> keyval = import('keyval')
>+rust = import('rust')
> ss = import('sourceset')
> fs = import('fs')
> 
>diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
>index 517b9a4d2d5..24325dea5c2 100644
>--- a/rust/qemu-api-macros/meson.build
>+++ b/rust/qemu-api-macros/meson.build
>@@ -2,7 +2,7 @@ quote_dep = dependency('quote-1-rs', native: true)
> syn_dep = dependency('syn-2-rs', native: true)
> proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
> 
>-_qemu_api_macros_rs = import('rust').proc_macro(
>+_qemu_api_macros_rs = rust.proc_macro(
>   'qemu_api_macros',
>   files('src/lib.rs'),
>   override_options: ['rust_std=2021', 'build.rust_std=2021'],
>-- 
>2.46.2
>

You could also change the bindgen target line:

  bindings_rs = import('rust').bindgen(

Either way:

Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

