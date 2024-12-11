Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B23E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQN0-0003Zc-Je; Wed, 11 Dec 2024 12:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLQMz-0003ZR-RK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:19:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLQMw-0000Pw-BN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:19:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso66814825e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733937563; x=1734542363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5waepcRG0rE96d3+FTAxo9ZMgSmUAmPYYL6auywoo5k=;
 b=y2U6/kJl02LpnZd3w23Mi8mXzhoRS+MwKdVIR7cq4jh7fK4deMMNBK+nHHyNwr9jrl
 FPVXf0YgSam8guRbzx5xdY9iuYcDjfDlKYpkaSGY1VXZPP9s8+Nc/sUP/LP9EUb3Boxw
 5QIlQu2bpwihpriAghMNMSA4j8MAyEcwPPsXuOcncymStHagN2EumxQ/MOrjKrtLBI7C
 WH1Cr2MxshqNNdtFunLDUApqPar+qh4WCLGC0Vc19JIkXmV5+Xku35IZBXsPMovB8tF0
 thtHWR+NuB+94tVEdHUo9yOiUqb9GjBb1tGTbTCWQHuLAaDhwjqkFCZcR1GPW5PuPQ5G
 P5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733937563; x=1734542363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5waepcRG0rE96d3+FTAxo9ZMgSmUAmPYYL6auywoo5k=;
 b=GrMQM3qoETWGT/YFLjejI9m3UaKj9t2g0Ht1ipNbiafzM9tUN6D8osfeU3/uPRKTzu
 K+xRpMUQYs6Z/sg8p1pPUbe8TF1nNnupjTvslUEgeEwfmGD9qM6IOJEtKaaJaqEejPVB
 nycdoL/g1WyIrGqdGDHYddN1izYtc1eVi9fS8Rv+xo8pIHT8WkH6oMqDmYTkiat5Iw1v
 MRO5CoPtVBsF0Yf7n6a6rhKo+7jzI0rOIY/PTXkIuOb/WdIDeqxx77qZGkKhpyilaXFX
 kZON/Y0dY4LK/XfNnNrggzktvHuV3FpEvQwifElE36wtPC96dR9YZd3y6JMZ423IfmsF
 DfRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc7xxcVhOWmWPORJB7uw844+CaY3gG7Ky9E9A2SW+1y17quDXM6doruQspg+qynH51GGH4ALTVUdOR@nongnu.org
X-Gm-Message-State: AOJu0YwESclx+IbKiMkeg2YK1RdlWWOc8vp+8hdm/NGoT1FAXkDM3DDh
 URTWnWHGNxklnA92C4CM942vQu2jIBfuOv902tjX+jLcl/Qt8eLl4g6/fNIFABk=
X-Gm-Gg: ASbGnctm+ANvtERn57oL72SKYT+zYnbuIdMlr+T4lIWHV/VsG1GY0vJU++4fSw3jPax
 zof4Clv40wavTT/9FCxxjZTyV//B4mRZeKD3LJLDA+Hk9YvVywZjsiX5IAif9YRbS6qD7RCoHlI
 FPoL9rErrDIO6WHtVRwbDFLBMgXWXcEdnlSKdC3jxKYZ5FfAjp9q+8z1srNAvd3jTqTDelvXREx
 j7loYz99dc/cFViR8iLRmF6gc87UVi+rx7ISe+nDve8lR5EpHfVxBox69hg0SZpNbPivJWUm85W
 0Z2C+/49xohjRCgRz/zVMkBj
X-Google-Smtp-Source: AGHT+IGetrizU7M/rpsotw87uLqEM6548LoXvExOVn9aWVTvoSYd4BCrh1G9DTG4BV7cW80NapV2Vg==
X-Received: by 2002:a05:600c:4e4b:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-4361c35cc4bmr29206985e9.9.1733937562991; 
 Wed, 11 Dec 2024 09:19:22 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361968eed5sm44525915e9.42.2024.12.11.09.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 09:19:21 -0800 (PST)
Message-ID: <934e7598-8927-4d35-9784-6d33d7892952@linaro.org>
Date: Wed, 11 Dec 2024 18:19:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/69] target/arm: Introduce gen_gvec_rev{16,32,64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
 <20241211163036.2297116-43-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241211163036.2297116-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/12/24 17:30, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h      |  6 +++
>   target/arm/tcg/gengvec.c        | 58 ++++++++++++++++++++++
>   target/arm/tcg/translate-neon.c | 88 +++++++--------------------------
>   3 files changed, 81 insertions(+), 71 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index cb8e1b2586..342ebedafc 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -586,6 +586,12 @@ void gen_gvec_cnt(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>                     uint32_t opr_sz, uint32_t max_sz);
>   void gen_gvec_rbit(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
>                      uint32_t opr_sz, uint32_t max_sz);
> +void gen_gvec_rev16(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
> +                    uint32_t opr_sz, uint32_t max_sz);
> +void gen_gvec_rev32(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
> +                    uint32_t opr_sz, uint32_t max_sz);
> +void gen_gvec_rev64(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
> +                    uint32_t opr_sz, uint32_t max_sz);

Remembering 
https://lore.kernel.org/qemu-devel/20230822124042.54739-1-philmd@linaro.org/, 
these gvec helpers might be useful for other targets.

