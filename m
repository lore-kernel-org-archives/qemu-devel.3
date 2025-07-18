Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5834DC83F3B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctVb-0004i5-Uh; Fri, 18 Jul 2025 18:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsun-0008P7-Ib
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:46:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsul-0007Vk-LS
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:46:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2391134b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752875206; x=1753480006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vtVhfnoYsbi7FVIw5IIyiOnvzB6WsKqtOcF4xWo1Z8=;
 b=XEi/VEJHWNvphnTdY8WjI27ReJ7QsNL2R3Oskda8NEEubf4OZaR0wJvwMq7a3eYTir
 uDzBO3GafILsrnp1browvipq8Bjwf8wMIo1v+dcaDXzmaZyxAHUjvdRhSZ1lsEo6IFST
 q8cuEML0YrKpPRDNYTeTM17sOKL9h3cYJdi61NncLYarB2l7CO70gpdAqoCLJI0uP7gi
 xZA+tiYfAEbcgntUyNNdXyt4WcxcoMbVE46IjrHcSr7f85l2DAyf7LOINgi1WzHJC//C
 cApKdRl2YiBemXVlDMN7fcimyoR3nbaW/RW8cZEWMSO0A3/GgSRlu1BpKCrWRLWQaaTv
 Fv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752875206; x=1753480006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vtVhfnoYsbi7FVIw5IIyiOnvzB6WsKqtOcF4xWo1Z8=;
 b=L17HAAZ6Uhd1hx9hX/tHPFo9wVXHqdREq8SUZx8ElpFulAAVIsk9GpWUAgfmtQUuO9
 AbU9aVbzayX+GLUcN4ZH3BX4K6NKKaxfQL0YpWV9cUPCbeILLBd1bJS1zeMuB0BQu7hf
 z/UXwdhiWvQCDhO/ma+EYH0FCfF3ry98tcBa2K1M2UoN/gVxIQGAttRx7oNbHesd+vDE
 g1JaeJonuV/4GJ06s3n1wWJvK2/0pbaQG8EkVYH1wG3LmL/fgco09jvi165QvTaH/tKj
 oHVN4nH73cgc/+g6scVzAln3tK71YiLK7G2CTOYy4yA0Mm7etpwf1HBXetRtOxDqUNfP
 lkqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoMG9pm+hdTuwNRNWYOmtjCptwFqstF6O+WJ6+yqWX48tX2RpOhx3Rw4Ppn8Gu1vonjwfkfcxAp+nA@nongnu.org
X-Gm-Message-State: AOJu0Yx+mzVQliWX8Zm08Nng7pbgmTuRkaYjv3bJl/+7vseOLjFa+BJL
 R3h8eZcOyQQCH2vJOSgEWDZhxz1xsnp/lYy0E48KGuXQrPydnVR5Uitl7f59djVcau9a6sjrzCF
 nm8dj
X-Gm-Gg: ASbGncvGS/xrQYHc/68RAuU+5ucgMBfTF0hoKBZMMQliCtR/gZzUGCm3tbk64ELsa9F
 kojhfKZsYV1IgKnMYMMGIae52941wLdq5t1jBPYVhtNyeGFAn58wpnHn33b4kHMadU0FFSnAOZC
 jhH0mX+R0gPZgAhkcfSMq0JHkaVpIsVUyhMNDL4fZv4SzrgNvx3lHm+MJo0AMYRDnw+B027VHXv
 FY4cqiByAO9tbYD4U6fDSdjoQZZZh0cQFSC5RjWIN2FFHGTD+ndUBy2It4tQ4BXDwvDs/yC1Jta
 0igidEJdC4ZucQA7LefCu/T8af7oj1vAweCiGN+XWz459W2Tz+5Dt6jRDscPVEQqH/EIsfou74r
 oRkelUXP5em4XkcEVVvtxF2Lohw99J2WevRPiy4cG3w==
X-Google-Smtp-Source: AGHT+IHZ46G6vsECdMKPxR0JDgbjFwYX2bZhlIIdfgHofxWcoQ3U/6QteK4soAT/Iz8rv5cGwIDFdw==
X-Received: by 2002:a05:6a20:3d8a:b0:204:4573:d855 with SMTP id
 adf61e73a8af0-23811d5b33amr20819751637.9.1752875206270; 
 Fri, 18 Jul 2025 14:46:46 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2ff62972sm1431258a12.40.2025.07.18.14.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:46:45 -0700 (PDT)
Message-ID: <8b1f32b8-73fb-4cb2-8b86-2f6677cb0286@linaro.org>
Date: Fri, 18 Jul 2025 14:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 10/10] target/arm: Make LD1Q decode and trans fn
 agree about a->u
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/18/25 10:30, Peter Maydell wrote:
> For the LD1Q instruction (gather load of quadwords) we use the
> LD1_zprz pattern with MO_128 elements.  At this element size there is
> no signed vs unsigned distinction, and we only set the 'u' bit in the
> arg_LD1_zprz struct because we share the code and decode struct with
> smaller element sizes.
> 
> However, we set u=0 in the decode pattern line but then accidentally
> asserted that it was 1 in the trans function.  Since our usual convention
> is that the "default" is unsigned and we only mark operations as signed
> when they really do need to extend, change the decode pattern line to
> set u=1 to match the assert.
> 
> Fixes: d2aa9a804ee6 ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
> index a77b725c876..aea7f519730 100644
> --- a/target/arm/tcg/sve.decode
> +++ b/target/arm/tcg/sve.decode
> @@ -1345,7 +1345,7 @@ LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
>   
>   # LD1Q
>   LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
> -                &rprr_gather_load u=0 ff=0 xs=2 esz=4 msz=4 scale=0
> +                &rprr_gather_load u=1 ff=0 xs=2 esz=4 msz=4 scale=0
>   
>   # SVE 64-bit gather load (vector plus immediate)
>   LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

