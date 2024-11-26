Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F85D3B994
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFwOd-0000aL-Kg; Tue, 26 Nov 2024 09:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwOW-0000Zw-Uq
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:18:25 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFwOU-0000KG-8p
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:18:24 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea48624a2aso1152091b6e.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732630699; x=1733235499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+1SS+p9wfsHam2G1Z6rmDlE2B2ReYXAtDIIsvcPagg=;
 b=Nknp3l2rm0WFTvmRWJ7e8CfE9C6Dmi/aukZC+78t8wjMMjWWIzzApnC6SkShnYi5RI
 QVObA9tI1X0XWZ4YKJoT0beg8FBV3CXKIOuxUR0gOxjiM3hqws+atlZa17AdLhdeYCyS
 NrTgLA+ZnCb312v6uFPkjlu4Rfse0maPr/5ZIShmNJVxBWlyro/7Yzh8KwQ+A0OGpe5A
 E39y1PT1bgVvf1aqVWiklErmMIlWY8es/hE2CSQqWKqJD67L8QmpiGL9+INrBEVNem5t
 kUnGVVvU9+Wxv0WxMo/I2gM3nwYogzWSwKJW4xU5mwk+jYZEvD3J7Xf3lobQAEkgxVWC
 pCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630699; x=1733235499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+1SS+p9wfsHam2G1Z6rmDlE2B2ReYXAtDIIsvcPagg=;
 b=ty8VOanOQ8hupShfv/IGKGCBtmc/D6VnUwJYb8/xAaaFR+ZZMcOPHzs5FrfJMp51de
 bOIbay82OE4ly1rlGDNKJEdoAsF7T6BEcJlmzVjDhUufLhtVs9t7GxfW6efic5aMTBvR
 /RkJhIIvCZEP9nF+KZDd3jagpEzDs3lDUbMadZbhNihLVLjMVl8i61lBFzaM+ndM+SWt
 c0/MR1hpipyvYcSqx98KZ0GSTL9Uwo02KuWXXYjybgufjeOCs4mw7t4MAiFRz22Tgsds
 API3OpDjAGEkG2HNe9Mso4nGTeEjlpuwTPsPVYWXSQ9LUuteK44hv3Ol+GzB0nzHvkuH
 mG5w==
X-Gm-Message-State: AOJu0YxUnSdLlQKCCoRCp5mKgxUjgjD3OlOuK6y2nDiXcJ4ehYGsTIGG
 3fIWrXeGWgHydO0XqYAFh+l1b/UJTyan+SXTRBqqrPFBJUvrH95x8kStDicUMqK/Egcqm99mVYE
 x
X-Gm-Gg: ASbGncv/uMxoGeTWtFJx+IHXEWj/4Oqq2+9QVRiINJTkTm6niTb4W3n/2MHzGPPV5kj
 ymjglLjkBo6baChwbTvJ2Wgjl+ADPQCYb1vDz84M6owxzohIy7jkMEzXo+ElGukOHW00QipTsNG
 GtMjvlI72AnvMtXvCCrqOi78689e1thOkKXbtzToK3z60CsZcktkulk2nrXH7gMjQQS8rXTQf4t
 GPh+xblzwX5TjT/NQp5nA6wepbsAkH1WxyfbKePJldgVQ+GLRC8jYe+KklRmUG4Xg==
X-Google-Smtp-Source: AGHT+IF7LZkjo8LR/zszN0Kcuz6RpnYKpRwKFIcTvCNXdpfJ7Ser7oeCcOqCQcIyidBKTDA+t1ffVA==
X-Received: by 2002:a05:6808:1a07:b0:3ea:5af8:c9d7 with SMTP id
 5614622812f47-3ea5af8ca64mr2819657b6e.12.1732630698841; 
 Tue, 26 Nov 2024 06:18:18 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e91500f765sm2899261b6e.50.2024.11.26.06.18.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:18:18 -0800 (PST)
Message-ID: <44952443-3928-4430-8fd1-23c2bb4c00b4@linaro.org>
Date: Tue, 26 Nov 2024 08:18:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/mips: Declare MXU registers as 32-bit
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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
> MXU extension is only built for 32-bit targets,
> so the MXU registers can be directly declared as
> 32-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

While the mxu extension is only enabled for 32-bit targets, the fields are unconditionally 
present in TCState and the vmstate.  Thus this affects migration.

Since there's a migration breaker, I think you might as well extract the mxu state to a 
subsection, enabled only when mxu support is enabled.


r~

> ---
>   target/mips/cpu.h               | 4 ++--
>   target/mips/sysemu/machine.c    | 4 ++--
>   target/mips/tcg/mxu_translate.c | 8 ++++----
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index f6877ece8b4..f80b05885b1 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -514,8 +514,8 @@ struct TCState {
>       float_status msa_fp_status;
>   
>   #define NUMBER_OF_MXU_REGISTERS 16
> -    target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> -    target_ulong mxu_cr;
> +    uint32_t mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> +    uint32_t mxu_cr;
>   #define MXU_CR_LC       31
>   #define MXU_CR_RC       30
>   #define MXU_CR_BIAS     2
> diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
> index 8af11fd896b..823a49e2ca1 100644
> --- a/target/mips/sysemu/machine.c
> +++ b/target/mips/sysemu/machine.c
> @@ -98,8 +98,8 @@ static const VMStateField vmstate_tc_fields[] = {
>       VMSTATE_INT32(CP0_Debug_tcstatus, TCState),
>       VMSTATE_UINTTL(CP0_UserLocal, TCState),
>       VMSTATE_INT32(msacsr, TCState),
> -    VMSTATE_UINTTL_ARRAY(mxu_gpr, TCState, NUMBER_OF_MXU_REGISTERS - 1),
> -    VMSTATE_UINTTL(mxu_cr, TCState),
> +    VMSTATE_UINT32_ARRAY(mxu_gpr, TCState, NUMBER_OF_MXU_REGISTERS - 1),
> +    VMSTATE_UINT32(mxu_cr, TCState),
>       VMSTATE_END_OF_LIST()
>   };
>   
> diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
> index 20b8314b478..ee70ae96c32 100644
> --- a/target/mips/tcg/mxu_translate.c
> +++ b/target/mips/tcg/mxu_translate.c
> @@ -606,8 +606,8 @@ enum {
>   #define MXU_OPTN3_PTN7  7
>   
>   /* MXU registers */
> -static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> -static TCGv mxu_CR;
> +static TCGv_i32 mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
> +static TCGv_i32 mxu_CR;
>   
>   static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
>       "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
> @@ -617,12 +617,12 @@ static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
>   void mxu_translate_init(void)
>   {
>       for (unsigned i = 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
> -        mxu_gpr[i] = tcg_global_mem_new(tcg_env,
> +        mxu_gpr[i] = tcg_global_mem_new_i32(tcg_env,
>                                           offsetof(CPUMIPSState, active_tc.mxu_gpr[i]),
>                                           mxuregnames[i]);
>       }
>   
> -    mxu_CR = tcg_global_mem_new(tcg_env,
> +    mxu_CR = tcg_global_mem_new_i32(tcg_env,
>                                   offsetof(CPUMIPSState, active_tc.mxu_cr),
>                                   mxuregnames[NUMBER_OF_MXU_REGISTERS - 1]);
>   }


