Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CECCFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmVf-0006fz-Ft; Tue, 25 Nov 2025 01:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmVe-0006es-15
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:26:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmVc-0003y7-17
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:26:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so35809665e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051998; x=1764656798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APxK6V4RprR6Lw9uWClMKRx5CVH63J3Yv9jjTkdt3cc=;
 b=SjRU8N5Q7WWfi/+N0SqLQ06Mm7hOnMfqZvxu/IvpaneDGUd9jDaciYrgc4qBPhH/Po
 UekQ+B0krdSg5F/8k22gA33TkOh2x+co+a+Q/XHw0YcdK1kbmFLyikd6qJbwSrOEw9L9
 LES8Bz0WnWL6S7VXlIK7v0ekOHyown30hr/pTisDNIEWETR/uGfyL5uE3CP5xa1ufs4/
 653eJH/yihm/knKE8nRSIGnGOlI5GHh0nmrLZW2XHORAaEsPg55hbQmKGls/d55aI347
 dG6N9a8cClCKHqUInRDZ3ITGVk19aemE5W7rA0ZlihGqs42Ehdi98zHL/nC3/4jQhtz8
 KWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051998; x=1764656798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APxK6V4RprR6Lw9uWClMKRx5CVH63J3Yv9jjTkdt3cc=;
 b=C7twNgvjUKDijgxJPQelyjDnLC+siLxwRSNu2vjVVR3xoNf+Fp0VsPr+bvBnmYC2uR
 r5ljeCtirGMdpebzZXdhFdyreEBHVxnlzDBaAw1dpR+HOGvivKaDYnE6o3CJ4+0EVp1H
 KaHSezneFumLU9jr+5Li8ojIXwal7fWSxvQ4qlXfqCQ3zL1P2ZSglne8teHkWujATaql
 up0DFQHHXBtJvro5h/n2CUNFTHwFwpq4MSNug3d3zlvPnHMD3aiFGj37uAjEeBeLJwpx
 wHQps++eBKdfqdldVYb4pYkRaRMYKbB0GxXUJQeZGq/Lr4ucPxlv8btg+PeggWl5vgeu
 M4Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXduKj7OH3mkNqFNi9uDv41WqNXGoqBLN8viHzBVdtOPUNz86QsZBguZOrwdwu2Pjx5YJDJM4+DFvEQ@nongnu.org
X-Gm-Message-State: AOJu0YxbXy8T1ihg4jNQQSizPbvdD3BuzlA1MONhDg0oTmH6ZBDePIh2
 EsyGDHrcKDxb9uuvzJY5AXdebkum3HXdWaRaTCMOt/RvZ8jrvRJ00rKtm7MhfgvYhu0=
X-Gm-Gg: ASbGncvyV9mh5Vry/LyHTKGC/yaZJIb/QVk/T26w2wjg9UTY/0UM0zT2OQvimv4pe1T
 L56E54fOhsSPo4uI8i2S47VGMjkPIvVb9P7WzY8p/93oTSUeWKTrwmV/xxt+EUuiVFSNaJWHofs
 ha8dUI1SIENimDNS2uzGweGfG7hOBayfE9298vTKYuUpdRPUI2Ug31oaMWyxS8LeoDZ2Hsv12V7
 LzTa8M4BUJuhdu7/+5Ln5byz8ro3B0ZQb94Ej1D8HlsU8rLpN1811cYQAsljx0UKF7kSDUnXv6F
 vxEhPUR14PYw+2Z1Ae/xD8pw1Qu0lzEZAYcCcVMUR65f35AwsqH7hTIwYUrAYXyWeV1dWz76doB
 cnjrFrRjJywKfFQpCxX440fLrVc7ha5tH4R9i8yD5bS23iRzBpSt0Y8ByJhKVXUEevN2fM9W5Ha
 biFEyXXuf8FXme2zhEmVEIir+iiZ8rzwSX118LI034YgxjH1TemnuXPTo2AtujcMK8
X-Google-Smtp-Source: AGHT+IE/b7GlJj4PfRlUYagZUJTeq4oci1zgF2+JDjZVZttCeQP0ylvaFMRgw0kOfVCC3zd5Nkb1mA==
X-Received: by 2002:a05:600c:3152:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47904b24282mr11376395e9.29.1764051998071; 
 Mon, 24 Nov 2025 22:26:38 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8c47sm33671034f8f.38.2025.11.24.22.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:26:37 -0800 (PST)
Message-ID: <38cd6f40-2653-4510-a020-76da960c44d2@linaro.org>
Date: Tue, 25 Nov 2025 07:26:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: Improve assert in replay_char_read_all_load()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20251124173407.50124-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251124173407.50124-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 24/11/25 18:34, Peter Maydell wrote:
> In replay_char_read_all_load() we get a buffer and size from the
> replay log.  We know the size has to fit an int because of how we
> write the log.  However the way we assert this is wrong: we cast the
> size_t from replay_get_array() to an int and then check that it is
> non-negative.  This misses cases where an over-large size is
> truncated into a positive value by the cast.
> 
> Replace the assertion with checking that the size is in-range
> before doing the cast.
> 
> Coverity complained about the possible overflow: CID 1643440.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   replay/replay-char.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


