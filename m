Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9345EC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxu3-0004x7-GQ; Tue, 27 May 2025 13:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxu1-0004wh-VG
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:15:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxu0-0008U2-5X
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:15:49 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74019695377so2305958b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748366145; x=1748970945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGa7/OAikUHlVl4F/tVkt/cibk7ms1BaLldKIyX8LvM=;
 b=b0U345Q+s2bE31cojYeq78eLLm63q7k6GmjBTW4pqcKmNbcd3zxYUzctUAd5Rovq0l
 i+oD2hf2Kp4OEVMeThDn2b+Z3JsdK+PHXUnViv89dVzeX26B5816A1MY70vB6F4tG+zv
 JeB+LbRG2ZqD7/qZw5FS9Jm9c8PydjnbbdU0jSmChVdymbV0dh2Twz0n1cAN+Gycl7mv
 IGFRGjV48O4MWEgvpG9PJ5YsgoSz/CMu+RBnspp1FEvPUX1cbaxo4gq83FHZiKdXeUDs
 U3wO2dDyExRYXzFpOI2y4DSkiK6v0wUa2aQAVrXiCYwfn2ZF2ZWo4v+QbV5viThqs8jk
 4vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748366145; x=1748970945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGa7/OAikUHlVl4F/tVkt/cibk7ms1BaLldKIyX8LvM=;
 b=KyjkfCSzYs4JQYVkEl6pcTRz72nUgw2jsjdQAMYHEgn6IuHuyXMGldbJdTyk0QdDiV
 QIVN4Za1JPoKZ/049DzjT+YrBp39I+yscX4RyfRFIMxCVhD+35YphS09XBDlyuIDRebi
 TLmY42X1w4xZT6Rybs03+aLWSKOLEh7odZs1BmuS7mT2LFyZ6EVVKPe5+QgaMtzacL1d
 j59wlUnrICYzxE67dWjkSw5gWLGQ2nZafc2jXJSzy0TuX23m3dI7w4cc1VkTG+R953m8
 Te2OhaXihcTjjiViQw8riSpryiUtfY6jQ0zcSi+g/Ry+fJlDL3IEMmq6uRIzis0GTtz8
 E/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7CKuYhKHr77MOZeOPHg7bXU2SrFoWlfzqvR5OcGJ17MftA7nHpGl+HFkOruMwKPrdp95e+hDyUeLa@nongnu.org
X-Gm-Message-State: AOJu0Ywe/wlO0ERUdEFmZqBqej6uMRnBXu3ncuEEDw6dkItMEiGQagMp
 CFdWreoBvsQN5AxuICGEuGM329lYogg3RiicOgQzJonFjADdy9xcoB9XfPodQYNbDQM=
X-Gm-Gg: ASbGncv3f/NaQ4Qk2s/+QlhWuN+WGPucF9UBfugk+/T99H62A8u11cYFp6jZw2KGWBQ
 vkwQcmFLmbt5uVcZMrT0d3d+Rt83uFgZ2ThKKKos+Dz2FyN7IPnawT37N1lrjfZqEYRFqN2XuVa
 DQsgPadT/ThL3ed6/VKXMoGIJ/qj/fXuFeFBxpoS8ybtZ0JHfhEy4kr8gmTZ4NvUTPvWzNcTVpH
 rXV6pMwrZbpnWUO7MC3Q8KtCWiF6s1MoZLiwZwiEUPrxw8wH9UYi/uV9Nd8xngKREPkZCz8Nc18
 q21VZBNVCCzjvsJD1yjuigVuXQpMg+Wn8asjqqwDxH8XFYyHse6k6iYq/CKvVpwE
X-Google-Smtp-Source: AGHT+IEoIUSPLtc1VAm1fVaShrF/8RvM4p5M3WhG06UewZCFu4/4vLS7a7uQARVUY6jhVi5D1/C4hg==
X-Received: by 2002:a05:6a00:1495:b0:742:a7a8:4135 with SMTP id
 d2e1a72fcca58-745fe0c9616mr23246920b3a.24.1748366145514; 
 Tue, 27 May 2025 10:15:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a1b3esm18994841b3a.157.2025.05.27.10.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 10:15:45 -0700 (PDT)
Message-ID: <55ef7adb-2c56-4638-8b9b-13d45f7890a1@linaro.org>
Date: Tue, 27 May 2025 10:15:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] single-binary: build target common libraries with
 dependencies
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, thuth@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
 <467e47ca-9cec-4c07-aeb6-4ac94c00563c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <467e47ca-9cec-4c07-aeb6-4ac94c00563c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/26/25 2:53 AM, Philippe Mathieu-Daudé wrote:
> On 22/5/25 00:34, Pierrick Bouvier wrote:
> 
>> Pierrick Bouvier (7):
>>     meson: build target libraries with common dependencies
>>     hw/arm: remove explicit dependencies listed
>>     target/arm: remove explicit dependencies listed
>>     meson: apply target config for picking files from lib{system, user}
>>     meson: merge lib{system, user}_ss with {system, user}_ss
>>     meson: remove lib{system, user}_ss aliases
>>     meson: merge hw_common_arch in target_common_system_arch
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Thanks to you and Thomas for raising the issues this series fixed:
- dependencies for target common libraries
- apply config for target common libraries
We should be good and complete in terms of build system for the single 
binary now.
(last step left will be to create the single binary itself, which I have 
a patch for, but it will come later, no need to worry people with a new 
mysterious binary :)).

Pierrick

