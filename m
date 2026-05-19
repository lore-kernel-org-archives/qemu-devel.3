Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B7BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 09:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHBn-0004UJ-G5; Tue, 19 May 2026 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPHBl-0004To-Kk
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:56:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPHBj-0000EF-O9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:56:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so27365265e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779184594; x=1779789394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2T0BHAJ0SQL7a8enwXbeL/CX/8FebQzFEYwJmnF7ovA=;
 b=IDTIPDY7p7bU0OumJLzGnP9Re5YuhOYrGrgRkifol91mgssms3mynPFNBrCVmoAM1T
 JIfKgG2Qr9CcxYmdvwuREJCKgtw+/97WheaprqEZXzxoXDHwTYaU7np0IsydbPydKQYq
 QN1pbVqNtPlTEdlnyTq41qpoWN0ODFlH8gD4Z9lcxWn2/2P49sVx7BJ18e47FxmQDzjw
 7TA/tLdNERFu8DPoHwtO/J12c8Fv+nN0nQmtXuOaHmtVueruHcV+5VOSCDZ2alu3Np4I
 7AXxdQxgKfIVxSXqz4PZm0hQSiQivJe/zKRX1WqFi9Rm1uCI73skswIjASR74bxrm7PT
 NwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779184594; x=1779789394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2T0BHAJ0SQL7a8enwXbeL/CX/8FebQzFEYwJmnF7ovA=;
 b=QZOnFpVNzMpD8ejvxbAObS1puZ9GZLzIIx3rKpuChkFxMAWAxZ2vBybd7AhSlsTZiS
 uepLfuOs7DR+8mEwoCdfxr8TIXWseqiPkmrUJGKeqop+301YBcDWX0LXC9ERXL7Q26AP
 97VkUZ6vKUoHdjXKY6a398qtDORQUgNrV9BSpG8V99kjCgsByvwOoNBiemyiky9e/uCo
 tk9R5jqquPGBSplmz7dRpDyjy3WkDOjt1oT3xX+iOKqL7y3s2XI6kIG+RbvGzr38rMVf
 DR+g/geHfdkpfiKH3fkiAPZqVX2LXtRYfOKOGuOjBDXzSVqv6e9Z8ftPDYz5pJxIxeTg
 +ucA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zNhN6zUuRBdt31Y9MucwlTAFQmyLMPkedRpTFKeNKMPS/mp6y1Iq3zadI+O4o89RwzLNVrvHHNVSU@nongnu.org
X-Gm-Message-State: AOJu0YzBRBlkYw5bg0sI0fLq3fVWRW5fr0eMvtltOUvWTLvohPgp0h6A
 6Lfik1gWUWsuSWDQvqa5iBfORqkI5c+Dh3iHe2whLHwpaKIh+g1RvMnDjaQmEcgF8jI=
X-Gm-Gg: Acq92OHMihHbhGi4TmlbcYhafMSSgTRIcQcZMY1bgmxMV5VmpHQFz6DDB2nta7QYQrF
 I2yRobazN+CRiKIqgbp7J/Mj0YLlcDIBKD5KbsmeTp1Ll7ACVDQohiWA2Nb8SIysRltEJQDdB9b
 KGtKsDf4IXGFt4pu7JYl7vGRFOJEospIRxq9LZKnbe+ft9FX6JYve7h/9dzzX+fnSH0PJFhsYYC
 6JBxUy3p6arn0c8A7KygpqUHjdrT0djBXFEq4cAUVYOcULeE3xNX4Ix2WnCQw7miLpwAHl97ART
 ZCZTxCxEZLwRfWCMR/BD/8RFNXqcr8fkEo+3eHxMrMzZjNK3NUA8r4VBWi0F80pgl2pESxnM7Tl
 E1FzWi98c3pOGZqmrgxxRksSvOQZWsaPb7T/DWQly1cZBjdGQkUlv3Fh9SKAtmx3VNM+t3NzDwu
 k6UahLSIYoMiEw7zd9DNTwqY37wgarfbnmiHvFfWdlWIgrEnmQrOBi5FG8vVNjKk80G0XeqtzQV
 MA=
X-Received: by 2002:a05:600c:3b27:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-48fe6516b54mr268701005e9.25.1779184593755; 
 Tue, 19 May 2026 02:56:33 -0700 (PDT)
Received: from [10.139.182.66] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm367663085e9.9.2026.05.19.02.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:56:33 -0700 (PDT)
Message-ID: <7a75e9f1-d7a3-4f06-837e-03cc11969d19@linaro.org>
Date: Tue, 19 May 2026 11:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/rtc: Fix a possible year-2038 integer overflow
 problem
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
References: <20260518160255.1844308-1-thuth@redhat.com>
 <ags5_IDkvxClCdHm@redhat.com> <ags7xIsUG2DqX5vu@redhat.com>
 <dbc6464c-2685-46c4-803c-6af53d345083@linaro.org>
 <c9fa27e3-0939-4490-b350-7a625ebcdcdb@redhat.com>
 <b70b35ef-1761-4624-9f98-7c1ae161ed9a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b70b35ef-1761-4624-9f98-7c1ae161ed9a@redhat.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/5/26 11:26, Thomas Huth wrote:
> On 19/05/2026 11.18, Thomas Huth wrote:
>> On 19/05/2026 10.24, Philippe Mathieu-Daudé wrote:
>>> On 18/5/26 18:18, Daniel P. Berrangé wrote:
>>>> On Mon, May 18, 2026 at 05:10:36PM +0100, Daniel P. Berrangé wrote:
>>>>> On Mon, May 18, 2026 at 06:02:55PM +0200, Thomas Huth wrote:
>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>
>>>>>> rtc_realtime_clock_offset is initialized with:
>>>>>>
>>>>>>    rtc_realtime_clock_offset = 
>>>>>> qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
>>>>>>
>>>>>> And QEMU_CLOCK_REALTIME might be based on gettimeofday() in certain
>>>>>> cases (see get_clock_realtime() in include/qemu/timer.h). So this
>>>>>> counter will exceed 32 bits in the year 2038, thus we should not
>>>>>> store this value in a normal integer variable. Change it to an 
>>>>>> int64_t
>>>>>> to fix the problem.
>>>>>> And while we're at it, also adjust the nearby 
>>>>>> rtc_host_datetime_offset
>>>>>> variable to be on the safe side in the related code.
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>> ---
>>>>>>   system/rtc.c | 4 ++--
>>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>
>>>> Actually on second reading I think this patch is not quite right.
>>>> The code which uses the value is:
>>>>
>>>>      time_t value = qemu_clock_get_ms(clock) / 1000;
>>>>      switch (clock) {
>>>>      case QEMU_CLOCK_REALTIME:
>>>>          value -= rtc_realtime_clock_offset;
>>>>
>>>>
>>>> On 64-bit platforms 'int' was 64-bit already and so was time_t so we
>>>> have no bug to fix.
>>>>
>>>> On 32-bit platforms the patch fixes 'int' to 'int64' which is fine
>>>> but that int64 value is then subtracted from time_t which is usually
>>>> going to be 32-bit again, unless the OS was built with 64-bit time_t
>>>> on 32-bit which almost no one does.
>>>>
>>>> IOW we only platform this fixes is 32-bit OS with 64-bit time_t.
>>>
>>> "32-bit *host* OS".
>>>
>>> Per ./configure script, we still allow:
>>> - x86_64 x32 ABI      (CPU_CFLAGS="-mx32")
>>
>> We should maybe deprecate that x32 ABI ...
>>
>>> - sparc32             (CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc")
>>
>> ... and that one as well?
>>
>>> - s390                (CPU_CFLAGS="-m31")
>>
>> Uh, we really still allow 31-bit s390 hosts here? I think this could 
>> be removed nowadays, also upstream kernel recently ditched the 31-bit 
>> userspace:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 
>> commit/?id=8e0b986c59c67e08ada646249f834655a9e6da16
>>
>> Question is whether we can remove it immediately, or whether it needs 
>> to be deprecated first?
> 
> Ah, wait, we completely disallow disallow 32-bit hosts nowadays:
> 
>   https://gitlab.com/qemu-project/qemu/-/ 
> commit/372ec46b9f1215f48a4717f2b7ed969f65bfadc6
> 
> ... so these checks in the configure script are just dead code nowadays 
> that could be removed now? Or is there still some hidden magic here that 
> depends on these lines?

Ah think, I remember reviewing something like that but was looking in
./configure history and forgot to look at meson.build. So this is indeed
dead code.


