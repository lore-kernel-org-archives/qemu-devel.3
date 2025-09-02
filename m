Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA1CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 08:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utMZQ-0003qH-Vi; Tue, 02 Sep 2025 04:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utMZP-0003pr-9B
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:40:51 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utMZM-0000qi-Kh
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 04:40:51 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b0225483ca0so455640766b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756802447; x=1757407247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1k1soRJHK8hQXvXLS2HszFOzrGaxEC+h6a4klkwAdv8=;
 b=GQAAoZwsmdYjKWW5X+axHEOEBh/fBjtoRf8YYKMWkut+69u/xNcPVuMmXNYBPzJv5u
 XUp5xq9C6urDvTAQg2dOUYA2ysF5F2RPjpX77pPJodOe8wj8YEcm1uN7FcK5FS16wk7x
 MU1ggEBkmZCn/1SAfGAd2tl6nGp/l6ryK+Z055Q0A/AtfiDcfSDQkselHGlUB5SyOKx+
 VqBHMmCINeK5QqaCRNwFKGf3yoXYUDT5wyZqNBPN7gKh4jQ0lp6knoVIPaTY+igI5fSE
 aNMc8k50SD2OFyh5VwjeJ/0tgb1zmrqadofcmbtyGRxpfvI/MMP6KtC0meitB0q/wtk3
 yIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756802447; x=1757407247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1k1soRJHK8hQXvXLS2HszFOzrGaxEC+h6a4klkwAdv8=;
 b=t1F4DmhU668eEgBVlmUJs7VtTjEHW1eX5XhhoRWMb5D/iJQeyFef6y8x1IlWqtUczi
 BreuQQsaPqURXlapcaGehHE9SXMCKRnNdhxZuLC71CJPFXqKmnd0+MeSAtkk0FSNFBag
 PV2lWvDJee+Bezuphde6u7ZnpVO1So+IOZxLh+EUCofyffAXu0xlouNT4GA7sKB9ohy8
 tNU1Ea9gOPbcP7NW/wJfw5RUdsN9yOBeRGx6sLDAYzRZ/4V2cq8FU6+NpZP0Bh9HFSbX
 /FfSSIYyA/AWJ6TkXLX8vheXUyjEhHAS71CnM1gCAofzr3/afZ9F9x+wULbNT8dRh5rq
 fMUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFyOJMKB8o8HntORUAiiwFLsTh1tIOG6ck3ycFPc72/8Xx14y/n8fKPtf+KSqroW511t3B0XB1AGuK@nongnu.org
X-Gm-Message-State: AOJu0YxQjZUPt784PWW32++ZwhVt2lIe//vOoGVJ93y+ITxpzWZlsM0s
 srdooTIbzNaSR7+eaoMvYZ3M8/e7m33AQyJ0HylO4/+6zTqJYOwIA+jyQ+5edj74D2W37FQG3LK
 KGZmkOkJcWg==
X-Gm-Gg: ASbGncuVGncRKLTQ56+lXHVpfrhlY5iQFtlJINHZwjREtqkdLZ0Lp30pA0gxPVPW65u
 lgCbRmyxEEGFyv43cD7EBPyxSz9mFBE+o94iEAsnLLhsuv/JNpRzpHm1H8MeHKpYvSPPA1eqd02
 Oqjyjo7BucHR62mHVM3c34yR2kVDRTYSq08xHHLRNika7BRYSNNKhPybNHOCFGWHhS0NgZEW+5H
 XeahWmYmFe4y+js6b1FOd7gGfSZGQrogzFEeG5BO1/BJzqxT6ati7GACgrZGGOmmhwiFtj44RfK
 H3iLxtgzLBWHpdw91t3NcT6qLGQ2Kd0Txb35C3LDXMdmEmTCSy8HXf4ss/tdC883Io+CaEiEW1v
 z53O/woRzK2t2+qFsjAy92pRDRghNOIrSDIDRVQ==
X-Google-Smtp-Source: AGHT+IG/wfUlTZLowf5Ii8PSi1A6aVx12dowyZPQu7zTTXx26tA56Y2UCLaoRzqMQYPxgJP+znBIYw==
X-Received: by 2002:a17:907:2da2:b0:b04:3525:6c5a with SMTP id
 a640c23a62f3a-b0435256f6dmr474164466b.42.1756802427811; 
 Tue, 02 Sep 2025 01:40:27 -0700 (PDT)
Received: from [192.168.23.199] ([193.33.57.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66f2041fsm162092995e9.5.2025.09.02.01.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 01:40:27 -0700 (PDT)
Message-ID: <e8270463-d2ff-44c6-a535-45a393132909@linaro.org>
Date: Tue, 2 Sep 2025 10:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] system/main.c: compile only once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
 <20250730220519.1140447-4-pierrick.bouvier@linaro.org>
 <c6b5359b-27d0-4776-9690-7d49debe3d7c@linaro.org>
 <68c03c72-a001-40ca-b4d9-acbfbea46d6f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <68c03c72-a001-40ca-b4d9-acbfbea46d6f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x62c.google.com
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

On 2025-09-01 22:51, Philippe Mathieu-Daudé wrote:
> On 1/9/25 17:07, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 31/7/25 00:05, Pierrick Bouvier wrote:
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    meson.build        | 4 ++--
>>>    system/meson.build | 1 +
>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index f94209bb301..b72d4ce8618 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -4420,14 +4420,14 @@ foreach target : target_dirs
>>>        execs = [{
>>>          'name': 'qemu-system-' + target_name,
>>>          'win_subsystem': 'console',
>>> -      'sources': files('system/main.c'),
>>> +      'sources': [],
>>>          'dependencies': [sdl]
>>>        }]
>>>        if host_os == 'windows' and (sdl.found() or gtk.found())
>>>          execs += [{
>>>            'name': 'qemu-system-' + target_name + 'w',
>>>            'win_subsystem': 'windows',
>>> -        'sources': files('system/main.c'),
>>> +        'sources': [],
>>>            'dependencies': [sdl]
>>>          }]
>>>        endif
>>> diff --git a/system/meson.build b/system/meson.build
>>> index 6d21ff9faa7..f358c2c446d 100644
>>> --- a/system/meson.build
>>> +++ b/system/meson.build
>>> @@ -18,6 +18,7 @@ system_ss.add(files(
>>>      'globals.c',
>>>      'ioport.c',
>>>      'ram-block-attributes.c',
>>> +  'main.c',
>>>      'memory_mapping.c',
>>>      'memory.c',
>>>      'physmem.c',
>>
>> This makes the build-oss-fuzz job to fail:
>>
>> FAILED: qemu-fuzz-i386
>> clang -m64 @qemu-fuzz-i386.rsp
>> /usr/bin/ld: libsystem.a.p/system_main.c.o: in function `main':
>> /builds/philmd/qemu/build-oss-fuzz/../system/main.c:70: multiple
>> definition of `main'; /usr/bin/../lib/clang/18/lib/x86_64-redhat-linux-
>> gnu/libclang_rt.fuzzer.a(FuzzerMain.cpp.o):(.text+0x0): first defined here
>> /usr/bin/ld: qemu-fuzz-i386.p/tests_qtest_fuzz_fuzz.c.o:(.bss+0x0):
>> multiple definition of `__odr_asan_gen_qemu_main'; libsystem.a.p/
>> system_main.c.o:(.bss+0x0): first defined here
>> clang: error: linker command failed with exit code 1 (use -v to see
>> invocation)
>> ninja: build stopped: subcommand failed.
>> make: *** [Makefile:168: run-ninja] Error 1
>> Error : Build failed. Please specify a compiler with fuzzing support
>> using the $CC and $CXX environment variables \nFor example: CC=clang
>> CXX=clang++ ./scripts/oss-fuzz/build.sh, exiting.
>>
>> https://gitlab.com/philmd/qemu/-/jobs/11205571060
> 
> FYI I'm dropping this single patch from my queue (but keeping the
> other two).
> 

Thanks, you did well.
Nothing critical on this specific patch.

