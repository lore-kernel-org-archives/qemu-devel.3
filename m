Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E579CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 07:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uod02-0002vb-NA; Wed, 20 Aug 2025 03:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uod00-0002v9-VU
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:12:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uoczz-0008TP-3K
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 03:12:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so37810665e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755673960; x=1756278760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FQieiFwnl0WRp+YQcYw0dIHiUkFvbNMn9HXJ63tlf3E=;
 b=fbErFG+VhDIT5X0TYjbuh1cmFiu/HTjstkOS23K0+2x5dVqZsIQhPiMNIF1DWoyu4Y
 ZvfkHn+OUeUvyz93W2mKKLPTB3t+kWMayhKQc0n3nueDaKsKlF03LNwtlVewUV5slGu1
 Zm1HsONDllFeR2H0grRpzxrArRSHdM4SZKbFNiROT5EVaou91HNbhknmw8QJTf+9JS7C
 MH3L8qANFQQIqBUtBfJqQ4Cmf9nPy0vJQm7tHKT7VFdVsIo9wWfZAuYzEIT0KyrPhzTG
 mnMFL+j4FqhwMxoOUoVxFL0e43XXwKUxcneOtHhIxwWtvYgUL0vzvwj6zAXYJha9Iem4
 v9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755673960; x=1756278760;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQieiFwnl0WRp+YQcYw0dIHiUkFvbNMn9HXJ63tlf3E=;
 b=Mi+YatDvFhFvh8ocnFeWA3AqiJ/Vp9CRpwY7AvxageBHa0rrZR+Wikh8/vFsP28KI7
 W5+OvgnbTpZCEHfeb+bPxZuyAtd+Hy3iFxYpf8nuJogLzDhFgAX6QB6GONxi0WWhFjCp
 qGicM4xjrUPBoEkGmR6JUNXXQK4fu4xcCgn75EjshALig0JK/ORgrGZs38SWOTU7LGIy
 PEKQAJViKo2jLbItiks8v/+4JHhYvsKb34SwuFNnsTObcobaHNAVg0tyhocxPwnCq6or
 yJHUTb6fcODlaccJ4UoYM7pOTTVNZzLyIi3x/F86heKq+ab6dr1NXLh0y0HWTDS+7lIa
 5mpg==
X-Gm-Message-State: AOJu0YzTrzkh6riiIAjAw8HSb39tlIoNJ0D82j0ZJV4kwM3TrKckk2Ip
 lUq1XFxoUt1J9bEbeBuErcAMUsZzbjgRUoqKIg2V5RXrn35PPBO6J5VwlQledzJtI/I=
X-Gm-Gg: ASbGncv+0NcR+WxV4YNO3FgGR+NtNssmHGQ7HMqOvRiUXQkj1zBw9I/KxKTT99vANFw
 aizfFxrmC8vpcTdePkDik8iytuspiukNsxpjMMquOQnPI4TJ7amimXwdRU5DqAUHNjsxlqqsAAX
 5ZfBkerlYHHIwqN8qy9A5UhmvcvdQxdDQo0CVte15rAfQDVd+/EmMdfi3hdeIJdp58KiYQbJ+2C
 P6Xns6FnED0suO2s2Q86FdMkC6CVcXcvqC/12pEbSh5d1j+6sbgMMP4w7oIO01gPZuHXQx7bmLO
 Me8xeAgJZ1ScCxD3RsRaNt2bW1jUoI7PoKuk4uueyei0Jzx+6PejZ/QSfKC5DuyLQqNQBgvjUn+
 I2nZBVLkUndtGwnEbGTh5/yp+4cdxCcGzS/0/5znNH7CHaNPmLMjZrqCrgDJETdEasw==
X-Google-Smtp-Source: AGHT+IGtBasgA5GnMibUR5FfkJjw7FhEq66ZUh/pAHS931Wy+aiFXxsAx6SK4y9YO3903MM5JQIh3g==
X-Received: by 2002:a05:600c:444b:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-45b47a0615amr13474425e9.30.1755673960600; 
 Wed, 20 Aug 2025 00:12:40 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c310efsm19597535e9.7.2025.08.20.00.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 00:12:40 -0700 (PDT)
Message-ID: <c6611e12-9af8-40df-b3ee-d9d79dc46ba4@linaro.org>
Date: Wed, 20 Aug 2025 09:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/43] arm/cpu: Store aa64pfr0/1 into the idregs array
To: Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
 <20250701170720.4072660-7-peter.maydell@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701170720.4072660-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

On 1/7/25 19:06, Peter Maydell wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Message-id: 20250617153931.1330449-5-cohuck@redhat.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu-features.h | 40 ++++++++++++++++-----------------
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu.c          | 29 ++++++++----------------
>   target/arm/cpu64.c        | 14 ++++--------
>   target/arm/helper.c       |  6 ++---
>   target/arm/hvf/hvf.c      |  9 ++++----
>   target/arm/kvm.c          | 12 +++++-----
>   target/arm/tcg/cpu64.c    | 47 ++++++++++++++++++---------------------
>   8 files changed, 68 insertions(+), 91 deletions(-)


> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 7554282410f..e1bfca5947c 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c


> @@ -911,7 +911,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>        * - fix any assumptions we made that SME implies SVE (since
>        *   on the M4 there is SME but not SVE)
>        */
> -    host_isar.id_aa64pfr1 &= ~R_ID_AA64PFR1_SME_MASK;
> +    SET_IDREG(&host_isar, ID_AA64PFR1,
> +              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
>   
FYI when using:

C compiler for the host machine: gcc-15 (gcc 15.1.0 "gcc-15 (Homebrew 
GCC 15.1.0) 15.1.0")

on macOS, I'm getting:

[757/815] Compiling C object 
libqemu-aarch64-softmmu.a.p/target_arm_hvf_hvf.c.o
target/arm/hvf/hvf.c: In function 'hvf_arm_get_host_cpu_features':
target/arm/cpu.h:897:32: warning: declaration of 'i_' shadows a previous 
local [-Wshadow=local]
   897 |         const ARMISARegisters *i_ = (ISAR); 
         \
       |                                ^~
target/arm/cpu.h:892:39: note: in definition of macro 'SET_IDREG'
   892 |         i_->idregs[REG ## _EL1_IDX] = VALUE; 
         \
       |                                       ^~~~~
target/arm/hvf/hvf.c:818:15: note: in expansion of macro 'GET_IDREG'
   818 |               GET_IDREG(&host_isar, ID_AA64PFR1) & 
~R_ID_AA64PFR1_SME_MASK);
       |               ^~~~~~~~~
target/arm/cpu.h:891:26: note: shadowed declaration is here
   891 |         ARMISARegisters *i_ = (ISAR); 
         \
       |                          ^~
target/arm/hvf/hvf.c:817:5: note: in expansion of macro 'SET_IDREG'
   817 |     SET_IDREG(&host_isar, ID_AA64PFR1,
       |     ^~~~~~~~~


