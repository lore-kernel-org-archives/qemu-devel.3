Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4DCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0wQ-00057v-Ny; Mon, 05 May 2025 14:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0wO-000568-F0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:53:24 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC0wM-0007RL-Gj
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:53:24 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b03bc416962so3323932a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471200; x=1747076000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WW2PugbCueDfTe7SCxeY/0K3L52JtpHstHxnpx2N9c8=;
 b=mPa8NypEUdS6b6ncA0r2UvGUF543L8IKP9VWh83wAHBaDgbS5UbrZlBAaXGG3bIz6y
 NDvqm9orWxGW69pZD+xrqBlE0QMjiCQ7WLfbeSAovaJz6wg6EDVPCdT2FILNVNTI+xk5
 Ox1iE22qcLlxEnNCSY9yidnXrbbzqW8J38gMke/p/GNsG4b7tvFSbO5Z+6zpNbBifV1N
 CvdWvHH85l8sTFhcXRumRDaEx/32hrh0akWCvuu4EhciF0XidxMe6T9vlhYJzwU6aHn8
 XIoz6nOZxzwP/5qrsLNrh54YIParYkZlwYJ/eZqwgwUeCRLPDEsxeIqRSOu566jlgPIb
 HVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471200; x=1747076000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WW2PugbCueDfTe7SCxeY/0K3L52JtpHstHxnpx2N9c8=;
 b=Y/6hvpmmiV6yiWTtKKkRFT/ZmIzJcqp4CvBuRgfxJEZdJtuuHCggDmM/paB+Dy1sJM
 AFZEU5EGYaD5bMnmD7mwpOK4L+/JMGR11iaXsFRo8e+hNBoBJJgtcw0+8IKkC47QhEN8
 I5g1W2o1T4e1q7y4EIj4y4Ps8gGQEELIK3pHcYweIJtFe93LiqEtzmSDFWhTMX1GaU9T
 JiSnLOP8zW+T/4+ckIeA06suGZws/lpyq69wSU4rDtymYPwp0eXiKhjYvq+kpHqNNwJP
 rU/1hCCZomoz2XHAATJetUdHWe1aTh1Yk2d5xxVFQhEJDrtA7Dg/L+m6RxweTeNJpCTP
 cdXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6EjSzPzdgvjXZ2Ewh1AoMLB2TAYottrqTQ2atbeFMdtUJ0Tg3iIYZLoEQAB4rxFfJoYc2OshIvRWs@nongnu.org
X-Gm-Message-State: AOJu0Yw7CNg14/DD6XLaKdIw4ENHF6rosAaO1pUJu4JTsBSbkg7iYBdL
 BrIw2FBkVcbFm0FPpk/3wUHU8L2gh/X0hYJxzhNHkFNW3kZzOePmkDRceaLfe3Q=
X-Gm-Gg: ASbGncspz3gIbJduz2a40rnQYZEPCcnRNESB9WGymKIQsN3czKpKJLUzgccz8mOwlgH
 oSW3b4u41bpRf/wPE4NCa6dd7erTmElnIgRl4oRJOZR6RwlBva2IW0TBkh/B20jQagXRG+Uhe7m
 xMyrJ6P8HWTeK4n1sKfs/yY3Zpzv5DMHnW66p+kTClkg9ygbucUx/81NAb30DoumfCusEgFkf+8
 P0ACl4Bcefdsb9ocZJP/An6q+wh2cNegzCI2bexEuV5JiY9lXhbaibET6Q1od/Rhe/PJq0vRqYc
 NsbA1ybqW+80Mk2g9qLz80v46TusyjHxkNYNP4uFDfdkO/CgElJ89Q==
X-Google-Smtp-Source: AGHT+IHZVx9eBvMSyhsQT2CjKQPJmL9kB/iVWh/hm8ZsQ4A2jqzgMClBG9aBXB4nd+yyoHKnutlong==
X-Received: by 2002:a17:90a:e184:b0:309:ebe3:1ef9 with SMTP id
 98e67ed59e1d1-30a6198d1e8mr14256650a91.12.1746471200600; 
 Mon, 05 May 2025 11:53:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a3484bc23sm12038442a91.43.2025.05.05.11.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:53:20 -0700 (PDT)
Message-ID: <83038814-8527-44ec-b1c1-2d17362d08da@linaro.org>
Date: Mon, 5 May 2025 11:53:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
 <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
 <f33fa744-1557-4c01-ba49-e64b4d3b6368@linaro.org>
 <c67c4a79-7855-4d15-8064-b2f448ac9a42@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c67c4a79-7855-4d15-8064-b2f448ac9a42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 5/5/25 11:51 AM, Richard Henderson wrote:
> On 5/5/25 11:47, Pierrick Bouvier wrote:
>> On 5/5/25 11:38 AM, Richard Henderson wrote:
>>> On 5/4/25 18:52, Pierrick Bouvier wrote:
>>>> --- a/target/arm/tcg/meson.build
>>>> +++ b/target/arm/tcg/meson.build
>>>> @@ -30,7 +30,6 @@ arm_ss.add(files(
>>>>       'translate-mve.c',
>>>>       'translate-neon.c',
>>>>       'translate-vfp.c',
>>>> -  'crypto_helper.c',
>>>>       'hflags.c',
>>>>       'iwmmxt_helper.c',
>>>>       'm_helper.c',
>>>> @@ -63,3 +62,10 @@ arm_system_ss.add(files(
>>>>     arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>>>>     arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>>>> +
>>>> +arm_common_system_ss.add(files(
>>>> +  'crypto_helper.c',
>>>> +))
>>>> +arm_user_ss.add(files(
>>>> +  'crypto_helper.c',
>>>> +))
>>>
>>> Could this use arm_common_ss?  I don't see anything that needs to be built user/system in
>>> this file...
>>>
>>
>> It needs vec_internal.h (clear_tail), which needs CPUARMState, which pulls cpu.h, which
>> uses CONFIG_USER_ONLY.
> 
> Ah, right.  I didn't see that coming.  :-)
>

I like the idea to have it built once though, since so far 
{arch}_common_ss was not used, and I was not even sure such a 
compilation unit exists.

>> I'll take a look to break this dependency, so it can be built only once, and for other
>> files as well.
> 
> Thanks.  Building twice is still an improvement, so for this set,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~


