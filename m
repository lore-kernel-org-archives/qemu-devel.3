Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60A5D232E4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve5Wy-00045N-2W; Fri, 09 Jan 2026 00:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve5Wv-00043e-7j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:59:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve5Wt-0008OB-Fz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:59:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso28470105e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767938361; x=1768543161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rvi2gzyYnaWoTGayjwMKg9nXmVWOzGTMp22uy2P3Pcw=;
 b=EF7EJz6te5kT5WYL/Hcm3280YsjX7iWU25F0rnbWQeTrFlvedxYrOrg+9XyOcs0Xwi
 D55/ad7pgYEYxedFGFRGJI7nCpFHvtX9LQgjNMB0rJ5kWIuKIdx8+BMYKxP3T1BIUejG
 QEJdSJRsFWA4fYQLca3OK2Q3stcefFrZRhH/aX7TbEyrR4oj4YnQ1MVBxaT2PSrgTYdM
 CPCjv8H1LgKCjoS6HioKZ/iFDGFaaRkhmg+Y6mojWlEBOaeiR+RpJ5lRvdDKQmg3pEBP
 Mt8L4b8jwFubRD+iOu3IGPx3zOiJcTRDGHPjCGdsooIjk/4Wk6lyKRIDyOlf4cnVqONO
 pPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767938361; x=1768543161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rvi2gzyYnaWoTGayjwMKg9nXmVWOzGTMp22uy2P3Pcw=;
 b=Yz3dr5jPL+L0+sCsozkTO1lwHgRhPnfLDo5khI/CkpNasGsisbbDI1TN+rgljFM1jJ
 7CmUjQDA/KyUerAJ7P070O5CcM6T6A3XfaxN4uj4ox8Nuu2SA5VsWGchGDMYKYbt5+0Z
 YWwemu4xTeuVj5epU8RK4fkOUmWORKS4Wailg8u0/F/pgDuEnMckdRo1A2iUJEcdu4cZ
 7i4yuky1O90mmETEFYYKFx0dnufnhe90ZXulkhbbIxi0UrthfmbXgkff9BWd9d5zvLFB
 CBmEAF8qvrixrEeOXLxMl1PQEiSL8QUFy7SWpfipjG+Ioq9vDgbPfKyLyFoIcIlERt44
 pOIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLXy68uemOxfAvoe0mkT9q+sH9dLy79ZwJavFAgBiHuk1L5c1Vbmotswv7hLayZd8FDBrm8bNTymlH@nongnu.org
X-Gm-Message-State: AOJu0Yx7+6J+O+ZJoJFY6tqEyHCm8z6oy6gMG1WX1dhfmczQFUxHoYh6
 yTPHWH4bOKiPJ3DKbeah4ZJ3A9cYQqo9zJ5SDbkB1p7ka1qcNpLOR83DzZDlogRTqUQ=
X-Gm-Gg: AY/fxX7W7YZqvh7107VqMmJCHk9cAM6ilvX90BzPkDD0IvA9DXEneLkJAa0l8SHmMmz
 hR3qKVfzlpFYPXOScgGqk6uoshdRFWB9m/hU7HKHJ9uWSOcSjy/GrRRAx8qM94XSgBenGpTQMWw
 Cx+RUNv6Zlr6DslS/YerRhg/bZeH6j7p9HSFnA/6Z3P+bJhivFkUz/iF4ufLB++4sx2vavHnDmU
 lufkLoTQ0EhiPXdv5bIdS/4syKeANS1zXqATAbsFZ440tfEjKRgyhU2TC1wKq2WJ+6g4EOm+giM
 1AORtLkKfX4UipKWJPZBXYvVOKxOqVDLH5ThZaEGZGrlbPftal3izwBHZNyTUpym2Lv5enLVz0T
 YtMl7K3sy6OKo9ivvpG1bKcEDaFD9QDKDmDb9Y5b99Juwid7XByXey3PpKqPlyEPTVhkh7MQeqt
 zID1W/tNU81JQN6WN4d0wXF1u8L4GSa+ggHYqMt/qkK+8SZ2tp1i1eig==
X-Google-Smtp-Source: AGHT+IHtjIH4zc2a8XeLmG30K3XYQurv2ul9oqAqz9m4no2FHsZRkgAKnlGPBhlVGKHEip4EExvUzw==
X-Received: by 2002:a05:600c:83c9:b0:47b:e2a9:2bd9 with SMTP id
 5b1f17b1804b1-47d84b3b719mr108605335e9.31.1767938361069; 
 Thu, 08 Jan 2026 21:59:21 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm20361294f8f.36.2026.01.08.21.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 21:59:20 -0800 (PST)
Message-ID: <4a4e9d19-e9bb-4a35-9b5b-c24f4ef80489@linaro.org>
Date: Fri, 9 Jan 2026 06:59:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 tangtao1634@phytium.com.cn, richard.henderson@linaro.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260108210453.2280733-1-pierrick.bouvier@linaro.org>
 <fd731d08-aa55-45e3-bdc1-471c449d6ccb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fd731d08-aa55-45e3-bdc1-471c449d6ccb@linaro.org>
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

On 8/1/26 22:06, Pierrick Bouvier wrote:
> On 1/8/26 1:04 PM, Pierrick Bouvier wrote:
>> This will be used to access non-secure and secure memory. Secure support
>> and Granule Protection Check (for RME) for SMMU need to access secure
>> memory.
>>
>> As well, it allows to remove usage of global address_space_memory,
>> allowing different SMMU instances to have a specific view of memory.
>>
>> User creatable SMMU are handled as well for virt machine,
>> by setting the memory properties when device is plugged in.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/arm/smmu-common.h |  4 ++++
>>   include/hw/arm/virt.h        |  2 ++
>>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>>   hw/arm/smmu-common.c         | 11 +++++++++++
>>   hw/arm/virt.c                | 13 +++++++++++--
>>   5 files changed, 40 insertions(+), 6 deletions(-)
>>
> 
> v5
> -- 
> 
> - Use DEFINE_PROP_LINK to define properties for smmu.

Thanks!

