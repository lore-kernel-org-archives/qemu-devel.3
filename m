Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E81CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDi8L-0003Un-1c; Tue, 28 Oct 2025 07:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDi8I-0003UR-BH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:44:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDi8D-00067Y-LP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:44:58 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so1209723066b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761651884; x=1762256684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mk5i2be7EZssQLJ/1l17wpc5az1qu4wnupbq88AWFYE=;
 b=LhDiVIrO+tAfAbZMmgJpcCapxhXN0/fDjFXwbadXwIvln0PtrnqGQ1IY4mVIaoFA5s
 FTmyG05wawMPmKIxCe5dyLayW0Gn9oh3l8c/1Mn88CCL3sZ70TGmTpH1fI4YoiWDiVCI
 mtnAQXiDsBqh2nZ1LWRDiJKB6/ka7e0t9Uy6+Vy/w+K79n3D6BJdfUqZHYZXzf7JcA1a
 C8/gwPDCYRTlTsT7OCjDZCQLbDAsdWyP/wbWzzPb/2mIv83fDQuU7Qsyv3bOcYrlDbcR
 6HOoLpulw7pA5pmUtGqtgWCpFEsL+Pw/idLcXhDJc1iGfmSrexsSbDJP6ihnPRto3igi
 zsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761651884; x=1762256684;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mk5i2be7EZssQLJ/1l17wpc5az1qu4wnupbq88AWFYE=;
 b=oNcS/HaqPknPySSprXuMjtBakLaEjkyJYU5+IMf2owk/aaEDdnvtVLYbOy3BHcLeh5
 esppuE1pgmkbZzB3hZyVO6/NsrrOvRjjS1maaN5mmzSsIETzfWb5//X5s3BBFog0w76E
 HzKwcuNxJ640LjWnR/lHeSdMMPVVLlq20cQPNpeuUz49SVaTm8hPEYdh+bzEeIpjsp30
 eeugwue5OsbIEp+XOdSxD8hcw55TvFrMsm0ArsCVwo+DhMmMZ2BIyo9NlZg18GKQbrN9
 qWhKYNglI6nuUuoC5qAvR65EL+hX4yRwaIOYaG0g1JMcCN2qSdT6jO5THcQklYhqYr3h
 9RjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5G4mRtUL6DpBurhGPEI/mUdEn0j0AqUNd2SbUz+AwGk4Hwd9266NPGGKBa4JWZJmKVgXWzzfBNJO2@nongnu.org
X-Gm-Message-State: AOJu0YzxiXz0PXYLH3DCJArt8wYv19E6YYEpsha9lIlIJXpv0Jho6HU+
 E7ycOFBsad+JTcgRQQ7hrY3ND70XDNLBMhUDqaQrM5XT29V3jnQDbm4n24VTwvobm8o=
X-Gm-Gg: ASbGncth5Sz4dpxRnNfgn95bed3RlQbD4MsHGcLjeZv+Sy/d//3bASjdSMmRwGUGrjZ
 uCh0q6eYTCqumSrM+TLhrkw3kQSTOeyMa0/7K2N/i9+sUxjJav5PyRiLwgpaXmjsz7txPzkui52
 xvs8RmcN8fuJgLH2A7gSgRaZEOatULtcgCl35pGQMTXVUaynMMW0cXiBLBN+ehZoWfJ+G2n0GrO
 lN6isQvqJS8ae5qxLW91JzagGCBxJjIH49+x6TJOCFpJIQbslbVbTci0SjGttlIX49i282efo1r
 VVOsrb3Af5iJTs2DWoRsFq0rfubCksXXQcVYU5x0qU88RT4J2MIB34o28hyx96u4QzqNrCnZ+CQ
 5LKJpKDIktuoPzokTetb9vpDUbH5UkZoF5HiLFq2eLVKc0X2em1hqH8vByeDBFzK9vBg63RKOLM
 7uJNhmcSrUw8RB8q6P
X-Google-Smtp-Source: AGHT+IH0TUavLg0vZIia+x2IXs73pUR162RJh+Ciodcn7fHTqzh33pG2sJtHgdOiuC+jIgNRgS4ZBg==
X-Received: by 2002:a17:906:f58e:b0:b3e:1400:6cab with SMTP id
 a640c23a62f3a-b6dba487a3bmr350894366b.17.1761651883755; 
 Tue, 28 Oct 2025 04:44:43 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8538478fsm1075342066b.33.2025.10.28.04.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:44:43 -0700 (PDT)
Message-ID: <635a923b-cfd2-49ad-99ff-dedb26ebbe58@linaro.org>
Date: Tue, 28 Oct 2025 12:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/59] accel/hvf: Enforce host alignment in
 hv_vm_protect()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-33-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-33-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> hv_vm_protect() arguments must be aligned to host page.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-all.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index e13abddbd9c..2efecdc9f40 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -11,6 +11,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/error-report.h"
>   #include "accel/accel-ops.h"
> +#include "exec/cpu-common.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "system/hvf.h"
> @@ -67,6 +68,8 @@ static void do_hv_vm_protect(hwaddr start, size_t size,
>                            flags & HV_MEMORY_READ  ? 'R' : '-',
>                            flags & HV_MEMORY_WRITE ? 'W' : '-',
>                            flags & HV_MEMORY_EXEC  ? 'X' : '-');
> +    g_assert(!((uintptr_t)start & ~qemu_real_host_page_mask()));
> +    g_assert(!(size & ~qemu_real_host_page_mask()));
>   
>       ret = hv_vm_protect(start, size, flags);
>       assert_hvf_ok(ret);

You should call qemu_real_host_page_mask only once.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

