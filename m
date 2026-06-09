Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CBCD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0Wf-0002Fp-9G; Tue, 09 Jun 2026 13:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0WC-00024r-Fb
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:45:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0W9-0004tq-JX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:45:38 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c8589498839so2618529a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781027136; x=1781631936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26kw2NwentlM2Et7yRFb5t61zclxO0f8WsdX9RggmrA=;
 b=NG2TU5zVZbizWE/bWE+JGsixOL4aH6S80sfp5YT7xJsbbXtQB4r/v679a/LTxat64P
 BtTz3QiWpERqdWZzWEyQNwUHgm0cKAiaj0wvvQ03saJZ2IOgNL1wBKPUhf2Y5MW2IQ+Z
 BRBtZgIHv4s2dRBN3WzW2bOdKiHrmvYuba9wGWs+RQJsHrzZyC5bwwRAiHeHr2yqKWqO
 13JdOHXcL9JvAAgj2R7PbfZvEy70dqxHdtuFCIJlnmXkY0pRzsUH0a925226hpNgzOG8
 /E4RlXbWfom5flvTQKG7FFCUMDhzfK6Cy5bjwwYBrM8eF1utVTdG1YaSLoxo9icYllRa
 m+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027136; x=1781631936;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26kw2NwentlM2Et7yRFb5t61zclxO0f8WsdX9RggmrA=;
 b=T0tHegQvuhbyGrijsIsNu41WKT+3XOXaaKSzJGwORrh2Vz9nxKEmZf87MJShyuIGVS
 Es68J07lnVmVoqLrmKVHEBeSTDVLKV+tVz1OHO+EH1YoO+ENPJ5aX/HXolyHWcvFkpaT
 TjSCl2qZFFCATlMOOYTMPYsjKcX1oHiKE3WYranPYb18uFYiuSJjMNfQmUqMoP+6D8ES
 okAlncvQ5StUGCJ8gP82q0Q0AXBGEjdzV3TTkUIO8OtVpvav9fHrKEJf3AvWLZb4MUvd
 CMUNRC8GP8J0qLAaCApRnEEk7KJnr6Erxh2G9QIwkRdxuDc4gM+W/Ktpm+GC3X/qN1bS
 ACzw==
X-Gm-Message-State: AOJu0Yw6wUGiSVeZkH/MtRFzIIQ489a+HXRnpfwjCyu5EaPNeMauj+QT
 //i/vH6FUacOthMBRHH3bTBzMOFsuQBKQ6w661itax5TMWATmwGs5A9N+FCa/R8mX4+kjgI7Md3
 esB1AZFU=
X-Gm-Gg: Acq92OGUmrNxN1PIxFp5UGO4Npw7pStoLMihgYdGclxkFvEjhz5nAwKPcN8TwKdvm4V
 DTTwSVkVVRoS3yUmnWvumWuCsgCbrcXW83j45VOKPpUukKB/NmkSIm/xIsjODK2lTqWGRMXBXii
 cJ6MeXCQU/5akh1ecMFrPLNERh9L3E+Kf2kklJd/ztPnzPzvN2K4vQgFl9jDXOYfiCRH/b47HyX
 NtAS7L/ByscyOEOfjS2YiRpityJyH0qIbfkLDf4GyjhcU7e8RU3vMIWkS9Td+VCSgqjas9t0jOl
 d9MQm7iU5mUDKLLNSV36BBiNORTCUU90JQLevyWoxigXlXqjQm4CmDrZwwuftpnuJZXR/p4ZWoI
 T3zldDL1HABOKUqt7fCL7n8mOuhW/HweFxtaB/w0DxsRyd1iWDOKZw91TUA++2RauztAIaxrSeZ
 pSnMG1MJFt/jQKVKWZtc0wetDOUg+S0W1y8QW+SGqzSsPMvyA=
X-Received: by 2002:a05:6a20:7289:b0:3b3:fce3:a7f8 with SMTP id
 adf61e73a8af0-3b4ccd775f2mr24419156637.15.1781027135833; 
 Tue, 09 Jun 2026 10:45:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df034ab9sm18643671a12.5.2026.06.09.10.45.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 10:45:35 -0700 (PDT)
Message-ID: <41e90f99-ed99-40bd-bed1-4c425c75bd0e@linaro.org>
Date: Tue, 9 Jun 2026 10:45:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/arm: trigger timer recalculation when toggling
 CNTHCTL:ECV
To: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609140008.3206970-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
> When toggling the state of ECV we affect the offset applied to timers.
> As a result we should trigger a recalculation of the timer value to
> take into account the new offset.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f4aae0a4072..5c640853060 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1806,6 +1806,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
>           gt_update_irq(cpu, GTIMER_PHYS);
>       }
> +    if ((oldval ^ value) & R_CNTHCTL_ECV_MASK) {
> +        gt_recalc_timer(cpu, GTIMER_PHYS);
> +    }
>   }
>   
>   static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

