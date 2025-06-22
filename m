Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76474C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAKD-00070c-3c; Sat, 21 Jun 2025 22:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAKA-00070D-S7
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:20:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAK9-00035q-Ar
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:20:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2363e973db1so21490215ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558848; x=1751163648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XwuwNh+koy2VQwdfNjbtk/bKBYSVtwkZKZ8/lJpV/kY=;
 b=hnURfRXMS1iI6Z39gltAMuEl8TBj7BARW7GnieF22/w/0s9PAwcSZ3tv5q2gTlUkAt
 x6koINVHAdf/C5xQU7nbIaQke44SSLz4mk3JB8gowJ4SuVub7Z1EYzLzTuOM3U5BBApn
 6RxHixhcVivOYw9AllPt2z/Ek258R8HOxO1LCp3oeoniNCd30kNGmHojDciGOB37Jyr9
 eNg4dxefsoRif21a6rsmyWYLsIKODHOnE4hiz3aT4UYn23rhsR0A9odOY9J+MtltlRbO
 l+SrIfnH1HjX98kuxHG2UnkLfI486THCu+TxLAUUKvTSGQERhOfwZC7jakzHd7oI2jaW
 kViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558848; x=1751163648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwuwNh+koy2VQwdfNjbtk/bKBYSVtwkZKZ8/lJpV/kY=;
 b=hkNMZ6dy9N1TzmYiyfbmBPQyCLx77rK4RV9MV1rfyGD+hckSqCV3T+ZcOzWHaolKyh
 FAqxRRnYvDjC+eFR3WiAsASbMIHhLLUIB2YLE2GNfVSVWF3WFgMPyPqLmvzqH/OI7ygo
 Fay35QyuOwWDE8gWmTUzSXdRXlRY/CwTO6VVzomigtX5RbyqZcGvvwbfzNeKHj0oQd49
 +8Iv/TaQSPuAZO1NIgosvq7EYE3F6mYLdnYwSFZI1RIqrygBtQJZqtn+YZpAdsWeZjqF
 Du3RngEecPLn2HOxSFDrkV4Pg96fGwuk6UJ+B7ptv8aPR28e8hlzTA68BohuSCzd+v9b
 F1ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXeLeaNPuFl3BftH1xQyG5AGG8tRRE+h3jmTSIWjMqbFUtV6Gd7uPNlaVNpl2dspHslX33Ds72hYkL@nongnu.org
X-Gm-Message-State: AOJu0Yyqa/6M9Vfufe9nzlSLXegH7x1vsmPObRjJtSwFrsaRlEl58xf4
 FoCe18S0IG/g2JICfxQa4c6VzzKZ9pMoQTbln40TwDXKCYg4lY5zhF2HfDbCq+xLze0=
X-Gm-Gg: ASbGncuu9lLtd6Yal3cpTo2pzG4/77wwl/R6cpz/2kUk/dRjaery3p8eGAOgCIuoA0D
 FgQKBOvtGC6KemxL67va94Len3pvu0VsWd376LEVbq4Amm/cn7geZD13v4ANjIf4FlOCJpuMZcE
 HwJEdNIFLcC+gIIuOC/jEIGiGiV15acdvz20rO7oENViZizS5UUw4+mMomrFip7WutDxaYX5D62
 LM97Jo9rrsYvDgB6Lj1/9SBmNlDHNkbgONg+UQCj5YX/+2AGUka8Qsv39rr87FZ0HSUrz56GLOq
 ZqRXzuUAxGNloUIJHqB5VtLytivxvR2dyBI8ChlO/sgpLJBsdPf5sv7rmGTml0MMUluTXY9tQZe
 /V2xhJ9PqerO09IPGKfpjUsVwr2Fs
X-Google-Smtp-Source: AGHT+IFmMdGTiw1qqxx3zyH/7DaGGhfFTg41sn9KExjj+U+8VX/dp8F54K7fG27lvD93zjqnpoWybw==
X-Received: by 2002:a17:903:120f:b0:236:15b7:62e3 with SMTP id
 d9443c01a7336-237dafbc416mr111541685ad.9.1750558847668; 
 Sat, 21 Jun 2025 19:20:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8610ac2sm51400315ad.135.2025.06.21.19.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:20:47 -0700 (PDT)
Message-ID: <a19eac04-824e-438c-adeb-a5cd456cadd6@linaro.org>
Date: Sat, 21 Jun 2025 19:20:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 03/42] accel/split: Implement
 cpus_are_resettable()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-all.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-all.c b/accel/split/split-all.c
> index 6bc95c7a7c8..c86d0e8583a 100644
> --- a/accel/split/split-all.c
> +++ b/accel/split/split-all.c
> @@ -30,7 +30,18 @@ static bool split_has_memory(MachineState *ms, AddressSpace *as,
>   
>   static bool split_cpus_are_resettable(AccelState *as)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(as);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +    bool rv = false;
> +
> +    if (hwc->cpus_are_resettable) {
> +        rv |= hwc->cpus_are_resettable(sas->hw);
> +    }
> +    if (swc->cpus_are_resettable) {
> +        rv |= swc->cpus_are_resettable(sas->sw);
> +    }
> +    return rv;
>   }
>   
>   static bool split_supports_guest_debug(AccelState *as)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

