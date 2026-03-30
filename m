Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B67F1061B0A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Ejx-0005np-C1; Mon, 30 Mar 2026 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7Ejr-0005mg-G5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:41:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7Ejp-00074W-Sm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:41:15 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2273450a91.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774885272; x=1775490072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqn8h5li9SUttpZO5zkrQKWbsbi6Lktn+ZvEoww31Hw=;
 b=htmQ7x+bFtWVXf9KfvHWqw3sKvZj6lginc/Ex+s4vy6/+JQiFjzPOnPyFsp6VkdOWs
 v8nwe1cdSwdIdQfEz0HJHfZCRtKNTytzz2SSHy0YFijATqJ4mc2ZeLxgd0tY4F7G9Xny
 iwP4PUI/qu3eLrM4NPFqlik3OW/8njhMOk20kXtMKSXIhzJ4qKkaReV40aiE8A3e9g1r
 6H8gOEHiqyhoGD/aux+bMjbcqvcETgb23cjrDqtM7GSN/wOumCtLRm+AIlW9cVoXytD4
 q+f/YkzBddulN2ngtTpW9FfZDiDyQn3Ajnoc/l4jPoEFK1IJgUszTJZjmYp8i3xH4evF
 hP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774885272; x=1775490072;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jqn8h5li9SUttpZO5zkrQKWbsbi6Lktn+ZvEoww31Hw=;
 b=eLwp98WGv5P3ZUUMly2Yef3qsA6t7gDhLx80EbsL+USJYE1u1XZ7bCNSFlXl2+GQlf
 kMRGwnhOzw1KQlrEtW4BItTpvSBw+8COocHv3G7LskenhxaPAsTo/BdIBF0oJ0ZeWEqm
 +vrfQXIu5xEC3NqP2PKMc1az6C8sXgzig/ftY4DPj/rbAveyY5Vqb44f7lp0YKYUOWo5
 jJfxeoY3OAWe9Bv2plTs283kkO8LMdgGENDqND3qlApgi4o8mcHXWEb4KmRVZDfEnrgp
 v0QLvB2kvMdArFbP+9zWlufYTF9rVuFHgfwnZ2GaW0A7hkxYLyfVHjF1AFNTep8kWyE4
 JCmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkwUuCcDWWteWOpksdQao+V9zqB/qLFGJBxd4mdDIuKYvMX5x7pDv3chMPMv9YdQVQEXf5eJzyMYAX@nongnu.org
X-Gm-Message-State: AOJu0YySXCC0py9ki3hnDK8nFKIHG/HAdjv6TsOWFjhaXkbYPvCXE9Kq
 PYSsNSUo5hrQPEUyht0grMKapEyeTiQwUI4ctD5b+DnNP+DWdI38eo/2SPUjnuy4cMc=
X-Gm-Gg: ATEYQzwzIxeRaSG+ey0vTOJsAxIXPumClvrvl+bjpiRgklbdX662CGS3k/u6RRNL+zZ
 +Tewr/W3Ba/6ni73CTwWdu63tgPozZQt3RIk7JqL6Y3yTKkTFRmbt8lvS9LUyyep4zPv3fII7DL
 adldj8PG4sMUXr9QB6qFPXIVR5/ojvzVxipuCG18LX8uISV8SVrSDsDBVG3oJAS8GNogqnyjFPn
 0ZPZgjAdMlwtB12dpiUsAfe5wzxlht0nXxUgJLAI+Pbtl0q5lDXmRl984vbYEdipgUswOeHP9Yd
 RnJFTPN4CzekQxcuP5+hhoBjihCv3kUCL2ZAixcinUOPKIACrK3JOl0otOxQSnWt2BdG93mW28N
 4/WZNI8GAvjnQHIFJJablQEx8jZhkfOexUh79qtlzJRRld45vIMLX4e3Gn1ZJ9/EZQZwJDcnItV
 a65oqcacZHcFLefkTb6dM2NmiB5tk1odpcSPvWD0T3M8p6a9eDwIIva39+H+39EWugHSyX
X-Received: by 2002:a17:90a:e7cb:b0:35d:a84d:e281 with SMTP id
 98e67ed59e1d1-35da84de7f8mr4471891a91.30.1774885272241; 
 Mon, 30 Mar 2026 08:41:12 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d94d289f5sm11033978a91.5.2026.03.30.08.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 08:41:11 -0700 (PDT)
Message-ID: <bea8028e-39dd-4faa-8c55-f2cac9ccf144@linaro.org>
Date: Mon, 30 Mar 2026 08:41:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
 <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
 <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
 <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/29/26 8:46 PM, Richard Henderson wrote:
> On 3/30/26 12:34, Pierrick Bouvier wrote:
>>>> -arm_common_system_ss.add(files(
>>>> +arm_common_system_ss.add(
>>>> +  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
>>>> +  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
>>>
>>> How are you not removing the other decodetree invocations at the top of the file?
>>>
>>
>> They are still needed for user binaries.
>> As explained in commit message, we don't have control in which folder those .c.inc are
>> produced, so we have to duplicate them to make them visible for system_common code. Since
>> they are not proper compilation units but templated C, we don't really have a choice here.
>>
>> The only alternative, if you prefer it, is to remove them from gen_a32 array, and add them
>> to arm_user_ss. In all cases, duplication is still needed.
> 
> Maybe I'm wrong about how meson works, but does invoking .process() twice result in two
> executions of decodetree, two different file objects, possibly with identical names?
>

Don't forget we don't produce file objects (that's the issue here), but 
.c.inc that gets included later.

> If you want to share these, do we need one invocation, storing the file object in a local
> variable?  Akin to
> 
> vfp_d = decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp')
> 
> gen_a32 = [
>     ...
>     vfp_d,
>     ...
> ]
> 
> arm_common_system_ss.add(
>     vfp_d,
>     ...
> )
>

For information, it's already duplicated today, since it's generated per 
target.

> 
> r~


