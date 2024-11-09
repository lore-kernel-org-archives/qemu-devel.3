Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91415D5E379
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 18:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9psm-00062T-K5; Sat, 09 Nov 2024 13:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t9psk-000621-Oa
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 13:08:23 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t9psj-000170-1B
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 13:08:22 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso2564444b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731175699; x=1731780499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WVBtXow4KFxz+Lac3PbLQUrFNDArIauknCGxhDK6bI=;
 b=XhJ+g4fglLC5DSAU08a/PwBwhngTr5yeHDAotynZt652WnFTK9k0M7n/R0s8XwC+Fb
 FN7D/PZUF7MML0+3/8l9n/ZlsV55Muxkza9FIN2MmkNXR7OmjbGl7Wf5QVvGNZYYqvzs
 XNTUy107Y+zzmeQpmmR3kuMC3EnHNIJDweZF99Fd7fWCnRRMT9Z0eK0+3xi0vzxQxjaL
 bJKnjxWzHDDKYFo1PuYm/v9r1HUTNOJxzunPZTRX7zHQkAYmEMYxzn8+sHOpATzev73d
 BdZX14Xsf/7grCiNaDGJ6sHL3FKdEIoejW40GDRe7FFqGptNwxyyi2Ei5ikXvK5p6ElD
 YNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175699; x=1731780499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+WVBtXow4KFxz+Lac3PbLQUrFNDArIauknCGxhDK6bI=;
 b=nLyodu2KUIWHEFUZD9otvp216vKY6CSnMHzqxE9s1fiZWGoxjPPVUteMCXzExQnrXK
 Ky9gKVi5vmtH3lbcN3Ru1DjjDU2vmW86rbsqg9I4SdnnlKH1ddztEcbeOJ8cIa50zVW5
 6hAXiO0soh+F8cXIlC4CFoBQiOqc+TOWkZx/vwZIQNNHTO9dzBC2gmOcmD7grnyMACDy
 QG06oLyyw4v0CYtY+zUiUtXj/kczj0giPq3GQH90e8UgidvDBzJS7ydhfsWrQrBg8bGG
 BFN45Cd4iDWQbcIusrRdLYFivkmnDM3HZ5v4yyuqtMasNGBF5z1mSLJU/h3ZV7j5BEty
 thBQ==
X-Gm-Message-State: AOJu0YwyM/HUTX9B23/IaUnGnH1DX6jixW7rRmwztZDhq+XsIEsmXPtZ
 qvR+lOs3zrctUJYqvAQtzNy2S7TzthEsMirOQOudqkjGGXeQ20Q8txBOf//tI4M=
X-Google-Smtp-Source: AGHT+IH2Bz8Hj66mtrFfqxihISdZYeF2BiDJMc5D6MME510aUOIgwMHFagh2GxRdk/9016GvIt+qGg==
X-Received: by 2002:a05:6a00:2a0e:b0:71e:8023:c718 with SMTP id
 d2e1a72fcca58-7241328f296mr9932335b3a.8.1731175698980; 
 Sat, 09 Nov 2024 10:08:18 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078ad53asm5858090b3a.73.2024.11.09.10.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 10:08:18 -0800 (PST)
Message-ID: <dfccc639-8347-4e75-af08-cee7f8ae2bd9@linaro.org>
Date: Sat, 9 Nov 2024 10:08:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-5-philmd@linaro.org> <20241109074225.76e0e4ad@tpx1>
 <84046f49-a39f-4639-a383-fa3c4a97e17a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <84046f49-a39f-4639-a383-fa3c4a97e17a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 11/9/24 07:58, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 9/11/24 06:42, Thomas Huth wrote:
>> Am Wed,  6 Nov 2024 18:46:11 +0000
>> schrieb Philippe Mathieu-Daudé <philmd@linaro.org>:
>>
>>> These devices are only used by the OpenRISC target, which is
>>> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
>>> definition expand to DEVICE_BIG_ENDIAN (besides, the
>>> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
>>> using DEVICE_BIG_ENDIAN.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/openrisc/openrisc_sim.c | 2 +-
>>>   hw/openrisc/virt.c         | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
>>> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
>>> index 47d2c9bd3c..ede57fe391 100644
>>> --- a/hw/openrisc/virt.c
>>> +++ b/hw/openrisc/virt.c
>>> @@ -236,7 +236,7 @@ static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr 
>>> base,
>>>       qemu_irq serial_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
>>>       serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
>>> -                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
>>> +                   serial_hd(0), DEVICE_BIG_ENDIAN);
>>>       /* Add device tree node for serial. */
>>>       nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
>>
>> According to https://openrisc.io/or1k.html the openrisc CPU could be
>> implemented as little endian, too ... so would it make sense to use
>> a runtime detected value here instead?
> 
> While this patch is a code change, it aims to not introduce any
> functional change. We are not building (nor testing) these devices
> in a little endian configuration:
> 
> $ git grep -l TARGET_BIG_ENDIAN configs/targets/*softmmu*
> configs/targets/hppa-softmmu.mak
> configs/targets/m68k-softmmu.mak
> configs/targets/microblaze-softmmu.mak
> configs/targets/mips-softmmu.mak
> configs/targets/mips64-softmmu.mak
> configs/targets/or1k-softmmu.mak
>                  ^^^^

The openrisc little-endian control is in a control register: SR[LEE] (which we do not 
implement at present).

So any openrisc little-endian support would look like qemu-system-ppc64.  I would not 
expect devices to switch endianness at all.


r~

