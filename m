Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF5EE81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 17:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpVWO-0004YT-Ro; Mon, 09 Feb 2026 12:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpVWN-0004YI-Qb
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:58:03 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpVWL-0005Jg-CS
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:58:03 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f47610542so3137976b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770659878; x=1771264678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goZOlZLCqcIlvHYlFxEFSnDWqilzIfXz2/b0/0428dk=;
 b=cPx/TIM7SiuKgAAe7ow9G5HytNamxsfc49dbS9KsxLEAhqishLmdrwIk2fcWbbFbkp
 CAmcY5jOKz2IPQnn2UsT6SSBFCX1otK0M9NIwqdzCGv2W7CpCwRI+gyPNnLja8T9baTi
 XUiVJfAQNhDQp3hgY+r3X70VMqengjcRuDT+fFgkD0gxlMW8CKw9EEOKXBS5aIFEs9C3
 AwGtB1W5/JQGNfJRJv31ICeVCdCPhiZLFZmm1W2tTzDC+/5zmaI6Wyf5of4dm1I21+vn
 9Ge2Fa4nPErtKMLOPJd2vZGPPMKRzgxRsIOtQjFE1+m26XZdIAeoUwWeQhPTpbuz4D0A
 I/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659878; x=1771264678;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=goZOlZLCqcIlvHYlFxEFSnDWqilzIfXz2/b0/0428dk=;
 b=Uq0e559BCwC9ybBE2golgxYvprZe2Vgx++hzR51uz+65kb6p1nC5G+7fvZOKln5n4e
 ygUKPt6RuSkiKGCIMaSwYBbo1tcylx+qfexTDyhrIWFdYf3hvwnyw5mcpQl6QFWKtBf5
 tfhQa/k4kQlJYw1xkCohyTim2xvb7yayLJaDL8GX5vtHJ9WM8dqr249j5MWbbMwQH6t2
 S9av+dmXNTDWTn02p2L+7BS/x4XGz3LczWontkn+RaqvgAmkrQytuwR3E41PU7ySZ5oJ
 3CBSRu7J1kXSntopR8K7K3FtezwEFCggshyZyiVYfYJrDpw77ZGCh0z1hdUyHHXsLt+T
 dU1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwvHF6t30mK4B950hZpmHXXQmloznGocodw5r8h4g6sTMYGJ7/d3ip3shDjyMdVAuF53+h50fAIN7+@nongnu.org
X-Gm-Message-State: AOJu0Ywi7A4DQAjCJqgDAkwYJpL/WWAlMAFc6yMow/GDQ7448+NHcH91
 TmUAcubdliUqYB8A75T6Q70WmV32hwF8YfXL6H+o2AuLwCbRic9lG1H1BBOakzahiEI=
X-Gm-Gg: AZuq6aKlU+vhTxHQddRI4vmqfV2CYOQz7Tc0uIdQbJwa5Jq31d/ML1VidoA1xJZM5yr
 54ZFsxLEH7xR294f1UswX7GLF3K0g8MiTE3kEdVw7ZLCfj9sIbRnrtgQYiNnKD5AEPN7xU2ZwHF
 gFLkgc9FTBkR6DmdM27x1i57PMxwFNEd7+nJ60xo/3r3zsGWP63WzuETE1ogls3DPBJcteTHW+f
 LlLX/vdoI80lLxsHB1r8eM2hxJ1O5AgaeDmKg8xz7bIJh0TgQFPdju43hyzB9uajzsEaxwx3+AC
 1UOPzkkMLY52xZW0RdflYrfjO6Ah96HcPw1Z3LvOS5bUXYWICYcOdu7UnJOoPRfuZvrHORHaRfe
 6pmwrac7Za5WXtxMkYQjzW5PSb5VGtRKL7M6lXQE2MeI8wJNynPwm7dW9yRUjgYdoRtm6GAgLBS
 V4HynIYYkxics7hLuRH3dpID7J4RBLDv3GQ4+Skeb9vdhKMvVVzdgybzQv
X-Received: by 2002:aa7:888f:0:b0:81f:41c8:765a with SMTP id
 d2e1a72fcca58-8244160089amr11519701b3a.4.1770659878485; 
 Mon, 09 Feb 2026 09:57:58 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418b60easm11015905b3a.55.2026.02.09.09.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 09:57:58 -0800 (PST)
Message-ID: <c0b0691b-3cef-4ec7-8d68-227420167481@linaro.org>
Date: Mon, 9 Feb 2026 09:57:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/arm/tcg: duplicate tcg/arith_helper.c and
 tcg/crypto_helper.c between user/system
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
 <20260206042150.912578-7-pierrick.bouvier@linaro.org>
 <6c5eb308-56e6-487a-ad7b-8f0da70ab7cd@linaro.org>
 <e291f290-a188-4106-8648-48d4c464dfed@linaro.org>
 <a6320ab4-7ece-4618-8d73-549df7a34886@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <a6320ab4-7ece-4618-8d73-549df7a34886@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/8/26 11:08 PM, Richard Henderson wrote:
> On 2/9/26 15:52, Pierrick Bouvier wrote:
>> On 2/8/26 9:00 PM, Richard Henderson wrote:
>>> On 2/6/26 14:21, Pierrick Bouvier wrote:
>>>> In next commit, we'll apply same helper pattern for base helpers
>>>> remaining.
>>>>
>>>> Our new helper pattern always include helper-*-common.h, which ends up
>>>> including include/tcg/tcg.h, which contains one occurrence of
>>>> CONFIG_USER_ONLY.
>>>> Thus, common files not being duplicated between system and target
>>>> relying on helpers will fail to compile. Existing occurrences are:
>>>> - target/arm/tcg/arith_helper.c
>>>> - target/arm/tcg/crypto_helper.c
>>>>
>>>> There is a single occurrence of CONFIG_USER_ONLY, for defining variable
>>>> tcg_use_softmmu. The fix seemed simple, always define it.
>>>> However, it prevents some dead code elimination which ends up triggering:
>>>> include/qemu/osdep.h:283:35: error: call to 'qemu_build_not_reached_always' declared
>>>> with attribute error: code path is reachable
>>>>      283 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
>>>>          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> tcg/x86_64/tcg-target.c.inc:1907:45: note: in expansion of macro 'qemu_build_not_reached'
>>>>     1907 | # define x86_guest_base (*(HostAddress *)({ qemu_build_not_reached(); NULL; }))
>>>>          |                                             ^~~~~~~~~~~~~~~~~~~~~~
>>>> tcg/x86_64/tcg-target.c.inc:1934:14: note: in expansion of macro 'x86_guest_base'
>>>>     1934 |         *h = x86_guest_base;
>>>>          |              ^~~~~~~~~~~~~~
>>>>
>>>> So, roll your eyes, then rollback code, and simply duplicate the two
>>>> files concerned. We could also do a "special include trick" to prevent
>>>> pulling helper-*-common.h but it would be sad since the whole point of
>>>> the series up to here is to have something coherent using the exact same
>>>> pattern.
>>>
>>> tcg_use_softmmu is a stub, waiting for softmmu to be enabled for user-only.
>>> Which is a long way away.
>>>
>>> It's also not used outside of tcg/, which means we should move it to tcg/tcg-internal.h.
>>>
>>
>> Thanks, I didn't think about moving it somewhere else.
>> This does the trick indeed.
> 
> You can also make it always a #define.  The variable for user-only is never set to true.
> 
> 
> r~

Sure, let's go for a define then. :)

Regards,
Pierrick

