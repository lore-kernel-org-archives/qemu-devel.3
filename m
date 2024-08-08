Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670F2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyYz-000714-71; Thu, 08 Aug 2024 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbyYx-0006zH-Mg
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbyYv-00050I-Tt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723105916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6l0Gy8dFEgUlxYu0trH+/uJ82XK8LXdOH/uUXeKp2PY=;
 b=bYQiwSYEGrWTua811BMBRVXggphZmS6wKZS9tNAjVTTMsAeweRtT7aeg9tG7bxwZd9W1cy
 S6+ZJNUaZ/GkMOQHr6BPLUBHn56gRjZjrkWlNOuRfyjsMRDqW033rI0huCgY6H28aX3/f5
 rSDY2eDKyBcWcPQBnykw4fZKkQFUZrA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ohJwj6ObM0mh5-WsYpi_6g-1; Thu, 08 Aug 2024 04:31:53 -0400
X-MC-Unique: ohJwj6ObM0mh5-WsYpi_6g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7abee2b4b0so59716066b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723105912; x=1723710712;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6l0Gy8dFEgUlxYu0trH+/uJ82XK8LXdOH/uUXeKp2PY=;
 b=EsWDGyWz19gNEMlSWOAC1d5T0nj5Hz9EUTviLxj2/QKHHDsiRes0QsHbRKyK2WQiic
 VPazOKA2Om+/+sfNfX5CPaLY3J4ox6U4YCWMu8YmYkozE9e3FP/ZE2e5uqlY2meMSHtv
 jQUhYtOJWCddprWCRHbx5xnxroxkAJmoJx9brJ1TMA0TX5N8+ng58H6TaCtKrekCi/As
 ES5NmEulCLOoI6fT+jeYCJmW0+C1dH3VA3NLEsLMe6Qtfn6OuQwSQQDP/i7eQ+R/fbc5
 nR7XkvA+UMm+dPhhrmdFt+9gQPPZtIXaGjqxe32r7KYDSFDusudkqDdexwMTfI2cpnsN
 +2gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC54tX2biQ8oKNoLhW3gLQWbedIrpS9U5k/F+fgwpGBvGKWXKILm7rvkkLwTjz/Ive7qUx8G/r+2f3X6/wFrZ5GT4IFUk=
X-Gm-Message-State: AOJu0Yy9phFgFfxwJWk8jLHqWV5RJ/GJDEJU9/9EOPP11wXCJ5Jg9TVP
 Fmo01SKilCkdjh7Gv1ZgGxQjG+dRgvY4YttC/jXSFjn+BWNmg2s5XMV5cHZUZRCjlBSCklR6Qb7
 N3xIXfEFtqDWdxoBktbHsJ8r9EuhWllIW/ubRoTOTo2RNkEmK3q7A
X-Received: by 2002:a17:906:bc18:b0:a7a:83f8:cfcf with SMTP id
 a640c23a62f3a-a8090dae6f9mr75521466b.35.1723105911950; 
 Thu, 08 Aug 2024 01:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9QcHdYNhKn8be4nx44OpOj8g2kT+agbIm4E9EwPqVbdQ+Kml2BGYR1uU7KvYkcj0niyrhKQ==
X-Received: by 2002:a17:906:bc18:b0:a7a:83f8:cfcf with SMTP id
 a640c23a62f3a-a8090dae6f9mr75518666b.35.1723105911402; 
 Thu, 08 Aug 2024 01:31:51 -0700 (PDT)
Received: from [10.168.67.37] ([131.175.147.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0ca17sm717473766b.84.2024.08.08.01.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 01:31:50 -0700 (PDT)
Message-ID: <9a83a260-4f4c-477b-a6e1-c8d78d1f3039@redhat.com>
Date: Thu, 8 Aug 2024 10:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 5/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <rust-pl011-rfc-v6-5.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <rust-pl011-rfc-v6-5.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/4/24 23:04, Manos Pitsidianakis wrote:
> diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
> new file mode 100644
> index 0000000000..a17a823cf5
> --- /dev/null
> +++ b/rust/hw/char/pl011/meson.build
> @@ -0,0 +1,28 @@
> +if not config_host_data.get('CONFIG_HAVE_RUST')
> +  subdir_done()
> +endif
> +
> +add_languages('rust', required: true)

These five lines are not necessary.

> +arbitrary_int_dep = subproject('arbitrary-int').get_variable('arbitrary_int_dep')
> +bilge_dep = subproject('bilge').get_variable('bilge_dep')
> +bilge_impl_dep = subproject('bilge-impl').get_variable('bilge_impl_dep')

The subprojects also need to be added to scripts/archive-source.sh and 
scripts/make-release.

In order to simplify a future switch to Cargo projects, this should be 
something like:

subproject('bilge-0.2-rs', required: true)
subproject('bilge-impl-0.2-rs', required: true)

bilge_dep = dependency('bilge-0.2-rs')
bilge_impl_dep = dependency('bilge-impl-0.2-rs')

with a corresponding

meson.override_dependency('bilge-0.2-rs', bilge_dep)

in subprojects/packagefiles/bilge-0.2-rs/meson.build.

Also in bilge's meson.build:

> +arbitrary_int_dep = subproject('arbitrary-int').get_variable('arbitrary_int_dep')
> +bilge_impl_dep = subproject('bilge-impl').get_variable('bilge_impl_dep')
> +
> +lib = static_library(
> +  'bilge',
> +  'src/lib.rs',
> +  override_options : ['rust_std=2021', 'build.rust_std=2021'],
> +  rust_abi : 'rust',
> +  native : true,
> +  dependencies: [

native should not be true here (but it should be true for the 
dependencies of bilge-impl: either, itertools, proc-macro-error, 
proc-macro-error-attr, proc-macro2, quote, syn, unicode-ident).

I've placed my updates at a branch "rust-for-manos" of 
https://gitlab.com/bonzini/qemu/.  I left the fixes unsquashed for your 
review, but feel free to merge them and post the result as part of v7.

Paolo


