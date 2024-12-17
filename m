Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A13CE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeOe-0007Uq-J9; Tue, 17 Dec 2024 15:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOc-0007UK-Ut
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOb-0003p2-Ej
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:22 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2167141dfa1so816105ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468140; x=1735072940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=91CuxXfX7+64YTha+E2bT2fg7UigeCMQ/Hdzaec3ju0=;
 b=KdeJBAd5CXZEzSFFWJI+/kM/2KunjBbvt2wTRwgZgHVS0oB8VWeQX3uUUS+5bQs3N1
 AwVFsXYtVwduLirL/4JWMhwFGooT0K4fVT39lQ0UyUpmBftbI8KzAtCAPSUhO7NaWwh4
 ZFr8eJrba5poD2V3YahSwI1IX5QkRmvZ4H+FxSo/mgDScAVb3ta2I2JCkzqHid+fKVrL
 4lcDrGhYT1RaqKMXtkwQISF6uU5d2pISnMgA6Ew7Ql2d17Q/ahowcGVyAUPZmlhLzkaq
 MXgoAwuO6RE+/U35VSmuTI0MTmm6aPIdFw5OaTisB4wVK2R3dIcxQW4bE8FMiF+BCz+0
 2yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468140; x=1735072940;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91CuxXfX7+64YTha+E2bT2fg7UigeCMQ/Hdzaec3ju0=;
 b=qOotsM8lganhiCXKQce5O1gtucTNx+RkKqcJSRBhCDQ7lJFBg7rLDGsHXF52ChD1D/
 MPRkP08pQzAb6Sxj52IEO/vjuO84DYrVSt/BfNtrpywMp79al8rhrpRLzZuDJbg9W25G
 Z4TnO3mAVo8u+LmDvj+EbBl/GEmCftP6B512ivZjPSn5bJZHy4va9s1TTAxyuUS4bLqV
 tTRu3tkVY3JOcNHFJaB8JomWJBmj70vnRuyf1gZivq+qWM13zBK4wPBq41jk8VURLbd0
 gCfJc/Wo/4nszdEMg8gmBB0W5kqP80WPV5LfUfwlPcmZi3SF8ac3P5/ACCBg7xXuLp9a
 9cbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy1m6j8YHwV9uGpQLgv9vtCgZoSlH9AWcjN3CAa9X5uV/7VpM4LEp1ca1t8f3Z93Qk8UwJQ5cE2GlJ@nongnu.org
X-Gm-Message-State: AOJu0YzOFiRc4IYlRk6QEGleHbt+uTdYjdYEtBZxkkg3S0QdUBb1iA+x
 XNgtP80MmFH+2/xJBhEAzCaCpfikHkRhgcP4smm/SN6n92u6ahcLQ9crV53fuJQ=
X-Gm-Gg: ASbGncte7/Hw0Ej+PDMVY3iK2SLbW6ATBX8iG7o3atxr+cZz/F2aKwXP7/aSbEn6Xhi
 VkNOv20hVm2wpqy7eLDUNihIuZ2zxWEiasM20Y6rmjgHg/9Ph1FBfNegPHyNczBKYCKFPk+hxAr
 Y5iOLWn9JDDq0OXHHW7dO5KOxtRwkxaKmmDOoTaV6XlHCfoLKUFKh3Oh/A7SGsZo9iNnAXjiLNX
 8OhzudjFbjXgx1PB9cN8MQYvGX8zq5uuQoaP66DA0Gji79H8lb207YH/UDlkLe8zAl/ag==
X-Google-Smtp-Source: AGHT+IFUZLbdb5B0kOe3hl94hhup14CP5e0dtrpJ4C4yz6o34eFrRRAClAnBy/wipfRVvM3m8JZN1g==
X-Received: by 2002:a17:902:da8b:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-218d72917c0mr3042425ad.7.1734468140099; 
 Tue, 17 Dec 2024 12:42:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e54062sm61795335ad.124.2024.12.17.12.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:42:19 -0800 (PST)
Message-ID: <4c968311-38ad-49ea-b4c0-eec3cbde6828@linaro.org>
Date: Tue, 17 Dec 2024 12:42:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/46] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 30446baabd..c99e6f79d2 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2483,7 +2483,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
>       if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
>           op->args[5] = tcg_invert_cond(op->args[5]);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_sextract(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


