Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CB9C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Efw-0004xN-R6; Fri, 11 Apr 2025 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Efu-0004ov-BM
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:44:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3Efs-0002JZ-Gb
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:44:06 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso14924085e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744379043; x=1744983843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7iRmonuEGTUhV8/bGZ8Qo3KPpwAcDNcdn86dEjX4NIk=;
 b=s5CUmbXxJLUENYaxvk3ibEBvmUORmKKbL5lOg8uVqqTBEk3M+//VBpfc4L/cXnCSax
 QaHJimiW0qYR8JoKzKEFQG9+PuSyW9OqpQP4s9QD+QHoCd6HAFjdJkffDN/ULfsMb1AA
 T5y5iEvcLx7crmRfexVXPjaZK4SEHFXF9WMQXjyoTDoUSe34kw76DysEQjXogMjFhZBn
 E3KpqxNTQQBiSrDiw1ssx4leyJSGX5wIOzTOxF7buFcoxX49EqRYjEio+KGuVD/RSpPW
 LtFbiXCEJxAK1ZuB6p6ZqowYjtbmVjA4y3u1q0zE2b7UIJLcdtev31CtSSk9QPtEPVoz
 01GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379043; x=1744983843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7iRmonuEGTUhV8/bGZ8Qo3KPpwAcDNcdn86dEjX4NIk=;
 b=fX3YQNNhGvhvpRrffxY42pLyYUySpLsviPrLNpR9DlLPP2hRSMfHYCGtZ6ZgU5GHLC
 Wj/o8VdK9dnq9acLeiVsFB8EUPe6S4i9irlNiYAKA3znPKGAeYt4ZCBtzTSVJb+fs+fh
 wb6AJxaFN9rrrjz18iXj1BizmAJjRrFUk8Hi4J5Zosw0XfvLRnGJFyevYpipQLl4UxbM
 RLzryaEuy7sUEu66XQyt64+JRhUY8DkxbmhcNv/CL4qGdMAqDlqnm358NERBUAjQr+Kk
 oKLTAvwlw9DkuNE1NaNd/U41N5bm0Oz3X522QpFeQfZjE3vL9PPUlMkkn9IQpiGtGZAd
 HkGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvIU0kAdcrCuhziDiHrogNPhYBnrVWBUoj7ixvpdVUAj0g8+2WHV9IWVLmpjIToW1MvXhLIpLV6bRt@nongnu.org
X-Gm-Message-State: AOJu0Yy0jUgY61y4JDeh3qXYG2yodAYiOBe+Dftom+wA37CtnslUPWPk
 KnMEQvthUIVOPlbuqS9ad2mWONPzeak3ch3B7NxqhqnQqzmfv3bPeKrGgsKV6WA=
X-Gm-Gg: ASbGncvoU1R8qKiqbHb//kaNkQ7GeV9qRGBi7AK2B0eJyIEhpGDGO7kZ6FQDDcASbJV
 1x1QBjmB/5n2CJkiXUMe6q0rwwq/S1TiLJVYMCdlp+KpOvh3EtLETBG1c9vhjlQpxFVkmSPD1pq
 ytr9DYDqw/9PmDZONMRC0C3iZDA3/s8IDi82nSiCLdux5M9gN9w2SAr2LMmW7WH5xdsI6p7iIWi
 0bAhSMjyR+kC094CmjewDrqxuX+gwl5rhZiXWmh5wrE//+Q8wyXrGCCJ8BxbPkhLtH4QI8gPcp+
 /Wea1Lxk4Y4tZcPcTorbOWrY9sOxYPFIBmn9m6/7jYMDo0v9WXFZUYWId2c2eyidf/IRd/RLSsR
 5bQ3trTRhWvw6yA==
X-Google-Smtp-Source: AGHT+IFj/1ceJeohV+InU/4YA2J+yHDiWMSCg/+Ncbx37AgIArjFXc0h4jayyS0jv0c/IhYKT2JxsQ==
X-Received: by 2002:a05:600c:5026:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43f3a9aee21mr27969505e9.30.1744379042697; 
 Fri, 11 Apr 2025 06:44:02 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9797aasm2087507f8f.56.2025.04.11.06.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:44:02 -0700 (PDT)
Message-ID: <cea136fd-50a1-42be-98c6-e9550e85c1ed@linaro.org>
Date: Fri, 11 Apr 2025 15:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/arm/ptw: extract arm_mmu_idx_to_security_space
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 qemu-arm@nongnu.org, Yannis Bolliger <yannis.bolliger@protonmail.com>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
 <20250410210022.809905-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250410210022.809905-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/4/25 23:00, Pierrick Bouvier wrote:
> We'll reuse this function later.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8d4e9e07a94..5e196cfa955 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3550,13 +3550,9 @@ bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
>                                  memop, result, fi);
>   }
>   
> -bool get_phys_addr(CPUARMState *env, vaddr address,
> -                   MMUAccessType access_type, MemOp memop, ARMMMUIdx mmu_idx,
> -                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> +static ARMSecuritySpace arm_mmu_idx_to_security_space
> +(CPUARMState *env, ARMMMUIdx mmu_idx)

Style is:

static ARMSecuritySpace arm_mmu_idx_to_security_space(CPUARMState *env,
                                                       ARMMMUIdx mmu_idx)

or:

static ARMSecuritySpace
arm_mmu_idx_to_security_space(CPUARMState *env, ARMMMUIdx mmu_idx)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


