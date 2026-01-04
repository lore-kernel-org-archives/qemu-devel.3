Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6581C2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 15:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcPlT-0002OL-BV; Sun, 04 Jan 2026 10:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcPlR-0002NY-F9
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 10:11:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vcPlP-0000La-Qu
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 10:11:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso119572555e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767539486; x=1768144286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oDk9/LzkEZVT4JGdub3WDo1knrTMsltMwSFKHHXT880=;
 b=Nz1N3Lr6y7cTJOu8ZuQtdx+UhDBjTVj+z8pLqWrXzIg+8K4Bowkfseu0APfIT7TGOs
 fN9C9ToHf7CPm2Eh8ay7oXzrcK8naMlEQMgazYj/pYuL1Au7xN+ehAwdCs9VTqTHVa/H
 SL9WijKRBWg+fwz9qlvgphkqjDuUIpXNd4xATJU2pnowgcGRZZG6X31XlmuawkC+bs3T
 lU2SnzrnxE7wZO9ykvU4B0gU8nJODF8p1y/8M1cQohcSPnMktfiH/7QB0Zf0dfFb2PkX
 6ZXpXxVvwRK+Y1hi31QTijn/uTVXqdrEXT9rSMdpHDMq9elwRF6FBAfXDWBQwPfe69u1
 Hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767539486; x=1768144286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDk9/LzkEZVT4JGdub3WDo1knrTMsltMwSFKHHXT880=;
 b=TZpt53cqDRdAJ/0pjDGjeiJKUbl9M8FVwZpWVaKDR6pR6zfsQXVYObVLArLZ9e4Tyv
 K6fk0/QSiEhMTg91oPwUW1M5i7VBZYyj4txnxb3+zGcxwQflVbG46j3TKh2GhDZMTjsV
 AoB6BGM23BPAcdDYEfpstQsY4K1VY8IGT14T6fr12aYZKziT0Jwh5KVcRMuyD410CI7u
 Adg1sd/Fh2CjyTcSkVKj29gtwAyIzBpFfIV/+7+ujxj/08KgOMq44+27ySsEV6mmOUke
 4toXc2gD24dLR8r979cXxJMJc+9zsc+f+OGAdWr1MxNi8OOq0j1Z7L+2Av1n6u6Y/HTP
 f79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXLiAsn9SArzJGFtEJp3GE2uUHXDgzu85LfHWh/2rKVA78sFjejXLUNWxrB0p2wC4OD6CL+0+PE9hG@nongnu.org
X-Gm-Message-State: AOJu0YzK4DRW95+KarXCejDJslt1++yRJf48JBo9K8OsheWZXxt/Mgix
 nspwXeEIY4hZXKfYvx44XTWgO/7DowmM33JhSXAudHxUoFTN6/Bhq57bQFuKnWR2IX4=
X-Gm-Gg: AY/fxX5ckmRRxhtlvtD1yPERL6QhL7fyWNUWB6gmICnlxywDRDnKlnXcsl16HWZon1q
 LmBFQ8CHJXGxzbr9b68E9UAtIm+TDpsSycLqauV/ced1u4JlErwmZsEDppTBQXGFskyDEDY3Ip2
 dWji2zo2p7o9oJwZKDjJcD+39A2vEUGOt8DKaY0i2yqmksEf/mYKSP1vlugNHdhRFSdMHxuGdho
 l6w9g+jnMVwYZ+/1y4gC9DelhF8JS9jF8gWS1WxeXy83opnnrvHhV8j8azn9QLJcp/bGd9Tk/G8
 TXfknFyjeMyaxeSd+Eal23YIaaXfBC/Li/oG8Eoi4JorIocWLeNLZteoKvWYOVthPVKRqF3ndD3
 uL3945DQn7t0aCy23lQeDIWQGW5qjB0A+Duo/TmuuFTjUQHqMGHXx1+g/B32g+PDhQ4VV7Yp3+T
 vBwczq7+wEIGsPa7eucgital2BILBFQWIFdQOcB8JqM69kEGSg++KC2w==
X-Google-Smtp-Source: AGHT+IH5p47OUA/W+tYGpggdcjtTC/Flbl267HOsBwxkm+jJW44lwDn5K5TuWVUK2g4bCSh+sbt15A==
X-Received: by 2002:a05:600c:4fc6:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-47d1955b35fmr508711445e9.8.1767539486089; 
 Sun, 04 Jan 2026 07:11:26 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d34500fsm99214845e9.15.2026.01.04.07.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 07:11:25 -0800 (PST)
Message-ID: <05847b10-91ee-4def-83e7-0e0cb50da585@linaro.org>
Date: Sun, 4 Jan 2026 16:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/loongarch: Add some CPUCFG bits with host
 CPU model
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260104022905.2120787-1-maobibo@loongson.cn>
 <20260104022905.2120787-5-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260104022905.2120787-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

On 4/1/26 03:29, Bibo Mao wrote:
> Some CPUCFG capability bits depend on KVM host hypervsior and they
> are detected on QEMU. However some CPUCFG bits are irrelative with
> hypervsior, here these bits are checked from host machine and set
> for VM with host CPU model.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 27 ++++++++++++++++++++++++++-
>   target/loongarch/cpu.h |  8 ++++++++
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index f9255c4f84..b87819c8e0 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -503,7 +503,7 @@ static uint32_t get_host_cpucfg(int number)
>   
>   static void loongarch_host_initfn(Object *obj)
>   {
> -    uint32_t data;
> +    uint32_t data, cpucfg, field;
>       uint64_t cpuid;
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   
> @@ -513,6 +513,31 @@ static void loongarch_host_initfn(Object *obj)
>           cpu->env.cpucfg[0] = data;
>       }
>   
> +    /* Set cpucfg bits irrelative with KVM hypervisor */

What do you mean by "irrelative"?


