Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469AC07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvtj-00052p-NV; Mon, 22 Apr 2024 11:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvtc-000517-7r
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:47:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryvtY-0006jc-2m
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:47:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6eff2be3b33so4418636b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713800869; x=1714405669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O+yWL8SVGKNXZnGRY2ne6v7vOdjrRusxiK4JE5IRxDs=;
 b=e53jRAtF8lQBmYYQRvir7DrkHk5R1P7C6jlKaF++gGDuywMk7snN73i6mSpN1TQBR7
 jmjKljGR/dj6GlMYSu3SnweKNdnE/P1M5d60Q7xsQqO+V7N/4IyIDEcWQVEaNlwlOBjY
 QmwBKojkKQyqYH+h2Zben8CjKmpqNf0MohtfZ3HzpIGzdZ0rLLpcS8YYDKGiFcxPfuWd
 AicLXuIsuTQmQM1oYB5r3rsW8tiYnr9xlNAoOgvcSQZSgbwaLwawvppm0Zrdjbv/V4f+
 5KP1lkswzKfm+12hfw4ZcAoGjPo8qmS+t1O36p1CVQlbPp5OfGmkCSNdg6kqm0eHWlqv
 su0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713800869; x=1714405669;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+yWL8SVGKNXZnGRY2ne6v7vOdjrRusxiK4JE5IRxDs=;
 b=NNeSw9wUSiTIYm6sWU9uxAJ31J6D2SZGSSyfsAQHS92Kfshr7GbQkkvrNkr1ES/ViS
 BB19qZlyt3+qPOrzFlzr/OpDWKn5cPZL566zeTbYL5/+8OjygjqEUragbNlTQtcG1M0H
 6iL7DOJ5A1MHIC70jbpVc2zAsXy01qQv1MIacOVrT6JcD/qg1JCgTf2hQ8p9UDJI5PgW
 Ug6ZwL3sMj0/P37/lIo+KV02KYMIjj+BVf57rlEVUtgHo6N8fc6yYxsSUsOcKFP2FSt9
 O89BENsjMKutGkhYpRbRTjaFXwrLOiLDz9qkLKisJHYzvNXdEr5qj+a/RzpHG92osGQS
 UT7w==
X-Gm-Message-State: AOJu0Yw6agj9AVyMcbDUtmOEiay4iEcH9KGUyqJM48RG9uzNscu6/Tgb
 igfB5/8hnFzk34vMte655SCp8koMEuxEW13BWZjCALVB9gJP8m+Ag6AyiRR1p64=
X-Google-Smtp-Source: AGHT+IHaDf/sojdO7wYw+ue7wmGYD9VUawRAHcqfsDdgrlQypiWoNCfwNJXWWOp/TfCRwyIPF2h+Dg==
X-Received: by 2002:a17:903:1210:b0:1e4:9ad5:7537 with SMTP id
 l16-20020a170903121000b001e49ad57537mr13179637plh.34.1713800869025; 
 Mon, 22 Apr 2024 08:47:49 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a1709027ec200b001e0e5722788sm8454839plb.17.2024.04.22.08.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 08:47:48 -0700 (PDT)
Message-ID: <1e4cd671-45fe-4a97-8f76-5bbb07a84c15@linaro.org>
Date: Mon, 22 Apr 2024 08:47:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] target/arm: Do memory type alignment check when
 translation disabled
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Idan Horowitz <idan.horowitz@gmail.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, ardb@kernel.org
References: <20240301204110.656742-1-richard.henderson@linaro.org>
 <20240301204110.656742-6-richard.henderson@linaro.org>
 <CAJ307Egu6951WwbdoTERUVff9cr=2qBK70FWgk3Ck-1DCpDtHA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJ307Egu6951WwbdoTERUVff9cr=2qBK70FWgk3Ck-1DCpDtHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/22/24 08:26, Clément Chigot wrote:
> Hi Richard,
> 
> While testing the future V9, I've some regressions on a custom board
> using cortex-R5 CPUs.
> Unaligned data accesses are no longer allowed because of that patch.
> 
> I've dug into the various documentation and it seems that R-profile
> CPUs don't have the same default memory type as A-profile. It depends
> on a default memory map provided in the R-Profile RM in C1.3 [1], even
> when PMU is disabled.
> 
>> Each PMSAv8-32 MPU has an associated default memory map which is used when the MPU is not enabled.
>> ...
>> Table C1-4 and Table C1-5 describe the default memory map defined for the EL1 MPU.
> 
> For our case, Table C1-5 can be simplified as:
>   |  0x00000000 – 0x7FFFFFFF Normal
>   |  0x80000000 – 0xBFFFFFFF Device-nGnRE
>   |  0xC0000000 – 0xFFFFFFFF Device-nGnRnE
> 
> Therefore, we can't blindly enable strict alignment checking solely on
> SCTLR bits. We should make it depend on the address targeted. But is
> it possible to know that address in `aprofile_require_alignment` ?
> with `mmu_idx` ?

No, this would need to be handled in get_phys_addr_disabled.

> By the way, are R-Profile CPUs the same as those having the `PMSA`
> feature ? That could mean we can use the `ARM_FEATURE_PMSA` to deal
> with that, instead of create a new `ARM_FEATURE_R`

No, some armv5 have PMSA.

> 
> Note that the RM I've linked is for ARMv8. But this other link [2]
> seems to show a similar behavior for arm-v7.
> 
> cc Jonathan and Ard, though not sure this is the same bug you've
> reported earlier.
> 
> Thanks,
> Clément
> [1] https://developer.arm.com/documentation/ddi0568/a-c/?lang=en
> [2] https://developer.arm.com/documentation/ddi0406/cb/System-Level-Architecture/Protected-Memory-System-Architecture--PMSA-/About-the-PMSA/Enabling-and-disabling-the-MPU?lang=en#BEIJEFCJ

Ouch, thanks for the armv7 link.  At the moment it looks like my blanket mmu-disabled 
change should be restricted to armv8.


r~

