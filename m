Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D2EC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchj3-00051a-Gq; Tue, 28 Jan 2025 04:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tchj0-00050f-Kd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:17:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tchiy-0001pF-RT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:17:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so37551695e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 01:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738055855; x=1738660655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNtuBqPW6c9cGsDa+hKWe5shvr9uttKboQwbuz++lMU=;
 b=mRYWJ/LPTf1N7Hcu05zOsAV9NJgxVkaAADn8ThFINtT/Pk8li7qYXptgAYntq8RNTZ
 8cLSrr0gjoFqjcVujz2i0OuVdI3LeOTBsDZpRNmT1iIGFiUDscCCkB/YIsGzqs/ms9sB
 aHlyJWYV8Q4IgvHjpd0tHuNRPIomLTsKY8wI8UkilbNmiU9ULIDTExi7cVajKXbZZsDE
 xM+FvhZ00XddQlY1vod+nMsToe+2jetiqRMuprAlAW+M2Uuya9f+RIcA4UPGGCWAY4fB
 3KCugyCZTy8Q7scmI3LWQNTvjVLk8x2jGFcDhKYILW5BkPpuIAGQy+cOvMBwH5Fi3pB8
 sJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738055855; x=1738660655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNtuBqPW6c9cGsDa+hKWe5shvr9uttKboQwbuz++lMU=;
 b=YFholO1pAKVAATrXWbrPtCbDNu0zTxzUYOg4nMvDmSJbb6VXLEKDvGVc8FNOsjWKtd
 4ANs0UJBf4A+inAiQYzG3iZ9o5fzzneLiQVV5OJi6fwXf2b5BNWcJyCCkIfaZ19yauFO
 ZMZ6l+13K75wLONHw36vMms2g27CfE+mxNVyNJ+dHWKsl9Cu1+z33BftT4pdKFnucF2p
 cWwJvClaZoam/FxgZLf8jEwk5Mc3kiSNsMXt2sXcEGx7hMA9mkc/gLWbkGzjGYXgTxMt
 fWVtmf7wFpLn4a1w9D6u2Ogi0zqsye5iL7bffKcREMnyS9jCjBw4MMRNcwApKBmwTryw
 VLNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzDHdBrtpcfafGfPvoP6scVAWjOdunVUdeW11zxaMCI9xCuC7wWTc8y5pCOQEFxMOrDlwgjVEqYRHa@nongnu.org
X-Gm-Message-State: AOJu0YwLHC7gIvGzZF6svsDaZCdZ9UDzoEDisJ5kI/K0gBfZAlyHVwNt
 djy5M8axisd75qoHyQrLSkusTzZ/Eo88wHoIJuMjGylTRgL4/cAiBGzyP8uUDTU=
X-Gm-Gg: ASbGnct7t/EMA/UjUcyaGQOVZ5WYeIpfqLX0o8fdY3nLFjgm5cj+mS6Mq54rVJV3wCN
 GQt+DPeIbem9DJhto+uPOFKVtr7TUECb3RFIi7pEb7e2qKEoSRpCxR7aXL2e2mdv7xT0xe8sIlQ
 8ogYV3d7wEYO7TY/l5Q5Kxwflh07Sku0pS7/JYXJ8afNNrtSIC9tBJM8nesgq3IqEen/VRUlx3o
 hxCU1St+WYhbZn5BCCud5+m7Piuu1K2QI05s1giArlRQbamEJmGgH4lY8TtS5cHs44C8I/yC/3g
 wolCBAfSozKzBsOokenoH5r53tLLI/dGc45oAk3BLkaULwxccAyWi+ZoONI=
X-Google-Smtp-Source: AGHT+IFxiTHWw+9Dhvf7WfuqAFtc/jHgIpSFNYll/6X0dyxDEjA0iwDQ6YdYGKTvUQ6bCD07agvmeA==
X-Received: by 2002:a05:600c:6550:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-438946434dcmr385202725e9.3.1738055854830; 
 Tue, 28 Jan 2025 01:17:34 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa479sm165685615e9.5.2025.01.28.01.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 01:17:34 -0800 (PST)
Message-ID: <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
Date: Tue, 28 Jan 2025 10:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mark.cave-ayland@ilande.co.uk,
 Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87plk72tvr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 28/1/25 10:02, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 28/01/2025 01.42, Richard Henderson wrote:
>>> Time for our biennial attempt to kill ancient hosts.
>>> I've been re-working the tcg code generator a bit over the holidays.
>>> One place that screams for a bit of cleanup is with 64-bit guest
>>> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
>>> have to handle such silliness at all.
>>> Two years after Thomas' last attempt,
>>>     https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@redhat.com/
>>> which resulted only in deprecation of i686 host for system
>>> emulation.
>>> By itself, this just isn't enough for large-scale cleanups.
>>> I'll note that we've separately deprecated mips32, set to expire
>>> with the end of Debian bookworm, set to enter LTS in June 2026.
>>> I'll note that there is *already* no Debian support for ppc32,
>>> and that I am currently unable to cross-compile that host at all.
>>
>> IIRC the biggest pushback that I got two years ago was with regards to
>> 32-bit arm: The recommended version of Raspberry Pi OS is still
>> 32-bit:
>>
>>   https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/
>>
>> And looking at https://www.raspberrypi.com/software/operating-systems/
>> this still seems to be the case...
>>
>> So I guess the main question is now: Would it be ok to kill support
>> for 32-bit Raspberry Pi OS nowadays?
> 
> I would argue yes for a few reasons.
> 
>    - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can work
>      with a 64 bit OS.
> 
>    - It's not like the versions shipping in bullseye and bookworm will
>      stop working.
> 
>    - Even if we deprecate now there will likely be one more Debian
>      release cycle that gets 32 bit host support.
> 
>>> Showing my hand a bit, I am willing to limit deprecation to
>>> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
>>> unconditional support for TCG_TYPE_I64 would remove a *lot* of
>>> 32-bit fallback code.
> 
> I support going the whole hog. I would be curious what use cases still
> exist for an up to date 32-on-32 QEMU based emulation?

Current maintainers don't have spare time to support the 32-on-32
emulation. If there is interest in the community for such niche,
someone needs to step forward, willing to maintain it.

