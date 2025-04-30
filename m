Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0994C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8af-0003bc-9P; Wed, 30 Apr 2025 10:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8aa-0003Xw-OK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:39:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8aY-0000Mw-F2
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:39:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso954079b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023944; x=1746628744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iziWfrMDATuxJ1oC+ojZYKc0BALl3/NiumthM8sV9aA=;
 b=J358znd/QN0GmLRUYQ5/+1Sg3ZLCth+lVb3NC/z9RX9aIFp0RN8wR5IzwJ67LE4l3X
 DNTjOAhzlx8dFogIGhr4sueb41sC4Ay0k+Ki4e4ATgUfyt4zZdWuT8pz2eK4TcF46E/s
 AQ/pWnwKNnxr9tUp8P2WpXW06xZimaIvXBDAMn4348rzElKqXeowGCMvtipNbmXB8X4L
 fBmAon45aZ6etKsT4Ayfo3IELPjTzKn+aIqoF3g+wBAD/5CDKgQWrg0+QbhPUaXW+j2z
 WECSq8SQQxCEvLeoE+6CkYXxHzuX3yAnJVTgdKjiIdyRCsLI/xKLDmbhuPXcP1eVtfkC
 RIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023944; x=1746628744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iziWfrMDATuxJ1oC+ojZYKc0BALl3/NiumthM8sV9aA=;
 b=sOHNQxL7wRcV/8cMrAgQGyCSTHS0Fxh8U/wPWfvKKfe0Dl8p6TV2ZGXGSEBImi1wox
 lkCPBwS9TtZ3aPGE7iEGPlSvCSF/uepFB1ZTwkTNNbI7TzV34MbwouBAKZn3ZZ3WwRNG
 C+PXsHqaTNGdWshuYgo9kvOxDUnypr4KGmyuVAy/jyDHCCToFGQ2CrfuegmThikI3Qvw
 h9jsP7S/nfNTGVMSOzKMG/koc12QhoUneQZDojND4SF+/pxblMKWlFV4kuckCo7zt9Fi
 LeC+MBLV0dyPxB5HZ8dr394bYXWqXwSN85kxdaY/Qjh0G4lczVUyzA3WsjVb8GoJk3Cz
 GrSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQidL+iZFMZIRNaf9kMi2hrFlWZroIOvxPCHM3jEXoMieHd33kHwRKroCtWS5gbc1cjJjHbujlnaJK@nongnu.org
X-Gm-Message-State: AOJu0YwWSsXOnGjsPBcjC7HSUlxo63cL12sl2IufraCRef5Nf8dqjbqo
 ONBOKYTvTaQtQW2Uqgj0SedKb9P+U9C0HD0BtMA58w9oGuApvDusDzg9RrLmwIU=
X-Gm-Gg: ASbGnctaNUcLBKlWEHrY4HTKktpKPJOYjbqFyAgs9gpTe9UTl+/HrIBDBq1kw2JyRgN
 eUc8aa5OxDEJNgfrjaF+yxpmPMvo3G27WjnwjUmyU+Sx0S4P+f0FKrWHOAlgj/m4ziaH7SmH6Le
 eAIGCHE6R0n5aagxX9stVRF1FN3IEsQKYex9Ju5cikvaPC/7XFYpvDZZlpZYarqIc4D6+7pwgbQ
 pHo6tgW3S/VSWx4fx+Rn2AZlVpPAObL0X0B+5xdW9Y3B2s8+CuPc5Pt1dIXX/tfbb+p++cki0i3
 ztDfGYGrXF4KeEhL+KXYx3Q2w2mBJRxWbnVz9GX5NG+N87nedNXqmg==
X-Google-Smtp-Source: AGHT+IFcck6NA9HJOHtUow4q+rzz7NtoeM0eMYtAmia6Q8OUDHFTb0ZXMo62jznlQs8eQn2j8n6ExQ==
X-Received: by 2002:a05:6a00:1482:b0:740:6f6:7338 with SMTP id
 d2e1a72fcca58-74039a72143mr5121218b3a.3.1746023944135; 
 Wed, 30 Apr 2025 07:39:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a60099sm1765126b3a.140.2025.04.30.07.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:39:03 -0700 (PDT)
Message-ID: <793e4cd8-b18d-4ee7-833a-8415cb79cc05@linaro.org>
Date: Wed, 30 Apr 2025 07:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/arm/cpu: compile file twice (user, system)
 only
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-13-pierrick.bouvier@linaro.org>
 <dbc62384-b05e-4f30-b82a-395a82812f65@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <dbc62384-b05e-4f30-b82a-395a82812f65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/25 1:32 AM, Philippe Mathieu-Daudé wrote:
> On 29/4/25 07:00, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/meson.build | 8 +++++++-
>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>> index c39ddc4427b..89e305eb56a 100644
>> --- a/target/arm/meson.build
>> +++ b/target/arm/meson.build
>> @@ -1,6 +1,6 @@
>>    arm_ss = ss.source_set()
>> +arm_common_ss = ss.source_set()
> 
> Unused AFAICT.
>

Yes, I was expecting some files to eventually be really common, but so 
far I didn't find some in target/arm.
Same comment goes for the patch 3 with associated target_common libraries.

I'm not sure if it's worth saving the lines (especially in main 
meson.build), compared to the "pain" for someone to have to write them 
later.

I don't mind removing this though, if you think it's too bad to leave 
this unused.

>>    arm_ss.add(files(
>> -  'cpu.c',
>>      'debug_helper.c',
>>      'gdbstub.c',
>>      'helper.c',
>> @@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
>>    )
>>    
>>    arm_system_ss = ss.source_set()
>> +arm_common_system_ss = ss.source_set()
>>    arm_system_ss.add(files(
>>      'arch_dump.c',
>>      'arm-powerctl.c',
>> @@ -30,6 +31,9 @@ arm_system_ss.add(files(
>>    ))
>>    
>>    arm_user_ss = ss.source_set()
>> +arm_user_ss.add(files('cpu.c'))
>> +
>> +arm_common_system_ss.add(files('cpu.c'), capstone)
>>    
>>    subdir('hvf')
>>    
>> @@ -42,3 +46,5 @@ endif
>>    target_arch += {'arm': arm_ss}
>>    target_system_arch += {'arm': arm_system_ss}
>>    target_user_arch += {'arm': arm_user_ss}
>> +target_common_arch += {'arm': arm_common_ss}
>> +target_common_system_arch += {'arm': arm_common_system_ss}
> 


