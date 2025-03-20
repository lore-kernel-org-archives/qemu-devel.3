Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F90C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvFHG-0003yK-Vh; Thu, 20 Mar 2025 08:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvFGs-0003pg-Dg
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:45:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvFGo-0005yQ-ND
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:45:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso7351805e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742474708; x=1743079508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/uEG2DLXs18ENiwWR0SANZL6p2h41Bk/uFAQ9TCN+w=;
 b=VlEIHj/0USBjyQItNfeN8jkFlqw65qhE2zQg9KdQtLSPQzg/c8KPn0S1xOyDwuy0UB
 ryTbUAlbHmYz9ffTgiTEq238TZnbhKiNUMQWyxDmHbSc+p6FjMNpsHAxBMx6Kdbpmldv
 oympv/fAFo4+KS93QW1NHCvKTXz3HEpuQvD29Z5Bo3V3k6ACrB1lEKmEcKYlu1XnxeeE
 KAfWUqq2popmfuEPRe4lV7RmrxSjfQLQPUKreGrd5DhTnueC7DEyHX/BYEnZa+tgy1CJ
 pttMM5La5wLQWlFVYHNWHf7CK7DVq1i4t02rmKDsJlxpkhhDfRGpYD1788Qcd1u5aint
 kcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742474708; x=1743079508;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/uEG2DLXs18ENiwWR0SANZL6p2h41Bk/uFAQ9TCN+w=;
 b=n/8IeaX88lTzTttFluSI24qOOCc+mmiKrtxiG+QFYZY2WXjjR1az9MMoks3iGBUsVL
 lRfQzfqlGVbwd3TbdIYuvHUMoeZPz2Yk8/1t0zrbPCxP6kArakJH0uaraE+Ure4tYBfW
 6Z9f/vgkTkzNuKl5Zu5k0CRhg2ggHoL0Iccu6B8yEJDIJP8lmv1xiFRzrQeRdcN0pdJZ
 +3ooPE0st9twzGOD4mIZjnzNaAvPhNmU/jl5x1b0seto+mO6hxaPeNFF2ubtEBPGvPyl
 dK07sh5TI05wE+9SxVLdHx50YHBwZd9mBTooFrjAjqdtGYSM3xduxp3zpwIIIDy7cTVE
 GxJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYEQhZ2NPETEAB29OC5EiROKtBfW/DNTiq16rOqI1sLKKlEZTeZ64jxran7fa09xB/pH9kI4E0E5Hh@nongnu.org
X-Gm-Message-State: AOJu0Yy4h73B1wCtkEdrm01mp7I9gG3mL2tn6dyLCbsErfIeQITQM+V1
 qp5EO0u1b7+6F6t3ZohHCtEr3RY63pz2SkbG33qv95nTRxRPBVKdC83B7Y4QhqrubTNdviEmsPv
 G
X-Gm-Gg: ASbGncvDC6BuAj1O1OQizWhRsWo8i8PyJwxYiAwUgIYdSoeZrl+8oj/xWA3NUJ+ncF6
 OkvUk5nB88RpiUst34AN36FJ+bRXvGmB+C34MGm7xAP/u/DwcuZDQJflyvTG4F9OO+fq90ntdQw
 139Zm6gev45nunIar1cAuQVjCeUMhhC6LcFYz/f7jYO0rDgN2CQID2VuGRSGJIZeD8c6lvEwbdM
 MX3sRnJwySgAJlH90FHyoAMFMoFYxlhlw6iJ065ZQNnuc7gb/29Tua3jMY73Dkk9c67hYCSnuB+
 1LZ1cQEOP7Gq4pwST8qKku/jyPoS8+WGB+jGjs4YSAzSnSZdxFAMMEg23HAPOUWmTvpUyGNs5Sh
 mV/4DwlTcURtC
X-Google-Smtp-Source: AGHT+IGLsXMz0LFTm0x32s5aAWDgrwBZ+jItatPBvTXsfZsoIWMpUvW08MIohdn1xJtl/l0roTT4fg==
X-Received: by 2002:a05:600c:1546:b0:43c:fb5b:84d8 with SMTP id
 5b1f17b1804b1-43d49549405mr26133555e9.16.1742474707711; 
 Thu, 20 Mar 2025 05:45:07 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f3328bsm47564755e9.1.2025.03.20.05.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 05:45:07 -0700 (PDT)
Message-ID: <bb6189ba-6462-4480-8fee-684a420d4a7a@linaro.org>
Date: Thu, 20 Mar 2025 13:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix e200 duplicate SPRs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Author: Roman Kapl" <rka@sysgo.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250320122741.109111-1-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250320122741.109111-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/3/25 13:27, Nicholas Piggin wrote:
> DSRR0/1 registers are in the BookE ISA not e200 specific, so
> remove the duplicate e200 register definitions.
> 

Cc: qemu-stable@nongnu.org

> Cc: Author: Roman Kapl <rka@sysgo.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2768
> Fixes: 0e3bf4890906 ("ppc: add DBCR based debugging")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/cpu_init.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 8b590e7f17c..7decc09aec8 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -2744,14 +2744,6 @@ static void init_proc_e200(CPUPPCState *env)
>                    SPR_NOACCESS, SPR_NOACCESS,
>                    &spr_read_generic, &spr_write_generic,
>                    0x00000000); /* TOFIX */
> -    spr_register(env, SPR_BOOKE_DSRR0, "DSRR0",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
> -    spr_register(env, SPR_BOOKE_DSRR1, "DSRR1",
> -                 SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> -                 0x00000000);
>   
>       init_tlbs_emb(env);
>       init_excp_e200(env, 0xFFFF0000UL);


