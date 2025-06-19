Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F8C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMuB-0002Ac-Vf; Thu, 19 Jun 2025 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMuA-0002AR-J1
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:34:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMu8-0002rJ-Vq
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:34:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so899646f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750368879; x=1750973679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTDwjqILZfkRvlFExD2iTfSpeUzaMy7m8OCPLYS/Gk4=;
 b=MpemhGJSm5nZSKpWMj+yPis9yJBkK16yO0W7YLfV3LZpFrEPqiU53SEJS9yZfdjuGz
 qICdPG7tAgd1RyMOGjXizhXQRTUxVpkqNti3GHrazTKecVia/UcCkF2UjfIV4g7MNIIU
 q2P0KzbG3U/DPl9IRcvKmJcPkwcKyYM/A5vpz8iVOuPTy6QPPonhZfvL+bQLZetZlEqX
 hNtCEGy1q/+Fgy3hRyMIYBYrqYxF9xocHFIzUftp8YcqccATTJlieTM7BNb474Hu88KW
 sUfb5HR3E/TeSassc/srR2/anTQp02w5rXyZ8um2VKhxGM42+eerkckQD9UE171rFV9F
 TTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750368879; x=1750973679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iTDwjqILZfkRvlFExD2iTfSpeUzaMy7m8OCPLYS/Gk4=;
 b=pIrypgcJuhC4XAbr7i+qLSq4AQKUXIK7UjqUvPbD3+4NeqTjcxNw9MeAvMaQNzW4KB
 rozdvQz02yHSsOsuruDfCns4Um6+oZTwzlSqVujZUIhcpuNMscg5ZZ18q0gE1C7+tQtB
 VH0qMfMuHe6Xar5WBev9aQ3AMy6i9PzrT2Cs4Fe+aI8HSgz7kue4WegJodbB2OG1yU2Q
 qJBCa9k6VPeJqhsBHcEIhTjIFui5CvR+BCDe67evgbeo1h2IZR9AyTd+IRuElaAOD0of
 n5thYkR4fjXh3Mj4G6zoc8IBoImDgd6NZpxiX+3eLf/Jf3qHv6pB1OjGJ39katL4D3w1
 Bg9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUilYPph9akkDYqfzi/16R3tkqs7veIpsDhugtIKazQsF48CUnpuVj1ZFbb8r5q1owGlQm9EmpBUThY@nongnu.org
X-Gm-Message-State: AOJu0Yyr0y+rhHk8hJam6YDvWsLbuVWT4buqjQGDegAoMlFH75pnGJ4l
 MsM31epUUMOPwtEbydf4lh+UQf5E/wVM/JKMpMjC0XAfJGBLXA78BRgNqQvmIJOOe3U=
X-Gm-Gg: ASbGncu8dxm5/VbZWovOH8C57fFgaQTQHMo/rAuW3DTRL7+AQu/jbhYuRVuYW/+FysU
 PGCWy//MNZGrNGcPvvnyIcp4quVYBtZFpzMepmWHiCB0OMwHnGncAUlA/+tZZaAQwN/6ZpSEIqM
 YtdSIRBse5fVSrOb/opkyWWOqYDvcpVJDfgYgiYCpLpRNWBgjpOZ3YD3YPYrsFRyY+JcXKZ7CyV
 fz3hEW08DmY+fuh1eS/adIBonS9QztDEKAY390y5HXlktKkvBYeDZqTlDrv11PO6I15rbvVSTx9
 mf5g7LNocJB7/RSGFqfObY3L8AvMH46KLkd20D0pKRrc4W27hctAAxeiuECaqmEywUwDRFsl4LA
 80xLngmN5j7TimExJH7cSceWvsB9Sjg==
X-Google-Smtp-Source: AGHT+IG39ERt6GirwzwVypqKTmunZFNyklgxGtDeIqTjzYWmpQf7/iwWE/qY9z3o91fr+JRntD/OKw==
X-Received: by 2002:a05:6000:210f:b0:3a5:2cb5:63fd with SMTP id
 ffacd0b85a97d-3a6d12dbf71mr270570f8f.10.1750368878771; 
 Thu, 19 Jun 2025 14:34:38 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f105efsm391366f8f.15.2025.06.19.14.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:34:38 -0700 (PDT)
Message-ID: <b62a7645-03a7-4df9-ad10-221861e3b43d@linaro.org>
Date: Thu, 19 Jun 2025 23:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-20-philmd@linaro.org>
 <1e7d58dc-b348-4c6f-b7bd-e8da047e21c8@linaro.org>
 <b3bea159-8da3-4a7d-8485-fcd6519b845d@linaro.org>
 <2d819061-8262-4da5-add3-20d567dde52d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2d819061-8262-4da5-add3-20d567dde52d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 19/6/25 23:28, Richard Henderson wrote:
> On 6/19/25 14:20, Philippe Mathieu-Daudé wrote:
>>>> @@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
>>>>       sms->smp_cpus = smp_cpus;
>>>>       if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
>>>> -        error_report("sbsa-ref: cannot model more than %dGB RAM", 
>>>> RAMLIMIT_GB);
>>>> +        g_autofree char *size_str = size_to_str(RAMLIMIT_BYTES);
>>>> +
>>>> +        error_report("sbsa-ref: cannot model more than %s of RAM", 
>>>> size_str);
>>>>           exit(1);
>>>
>>> Not a bug bug, but autofree has no effect because the block doesn't 
>>> end before the call to exit.
>>
>> Right. Isn't it better to use g_autofree as a general code pattern?
>>
> 
> It's a case of "this doesn't do what you think it does", which is bad form.

I see.

> 
> If you are actually interested in freeing the string to avoid a false 
> positive during leak analysis, wrap the two lines in another block:
> 
> 
>      if (...) {
>          {
>              g_autofree ...
>              error_report(...)
>          }
>          exit(1);
>      }

Interesting, thank you!


