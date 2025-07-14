Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C974DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMKx-0007pb-Fu; Mon, 14 Jul 2025 12:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubLO4-0001lS-Ld
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:46:40 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubLO2-00068n-2y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:46:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7481600130eso5104323b3a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752507996; x=1753112796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+IDvBEmV+Lzihs6gqqtoeHh/iFwCnyYUNSldXE8MxgI=;
 b=bw/8tKaUFlBPW9jRhBLMlZPsqmXkFdonfKdHfg6QFSosFVRxqu3KZ5C6jlpk6TyYor
 tn6bZc9q0wVU9NRahJwxzb5GBDj53gYwxJ0vvI4jv4wXGuEN8aw3yqgaWOsBKkBCU9jD
 ZoVY8Y06IN9V2gpzArIvy7+EcjFLEd4IdoIQlvdSamtj4ttYGiihQ6/jSvUEo7YGsX2w
 GEX+yqAQec+UBOTs7rQh1WC4oENRImgnAMpUqqsaEyRmsTQ6mYe8kd4frzAknLks4S/i
 fr58rqgIiV7AkCS9HbVzD6drrTAjGXy3uBNIDoqf+SngG9MdJ+bfV2w8WXSuGt91Pir6
 Mslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507996; x=1753112796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IDvBEmV+Lzihs6gqqtoeHh/iFwCnyYUNSldXE8MxgI=;
 b=mTFIEpWh8iCQtkHz8GNqA6dp/gEd0DqYSNnASb6ZujAPmuuYcfaYToHyg7PcooX0RI
 KC9sHD87ogfcY7ycYI5HCnCH2p1GCJYr9yiSWcbdgTRrQmizC9PSzPWey65zeMyA31il
 J8lUNA0g9OV0Xf8H6SDQhjlFCDjyuluiAJpwrv2si4M3jPeokdEBnoFSSee7pPxhJGKH
 E3FJQ47YlH/fy1qKQLxEUjUmvCu4yh3VW+A0wDioCBTgGxjZOpavDwhKUBqwQbs6bYhl
 jH0GoAYXKnM2nnf8KzN7romAmjnNFPRo/U3Et1ANnbcZolTNEmVE/EScKbDYsY5xoVtj
 sY0w==
X-Gm-Message-State: AOJu0Ywr95jOKfwXGTGlZ6Gci4YftxtDk5ZPR62lwAJrfk0bJrmA/dTR
 gEu8iZxblhrMUDhIlfXASFu11PSNAnH/uXKs80dCHCDHgUFBC1NyE38YEA1bjTq9Mlk=
X-Gm-Gg: ASbGnctxWHuYfbJhMUYc0swba/PU8t9YmaHOmYp294l0toB4S/IMM6F7+axwczD9FY/
 unJENBeCxpSi9+8fPA8pHfIe0dIJGE9PmCH3Gw+00kNrPJZlBHR84mkWYg2CKsLY7WOHUfmOH0e
 Uxl21a6ihm7EJ/bSv9R36Q9/xzyLeR2ldYc2TJZhsig4Wrz2UAY87jgFQfOLXR/bKyMdTEEY+qS
 paDntfYO4j4JpHIs4FK/BxXQ17DJxlqEtLUV/MRmbWKasMtLtGGell9QZUiSGJBDBixH4b7RKOG
 /7TD3wvie6NWibTjbv1lOGSfL1ewDx7aIZ0h3ghFuKxg4VosHS4MHRf6PrDrMH/9XRRNmazh5Xo
 G/F18Cm2vNkP17XlODqhh2FmCfU+Y72qkDMR9KhqDVbzwGw==
X-Google-Smtp-Source: AGHT+IGg8P/it84LX/wj/a8NB7leTLCQbehdmwijsf3a1Vwrhji4eSM4vSncTNX7gSMgk22Cy3IPCg==
X-Received: by 2002:a05:6a00:2352:b0:740:9e87:9625 with SMTP id
 d2e1a72fcca58-74ee04ade9cmr21578864b3a.4.1752507995641; 
 Mon, 14 Jul 2025 08:46:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4cb57sm10995934b3a.136.2025.07.14.08.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:46:35 -0700 (PDT)
Message-ID: <eabfd320-5efd-4a0a-807e-10aca82ca27b@linaro.org>
Date: Mon, 14 Jul 2025 08:46:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] target/arm: Add FEAT_TCR2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-5-gustavo.romero@linaro.org>
 <21bfbfaa-f0df-413d-bad6-b69688ac381a@linaro.org>
 <65e20340-e164-4424-bc60-52d78b9a17b8@linaro.org>
 <f18a652e-b64c-4a33-bd60-63dfa93ffdbd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f18a652e-b64c-4a33-bd60-63dfa93ffdbd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 7/14/25 5:58 AM, Richard Henderson wrote:
> On 7/14/25 00:21, Pierrick Bouvier wrote:
>> On 7/13/25 2:59 PM, Richard Henderson wrote:
>>> On 7/11/25 08:08, Gustavo Romero wrote:
>>>> Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
>>>> These registers are extensions of the TCR_ELx registers and provide
>>>> top-level control of the EL10 and EL20 translation regimes.
>>>>
>>>> Since the bits in these registers depend on other CPU features, and only
>>>> FEAT_MEC is supported at the moment, the FEAT_TCR2 only implements the
>>>> AMEC bits for now.
>>>>
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> This causes a regression in tests/functional/test_aarch64_device_passthrough.py, by
>>> continually trapping on an access to TCR2_EL1 while the HCRX_EL2 enable bit is not set.
>>>
>>> Unlike the similar SCTRL2 failure, it's not 100% clear to me how the guest and nested
>>> guest kernels are related.  But it is clear that the outer kernel does not does not
>>> support TCR2_EL1 (and also doesn't manipulate ID_AA64MMFR3_EL1 to hide FEAT_TCR2), but the
>>> nested guest kernel does support TCR2_EL1.
>>>
>>
>> The same kernel is used for host and guest.
>> Maybe it's related to kvm support?
> 
> Oops, no, the patch fails to enable HCRX_TCR2EN in hcrx_write or SCR_TCR2EN in scr_write.
> The same is true for the previous patch with HCRX_SCTLR2EN and SCR_SCTLR2EN.
> 

Thanks for the investigation. Indeed, building TF-A with 
ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTRL2 didn't change anything.

It's possible that it's still needed to update test images though, so 
I'll try when Gustavo will post v8.

Thanks,
Pierrick

> 
> r~


