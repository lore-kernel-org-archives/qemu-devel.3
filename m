Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F3CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 19:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGNLh-0004Sl-3A; Sat, 17 May 2025 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNLe-0004SE-Oq
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:37:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uGNLd-0005I9-2I
 for qemu-devel@nongnu.org; Sat, 17 May 2025 15:37:30 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30ecc762cb7so188759a91.1
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747510647; x=1748115447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=10hX6Q+1OrOgjAPV9493bgUcrcKxm4vjmiw0W+KbRzY=;
 b=oFjy4C/tMjAu9FTabcMUVMPALPkjHMRfy2AjQPxsCv8wf4GbLVjP5jn2p9VlhqhegK
 Sq6ypXTWoeuqtTfHTWkVCfZ9UDDbB/MglI2/TDuMsTXrxQs1QkQBLRsCTeiPPNziotwD
 SBjRN5SegffagmZ0e9323UbTFB6OYzpG52SsNiKTGAs2ns0t2WW0gnQmJVV+9nZqn2Qv
 O3p3okMZhSHuqmjs1HrCl3owid9D/BFxqHm7jAsqOgYz++EP/VXhDTWd5EIN1lcc6Q3P
 ZeiID4Xmi5bCaWhQPbp6rBSagj9JyuShvFQ3uSA9nP3PxuHyFz9ThsqjmPjp9AgTQNt2
 FF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747510647; x=1748115447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10hX6Q+1OrOgjAPV9493bgUcrcKxm4vjmiw0W+KbRzY=;
 b=rLpHm14WKc4rIEBvzKif2vcONOzG6unOJQFGQYegqAqQLE5YOFXqXcyx8/8Fu2TnAb
 brCB11gW7BDgKXy675Q2dS6v0L22HVJ8ziKP17gbde71Xo395DetgjcHkuppWrePTnSX
 v5//G+XCA4ODPpEwzhEyNy1XWLeC+zyj60GKUnj2zsGTWjfCsBhQ4xLbsZU2Oei+w2IG
 C8nXcTRpW/qqsojXpARaU5kJVdI7SD2qud4ydQpwjr2CHniUDM93q2NXA2S+idOe4kQH
 s8txtUrHir0hAwQ6Hl0zZB8QpyTs3eE1Qx/dbBfWAgDpu9N5as/aIwy1jlIP7Tx1ZBjE
 fXMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUatewRRLAdzRcWEEEML3MTpxbOgVqfkWMkwSnt0t7HcZZC5TcU5VooUmtZ1Lt0sHWfu689MNbgB8T7@nongnu.org
X-Gm-Message-State: AOJu0Yw4/sw0OfCCyCuz5P1ksNhkEO4vvPXsudbfEc5B5ISmZrNHdG7s
 MrzquWXm7jaOnMrpUnfELeX86po+SuIsAskdNhkHD5OknLfA5SyrdL4OJafkpndtt9k=
X-Gm-Gg: ASbGncszanYJ/kGRKQUPyG4Du8J+xXLrA0ESCCyZtdzjnEAcsM3eu8ffRgpNRJFWkz2
 QEPPr+3X7celOtGgSjsGyoWWcNef+FgzAlqX2fGhvgBRa5OWCgUTaGLwWb+YMlMCBNyImDSpxXR
 bsG4NXEytkOsXMDEZzDwqDnAdazYXpLC/+lI+x/rJKVu9HIi91fYlaNFWZRYCaKweJJwzf9tq+U
 RzJdPvrS5SVxMUV3PuKkU+xQ9Wk+NkdCpZNwSo/ZhmP3DMUBbQvmMliSbvN8NPwScGI4lp1pWAf
 tyka3aHgqmkR0ZlVrx+T4l4gIc7ZLc75bg7OJdiFEsVgiZ7cm2s3d9qxXrxf8odfr4JhbBoJYdY
 =
X-Google-Smtp-Source: AGHT+IEoWF/bhK1MTOjLpgpm8XdSek3ndEngZqPp1TKGmpfEDUW7nTwyZBjPm3r3U8gs/Wp1iL6eNA==
X-Received: by 2002:a17:90b:4987:b0:30e:9349:2d8e with SMTP id
 98e67ed59e1d1-30e9349311dmr8191252a91.7.1747510647342; 
 Sat, 17 May 2025 12:37:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf8e090sm3513198a12.38.2025.05.17.12.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 12:37:26 -0700 (PDT)
Message-ID: <c9aea7a8-f6e9-4969-ad85-c53ccda74a2e@linaro.org>
Date: Sat, 17 May 2025 12:37:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: build target libraries with common dependencies
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-2-pierrick.bouvier@linaro.org>
 <e270f781-b328-4aba-bfe6-b61516f7b286@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e270f781-b328-4aba-bfe6-b61516f7b286@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/17/25 8:00 AM, Paolo Bonzini wrote:
> On 5/16/25 07:27, Pierrick Bouvier wrote:
>> @@ -4131,12 +4137,17 @@ common_all = static_library('common',
>>    hw_common_arch_libs = {}
>>    target_common_arch_libs = {}
>>    target_common_system_arch_libs = {}
>> -foreach target : target_dirs
>> +foreach target_base_arch, config_base_arch : config_base_arch_mak
>>      config_target = config_target_mak[target]
>> -  target_base_arch = config_target['TARGET_BASE_ARCH']
> 
> Each target_base_arch is now processed only once.  Therefore, all the
> "if target_base_arch not in ..." tests can be removed.
>

Yes, that's a good point, thanks.

>>      target_inc = [include_directories('target' / target_base_arch)]
>>      inc = [common_user_inc + target_inc]
> 
>>            sources: src.all_sources() + genh,
>>            include_directories: inc,
>>            c_args: target_system_c_args,
>> -        dependencies: src.all_dependencies())
>> +        dependencies: src.all_dependencies() + common_deps)
>>          hw_common_arch_libs += {target_base_arch: lib}
>>        endif
>>      endif
> 
> ...
> 
>> @@ -4179,7 +4190,7 @@ foreach target : target_dirs
>>            sources: src.all_sources() + genh,
>>            include_directories: inc,
>>            c_args: target_system_c_args,
>> -        dependencies: src.all_dependencies())
>> +        dependencies: src.all_dependencies() + common_deps)
>>          target_common_system_arch_libs += {target_base_arch: lib}
>>        endif
>>      endif
> 
> There is no need for two separate libraries, since hw_* and
> target_system_* use the same flags.  You can do something like
>
>     system_src = []
>     if target_base_arch in hw_common_arch
>       system_src += hw_common_arch[target_base_arch].all_sources()
>       system_deps += hw_common_arch[target_base_arch].all_dependencies()
>     endif
>     if target_base_arch in target_common_system_arch
>       system_src += target_common_system_arch[target_base_arch].all_sources()
>       system_deps +=
> target_common_system_arch[target_base_arch].all_dependencies()
>     endif
>     if system_src.length() > 0
>       ...
>     endif
> 
> to build the two arrays of sources and dependencies.
> 
> If you reduce the libraries from 3 to 2, you could call them 'common_' +
> target_base_arch and 'system_' + target_base_arch.  That's more similar
> to the existing libcommon and libsystem.
>

I hesitated to do it previously, so I'll merge them together.

> Paolo
> 

Thanks for the review,
Pierrick

