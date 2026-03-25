Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADBB109C059
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Ts3-00053J-E5; Wed, 25 Mar 2026 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Ts0-000538-Qc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:26:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Try-000770-Jo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:26:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so2665955e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774466780; x=1775071580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3D9RckyigT4zl4/bckf1rYxQFUuFOH2/1ZUAaiVbkMw=;
 b=EyPEvxX1W/wq5bRM91Kt9tOtFqkVhZPsmmlDe01TZm4pjbgeHVkYxd2nxh2rarHpon
 XON7VzeBdcCtcIzA7K2eUI5mQcDG0JhnIFlfbYIg4I6e/rDjVYHFQkL2FhPPbsTsd3Wm
 75HcGoqC/OD7mRanGUBB7ctXU8e81EliiIwsrsH6X8Fb6EIq9CMJv8iG2WAw5ajZ7CSe
 V+YuPPJX57KdSpQJazXmrQswpWFh9L7zo7kjlT7EhYYheD9ni266FpI36eE+vuqQwlrj
 q9OQTcfqZQ9O4FE40WEHjANn8m/mYbp9Z1uTgqdwtMiIKzGSF0xH+WsjwzKiXFlaSKh/
 lzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466780; x=1775071580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3D9RckyigT4zl4/bckf1rYxQFUuFOH2/1ZUAaiVbkMw=;
 b=SlrerHdYRdkZghEXuVlUSt6tcJq2JUxZGrJNHmRSQxUPElgsNAOZpZRBaHgQ9goDIE
 M8iq8oOPqy8XshpSnfODPCeDCBgJWmm1Ry9SWb3VDDSOiwjawmWwIi/eXkTFsmHH/QtV
 HNWgw3dN/2+PjZ7PoNWp8+xcBUqtTdA6A0mdGhjLifhr+hYAQ8u85zxxwS2oKY5+tCWO
 7R1ePkz9Tfdg3vdKnLSqx0AQAHLX3IMZ3AAZglR8Ho2XH1YiD2Fd5WdEr6+JP71R6JLr
 O4yMHeLRMFcybJR+4bBMKhbd2nqdWokwwYLqN3+6ju7UK6WNvXIYB+ALgdwSbZirypeu
 la3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaDWddntQ2LBFyT4SnI9lC0DSXNa4Ben9qbPfOHnY5zAeXD7b2CZNwpUPoqhUw8xgpZzyV2RhAkBh4@nongnu.org
X-Gm-Message-State: AOJu0YxiCYt8qqkLg3JQBnyFxLSEalI9KTlMi4IYSHU3Vlf8fwHIpjOz
 LY1mhsRw9W61fANoBXMsrMMg2m80ePWNxMFRr3fTpwLC6nxS/lJrTBgYnd8ZZosbz6s=
X-Gm-Gg: ATEYQzzLTGlQRrEy47R9FEKTwFwWRXij42IHbZZO8g8pewMfGiG6D9JzMUThZLfNH58
 MgmlXSKo+9zyqXWDQ60hADH+aqZCj3/d42Yas5O7HOTCsE5QK5R0K9RwRHlrJkUUvJY3dMM96Kw
 KhmbZ/Xlrg+Ory9ORqZg44CFeGW4V9JJhWj/oELJEcC6kFP7LI9Ks7NN3f4JJpEuWQKXZBF0xis
 iLuQLUVc0ARXTXbYJRfsqtDu1tWKWbydTmXYsdmRUkZGCniRjou3v4Y8ywS4SwlHb3IlirHrM0H
 VP6PbVtwe6YqBvq8onFloGQ3N/UCk2G9Y7uU403YIkpxjkWu7UNvlQfFQ7ioWmSqiGrnXf3xzzv
 xBErZ5yR/KVEaFz95Kul1pxI2bk5ZUa4Y187SLw40596D7TifJK11DgLgW2k7tiFQoFs3PHhdHf
 PSmPeGRAa0ig0w1BmHqONPjV79W6F7zjMYrQUbHs84MTh0cvDJXCRuyC+A59wwJym2XX1RLFtJy
 2BO
X-Received: by 2002:a05:600c:a409:b0:485:439b:683f with SMTP id
 5b1f17b1804b1-48716042aaamr52598855e9.20.1774466780461; 
 Wed, 25 Mar 2026 12:26:20 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871174f2cesm153983945e9.10.2026.03.25.12.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 12:26:19 -0700 (PDT)
Message-ID: <9fd5bd15-7618-4b41-a6b9-7a4d552a1ab6@linaro.org>
Date: Wed, 25 Mar 2026 20:26:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/35] target/hexagon: Add sreg_{read,write} helpers
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
 <20260311034923.1044737-30-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311034923.1044737-30-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/3/26 04:49, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.c        |  1 -
>   target/hexagon/cpu_helper.c | 60 +++++++++++++++++++++++++++++++++++++
>   target/hexagon/op_helper.c  | 30 +++++++++++++++++--
>   3 files changed, 87 insertions(+), 4 deletions(-)
>   create mode 100644 target/hexagon/cpu_helper.c


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index af93be7a232..3517f3768fd 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1452,17 +1452,41 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
>   
>   void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
>   {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +    if (reg < HEX_SREG_GLB_START) {
> +        env->t_sreg[reg] = val;
> +    } else {
> +        HexagonCPU *cpu = env_archcpu(env);
> +        if (cpu->globalregs) {
> +            hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
> +        }
> +    }
> +}
> +
> +static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
> +                                                    uint32_t reg)
> +{
> +    g_assert(bql_locked());
> +    if (reg < HEX_SREG_GLB_START) {
> +        return env->t_sreg[reg];
> +    }
> +    HexagonCPU *cpu = env_archcpu(env);
> +    return cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, reg, env->threadId) : 0;
>   }
>   
>   uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
>   {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();

Ah I see, I suppose this is the patch that requires "qemu/main-loop.h".

> +    return sreg_read(env, reg);
>   }
>   
>   uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
>   {
> -    g_assert_not_reached();
> +    BQL_LOCK_GUARD();
> +
> +    return deposit64((uint64_t) sreg_read(env, reg), 32, 32,
> +        sreg_read(env, reg + 1));
>   }
>   
>   uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)


