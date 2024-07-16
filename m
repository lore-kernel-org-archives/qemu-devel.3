Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287E0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgTx-0006hV-6M; Tue, 16 Jul 2024 07:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTgTv-0006cK-TQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:36:31 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTgTu-0005eG-3Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:36:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b5117ae06so3904299b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721129788; x=1721734588;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fIrjmnrcime12URGWOz+U3tVhvhx495pQrmKJbaCEkE=;
 b=zbmzwRiM6T8rwiISfNhDefuTEkyXP4V3uS/i/mWfpUJzFPg2+C1VOzbp9ZmK3PJDE0
 n/mdgVxwPtMk93c238W80KxW7WYX8024vUEaD0MPHRDP8kyFjTnup8PU0ixHotGpCCeQ
 MfroBArFEbkEjIjYy90pDYEUFvsIrOovqhIk6K6BlhEnBjFIzz+NmaavxDt/lU+kF415
 rInk8bhX4Y7nofea+1KZBRi5O2z9LfTdJHnqxmcfndZTtaR0i/W3LWQ/X3hDTOiFLF+Q
 FfERzjlzzh4W7NtrGRFBpQ/y69pjZKolZVC/MckoMNxrs0C7sBB0Y2tdsaH+/tGExqb5
 3AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721129788; x=1721734588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIrjmnrcime12URGWOz+U3tVhvhx495pQrmKJbaCEkE=;
 b=VYqT/kIDPaQbU1pYLhEnGJYBGMzLwnRtre04qrt0dWavKiqUhzsdsmV/qSJhK096WP
 CjrTg7iqfQIujNej0uTlhSqLB9yFk1V2VOe5WL70IhdldGBuYfgkRYv7wBIFIogX9/vm
 gqDjwtrHx97evGrVMEEwQpnoW9Qh8cMpCvOoGdwPOV2Q4S74b8tw7c/O75ztH65yEr5+
 lDK3Iz/YGLfvadqH2QlJVP+odHxAEQff7YY3rYKE7U8L2fpr/t0n1+pQ7XHUpXZaSwLp
 gnCi3sW940zvqvSN1W8GV/WCf1eQDlZqX9bQWkZUFUQIO4nNHuIyycVEl8VLAZLCQ0GF
 q4lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqVuhSZP98OY5NrJEvQtvWmA2ItSDcOqO6llAjA9JVvzYtWNiEZJi0w89W9RC5SHkdOi5Bel2vxaNo1+J2lV7NFNrGupk=
X-Gm-Message-State: AOJu0YwYn7zHC2UV6lASWBvEyM+VIVcTddAroA4H8njs2ihJanw/LZlS
 MoOgm+cGfrRzqb87aCR+vb2ssuzjBsZQq0t8Vy+dNxrLM+nsuy4dixNpt7l96x0=
X-Google-Smtp-Source: AGHT+IEQVrTfKfyPKCJhRlvLtuj+FAKBk0KVvsPqj+ybVV0I53B3fwt1t2Qgzq9+Gr8iqBo42rH2aQ==
X-Received: by 2002:a05:6a20:2590:b0:1c2:1ed4:4f91 with SMTP id
 adf61e73a8af0-1c3f124ac4bmr1630429637.31.1721129788574; 
 Tue, 16 Jul 2024 04:36:28 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ec7da24sm6056707b3a.113.2024.07.16.04.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 04:36:28 -0700 (PDT)
Message-ID: <cdd5ce60-230f-48a1-bcf3-9591b8bede95@daynix.com>
Date: Tue, 16 Jul 2024 20:36:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/arm: Always add pmu property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-4-f3e3e4b2d3d5@daynix.com>
 <CAFEAcA9trFnYaZbVehHhxET68QF=+X6GRsEh+zcavL-1DxDB4w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA9trFnYaZbVehHhxET68QF=+X6GRsEh+zcavL-1DxDB4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/16 20:32, Peter Maydell wrote:
> On Tue, 16 Jul 2024 at 09:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> kvm-steal-time and sve properties are added for KVM even if the
>> corresponding features are not available. Always add pmu property too.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   target/arm/cpu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 9e1d15701468..32508644aee7 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1781,9 +1781,10 @@ void arm_cpu_post_init(Object *obj)
>>
>>       if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
>>           cpu->has_pmu = true;
>> -        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>>       }
>>
>> +    object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
>> +
>>       /*
>>        * Allow user to turn off VFP and Neon support, but only for TCG --
>>        * KVM does not currently allow us to lie to the guest about its
> 
> Before we do this we need to do something to forbid setting
> the pmu property to true on CPUs which don't have it. That is:
> 
>   * for CPUs which do have a PMU, we should default to present, and
>     allow the user to turn it on and off with pmu=on/off
>   * for CPUs which do not have a PMU, we should not let the user
>     turn it on and off (either by not providing the property, or
>     else by making the property-set method raise an error, or by
>     having realize detect the discrepancy and raise an error)

I don't think there is any reason to prohibit adding a PMU to a CPU that 
doesn't have when you allow to remove one. For example, neoverse-v1 
should always have PMU in the real world.

Perhaps it may make sense to prohibit adding a PMU when the CPU is not 
Armv8 as the PMU we emulate is apparently PMUv3, which is part of Armv8.

Regards,
Akihiko Odaki

