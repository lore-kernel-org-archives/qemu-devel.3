Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1B1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjltv-0005cL-Cc; Mon, 11 Mar 2024 16:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlts-0005aM-PU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:05:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjlto-0001Ro-7B
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:05:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e1207bba1so2582872f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710187525; x=1710792325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gq38VEc4wr9lp+A771Ytc0HuLfpanQX2CuZ1pE/R+8=;
 b=hDt5a/Pob2Lzxjq95IIBDBuPYaEi+YoUlO57iXc7+cHqBKB751SqPGWQPA/JSua0mY
 PLFIZ9h/7a/L3b+kMipHx6z+XuItDXbEbbez+X4cQmaL5udUWLqXeB84RiOXSPRLADQb
 6Em6SvlaTPaQaE1omqCU1SqePqDpDjEpO6WnuItXx+mXDkhAsdStu7EtZp9Bf0WLMlhV
 9ffSZi8C11EgWRUIrIkjaOXTBIzWDfs4F3O+VVkZZMsi1XfC65m/20z1yg1rRKkhRbYH
 6ujxNVbJsQYyo7NL4r0ddASOGoMj3TdWBkfVfW5KlADQiqTAuoHJPkdD376PtH+kAsJt
 rKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187525; x=1710792325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gq38VEc4wr9lp+A771Ytc0HuLfpanQX2CuZ1pE/R+8=;
 b=hUQ3yHKug1DJFtTQROZBt+sP7ZryGB3HrlapeS8bnNnLOZlgMZy6zQcxeiNyLi4M2P
 bOedA17ZVfjo/Lr1zfJw3FML7nl/6T3fonQIDQt7tBGFbRO6Fo6W0SKUZWviNDraquBg
 pyLWfv5foL54YsGHlQf+yMeeEv9reefpQAHAD60Yne0MLtNIDoXQd5AIhW+S1VjA4McV
 R+T99UZ5KXoubNUlM00s5lkApKdFuM5q+3tCVSMX3qBdGRploPa3pL+AQboYJT4uVeOV
 MTS0E3YPn9sDhNqDEzJuTCpSGQiGftaPGRvLPx+q6jRN4B04YP+zWGOkVilmZtinatGw
 X3Bg==
X-Gm-Message-State: AOJu0Yycp/9gtXh8AHZu/rWmk++F2SL9XaGT6mQNwAtFkIjyEQEKoWdK
 itL+b0QTpJHGkCdyKK3psD16QRmfb+8I/X9besIGCMhtQyhxRqplYAZAqFhuPjw=
X-Google-Smtp-Source: AGHT+IFaLfk+RKbhXFYjc1JOJLUy1IkgTo5wgo21jfQI3ZkGXRZ3LGVJIf8IqOHuwovkqysrEHIx9A==
X-Received: by 2002:adf:ecd0:0:b0:33d:5fa6:79bf with SMTP id
 s16-20020adfecd0000000b0033d5fa679bfmr4247373wro.71.1710187525203; 
 Mon, 11 Mar 2024 13:05:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a5d5f02000000b0033e456f6e7csm641136wrb.1.2024.03.11.13.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 13:05:24 -0700 (PDT)
Message-ID: <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
Date: Mon, 11 Mar 2024 21:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311185200.2185753-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/3/24 19:51, Nicholas Piggin wrote:
> From: Benjamin Gray <bgray@linux.ibm.com>
> 
> Add POWER10 pa-features entry.
> 
> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
> advertised. Each DEXCR aspect is allocated a bit in the device tree,
> using the 68--71 byte range (inclusive). The functionality of the
> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
> bit 0 (BE).
> 
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> [npiggin: reword title and changelog, adjust a few bits]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 247f920f07..128bfe11a8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           /* 60: NM atomic, 62: RNG */
>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>       };
> +    /* 3.1 removes SAO, HTM support */
> +    uint8_t pa_features_31[] = { 74, 0,

Nitpicking because pre-existing, all these arrays could be static const.

> +        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
> +        /* 6: DS207 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +        /* 16: Vector */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        /* 18: Vec. Scalar, 20: Vec. XOR */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
> +        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +        /* 32: LE atomic, 34: EBB + ext EBB */
> +        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +        /* 40: Radix MMU */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        /* 42: PM, 44: PC RA, 46: SC vec'd */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +        /* 48: SIMD, 50: QP BFP, 52: String */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +        /* 54: DecFP, 56: DecI, 58: SHA */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +        /* 60: NM atomic, 62: RNG */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> +        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
> +        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
> +        /* 72: [P]HASHCHK */
> +        0x80, 0x00,                         /* 72 - 73 */
> +    };
>       uint8_t *pa_features = NULL;
>       size_t pa_size;
>   
> @@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>           pa_features = pa_features_300;
>           pa_size = sizeof(pa_features_300);
>       }
> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
> +        pa_features = pa_features_31;
> +        pa_size = sizeof(pa_features_31);
> +    }
>       if (!pa_features) {
>           return;
>       }


