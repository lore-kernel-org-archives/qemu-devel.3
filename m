Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70754CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBVQ-0006th-Lh; Mon, 01 Sep 2025 16:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBVP-0006tR-06
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:51:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBVM-0003io-Vh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:51:58 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b869d3560so20494615e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756759915; x=1757364715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+bRCLBotJpD0nsAhCQSwG8T/JMPnSdVQ/G/2djp6dKI=;
 b=sGKUNhGqvqydXEZLUfRbZLRBGFVRfxi+4Xak30lyOOykIVhSU2TvlPQPUHlJSGr5cm
 RDizIhVopemBQCaBZYsB+mSuy8+Ao/1JMap9NRnrdX2Gu8pMK61y0zx66ko/R21kcuGs
 7XHHD4rmcyNK93hT8IAWJEOzFofDZWFto7cLSos2UX+mKvDgSkDLGaLsTxNPckehubX6
 W1PQbU6jV59Kv6aOQkeiDGyh0+1NOrbf1We1hQuSmw3kSAkFryI246TmhzbtMqSBSDEe
 QpH0HxutRIB6SM9aRFU+yNoBpJx96bdaUDH+Y5qx+QATb10KZZa78kIKQzx7087HGUh8
 uqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756759915; x=1757364715;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bRCLBotJpD0nsAhCQSwG8T/JMPnSdVQ/G/2djp6dKI=;
 b=YKcBW1iPY9DduXy7yqv4mMaHAvAqyrxeThvoURaaTtYAG4/41xyLXppTP9haMgonBG
 lvv9cvZLRBLQJmjkuPTbj+XsK5Y83K//Rqx87NgJsP8k9ws4MATAOARyzY3t046ppB94
 ehGq+3GZKSS8lzUt0lmCkyDyJsxaQWcYur2n7p3goPUYxyuu0lp132fx2r+QoSr3DIqo
 JzA0MyxRmryuOq0IBGWlbtAeCksagqQ/srQwB6nbQirOXUtiihYL2adT20VXTs8iMhJg
 R7WQFWgZFEI2nDOSfD6ciKCldv+RG4vKOtPSKFOQaDTkCryuQtJ8bq72R6gtqgDSD6sf
 XW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4fRkwWVwz0MymOm2c8VRNtnozeVCy1Y/5oDGscYK3ucp1mCxYxrJ5etFxYS0lOuxF/1wIu7OsM7SQ@nongnu.org
X-Gm-Message-State: AOJu0YxGvRQ+ZzNhf+UqzSX92WJzm3IWwrz9UY2F6brgBvFjl3BoAArT
 0bKVxs8Y+R5U1PLKvB9Tn1kgG792I4j+6ITOPcreuKSOq+ZOQ0eWLmfwZ/Mvzqk3sZk=
X-Gm-Gg: ASbGncs0n8QPEDyy9on/50krFhCgWUC/2h6bdFe9icLe6Vf8fejnomPJvwrlx0NClxt
 qepXnDku0kFyZWo3nY6AxP2BSDwwVkaiZgau84Bq+7lGAEM8DfszNw7AhiXfM/gkp102hsyWOuR
 +Rfg1myT1Hlt9OGTxOx72G/VMLubazODHVhwHNXRAqdHCygjo7nPo4RdUguWBHB1VGCrTGim+Br
 jLk+a0WUHIJ05PQzqqLd/AgpDccDcmjtmNIowIF/7v+3ZPFanLAHB8OYqD6GJaKMed/Yths09uM
 j9dZStyeowW2eHZ6sczetvUJ/nT8/FUvSRZa8ILDEPFTlpBWPg1vEASMR0EK/iG4kKeFi/CJQvj
 CHMdLFtXKSsXR6zSqs2iYoRwxa70C7GQASGXSEFBEhVsr0I19rUM6XWVoIuw+W/BXwg==
X-Google-Smtp-Source: AGHT+IH0mgebDH7ID5UroQ279srsccrFD8RR8Fmskp3G2fyQyV50m6YtWfOJ212rBsGoUwErbf2LMw==
X-Received: by 2002:a05:600c:1d1c:b0:45b:8b3e:9f63 with SMTP id
 5b1f17b1804b1-45b8b3ea13fmr49399695e9.18.1756759915312; 
 Mon, 01 Sep 2025 13:51:55 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d690f2ebb9sm6186540f8f.20.2025.09.01.13.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:51:54 -0700 (PDT)
Message-ID: <68c03c72-a001-40ca-b4d9-acbfbea46d6f@linaro.org>
Date: Mon, 1 Sep 2025 22:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/main.c: compile only once
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
 <20250730220519.1140447-4-pierrick.bouvier@linaro.org>
 <c6b5359b-27d0-4776-9690-7d49debe3d7c@linaro.org>
Content-Language: en-US
In-Reply-To: <c6b5359b-27d0-4776-9690-7d49debe3d7c@linaro.org>
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

On 1/9/25 17:07, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 31/7/25 00:05, Pierrick Bouvier wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   meson.build        | 4 ++--
>>   system/meson.build | 1 +
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index f94209bb301..b72d4ce8618 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4420,14 +4420,14 @@ foreach target : target_dirs
>>       execs = [{
>>         'name': 'qemu-system-' + target_name,
>>         'win_subsystem': 'console',
>> -      'sources': files('system/main.c'),
>> +      'sources': [],
>>         'dependencies': [sdl]
>>       }]
>>       if host_os == 'windows' and (sdl.found() or gtk.found())
>>         execs += [{
>>           'name': 'qemu-system-' + target_name + 'w',
>>           'win_subsystem': 'windows',
>> -        'sources': files('system/main.c'),
>> +        'sources': [],
>>           'dependencies': [sdl]
>>         }]
>>       endif
>> diff --git a/system/meson.build b/system/meson.build
>> index 6d21ff9faa7..f358c2c446d 100644
>> --- a/system/meson.build
>> +++ b/system/meson.build
>> @@ -18,6 +18,7 @@ system_ss.add(files(
>>     'globals.c',
>>     'ioport.c',
>>     'ram-block-attributes.c',
>> +  'main.c',
>>     'memory_mapping.c',
>>     'memory.c',
>>     'physmem.c',
> 
> This makes the build-oss-fuzz job to fail:
> 
> FAILED: qemu-fuzz-i386
> clang -m64 @qemu-fuzz-i386.rsp
> /usr/bin/ld: libsystem.a.p/system_main.c.o: in function `main':
> /builds/philmd/qemu/build-oss-fuzz/../system/main.c:70: multiple 
> definition of `main'; /usr/bin/../lib/clang/18/lib/x86_64-redhat-linux- 
> gnu/libclang_rt.fuzzer.a(FuzzerMain.cpp.o):(.text+0x0): first defined here
> /usr/bin/ld: qemu-fuzz-i386.p/tests_qtest_fuzz_fuzz.c.o:(.bss+0x0): 
> multiple definition of `__odr_asan_gen_qemu_main'; libsystem.a.p/ 
> system_main.c.o:(.bss+0x0): first defined here
> clang: error: linker command failed with exit code 1 (use -v to see 
> invocation)
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:168: run-ninja] Error 1
> Error : Build failed. Please specify a compiler with fuzzing support 
> using the $CC and $CXX environment variables \nFor example: CC=clang 
> CXX=clang++ ./scripts/oss-fuzz/build.sh, exiting.
> 
> https://gitlab.com/philmd/qemu/-/jobs/11205571060

FYI I'm dropping this single patch from my queue (but keeping the
other two).


