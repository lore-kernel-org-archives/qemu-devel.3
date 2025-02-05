Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA97C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 19:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfkm1-0008Ka-I6; Wed, 05 Feb 2025 14:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfkly-0008Io-Qj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 14:09:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfklv-0008IK-F7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 14:09:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso4189905ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738782549; x=1739387349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzGx4b2wHISSXbbcMll6jEljDr1DreHfGhvAFRQOiB8=;
 b=DJJ0hOjUAhrQSJW2Is/SbMN88WyFWkKbHUDRvg5Bf0dUVIs59SC/zfaSZjiBB36Lp5
 oidjRUY7CFfKELXAhT6n2J+j4xOmQhFU6nF6gV5odIuk64lWmTXKanGBH/08zBGkPSNg
 m9O4cSxlPHR2b573vvAQV0RNc1aYarpAS3iCOXdhw7k2h7YHYbXu+qMXoK31kd5OH3sU
 t/OO1N5BXxYkTGFPdMNzVkT8VC9VFLT8P01EzWd/VC4XfKNzJ/ZmrZjgK/qRvLfaSTMF
 4osl75ROC+xlP/xkxNw8RXK4/bvcm5W4d19nceBRsN6DOezX+OQZOcF1uJI3CPfH2eI5
 HoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738782549; x=1739387349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mzGx4b2wHISSXbbcMll6jEljDr1DreHfGhvAFRQOiB8=;
 b=uYAOfFy4CTIAEK2eAxAMyngQPtnhyrbBIMvADfiN9PLyNh0yfbrworWASwkr+6L6r6
 i/vNEsK2IT51Yz4CXPcPexY/XeDmfIBClgQS5WyXIWiRxx0DTp+quTmL6U4l2J2fbfUD
 ij6dGgAfmIVeUAHQdA6ZY5ygq/rI0Udg8gK3mTFizaqyv597BKit2z4DuzHLzr6PXlUi
 Jf7A3JZt1QracB/08y0dTSkteZuQTuUyBnsfpRZ6Vc2A96twUazZq1nBxNCceoG/UkVS
 FNVuqwO8tlhb6YmycybDvsC5vNgAMn+WctcUcWac15rfqmO2WtGToHBZsRd6rQkPUDGE
 VzJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIlab+7mKWkFJt5EvWD+7JvLg6l3XerwH2LJ1YBgnmIMsyPGL0fT82Yo7OL8Q6b1VU7eC86k7eI/LU@nongnu.org
X-Gm-Message-State: AOJu0YyeVNb5KSNd6MD14HsVo4uaY0LSA1H5Y4+3QHxwPYw0Q0X826vF
 ULiByAoD3UX/wXNrihSFcrSYN2/JZRFA/9DTejV/1/F00QZdE03cVyMk3bIWdtM=
X-Gm-Gg: ASbGncuZ+Bikw2pCMQUXJTgDxt21iUTiiXkMNbs9Coez6zfnM2VOnR6O6syqcVvlLhP
 sCe0XF6N14PbC3fYIlW0b6afVh4GVWBGjuQu1uF7pGjoFZy4xvPfyZFl3IdF5GDG8bc3CJC9/FD
 HRr4IBZyD12+7FHnkB81mSr4fcXppcuMM16kDPIPDt++LgcknnvH8PuEyrpFSj3JOOkQtTpI/fd
 0rcHLbLN2lL5Ooji6lQelDOZVFaFhEi/8TwNbW80iUch4hPxmprxyYBI+1O6JwA1NDZEf7ZQz7C
 z/9bXSq1Gcd+nLra6lGM7071Do8rlAP9YO9eAGC9fKt18I460wo6FA4=
X-Google-Smtp-Source: AGHT+IF3nlu/OSr2PR6xukwv6LHyHCzgljaYPM19WkIpFOgOwpfqm24ZnEJbtq7Cwtd/vIJGjn6nrA==
X-Received: by 2002:a17:902:d50e:b0:21f:c67:a68a with SMTP id
 d9443c01a7336-21f17e2a761mr72435715ad.31.1738782548714; 
 Wed, 05 Feb 2025 11:09:08 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f0a069709sm32731095ad.59.2025.02.05.11.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 11:09:08 -0800 (PST)
Message-ID: <027c0b37-f73d-4f82-abb6-f3f6b76e8937@linaro.org>
Date: Wed, 5 Feb 2025 11:09:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Reinoud Zandijk <reinoud@netbsd.org>
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-7-richard.henderson@linaro.org>
 <56d285f8-2edb-4194-abf3-dd39e635a0af@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <56d285f8-2edb-4194-abf3-dd39e635a0af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/4/25 22:50, Thomas Huth wrote:
> On 04/02/2025 22.53, Richard Henderson wrote:
>> Require a 64-bit host binary to spawn a 64-bit guest.
>>
>> For HVF this is trivially true because macOS 11 dropped
>> support for 32-bit applications entirely.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   meson.build | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 0ca83135e2..c80382befd 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -319,13 +319,16 @@ else
>>   endif
>>   accelerator_targets += { 'CONFIG_XEN': xen_targets }
>> -if cpu in ['aarch64']
>> +if cpu == 'aarch64'
>>     accelerator_targets += {
>>       'CONFIG_HVF': ['aarch64-softmmu']
>>     }
>> -endif
>> -
>> -if cpu in ['x86', 'x86_64']
>> +elif cpu == 'x86'
>> +  accelerator_targets += {
>> +    'CONFIG_NVMM': ['i386-softmmu'],
>> +    'CONFIG_WHPX': ['i386-softmmu'],
> 
> We dropped support for 32-bit Windows last year, so I think you can remove that WHPX line.
> 
> And looking at the NetBSD Makefile:
> 
>   http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content- 
> type=text%2Fplain
> 
> ... it seems to me like NVMM only gets enabled there for x86_64, so I think you could 
> likely remove the NVMM line / the whole 32-bit paragraph here, too?

Good eye.  Thanks for double-checking NetBSD, especially.


r~

