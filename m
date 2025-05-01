Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D743AC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZgn-0005BD-1d; Thu, 01 May 2025 15:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZgl-0005A6-NL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:35:19 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZgj-0001aB-Ub
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:35:19 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d93f4fe5baso4457305ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746128116; x=1746732916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doptPJHNTX3efdtdZHHQCZKFb5/ogmLoNZ91COmEnTY=;
 b=IK0gdLeSbluNJvmSvXiXpT1uG7BPPLpvnlu7FFsxwWXJskfBKBuS6cF0u0OQOLzTjz
 ru/GHEoY88BxoHTlPutGbDaDPIrb7PAnH+H3+kGjDbZlsi9HHW1ktBEB8ufDddXpAO+M
 ddcLqk92iZyd9pxa7XKsfmq6Zgqm9pLynARaQqrEsj5cTe/h/CrJJwyoxc9d6mNUq0V/
 DjXRwdIecvoDc34A1RE2N6d/DxLrXEYFadIGkSsdqrVR1e396PIMcNhMIs4wy6a58nbu
 Xcq53wgsMhTeZJ3Wu2A1lS9HyWr6kpxnnhCpbxbzwvpNoylp1u2S3Jd5X4PlDieT/wOa
 zKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746128116; x=1746732916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doptPJHNTX3efdtdZHHQCZKFb5/ogmLoNZ91COmEnTY=;
 b=fSWWXB3IJQwil179hTg/LxFu4SYhdCq2yUhX0AEVhM1BV8S3iJeHI1FtAHeaSDehS1
 c7o2YBceYimQqh8Rv8BbQaxwgcN3gy/9jhxnFN8vD2ncdmjbXtnqWqIUfMmAphPN/0Is
 rTgUi5+WJ5lT2QlCLK3ZyIeKvW/0OzKtPFi2CnltIqMAnKhlG+5+geN206efl32yDPE1
 uRNlraRc+wQOht3wrPmoPUYbJ5U14JOcorc9BELu3p/5XYfucGPBtKph5elxwgOyvif9
 6eoud69zgezFEs/3eXx2fDOVEBo+xrEyQKfkdEsEykc1v2l+8EwjtyZ+sTYCF3QDQTGw
 JAbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI1MtSnsb4Zm8UQxD0GG4DHECMZtDCWAjqzFPjrewV++i6oZLgfSXwjjM0CnX3G7r92+iwBhm11xo+@nongnu.org
X-Gm-Message-State: AOJu0YyOVhGWQwe8aFw/GpIoNSznpXiaYNXFkslBETx1TtJCG+CvRGJb
 JUn2NUoHyjFYGiMG5mhNarwg1qgCatDdiAOTCNF/CSYnmKc6Xj17WyfuHaGt0I0=
X-Gm-Gg: ASbGnctxipxcMK2lLFqgDwaJVV7YwtNW7Q5SlRZtrVgun4uRgkAtT+HTV2XnSJxk23e
 rojFEgzcT9epn5h3NQyhjELt+5I+7YKW2rbX41evkcL/S+yOmtf7hjMRsV9K29+sE9+U6oLE4og
 YqbmsK7Ke4HoYC7zNcbqmPIvaCVCQSw05OWwHGjGS+PM49+GfauY7ziOofSaw99S4S805WQFarU
 hP3W998nrAHyZqgZCZ9QdH9L9p5B30WgOXU1Cfgq8bzvm8qOuSbZw0XaWQTj4q57J0y+s0iDpsI
 iQxOKJueKSptDPB1QQSrHoOyAPzB4XSLmBeF9vSB8wtERO4Bz8WPeH0j67XaTtjD/3c/mbAH3xN
 PibLw1xVzmVS4mQ==
X-Google-Smtp-Source: AGHT+IEsLtLhUNgdAp+p0rJEpvTqY2CYZqSy/735WowJEunJNXpSHddb1hTwFvyRnYt3F+iH6gsyCw==
X-Received: by 2002:a05:6e02:1b03:b0:3d5:7f32:8d24 with SMTP id
 e9e14a558f8ab-3d97c2272c5mr2037515ab.15.1746128116614; 
 Thu, 01 May 2025 12:35:16 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa959f9sm9995173.130.2025.05.01.12.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:35:16 -0700 (PDT)
Message-ID: <21d32a4f-8954-4a36-ba0d-6cb7a50f242d@linaro.org>
Date: Thu, 1 May 2025 21:35:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/33] target/arm/ptw: replace target_ulong with
 uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-30-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-il1-x129.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d0a53d0987f..424d1b54275 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>       uint64_t ttbr;
>       hwaddr descaddr, indexmask, indexmask_grainsize;
>       uint32_t tableattrs;
> -    target_ulong page_size;
> +    uint64_t page_size;

Alternatively size_t.

>       uint64_t attrs;
>       int32_t stride;
>       int addrsize, inputsize, outputsize;
> @@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>        * validation to do here.
>        */
>       if (inputsize < addrsize) {
> -        target_ulong top_bits = sextract64(address, inputsize,
> +        uint64_t top_bits = sextract64(address, inputsize,
>                                              addrsize - inputsize);

Maybe use int64_t for signed? Anyway, pre-existing, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           if (-top_bits != param.select) {
>               /* The gap between the two regions is a Translation fault */


