Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545E1F99C63
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDtEz-00009O-IJ; Fri, 17 Apr 2026 20:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtEu-00008W-Em
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:08:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDtEq-000631-Nh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:08:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso803490b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776470922; x=1777075722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KnbkQGrVB7bINDJ29Y/dXFuTqXc4UOVwMIevBemqQm4=;
 b=IkskD8fnn7p9xhGojjGAZCUkQjVWb7o8FXLCkgdVmZ06xL9kIseBRr+cIkE2tBrLsJ
 7aeFpJANQ4mpE44xIMX8HsIz2TnPQPk8ZnQt3szF95SlCk4TeRMtu1Ghk3bDZUCitJDe
 l4ik+fMUEkAKCPpI/G0IjKS5Yu9HPpJqYdQ00A9imLIYliy4fdzx4HAcYffo4FaIBstB
 dM644vFcy3cZWqyA4jAOFm/qE0w6Eh56TS6Ad6W42DICmfotvECsI5dy6avnpwiqO0hB
 tTglUVyZDgdEk+7n7EClHUc1oo88dVxig822yjHmPqdZ3OW5JDbCowBXxTrpESgbM6ug
 hD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776470922; x=1777075722;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnbkQGrVB7bINDJ29Y/dXFuTqXc4UOVwMIevBemqQm4=;
 b=HV98dsCKo+f/v5SxXq4kv2gsr5SQ/mf7Z//Bid5NaOLDZm2EbsdrxO1ioXSliAS5Md
 t+z42W3mo8TipwBUPj4LjyhG8cFHwCADshFrgXVtvH/39Hm6yA9E9wqgvpExNoiW4MeO
 z6ohQcv6BCViL/tEhurxwgBbZvi7QrgXiWtyEg8AJjPTk8hsEv1zxGZJmpz8JCB8o4h5
 6kTawKTwmlm3/S9e+S1pAwE3g1/2U2ynm8dZ3iYtoMZfUtA8o0gWPAuCJyuL3xji6PSU
 tebKOpmDNOiSIRLZo8wY1Yu+SBLSP40krH05PxavHOh1A+v/Ac6vuo3beCicADjH9vky
 ILig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xxjJj1uhuZBmtCIXzOcCRLV/26yXuu2kWkpoKkVc0vcSWPil4BwhchEraTAeVxOOSs7YPC6es2OP7@nongnu.org
X-Gm-Message-State: AOJu0YzsPRbWcUjTVUVtkACHGr1QGO0pddFLRWVhtyXodSENWqeURopS
 6WQWMlhS51LCAxdLldFmxxAplmCgbnHK+CLAlUruT/NKl24jH6fwKgpVxykD6h+9rU4=
X-Gm-Gg: AeBDievUOb4VKhf2erpx9xTSKSY3pYgg2XE+W6mUuuuUdkbYGVSGifLFsbpy88hD7km
 ExyRewDzXHjF0o3YE9q1pDOjk4YdsUm2g9LXDC2+pFXzocytAhRv/4Y/w8uqZW0dAyh45MU3gBF
 As90kecT5rNAl1jXh04FPCjo30eimgk7ygqylfpXIuJwLnfdkp1N9WdK53TamwiaPLn97TEBdgD
 SeFzkZLUasv3xTIKrLCfiR6k0G1Cg7OjBPTU70MKXUASr7LldOrlHZA4plI1kUQT28safZyqSMI
 F4DUMgMcut33+61lh11nQqRQzIyRzoK8K5j3SaZL+3n5r4ZNgpXTucQ1QByOo67c6R5vQMN0JNT
 jmpP6mNsqLDFd1YVIfetLq4y86ORi3PgbM+FkbkyHAl4f42/sgBtkH4AA3HlSTPBngDc3Ua0ix2
 eTZt209JBxJ2hsyZnW033KkfHxKs/y/SHHPdet0BvvMBr3bQKMHcbgcEv+V1AqRYos5AetmfrKY
 MSW2IcQE/zVzWUrzbCnWMiiG0Q8rth7CSvTjO2HERwuM3KnI+3zOp7NpmcxF0q8DA==
X-Received: by 2002:a05:6a00:945c:b0:82f:9407:d155 with SMTP id
 d2e1a72fcca58-82f9407d4b9mr2691463b3a.40.1776470922052; 
 Fri, 17 Apr 2026 17:08:42 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 (bg30dhzyct7sk57q2zln.ip6.superloop.au.
 [2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec04448sm3708513b3a.55.2026.04.17.17.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:08:41 -0700 (PDT)
Message-ID: <641cb56f-7e38-4b09-8514-5301827242c4@linaro.org>
Date: Sat, 18 Apr 2026 10:08:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/arm/cpu-features.c: New fields in AA64MMFR4
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
 <20260417-jmac-feat_rme_gdi-v2-1-7cf5131aeb60@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-1-7cf5131aeb60@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/17/26 21:02, Jim MacArthur wrote:
> Added RMEGDI for FEAT_RME_GDI and other new fields.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index b683c9551a..2d1a3196b7 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -346,8 +346,16 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
>   FIELD(ID_AA64MMFR3, ADERR, 56, 4)
>   FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
>   
> +FIELD(ID_AA64MMFR4, POPS, 0, 4)
> +FIELD(ID_AA64MMFR4, EIESB, 4, 4)
>   FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> +FIELD(ID_AA64MMFR4, HACDBS, 12, 4)
> +FIELD(ID_AA64MMFR4, FGWTE3, 16, 4)
> +FIELD(ID_AA64MMFR4, NV_FRAC, 20, 4)
>   FIELD(ID_AA64MMFR4, E2H0, 24, 4)
> +FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
> +FIELD(ID_AA64MMFR4, E3DSE, 36, 4)
> +FIELD(ID_AA64MMFR4, SRMASK, 44, 4)
>   
>   FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
>   FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> 


