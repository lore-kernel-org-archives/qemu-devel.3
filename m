Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB40EA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 22:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnlGT-0000Ri-Nm; Wed, 04 Feb 2026 17:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnlGR-0000RD-Vf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 17:22:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnlGP-0005cU-R8
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 17:22:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a79ded11a2so2237195ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770243739; x=1770848539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRWeWptZSdUrt5hS3lchhMINvUNAz0Imew8bWIEoy0E=;
 b=v/jHnbLODFs5lkxWNhQhcRr+BoUZtq7Lew/TMDcDbNAY6Fp+F5BiCnE8SounvmTohC
 txT25dNm6jCUGxlCp+HWfDr3AbMtTZuxPPP5J0UVQwv5nyEir0CCDK1S2BSBqbB/hhCr
 OGjjpx6Yp8+5CR6XCGGAwny1dA4kEHr5q1eKhnRD8iTX+iOlXxM/2mGQKBh/NSyAfqTO
 nDpxxn0w55NuGaYp1elL+A6xE7tO5ZlhOydqcycd+egHlF8QTRngYNP2xcQo9T9WwM7u
 ZMz6VwPztQno1GYvGMcEZBR9mzj1q4uaXU4lX0TvPBRh/oymuQKDq9TFAqJ6EVt1mV9b
 hyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770243739; x=1770848539;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRWeWptZSdUrt5hS3lchhMINvUNAz0Imew8bWIEoy0E=;
 b=jYTo/cSeNKS0mCHquGn50FoMpagscJ6rCMjWes4Vb1nG78ymnxj6f3dUPaORX9uJlN
 QtHxsw+3TqsuVjbTBC86g/dhlmpuFjzNSuCgqYDoTiDACmBi6phQVBolN4s9nZaAe4V/
 6ZRSmrjyuV1ZHIlK5tC9GFzcW40FGBT3xCuBXSHYSjm1BAgIEJ8fCVCDRzyXU0p8PqW0
 i3dlaYFTfpOHwzk1s5cN9NX0HX+tVnEfzkg5idzCbF+elpR3KnzU6HtJjEKHkJZ8nMfM
 jZQLC91eL/JU3E+tE1ho0AHlYEhLpVzZp2ucyNfF5Vvo+aH6DqyjuuvMji/DxFcn2ZCM
 RB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8A3ihVEb2Ovj5Z6xU9IU/9jXeQ166dEMvh3HgH8jo9stkIOkt6eo/wR4kHqcfnCa2YRNrhQSAIwJl@nongnu.org
X-Gm-Message-State: AOJu0YytJDIyW+Uotv3k1EUE7VsllXXK+zVkJuNlQmAUILb5D2lPym2A
 kst+VePtqQ34ZTI0PJ8W555zpcLq7C+xSHIef3RtiRJYtXf5rJsnWesty1yYz/JmK0I=
X-Gm-Gg: AZuq6aLYuEoIZjqk9HU8rqA/HgH2r8IaiCgNwKfDXoayfOgIXacLI3ilws6dtIdfDWK
 B/mhrbGWVFee8qiXz1w0blIeKugz6GgX1LGRzyRP0KPmK+f6X/qT0shdpkyU7qV5DK/UFrE+aR1
 kQxFh1GcIu8130ggDUZMXKxtUDqneyqrQqkybUqYdZShTt09YKim4eGMKhLfSWzGvNU3rwCpGpj
 YaQXfgWHUgnL5ZEFtkXlaRC1+XNlDjuToe5jjHPfi04TotkM9ME4H1sfDT0XT3BFLlDtSUutNmA
 srHhh5Cl9RWsAQTzh3Bq8+hAYZ3BA1yGoKSOdmEk8kl8AR7hu2JIvD34EOg2cND9knrWy80IRNu
 POVvPW6KNnJO4q+vq+JcWz3CyYUtCjzY8+CL8VU2r64KFnaHdbrM1kgCTpHjX8SSFBs+YGZOq3j
 WF/MYZ3BUHx21Kt9BEQRWCPF1pAka1RnZctOE3DjH9FMzMjubWGuUfu9RC9+AYvPLbjrSU1Klz
X-Received: by 2002:a17:902:eb83:b0:2a0:fb1c:143d with SMTP id
 d9443c01a7336-2a933b89ed8mr43775285ad.1.1770243739504; 
 Wed, 04 Feb 2026 14:22:19 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:110e:c2b5:eb10:f92d?
 ([2401:d002:dc0f:2100:110e:c2b5:eb10:f92d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9339822d5sm29164745ad.99.2026.02.04.14.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 14:22:19 -0800 (PST)
Message-ID: <e1495603-4ac2-44bb-8b0d-74c45e5f2e66@linaro.org>
Date: Thu, 5 Feb 2026 08:22:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-info: set target_arch statically
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260203194113.3026757-1-pierrick.bouvier@linaro.org>
 <7645fcac-c4b2-4a9f-91c8-4990e9c92ef9@linaro.org>
 <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5fd0062c-b474-4971-9a46-06af9ae4e0c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/5/26 02:36, Pierrick Bouvier wrote:
> On 2/3/26 5:36 PM, Richard Henderson wrote:
>> On 2/4/26 05:41, Pierrick Bouvier wrote:
>>> target_arch() function will reparse target_name() every time if it was
>>> not set to a proper SYS_EMU_TARGET_* value (when using
>>> target-info-stub.c), which is not efficient.
>>>
>>> Since we want to preserve the constness of TargetInfo but C doesn't give
>>> us flexible compile time expressions, we simply set target_arch using a
>>> static constructor once instead.
>>
>> A static constructor isn't static initialization.
>> That said, we can do better with some extra help from meson; see attached.
>>
>> I'm mildly annoyed with openrisc vs or1k.  We really ought to fix that, but I haven't
>> looked into what API breakage we get from selecting one or the other.
>>
> 
> This was my first approach, and I noticed the or1k issue + missing hexagon in 
> SYS_EMU_TARGET enum. Having a hack for target name in meson.build is *really* ugly IMHO.

I agree.

I assume the qapi string is the one that should take precedence; everything else appears 
to be merely qemu source level strings.  Marcus, can you confirm?

> At the moment, hexagon is only linux-user, so I thought it didn't make sense to add it to 
> SYS_EMU_TARGET, and I didn't want to go down the rabbit hole to rename or extend this qapi 
> definition, as the initial goal is just to define a field before main, which I consider to 
> be static initialization, even though you might prefer to call it differently.

I was only going to ask you to change "statically" to "at startup" there.

On the other hand, system-mode patches for hexagon have been on the list for a while, so I 
don't think it's jumping the gun too much to include it in SYS_EMU_TARGET at this time.

> I'll let you upstream whatever changes you prefer, and I drop this patch.

Ok, will do.


r~

