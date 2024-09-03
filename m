Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB0CCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slOLg-00025C-9i; Tue, 03 Sep 2024 03:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1slOLc-00024X-EN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:53:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1slOLa-0003WG-5H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 03:53:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so1231808f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725349984; x=1725954784;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IZNpcvjBnjOZsEop3XwjpMPZkk0NO4drzCJ+Gd6qezE=;
 b=gb4BovFtPAiiP4B+dElpH0svknOqrWOrH4yFqMFES2193hPqm4ovpW4yFPE1eAMPby
 gYAPeDoWQ31G+OKORWW4c5cWDYwfOna7jmsUtMrsglrqjkAmTYgxafuOjZ7PzQUA5XJq
 J2eCP8fFWSprbf9VahN3so6RXMNfHED4pw6Em57+v6W+SUYaRCMg0vDJ+vKrN14MjIOe
 RwDxbRtK/pL0k07dDjpw5/sjh0Uj9rHvCAk8JFRMJ+B8S4U2Zngkr7k1MhkXnvZXJ0yP
 daWy9kmM/4dRsYsqSSPmnvHPi2Gq5AQQZeXPkPNDM4K6dB/avjhhsJ8Je2wvLdm4UrWz
 GH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725349984; x=1725954784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZNpcvjBnjOZsEop3XwjpMPZkk0NO4drzCJ+Gd6qezE=;
 b=h8I27s9+/tDzqWejjjePrgVGZm1sRAu+8U5ryxqz1jC/k1hlbw/PoNBdTgLGMoVpSr
 aNd7Z2Q5cC8rP8tcKJLB95gvEuwyIkZLA/u0yoaOPCkggxTRxt8GqYZ+zzNN6EncQTQ9
 glzLmkdddhtpN2zOtL2lL/XgXqxdulroU373E3UvjlosmDhX8AEiy3fOTjSXXFfkahRv
 cKWuXzsuNDS4/Y3m5GQm0JyCBiUdsw1/ViLzD9M2UXNERo5PdZqlcv/hocu5qPScezjr
 LpY/lhXNeqnNXx+zbwhqH6dmW1QSUFcuJU3OlOh+N/7Eg9D5uC2B1sWUbrQ7Q2RH12cw
 V8dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCsF85N7knVGTMkCkEOocAbvse6GWetjuuoj86uUvALE89Vmgs300/cb+ttnIJd0MF0iCfydGnHaHy@nongnu.org
X-Gm-Message-State: AOJu0YzpBLIh4sXX/UrMNzWqdUYlT1yD8GlXkdQW/OHbjH90v5tay4AO
 FN81MPCbnjz29eDIiCrcnqlOygohyTEnXFnJAXnvNpYQaYJ5nMbj0P6YVKY+NU0=
X-Google-Smtp-Source: AGHT+IFV2PcPZOa67iu9QiGleAncoJTgp8enBG2pdOVUvlou8NTyFZ8kltjwxMuwR6hFH2zdpDtVDQ==
X-Received: by 2002:a05:6000:1971:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-374a91a3911mr6854494f8f.15.1725349983503; 
 Tue, 03 Sep 2024 00:53:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb37efsm13527075f8f.109.2024.09.03.00.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 00:53:03 -0700 (PDT)
Message-ID: <563f3b75-bf13-4ca7-a995-f2c8ff1b6799@rivosinc.com>
Date: Tue, 3 Sep 2024 09:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
 <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
 <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 02/09/2024 21:38, Philippe Mathieu-Daudé wrote:
> On 30/8/24 13:57, Clément Léger wrote:
>> On 30/08/2024 13:31, Michael Tokarev wrote:
>>> 30.08.2024 14:14, Clément Léger wrote:
>>>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can return
>>>> -1. In that case we should fallback to using the OPEN_MAX define.
>>>> According to "man sysconf", the OPEN_MAX define should be present and
>>>> provided by either unistd.h and/or limits.h so include them for that
>>>> purpose. For other OSes, just assume a maximum of 1024 files
>>>> descriptors
>>>> as a fallback.
>>>>
>>>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>>>> posix")
>>>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>
>>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>>>
>>>> @@ -928,6 +933,13 @@ static void qemu_close_all_open_fd_fallback(const
>>>> int *skip, unsigned int nskip,
>>>>    void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>>>    {
>>>>        int open_max = sysconf(_SC_OPEN_MAX);
>>>> +    if (open_max == -1) {
>>>> +#ifdef CONFIG_DARWIN
>>>> +        open_max = OPEN_MAX;
> 
> Missing errno check.

man sysconf states that:

"On error, -1 is returned and errno is set to indicate the error (for
example, EINVAL, indicating that name is invalid)."

So it seems checking for -1 is enough no ? Or were you thinking about
something else ?

> 
>>>> +#else
>>>> +        open_max = 1024;
>>>> +#endif
>>>
>>> BTW, Can we PLEASE cap this to 1024 in all cases? :)
>>> (unrelated to this change but still).
>>
>> Hi Michael,
>>
>> Do you mean for all OSes or always using 1024 rather than using the
>> sysconf returned value ?
> 
> Alternatively add:
> 
>   long qemu_sysconf(int name, long unsupported_default);
> 
> which returns value, unsupported_default if not supported, or -1.

Acked, should this be a global function even if only used in the
qemu_close_all_open_fd() helper yet ?

Thanks,

Clément

> 
>>
>> In any case, the code now uses close_range() or /proc/self/fd and is
>> handling that efficiently.
>>
>> Thanks,
>>
>> Clément
>>
>>>
>>> /mjt
>>
>>
> 


