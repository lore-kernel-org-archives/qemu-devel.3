Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0183FC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racez-0000Fo-Ki; Thu, 15 Feb 2024 09:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racex-0000FI-Lz
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:24:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racew-0000kY-2q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:24:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33cf7812777so509938f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708007056; x=1708611856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BbodEF5CfyfyezAUM7C9Pjfur1AbgmXuVllEdfGP3ws=;
 b=SgK8+o3KUApX4BRt2Yy8mkR1pAv71w734KI3+Ea0xuycxOzvh+M0GQ1/5QGDJORqMz
 ENFSGbZu5kv1vjmZyZTCjHNxAYcS7CBa67V1vkC+5PByl/5hbHY0QVDvF5WRJPuKZsGK
 HSrklV8Z+abloVTP3aYs6/xao1b3gmWqmgJxfzihb8nSMdtdwEsdufHMhxpccRnB5qB9
 Zae7rtkRYJssDXlVXh/6WVMaVwhFwHaVcabgjZaTsXPr7eYQJVczbCXxjAdQ8wDllxYs
 q2BB4BJkarCOs24Cjm6To3+A/TBv/HG/7bdgI7WJcrd6Wlf+BBT7lCrVtoy538aNXICo
 E2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708007056; x=1708611856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BbodEF5CfyfyezAUM7C9Pjfur1AbgmXuVllEdfGP3ws=;
 b=J++dIJHObatRdCHnvl9MrgCbmKnVTadPdmyJjVjtpqaHq/fvGijGFVKVwS0d9JLNnn
 84a3+xjnBJ92tXjAz3cFSDWzdz2MFXNCR5+57Zk4tbx0VFoyszy0pGjoHcq29bcRq1S0
 TzgycIDdBfwZU8w0wgv6nNfvDaILWOI/kQzjeMLMjYWkMhcPMeirMIigXxOMzXXBVwcf
 bSssxyjoFdeF2ATgFHRTCVIuXdch4PA9UwXr+eXht+wrWkNfAVhwYwaWYSiXL1HDSJFj
 rJOhhu2aYWoOD2+sTX2zmW2tu4QVWcaKv8oM6x9R0jhWYfZxuqijZKymY+cLn9YcMsOO
 QWkA==
X-Gm-Message-State: AOJu0Yz3oTQh/SAn/M5IIGx/NLmXzeqaV8gIYBuRPHl05h/MuRp3BINx
 xg5hnWM1x2PvktRCeK8Kh/xMVVqv0KFvBOYRE1GHojj4L9f8zifvgmmzyOxTeV4=
X-Google-Smtp-Source: AGHT+IGIbYETV9AbMpyGxDBqzj+Xmuzr40nossI1Z5oeeIPYWgm8+u9yXBhGS47unnE1lzxQjLnDcg==
X-Received: by 2002:a5d:4fc1:0:b0:33b:d225:3640 with SMTP id
 h1-20020a5d4fc1000000b0033bd2253640mr1520980wrw.59.1708007056461; 
 Thu, 15 Feb 2024 06:24:16 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a5d67d2000000b0033cf0f5a01fsm1896020wrw.33.2024.02.15.06.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:24:16 -0800 (PST)
Message-ID: <f9dd39e6-4ff1-4a05-944b-3cdd93fef82d@linaro.org>
Date: Thu, 15 Feb 2024 15:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sparc/leon3: Have write_bootloader() take a void
 pointer argument
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>
References: <20240215132824.67363-1-philmd@linaro.org>
 <20240215132824.67363-3-philmd@linaro.org>
 <CAFEAcA_we0joWBdAeyhRAAWaTF_gZSSUVJTNv=jQwpS+cUUuGg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_we0joWBdAeyhRAAWaTF_gZSSUVJTNv=jQwpS+cUUuGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 15:13, Peter Maydell wrote:
> On Thu, 15 Feb 2024 at 13:28, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Directly use the void pointer argument returned
>> by memory_region_get_ram_ptr().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sparc/leon3.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)


>> -static void write_bootloader(uint8_t *base, hwaddr kernel_addr)
>> +static void write_bootloader(void *ptr, hwaddr kernel_addr)
>>   {
>> -    uint32_t *p = (uint32_t *) base;
>> +    uint32_t *p = (uint32_t *) ptr;
> 
> I don't think you need the cast any more now ptr is void*.
> (If you do, then our coding style doesn't put a space after
> the cast.)

Right, updated.

> Either way,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thank you!

