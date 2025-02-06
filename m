Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596E1C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyR0-00071b-5n; Thu, 06 Feb 2025 04:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyQx-000711-Ng
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:44:31 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfyQw-0002Re-0o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:44:31 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so6537695e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738835068; x=1739439868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ejjTpZkkDDyalI24yhhci7fWdVMkcXjM8JpFoc7Ffv4=;
 b=uxukW0eKdQT+rSn1SvWOUB4X85keQrC1qxFA52fvFYG5E5rLGeS77w0lz8BMBQTOTB
 XBtpsfr0ZfRG76D1Q0TFXgK2XLPifVzPoFX3DLoqmGofeqSCfS5JxzrJTE/PZ6VYTetb
 RtHsDFiFGz26xyJQNpWBiDjBsdoxk1S1Ys4Q/dr1yA77oMH/0LNyzwLwI+h2vw+eFRrk
 QYu/7NLpDqTo5G3l1uN7wo763HQbtdxDUm928RLilBMY4NiC+jRjkrjkwfeZx9Pb+Bu3
 rhF8FDvCO4Fsva5zTuVJftm6tqU/aCFh0CLSmdQWSQabp3aWTsu6TsdjT2imFKfgxoBL
 27kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835068; x=1739439868;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejjTpZkkDDyalI24yhhci7fWdVMkcXjM8JpFoc7Ffv4=;
 b=WIOQAuasrT7HtO046UIfacLY5Up4u0ssnL8O0+zTz6e1aucR/MLkwPaV+5ojNEyx8g
 yOaT1nb8XMYKYBB9UdfX+OAg89benT467x3Jb/6G1OUPIGr8TZscM/NFQzAPGvFhCon6
 qKjjw3uZWREd4QyMF+lkHeM0ytuJlOy5H3WW8fONaVR1Qi+UkqE6Er6JFmGeJ4z0cpCp
 zDxK1MM525wErNjiBqnAgpVqGKrPXMLK1iN6kViskunZo5Uzv974O+GlNPo3IOPV5vYH
 +o2+RVaxUlfC3TH02M8C7Rg50enYPPTuHSI+bC0K2NUtjbVBuBM1dbeuoy+CxDMiNEsM
 0fGg==
X-Gm-Message-State: AOJu0Yxjpt6R/g0gp4LYcbXMDFhZYGHqGHLTlKlnYitU9P3dZ6/8YsDB
 Nzbuz4dtQEyRqjn16QfmU6CRrdjR6i6M4IDCUrxGr+isTQznpPolxZlghSkZ5Ui4TQ93Nz52zDX
 M6yU=
X-Gm-Gg: ASbGncuHufX1UhxJ1d7DksUzcvBp1JUZD1nl9j1HNLwr+PPySN0HpIClaoAWUEmN+jV
 BIsj2AVjhFntzXmdZ2v9zajuA/QdOW4KnuMMxXuriszsI4n/fTP91y5c1uSJgjMwpug3FQ2mQ7a
 BlXbPWPebP1fwnwU9UdqgDg9NPddIjLxuqJ8bBhwO5STbkJcJFbph3DP8yQm7lcetrnYYJ+ZYae
 kggH2PzMEv/rMB6k+x/lrffKJo/Xw6xbGs1hm8o2z4eMz6k2LOBMOrKgT9bJf3NB3lC65kS2dAU
 uYo8a8U060LWk4hSfSm0sTxr9k/tyFFAd1A2VSjdIdz5pf2mpqjg0Wi8tRU=
X-Google-Smtp-Source: AGHT+IGwclZZzUYlTjZVWZOpP10wHXZjfgFg0sg38e6APL57R8lQfwAV97Cs+coO/1wmdcOiLegN5g==
X-Received: by 2002:a05:600c:5492:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-4390d56c048mr39157475e9.25.1738835067858; 
 Thu, 06 Feb 2025 01:44:27 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc3a10fffsm184222f8f.12.2025.02.06.01.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:44:27 -0800 (PST)
Message-ID: <2a7400fe-36f0-4377-a1f2-abeca8290616@linaro.org>
Date: Thu, 6 Feb 2025 10:44:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qemu/timer: Clarify QEMUTimer new/free API
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250125182425.59708-1-philmd@linaro.org>
 <0e30640c-1dcc-4b83-b69f-305821714151@linaro.org>
Content-Language: en-US
In-Reply-To: <0e30640c-1dcc-4b83-b69f-305821714151@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Cc'ing more developers.

On 4/2/25 22:44, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 25/1/25 19:24, Philippe Mathieu-Daudé wrote:
>> Update few QEMUTimer docstring and add a
>> sanity check during timer initialization.
>>
>> Noticed trying to understand leaks in QDev
>> Realize -> Unrealize -> Realize transition.
>>
>> Philippe Mathieu-Daudé (2):
>>    qemu/timer: Clarify timer_new*() must be freed with timer_free()
>>    qemu/timer: Sanity check timer_list in timer_init_full()
>>
>>   include/qemu/timer.h | 12 +++++++++++-
>>   util/qemu-timer.c    |  1 +
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
> 


