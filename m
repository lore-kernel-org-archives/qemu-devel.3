Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5A8CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 00:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRg52-0001JF-AO; Mon, 25 May 2026 20:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg51-0001J5-59
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:55:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wRg4z-0006ZX-J8
 for qemu-devel@nongnu.org; Mon, 25 May 2026 20:55:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f8b60e485so4154482b3a.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 17:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779756931; x=1780361731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YB+7V1/Vkv2+jPh/Tz+DurDJ4jAwY1Ha9RLOf7oZtmE=;
 b=oopVHYfGpyOMsv5pCOC/pXBOJLixP9tzmDTb0hTPaDCOvOwpFen7pqWa9zl2bvfRVU
 DXCrAvISZ13Ew24sR+MvgjEO4RvoB9cD3hlWUIxiGpbcWH1nah2zkptF40bNSD4DBsMz
 vwwiv8JpS5T4p/bksBdrKQnHHcR2/m3JCpygCk8WB2oZgVEa+MLE2/QnWuYYxxd6mhNK
 JpQ0DLnOfKEr6IdrF8O4UqKfUOT86wa2SURSgrXfGFlJdhA0fLB+bdfWMkwRcZjvMTzn
 H22CbpLhK/LryPKKaZEtAsfvjnknShy//AuYQ20dklwYmhWP9RA7YoZHgkMWTG2KHAXr
 lqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779756931; x=1780361731;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YB+7V1/Vkv2+jPh/Tz+DurDJ4jAwY1Ha9RLOf7oZtmE=;
 b=JodyXf7xIB4E7UsQ09ke8tcvrMaH83nhzK/r2OkyDVSX4nFtzpyQk0FIAnzBaDm+uM
 zeSbjzvqyJqclVCTJa8iRhPplou1dtBIbgFCupDlSfCJe/PSzY1JomXiH8hWW/KSOvtL
 Bzh8iPCj+Oz3UukJ58sK53CzNVRdFURzf5/lilnsDLnaf1aTzDMwnxnZbvT/0siteEPM
 WdcOun10Niq2Xdb006MZr1RCUEckgADla2TX+xzhCSrDP4DitqSJm0ZcBeJARsJ+LWsr
 snxVCrOriaJCsJh7UWU2TK+NyJrDJBGc2MWsDaDkKP5d6MpJrJiQe4ph7H9AiH1zFT+D
 UPcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kVgNKsNaKio8j6qYOeqIIwIPzvYs0NO8L6W3tTeGWiHAAdE9DqrSkd4vJ4J7hU1dkapPe5qNBix13@nongnu.org
X-Gm-Message-State: AOJu0YxZrMKOXmCfsrTdgFhupy1xeP/X2jzzaYOSuQk4nSKc/Ufs2QmG
 Z/l1Qo5aJhL1vORXIzX7hh0xtQZfS10llRwiyZdUmaxZspxspHm3r+3s599iIC7xS04=
X-Gm-Gg: Acq92OGM1efdp1FRuKPGbWjXENTlpe6e2BN3ymPjKB//9VeTjRjRGZzcZpABkB9vlM9
 HcxzuCcD6kZZeje7sI1b86IWDmRtc4/75IyRcHM6hg+JpSW1HoYj+LJp2tYx+lRwCOtW5oPRA3c
 Ca9GHTFYM6jZcJpxx9K9JkfhfbqZvoIf7i9bIfcQ39H9PtQ0C08JGhVGvh3CSk6BcrBJ8xbRhpv
 LRKUSemkoGy+UHMx4ybC6ibVT2NWBNn/xZD1Z8MLV2DDdewSbBMZPOLW3m9KUuLxMM9HEE1TPFE
 6uQ0LD3uLYd/302lDQs7yBENsNmn0jaJyMT4QPX5EFxar/8z3NSbDKCf25zfAniMYAYKuDnX3dL
 1mRnnT0mDf2A+fN7QVmcdk6+2a4xSrxGUNIpVAa7PmZG6rz3bXF0oQJj2+bTfPiEOEJ1mDbnBkl
 CGmAvLbwJOhir+9+OyDA6/n2tyu5Glc6BmkKwn
X-Received: by 2002:a05:6a00:f99:b0:841:58b0:82c8 with SMTP id
 d2e1a72fcca58-8415f158b8amr15307525b3a.13.1779756930933; 
 Mon, 25 May 2026 17:55:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9fa5sm10528815b3a.1.2026.05.25.17.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 17:55:30 -0700 (PDT)
Message-ID: <20c744a7-369f-4abf-93f5-c6553c3340fd@linaro.org>
Date: Mon, 25 May 2026 17:55:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: decode_gusa: recognize add#imm with prior mov
 Rm,Rn
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20260525152739.4122267-1-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260525152739.4122267-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/25/26 08:27, Matt Turner wrote:
> The gUSA pattern matcher rejected `add #imm, Rn` whenever any prior
> `mov Rm, Rn` appeared (mv_src >= 0), forcing a fallback to
> cpu_exec_step_atomic for sequences like:
> 
>    mov.l  @r2, r3      ; load
>    mov    r3, r7       ; save old value (mv_src == ld_dst)
>    add    #1, r7       ; increment copy
>    mov.l  r7, @r2      ; store
> 
> When mv_src == ld_dst the move merely copies the loaded value to
> preserve it -- exactly the situation already accepted for the
> `add Rm, Rn` form. The immediate form can be handled identically with
> tcg_gen_atomic_fetch_add_i32 + tcg_gen_add_i32, so translate it inline
> instead of taking the slower single-step atomic fallback.
> ---
>   target/sh4/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git ./target/sh4/translate.c ./target/sh4/translate.c
> index 5adf650744..d38a6bd352 100644
> --- ./target/sh4/translate.c
> +++ ./target/sh4/translate.c
> @@ -1974,7 +1974,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>           break;
>   
>       case 0x7000 ... 0x700f: /* add #imm,Rn */
> -        if (op_dst != B11_8 || mv_src >= 0) {
> +        if (op_dst != B11_8 || (mv_src >= 0 && mv_src != ld_dst)) {
>               goto fail;

Hmm, but then you don't further constrain B11_8.

For the given example, afaics, B11_8 == op_dst, so we're failing only because mv_src >= 0. 
  Do we actually need the mv_src check?  I'm guessing not.


r~

