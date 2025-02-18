Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C108FC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJRN-0001Wu-Cg; Tue, 18 Feb 2025 03:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJRM-0001We-CV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkJRK-00053D-DA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739869128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IFlc6OJjH3+kG9WtL4D6o3dVM6VZ1EV8iFHoyRx4wNU=;
 b=Vm15BiPc63ksKm7tcC0q19HSYXfbNjHFiPDcwRUf06ri3lD7tWldYH1sBjkxaO+af1TWWd
 w6hmO7ukWVWIm9Ulxu2R5MpZ1pBI5rZeoRKMkOdoxGcRFo82TmQpro1KzLbepUddpKkpSD
 JARS2HJrOskXvtLtrexYBwoakii8Ui4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-n1NatkgDOz-oauss5FNZQw-1; Tue, 18 Feb 2025 03:58:46 -0500
X-MC-Unique: n1NatkgDOz-oauss5FNZQw-1
X-Mimecast-MFC-AGG-ID: n1NatkgDOz-oauss5FNZQw_1739869126
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439858c5911so8953065e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739869125; x=1740473925;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFlc6OJjH3+kG9WtL4D6o3dVM6VZ1EV8iFHoyRx4wNU=;
 b=izBpvtfQvjycPVC2keY31wTgXdw3EKsgd6wUXhHi3J5jorMqib+Jm9uREv8v59QlR3
 2AKWzJJLlQDCcvSUSt52MnXkErUYWuSHpLfIRxpc38OJo9EoSO6Ai4TUgoQV00KDJFcv
 L6JOef/4uz13zWm3uNMHv7bnX0yryzWTzAhstd3FTm9VU2lxsYWt07azQam+o04htQMk
 Zshto6Q8dBdzs5yPwM7MZyespoJDAV1hqO7cAAyq4l2K4fdw4rZnUeoKvPT8zoU1rYB2
 vkDTbMQiLojnYoIwWUcBe1d7G0sSYD5cSVOyVQllLWEfhZDdbMLKDiqR2rrG6KsB8yLu
 eUGQ==
X-Gm-Message-State: AOJu0YwXRlmTNiiUyAEaSEF7zGKsR0o4rnE3V4ZN43bEjhO0LoFu8iRp
 B4LSxR1kOWrSrRJYACUIkbf7p1BxqNdti32kV/enF2OAb3Js+lH6qJ6nX0iegU9/qwI0+IeNAFp
 +SE2MzhbofsI3X05iSL7wMzbr9hW2uXVW/hWyhU0I4Sq0tNPPYWyV
X-Gm-Gg: ASbGnct7buPHkzakv9/foYvaa8Z1f2lMREp6Q9ro6pDJbfXpD4n9h9DX6vA6bC0D0LE
 DOcSCBqMfE/yOfzYHHrdMB7595SughVa9T0dFg9V1oSKm7XBfPnv4osBKUVgJbpCSqqWnKcxrLo
 9Ifg1jkMbthw3AC4YW1qle0dQ4ZFf9ALFKgHjUngKdtjO9Abe+pDL4nl++bHDL6YVEmIiT6eim0
 Ui5KJVUo3Sr8NO3LeYWUlfqj/rlKzYq1UpPhhcBU6/5TReOwoU79W5eFQnv5L2rcZOwrJmgGzbh
 4wLeWV117Ds=
X-Received: by 2002:a05:600c:1c94:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-4396e6fa130mr131745925e9.15.1739869125614; 
 Tue, 18 Feb 2025 00:58:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwkeNwGtlVzUmsAU7bKMnD0PNvlUcCs495SebW4ffWzHNeTB/OACbWlufkF9awpu8I9a8YwA==
X-Received: by 2002:a05:600c:1c94:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-4396e6fa130mr131745685e9.15.1739869125291; 
 Tue, 18 Feb 2025 00:58:45 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4399558f8d1sm8697265e9.19.2025.02.18.00.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 00:58:44 -0800 (PST)
Message-ID: <88a20e34-5aa8-4351-a33f-4df110933e35@redhat.com>
Date: Tue, 18 Feb 2025 09:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Prefer link_with over link_whole
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250218083734.3345966-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250218083734.3345966-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/18/25 09:37, Zhao Liu wrote:
> The commit fccb744f41c6 ("gdbstub: Try unlinking the unix socket before
> binding") causes the compilation of rust-qemu-api-integration to fail,
> because rust-qemu-api-integration uses link_whole which meets the
> duplicate symbol linker error.
> 
> Though it's not the issue of link_whole used by Rust side, there's no
> need to use link_whole.
> 
> Use link_with, which may also bring some benefits, such as faster
> linking or smaller output files.

link_with, if I remember correctly, drops the constructors.  Using it in 
rust_devices_ss therefore prevents the devices from being registered 
with QOM.

The real issue is lack of support for "objects" in Meson for Rust 
executables.  A patch to fix that is under review, after which it will 
be possible to build Rust executables using the same "dependency" 
objects as C code.

Paolo

>   rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
> -  link_whole: [_libpl011_rs],
> +  link_with: [_libpl011_rs],
>     # Putting proc macro crates in `dependencies` is necessary for Meson to find
>     # them when compiling the root per-target static rust lib.
>     dependencies: [bilge_impl_dep, qemu_api_macros],
> diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
> index c2d7c0532ca4..ce90cc4f021a 100644
> --- a/rust/hw/timer/hpet/meson.build
> +++ b/rust/hw/timer/hpet/meson.build
> @@ -10,7 +10,7 @@ _libhpet_rs = static_library(
>   )
>   
>   rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
> -  link_whole: [_libhpet_rs],
> +  link_with: [_libhpet_rs],
>     # Putting proc macro crates in `dependencies` is necessary for Meson to find
>     # them when compiling the root per-target static rust lib.
>     dependencies: [qemu_api_macros],
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index 2e9c1078b9b2..e825671b694b 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -63,7 +63,7 @@ test('rust-qemu-api-integration',
>           rust_args: ['--test'],
>           install: false,
>           dependencies: [qemu_api, qemu_api_macros],
> -        link_whole: [rust_qemu_api_objs, libqemuutil]),
> +        link_with: [rust_qemu_api_objs, libqemuutil]),
>       args: [
>           '--test', '--test-threads', '1',
>           '--format', 'pretty',


