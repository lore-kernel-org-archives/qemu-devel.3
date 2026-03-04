Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136DAEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfiN-00083a-1E; Wed, 04 Mar 2026 01:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfiF-00082P-8s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:28:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfiB-0004pJ-CR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:28:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439c5cce2c6so513215f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772605677; x=1773210477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kAWksY/LVxWrBjbU0RjgGw+Ixo7H3jy7Zvw2rKHIsFk=;
 b=jzxF59wIS5rtTn4uF/gQKgmoLXl3bDVRMDXlaS/gpaAjtRqPEvKYIA4LlkGJa/tyXF
 U+a9e9JbQ3BmLkstSNV/J1q4lAJ5wWKn/3sudODnHTYEDPfVv/woIhrc4T2xdwn+bATe
 2ZbISxbJsOde5qzBgh5DmQhZcKAD/hGGYarLezGf0qwB4fZt946AChftsMigLVQMCWUS
 qmdksKrEL4IT9dKDLrH5ACqVww/drRPtm16xgXfV0H3TciMe6i9AZ/h8dU/aSvPwBsnv
 HiLa1WlODnuPjrj5tUS3ClQsCJe93AnoXiadMY3r56ZzSNZ72ZkQagBy0oz7lwCYzOj0
 +2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772605677; x=1773210477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAWksY/LVxWrBjbU0RjgGw+Ixo7H3jy7Zvw2rKHIsFk=;
 b=boa14MDC2Qc8IWR0rb55Rix6yoD6OUKwcAY6UkMlC+tzqEespCAmCcB8ySvm/QHT0Y
 iRADlr8lh9MBSnoXJsL/Er65IS2GICZDZ8mhtMH6rAgmKFcyT5aTCsCQ4boWgkQKRcV2
 Ioc5Cycu4PNgd4gTwW2C99nj4qgC72tqVVViL3nilPaRIo/ocrejR+hMRmNJEtzsKxJA
 olyQ81JzPgRDA6eFsVtISl9FJjYzDn7kxugCNHbomNXTsbYIiKWvM+bAQbBSEri+c1gU
 bY9XZnFUtqZo4dYOksCZAIcclcgkHEuEKkP9CR51OqMxvD+WDehseCRJWSomq2n2P6gF
 kY0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwNaXtqVGKKdQlEC+wI2jUtd/U9Pl5WmJMAJksY9Mbawe3ak9MzgxDSpJqMVUu6+O3W99r2cQ1J+/m@nongnu.org
X-Gm-Message-State: AOJu0YxJ6GNJdTEv+b3Diyu5QWqhXgSf8p3aiLnVlRlW/s0GNBEKZZdZ
 zfkK0xeJdB5e+Gdh/itNUtiyTK0L91oHZ/oB4DYVm9SP965M3zrILX1PF6xbOGcvDsg=
X-Gm-Gg: ATEYQzwKFcVb22C3L+yYMXxjqCB5WmQAKd5b3Fa4pQWSRqcHhhvVsuUh9teJr6++Wt1
 YJJ74/fCJFImwIhaGv5NUAspvGzA1XxlTpCtJi0BjykJTMh8Cpao5bMax2OJgCdkVCpTJQKxb5s
 Cm01kSXs5TMVBjiZ0f83NSAZKCzXIEZATdA73rOFEMgNhki23J6Ae6KOL+epgd5PeZcUszKcAi4
 YwTtEpQKxZbKV1cnbra85TC4Wqhf0LUNdewYdaLwSlSCzqkDUUP5Q8MQbrodBZp1726H84gfL8r
 WkYCF3nTwWMvvaVo12IjtpXJgo8TQq/ynUrO7eq5Mf0kLHBC/L9cseNJ09rpMAc3xaq1NzllJ1u
 z739Gen+x0Pc9LjP6tRItYwqy/2Y2QYo26XS8ps+bZnyzc9oANbAkOc6HVCmpZtX5uySh9+dbIl
 lXxRDVwQzeCiCRx5qx73gFhvyXfe9hxQ2U7pckESez9PcT578ag6JrAu+Zw/mA0CXPhQ==
X-Received: by 2002:a05:6000:3110:b0:439:c1f4:302a with SMTP id
 ffacd0b85a97d-439c7f64ee3mr1623479f8f.11.1772605676767; 
 Tue, 03 Mar 2026 22:27:56 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm25898682f8f.35.2026.03.03.22.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 22:27:55 -0800 (PST)
Message-ID: <fb933416-cef9-43a0-806d-16ea4957a2f6@linaro.org>
Date: Wed, 4 Mar 2026 07:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] stubs: Merge physmem.c within ram-block.c
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-2-philmd@linaro.org>
 <8a2872f3-dfbb-3fed-dd95-3cd474e3ca2b@eik.bme.hu>
 <82dfe6e2-22c1-4df1-9e49-a2c7a2970082@rsg.ci.i.u-tokyo.ac.jp>
 <ef6b34f6-7e72-4aea-9436-c2bda69c2c0e@linaro.org>
 <1dfb1673-082e-2748-9887-bb7efd2df4f4@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1dfb1673-082e-2748-9887-bb7efd2df4f4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/3/26 18:20, BALATON Zoltan wrote:
> On Tue, 3 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 2/3/26 07:21, Akihiko Odaki wrote:
>>> On 2026/02/27 7:22, BALATON Zoltan wrote:
>>>> On Thu, 26 Feb 2026, Philippe Mathieu-Daudé wrote:
>>>>> physmem.c defines 2 stubs which are related to ram-block:
>>>>> qemu_ram_block_from_host() and qemu_ram_get_fd().
>>>>> Move them with the other ram-block stubs.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> stubs/physmem.c   | 13 -------------
>>>>> stubs/ram-block.c | 11 +++++++++++
>>>>
>>>> Maybe should be the other way around moving what's in subs/ram- 
>>>> block.c to stubs/physmem.c considering the the functions these stub 
>>>> out are in system/physmem.c and there's no system/ram-block.c.
>>
>> Fine, I'll drop this patch if you think it is not worthwhile.
> 
> I did not say that, only that the functions are in system/physmem.c so 
> why not put the stubs in stubs/physmem.c to match? Since there's no 
> system/ram-block.c I think it makes more sense to merge these into 
> stubs/physmem.c instead.

Unfortunately I won't have time to address this change before
soft-freeze, do you mind posting the patch?

Thanks for your review and help here,

Phil.

> But just leaving it as it is is also OK.
> 
> Regards,
> BALATON Zoltan


