Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69304E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 22:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRfiS-0005ri-FC; Sat, 28 Dec 2024 17:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRfiO-0005if-51
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 17:55:24 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRfiL-00032V-Tt
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 17:55:23 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f441904a42so10808520a91.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735426519; x=1736031319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwZRikBHZ6KNJ6OOk/3H2qwRn2eKDb3p3ZPj9cy+iuQ=;
 b=U6UIne7tpZxIjQ8zke6OYp+QnhC3QGnMA4j9Qk1Fj0hAfq/A0lK9FRZUPG2IOzrgGi
 MmOHpoKrmUuFiXkR+WQg9aZw5mg4s8mwK5XMRKW+JvvIwmjCoWoQiIeohQad91gK24VX
 NX3++tlbYlz8U7+XJdlIFiNa8Petnj7EavZz+n4I/UryUodX+qhT64Z2K1TRsphv15ym
 ZSl3fHrQdJf/Mi/4uAcfpEjomoXij3z7PUA/OSXLYIgNwkgt8YSoIXNe575itpdC1mjw
 Sn1u2XZtqVT3+nnYYcQFLyZpAXplJ9Q1rZM4EByydT69+ei3OWKrkI+i8Aqz7QMAGmlP
 eeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735426519; x=1736031319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwZRikBHZ6KNJ6OOk/3H2qwRn2eKDb3p3ZPj9cy+iuQ=;
 b=CzpVC7k18yXt81TXjlwmBU8gdQpw7M3dSRlCAZRW+T7vxjf4nwRFy1jfUkGPIlkgjx
 VsyOFk+GbUVfQLRISojvxJpVWDSrsEqieQ8Hj2BIh6mpcs+tTyXTYF2z/sIoWuyKZ8QS
 DO7cej8h6uRqf9c/Q/tNnaXX9vEOTEDDY2vfzR9K8YmljHJdGmypUW/TgfdlsYMM32J3
 9avzEZTqdyvr9MOiwJ6IdAjdt4abBGeiqP0bbnkarpMSMy3hUduzhEHrbZYQN/ihnNft
 W7uOnTwwS++nKmOAU7bqDhL2Tk9FoOLtYFmhCMnSb/aXaUffEuMpOn0vlyH68ZQKkg6X
 v6YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUzCzbUiC9oWhVVgw4AikCz8zInatv2A/FDRiYmfSh6yBgw9voHx46Q7W/JlwUfCe2IxOf+W/jxyQ0@nongnu.org
X-Gm-Message-State: AOJu0Yz4Rg4FQLb5S1/G5pa/s7XI4I5nUYPrPhjhaEMmyEXgGuQV/ojr
 0jsRsV3+F1o/0TlxKZXhJjQDvvonu3HztVKnll9JH0lXN/T/Rxq9fVhczM1kcU7P67QQe/GyBuh
 OlHE=
X-Gm-Gg: ASbGncsP7Wify9DkflJrFEoiCH9TJujno9nJLr3xsQU2bGMq0MZN1/F+7Fofi1zF8QY
 tOFsquaBacLlXZHV+4qi/m3zgUM0WPirgYbDl9KQVS8QOK4dCuo57UH/QgpM5TXFqY9uelBMeiT
 o0DL8YCvzgjFB8eHE0F4cZk6oGVTldFLSKMoHyIHvFhrzVNu2LB6JCCRd6w2F0oJrdIGVmWPNJ5
 YgPszB7F35N8Fpapj2+EpGWboHuWIIdPi6fGnhMZ2a2UtUQeH5ry1QLsx/IiMc/ZsmYIKowhCIW
 k1bApay3VGnAIDi0iQgbsFFjj9BA/zshvBfIjN0=
X-Google-Smtp-Source: AGHT+IFMsfVfz731wevtHtSnVIl2/eIImcDnJsr8qwWCEYblTYdUkA1skNsW+rTwhUxQHpUth/h5Ig==
X-Received: by 2002:a17:90a:fc48:b0:2ee:c059:7de3 with SMTP id
 98e67ed59e1d1-2f452e3a9efmr43792943a91.18.1735426519180; 
 Sat, 28 Dec 2024 14:55:19 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c4cc5sm19993365a91.12.2024.12.28.14.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 14:55:18 -0800 (PST)
Message-ID: <e2a83e65-8ed4-4fcd-933b-1f40446d0fe5@linaro.org>
Date: Sat, 28 Dec 2024 14:55:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: Speed up hppa_is_pa20()
To: Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>,
 Helge Deller <deller@kernel.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <Z2-nWcZ5l6oklIZW@p100>
 <8150fda8-7f13-75d6-57cf-e2099b14ff33@eik.bme.hu>
 <96b8aad9-1eda-495c-a0f0-0e955151d4fb@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <96b8aad9-1eda-495c-a0f0-0e955151d4fb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 12/28/24 13:12, Helge Deller wrote:
> On 12/28/24 12:16, BALATON Zoltan wrote:
>>> static inline bool hppa_is_pa20(CPUHPPAState *env)
>>> {
>>> -    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
>>> +    return env->is_pa20;
>>> }
>>
>> Now this function name is longer than what it extends to so maybe it
>> would be simpler to drop the inline function and use env->is_pa20
>> directly where it's needed?
> 
> Yes, that's a possible cleanup which can be done afterwards.
> 
>> Is there a reason to keep the function?
> 
> Personally I like it more than the "env->is_pa20".
> Richard, any opinion from your side? Should I send a such a replacement patch?

I like keeping the accessor function.


r~

