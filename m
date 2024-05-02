Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89151C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Si7-0002X1-9z; Thu, 02 May 2024 05:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Si1-0002Uv-HP
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:26:34 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2Shz-0004NF-9V
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:26:33 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso47950031cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641988; x=1715246788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TbOTRUl7TFKgvJnukP4K6diYww+Pm6wVeTRlc0HWXD4=;
 b=yHvJ14mZn4xsZ0mB8fjBRiBZ+GgfGzkz9yJZGDZTpVapRLg/KxUpY9I1F+ny/VvYDk
 P7a4iCC4w/mQ9C2WBLG3sM/xc3b++SO98khIOmRlTOq9FWyxKOJXQsO2wwb+8ciwrSha
 Q1vR2RkjBUKXmmVo0XdWTg6BRYpUNpLN4ctNLFOQIT4tBYutKvkeUIyPIDmgvsq6FsMX
 48VhjKgy4VEsdrtARg9F8iCQuWm9RWIr0kBgSoDVJeYYjodrz06RPzYrthKaXedWsj62
 rl63oFQtKy9rux2AoqCZE9crAYqUl1Oy2BzF97nQJtwzMdhqwk6QBQ2Z2e0FB/jvoFYf
 gLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641988; x=1715246788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbOTRUl7TFKgvJnukP4K6diYww+Pm6wVeTRlc0HWXD4=;
 b=ZD+YML2ofyGUzTmOHCJ7RJ0sXn4GBIu4SF+fxtYMEUrOhYCxyROdbokNukUg3Il+R2
 ES00vGSiDYb9WV+623XWBLdAKH3Iz9MHl31uICbeUjTfB45sckg9/OY70UJ5LfeIYbzR
 x7fjZVEYiSnWJf0eQA28okQldvS5JY8kb2stVXFaY48sQVD3kSZA+P56QSOR5FujuyZ8
 653nL43/jF7Acdo6myRPUwCRsTwhfDbPG8YN2vzVPSI1aYCqlHE3SfCfAT4eLTkvEyG/
 MZhyfm9YvhKOBWIeohPr3OURy9EKrsn5pHtWnqmpvM8GwBdKeq67XnS45iTtU+urPwaU
 njUw==
X-Gm-Message-State: AOJu0YxJdhHLfoFQ1vChGCjdIeCtYWDIjlZpkUydi1v4M9It0LxRhCj5
 g+Kx8uRV0bOtGAzch1RAdniqQZ/ReU60kcLxVLpemmslXKg108mcji0ZrqpZsUM=
X-Google-Smtp-Source: AGHT+IHMHc4N2Va2oikHPiaDr4YPbh9MJA/RLEXoCPz+2d5sBHdHGPdKpzow8k90U/jPL/AqjhmHaA==
X-Received: by 2002:a05:622a:178a:b0:43a:bcd9:5d5d with SMTP id
 s10-20020a05622a178a00b0043abcd95d5dmr5673454qtk.19.1714641988181; 
 Thu, 02 May 2024 02:26:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 ff22-20020a05622a4d9600b0043a0acc96e4sm301329qtb.30.2024.05.02.02.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 02:26:27 -0700 (PDT)
Message-ID: <26211a43-24de-4222-936a-259f22f052d1@linaro.org>
Date: Thu, 2 May 2024 11:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: Allow building with GnuTLS but without Libtasn1
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240502081144.86599-1-philmd@linaro.org>
 <d67338f5-a13a-4663-b77d-f9dac2b2936c@linaro.org>
 <ZjNOGBnv4UeaFSLI@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZjNOGBnv4UeaFSLI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x831.google.com
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

On 2/5/24 10:26, Daniel P. Berrangé wrote:
> On Thu, May 02, 2024 at 10:22:02AM +0200, Philippe Mathieu-Daudé wrote:
>> On 2/5/24 10:11, Philippe Mathieu-Daudé wrote:
>>> We only use Libtasn1 in unit tests. As noted in commit d47b83b118
>>> ("tests: add migration tests of TLS with x509 credentials"), having
>>> GnuTLS without Libtasn1 is a valid configuration, so do not require
>>> Libtasn1, to avoid:
>>>
>>>     Dependency gnutls found: YES 3.7.1 (cached)
>>>     Run-time dependency libtasn1 found: NO (tried pkgconfig)
>>>
>>>     ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig
>>>
>>> Restrict the unit test pkix_asn1_tab[] variable to CONFIG_TASN1.
>>
>> Otherwise we get:
>>
>>    In file included from tests/unit/crypto-tls-psk-helpers.c:23:
>>    tests/unit/crypto-tls-x509-helpers.h:26:10: fatal error:
>>    libtasn1.h: No such file or directory
>>       26 | #include <libtasn1.h>
>>          |          ^~~~~~~~~~~~
>>    compilation terminated.
> 
> I'd say that crypto-tls-psk-helpers.c shouldn't be including
> crypto-tls-x509-helpers.h at all, as PSK auth does not depend
> on X509 code

I agree, I tried the "less code churn" path first :)


