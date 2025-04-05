Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F15C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14II-0006p1-5C; Sat, 05 Apr 2025 10:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14IG-0006oY-6e
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:14:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u14IE-0004Ih-Gk
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:14:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso19452175e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743862480; x=1744467280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFOZvrTN5I9L54c5RCctQfy6TWbmrKAeol08PKLOjhs=;
 b=dAGI6He7K5uGnBd4tU9BU6Qo1PDvv0bj9XyO9w+otlKrKrENGBARqNY0u3wuHTd6Kx
 3tLLEt5DlmSZ8QZyy2jqG9JHG5DCInmRvNlBi3QlKxFa0HEE+Z21aSiQ90hMZaJ6FBOC
 O4vABCHugdJmcQO1SOwmaZClZRyPk/CXQdznPOI/V0yInLK/sbS5zhvGhN4Okgd9UGmL
 0KThtmJG438cwM303hpXlAUBhR71kwvWmx1VeX1I6AljSHEeQZ3m8bxrDwgAqE9AsJwt
 nJhd6luVi3g4d7OzYrnPfcuGTJRuZTq1Ut/GiyyvVZbA//Jk+1QsdJu79sB+J0U2fpNk
 YUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743862480; x=1744467280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFOZvrTN5I9L54c5RCctQfy6TWbmrKAeol08PKLOjhs=;
 b=oRkO0Jfrx0mKG3H5ayVdHZtyd376QSUQeoyDkED8z1rUOVw+2KlgQrbhJzTLbjoLIy
 0VFEDCFObmhA0kxtSv0thGmFmW3vQf4bDDNQ8XjRU5ziJH0Xn7UMLAPlEMJw/ZlXNitA
 y+7VFeiEGNRAFWhAqtZbqrAYxHB5pPCYKQhd+5jF+ivmeK0Ar+ZzRHekVOyMsG6j52bs
 2hkDUefxEEAK3kFFpRJS33y91Vj50uBoZ9j1pVp+GQ78wCb2Xd754+FGtfnk5MdIdA7h
 6Z9ikq3iMwUGUkM3ncwfhtb/Pf9dwu5CUNoFwSwCR9kuh5y5mDhpwstb+j0mlVxDZItd
 Cy2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpCubd5PwkBazT7/AXooW3gwPLCVYNcoEWJ+X7I9x7UKg/60i4788uW2VUhXXLrtvgggjI2Jrz+54X@nongnu.org
X-Gm-Message-State: AOJu0YwvTEfyipcbXGisjCS3iOQ+O/UEAg1H5J0Zgl0ml63Rq2SojCmN
 niowYgUYXD6valoRP6nYIkRE0Q4o/lDV4HDWP5VszKFes0PP+g+RoQS+DqFFBkg=
X-Gm-Gg: ASbGncurQNNTgh3lUA47SqrMv64HRoBfd8LhbcX4j91XLc5G7viX8qN8+S0XVJorLWp
 3H5IIh+EbshKUfYqXDgmNfII/0W+nQP4A7+yTOMY+DWSHCYdz6anQ8obRenhhoyyEVZQrYEVKpa
 q3d6a+sdostjHg5dD/hUBGW7h82ruc7MEGG/Nfx2Vwv8VVm85xIHHhl0bCJWSFYzRzpF/TrpA3D
 KMPF34HeBDesbOo+3X4rROfVFzOku6YJ2iFafdbicJXS4V96Qcoy4B5FlpASqs2Mk8EiFh+XzGj
 eDIzVwI525kGxHTdTcuNwlqKTqMbWpOeiPjEnjqzQlVdK6AXqdIasCaK8qabx1uU4Z11Twe2NyN
 jm9Z5FBmoIxALGOJbmg==
X-Google-Smtp-Source: AGHT+IHFG30u/P2jfXB2tFdfPwgj8k/SY8s5q3ZSbN5lgc0T1/e4DwFvJK7Mb7eqDKCFx69pKXNZfw==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr80293105e9.30.1743862480623; 
 Sat, 05 Apr 2025 07:14:40 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d6c8sm6937449f8f.73.2025.04.05.07.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 07:14:40 -0700 (PDT)
Message-ID: <946e2f5d-385c-46b5-a2cc-0d8d3166b779@linaro.org>
Date: Sat, 5 Apr 2025 16:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 19/19] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
 <20250403220420.78937-20-philmd@linaro.org>
 <42750cc0-177c-4939-8832-154c2d2178d8@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <42750cc0-177c-4939-8832-154c2d2178d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/4/25 13:29, Richard Henderson wrote:
> On 4/3/25 15:04, Philippe Mathieu-Daudé wrote:
>> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
>> have each target set the 'mttcg_supported' field in the TCGCPUOps
>> structure.
>>
>> Since so far we only emulate one target architecture at a time,
>> tcg_init_machine() gets whether MTTCG is supported via the
>> current CPU class (CPU_RESOLVING_TYPE).
>>
>> Since TARGET_SUPPORTS_MTTCG isn't available anymore,
>> instead of emiting a warning when the 'thread' property
>> is set in tcg_set_thread(), emit it in tcg_init_machine()
>> where it is consumed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Anton Johansson <anjo@rev.ng>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This doesn't work for i386 and riscv, which have both been "updated" to 
> initialize cc->tcg_ops via ${arch}_tcg_cpu_accel_type_info ...
> 
>>   static void mttcg_init(TCGState *s)
>>   {
>> -#ifdef TARGET_SUPPORTS_MTTCG
>> -    bool mttcg_supported = true;
>> -#else
>> -    bool mttcg_supported = false;
>> -#endif
>> +    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
>> +    bool mttcg_supported = cc->tcg_ops->mttcg_supported;
> 
> ... which has not yet been called, so NULL pointer dereference.
> 
> I'm not sure why the init of tcg_ops was moved from ${arch}_cpu_class_init.
> Probably it looked nice to remove the #ifdef CONFIG_TCG.
> 
> There's a definite ordering problem here, and I'm not sure how to fix it.

Can you just drop this single patch? I'll see what needs to be done.

Thanks,

Phil.

