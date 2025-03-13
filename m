Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E24C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsht7-0000jv-H8; Thu, 13 Mar 2025 08:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshsy-0000Xi-KS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:42:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tshsu-0003Xb-7E
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:42:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2243803b776so23894795ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741869716; x=1742474516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bsj7AX8gQvYxU3KPVhraEp0zwvIkHHL34mRQ+1KZuRY=;
 b=WmZ9M4gse2jJudS4SmNXzXqzczL5AhIVnCTxV5TjybKonK8ni8bqCO8sk5Tc8HWOAx
 ltTJpqmeU8n83CPxQAZi7uJg6bKe4mDG3/oXDRtEoM+KDDANicNbzgRGcHzdaMvCtakc
 95tguOavsDeuKX694ZL8n88qPXM978McgzQCPNObaoAOOTP9KIUQGZfNEXXnZtuqoYH/
 XX2Ug/0C3wHLa3+/30NXWaGIN9oxjHdG/UG4NsLdkdsNAPCTHbYwey33LgdYeEmlhYd3
 noszKyms4FIjbPSkcqRidYrgrcW5k8Q6n7W5no5hSAdGAcWGu2OU/Gf5DVHsr0a4fBmO
 MFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869716; x=1742474516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bsj7AX8gQvYxU3KPVhraEp0zwvIkHHL34mRQ+1KZuRY=;
 b=DbxtC0ootTNeyc5FdSV33fECCrFadf/iR9Hwl/7JcxxfSw7B90MudvtPhC1eXP+A14
 0AEO84OKViQFSjxg6j8o0iv+1foPnSUYl2TAdpjFihEF2paqkcWG2eLd6GQ/7WFECCda
 uPK/13h7VOPvaElYDV22oAxGnJQd2dQWi2CvOcW55MZtGjeYRGN8/PZhm2+lkM2jrJbi
 f5IRCJZsF0blzo+zLbrHqyXQL5/26jqnR3BJlG1byqT2DADMvFajmW7FkHz3TrtkM5w4
 rS/Z4wFdcFT1TNbioSLxi+//d5wjCr3pKoV5GTsnacQG06Ld58EMAiuUAlU3GtPj/i/A
 RP4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaXVvaWDscL2Y26nLGynnAC2VIsNuEtzrfMO36MtAVlxI1C4Sa/+n6tY11CYPSI4fhulJaYybD2hAr@nongnu.org
X-Gm-Message-State: AOJu0Yx1fOwzoK5IOm6D3AbZtV15GPpnrBVVjvPiKzZo+KP06x7H8iz/
 HXRYg+x8QjRhaoS/XXQyb5icZKMAWGZo14sLC3tz+Mb3TTrlsnkGmfJoOnM9y7s=
X-Gm-Gg: ASbGnctjdCqVeG8LL0+erWTZFL63P7WJwZ9NTwKMOUJGhpWwXZ1gQQ2nK59ytdmBbv0
 rE4AYJgSJLCpE+iOdmxRs4b6KTarWIvARPvAj8z6GKWjnkftm/+hFb5h2W7SDR76oCGjwQ3vvB2
 WcTz/wzza978z2qAJ9YvhXv+Ba3G0Il/2adwtB8Ihr/QiYIK/pEjFra0Jd5Zi2yazIbwxkxiRFJ
 AHWIujn+mEYtkNMPZ8QHu9Pptn6UW8fg9WZy4CLykENG9J+mTBxyah64WynplA3ZxHBQ2r1sWft
 VzZBh0PpZ4wmgdwAFcORmdIHitCVDtK8sGuvlaxAn6Vgdj+fhB+/G+mFfcs=
X-Google-Smtp-Source: AGHT+IERoJ+ZwvsVDlGQHEAl1jJo/A2fCmH3J6LMkdMrCUY9jFQlVu3jmaBNWCoLnV4OjuRdhsNWlw==
X-Received: by 2002:a05:6a20:2d14:b0:1f5:80eb:8481 with SMTP id
 adf61e73a8af0-1f580eb8e70mr21068474637.13.1741869716038; 
 Thu, 13 Mar 2025 05:41:56 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9c95c5sm996405a12.4.2025.03.13.05.41.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 05:41:55 -0700 (PDT)
Message-ID: <54970784-4389-4f61-8c54-4413cba7ff36@ventanamicro.com>
Date: Thu, 13 Mar 2025 09:41:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/riscv: pmp: remove redundant check in
 pmp_is_locked
To: =?UTF-8?Q?Lo=C3=AFc_Lefort?= <loic@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-6-loic@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250225160052.39564-6-loic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 2/25/25 1:00 PM, Loïc Lefort wrote:
> Remove useless check in pmp_is_locked, the function will return 0 in either
> case.
> 
> Signed-off-by: Loïc Lefort <loic@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmp.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index e4fee10d93..81c8bd71ce 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -58,11 +58,6 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>           return 1;
>       }
>   
> -    /* Top PMP has no 'next' to check */
> -    if ((pmp_index + 1u) >= MAX_RISCV_PMPS) {
> -        return 0;
> -    }
> -
>       return 0;
>   }
>   


