Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDE1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0lA-0007Km-Te; Tue, 25 Feb 2025 14:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0l4-0007II-L5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:38:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0l2-0000Wj-NK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:38:22 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220e6028214so132422515ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740512298; x=1741117098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J1W/m1iUSNJcGP7Ak4CKGx6TnAd4BXmbjQ8tVkiDg2E=;
 b=zikHnkgPEfSV3hsj+Cgs790JTFAkYCPFWrf0VYZ4fnAthTUGYWSzEpOTNZufUTCl+u
 WWE67i6e77nBz9FpwWIe+YQySdaHZUscaaFhzJi+cnus8T4KbJn8P43IByPYcmdVr8UM
 j8qLBafB7mnLg8lLWElvLmht4cxwoLzhS6oj9bn/2ai6+3pehgObhExWmZdGQYe18YHj
 dth5xlhUD0th9tVGNCdgNica5rrgI51KXwv1OOguxI+wlnyCxq7JOB9+yPgBSlji/sZs
 n/hZv/905XMg2PQPQCBV6s1BarYT7bOAAsyKtRgHfsVJcPzFaD88driWjYWGDwRp3Ek4
 hi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740512298; x=1741117098;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1W/m1iUSNJcGP7Ak4CKGx6TnAd4BXmbjQ8tVkiDg2E=;
 b=LZW5D8WWsYv1MEM57Ojcnk0ARr33IckdM0gQpq1hFRLQtZ8hxMxW+Q5o8zprD072M6
 fWKOwPP++a8ssrF+yFCZrsbbIqW5Zae+v/bZuxM1Okgci80fKlQrGd0nrO+ZglkwIZvO
 wg+q1xiRZ86REhASPVgS6WBPYGEbNznJke/SZhOOHAnigv1h3IqnkFgfWVyWKUtuL+Yn
 srnKE7q5QaEBT1fA9yEMNZc8Knsl7O288cO0kKJRz8rWcbw0IfzQfWDuMtuvq8bJSrIB
 4QHNSWmm6hUUnfdUPOA8yQqzqBa5+UL4j/vAQu7gLWHJThBvkpP9Yjq33cErvIL3N1EK
 1MQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/Cjb9jnUJvra/arC6WVbHBl6Tqs5eY4PE93AddBrJE//CylrjBr1qiv0AVfTQcebxRsMcCgJoTN7@nongnu.org
X-Gm-Message-State: AOJu0YycpyB/2/gQ12NXLBNr76ITDRpiDKuOwxsE8Dbjo8cPzElhwbv7
 Aq4XDCZY2YIrQuWnZ/IflsZl1p+bIXCDu5Jd3Z/G9ER6dej6UW5kf0sVDg4a1DbX7fca6KdF3IB
 s
X-Gm-Gg: ASbGncvgNmb4sAaNLh0LbyG62tC9T6GsT76ejoOVRjVLE7sBiS3ERKThliKDBtd85gf
 4Ito2DjkbZ6HM9jK7Wksat2uRwAyg8+gmAsYfwtz7GOZjCAHO3ckv30bY9ez9vYgC0aiqMDX5lg
 xcZkWzP7JbseQ50K3vPgpTJGchl2EWpoeiPEOKkL4qxWhkinQO1cBvduxhm4o609p2ZSq0NC0NM
 vT6qTdv6BI9gnR69sYyB1iNE6KI2HQTkIX3ISR9+cYC118Ykzp11PUcoe70qKTW7OBVPu41IxNH
 4zu0w24MvI41KMr/iSw2Tr4q2+vB7L8HHYt0JuWiJKtV7QBgqCcJpgMF6R2u/dIvkyoLaZMpAj4
 p9IsMErE=
X-Google-Smtp-Source: AGHT+IHf1zuRGvuBgx6Rhvg19XXP0mH3oWMkTaMqu+z/695uHrOw5wjXzI5vrvl+XysOuzFxN3IQtg==
X-Received: by 2002:a05:6a00:179f:b0:730:1da:d0e with SMTP id
 d2e1a72fcca58-73426d77fa3mr28283696b3a.18.1740512298506; 
 Tue, 25 Feb 2025 11:38:18 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a7f9d77sm1963293b3a.101.2025.02.25.11.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:38:18 -0800 (PST)
Message-ID: <c2e62cce-65f4-417e-bd57-85b64e78102c@linaro.org>
Date: Tue, 25 Feb 2025 11:38:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hppa: defer hppa_ptlbe until CPU starts running
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-3-alex.bennee@linaro.org>
 <ecce2fe8-f2c0-48fb-a3dd-99a1c4720dd5@linaro.org>
Content-Language: en-US
In-Reply-To: <ecce2fe8-f2c0-48fb-a3dd-99a1c4720dd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/25/25 11:33, Richard Henderson wrote:
> On 2/25/25 10:46, Alex Bennée wrote:
>> @@ -191,7 +199,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>>           cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>                                           hppa_cpu_alarm_timer, cpu);
>> -        hppa_ptlbe(&cpu->env);
>> +        async_run_on_cpu(cs, hppa_clear_ptlbe, RUN_ON_CPU_HOST_PTR(&cpu->env));
> 
> Nack, this is emulation of hardware, not softmmu.

Hmm.  I see what you're thinking about though: this function, after resetting the data 
structures associated with the hardware emulation, also calls the softmmu flush.

If we absolutely need to do so, I suppose delaying the hardware emulation flush to the 
work queue isn't the worst solution.  This is where the hppa patch is more correct than 
the ppc patch which completely eliminated the hardware emulation flush.


r~

