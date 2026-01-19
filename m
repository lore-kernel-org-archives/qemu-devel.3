Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F07D29C2D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpwq-00064i-S5; Mon, 19 Jan 2026 09:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhpwm-00062F-TP
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:09:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhpwk-000759-FZ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:09:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso39641015e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768831773; x=1769436573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwKIh8LIEad7aH6Tqt5/QHLConUDcBI4y2gsj9RRJfA=;
 b=TuZILqF997+21e8wY+7NaeYDBOAIom7o1KwhqZMIvl9My6aQsne2Fm0FOSSeVzNGvm
 WsRpim479MV+LGWBeBZ2XFcVuchM6rJNDWluTX309dljUnQBGwcqxDdRWbVw7KjCiiwi
 f1cOX8muoBoAEmOhh6uB1PEmPBTpg+ZI21XxUxFUjHg0QaVVyca9s8IfM2F61rTSfDDM
 iEMMSsheKCeGcq9AzFVAGmrnEvJgluleyQ61IV7RPSBEZm2DG4VFRwYShBQX1YEFhKOB
 pnnPAk0LSWFSVBAN+sR19Ly6JV3conTyoI535WdHAcbDssqWtZn7Mqr8DZeoUv3+FXW+
 dN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768831773; x=1769436573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwKIh8LIEad7aH6Tqt5/QHLConUDcBI4y2gsj9RRJfA=;
 b=aLWIrUXK6UF95fw7Y/SCPvWJKexPMlclZxjBkyG5iCydgTGoenYKKhqJZwpc55hB3Y
 u/gD7D1JY3b/Yxz6H1aPIMnXsk/OJfoOkqno7z27Tu/YHxz8xEDcxER/N8RVtq1ayGgR
 h4x4MG/GhH/UV822STLOnCcRiN00sYSBoQ6+h+gNl1w/pbAQwwmmWJKQqGNP1VM+PDnf
 fE+ylUoyQamYVWwAmCcVxZS5G8zryvaaYiO+YfLOhz/kO/7K7u5jWbV/AxNPTMu0kKj/
 qytRbNepMIREFihGoJQtg4cfdOsqjNkQTbiNr8gFrlvNnbwNoahBAv7qBMHy8U+c6NTp
 lK3w==
X-Gm-Message-State: AOJu0YyxLqpcvoS0NNrbcabSxPcaA6Bx3TSKFfOwvhRhUERdU86GPJdO
 ofQg0kI47wWXOkn4R3y7puH3aLaulZucLeW8UfFhIwjbtfCmFsMHfdmIdza/GTaL2zg=
X-Gm-Gg: AY/fxX7T3V/Xz/DPEGlpLiNJ96gaOhSjrCUAxHujUXGDrnJ3GlzVdqYJFVgzrT2IYFw
 KjXWJTN3y2hDEWcqQW4pqNk1f7zge11Yl6mrZoP4J+KpiAUGlmq4+/yKdFBhwFVTqZSipzzoCBU
 It0ngiCBavthOWFC5DeAVIpgYvvrnq8GsoAHjAEJy2q27xhmTWrlWDc5wQMROUkiN0z1F7ATC7v
 2EZJmexbqXqbDr4GiSx80Nf1O0iheu6VNwyyJVvZpWU0NBg0AJ/WmbOmY5EySb8tbH2B7HWD4JV
 7wHyUqVKxIndR+NJI0hI7AGIxPCfQZGEI05IFtSoG7gKQYTv4rL9pAz4yyQLD/ppI6VLMT67CBa
 oy6IL61/YuXgBROgQ2I4vofGsMRcR7OrG1eK0OGVMj653fZtQrQ9INLKPNAfs4aBoAaAG8wSOVJ
 e27tRl8LDVXvniBPshp3F8dZ54ZKPISPEF7/zTYKkwviMsRbsDxctPqeUn5Oc+fVR2
X-Received: by 2002:a05:600c:310c:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-4801eaadcc0mr133159705e9.7.1768831772723; 
 Mon, 19 Jan 2026 06:09:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe47dddsm81031305e9.13.2026.01.19.06.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:09:32 -0800 (PST)
Message-ID: <82fd0099-8041-43c2-9c4e-94c9f0398fac@linaro.org>
Date: Mon, 19 Jan 2026 15:09:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 0/7] hw/misc: Introduce a generalized IOMMU test framework
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, eric.auger@redhat.com,
 Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <6d50c3fe-e235-48e8-b461-fe0689f12070@phytium.com.cn>
 <9fba7ded-d31d-4789-b83d-efcc96f5448e@linaro.org>
 <10e1b40c-2edd-400f-8c8e-e0f3ad4c6f75@redhat.com>
 <7881bfff-59f0-496f-967e-32a697ff11fb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7881bfff-59f0-496f-967e-32a697ff11fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 15/1/26 21:56, Pierrick Bouvier wrote:
> On 1/15/26 9:47 AM, Eric Auger wrote:
>> Hi Pierrick,
>>
>> On 1/15/26 12:39 AM, Pierrick Bouvier wrote:
>>> On 1/14/26 5:30 AM, Tao Tang wrote:
>>>>
>>>> A gentle ping on this series. Any further suggestions would be greatly
>>>> appreciated.
>>>>
>>>>
>>>> Link:
>>>>
>>>> https://lore.kernel.org/qemu-devel/20251224034647.2596434-1- 
>>>> tangtao1634@phytium.com.cn/
>>>>
>>>>
>>>>
>>>> Best regards,
>>>>
>>>> Tao
>>>>
>>> This version is in good shape and is ready to be merged.
>>> Eric, do you feel like merging it, or would you prefer someone else to
>>> pick it up?
>>
>> Peter generally sends the PRs for the vSMMU. Maybe this can also be
>> taken by qtests maintainers too.
>>
>> Thanks
>>
>> Eric
>>>
>>> Regards,
>>> Pierrick
>>>
>>
> 
> Ok, thanks.
> We really need to help Tao to get this in, as it's really useful and he 
> put a lot of effort into it, and waiting times between two reviews makes 
> it probably a bit complicated for him.

Since this series subject starts with 'hw/misc:' I'll queue it via
my hw-misc tree, thanks all!


