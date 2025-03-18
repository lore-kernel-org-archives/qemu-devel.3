Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DC9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufYd-0001Bf-KB; Tue, 18 Mar 2025 18:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufYG-00012c-OR
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:36:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufY9-0000jl-QN
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:36:48 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22359001f1aso6154695ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742337397; x=1742942197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UUhi9h0Ky4Lwg2yhKJLazGJR+aageMiVJ0t5ECQWEPk=;
 b=GGtiG7Uc9LwD0oAqRA0H+b3GNA1agy5aJLQrH+8OEbNb0Z5RtvWFNXuZKBUIW0kTiR
 eVyGnw+jlJTl/3TCCD0qivsBd7XoxKVj5AqibUpYubQWieXxRd3tYgB9neWqR89WmeNk
 5V7aPolK4LYaTPy0Nt/DvmTAX0NBmJ1BxwR9d3Z8Rf5KOqSCiHqH9iTxS7Eg3U5I4N9Q
 njgSHZU0aXTs83vTK/RhSiDdqyHT+x+9WjY6uNdo3SOyFoLkMLyLpIYCEG9jRk15FTON
 tiFOuT1Vc1mOvguepv11CbRl6jyh3OD5m0aDvRHhm/m5xK5+WAac84BAXvVaSDsdJiwk
 2wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337397; x=1742942197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UUhi9h0Ky4Lwg2yhKJLazGJR+aageMiVJ0t5ECQWEPk=;
 b=HUnxOdt5/NNReWv5+s1G7GxpI0/MisCVR3FoVCzGsIcST5FYPiX30VtY5TiGOs9Ae4
 Z7gMq38L/vXCQY3Fmhx0cTLo9dzXY3s8t2ZxQjTGk11ChWxUyfYPjbNyprcZg7Aanx/X
 7w85aWV4dQ0IU4D2Lk5ayfIc6GePQQBfgsBc0uoHVx8bW5j7HJh1Vz7t8hkHxOdlxyti
 q6kl0IHXAUHKplu1hhuk6vFMdSAtj79XoHSODYIqCeUKOTeZFvomrw+kwoK3Y0G1GVbA
 RyxAMy+TIw4zyIsoXV2hGxce8Cymi8igMnf+EW4WHLJYI90X2FLBDiRngyvn9POPypEz
 GJtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF9ZxmRaAi4RPNLsLS/v0L5BwQ80tjDgFuYrsJhJAXXBUkr0VdgswQtMECjAAOidTVcqKTRAAzzFjQ@nongnu.org
X-Gm-Message-State: AOJu0YwSZCKbOS+GCPuKTdQdBOmb4ucE2J0pWZtYd4Z7I0fkiF8WGbRx
 P9P0W9zzwSHvbFeRMbzOhCWpCasosaLDj9Jl1Efcy4x5awVwJmpTlUk57bITmME=
X-Gm-Gg: ASbGnctbaDTGYiKBKIfrkY4RUO2pBJ7Oj8cDMGgS451PzB/HX6+cXUQfE3zW9V4hWhh
 2f8In4VialyQ7vKHwy8v+HxzvFIR0hJM5jFvj1O/xpKq8LfI/DSkBk1QXXRKJyBQATSaig//0Su
 WXIs+CcCAJU+1lytNK9TJ5DkP7cjbwaKa+DWATF6lJmRGZA+w5//fvSFYKBSvSVEbW0Uu+zIA11
 +/29hVuKoVIu97k2zZScWb0BaKrJ6l8seOHk15scqlVTp6jlkQs8/paAOBqrep2sk0L2LoPA93/
 9j/vgzfWNu2dDduvfz2Q+ZtU4tPNyMiTFt2OS/ev5vjTrd87EODkx34kMsSWfGRaWZE5jhsGbfD
 P+fCWIB9f
X-Google-Smtp-Source: AGHT+IF/EP9tvkxdUM+YtdNjRtxjdctiECzFem2hCJcdLxuxEimfX8lMgON8I3Z9Cbv3sCS9h/91yw==
X-Received: by 2002:a17:90b:4a11:b0:2fe:b174:31fe with SMTP id
 98e67ed59e1d1-301bde51a32mr547250a91.2.1742337396781; 
 Tue, 18 Mar 2025 15:36:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf589bccsm37460a91.11.2025.03.18.15.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:36:36 -0700 (PDT)
Message-ID: <ac79c5f1-d7ea-4079-b042-3805063fddba@linaro.org>
Date: Tue, 18 Mar 2025 15:36:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
 <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
 <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
 <0c6f23d5-d220-4fa7-957e-8721f1aa732f@linaro.org>
 <172a10d0-f479-4d6c-9555-a9060bdf744e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <172a10d0-f479-4d6c-9555-a9060bdf744e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/18/25 15:25, Pierrick Bouvier wrote:
> On 3/18/25 15:21, Richard Henderson wrote:
>> On 3/18/25 15:16, Pierrick Bouvier wrote:
>>>> This doesn't make any sense to me.  CPU_INCLUDE is defined within the very file that
>>>> you're trying to include by avoiding "cpu.h".
>>>>
>>>
>>> Every target/X/cpu.h includes cpu-all.h, which includes "cpu.h" itself, relying on per
>>> target include path set by build system.
>>
>> So, another solution would be to fix the silly include loop?
>>
> 
> If you're ok with it, I'm willing to remove cpu-all.h completely (moving tlb flags bits in 
> a new header), and fixing missing includes everywhere.
> 
> I just wanted to make sure it's an acceptable path before spending too much time on it.

I would very much like cpu-all.h to go away.

It looks like we have, on tcg-next:

(1) cpu_copy is linux-user only, and should go in linux-user/qemu.h.

(2) the TLB flags certainly deserve their own header.

(3) The QEMU_BUILD_BUG_ON assertions need not be done in a header,
     so long as there is *some* file that won't build if the assertions fail.
     Perhaps cpu-target.c is as good as any.


r~

