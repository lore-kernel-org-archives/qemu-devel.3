Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB4CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiAd-0004Wv-9u; Tue, 28 Oct 2025 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiAY-0004WM-DD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:47:21 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiAV-0006pX-GA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:47:17 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so1043211066b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761652031; x=1762256831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lBzBVEYneP666rmYHmobqh3BUne43lYo+SwtDrwg61s=;
 b=XKHTvFWXzdRKXt7kHDVA0tGK/VMyKCnl5BHMeF7Mo5ky9/EUMJQA9BmoS2LDsZK/D9
 rsomW4OGW0vKbH+uxaZm+1mRcgLb7IjIx7tvZ0qNS/3XEGAaKlspPPkRLXrZ4cK4xwlz
 DzqfoO+hJnYRFJER5L2feJo5zzCj4kJrVAX/XXhqp7gpcLJ26OpToB/aeWiXFFhJAjSy
 Tl2pNd8hVobYGtgtodHb6hASz2wq+A40HXO+g/eYGSa7pyGed/HpyjSgO5Zmu5ZD/2m8
 vZnHpGRq0/rkR0dsQXlSHfEkC1t4rKSk8VaUKYpnB2fiRJgCw1Joxz6aK2YWBUum3lIp
 a5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761652031; x=1762256831;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lBzBVEYneP666rmYHmobqh3BUne43lYo+SwtDrwg61s=;
 b=h3iouHF0NaossqsmK1VWWg1qlHL1bEG+hLtf+69YYYC7R3OfGeGINcTc1b+4um9eZr
 ZJoeFWrQkUG24WnB3RxE4hQb5g2a36RNBLbqFcmGOpihBgJMrMVJNdGHECu8eKYTULAT
 7gZtmFj3hm4W88qpak4GqXyZU8Z5LH1H+PsrlRlB8bTFWEEsgwSqsSQsl9/p+0qsV6Pr
 6Qzr/Sxmwns1s3qfvYoSmmEtUzUYLF2M+/WaeqsIMIKUpXL/sAnnlIUIlb3Tv/JP/4Lm
 pv2did/RA2iZ9IiwpptRaTvnoY56YfgPb9CzJl8bg0QnpnGekOeLnYrPSP2bCST/T+aP
 eFvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIA6WFWVrcpSkjDZX0C1dHzvdVeKhtvDaEMSMGXd+DzYHNEr7a4B+Bw6iMaAdTwIErJ3HYc6L+lWqX@nongnu.org
X-Gm-Message-State: AOJu0YzKeKpksHJkN7aUyo22Xwyuhb13NVSW4flDXsovcBWFb1Fgj5Zz
 k4ptjsxaW5N2kSp6+SORKUtmWhySXzPD7MR+RpjMaW3UASGSVxe9IvMZDaY0GY3n+QY=
X-Gm-Gg: ASbGncv647Xp4qLw9uG9xBh+SZM781PF3rpl9iOcc/kOC5XhjbmPnylM17veR1vP9HL
 3vpZi15Nml5mvMGz3X1PVUknq6O6Z5H7Tnfn5tqCjFCev1CNGvX2LCgfCDWzU0vRTlOKxWPXJj+
 I+ajSyj+PbLcfwiaYyPB6ysIzIIjrpdyZs0tZIYJ95uiXD+DdDZCsrfGG63jMp/tym6shtGG0sa
 63F5Se3kACxd53QRO6q3BYpi/BxDo2G6MP+Vsxq6sYpMGl7cjW197vPM2pu5cgjTR3paZ+zeqU4
 xZ7A/MC3siMLbFHjyJFCD2PMpiA5bfxn6pKBcRfrZFA7YY4vaDf4tx3dvkaLNdtJbzsc9u3WH1R
 qUbPMx24xX4FnWR5VaPhO2IcNeLE2R04fn2k6rRBDTSU2Kztn1TicwZ57eWf56NIpLQv+4CUg6X
 JHi/fbjwtVqWu8x1ZM
X-Google-Smtp-Source: AGHT+IG9QmKv+68HNRKnpKPSr98LQZ5B/iVG89U1WWIJyJWebttd62uhm0K97Ul7u6hZYH9NJfUupw==
X-Received: by 2002:a17:907:7e8c:b0:b41:c892:2c70 with SMTP id
 a640c23a62f3a-b6dba5a55cdmr304656366b.49.1761652030756; 
 Tue, 28 Oct 2025 04:47:10 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853386casm1057898966b.15.2025.10.28.04.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:47:10 -0700 (PDT)
Message-ID: <1552fe01-777e-4006-8c77-613dff5de773@linaro.org>
Date: Tue, 28 Oct 2025 12:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/59] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
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
 <20251028054238.14949-34-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-34-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/hvf/hvf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 16febbac48f..c0b2352b988 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -76,7 +76,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/accel.h"
>   #include "target/i386/cpu.h"
> -#include "exec/target_page.h"
> +#include "exec/cpu-common.h"
>   
>   static Error *invtsc_mig_blocker;
>   
> @@ -137,9 +137,9 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
>   
>       if (write && slot) {
>           if (slot->flags & HVF_SLOT_LOG) {
> -            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
> +            uint64_t dirty_page_start = gpa & qemu_real_host_page_mask();
>               memory_region_set_dirty(slot->region, gpa - slot->start, 1);
> -            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
> +            hv_vm_protect(dirty_page_start, qemu_real_host_page_size(),
>                             HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
>           }
>       }

Call qemu_real_host_page_size once -- page_mask is -size.

We could get away with TARGET_PAGE_SIZE here, due to x86 and it's fixed 4k page size.  But 
it's better for consistency.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

