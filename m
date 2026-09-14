Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32954C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6BAf-0004io-D2; Mon, 14 Sep 2026 14:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6BAd-0004hp-Gk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:12:47 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6BAb-0004DV-9l
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:12:46 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so1765730a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789409564; x=1790014364; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QuUBr9zdM4htmzHHhtIWkMLhsZadnXhHa5dce6S/0a4=;
 b=T54gGVfwhcVO2bNnKbamuNjjypkwgc3LtAkaeVEWaOMkEVT1VVsGVQWsl1KgWxM5ia
 kiJsbKsqZwAzbVIY8a/VvohmMcFDPSJwsvXmBVaA+wL1f8LUgJL3l8ZEDuI+8G2fd+B9
 R646yd8id9Nx9S239DFeJRJwJXVMR4gmP1hYoHSg6O0pZlgzxfJqZqBlxEQGnAKlTnUj
 tqX/spyPb0QFGfFwFcWrBq2Sq0Ji8Qaiy8KcKxt6W+s7choIVa9JcdDW+4pvNFQDVpLQ
 3UqAmfO3+Bca7lwhlfw/Cm5pGZwST8rzO3rty+p7tGXCuVNBy6NBFV+PBRXvQhRSrZpV
 Fc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789409564; x=1790014364;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QuUBr9zdM4htmzHHhtIWkMLhsZadnXhHa5dce6S/0a4=;
 b=PtJdaFuMonI8MFuhAsjv3xdvBRkU/MOjSAaOKyGG13GJVlCfjr/P2SAB6PoTOgE5cM
 w1hmz9K3wScIhz4SkvfHbLNhn1ZqvEzKAJn3IG7SVXN9erDtkAGB3L85SZvXrEXwCa+Z
 4qMG19VmkoO97+HzOpuTJvVkZRvbW5R1pdW/k3cSuQ3Z9US94+AM7/vNpJL/QX29Teaw
 +Wec/aLvqqrF+qBwJhGGc3Oo/RhuaXAC3QW/ceid4uzJyY+CDL1c3ZOa0MwuqxEKiFQf
 grGnRaWo8EwuGYoeASnsVjWbxUr/UFzoCOxcZIj/QufzxJ0PRlQLGKL2OD6m/6oLhYsC
 wLQA==
X-Gm-Message-State: AFuF++kUKZMu/BbeVFylcpZKbFdCl5d1QuuYzGjwsWEZrRUkRHLy8MAD
 C/uc+9OKKhWPTJ7k6dJBDhJrTmEhAbreypLCkhqraaYiu/BD7h22ihigqOprLbGZ6V4=
X-Gm-Gg: AYBFou1JljmPDMktUNg0lenWIm3T0gVryK8unLBZT09d+r7GxnMjyyZZL31d0jrPr+7
 Cvd1cslbeYIgko2L8vmv/cVGoZbCOJFDXSxhb3p9DyW+0pkTbEbBAngZ5S9pqNmNnHQRSiTuAAO
 k8J80PcmCWgHQVSdMULIoagAiMtuuUwzrgoYbk1X1KbebTCbs0619ioddCIjTd+roTW0qOYDS9k
 YZE6rjraDRpS+rIGqJzJzmG/bABLuMwfHslaCYj86WAxbxQHOwofKeqChvM3y6iVWJNov8fbEWF
 WaAr2NaYmzl44hwQfn2pe6aNXhsA3CwC7k/Ksxq/pn6Dw7YvF+WzG51kWLN2wrrC0O+IyfL1ydd
 xazCRSTL9FUgsg3WaKs/RnhZCVmMaiUJLH1H5hN9ZRf4KQ2qBz+QtXnsEaKzd/3YaQ710yEAy6v
 gzDrhVz80Mgkj+EYXmb/t3CEGJIyoGDT94iiX7nArMAmoX+rNZ57cHAvfCt0jYvN+vjEF6cQxcW
 pDVctkfNREwLoE6CSeG5FOY7ljF/5fAlBE6Q8mEJJwOfYH/XZXDhZcrl8ugpQ==
X-Received: by 2002:a17:90b:4f45:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39debf6f167mr6970370a91.3.1789409563549; 
 Mon, 14 Sep 2026 11:12:43 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33be20c67b7sm1000162eec.15.2026.09.14.11.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:12:42 -0700 (PDT)
Message-ID: <72dd2ada-3b4d-4563-860a-86bf6c6a8a90@linaro.org>
Date: Mon, 14 Sep 2026 08:12:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
 <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
 <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/14/26 07:51, Peter Maydell wrote:
> On Mon, 14 Sept 2026 at 18:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 9/13/26 23:16, Peter Maydell wrote:
>>> On Thu, 6 Aug 2026 at 18:32, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
>>>> within the range which are not explicitly listed.  Previously we chose
>>>> not to honor the TID3 bit.
>>>>
>>>> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
>>>> on these registers, so we might as well honor HCR_EL2.TID3 too.
>>>
>>> I thought we agreed not to change the behaviour here? Is this
>>> just a "forgot to update commit message" thing?
>> Oh, yes.  Because I did update the code to test for v8 in translate.c.
> 
> So what does this patch do? Is it just a no-behaviour-change
> refactor so we have a place to add the SCR_EL3.TID3 check
> in the following patch ?
It does what it says on the tin -- it honors HCR_EL2.TID3 for undefined 
registers.  We currently only do this via access_tid3 for defined registers.

The comment from v1 was about changing the behaviour of Armv7, which is 
addressed in v2 by testing for Armv8:

> +        /*
> +         * With v8, we have the possibility of FEAT_FGT which requires
> +         * trapping with HCR/HCR_EL2.TID3.  Without FEAT_FGT, it is
> +         * IMPLEMENTATION DEFINED whether TID3 affects IDs in the range
> +         * that weren't explcitly listed.  We choose to trap.
> +         *
> +         * With v7, there is vague language about "not required" to trap:
> +         * see access_v7a_tid3.  We choose to not trap.
> +         */
> +        if (arm_dc_feature(s, ARM_FEATURE_V8)

etc.


r~

