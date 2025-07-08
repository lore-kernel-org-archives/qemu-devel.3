Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C0BC83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIc-0005V9-T5; Tue, 08 Jul 2025 16:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZEBt-0003Ai-QQ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:41:26 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZEBr-0005wp-9l
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:41:20 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735ac221670so174359a34.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003678; x=1752608478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q40TJECRtsoWYxj1GirxFEvv6aJHogSk5BYPRSgd0sk=;
 b=urx2p9N3RfI5AdgpJCpZzECLWTd/i64AuVkLOdlOJJLM/MWnyhXujKnUcj/12kYnRn
 G59NdUxSnvolKzQSJnh2T0LzOLAlwslSXDBqt4P6hZQb53wrWGRmVp9IHI8yz10uHuR/
 Ezt0Kt1Ri/0aWdkrP5WQ448/8Pv4tVvgo3JatNgGxfGp42a7XtR8PbdbWScpu/UHBQHG
 x3rXRsXodwKvbopLTnXDBxoKFkNHdUs5kQSXcle4svutGnKSIJ9+T8BCjBMFPUOidVHt
 rVcEKPHg4NZrDJeNyQ4oNDCLJPm+UmpyjlxV+cfAtpAQUKUyvxbdVETLAQfjet5vwcJx
 HI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003678; x=1752608478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q40TJECRtsoWYxj1GirxFEvv6aJHogSk5BYPRSgd0sk=;
 b=gaKmUI2nFtEhRj3PXqgy8PM4Lv0VGcDO7rWrkBbpI1d19wSkXvyTGcPS9MyYqJ2RIQ
 95JvM4ba7fEtB68FkoiGfn4Lmnf7tf7ngKok23IYnv7iJKdNt6z9CjOeDFkHiivjgOe8
 lpErBEiKXFj718M8x3cOf5r/zFvv5mXoAhT8PsaTIJbcAslFPrcrcC/QqZEhDd2N865F
 R08F2MdJTZtRkmz+qbjNi4C2Vywe831wWkonbMF5cujzbxxwodQAWgypOqRbP6MS72HV
 zenStrIrPNdCl/Bsu0nrfoyDwNFCrsmSM+O/i67eI7d7yCpAcytdsZRLOHmon8WTt1CX
 Zj/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm/8yIf5JvxEKESmt1MSkrCn06SlFkYDLgoLiLkcUezcJoT3S47cKHWscR3CTu9wD2GDdloF4nJT6+@nongnu.org
X-Gm-Message-State: AOJu0Yzh/N4DDJ0I1nuajpE7MTFqqdyu49lAGyW/AngIPPgfJU2SEgK1
 oyGyQaR21XjAn9ZBfHFZJRMxgQISIdOqhOYc1jlpCs7ov+J1V/5x4nrcf0v8zFSRZDPUnB16lCL
 VZVRk
X-Gm-Gg: ASbGncupU/v2LIfCMPrIXvmpFyjWeCiGXewzPGmQ1Dydc42Xfls57gbkpd1ZB4mWuHj
 kkYcOL0efbYJCHYZ905+lk6tNhKSayPBzhUR3xysVcFoXS/qMOxg2CKHcJI/IYoYo1EFDlHA1w3
 sPl9kbmPutwS7OxOh9r9TvmnqXwT/QTigJGTuwyn65VXmAHzpV98SCRY2fAmFMiaI63eyBvhJ3T
 OWYnXBOxV6yvLhng78HcoLrKUZ8icNL2mnvV0NE9KmtvM9JKvkwqaVsV9lepI+XXw69jkIQIX3/
 NY5MtVa15kEriaaykdPRm0rlucG97YwiG/Bg3w/aGVhET9mZs2McnwiRpYOgpzskE/O72KTeVdA
 =
X-Google-Smtp-Source: AGHT+IEPeT/Km4WbyjqbZVAX6lYs4xjzM+Ya3iiGyfWUWzKkFv0M7feVfKnjL94eFZRFDnweW6d8ng==
X-Received: by 2002:a05:6a20:9185:b0:228:6699:87ef with SMTP id
 adf61e73a8af0-22b674b7edemr5163376637.13.1751996606416; 
 Tue, 08 Jul 2025 10:43:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce359e9b0sm13007021b3a.16.2025.07.08.10.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:43:25 -0700 (PDT)
Message-ID: <d5806fdd-3b1f-46c2-857c-a749f6bc4ee5@linaro.org>
Date: Tue, 8 Jul 2025 10:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Controlling time in QEMU
Content-Language: en-US
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
 <aGbp6onOanCKHzl9@gallifrey>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aGbp6onOanCKHzl9@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x32c.google.com
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

On 7/3/25 1:36 PM, Dr. David Alan Gilbert wrote:
> * Pierrick Bouvier (pierrick.bouvier@linaro.org) wrote:
>> Hi,
>>
>> I recently needed to slow down time within a virtual machine, due to a
>> timeout being hit because my QEMU binary which was not fast enough (gcov
>> debug build if you're curious about the use case).
>>
>> Currently, people tend to use -icount shift=X with low values for that, as
>> it roughly maps time to how many instructions were ran.
>> As well, I've been working on ips (Instructions per second) plugin [1],
>> which allows to slow down QEMU execution by sleeping, as suggested by Alex.
>> It's using a new clock update API [2], that is limited to move time faster
>> (jump to future time), but not slower.
>>
>> After looking at how all this implemented, I am wondering why we don't
>> simply fake real time QEMU is using as a reference, which is based on
>> gettimeofday [3].
>>
>> Using faketime, which fakes gettimeofday I've been able to manipulate QEMU
>> time:
>> - faketime -f '+0 x10' qemu-system-aarch64: boot timestamp is 14s
>> - faketime -f '+0 x0.1' qemu-system-aarch64: boot timestamp is 0.13s
>> In both cases, the real boot time (QEMU execution) is around 3s.
>>
>> It works as expected, speeding or slowing execution without impacting QEMU
>> speed itself, which can run without needing to do any artificial sleep or
>> clock manipulation. If a program in guest vm sleeps with an absolute time,
>> it will be multiplied by the factor, which results in significant slowdown.
>> But it can't be avoided, by design.
>> By using a time factor big enough (x200), it can even trigger rcu_preempt
>> stall detection in Linux guest kernel.
>>
>> As it seems a bit too good to be true, time for questions:
>> - Has it already been considered?
> 
> Not that I'm aware, but there are a couple of things you might find useful to look
> at; there is the'driftifx' option with the suboption 'slew' and the LOST_TICK_POLICY
> flags (and option?) - I've never looked into how they work, but they're intended
> to correct qemu time slowly in some cases - maybe it's a hint to places to glue
> such a hack in?
>

Looking at it, it simply delivers more timer ticks at a faster rate when 
they were missed in some cases (like when guest is paused). It's quite 
different from altering time for the guest only.

> You talk of using 'sleep' to slow the CPU down, however there is some code
> in migration to slow CPUs down (but not clocks) to limit the rate at which
> they generate migration data.   I think it's more subtle than a simple sleep,
> running something on each CPU thread to sleep.
> 

The 'sleep' approach mentioned is used in plugin ips, but it has some 
caveats, as explained. In this case, we just can slow down execution by 
blocking cpu run from various plugin hooks. There is no simple solution 
to accelerate it.

> Dave
> 
>> - Any obvious downside I might have skipped?
>> - Would that be interesting to offer such a feature in QEMU itself
>>    (-time-dilation 0.10)?
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/72db6d54a4a9203736261fc63f32f6cd3486b7e4
>> [2] https://gitlab.com/qemu-project/qemu/-/commit/847a65dd76bf1868c7966a2b2608dcd00cb68dc7
>> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/include/qemu/timer.h?ref_type=heads#L809
>> [4] https://github.com/wolfcw/libfaketime
>>
>> Regards,
>> Pierrick
>>


