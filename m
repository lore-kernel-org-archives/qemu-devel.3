Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344F6C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vharl-0007iL-AO; Sun, 18 Jan 2026 17:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhari-0007gv-09
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:03:22 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vharg-0000P3-Ex
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:03:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo28310585e9.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773799; x=1769378599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hgv2TCb53Yuj1iGRviITZXfy1CdbaMx/7OSQNso2nK0=;
 b=S1oI0z7LtlCQIhELK7uvW695ENeT8jdAKU5ajBwuyEO9qv7YHHG+BhA/ItTMoo5gWs
 OYcbsBAzjChJ4ZpKDdDrHRbAurkauW3YjHtApZPSVPs4oA0Fzb3BGt527cQJAIO+UiSD
 ZlIWgCkDyhIY+lMlp2NHtxvP77p2BVZva4WSxp5wGgLVKd265QK3HjovxWBnFMe/UBla
 d9bY/Psrl5a7MvsLkXJN6lhiUNWbK/SOPZ7xcEKqb/M7QJULlD1YVIANGjfe+8OZEvOy
 b+wiOW6Mf3iCzQd2pKd3xJppCWdygiV+r3cmPzSm0fnsLm8h0q5SYZpoamrK9/6HGjvk
 cAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773799; x=1769378599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hgv2TCb53Yuj1iGRviITZXfy1CdbaMx/7OSQNso2nK0=;
 b=qKN2Nxcm0rYJqtP5+or699WMvSLMjJ76j7vTErepbNCN+2sQztCTeFxRhKqNZozjzz
 q7YsahN0rixluV5vQVBuxbQHNGiOIASnISSyMgOoLMAtPHYvu+hipqiItMQluLsGGeLN
 IDwImlRxoe4X0RG85McMGsOeQy3q9Pyhy2SIpWXTy43azYZ1AcGonvZYNmlywrjlqwfw
 bGbSy9QsiFk5E0aWar07dB+H4d51d9AfGXfjIlps+oJrKDB2LYxXURRm8Kk3k4OkcCr1
 XMbLCwYLkzxGbLPjghKmn50+W/h5H12RccIB0id0WqccFpiVN6zVr5xl+QwySPRtGSC2
 Ki3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8NupOXB3wRfh31pfyKcSJMYQ45gXwWdB4ohxHhXzjJe6oOZg4l9AlClm1EV/gvcFW3EVBHIBM8V8a@nongnu.org
X-Gm-Message-State: AOJu0YwXD+nBUayrY7ioFMLhA7l3+QO7WNUy3tzxBV0gGs71ihYADGhd
 FGpjtYhOXVFxpP8ppTbVTCNhJ32jxwGh9N5pJUquY6mjmQDUe4yHrBw00BKsWmyBAWA=
X-Gm-Gg: AY/fxX7VVYZ6MI+O3PV1SKc96hxA3pHzHi8xtpSsqRqZeYgKcHAMiuoAYm5j+m+/2U3
 lQa7i0SeQVcp8m5zDwwguYqwsSRERKoQOWJ4AIgn4Rm8S57pCpURq8V93LzuCrDMMaQEFfj2UOm
 z/TDuD2d2LHU8I3hc6UWlpzr/Pukw7tD9JdfDUGlulPUxf4ADzbslFXOVLWNNDSEP1lfvyl4trq
 WeqLrOrupAcr03gcQLGlixx4Dqd3m5Gbl+Q/JPQeR883nO7HWJ4dKnZ7weFISZtkCQRuyiadI9S
 21vUYxMbMCmudHGEzGWtNpyuRRfSCl+lhkN8wUmmO8MTV35FQJ8vznXvLX7YtjudhBKFi3/nYlL
 fvyXvj9bouZgUjj1dJqnIbQxQ0izoRIUqdITROcLTjzVoqIBVtwI840fYviDZv/7nEoFP1UbEJU
 sIrpvmgfaGkbS7lCMcbZQayvJ0QEZwXhrL1weFq2meqf5eSFpaPlJaCQ==
X-Received: by 2002:a05:600c:8710:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-4801eb142famr109060695e9.33.1768773798709; 
 Sun, 18 Jan 2026 14:03:18 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm65442845e9.16.2026.01.18.14.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 14:03:17 -0800 (PST)
Message-ID: <06ea18a9-e02c-4d5b-91e8-9f0fd1e8ac43@linaro.org>
Date: Sun, 18 Jan 2026 23:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 50/59] target/arm/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-51-philmd@linaro.org>
 <f7a2dc18-ecad-4487-9b7d-f85618fc2ba5@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f7a2dc18-ecad-4487-9b7d-f85618fc2ba5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 28/10/25 13:06, Richard Henderson wrote:
> On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
>> Do not abort in hvf_arm_get_default_ipa_bit_size()
>> and hvf_arm_get_max_ipa_bit_size() when the IPA can
>> not be fetched. Return 0 (and document it).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf_arm.h | 11 +++++++++++
>>   target/arm/hvf/hvf.c |  8 ++------
>>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> Doesn't this just lead to a nonsensical error_report, e.g.
> 
> -m and ,maxmem option values require an IPA range (XX bits) larger than 
> the one supported by the host (0 bits)
> 
> ?
> 
> Is there a reasonable way to populate an Error return?
> I guess this only happens with older versions of Darwin, because surely 
> we can always probe the supported IPA size...

I suppose (it came from 
https://gitlab.com/qemu-project/qemu/-/issues/2981). Let's drop this for 
now.


