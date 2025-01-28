Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8894FC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqt3-0001Xj-7x; Tue, 28 Jan 2025 14:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqsy-0001XC-SU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:33 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqsw-0001FC-Ac
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:04:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21619108a6bso104058955ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091069; x=1738695869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHJLG3qdnYe13O65GgfhVY1MD+fz69Malm6NTUctPgo=;
 b=mJC64n6C3fV+cRguuW4CZSHPtdiBSFWyqFbPjgEjhbrtZLGnof6uxJPyZ0VnSglkl/
 mchwuUT6suX6nqokAxj2l3ySTsJZO7mrHT6jzWvCTnagDe0k2bgbpkUaF/yMx9PBel/4
 7+Wbz4VGNn1zwJVMAHt2veQ5EOsCYofsFFYA9YxwqrM/qFV3ZqlNHfsP2SjpMbFjPdKJ
 h1s7Txy549KGc5KSmWcE6ofuVSlt7j3nRoWCz2jQwrjYQq6ZzZM7ROjImbdp/p/HSe+F
 HN+fwkM0CQ7e9rgH+R9EmhIDV1TPpGy5j+nDz1J0L6DfU2iPujg1u2mDgEuNoH4IPj/A
 I+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091069; x=1738695869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHJLG3qdnYe13O65GgfhVY1MD+fz69Malm6NTUctPgo=;
 b=sIdRE8oHRDIFQkstjbGTkVJVAAPDYeMexVw7xrbxXhXjkaVEi4yfcxo952cUQA5S+C
 eWFbeDGwkbQRxg+hEipHsEozKVeUdYDSWHgTfShQQIFpjQRKpmvzhMMjMMbVF67FxRKo
 p1f3Y0e9icS5mqM/8BlRPr5JhZOa8JXarI3jdp7ym1UdK1lUpWPCCpyB9wSSNsFcpehT
 5oRmpdNEHFABXbikbv6X/3lunUlDXeZ1NQwF5SnzDI38AyYgmvxEIjd96/YugEY+teRE
 p+fLwwttkxpSLjh8chvben3OkPZsUzYa58Rr28nODS4FxQDSSfbPK6hQC3uScdyKT5it
 nb7A==
X-Gm-Message-State: AOJu0YyN3A/XGN7KwNzqrZw8IaggCbEWn6Yf64PVra8sral4E4Q7fi4a
 HjlaiFC951oAZ9PJbR3d1wb5g6TQmozq5FyM9w1k44Q78dXd8oozWsjJE6lL+3AyNuKEvxodM0/
 a
X-Gm-Gg: ASbGncvpWqDjUvAcdAPCrSZcLeV25lhvXDN0piE02GckjHk4Vp0tiIk843ddUFqrt2F
 7ICLJh4mtuJ5c+XK0fB9WbMP8+Xm4Ow26rBYL1tqGgnppREpjeSB6IPEFdkkesbktmye0xU7viF
 bmo5PspuQ+M2bpSAE25VCPLbp+RY5qDcgObRbmfLiUodZIGU4Ecc7bRiAPtU51ejC4Ek9QcMCQr
 aHb39Yo/UXA3wifK1GzslcbaS5zTDvtFS8z+OlRMVni0i/P+W8v9xvdH9KK4nQ/XYHuza2nubum
 amv9ivkobHnPiCF2rIp6WnFLdhAzewLF6/kGrpsgz2IYzqJP7BIxMtwcyw==
X-Google-Smtp-Source: AGHT+IFe8voc6rozfyqTUEc9tKCqDbPrvfAe+Z+fU7KHLVp4i50FfhLtamVve/YL5stSoNOiZM2rTg==
X-Received: by 2002:a17:902:c94c:b0:20f:aee9:d8b8 with SMTP id
 d9443c01a7336-21dd7c667b3mr3431285ad.20.1738091068964; 
 Tue, 28 Jan 2025 11:04:28 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414cc20sm85799835ad.165.2025.01.28.11.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:04:28 -0800 (PST)
Message-ID: <c3bd1aef-7e6e-430f-aabb-691af6cda99c@linaro.org>
Date: Tue, 28 Jan 2025 11:04:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/sd/omap_mmc: Remove unused coverswitch qemu_irq
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 02:45, Peter Maydell wrote:
> The coverswitch qemu_irq is never connected to anything, and the only thing
> we do with it is set it in omap_mmc_reset(). Remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sd/omap_mmc.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


