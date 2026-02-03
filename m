Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F48E83047
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6th-0006do-Cs; Mon, 02 Feb 2026 22:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6tg-0006c1-Lq
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:16:12 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6tf-0007zy-8B
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:16:12 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3545cf80e1dso999355a91.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770088570; x=1770693370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dAiTN7jbRIROLuNNcs6thTPIdZrzClI2sEJxbhNX3c4=;
 b=Gu804jKUAL/ZeQn4XmuJQ4SG0Et6F5R6TpkrxpFVs8fgv+Lsnakh5lJtbr0DgHrURD
 3ZlB6zX/nIrRA+sM7eLLuKozA5dQDi3eP9yXOAu59zuHuHDKxzvkDELjsbpp3hQzkwG3
 6+mWdHwr+y2lkdpk2PXIum75CrPhrWQyoGrExo3N2T8Q+HwoDOsJTSdDuXmvs6Bp/Wmj
 lsfk9HyoTCxO0l5bXvCJKqQQVM57EfotaGipTgInqUmE/rbr25cmls0e5K9IRr9vDjdN
 8KPtMu3vO6KT93EMYGMRyrcOvOJ88zIiilISgONSMP7UJMNWNIKhhYWOlGjsBKF0mGAE
 g5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770088570; x=1770693370;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dAiTN7jbRIROLuNNcs6thTPIdZrzClI2sEJxbhNX3c4=;
 b=b+cFbdo2deNXXjaYNWe/Y9E4RqD5PawQs3YN2+CmM2Z7wOMHT40Gn4zc/cmO6peT8H
 Go298F2ZKfn/ZaQ6vMrMIkVbHhr+KAtrssxO4V6jWO3ARBnNz6gBViB8BpK+Sqqdkka2
 RKtzcx7hE4HmyAsi1NrR721EQo7TL8WBXikmwXE6QwgxuG/Y7EjdrvGXEvQajFZJpvJT
 VZD23p9mf1OT08JQkRPyzDuWNXOs5Tu3H9Cnh2YMHqUZmYUwJXy9ZWncfMtXPyg+FuYS
 9WeHqEHMvY8jAcQiKFRMuVHEX8jhPEU6nF48NR975rqOW8Y/3KL2/BG1WDOSpe0Ekqp0
 hnBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoTdkkXzRFV232jdi7//Q68QbsobRpUbxM95use9ugYHKtZrRFiLO3Uu/Mylg41iE28Yabpdc5+4dU@nongnu.org
X-Gm-Message-State: AOJu0YyVvl8B2HaZvySsC+VX0enK5U81Q6QqxMnwaz/KgbTk2bu28+qf
 Mm5uNV2BxDTt2CyMdCv8U3M8+0Ga2JROlrkFS6h51+q+0xlCuHz3w6jVHtLOFE3aQ0s=
X-Gm-Gg: AZuq6aJbWUCgAGGT3owjCetTS4NrLJVu+qv1xZNunfZZMfEd87l+N+BE0O2jh5Vcvf9
 QEVx00XmWxrip+R47lM2ScGLO+DNNRSBaZcczOT5+2YfE9v6VEFVCOYEDjDT0ENYfG16XaZFMn/
 8kwotexPiUhM56QKxAWiGfQ5Ja1E6DZPD3mM6Ccoe6anx5gin3iJkuJmvorEqEA2s3qDMnbYgxS
 rgPtgW5zraOZM3HQZ5Wh4yIGiPuSB13ia3PFGEjJ2Rn4JWbe8E8udKNGlekLrwem0ZCG37+CgTS
 710gQcPR+/QtjovRKmG4q8TDOJef0bbaMbEwLRPkoVR0/hcdxqFnt3jEo/rTlqMfUn9Vt1bxYdc
 TDaS1ekGHRccPzxr/X5BihLHPIvTq3WICw/L/PBe4mhS/HEfFmrHvdXjCnMTdN26WBfqtnLgtbq
 d4h9fqnR7EREMiaTy/6clVzON3yI6lhcN0HPDUTxTbdznsMHaewQ5bWteyrqRuVu/miSDGAAsNB
 DKQI7ha07g=
X-Received: by 2002:a17:90a:d88b:b0:343:6108:1712 with SMTP id
 98e67ed59e1d1-3543b398132mr13884396a91.18.1770088569713; 
 Mon, 02 Feb 2026 19:16:09 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3547b1304a9sm286577a91.14.2026.02.02.19.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:16:09 -0800 (PST)
Message-ID: <38d57330-6c76-461b-92ef-98074f5b8808@linaro.org>
Date: Tue, 3 Feb 2026 13:16:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] target/arm/tcg: Drop unnecessary aa64_sve check
 from do_trans_pmull()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> Part of the logic inside do_trans_pmull() applies the aa64_sve
> feature check for the non-128-bit-element versions of these insns
> (PMULLB and PMULLT).  This is currently a redundant check because we
> only invoke this function via the macro invocation
>   TRANS_FEAT(..., aa64_sve2, do_trans_pmull, ...)
> and it's actively wrong for an SME-only CPU, because these insns
> are also available via SME. Remove the unnecessary logic.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index e853b4dd0a..fe59126d2b 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -6782,8 +6782,6 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
>               return false;
>           }
>           s->is_nonstreaming = true;
> -    } else if (!dc_isar_feature(aa64_sve, s)) {
> -        return false;
>       }
>       return gen_gvec_ool_arg_zzz(s, fns[a->esz], a, sel);
>   }


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

