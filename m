Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03ACC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURZD-0000ca-Lw; Wed, 25 Jun 2025 10:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURYy-0000VJ-4v
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURYu-0006nv-5h
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:57:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso4824b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863438; x=1751468238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FXXmXTq6wCQKC87RaXhnvWbqDgyK35zYIP5EkD1N10=;
 b=gCDa8sz15Rum/PxV2VXLZb46ye/AJ9xOBy4cbKRvtwQyfLlSj0v9jYZD/o/1/Hpqee
 OmtYqbY44v9ZnO75YboQtx0CZ12UY0/t5arff9SwYQCbbzoXS8F9Jx3VWVKgd1eY9fYC
 lOATO+JY87tPj5W7JTy8fDiKaXAVHRfcxpEVxYbIKnGSPRH3uKMMR2onTamTPM0bxQu8
 YtX/DKkYm8YO0p6PkY018svTEvGbWRiHEbhW3caMcFBwxtSJM5oTcJyLYdnDIafd2jz0
 nzraJcrHv3MlXnm8mZZmN6BGNn0Ct6TtxxzTg6vWUqHQ+13LJoyvE2KfR3pk8zjBXu/o
 7FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863438; x=1751468238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FXXmXTq6wCQKC87RaXhnvWbqDgyK35zYIP5EkD1N10=;
 b=bFyQ9KvA8M2MDO+Nk1reB3Nzqm006sqq0Ns9FhgL4jsIsUrF/kRdkYz/OoEWv52BPM
 XDWIn7mKfEURvJxmHyEmpXQHG7lnjZu0emN7ReiEE2flW7ivFmGccpdsWAYmV/DL2bvz
 Gj8GXlKTAjEBICZjMxv93vkKJaHQciurgCm7JYLbsNtWVdAOCp3fxi9LaaiIzkI1d4uH
 c4A0inGIK0v5Cf7dVg//9OV8oWe07E80w0mgIvQkHXuBJbZNeUl+oJkDF9soFxmsZkfZ
 07POv9EYLd/oB9f2NAU881ZhbDPAWObLFhEm1Nccl11slBZ+0BuwmHdzBTNJwWTAv3Gu
 l6Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFZD3yIHobLw2tI2fjzbPsVr879r0tNNZqLdIbsqxVSI/mJBK9HItFc/RbNYdjsraVY1qKAd9E/pB@nongnu.org
X-Gm-Message-State: AOJu0YxB3YCBXP21QOYha5IZp+FaqxrEOSgzKbhfQHvrq5pDfl8PDI6G
 rFKEFuYY3PC+w81fzPV+T0l5cp+haV0ymPZHnbCOqO9yfPKP9wFnZ4/kWHcPrR6HFbFMD8XumkE
 LAd0VBtE=
X-Gm-Gg: ASbGncstSuMUWlZ5qrg2vrXOOy8a2dSUrsceXR4SSkZAgRhl3tH/ZFfZ/klhqJ/JK3+
 XcHeuAW+Ik+d29RvKIyRrV/nh2J4tMSgFiopcrlh1vtlUEYNd+MZsg1L31lTrhpuYyqJG37SC/u
 gcOSmIAEpN/BTzdb+wj1lxSAotXCBN1/jdXOyUnO7ybVlf9Fns0F682uf3d5GIE48Mcj/AzIEI3
 dDR4U+g3DGeqI7QHZjsIWScWDCVxVSncDTkZDasv9F24FsxKsT5zFZa2rT6ZMiaUV5UoBH8oiEx
 VTt7Qe55QoukxG3olNNym/FlUUJmelmIxrIgj5XPn+dLkBnfyneOF7+AtZPLguW02gD0JuGNGgM
 =
X-Google-Smtp-Source: AGHT+IHHuW4J9crSyfPCj9UQdEHrV+RDOrpzBtN+PctZciv23wtspQykZzGCpWEKKMJiYYyNYS/zWw==
X-Received: by 2002:a05:6a00:4f96:b0:740:b394:3ebd with SMTP id
 d2e1a72fcca58-74ae3096974mr202206b3a.7.1750863438234; 
 Wed, 25 Jun 2025 07:57:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c887378csm4650230b3a.178.2025.06.25.07.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:57:17 -0700 (PDT)
Message-ID: <aa8c6f24-bd04-49f9-8bfd-d22e74ea1a1e@linaro.org>
Date: Wed, 25 Jun 2025 07:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/27] tcg/optimize: Simplify fold_and constant checks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-25-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/3/25 1:09 AM, Richard Henderson wrote:
> If operand 2 is constant, then the computation of z_mask
> and a_mask will produce the same results as the explicit
> checks via fold_xi_to_i and fold_xi_to_x.  Shift the call
> of fold_xx_to_x down below the ti_is_const(t2) check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


