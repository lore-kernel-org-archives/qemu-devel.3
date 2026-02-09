Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D13DEF0718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLO4-0000lk-L4; Mon, 09 Feb 2026 02:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLO1-0000kq-VM
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:08:46 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpLO0-0007Dl-9u
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:08:45 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso3524553b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 23:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770620923; x=1771225723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wncuITwrtEChkffVzXmna42OBWtwxX9kHQYFhcI0LHY=;
 b=EMNi583syL7XunjJxkQ/RzsIJViZ4VdOarRIaYBYJR6/6MeSzUl2m4TXk8ct0BngGo
 tv2W18r93EHmBPBsRyPj8Fx/E/g9DjNgjzjxHpquSH5JbC0am42Rq61Yl+gKiD28YS6i
 oF2R6Uv8T2tDixSCrPMo0Dbbr6IG81Qq1bzZuHvHGaHCCfvFeJ54SEkvybA5WJ2PrU7u
 94bmS0ubquXZDUEnk8HQZRKQu6G206j849jEny09HjXYR6R+nDsfAHsyJ7sp+yNbBHGi
 18CtnpJdz7jJsguMu3W/VjUy+Hghwv5LWZSGVxm53t+J4CdEmlS7x+EKZRBo5ST2LbLC
 f9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770620923; x=1771225723;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wncuITwrtEChkffVzXmna42OBWtwxX9kHQYFhcI0LHY=;
 b=AmrFlq5wtONggg8pBqoGQeElWWqfTdFkFsvqmZCbNiR2k4pWxOce/WA1vg2TarOgAg
 U4igCdGbT8yKIiG1uYADyQLf9YodVybhFdwr3q1JmspuvX5Jmh7Y4K5DIgtltBlts10E
 lv11eflgjn2pjazWD+uJL6keM5mr1qP97jRETC56xoI6k0BQr6oli77WYBo2Qq5HO3VU
 mtSLs8xEaN2X3CS2Ao+cjAWCQiLG5PKOqhmr2heefvbiO0y0mmNBv3q3Vmx/kgUGeJDj
 dXgkg2SEChL1Yvzdg1h1yhpp1HXa3JNuGRpolhLpaTSfypKmjkmIXBL4pAxy06EqL5Iz
 azsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4/cDnAKrvMm4DmaiHe6hFYlWhxD+HzsH2d+RqWgWdVmJLOvg0vmyAHeLDxTALug29En0ll8j/M/7W@nongnu.org
X-Gm-Message-State: AOJu0Yymw+SJWF3wXTFL5g3ACNA+XpEOhJg/bmd9sb0ViglaMfLZ1vnq
 vY6SwxKI+d1KTN8psTZgeKvZXL9fCsj1RSHIaG/dqLCw3kxH/G06BOezxqGFGVbkqO3pfBI4N0x
 k/0Dd
X-Gm-Gg: AZuq6aLf1x9vbyb7ChryTMnPhb3rIK1iNMYd10vXE7S4P3j1/nk0Klyrs0sOD/CTZmA
 TK0jm8vnLCxOjvgfzvow2FGsll2zhi3YgAW1na5o9FXRMyL9+aUBBJL/A1vPqgJ+OQg1yjGpJiU
 V9lzNyyYj927TaYgyOb9qZYhtispGld2oNFdoM0JIGbD77P7SOlDlz93vpVNDkJoJmJFK+pVdlO
 JVudMb0/uGPD/uKTTSCyr+aLqT/HgCgKQ5PvQkgU1errl9UTXUxt8w6+trDU9kqTo2t3rYdgYS1
 9tsigpW9EIkbDoACRHu3YwGsNxstjJYcgurNy8VDgW+faREueClM56g3eq2jzwofGGwKimRQ0Jo
 xdM023oT/FHSEhKvSt2Za/Qj2PxPmvAEnXHArrlKxDAGzVlYR2EFikLnE7GpQ5O6Yhq28ZftA5u
 Azhsg7LTDq9qrGo+2+NfaBSGTCq3MQQzMrT8mW6ny8l2jFDZHg9Yg8PhUripkU4y83YhtYCL1Ez
 Q==
X-Received: by 2002:a05:6a00:1253:b0:81f:997e:59a0 with SMTP id
 d2e1a72fcca58-8244176e218mr9717502b3a.64.1770620922529; 
 Sun, 08 Feb 2026 23:08:42 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:7b35:2dcc:ff07:8193?
 ([2001:8003:e109:dd00:7b35:2dcc:ff07:8193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441695f50sm8737954b3a.22.2026.02.08.23.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 23:08:42 -0800 (PST)
Message-ID: <a6320ab4-7ece-4618-8d73-549df7a34886@linaro.org>
Date: Mon, 9 Feb 2026 17:08:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/arm/tcg: duplicate tcg/arith_helper.c and
 tcg/crypto_helper.c between user/system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-7-pierrick.bouvier@linaro.org>
 <6c5eb308-56e6-487a-ad7b-8f0da70ab7cd@linaro.org>
 <e291f290-a188-4106-8648-48d4c464dfed@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e291f290-a188-4106-8648-48d4c464dfed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/9/26 15:52, Pierrick Bouvier wrote:
> On 2/8/26 9:00 PM, Richard Henderson wrote:
>> On 2/6/26 14:21, Pierrick Bouvier wrote:
>>> In next commit, we'll apply same helper pattern for base helpers
>>> remaining.
>>>
>>> Our new helper pattern always include helper-*-common.h, which ends up
>>> including include/tcg/tcg.h, which contains one occurrence of
>>> CONFIG_USER_ONLY.
>>> Thus, common files not being duplicated between system and target
>>> relying on helpers will fail to compile. Existing occurrences are:
>>> - target/arm/tcg/arith_helper.c
>>> - target/arm/tcg/crypto_helper.c
>>>
>>> There is a single occurrence of CONFIG_USER_ONLY, for defining variable
>>> tcg_use_softmmu. The fix seemed simple, always define it.
>>> However, it prevents some dead code elimination which ends up triggering:
>>> include/qemu/osdep.h:283:35: error: call to 'qemu_build_not_reached_always' declared 
>>> with attribute error: code path is reachable
>>>     283 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
>>>         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> tcg/x86_64/tcg-target.c.inc:1907:45: note: in expansion of macro 'qemu_build_not_reached'
>>>    1907 | # define x86_guest_base (*(HostAddress *)({ qemu_build_not_reached(); NULL; }))
>>>         |                                             ^~~~~~~~~~~~~~~~~~~~~~
>>> tcg/x86_64/tcg-target.c.inc:1934:14: note: in expansion of macro 'x86_guest_base'
>>>    1934 |         *h = x86_guest_base;
>>>         |              ^~~~~~~~~~~~~~
>>>
>>> So, roll your eyes, then rollback code, and simply duplicate the two
>>> files concerned. We could also do a "special include trick" to prevent
>>> pulling helper-*-common.h but it would be sad since the whole point of
>>> the series up to here is to have something coherent using the exact same
>>> pattern.
>>
>> tcg_use_softmmu is a stub, waiting for softmmu to be enabled for user-only.
>> Which is a long way away.
>>
>> It's also not used outside of tcg/, which means we should move it to tcg/tcg-internal.h.
>>
> 
> Thanks, I didn't think about moving it somewhere else.
> This does the trick indeed.

You can also make it always a #define.  The variable for user-only is never set to true.


r~

