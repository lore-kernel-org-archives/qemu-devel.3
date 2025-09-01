Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A16BCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2cf-0007SC-NT; Mon, 01 Sep 2025 07:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2cd-0007Rm-QC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:22:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2cb-0005s8-P3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:22:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3cbb3ff70a0so2599850f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756725767; x=1757330567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MagfNrF0bVCp05fHgQD8x67CSeYa5DnvG2SLHEeLbU0=;
 b=cxVVig1rJzPpDIuy7dY534QcFk5460LbQeuq2yxW3aVktIdxkxgHhJD7jh0sNK7OP3
 A8yZk3/hh66GF1koKd0EF8lklaq7XCXG12W9jWDmYfHFTO20cXYVPrLnSLIO6/1VnCsb
 xmpJaCK/EE3ZI7pfKKd29BFmx/cZcnYmYjI+lMBWtp2VcaeeNFNwKDyxUIY7IPJcDj/F
 Af0G7DuATtBHJwBqeT9+p6dP1tmGsbwKk0jll8aLpqbwVUs90v2rIJnO7kMwEwQhhilE
 KlDhSBOOcDxjY4XDjKJgJur2bcof47sPFvxNUl80SxjGtuE0KGKAcXYRBQAp21Yf9VuH
 x5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725767; x=1757330567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MagfNrF0bVCp05fHgQD8x67CSeYa5DnvG2SLHEeLbU0=;
 b=Sa1H59YKsPrq86KATmJdo/A1H4+h9jOJ24ZMHPo4Ru3eFbbP9fvMbwVEMtjfT6QCzG
 u0kknz7vYAIsvjZJki6eccsy2EiP6Vf1LhRMqxL6ALHx9tRzPw2EeGMiyi52y25mIzzy
 sJ/TnPaZZVwSoPfyZHTU28T6mo7ZgQhqDvIzH9AYUNODWeIMaz5yapSIObYwN0ygCCtw
 LY3ipBNyIUrDIItek2jchAJ71zRRSZzzq1eL1tVDS9BfEXMcao9b9FcskUKSRPSqaF31
 4qudsRpiuapZQPwuTDiwskRI0t7DN+C7und/OQ1oZ1+WnFRB8nRCzMuw71TWO0mNrG8M
 cjDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAw8OUgicwqZ0bOBK9DDXBMu74BEleZZwZGQfD3woGjoIX07DZmUI8AsiMGh2Tp/NX5a7E3yBMdXRc@nongnu.org
X-Gm-Message-State: AOJu0Yxov5IDycP7ce0Q8+8R0FAwILhNihX+aSzfhagbx5xPiMO77PFn
 Jf4ykGjdX6akCiCvnwyVQDiyR0fm/URFCmrqimn/MevK/I+uwgJXPWQeO2ZuS7bdnnA=
X-Gm-Gg: ASbGncu3uwTPjlRhvQR1snlx647Ph4bBFjObZ8UuCeucTvJzv8DN7VWXIgmF6nSMbuf
 lZyKh60ZfJ1FvyJZBYGF64se7vEERX2SqSA5Ry5eiCaLdUcSKgblL5KdQOQ+OphThrQXPRYtQYH
 LWHqWlrDiWmSp50ur5zzWVTfUvx8TvohkqgxZRw4BglqaJQH3Ir8n+5WRHkxWWhCtbReIS4YF+/
 00dOa9+UTTQ9M0J3rE2Gid5ebwfujmr1JSRpYDnqb2yDehq4jH2/EKwvVE3MDbL2dz10u4inrc5
 ojyG6ntjngcqgmM3OHj8E2OLcrK1CCigP/CyAZhDZny80DPdDEhgO34SS64mNd7WgTDZP9eGCiK
 HPO3Bh5PfSPYh6flxbXaiNUAdNsQz3DMjoj7NQTGMSfhtuc86yuS1gl6tRAx+s1F99w==
X-Google-Smtp-Source: AGHT+IEa1j32SMzgWvx40rXMbAXz/E7LZUvDCcu+E6oVz0mWbaEHjoqrMCHrP1C5wSDaIO1V6vnIgQ==
X-Received: by 2002:a05:6000:22ca:b0:3d0:64c1:1a40 with SMTP id
 ffacd0b85a97d-3d1e01d67bemr6279792f8f.46.1756725767393; 
 Mon, 01 Sep 2025 04:22:47 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8d0d106esm20233885e9.2.2025.09.01.04.22.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:22:46 -0700 (PDT)
Message-ID: <c6835e86-ed11-480f-b0d8-4d7d743c73e4@linaro.org>
Date: Mon, 1 Sep 2025 13:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] user-exec: remove cpu_interrupt() stub
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829153115.1590048-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 29/8/25 17:31, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/user-exec.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 748bfab04a7..66c25fba7dd 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -46,11 +46,6 @@ __thread uintptr_t helper_retaddr;
>   
>   //#define DEBUG_SIGNAL
>   
> -void cpu_interrupt(CPUState *cpu, int mask)
> -{
> -    g_assert_not_reached();
> -}
> -

It would be nice to have the declaration also restricted
to system (IOW not exposed to user). Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


