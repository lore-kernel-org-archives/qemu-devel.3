Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D40BF99378
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsXC-0001n8-Rp; Thu, 23 Apr 2026 07:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsX6-0001mf-6c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:47:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsX4-0008I9-KA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:47:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso3881226a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944865; x=1777549665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0/zWCrt558ynO94m+x1zNXqKcIOG8BvNVfHJCnRLoH4=;
 b=Dugws9K1rSkF3Dfbt6toZbe0vKooIT1DJKhwKI92gFBcwUqHsK9p/MpnTL8nN0saht
 V3PTs6iFyYbzJ28OTqv47o9D6nAPITxz458R6WbvJdZPlWH2fl7mt6l/8WDI12dueFVg
 mfJ0TdxIn9uAi0kNR464VQ1OFCLka1u6p15+WbVC9R7qM7LHVgAlmZd75lJmZDsj17DH
 bcZWsLEhqdglwVRp66H9mYiNi6IzwnkFbspJ3UPaVHRLFryJxlRW19JKOqCuCCylXz0I
 ehsioWeHJW2CKiLQ9Gn0/WTZ1B33pPNSqWD3nbHekaXPUOqDNmNHMcF87XVp5CsvdnzA
 sOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944865; x=1777549665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/zWCrt558ynO94m+x1zNXqKcIOG8BvNVfHJCnRLoH4=;
 b=FrOWEYkvrDzQkJbvB+YnEU0EuY4XL1oWpHFowCgjTImlQ8Ekkf+1aKmdkIDzo911q6
 53obFMHDpJbRrF3X6bCFSY7e6wmhEaa1w71kCvwsasy4GXUwg7Qd6L3ydrLfa4Kpo5g0
 1TZRx5FewnMubxPuwKHH571TzQq1ggvQFum8G/YSzEoxIm91/3xw4yqFHYT9sa5FWFVW
 Z05cWuBl5dyM52JuO1DcY/JJShbtLIAqNoN63KvymqCjOmO7rpeB9Cgi9tsYaHTgyccX
 0TEnnClOo3MMvgjiavoctrhxz96Xanlvl8RcyrRoz2kO/UOAJBWbRNuQkWzTJqeeMZNv
 yvLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ96bkGhfs4PRxEvP3n7afcoxN9Hd37I4N/ZUX5TlvLAOdnxdUvddeT4bPjLNCJ3wQsPsXxNr9kLWAsO@nongnu.org
X-Gm-Message-State: AOJu0Yz4IcNgdP7bfHUOxr4fXaQt+LGGV9vcszLKrmSLJ+b0/75pUlP+
 u9L7NbwP33OEEZdTfrAs5tPMerfMys/EhH288mtOhk4sMB+hxiwqN/VzdJIkwSJwXN4=
X-Gm-Gg: AeBDievtH8G+eh+192RC5bJRiNoCo5a63BRD83BPROFBbPYzTXFNpzOxeQ6ui7ud1sl
 kwrkKIBl15sYB7zAxbLd/GhH0xGUfK2AwqQDKYiGAj4FjXbH5vvZ7qgYYsVQUN7lCoJq3Wsn4WB
 FrhvdsytDTTinaAyXi7gBJXUg7AGvfKuvllH39yUFu8YG9IIbjphp43QEYsztP1Dopgq8BUmcJp
 o0sMphXNUB43xanrNbrOBOJSJXezBXTSrlAmUGkw+lByOrFMwnI2ij9OkudEomniCZWG6ePdR2B
 Yo9ogK1+zm+BlMAw5TCnpNoLGs6Ts7oR1qZvcN/cq6miGxermbI5hKZQkcBHqGVeo3C9OsRfhxn
 xsyHn93ev0xqmnLICjkgl5hi0qzUByXD2ai7ZXjwenUGZS3USKbK+ReymsvIDd5Y5EQ9JyCrfuv
 tunKM+B0kZiRn+u8e9JjNPVop2wb4X3E0dmyQkP8+WQxRkPdUR0z6SlTlKTwTf
X-Received: by 2002:a17:90b:2244:b0:35d:9c32:6219 with SMTP id
 98e67ed59e1d1-3614040e440mr27719847a91.9.1776944864945; 
 Thu, 23 Apr 2026 04:47:44 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm25595449a91.10.2026.04.23.04.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:47:43 -0700 (PDT)
Message-ID: <819bf32b-a6cd-46c2-b4ab-c3366eeb691a@linaro.org>
Date: Thu, 23 Apr 2026 21:47:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/microblaze: Compile op_helper.c as common unit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> In order do build op_helper.c as a common unit we simply
> need to use the common version of "accel/tcg/cpu-ldst.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/op_helper.c | 2 +-
>   target/microblaze/meson.build | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

