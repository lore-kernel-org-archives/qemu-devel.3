Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C410C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 21:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhx2A-00080d-Gs; Fri, 01 Aug 2025 17:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhwH2-00007r-NN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:22:41 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhwH0-0002il-JA
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 16:22:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so2188365a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754079757; x=1754684557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+Xg1GiL2IgqUufNbfll9L1NhemReaq4SAsPynjLQxc=;
 b=TMiO+G7gmuHX+MD+ZJ8K0Dm/bT92joJAIqHprfJ4Ngfj3PXI8BHVaISLlB8kLVuJW8
 smRzur7Iu7FkkJfL1LS2yCiN+wffAr2coI4Pf5SI1jctEYGuyre5zbjugXrORxbl3K5B
 N/hPRq3EyrnaW0gvOyYZAdFp9YOTrCvQwBaVByLTbmBqF30MuXAaQCEh/bzfAatbcg3q
 kg2jP01dXkHKVZvpdiSYcuYeu8XnPE/NpJLsbhLxLVCoVTJONi+2xHmg7B3dq7lEChZb
 NDNLaj/bb13sL3+RyRBOzszErShKMR/MUL2r9A5AUtVWupfaxUrC+iY0tfxsq8wYzNhQ
 Hubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754079757; x=1754684557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+Xg1GiL2IgqUufNbfll9L1NhemReaq4SAsPynjLQxc=;
 b=BaYCplkLGjAxQc+SvYYzPAsAfwb1OcasrPtaPYDBeQDswCoR84kN97kliuI2Y7GXYL
 41xQQUcOJlrDJK1jzRxrSqs+7Z43A40sBqrG9YufDlUqWDBTHcGBSt9OsRWlCaoOkwcn
 rV3W0Bm53h2bogNaTJg1mwjjs3a484kL8bU+CEdcYQkMJH1KkttiHCYGbFxKsIeIQuva
 FRxJL+Wv97y7DVPpIJwHHchylI9xV8mI2XIsIFOPqpVZPPzXBNB8F+wB2EHpBq/87SMm
 vkswBZd2/BpbpvmHqLqjaL15lmzPyjdsCfweFNqYaJBz7SiOnF///HF4ddB/r+2dHNMh
 PZpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU34k+/Ff9s5wFQuASwqwqAEnfjNmV5/t7U9O87x9590mZvPSkE5rw+88MClW6DUJx4TyHFUG0yEjra@nongnu.org
X-Gm-Message-State: AOJu0YywC99W0tjhyBN08tiW7tJ1ALz21hZTgr4pUQoe1lh1T80YIyyo
 IZvhcyKH8sLmgC7FCg+ZnWx8H0MKNLDZGHUOtGKJ14LYTcmNNbqi2vQXf7vZvY2t0oE=
X-Gm-Gg: ASbGnctk4QXJM2AWWzn3Kdr2ADe6LKzzPoi0ZV4D9UGisBfGDJVktkL7dg6RidA8TPT
 htt8hZoe7NLEOvEWr83Yeg0SBbMakPVNdpaish0bhz1hnaVUMLABtur4+euVj5e/KsgwzDIAaqq
 tfBeznfVD5hVJp+sdnn/1UXRPv6z16qMcOdkkgLagJmLjtHO/s87nnQyT/7tjmvFREyHnUy1l67
 NJO6yo8uLtS+zPjQoCg7hDYm7vQC2tZ282knGMBr0FY2IaaIij5P8etYZZwg92bqb/7GbNqTyTj
 rRirRZq7rTrb13K4xUemlgRi0bY7hxWRDrlSOFi9lv2A7Lt60XMbchZXWTm9n4GVkZxkYibhjOw
 dNrKjSsK8sNph3v5UuXU97oC2wzi1R6MJArk=
X-Google-Smtp-Source: AGHT+IGzkLPHYPxF9WKZTAu/+OgIHbFJDQUpBuMHeafp5gjM5wpl6PCxu4NvT7ZtNy6sK0Tz4hxKuw==
X-Received: by 2002:a17:902:ecce:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-24246ff3902mr11031375ad.25.1754079756671; 
 Fri, 01 Aug 2025 13:22:36 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0f6b2sm50887545ad.54.2025.08.01.13.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 13:22:36 -0700 (PDT)
Message-ID: <ba19d78b-ddeb-4ed0-a724-e20b01fded8f@linaro.org>
Date: Fri, 1 Aug 2025 13:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
> it's time to bite the bullet and extend PSTATE to match.
> 
> Most changes are straightforward, adjusting printf formats,
> changing local variable types.  More complex is migration,
> where to maintain backward compatibility a new pstate64
> record is introduced, and only when one of the extensions
> that sets bits 32-35 are active.
> 
> The fate of gdbstub is left undecided for the moment.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  8 +++---
>   target/arm/tcg/translate.h  | 20 ++++++-------
>   target/arm/cpu.c            |  6 ++--
>   target/arm/gdbstub64.c      |  1 +
>   target/arm/helper.c         | 11 ++++----
>   target/arm/machine.c        | 56 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/helper-a64.c |  2 +-
>   7 files changed, 81 insertions(+), 23 deletions(-)  

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


