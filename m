Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F1FCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlZU-0004HY-4j; Fri, 04 Oct 2024 12:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlZJ-0004Fm-9T
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:54:17 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlZG-00006H-8R
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:54:16 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53994aadb66so2303862e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728060852; x=1728665652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lGP2A9bmBuTl2RGS3b0YCDGhmzpnLRee3j4uNqnE5zU=;
 b=iovZfX1XKL9iQjV5ywXA2Kbu+DyF4Z11a+ESLLv+DyClwKoKafcO0IOO3UO21vVqeO
 VqUOyO2ApFEgdVShBQtL/nLocrs2kJIYUdSWCj8BYWyWz1YUWVHP1DGPpclc4K/UCILv
 FMoV9RSZEmFavSTF2fFgxxqdcymbHyPkWBZusqWgVDkx9mCemY/YkZPzy5tGBAmvlKbR
 W39ScEs9OTl7PYiybrip1USUKnZ1vnDEZW+bx8+3IKg2lan8zrw1Wcdg+dKE4qZZgXg3
 QiSy62+IPNMoyM7dWAU9MWc0/gwNCtNztvCoiSkTng2dmhQDTVyAVH4pDArHncrhnCwY
 ZAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728060852; x=1728665652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lGP2A9bmBuTl2RGS3b0YCDGhmzpnLRee3j4uNqnE5zU=;
 b=hX3L9MXJl10BjUpWuIw+dFSsH7LNDS5kcjpj/1G0HjKD29jLyLmeYLxGXMJGCoUYq4
 KkMeu5Y3GWdYVU55cv88EKVdE4xY29t7yXYM24nxJs8HDulMlDwU9NgzIeRgWHLqhp8o
 z4kF52nIj++hwiQjDYXJKT5cjGBB1IplBCvWVeqayOfRkxHLJFHvpX14OShL6AMMiVXh
 UJbrgzEM40wETy9SnKWxMRrIUWKSC/tADdOThXTLH7YiIuYvFuDiJmTQgP8K5B0TQVY8
 oa3UER9Ep73yqYYZt9igK20fa/R1ZvjFqdCCG+3JtBLl7hoJaFWxDFzxiWxQz/Tbo/xL
 e/AA==
X-Gm-Message-State: AOJu0Yy/lKQWvMMTOG/2bZzURu+4nvge7+7glFUhNpm/F/jtxtAq5WFU
 EqS9864mkpUealbyWkcUD2973QrLO8MNtu0VS3PH6XTyI1m+aM1agBvbF5pNOBE=
X-Google-Smtp-Source: AGHT+IHvNeUnjIHhuMKK5Vkyccy2qOIa1LcIM2w3uJvCeHCrnJiBft/R2lzx1dsNADM3SFHnSZ/5oA==
X-Received: by 2002:ac2:4c47:0:b0:539:8b49:8929 with SMTP id
 2adb3069b0e04-539ab858cc6mr1980046e87.21.1728060852085; 
 Fri, 04 Oct 2024 09:54:12 -0700 (PDT)
Received: from [192.168.132.175] ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff2835csm5200e87.275.2024.10.04.09.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 09:54:10 -0700 (PDT)
Message-ID: <bf1c2206-ef63-4dd3-8a15-0323dfa9509c@linaro.org>
Date: Fri, 4 Oct 2024 13:53:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/core/cpu: Introduce CPUClass::is_big_endian()
 handler
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241004162118.84570-1-philmd@linaro.org>
 <20241004162118.84570-3-philmd@linaro.org>
 <CAFEAcA_X38bhELuwwKLPrbfC+vLnwpUHP5RNCDv1V2r69dbJ7w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_X38bhELuwwKLPrbfC+vLnwpUHP5RNCDv1V2r69dbJ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/24 18:41, Peter Maydell wrote:
> On Fri, 4 Oct 2024 at 17:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Introduce the CPUClass::is_big_endian() handler and its
>> common default.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/core/cpu.h | 3 ++-
>>   hw/core/cpu-common.c  | 7 +++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 04e9ad49968..22ef7a44e86 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -150,6 +150,7 @@ struct CPUClass {
>>       ObjectClass *(*class_by_name)(const char *cpu_model);
>>       void (*parse_features)(const char *typename, char *str, Error **errp);
>>
>> +    bool (*is_big_endian)(CPUState *cpu);
>>       bool (*has_work)(CPUState *cpu);
>>       int (*mmu_index)(CPUState *cpu, bool ifetch);
>>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> 
> What does this actually mean, though? Arm for instance
> has multiple different kinds of "big-endian" depending
> on the CPU: both BE32 and BE8, and data-endianness not
> necessarily being the same as instruction-endianness.

This is to be used in the data bus (I was wondering whether using 'data'
in the method name).

> This series doesn't introduce any users of this new API.
> It's hard to say without seeing what the intended use is,
> but I would expect that probably they would want to be testing
> something else, depending on what they're trying to do.

I'm trying to split my branch in "~20 patches series";
I should post example of API consumers in a few days.

First conversion is the cpu_in/out() API in system/ioport.c,
I'll try to post it ASAP so we can discuss there.

> It's pretty uncommon for anything out in the system to
> want to know what endianness a runtime-configurable CPU
> happens to be set to, because in real hardware a device
> has no way to tell. (This is why cpu_virtio_is_big_endian()
> is named the way it is -- to discourage anybody from trying
> to use it outside the virtio devices where we need it for
> legacy "the spec wasn't written thinking about endianness
> very hard" reasons.)

I'm trying to convert implicit knowledge of target endianness
to explicit one, propagated as argument from the machine.


