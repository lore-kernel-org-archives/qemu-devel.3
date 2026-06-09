Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09348CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0WE-00026Y-GE; Tue, 09 Jun 2026 13:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0Vs-0001x2-DH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:45:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0Vp-0004l1-Em
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:45:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c0c379e8ffso40495145ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781027114; x=1781631914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gDgR+fLHzgPVmH7Ru+tngiq4o+CVo3m5uIZGU956Y6U=;
 b=sEQRySDJha6PqGhmiEHI0+Y9qwWy40KrE+WrtMjNc8H2pFRQx9X7Y12cbxrFhaxNRd
 XPMS0gCpUnUrP6Maip8CfuI0D5ask9fQf+qH+1jtsT/IjVFS72o03iGNQnJwubdkx7pt
 l9rq1DjxbfH5j+m4RMMO04UDywK2zuQbPgUF6Gr4qAbIjdoKXlThSbloWnjJ2h9s+M7l
 ihM6TJa3FCQzSOf4NkaAphGhJYLRQ1J7J/yRvrSy0te8gBIRvHubdEIFMiwnweUmcE36
 8KX8vrpy33WoAOoJtgOYmReEUidc2A6+DcYV4xvaIZYH/VfhyGdtq/fDvg3uOOfJHQqS
 /74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027114; x=1781631914;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gDgR+fLHzgPVmH7Ru+tngiq4o+CVo3m5uIZGU956Y6U=;
 b=GKEXAaxjfejNLal4sqbIoFd/ambZX8+xZogLThK7Im36bIgMwRLJ10StdwGGyRFdQN
 RV75yo5DktNGjH1riJnYTf8AkomHIas5P1uCX6UMUewqmh3qqmqOAnslTBToBnsElBvl
 fsFhds0AHmqCINDJmdlNQVhqbYAW657eCe+ZmIxRQZGMBr5JKD3doSScqaa0/lMHjAm9
 zUAZ0fh1yj22xNLP3Zqjl2DVHFckU9q3kTq8MQkci/6+GAJwAC8nizdH9EgZAvo3A7B6
 Y76eiW9inpVQx4AHlVi2sD9JGWCh3DDBtIC3PIWCKpj/tKAxz/x2Rh3A6E8YBPrtWZ67
 zImg==
X-Gm-Message-State: AOJu0Yw2Z9wx9zUjigXl4zBj3w+hMCNJ2kbqYiZxKvFfR0BgubeSihzn
 1HW5BBkZQDPvA+4+sk2+Ki+bVAF2JYwLcxtltdX0yuTviAhLa4sTfGFqETI6D26jboB20wkJifJ
 dhrUKM1w=
X-Gm-Gg: Acq92OFIfqccm/HcCfOE1tqt8tCZq82staOfNjfxDftxNmdGoH1ATBu9NslGOosyMsh
 TQn4gVSHgweZSJT5HNrJRViNNtSl7PgRzLCEYTvUl0lzfRH6jK9Lu4UOxt4lvnBuXppOT2iSxs6
 C/+lIhDCHPKRUm+a8ZrVJD9B7S69McmTQwXl+5hToVln2qmmQmpZ3FA5zYRHt9vCwe5gp9fxgB2
 kNcIV4FZXZg1iOU2FJUZlWti1sk2LTFM4+Z5Z+DqcWA/GX4N5QVw4ooovcxWodepdM7VFbuNCUi
 ky/ghbNHGkS+dPDzyENJOd4yErpF9KEjub9NlgjnFBvsF131Vf15A7SEAkeO+BBxgXxauZkdFYc
 hEnc5PrSYB05iBBQIRD0jxqYLxsudSBOuW2QIXXcnW2DloZvnZR5XdZ8J/40K7dRcIh7Ch+VJ+E
 ceR8eobINRbX5/waPnuCJt6heWV/L10waWyJ3CfvvfAc4wA70=
X-Received: by 2002:a17:903:b45:b0:2c1:ed61:36ab with SMTP id
 d9443c01a7336-2c1ed613816mr255509205ad.19.1781027113865; 
 Tue, 09 Jun 2026 10:45:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664ae328sm213161285ad.84.2026.06.09.10.45.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 10:45:13 -0700 (PDT)
Message-ID: <ea18f6b8-7c43-4782-abeb-f7fd4a75928c@linaro.org>
Date: Tue, 9 Jun 2026 10:45:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/arm: split evaluation of CNTHCTL timer IRQ
 masks
To: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609140008.3206970-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/9/26 07:00, Alex Bennée wrote:
> Whether the physical and virtual timer IRQs are masked are independent
> of each other so the checking of CNTHCTL:CNTPMASK shouldn't depend of
> not changing CNTVMASK.
> 
> While unlikely to be seen in real life we should still make sure we
> behave correctly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9dd8fdfa41b..f4aae0a4072 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1802,7 +1802,8 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>   
>       if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
>           gt_update_irq(cpu, GTIMER_VIRT);
> -    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
> +    }
> +    if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
>           gt_update_irq(cpu, GTIMER_PHYS);
>       }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

