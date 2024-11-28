Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8087BD69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfDG-0002n0-6g; Thu, 28 Nov 2024 09:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGfDD-0002mf-L4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:09:43 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGfDC-0003eV-6U
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:09:43 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea3cc9a5ddso495940b6e.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732802980; x=1733407780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cSvEgR8qc0v9ZSHeat9AVzLEikcIot/f4WzAxKWFRKg=;
 b=yt9gT+J5ofcbMN25lK4BGC7mvbpKvvFdbBDOTKw8r+NXplbKZBqjty92C3ahUgONIy
 41Vh9O1LYEOAd6PphAWbkpgJCvHV4gz73lLtLPU6m3t1DvjEJkSG2/uzuHekOMov36QC
 6oYCANP+EyjlNdnJc2uMx+LCOqdYO9DLMZY+F6EZpjGvTDgGUDsKuHa8aHZa9iuOC0Y2
 IHrXc6GkNTsZxi0p9AUDljfIoKeujqOqZqMCxrd0Al5u7zweFL7X6SpEKlZKfVW6uoIj
 9dZGEBGJZayxVjlI5uFGOqqbU28LMOPSTwcy7Z8+WfFVQeCiYA6tc+/kYyegGbKpgfY9
 KK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732802980; x=1733407780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSvEgR8qc0v9ZSHeat9AVzLEikcIot/f4WzAxKWFRKg=;
 b=rCWhqOtA0K6YGagXyCgt6Ss2ovYx08z0uA5yH6jE6o7ou872tADZnyH3/V6G1Oqx8O
 QS4WHvgyBtbVVcftOxPV2fgkTcrWwY5YnhN+7A/AW9GKPl90yXyL4vh1oZLJXP4m/Nmq
 j+7JQnurMXa4KYD7apGsEQHdgDhy+Xb6Bi8FVJMdoPbnmmnmsf6R4GMs7ID+Pht16vUU
 sAZ8cvufyDoL9CfQVffxh3yt+ivzfHiLOBi/k3PwDM8CtC896+11hWruc8sl+DMVZ/UJ
 CWlptEpSbyMjj+9vV3UZo/pAQLtA3QGxKQLkAfvKfvEE2PsiX++1sd4Tu2gqfrdkCxJk
 B4Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUntWHd0Tv2xjOK+rf4jH8Bbo2B62h2d0yHVFZ/2+5c2omVBkusGXu6xXh6HsRfkwwyY6egYRIS8qRP@nongnu.org
X-Gm-Message-State: AOJu0YzJT11Q96OAEcTvK4xieNF1PwmqJle7tk9+LU7lp89zFmlvALAe
 PpVJ46bNyhAtWOEghZyZGQZwMfZr7GzTdfxRgU/tFY7TJ0TEJ9suk+RIBXg71wE=
X-Gm-Gg: ASbGnctI+nAzppkpUKaP4VzoFuluuCGY5AdNl5ZQ/Bsj75WH/J/haVgTVEQhNRAiwEI
 vsgebn+sqSBtBCvs1z3kkU/tUF3ZOBs4QUZJzu3oZ9PifDDUeUgq6rE8pYY/ZlpD60mCZJSXfp2
 PtjBKknB0swC6kQ48F9QeZY6lNr9cS7lHEDv2+LH8IVfABmPtrpH+oLv1ANTf/CKnxBzX+UAwDa
 wVrU+4t+Mbv4xOK3VIK4baS/YPEFNzzrqgK1BdPg5e0hlg07hTLXOgndwPaTjxCGZk=
X-Google-Smtp-Source: AGHT+IFXZ9iuqWU6RlKqKcTwLjfn1c4WHIjfPXBu+0fd3Hq2tL5WhkdgMfOnSr6PVXU1FaKMIDyrdQ==
X-Received: by 2002:a05:6808:2115:b0:3e7:bcb1:f5c4 with SMTP id
 5614622812f47-3ea6db63b26mr7440304b6e.4.1732802980640; 
 Thu, 28 Nov 2024 06:09:40 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7255e6cbsm310300a34.36.2024.11.28.06.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 06:09:40 -0800 (PST)
Message-ID: <9487d743-2788-475c-b629-23a662fbd4e3@linaro.org>
Date: Thu, 28 Nov 2024 08:09:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 12/25] target/loongarch: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-13-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the loongarch target.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/loongarch/tcg/fpu_helper.c | 5 +++++
>   fpu/softfloat-specialize.c.inc    | 7 +------
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

