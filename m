Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D522CFB420
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx8g8-0007ub-Nx; Sat, 05 Oct 2024 13:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sx8g5-0007uF-Cr
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:34:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sx8g3-0002Fh-FV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:34:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-71df0dbee46so615297b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728149684; x=1728754484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tdqr7C67Hy8bybFmMu3KwmMGIqzKUBbrFaDS3qvvM5E=;
 b=C6LQTlO6sPtkir6WcPUnnooWX9MIeYHXdjc8YlAQmnebeoCW03g74C1N8ETXmB3kVp
 fR/EDRR+ktsq0AbXyQQOm4Z7/g/g9hYyp0arC6JqOHyVW0bUZSdovT66EhfdWSaZkVEP
 7ND/8utQnNTIkfdW38c4iefu5Jm95CaXJ4U7Z+Jariofmw6amNshzBkDn7So95jF1V2N
 CpO9XE4+s8a8XO5jnkI4NopGIs9QEUy7KAKXRMNXvedoOLPYf2oQ7nPTyupY70Md5o5O
 aI04i4gaKZs0reJI9242vMlFqutEF3F10TEJdgniOPQolX0lxis4Ybyf1Gc5DRlj8jWP
 26mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728149684; x=1728754484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdqr7C67Hy8bybFmMu3KwmMGIqzKUBbrFaDS3qvvM5E=;
 b=AECsrhnwjnjasTCVf/i53Z1JB8Q0LMmxlrnS/S8wZh42X2QT+pmZ49hcoRfFbFepmE
 BALlmgXRbvphrYoKJwJUjDvGEhcdG91Wjfes4O9b5NrJjkgym6xmaazoZqrdmepwiQKl
 Gp6HwUvptT4f/aR6PLTklpbmQpNDRWUw/K+/GLWaeoBMimfoM/QfgMZ697VpdZ6L7LIZ
 FLQm0uwKcs86SCchggox0hTmInqdpmJtWJfUhKJpNqJxdjTVibdf46ByAyMM0Q2mxUHy
 +IO7VK/EdmKt3inSLVwgZUqqw7T3KWHuUDIwSfYv2QgYLoepIS6gRtZLiV7Y4TnlPkNt
 hmbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIU305kemd0WKLs6DoPh7DbtXoKNf9dsbL6onLYqlcE2tlKPGLfYsAIIJ2Ei9TSKrjPZra/JN/RNgJ@nongnu.org
X-Gm-Message-State: AOJu0YykmW42W0SqdFQMOVFExPrRAOmqoSJEcNBBbyrukFE/nHjIwP56
 7q35V3VmfOm6OhziTbOYYRvhVvUajiaXqJxO3U/wu6+Uqa+EkSPTOr1hs/04P6A=
X-Google-Smtp-Source: AGHT+IEGhLhkzcaWyy3afi20Go+1MRMMgpZvGsg/X+RWry+Tl+Pzkh8OBTwG6oUyyq5sk0AMRXLRHw==
X-Received: by 2002:a05:6a00:4f91:b0:71b:64c:814b with SMTP id
 d2e1a72fcca58-71de245e677mr12012861b3a.23.1728149684432; 
 Sat, 05 Oct 2024 10:34:44 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbcee2sm1716758b3a.43.2024.10.05.10.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 10:34:44 -0700 (PDT)
Message-ID: <bbbeebd4-2769-41f3-8cd0-1c0121ed4f06@linaro.org>
Date: Sat, 5 Oct 2024 10:34:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
 <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5604626b-cba7-4d1c-8dfb-2c2e3b8495a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 10/5/24 09:16, Michael Tokarev wrote:
> 05.10.2024 01:01, Pierrick Bouvier wrote:
>> Alex discovered that CMPXCHG128 was not enabled when building for
>> x86_64, resulting in slow execution for wide atomic instructions,
>> creating a huge contention when combined with a high number of cpus
>> (found while booting android aarch64 guest on x86_64 host).
>>
>> The problem is that even though we enable -mcx16 option for x86_64, this
>> is not used when testing for CMPXCHG128. Thus, we silently turn it off.
>>
>> x86_64 is the only architecture adding machine flags for now, so the
>> problem is limited to this host architecture.
>>
>> Meson compiler tests are supposed to be independent of environment flags
>> (https://mesonbuild.com/Reference-manual_returned_compiler.html#returned-by).
>> However, CFLAGS are used anyway, thus masking the problem when using
>> something like CFLAGS='-march=native'. This is a meson bug and was reported:
>> https://github.com/mesonbuild/meson/issues/13757
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    meson.build | 10 +++++++++-
>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index b18c2a54ab5..af2ce595dcc 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2867,6 +2867,13 @@ if has_int128_type
>>        config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
>>    
>>        if not has_atomic128_opt
>> +
>> +      host_flags = []
>> +      if host_arch == 'x86_64'
>> +        # for x86_64, x86_version must be >= 1, and we always enable cmpxchg16
>> +        # in this case.
>> +        host_flags += ['-mcx16']
>> +      endif
>>          config_host_data.set('CONFIG_CMPXCHG128', cc.links('''
>>            int main(void)
>>            {
>> @@ -2874,7 +2881,8 @@ if has_int128_type
>>              __sync_val_compare_and_swap_16(&x, y, x);
>>              return 0;
>>            }
>> -      '''))
>> +      ''',
>> +      args: host_flags))
>>        endif
>>      endif
>>    endif
> 
> 
> This does not look right.  We test with an extra compiler flag, we should
> ensure it is actually enabled for the actual build.  Here, we only test
> if cmpxchg128 works with this flag appended, but do not enable if for
> the build.  It just happens we have it enabled elsewhere..
> 
> Maybe we should add this flags somewhere to $qemu_cflags in this place
> if the test were successful.  With the proposed variant it is confusing
> and works just because it happens to match in a few places, not because
> it is supposed to work :)

If you look upper in meson.build (x86_version), you'll see this flag 
(-mcx16) is *always* enabled for x86_64, which is what the comment 
states in this patch.
So it's already added to qemu_common_flags anyway. The problem is just 
that when we call cc.links, environment we defined is not reused.
After discussing on IRC, we identified it was a really special case only 
for x64 and this instruction, so I didn't find useful to make a more 
complex solution than just using the same flag.

Maybe it would be more clear to define a qemu_machine_flags, and reuse 
it here (or in other places where it might be needed), but I feel like 
it's too complicated, and we can always add this later.

I'm open to implement something different for flags management, but I 
feel like we are thinking too much ahead.

> 
> Besides, in the current situation where CONFIG_CMPXCHG128 is not defined
> due to this bug, the final link fails due to generated calls to -latomic, -
> which might mean we have something else wrong.
> 

By default, __sync_val_compare_and_swap_16 is not available, except if 
we use explicitely -mcx16, or if we use an -march that implies this.

Our default level for x86_version does not enable it.

$ cat ./build/meson-logs/meson-log.txt

Code: 

 
 

         int main(void) 
 

         { 

           __uint128_t x = 0, y = 0; 

           __sync_val_compare_and_swap_16(&x, y, x); 
 

           return 0; 
 

         } 
 

 

----------- 
 

Command line: `cc -m64 
/home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/testfile.c -o 
/home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/output.exe -O2 -g 
-fno-omit-f
rame-pointer -D_FILE_OFFSET_BITS=64 -O0 -std=gnu11` -> 1 
 

stderr: 
 

/usr/bin/ld: /tmp/cccPzS5X.o: in function `main': 

/home/user/.work/qemu/build/meson-private/tmpkoy6pfnd/testfile.c:5: 
undefined reference to `__sync_val_compare_and_swap_16' 

collect2: error: ld returned 1 exit status
-----------

> FWIW.
> 
> /mjt

