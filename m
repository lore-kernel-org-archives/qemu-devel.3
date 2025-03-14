Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E0C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 20:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttBG7-0001i6-Hl; Fri, 14 Mar 2025 16:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttBFp-0001fX-5R
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:03:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ttBFn-0001P4-4B
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 16:03:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225d66a4839so29265825ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741982613; x=1742587413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICOOaZpzlFsDqlkMEPE9wAFgKAOBdMURc1KnGnML6Fw=;
 b=A0JUKZf56nhRZSdABdwZOTlF5cTJu3xQuks/rp+Cv4k7bLKedfFqkgdLgtveoFsqau
 sgtQoJWTdtROj0t65KOWfXU5cAEgesRYkPiJdEAuBVMQ2xeNovUWsAf55t8UKJoj47YV
 QADrBxh4qVMQ9UDWr+G27iiUZtIi761/YS7bWDI8STptfGKWg75DceFejgLUGsnvCw8y
 860B5d0Bf8Da6qGbljMNxmbasM1pYnHq0Zz2vwLHNQ2kFcEBDq8fx/KntaT5NJ0nJUcf
 SWgAaYN8u1I+lsPKHhij2L+NgAWa79XJsHz2eU8JtKiv9urDivsFm5jEec58A/4TePN4
 UECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741982613; x=1742587413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ICOOaZpzlFsDqlkMEPE9wAFgKAOBdMURc1KnGnML6Fw=;
 b=YJAV55xr1Cm51B/GfiyLzQExlEgB4oeb/ceYzZeUvCnQXmAFr11sc+4H8bdObcXX5Q
 V/wdYBMMdOs9emWuYPq9Bm4/b5HzDuGr7YNqAWpoqd5dwcajIdrO93V3ce3RRG1StiDq
 sxmoy8t2Alpzx+unMwYlxIXXltWPdSQuGWHMe9Y3IeuHlGaTWQ3K5BpVhVslB5UtDs5w
 JUSzIWsQQeEWFClci993BH+UT/+P42qkWVimiwrgzoxnYuP2/73wkzYfgrbS2wyavdyj
 3Fn9fa1dvC9S6yX+uLEE3fV8ea2arWxj8FI9FZhrnyyWQbJOHhjvk5VtVU1vAIfbiIE6
 Bz7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDqj9vUpM2RSSYllw5Pjx+ASbLNQ+yHQPFZrz0+lQ2RQz0hhXnRHTiko8KNNqVW86LR1ZTvKgNwZib@nongnu.org
X-Gm-Message-State: AOJu0YxOkNw//tZDkw9KE2iFHrWpXzjbofmunxpJjS6Fb9boJaDFIj91
 VYen5ecscN5LgnvWVOEojXxj3/BmaCPhHzkWYjOEI5KWC24Z/dRoPw2joXMnAnQ=
X-Gm-Gg: ASbGncvkzwAmpiMdc9fjZZNgI8LTjRdUiDUZQGTZeayZDNB6Rq9kg22EY9/N6qpe2Cs
 BSQJjeuw06AVEOAUwC6lfIjE2aD7dvupF+ACm02hHe78PKkVoFuRRRTL0ki4tX0GzZDgZ3Z4H8p
 HUQcw6gZZShyEnrOcU1DeDmozqHPcOiqGTvzY5vFtSufhwoqjsmpiftFBCSh/xzdaeIU1yCqV6n
 BfT9mp2gsewlgKXwNBs99bwykCWF89PDrpP9ZsWHsTD5A9aPL+QnuuwLm9vTo1WZhgLwOsJLRBd
 qChuI/u52MrHCfL8pApNrAGCC/J/tdqHmKQ7VYUUWAF7r/9pR5NRmrGy+vQ6F2VB91hHR9rEWYG
 971JrJ8m6
X-Google-Smtp-Source: AGHT+IHKzeqUs42vdfylXJn7MdngixIZiG/cUEqhT8aYAI53DBE4SS8x3rpE6+47QeDvk/7U+QfHIw==
X-Received: by 2002:a05:6a00:c95:b0:736:476b:fccc with SMTP id
 d2e1a72fcca58-73722e11ff7mr4741111b3a.8.1741982613261; 
 Fri, 14 Mar 2025 13:03:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711529381sm3284029b3a.33.2025.03.14.13.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 13:03:32 -0700 (PDT)
Message-ID: <e3d39823-734e-4186-95b6-07717663bdf2@linaro.org>
Date: Fri, 14 Mar 2025 13:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] include/hw/intc: Remove ifndef CONFIG_USER_ONLY
 from armv7m_nvic.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-33-richard.henderson@linaro.org>
 <7f665a47-2bba-4c3a-980c-a252ec44723c@linaro.org>
 <807dbc0d-db15-4bd3-95f3-b3e87951bd7f@linaro.org>
 <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <42b1f9f3-2ed4-461b-9460-0318011097ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/14/25 11:36, Pierrick Bouvier wrote:
> On 3/14/25 11:13, Richard Henderson wrote:
>> On 3/13/25 14:00, Pierrick Bouvier wrote:
>>>> diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
>>>> index 89fe8aedaa..7b9964fe7e 100644
>>>> --- a/include/hw/intc/armv7m_nvic.h
>>>> +++ b/include/hw/intc/armv7m_nvic.h
>>>> @@ -189,21 +189,7 @@ int armv7m_nvic_raw_execution_priority(NVICState *s);
>>>>     * @secure: the security state to test
>>>>     * This corresponds to the pseudocode IsReqExecPriNeg().
>>>>     */
>>>> -#ifndef CONFIG_USER_ONLY
>>>>    bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure);
>>>> -#else
>>>> -static inline bool armv7m_nvic_neg_prio_requested(NVICState *s, bool secure)
>>>> -{
>>>> -    return false;
>>>> -}
>>>> -#endif
>>>> -#ifndef CONFIG_USER_ONLY
>>>>    bool armv7m_nvic_can_take_pending_exception(NVICState *s);
>>>> -#else
>>>> -static inline bool armv7m_nvic_can_take_pending_exception(NVICState *s)
>>>> -{
>>>> -    return true;
>>>> -}
>>>> -#endif
>>>>    #endif
>>>
>>> I'm a bit worried we might have regression when doing things this way.
>>
>> I expect link errors to diagnose errors.
>>
> 
> In this case, yes.
> 
> More generally, for system vs user, it might be sufficient (even though I would prefer to 
> be blindly prudent on this), but it might not protect all cases, with subtle configs or 
> features enabled/disabled.
> 
> With a runtime check, we could identify the missing calls "feature_enabled()". In this 
> case, we would link, but could end up call_feature in some cases, when it should be hidden 
> behind a "_enabled()" check.
> 
> if (feature_enabled()) {
>    call_feature();
> }

I'm not quite sure what you're arguing for here.
A build-time error is vastly preferable to a run-time error.

If it's a lesser used configuration or feature, a run-time error could lay dormant for 
years before a user encounters it.


r~

