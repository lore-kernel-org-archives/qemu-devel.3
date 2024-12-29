Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88406E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRx1L-00061H-Q6; Sun, 29 Dec 2024 12:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRx1K-00060p-4k
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 12:24:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRx1I-0006qQ-Lw
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 12:24:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so57602225e9.1
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 09:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735493043; x=1736097843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ADXaISTO4+IOSzi53cSn6Gc7IReUg3FGPKS1aLMp7gM=;
 b=m03vQXWgw3dSJYZ89ChWKvSpBSjfFwtznRn8a9RaQXzgUINJ+WJHo8vKdOTE1Q9A/3
 yfAQ8q009wcvqa+LDXikltD/ziTR/z5KiOJsDx7EP1bzE7YA4mi9V8oHsRreWfXqxqWj
 iL2ULavzaSaZmQyXC/dqzo8qD6ahST6V63nWe4Hj6CQXnH9i1znAfyj5juI8TdLcyPmL
 P9u6QvLSZBjV8ltgqcqTeocakiNweXCuxtDKEW6RtAOPOkOMcmG2AalLRZ2DAC2ZEs6y
 gWbZor2GfncWiWh5lWHTWnHGbpJ39sYuoHMkPD18eoyT1aMirAk3/9leL2/CBRvfAIqp
 Yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735493043; x=1736097843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ADXaISTO4+IOSzi53cSn6Gc7IReUg3FGPKS1aLMp7gM=;
 b=wpf/L854+rQ5kQGhgWS8gjZwu9gPAFxL/TQohb9IcKiiMSkki351bfYvckuNuk6HEZ
 bSCAkcChI4eGv9zc+8AAnKBQOQkJM0Z7xQz7zSpfmYSL22ETo9r1gR3Ycn5jXFE7jOpX
 8oheuQ3ICGVCeCZiTu0tB2fhwIe9rPOETuWGYpq7VIdU2oyj+TeDfEnrSu8kaHn1A46A
 WR60yXQI+GIhp8r8oXWv13GGo+3KQ1Xf1bi4i+sXLerqVBJ0otpSZUPnWJPTtbpw5FA5
 tBfqYlFgY23Y69sExXdmXRg9ULE3lcZ6f1bN74uM4s04xw4Fj+3po5zhmvWkbCetxFJL
 v8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkVAsQyul3TqFKskzlTD8uP76tYLAhvNLL7HgNtCMrAGj8YVE0jWWwboMVR8MjzsToZARXGtYr2H8v@nongnu.org
X-Gm-Message-State: AOJu0YyxkFfRWVx8IbNbwEJb+UtLAtemxoU147CpbyYra5fW4d6THqFt
 LKBWVFNHVLsqjzAoctmTBbYKiA5TpMVHgeWCqLj/HzBHpZHBzj0C2xBzCBLBNf4=
X-Gm-Gg: ASbGncs2/uNK7qx6B/TGBxGYtmmM4wWFsGOJ0p7IFrgjhQfRNoghwYQdR4+ntrgXfG/
 KXqJ/jPAybxyyqob1Cfe4vO6XwxxsMs/+FHSFPXbQx1kcRlgPlMEgpZTt2k1Ya4b0+YzNLWUSKh
 /csNHczYcCZOvBA9zYTw6YcOJaLIcmochq9qATtlx4pd4xUvU57qqaXCH0IPf9RQWy6P33dx8XJ
 p7UukjzHEtA9agbBCHRldeh/6uysEzu48I/0EA8xrGGmjWoduRvSUGN71LvRqYIN8A+0QaE6S1N
 sG1ttOB404rjP9GbZDM8kX89ygeN1g==
X-Google-Smtp-Source: AGHT+IGVVEeWjEc2FX2Zp5CpRFv9oHZ0po2xUKTuh91n5yhjXjRUCD5Vam4qv25aB1gz8f4p5pwFRA==
X-Received: by 2002:a05:600c:35c9:b0:434:f1e9:afb3 with SMTP id
 5b1f17b1804b1-43668548499mr293163305e9.3.1735493042995; 
 Sun, 29 Dec 2024 09:24:02 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6aeesm366576755e9.6.2024.12.29.09.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 09:24:02 -0800 (PST)
Message-ID: <e491caff-6b3b-4e59-955c-cccd2a7f6510@linaro.org>
Date: Sun, 29 Dec 2024 18:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/hppa: Speed up hppa_is_pa20()
To: Helge Deller <deller@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <Z3BouGUFFP87PJyx@p100>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z3BouGUFFP87PJyx@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 28/12/24 22:08, Helge Deller wrote:
> Although the hppa_is_pa20() helper is costly due to string comparisms in

"comparisms" -> "comparison"?

> object_dynamic_cast(), it is called quite often during memory lookups
> and at each start of a block of instruction translations.
> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
> CPU creation and store the result in the is_pa20 of struct CPUArchState.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2:
> - moved init to hppa_cpu_initfn() and is_pa20 to end of CPUArchState struct
>    (feedback by Richard)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index b908cf65c6..05de952a87 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -199,6 +199,7 @@ static void hppa_cpu_initfn(Object *obj)
>       CPUHPPAState *env = &cpu->env;
>   
>       cs->exception_index = -1;
> +    env->is_pa20 = object_dynamic_cast(obj, TYPE_HPPA64_CPU);

Personally I find explicit casts to boolean clearer:

        env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);

>       cpu_hppa_loaded_fr0(env);
>       cpu_hppa_put_psw(env, PSW_W);
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


