Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CDEE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfvP-0005vn-3X; Thu, 12 Dec 2024 04:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfvJ-0005v1-K1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:55:59 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfvG-0005vr-M2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:55:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso3978595e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733997351; x=1734602151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x212bhFbd7tjCXnM1kJhf/PFqXLKhb2HDmMIdiUt4KA=;
 b=p/X054NY3mlPTJ7csLLN1fDdgFuFwSHQMYBYjiqGo/GOGmNl+GybsCX2m27FSurArU
 b/8dL9qoEgkRsDlCMpNWyjRUjvCzReMn76DzXf5yJH2hQR+/Wu9ORXMMYqC09lEjh+Ph
 ac/0crHXHDnKQEYERIR4c5BEiKdYIZNr0VLnkOJ6eUBqefDy2+Npudwv2RbYWd/4Av2x
 aSJlQmsAO+NpFLbgTS8aidRmmIA1KI95gMaxP6o6iYVQ3i69LSIYAcPEcxExj6vIwUw6
 73WeeXNu/I96jD0GIRqeXIEqYedVSg0i8+ecyYDOobGSDKxZA3xYBkpYgxKdgQn1ll4r
 pfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733997351; x=1734602151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x212bhFbd7tjCXnM1kJhf/PFqXLKhb2HDmMIdiUt4KA=;
 b=IGOtJqmL3ZasuW0PKmLxPMjXByMWVmA4A25wXQDhxt9gktUwEBFayjRl790XAZSSPh
 2mhH3l9+0hNSNODpTMLwnoscE52G/NISrUEX7964vacT6HvNanErR0Ln80wOzJHuMnK7
 FW9SucrtxPWiUPeaJfi5lL2djtxM4/hd3gvcU1T7mIIqiZbVjywvI60ukH3NQih3t+HY
 gVW6SUd5st4qTElWlxUTcn9/DPe1mMY+vsE7M0zGlJswkj/oukDUuyaVjxFOvge7u7St
 jAi9R+VR1uLwwwlFj9hy4wH/4BuhPdJTfko9FMv97FWuVB7pudgncIcZs1hzDppocCMI
 nj/A==
X-Gm-Message-State: AOJu0Yys+nJ0QDkqW/F9dzmfnfnW3y/zcPlctTjghOTTC7atCDnKhbP4
 rk1doV8yYcHq9FieKo+0Bk7C0YadAie0DZXrYGF09SJknafsBWK3neRfMKsTApI=
X-Gm-Gg: ASbGncv/S33H+mXYn/OkUDrCl9wsy7aYOe48Nwvze8GAmHj5IojOXszQ4Nj4ElFl/uu
 DYVazdMsDPCTATNVWOPeePBeTnaat/oo7R6sMkQiBTrHnXKa+DvXNg+dETgY+FSIAuT+gU6/WZM
 dnTq6DyKrWUhor3zMM1od6nVj24Sn8vQoTNHnJb3UJn7UEzTJS1dvWlDqMxSNGFBaUkOJROp7uk
 DU1JQdeIu4hVVTJL5/GfdYWIVjbyWfl4o0d8zffrE38vvEsyZMnuWwwelNjrnX2i+Pg1lzUe0I0
 NvFkzOf+TZcHtQ9Fu7wZuQ==
X-Google-Smtp-Source: AGHT+IHHCwMJXClBV3EAQLuXdMJclSQaPRAFF12ObHw5vm/J7hUSOP0HHaWcCI+CLAQqetccJhbvsQ==
X-Received: by 2002:a05:600c:3b18:b0:434:fd77:5436 with SMTP id
 5b1f17b1804b1-4361c38d24fmr52684475e9.15.1733997351472; 
 Thu, 12 Dec 2024 01:55:51 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256c8baasm11390435e9.36.2024.12.12.01.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:55:51 -0800 (PST)
Message-ID: <48a61a76-3c91-4ab0-8ae7-0a9a34082c75@linaro.org>
Date: Thu, 12 Dec 2024 10:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson: Run some compiler checks using
 -Wno-unused-value
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241211231655.98148-1-philmd@linaro.org>
 <Z1qptPHK6QOh_TRH@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z1qptPHK6QOh_TRH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/12/24 10:15, Daniel P. Berrangé wrote:
> On Thu, Dec 12, 2024 at 12:16:55AM +0100, Philippe Mathieu-Daudé wrote:
>> When running Clang static analyzer on macOS I'm getting:
> 
> 
> snip
> 
>> Fix by explicitly disabling -Wunused-value from these meson checks.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: Probably meson should do that in has_header_symbol() / has_type()?
> 
> How are you enabling the use of static analyzers ?  There are several
> different ways to change compiler options and I vaguely recall some
> approaches can trip up meson.

I prefix my build with 'scan-build':

$ scan-build make
scan-build: Using '/usr/bin/clang' for static analysis
config-host.mak is out-of-date, running configure
C compiler for the host machine: clang (clang 16.0.0 "Apple clang 
version 16.0.0 (clang-1600.0.26.4)")

You can reproduce without using scan-build by passing
--extra-cflags=-Wunused-value to ./configure.

We have a "disable some undesirable warnings" section in
warn_flags[] in meson.build. If we want to ignore unused
we should add it there, but I'd rather not ignore them ;)

> 
>> ---
>>   meson.build | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 147097c652e..a431aa982ac 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1166,7 +1166,8 @@ cocoa = dependency('appleframeworks',
>>   vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
>>   if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
>>                                                 'VMNET_BRIDGED_MODE',
>> -                                              dependencies: vmnet)
>> +                                              dependencies: vmnet,
>> +                                              args: '-Wno-unused-value')
>>     vmnet = not_found
>>     if get_option('vmnet').enabled()
>>       error('vmnet.framework API is outdated')
>> @@ -2690,7 +2691,7 @@ config_host_data.set('CONFIG_RTNETLINK',
>>   config_host_data.set('CONFIG_SYSMACROS',
>>                        cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
>>   config_host_data.set('HAVE_OPTRESET',
>> -                     cc.has_header_symbol('getopt.h', 'optreset'))
>> +                     cc.has_header_symbol('getopt.h', 'optreset', args: '-Wno-unused-value'))
>>   config_host_data.set('HAVE_IPPROTO_MPTCP',
>>                        cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
>>   
>> @@ -2708,10 +2709,12 @@ config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
>>   # has_type
>>   config_host_data.set('CONFIG_IOVEC',
>>                        cc.has_type('struct iovec',
>> -                                 prefix: '#include <sys/uio.h>'))
>> +                                 prefix: '#include <sys/uio.h>',
>> +                                 args: '-Wno-unused-value'))
>>   config_host_data.set('HAVE_UTMPX',
>>                        cc.has_type('struct utmpx',
>> -                                 prefix: '#include <utmpx.h>'))
>> +                                 prefix: '#include <utmpx.h>',
>> +                                 args: '-Wno-unused-value'))
>>   
>>   config_host_data.set('CONFIG_EVENTFD', cc.links('''
>>     #include <sys/eventfd.h>
>> -- 
>> 2.45.2
>>
> 
> With regards,
> Daniel


