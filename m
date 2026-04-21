Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5433BF94CB4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJKF-0002Io-A5; Tue, 21 Apr 2026 18:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJKE-0002Ia-70
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:12:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJKC-00056V-Br
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:12:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so77535595e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776809526; x=1777414326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+4wOKRADY0YHcqmaeXM8QcLpvgEPE95aCb0ZiNm554=;
 b=RUt76ZKi0UDDxOY046l0qZjFjNXPkzff+rUdexg3UYKNshyR1XIdzOKLWC4sfep2Z/
 PichzqKwV09CQUvYtLNPXGRtBUFWW3aepGhJ7PeM692xrdOCtcT/67S5yAstsNXVP5l+
 Ymy/zSOIW+dpkosjxIvpiXM7NDUQ8FeWIIEsMhGdxbMv8IaT1F9C5uUgvVJhKrU5hoPJ
 bQdR8hbTlqbKh/w76T37aSvDSne41NrnjYkkKxVvm4gm6wQB2Ey4uH7GTGs64WNE5qYD
 elm4U4QSojJ5/45aI6pKwyZyT5UKqFfGhuE36H15gnp6VswJ5WhUnF55ujwj/Vi1w9ob
 h/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809526; x=1777414326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+4wOKRADY0YHcqmaeXM8QcLpvgEPE95aCb0ZiNm554=;
 b=W+n1sBzueB5hAZnK3f0Rbg7gzyVpoMdvzpzKu3bQhUAdDZHq1s9x/bTHE71mN+G9wH
 hqA3hJTwOjmFG7OceInRR4428Y7WXU3HobFHSggH1Da7G/Qj8YYscs3RvKizI1lRd50N
 FeWBOiR6fWo3obhCEckrp9Badcoe7z44k86Q2vmvRy1IxNXTxQ1IuN9kj5o03zdYVgNA
 YsXgJ5TvF057/m5+Gurla14O9Rn7c7LPS6OJNExwjArytMLY8dXKra9mPbCnryCFAbLo
 PfeyVhErH/Nh56lDkbRh3im5M8qk0AmFuXGEqZNEEgtPGuZyToATVxHf27IGZvJy3XRe
 eiHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W+KjaVR1g5emALtrmF7tyTUZLJU/kYEI6v5Z4c8pJzBhMK1jD9XP/LYdZGFFnoFkW5ynEOkOSWD8R@nongnu.org
X-Gm-Message-State: AOJu0YyuwI5WJPDXjrSFmuM/tLA3eOmiVBBHyx6zZtbUFs6Zp0HU+Duh
 jxY0KpwE8tKJfDhqo1NUNBs+iFtm+yXoQs2GC7sB4YXTBvHBi5rQV9Tj+z+u5VPMLo8=
X-Gm-Gg: AeBDietSxHmugqTkZa8vBU8eApP4VTZEas7gKwJofxwLIQx40+zfYm60TYAQ/17d1pw
 BgjJNFA4OrHiKi3XdQuP4QmhkqbnK4epLs0Um/cbzaHLe8ynA+Hq9KfzgM7uaivrzCMMvunisZe
 dQysWJus3Eyh730R9mBVD0GRDr4Wcp6td2IbV+qrbJWirfVjzAojVD4XllSfXOad0N0YITWsLDt
 vx/xWYE0JhAdbqw6Y2vEqVZ91zEjsdDkuMuOX7z93nbKy6ChuAdQcGKVV63xQjlS0+C/ZGQDuev
 4+4NXyzdXbfVIl5aIwS3t+jgluJExSqWpPZ/yMvzHvj+tHmNv2j8PMrtNd2eipHmg/mLfGlq9id
 05BC/coWeL/q0q7RIgzB3nsoS/WgcGsYhTzbXqww0ACCw8xQwrtzHSqkCaK1tYdQJ2FnKOOSNYa
 IMby5CqbRllqkHyiN1Usbiodrkb0hSJnXYDgVAu3ooW6TWVhJNHGbr31tKq764NJRszGhld4R7g
 e3W
X-Received: by 2002:a05:600c:2e42:b0:489:1fa4:50c6 with SMTP id
 5b1f17b1804b1-4891fa451bamr69584445e9.20.1776809526316; 
 Tue, 21 Apr 2026 15:12:06 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm383721295e9.0.2026.04.21.15.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:12:05 -0700 (PDT)
Message-ID: <135474b6-36da-4ee8-af75-6312805e4ac4@linaro.org>
Date: Wed, 22 Apr 2026 00:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
 <c2c0386f-7141-4845-9d95-adb3927d5054@linaro.org>
 <beefeef5-96ba-4645-a01a-7ca96055d93a@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <beefeef5-96ba-4645-a01a-7ca96055d93a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/4/26 00:08, Pierrick Bouvier wrote:
> On 4/21/2026 3:02 PM, Philippe Mathieu-Daudé wrote:
>> On 16/4/26 23:03, Brian Cain wrote:
>>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   MAINTAINERS                                 |  1 +
>>>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>>>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>>>   target/hexagon/cpu.h                        |  7 +------
>>>   target/hexagon/cpu.c                        |  3 +--
>>>   target/Kconfig                              |  1 +
>>>   target/hexagon/Kconfig                      |  2 ++
>>>   target/hexagon/meson.build                  | 13 ++++++++++++-
>>>   8 files changed, 32 insertions(+), 9 deletions(-)
>>>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>>>   create mode 100644 configs/targets/hexagon-softmmu.mak
>>>   create mode 100644 target/hexagon/Kconfig


>>> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
>>> index 528beca3cd0..bc7a292e47b 100644
>>> --- a/target/hexagon/meson.build
>>> +++ b/target/hexagon/meson.build
>>
>>> +hexagon_softmmu_ss.add(files(
>>> +    'cpu_helper.c',
>>> +    'hex_mmu.c',
>>> +    'hex_interrupts.c',
>>> +    'hexswi.c',
>>> +    'machine.c',
>>> +))
>>> +
>>>   #
>>>   # Step 4.5
>>>   # We use flex/bison based idef-parser to generate TCG code for a lot
>>> @@ -262,7 +271,8 @@ hexagon_ss.add(files(
>>>   #     idef-generated-enabled-instructions
>>>   #
>>>   idef_parser_enabled = get_option('hexagon_idef_parser')
>>> -if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>>> +if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
>>> +                            'hexagon-softmmu' in target_dirs)
>>>       idef_parser_input_generated = custom_target(
>>>           'idef_parser_input.h.inc',
>>>           output: 'idef_parser_input.h.inc',
>>> @@ -390,3 +400,4 @@ analyze_funcs_generated = custom_target(
>>>   hexagon_ss.add(analyze_funcs_generated)
>>>   target_arch += {'hexagon': hexagon_ss}
>>> +target_system_arch += {'hexagon': hexagon_softmmu_ss}
>>
>> Pierrick: is target_common_system_arch[] still relevant for a target
>> which use fixed endianness / wordsize?
>>
> 
> It guarantees code doesn't use any target specific identifier, like 
> accelerators related for instance. Common really means "Does not depend 
> on any build generated target header".
> 
> Of course, if target comes in only one variant, it does not really 
> matter, since files will be compiled once anyway. But I think it's more 
> future proof to consider further variations could be added.
> As well, it forces from the start to do things without relying on 
> compile time defines, which IMHO, is a big win.

Thanks for confirming my understanding.


