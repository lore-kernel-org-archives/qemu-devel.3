Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E4AD6E2DE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJH7-0006rg-Bl; Thu, 18 Dec 2025 14:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJFK-00065L-1x
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:01:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vWJF7-0001Ab-Gp
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 14:00:57 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so852028b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 11:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766084451; x=1766689251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qux5kJlnf4yLb4Jal/b5IDnLE2fgj2b9cmP/92c4XpU=;
 b=Y5WWrmV0hvM2FW9EVecs8hr0tUuFcDPyAEtSZnarTokY1Cr9//lt2wrx6fc9B0Y3Bl
 GuooXbPhk5F02m5iCAUmCZ0J5qHveVjreCtcq+OcmCRU6vHbE6r54izq7igNrmRvjz7i
 1EKrAxwvbRjtasHQbs0zymBWowsNS+gua1PF29kAQoIPeq7lxK3vaWgTZo4DCSdYABm3
 MJ9MwGANgxH5j+EX0eoa4UXRa+ksDsZB+bJMACMAH3qVetoa2aEd06H6gKOACCpuUr+3
 Wv9TlQaO4yvRRslb1HfyYTHoFvD0Zk1Zlhk9AfiY/u53JBEFTGxDGKWkOa8LrxoM7LNs
 9f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766084451; x=1766689251;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qux5kJlnf4yLb4Jal/b5IDnLE2fgj2b9cmP/92c4XpU=;
 b=Qq24/OvWkFrdxi98AdJr9ccAIXUv0gXQo6dhOoLTt1ooeqmcYVZpsZsbQSiHYAQrZE
 rMPf/iUHIiufZFy70TWs9Yov6hJVC3qV0DpslE4DwgcDmae955yx/nGQR7CYgZZ7QG47
 5Emrfnw1ixY1BHVxa3g7VGLa8TdCgd58F8AYUiQq3ZRagne08U6Cn6jBO4/DxoDlbelB
 SRH7TTRC5uIzsv0DRt2f5+i3+kQpAr2ygpTsTmCpJD0dWlMbB21tQk1ZfRGleNLIkb96
 DHU5DYWpMay8TVVjIZgCYOYiFQKQn/1ZlKVQCePyqktCid8lr8WQ6SO7vc++7dy6Gv6G
 1LOw==
X-Gm-Message-State: AOJu0YzARVyqsoGUm10VXohR6aEv91lq3Y07Cu4HiVohIMmNqCfxCeEw
 /vpH8XRC0uRiuKP+U+sn35LsQk/4xfim04lw19/N3idMmOTCDd+4ofhnoOwgTJ5QRoN3cMS4hse
 aKZhXJbA=
X-Gm-Gg: AY/fxX6q1WF0Ma6dFpdrRKlZov43Ps0vWNwYEcPPBb1oVfhbND5Vhatsu8GiR6S95u3
 BbTNozL+8FmyijUO6AN/3TtVCei/xjj884VYgM0Xo+3LH7KDvDSgKRXzz3RbOhkcsGweJZ4/kxC
 6S7NGb7OFFsgvPFzrh/1OClNfh1VUJefsDrBOFzy4PUmGu2Z+z2U83yCflsftCjpTEAi9ucLSOT
 wHLrje3p5l45rzZemnpPZiPGeZhTesKEiJmQhR4EDZbEhROlDQs/8+ZXx689NAZUD66/6rl69dx
 gJftzfhJPUXL1PJrkP0tzv/8v2Dv64kuPqnhJHDQzZiHS1NMSzrC45FTzQQAOALTD9QPvHTJmWf
 2dEsAtqvquHygqg1oSEmrUDCfk2qTeudbWFG2/YQURZn5hDMBuOwSUaPpA/65OfbXEVADhNQ3IY
 7wNIoyt+MRlY1WaDoottF1hMy/IK0gAA==
X-Google-Smtp-Source: AGHT+IEbAaCsu0/IwMZ7+h540uBODo0mrx/hQIyFmsKGceWsPX8gfsuoIe2tFSrUuVxmT4D7rWoZWA==
X-Received: by 2002:a05:6a20:7346:b0:32d:b925:4a8 with SMTP id
 adf61e73a8af0-376a75e7805mr440781637.3.1766084451314; 
 Thu, 18 Dec 2025 11:00:51 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e9223aab0sm184110a91.13.2025.12.18.11.00.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 11:00:50 -0800 (PST)
Message-ID: <986dcd82-c915-460c-a91d-5d466e5e1af1@linaro.org>
Date: Fri, 19 Dec 2025 06:00:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/char/pl011: Mark implementation as being
 little-endian
To: qemu-devel@nongnu.org
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218181812.58363-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/19/25 05:18, Philippe Mathieu-Daudé wrote:
> The PL011 component is only built / used by ARM targets, which
> are only built in little endianness. Thus we only ever built
> as little endian, never testing the big-endian possibility of
> the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
> the little endian variant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/pl011.c                  | 2 +-
>   rust/hw/char/pl011/src/device.rs | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 01335d9437d..97cd9bd4c54 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -538,7 +538,7 @@ static void pl011_clock_update(void *opaque, ClockEvent event)
>   static const MemoryRegionOps pl011_ops = {
>       .read = pl011_read,
>       .write = pl011_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl.min_access_size = 4,
>       .impl.max_access_size = 4,
>   };
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 04155dabe1a..a6227a99f30 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -495,7 +495,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
>           static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
>               .read(&PL011State::read)
>               .write(&PL011State::write)
> -            .native_endian()
> +            .little_endian()
>               .impl_sizes(4, 4)
>               .build();
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

