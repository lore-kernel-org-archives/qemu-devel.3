Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647C3D3B994
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwUL-0003Hz-1b; Tue, 26 Nov 2024 09:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwUJ-0003Hb-W1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:24:24 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwUI-0001S2-C9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:24:23 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2965e65ce89so3415835fac.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732631060; x=1733235860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FH5t9T7YzViKHsUNN+maku0jWh0/jn+/lE9Ae9nQW6s=;
 b=McitxfDqs7M0X7zE9GMFER/HU03o1B89GqZgEOFqeYbrjonAUTHaMIcQQjzzQvHCmN
 i7LqBLGnHLDg/AmuYcogPUvdTkCvmWSrIQ8uSJrtOK6vzdH2H/G4+3dPV8PmOLp/YK0g
 VGxQ1Mmqn4xW4K1bHq2Z6M24z+sWgovukZ+ZSHNu5B23PtwFnZDQ8s7dwqHaBflfqTzM
 ca1fp2C15DlIx0oy6DLeTfQyuliCkGof/fkWVQhkjp1mvvcslmklv/QeLYs7CmeNf9qq
 R1xArDCAYZniRIiFAN+Z2Aobj1VydNdELCRSQ3ExnLWVIZov974LwHKBpwzmFywhL5JZ
 EiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732631060; x=1733235860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FH5t9T7YzViKHsUNN+maku0jWh0/jn+/lE9Ae9nQW6s=;
 b=JeFFtKv4aLGgwdi2HvBiLNoL0lFkWXSTxq/eAx5A4IW44QpWO8gHTTdySIzELLO/c7
 M/tKjCN/itILeFdoRRUiNGNZnkcwntRpBO/Q4JztvR91bttwbzd4H3GdvkyWiXSYFVOn
 en5r3JE4iRYY78nBWNfXYZA4CQFCIRs9SMjm66vnmv92+6lxgxDImVIfmcADHcxhe+Op
 mDVFeiWgvoRsNhQDAN6oHCYMeoQQUkMZ/Gj4Ik883hvmaA/EnlXxXmsPzQ81sYJdakf8
 i+Z3TtZ68iVrLsxbGElKX3TQNiWTFgJ+lBLquKXvylSvR29jmdFd/764RK3C5ZAgki5v
 jjSA==
X-Gm-Message-State: AOJu0YzeoeV84r9NxrHVdux8yc3DJdrCi/JhQax4WJZ11+aANpWiWt6W
 7frvx9UmAZSFA4pzfAahjV0ILAAM1TukN9Ghuj8UR93EGl045Uld92llT28U41zfc6UXGRwt4sM
 j
X-Gm-Gg: ASbGncuyYEvOIb05PaPRZlm2EReHalXHrsR7CVi/C0OC30b+LclgAGOq0n1o6b6NI0a
 hIT03sIq6JQvwwmHhExqXgrikPs3uQdCvt1Yf1H4gmseFZG6NTUgypoj2K6jcT2sDfneoxevID4
 HFoGZqesnQOSYlFDUf3D0Zzgkamrl/2Od03+UURytz2ZkFn73y5pSxQuNgoV05U2VjyxqqcIaYX
 LLqWjAAE8T6DU8su5IBAiQnUbOGGwZ8I+eXT+TMu/KKLnV9FX3VW7aYBcjbmwtN1A==
X-Google-Smtp-Source: AGHT+IHKs7LruoyV1VGL0/xoZlxRzqR8XL+r657OpDHsMMmzD/lcUBAc+yLFZBSd6Y9H+o/Ea7Ro5Q==
X-Received: by 2002:a05:6870:ac10:b0:288:4823:fe1b with SMTP id
 586e51a60fabf-29720b9abdcmr10493806fac.17.1732631060590; 
 Tue, 26 Nov 2024 06:24:20 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2972715a4dcsm3738171fac.34.2024.11.26.06.24.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:24:19 -0800 (PST)
Message-ID: <eed165a5-c436-4277-b833-a59e7bfab67d@linaro.org>
Date: Tue, 26 Nov 2024 08:24:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] target/mips: Make DSPControl register 32-bit wide
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> Per 'MIPS® DSP Module for MIPS64™ Architecture, Revision 3.02',
>   * 3.10 Additional Register State for the DSP Module
>   ~Figure 3.5 MIPS® DSP Module Control Register (DSPControl) Format~
> 
> the DSPControl register is 32-bit wide.
> 
> Convert it from 'target_ulong' to 'uint32_t'.
> 
> Update TCG calls to truncate/extend from i32 to target_ulong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h                        |  2 +-
>   target/mips/tcg/sysemu_helper.h.inc      |  4 +--
>   target/mips/sysemu/machine.c             |  5 ++-
>   target/mips/tcg/dsp_helper.c             | 10 +++---
>   target/mips/tcg/sysemu/cp0_helper.c      |  4 +--
>   target/mips/tcg/translate.c              | 40 +++++++++++++++++-------
>   target/mips/tcg/nanomips_translate.c.inc | 16 +++++++---
>   7 files changed, 54 insertions(+), 27 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index f80b05885b1..bc636510132 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -472,7 +472,7 @@ struct TCState {
>       target_ulong HI[MIPS_DSP_ACC];
>       target_ulong LO[MIPS_DSP_ACC];
>       target_ulong ACX[MIPS_DSP_ACC];
> -    target_ulong DSPControl;
> +    uint32_t DSPControl;
>       int32_t CP0_TCStatus;
>   #define CP0TCSt_TCU3    31
>   #define CP0TCSt_TCU2    30
> diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
> index 1861d538de1..36ce21f863b 100644
> --- a/target/mips/tcg/sysemu_helper.h.inc
> +++ b/target/mips/tcg/sysemu_helper.h.inc
> @@ -144,12 +144,12 @@ DEF_HELPER_2(mftgpr, tl, env, i32)
>   DEF_HELPER_2(mftlo, tl, env, i32)
>   DEF_HELPER_2(mfthi, tl, env, i32)
>   DEF_HELPER_2(mftacx, tl, env, i32)
> -DEF_HELPER_1(mftdsp, tl, env)
> +DEF_HELPER_1(mftdsp, i32, env)
>   DEF_HELPER_3(mttgpr, void, env, tl, i32)
>   DEF_HELPER_3(mttlo, void, env, tl, i32)
>   DEF_HELPER_3(mtthi, void, env, tl, i32)
>   DEF_HELPER_3(mttacx, void, env, tl, i32)
> -DEF_HELPER_2(mttdsp, void, env, tl)
> +DEF_HELPER_2(mttdsp, void, env, i32)
>   DEF_HELPER_0(dmt, tl)
>   DEF_HELPER_0(emt, tl)
>   DEF_HELPER_1(dvpe, tl, env)
> diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
> index 823a49e2ca1..c1fb72864f6 100644
> --- a/target/mips/sysemu/machine.c
> +++ b/target/mips/sysemu/machine.c
> @@ -88,7 +88,10 @@ static const VMStateField vmstate_tc_fields[] = {
>       VMSTATE_UINTTL_ARRAY(HI, TCState, MIPS_DSP_ACC),
>       VMSTATE_UINTTL_ARRAY(LO, TCState, MIPS_DSP_ACC),
>       VMSTATE_UINTTL_ARRAY(ACX, TCState, MIPS_DSP_ACC),
> -    VMSTATE_UINTTL(DSPControl, TCState),
> +    VMSTATE_UINT32(DSPControl, TCState),
> +#if defined(TARGET_MIPS64)
> +    VMSTATE_UNUSED(4),
> +#endif /* TARGET_MIPS64 */
>       VMSTATE_INT32(CP0_TCStatus, TCState),
>       VMSTATE_INT32(CP0_TCBind, TCState),
>       VMSTATE_UINTTL(CP0_TCHalt, TCState),

This would go into the new subsection, and you wouldn't need padding, since we're already 
incrementing version numbers for migration.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

