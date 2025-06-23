Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3711FC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 21:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTof4-0003Sl-CI; Mon, 23 Jun 2025 17:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTof2-0003SO-EV
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 17:25:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTof0-00041C-JJ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 17:25:04 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-313eeb77b1fso3677887a91.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750713900; x=1751318700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iuFwbh45fJkDHuILWLAwa2nQSdCO6QIwZ/ued95EtWU=;
 b=qwxgshyxwN6/8lAU3YXb18Ec8N9ciBbVAjlHtdIS6aWdQoj+kuoPSyh/DIOgbsPtGb
 DfInXLGmFz5TmZU2++eHLID5qCGdkuDUMJMh5iJbeRiCinwZle4RHOOncBSK3c7oyTv7
 b4AxTKH2CZzzRtoSAjzT6QAiWtz1W86lqgtQ30FGIlulLvN4TzBwk0VaZeM21XQdAM5A
 EZqI0Kjw/6i7wEqNz1HQdgx3YD00emgT7dp/OnbYCAXPhjV+9H5J6WxLlQ5yKDjAkBI7
 pyQblE7BKeXRXkI1mJc5YL2PdFTOCKNYoqAOUvD7NRW5uxeRdYRN69lxSJlWIDwKDi/q
 excw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750713900; x=1751318700;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iuFwbh45fJkDHuILWLAwa2nQSdCO6QIwZ/ued95EtWU=;
 b=icWAWMsTDcqY3r1IImBCCQDWFTpbOQ3f7FzzmCs0WNCAB9VqQqtH42OmY44L9umqOJ
 mhWJ5GprrkW4RilsE0dEkEYvYkbM2rhajOKnpTxGJWfO6mqrdqScozb2qsUUPCjV+9dw
 ESLrmzelLFGctPfv+tnApyg+9ytm1JzgY0ZFjI+2aISCxGnip4x3S9BGW/dKN5ffzpNW
 8MUjTT7H4x6KXXu5d6w9YAsJKNMqkTOq96idPUOOOWrKwuaUgoxhkO/eXT3CCwImG/Tb
 iIwfMNS1/nEBs4mpaP8pHEY361qNjph/3GAohhXJeEVkGmMvI1If2nfB8sYHUoBpfm48
 WgTQ==
X-Gm-Message-State: AOJu0YyNcpsQ5KYAoCpYGGFhXoTwYLUdleqQN+1Qjy5/30jFYgVodpEp
 ZGeTPIvrYxP66n+dzTsCNheVOB9Xf6Bnbq+GofXbPHyuVyXoTiAU2Un25rMDw/yEJQ30vjDgMEM
 sf2wRKSw=
X-Gm-Gg: ASbGnct48+Vwdce0WSyIQdTk3DiyuciKv4LBQ0JL1llSdBYJ6anmMHkvHBEjOOZ/RIl
 DuC48eKccyvKEhZ2LIa1awU2kfwUueO8fgxHja6E0i/PLYHrHENQUhtU8LNulj3kCN1kAKPepD1
 UkbaGmvshTXNsbtbU5tIj3dHj2I2Asbp9iVVVGcYm1otfgN+JfeBlxlDX7rrnZ2gxpRnZ03l1gD
 X7Qr2XnbScef/NZxMwyjK8qcvSDecO54nCKdxIy8E7QaC1ha/lBCeRM1ENl6Cxx3ZOnFbQfTHOC
 gqNvdvolHJOX80Tii1GmM/ZdtnITv1REXB8ACJyV1zipwn/T1MZsV4wtni5m2e1STAIe9buPRXA
 KyHyegLnKpS2mA1ALndfAkcyz64pH
X-Google-Smtp-Source: AGHT+IGie+43sAAIQiy0rYt+xwQraJR7j9tZbPuPADYhXTmE1UJ52O8VNlgR13o9xot36QzB6DSnRQ==
X-Received: by 2002:a17:90b:2ec3:b0:312:1c83:58e9 with SMTP id
 98e67ed59e1d1-3159d62aba3mr19641916a91.5.1750713899878; 
 Mon, 23 Jun 2025 14:24:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e0488c3sm9902464a91.29.2025.06.23.14.24.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 14:24:59 -0700 (PDT)
Message-ID: <1365c42f-d2ba-4854-b487-f9148c603c04@linaro.org>
Date: Mon, 23 Jun 2025 14:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 068/101] target/arm: Implement SME2 SEL
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-69-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-69-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 6/21/25 16:50, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-sme.c | 25 +++++++++++++++++++++++++
>   target/arm/tcg/sme.decode      |  9 +++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index f4af2dd98d..186d46ecbf 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -1541,3 +1541,28 @@ static gen_helper_gvec_3 * const uclamp_fns[] = {
>       gen_helper_sme2_uclamp_d,
>   };
>   TRANS(UCLAMP, do_clamp, a, uclamp_fns)
> +
> +static bool trans_SEL(DisasContext *s, arg_SEL *a)
> +{
> +    static gen_helper_gvec_4 * const fns[4] = {
> +        gen_helper_sve_sel_zpzz_b, gen_helper_sve_sel_zpzz_h,
> +        gen_helper_sve_sel_zpzz_s, gen_helper_sve_sel_zpzz_d
> +    };

The operand is predicate-as-counter, so we need new helpers.


r~

