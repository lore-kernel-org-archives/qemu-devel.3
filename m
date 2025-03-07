Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C103C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfbk-0000i9-SG; Fri, 07 Mar 2025 16:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfbh-0000hW-9l
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:51:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqfbf-0005Br-0N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:51:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso22105845e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384304; x=1741989104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VcglSgwL9d3YFt+EM1s5ZcGVoRNp/5wHt30Q6WrDCCI=;
 b=qs6Xt5eTn+KnUJPL4JNyWRMnZyHnXEK+7DWw/7NNP2BGwnPD756zIMQPy0JOj04Xvm
 cwia6OA+694n/ACj7kCkRzS7kygrnjJDWg9w38S3IRiIPEtM3BHdg7gfA6ZScU99649m
 DAnnzXjcKoODfeht54FSgwQuvNUchBnsxUwmbc6FgnO8pIiZsK6uNoR+tykHPz2AHiCH
 kHSNtRlN/uMS+4QTJS3jAR09d88TxK6x3U9VZP+zHjXD+hASFmBqxrQjCxR75QBSub+e
 bXBJH1+iYg9zJW0vT2x5yS3lInuQ6lQSZ+dssCRlaG8DiqiSS8+Mxq1v9x3FDr9RgJkI
 DS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384304; x=1741989104;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VcglSgwL9d3YFt+EM1s5ZcGVoRNp/5wHt30Q6WrDCCI=;
 b=anA6qVqEMjw+JgWGAcxqX32JqYKmDm28nyz54Nj4/mNi0UMnzAsYplWsRzo4zoEk6D
 JiFXBzPsZpfyOJG+z+RRGPNjJZ17S3dmT147LIkUdrKvqvPOyY0RaB5MNi9BO2GeKToM
 ZvA9qdm/SllB0sOZnnSdumkcSGUUbbdUSxobcGVdM1ohH15AXNspXi7yEEq11scgEq2O
 as5Y3RZ7q/IWG7KVwLeKJ/nhmyvPudpYg09/3GkG50N63Sv4q9hvC2/nuSKD1ZFtftFm
 jSyZdpuVfqNDb+Ok2Qk8h7DM3dsfKT8ua5Ncbom6aTtGxr0ft0xi1TkSZplhA6sQay7Y
 /1YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwUOETBkOBpkLPXWS3VWgIGEc3XkEGgzrUtn8w80IBBwBNkTxz7wFA0f18jNCQdLlRO28tMFSdDVdM@nongnu.org
X-Gm-Message-State: AOJu0YxxchKnY5BMLQ/HcH3JOvh2sTBUOGxo9EvaInyZpnnScY9nuZ9H
 jWevGbNJA7Ee12IRSt803668KArw7ldOTsubIdDcR+Sv0O9W9VjQKiLi0yrzyM8=
X-Gm-Gg: ASbGncvrdj9YJC3yBO1UAF6f9AwFA/ryS6bHs+tj88oR2MeKlHUctzTKIYZsGGfRQHE
 +RijBInjKZoZ32K3YZIb2Is44iB7kcfcfi/Sqka9/IcDGRoghXAtOO7v7wrX9lRBbO3n3ugD3ms
 rKHoRcUvbYt4rZVuGPXv3JCMCJr5pC0t0n4m0L/B58BiUuei1lYgh53qF4C9WeaRVPJDCzTOJ6p
 5AC4cuFr0crcl9WwFAdq2DcvnuCsm5Ak8Lrmfp8bmRkv5SODErKI5sPD+jbxpYYloaih/LpBW5+
 5EUE3wwJ7pbXbWoUfLrEskR3IoTxCFJ0wNkhl4dxIh01noPPhRidGwpgmcuUQxisqDcaNhcYK38
 /bLp1gMbIjhzW
X-Google-Smtp-Source: AGHT+IEyUVaXQu4EF0C5b/5aTorUNwP4/tS+13vAPKUeCVjbuqmh+xdlynLFipFwyhLadw1pz+YqZA==
X-Received: by 2002:a05:600c:1f92:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-43ce4dcf8e4mr6258045e9.12.1741384303692; 
 Fri, 07 Mar 2025 13:51:43 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff57sm6719302f8f.37.2025.03.07.13.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:51:43 -0800 (PST)
Message-ID: <b45cd704-67e5-4b5d-bf4f-9907693c4b08@linaro.org>
Date: Fri, 7 Mar 2025 22:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: pl011: Allow NULL chardev argument to pl011_create()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250307190051.3274226-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307190051.3274226-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/3/25 20:00, Peter Maydell wrote:
> It's valid for the caller to pass a NULL chardev to pl011_create();
> this means "don't set the chardev property on the device", which
> in turn means "act like there's no chardev". All the chardev
> frontend APIs (in C, at least) accept a NULL pointer to mean
> "do nothing".
> 
> This fixes some failures in 'make check-functional' when Rust support
> is enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is my first Rust related patch for QEMU, so I've
> probably got something wrong here :-)
> ---
>   rust/hw/char/pl011/src/device.rs | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index d0857b470c9..8098f762f4b 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -713,10 +713,12 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
>       // SAFETY: The callers promise that they have owned references.
>       // They do not gift them to pl011_create, so use `Owned::from`.
>       let irq = unsafe { Owned::<IRQState>::from(&*irq) };
> -    let chr = unsafe { Owned::<Chardev>::from(&*chr) };
>   
>       let dev = PL011State::new();
> -    dev.prop_set_chr("chardev", &chr);
> +    if !chr.is_null() {
> +        let chr = unsafe { Owned::<Chardev>::from(&*chr) };
> +        dev.prop_set_chr("chardev", &chr);
> +    }
>       dev.sysbus_realize();
>       dev.mmio_map(0, addr);
>       dev.connect_irq(0, &irq);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


