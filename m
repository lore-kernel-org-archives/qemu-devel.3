Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F2CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEd5-0004xe-Bc; Thu, 18 Jun 2026 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waEd3-0004x2-AL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:26:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waEd1-0004UT-F2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:26:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c168baac83so5351805ad.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781796361; x=1782401161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsNL/WSDPFzBkOnsOQ56FdT2foaULZpm3r7OX9+Wifk=;
 b=WNPlF/pbZlmpCKsboCZFCMJbdSpAsKw+P2P1BzbKyqMLf0HJHQZx+VRW7nmcr3J6Ts
 Iq+UiUM6xixJYo96HdF09KnIEam8U7G1rDkIIWjLjd0B5hvJqlmk6gk0yaBMTSICrjgx
 TInX/Up83iDvyxTHK9GMlK565Fzfi1MxfsDSiZ1ZhxKCAdbRmN97471k7qMmcS/RGQPE
 snlWEPY+D42PC6jY099eTkalJARVoqfojnw84uxL93PyUG7V57Y8Fa3j1hD+GhYpBw15
 eCvzoUgWj1Ltd/SK+PJGtb83C7AUlnSTn/A2Hu6BgwwgLJqmT7tuOqyt5Cwv+sGdyDy3
 x3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796361; x=1782401161;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsNL/WSDPFzBkOnsOQ56FdT2foaULZpm3r7OX9+Wifk=;
 b=aYVwQOKdSU7Nt+clkSDnK2rt9FJGU2rR2tb97sZbcmRSQX3uQN/rzOYUMFEv3JnocF
 0oRxqG2/7OfoV24mMTeJrSaeOV4vDTnhnZeVM+zmyseoy7tIFJGjYQzoun6m7PZ5JLMg
 fdkoOSoYEvKE1aL929GHZyc+17B12yE1RsVz9JCRnEJNObAKA/BGdKh2cwOG1XLEoKqM
 TuBR7271eKlAFbIxk9YEGTJrehtfvzm/GmuuyNjtc2l+Abxphqeri+/XERjV1adTggFt
 rHgTd0gk9b0/lpWELNpko9KkmzXPmiqK3wYf59kbfLZ49rinKPPS/6kjBPm0Z20n8ouQ
 M7sw==
X-Gm-Message-State: AOJu0Yw8Gn3NKtuKgO3HOZXyqZOmAHdDTy8nx9iRMl8E1PFpEE9qClsi
 BdfOrPXisXV8l0goKnw+cYFrd3oe8V2RNePyTMM7zXlZyOYHd+k5ZmdDe2I0RbprD/DkadFxHbd
 SDimZ
X-Gm-Gg: AfdE7ck9lpmJqHA52Xuo3hxWUzZW1Curu1CUECSok3R3Ll1zOBPWlbwhC4MH972EEuB
 LDz9oAkL86jl+iet5yc/cBji/ChdcOH0Vw65P156R9880VsV+YfKBknGAMwMOASe+YIyUb1jeMt
 gIaqe+JsnCUUQEZMJYmVAuGJF2wUryCqY+WsQ0MycKG0OmYn4i9bvcuftplxS9SUjk8PTo15TVY
 gbtlbL4pmp9cJ3R7nCbePCGAlHzveH30mFiuBQuQoDEb0xemiwAzXtrD1Ewqa9cT+bsdoEqG7ex
 rE64dYEnlSL1Gg7ngg+/UPokz9vNcPa8qPUs08MqD+BGY0Nst8UeGyLQLTAxfKe2MMXXmTwR9Vn
 EI64AkJ13MwI6jvYh/Kquc8ZIFqcbNUYl1D/BJ3W1U2vRPNsp8YYiLZxeS/TGB516b0VCDq8rFu
 IdA5s/MRnG76B9dCHNBHYcRPNg9emCWZcFdqNVwU640dMM+aYVtRD8YpSIHA==
X-Received: by 2002:a17:903:2a8b:b0:2bf:1486:e6ca with SMTP id
 d9443c01a7336-2c6bc0bce71mr100974695ad.12.1781796361194; 
 Thu, 18 Jun 2026 08:26:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433460a60sm244023275ad.76.2026.06.18.08.26.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 08:26:00 -0700 (PDT)
Message-ID: <8c0cdc46-aaee-4188-9596-92f32b22058f@linaro.org>
Date: Thu, 18 Jun 2026 08:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
To: qemu-devel@nongnu.org
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-3-1b4475bacf51@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260618-jmac-fprcvt-v1-3-1b4475bacf51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/18/26 01:20, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/tcg/cpu64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index f7a920a202..f259e82dd3 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1269,6 +1269,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>   
>       t = GET_IDREG(isar, ID_AA64ISAR3);
>       t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
> +    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
>       SET_IDREG(isar, ID_AA64ISAR3, t);
>   
>       t = GET_IDREG(isar, ID_AA64PFR0);
> 

Missing update to docs/system/arm/emulation.rst.
Missing update to linux-user/aarch64/elfload.c, get_elf_hwcap().

The other part of the feature that has been missed is

if elements == 1 && IsFeatureImplemented(FEAT_FPRCVT) then
    AArch64_CheckFPEnabled();
else
    AArch64_CheckFPAdvSIMDEnabled();
end;

within all of the v8.0 vector instructions.

Practically speaking, this means adjusting s->non_streaming before the 
fp_access_check_scalar_hsd call in do_fcvt_f and do_cvtf_f:

     if (dc_isar_feature(aa64_fprcvt, s)) {
         s->is_nonstreaming = false;
     }

This would of course be a separate patch.


r~



