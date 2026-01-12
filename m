Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F09DCF45CD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfPvS-0005Md-W6; Mon, 12 Jan 2026 16:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPvP-0005KC-Dp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:58:11 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPvN-0003SD-S2
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:58:11 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso49845335ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768255088; x=1768859888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qa7vWkA4IhFJkjX1kQYbliB9vhMrMUpkXMGgbuXNRc8=;
 b=UEX447Z1HL/qjmNSx8FBHH9R2VK5QGXfXYJVPYqZKKPoHiYZ5zI63cpZKy7uVfaljv
 sg4eW4NYGzuwj3atT0btWaoGIWId11CP7HA2lxwTQfY9xu+wslFRWJEFyR50daL5EOcb
 7cmOprSJ3OaPR/t68RxHZaP1tvyQMjFI3i4GxxVyYet8ETQQDjqltqaVLq48frYyDcbd
 GeS5LZPZZrxHKo5RRcDcwdiWPfbNwoc9LAPaL0uPE3nKMwkffh3QbKij0OheYqBS+MId
 sny9SuKONxHemIMRkco4NA0aWOQBEmKGFbxWqGCfeWZYBOB4Ve5JXa10o9yPpD5/TbO3
 0GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768255088; x=1768859888;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qa7vWkA4IhFJkjX1kQYbliB9vhMrMUpkXMGgbuXNRc8=;
 b=KCZS2tg5358dIkePvNRur0hfaNMquTCSanHVjoRyfWIeb6VTTrGhuUSLxyh0TcS07o
 aUSTtRcFh6hfsua/NSlvF273zfmwQQFKJ7tO+hh/e+SH3abfyzVvwP19QGZLPUMnskeG
 6uyBl7D3pYkGYnDF/PBN3UHUXe629FOg+m8BYTUCb23gL9rZqr0K0WAyNs/c+IIFu3C6
 /D3i2og40wasTIu8P4+i8b7VfLVEtuVRfR3TXLORGR6tfpP8r6m9SAq3KDK8eRtwGFrJ
 T1U17vCG2t1NWqdQsj+oXbqJZD3JVM2KD4OK9Epti/WHRC4iot/DAMn3kyA01E9l6MdW
 7p5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlnQCwSZtPj8j2mEOvgxAxbqlutNaaWat1v3sr+FCgLrArczjzPRvrZSRL/nWn+xKjtCzsPrr3+jGn@nongnu.org
X-Gm-Message-State: AOJu0YwavqfiwPIHP19zVor4sDJ37thztzSkMSfMSP3vlLQYEVlDvVDM
 5QSI8baNWZvSK5fZJQIvnEH0JaGp21q/VMjxbLYX+nLysgbr34zR+BCN/Cr9phYJCks=
X-Gm-Gg: AY/fxX5c51RhrrpZV9+vjbNM513mNT/N+cK2+SuMN5hnWZcWjPGS+DNcQWmV1z+8zhF
 laj8+XDDTfNf7Nx1nEZtGhmQ5waDJZ5Gv18umvQq8G3To0nzQtXxZZJRlS/rDAjhi1OktxqJ6w6
 A+ZlcXWF8jOGRdYpofGYsXVyxeJ2CQXBSH0JXEZ0UhtnswSzdEIzwpK7g8c0+f6FyPVw1z/QW99
 TrC6qepsmvmkuZQdiWrMOXvzhy2RMsNzcsFy0ylC3wp0Duy5i7SgBsP2nMsgUaa0CFBp2r2xab1
 3wxpmbcjkWZEmOniGPkxABjzkxL3O4KcFwsBGQsLrdN+s0W0kKFH6jHdqrpOnZdZdT05QKE458k
 eiX2DyQgpIkhNcFObPIsui/Y7riMvk1vURMlibQIc6wZwfDl8uTpKmHb9UblamMCo7hQAjQLgIB
 U1ZDOAkgjYJzG/L7qOX6D8jDowE4w=
X-Google-Smtp-Source: AGHT+IE8et5FL8/SnTvo4ONvh+gYYchslvAsPzrJO+/fsoz+Wap5TTjzknfmtBiW+e7ec+ELK2RZJQ==
X-Received: by 2002:a17:902:c94b:b0:2a0:d05d:e4f with SMTP id
 d9443c01a7336-2a3ee49a2e6mr185949905ad.45.1768255088095; 
 Mon, 12 Jan 2026 13:58:08 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc78c0sm184189355ad.69.2026.01.12.13.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 13:58:07 -0800 (PST)
Message-ID: <9bf69b0e-17b6-4016-965b-7cb3582b3b3e@linaro.org>
Date: Tue, 13 Jan 2026 08:58:02 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/rcutorture: Fix build error
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260112163350.1251114-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112163350.1251114-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 1/13/26 03:33, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects an unused variable error:
> 
>    ../tests/unit/rcutorture.c: In function ‘rcu_read_stress_test’:
>    ../tests/unit/rcutorture.c:251:18: error: variable ‘garbage’ set but not used [-Werror=unused-but-set-variable=]
>      251 |     volatile int garbage = 0;
>          |                  ^~~~~~~
> 
> Since the 'garbage' variable is used to generate memory reads from the
> CPU while holding the RCU lock, it can not be removed. Tag it as
> ((unused)) instead to silence the compiler warnings/errors.

That shouldn't happen for a volatile variable: please report this as a compiler bug.

That said, gcc-16 has been released, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/unit/rcutorture.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
> index 7662081683f5d781da74402113b73884780b1243..2f19d479a3f210cbca19205a0656eda1f4c2e5a7 100644
> --- a/tests/unit/rcutorture.c
> +++ b/tests/unit/rcutorture.c
> @@ -248,7 +248,7 @@ static void *rcu_read_stress_test(void *arg)
>       int pc;
>       long long n_reads_local = 0;
>       long long rcu_stress_local[RCU_STRESS_PIPE_LEN + 1] = { 0 };
> -    volatile int garbage = 0;
> +    volatile int garbage __attribute__ ((unused)) = 0;
>   
>       rcu_register_thread();
>   


