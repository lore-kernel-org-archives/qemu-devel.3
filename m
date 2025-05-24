Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FE5C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 16:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIrLO-0005kU-O4; Sat, 24 May 2025 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIrLN-0005kM-AK
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:03:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIrLL-0007ZJ-LB
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:03:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso4113145e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748102605; x=1748707405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SsI+S+dhj8PkP81dN9eNTv9v0LxqzOKIGeTqAwNt1uk=;
 b=xHRRlfx5YMZVUUxOZCwSf8FcMlr0TGU8wkiuzc9tgG61KbVpqDhcMCSkoUa8WUoNqF
 F4uaPqjir0IDr8Iyr2z3xdiBwngR52nZ0rNhC1BDLZmpMqlpCSy89UDsTfr4xbTAtgmR
 Jt8WNQrLFmXCYJWT5J424WxIsNQD0YRveLDg2mspWXDvpGBeDZpQ2dIwu0fth5jAX/A1
 CpoAKlK8O1oHamVuOfw2l5RbXJTpxC7UtdgP+Jax0Wwhu2JIbS6TDALQ6seE6jZd3fd9
 IPIfD2U9jNLpCg7rxQ3JjfBQXt1hdkaSPxPMCl1DBRyWL04oo1mqMR0ebkVyivkj3B3L
 Ne/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748102605; x=1748707405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SsI+S+dhj8PkP81dN9eNTv9v0LxqzOKIGeTqAwNt1uk=;
 b=M3N03ShjlqKO7k+CM5mHicUIjH3l6pxFz7P1JqqVq0FmZ8AS7scZsomTVJJBlcDTS9
 wJZlzjSo6i9v2RzJilVq7r7XOxq9jyffvxeVvmolB0E5timJAcqXb4hS/+rQY8hWmQzE
 x7HDeWSw0YjcqIcbXtKmI41BvKPlB4E0kQG9AdAqH/mW0fJt+OHB0kydgV1kPGvr7HdT
 TyIDXsi0H7I1XEpnqxC6kCZbA0CwgPE+Rzmx7M1XSWJZUvDnKI7AwjdQZsbHSkatP9tP
 sPAeeS5rE63OIQkxFxAm3I9JTA5Gl3/GhDXy3qHt7gj47SkRm2E+ZdU0Wzww5Fy+KTHl
 BRTQ==
X-Gm-Message-State: AOJu0YyLaeA43l8KjlPrqiZOeEhKVHicqyDZXxLGASuiieXkuyB3r+wu
 MsJRrVgm7S/9unIDoQZc+xAigvUBAZER3WEqzlpK6XW0Tplh66vPgJZk4XSi4fiaPOG92clh4rN
 GHzonGJw5GQ==
X-Gm-Gg: ASbGncuPp02QlagMbKP+x5tYKqEKwHxDBg8yaNGaboTZus/mg2rw1PDmTQHfMP88NxS
 uFtaTbdi5aLd7y4zLopGSGZt2G25C7W4Dt7u5TRFefM5byjtuaZafjZD1qwN8SWzwXjfVWT8521
 ZsK9p26mlLJYEKJm6vAHnmFa4ht0nh+NsYYHlr8KQ3QA0bdh2fO8U1/Jfb1vm15JpSQmiEcGwNg
 YL4/VPaheBeixG9mo127EYx8MMKJGtclvsJ3KMNmavvsiXXzdF1SfkQ3mYyPNvM2IlNwXSZBKta
 xsVFNvsDiIjY9Ge4R+fJz8C+70zS4/oOOeOV/tOLLOZt5TTBzohqC69EUOD5nLL4tqQfwFqOpIt
 s
X-Google-Smtp-Source: AGHT+IGf8HkvILIb1PfHTfIwjYfTsYLfYJbc+cZgihn7gv+ywkEN6ANz0jqQ+SRugsyOhw0EVRu/PA==
X-Received: by 2002:a05:600c:a08b:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-44c932023e7mr27881785e9.6.1748102605420; 
 Sat, 24 May 2025 09:03:25 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ffaa75cfsm179696365e9.1.2025.05.24.09.03.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 09:03:24 -0700 (PDT)
Message-ID: <1bc6bb9a-c13b-49f0-bb53-08b9b97cdc72@linaro.org>
Date: Sat, 24 May 2025 17:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Ignore SCTLR_EL2.EnSCXT when !ELIsInHost()
To: qemu-devel@nongnu.org
References: <20250521190228.3921172-1-oliver.upton@linux.dev>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250521190228.3921172-1-oliver.upton@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 5/21/25 20:02, Oliver Upton wrote:
> Using an EL2 that enables SCXTNUM_ELx for guests while disabling the
> feature for the host generates erroneous traps to EL2 when running under
> TCG.
> 
> Fix the issue by only evaluating SCTLR_EL2.EnSCXT when ELIsInHost().
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   target/arm/helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7631210287..83d4236417 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7389,16 +7389,16 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
>   {
>       uint64_t hcr = arm_hcr_el2_eff(env);
>       int el = arm_current_el(env);
> +    uint64_t sctlr;
>   
> -    if (el == 0 && !((hcr & HCR_E2H) && (hcr & HCR_TGE))) {
> -        if (env->cp15.sctlr_el[1] & SCTLR_TSCXT) {
> -            if (hcr & HCR_TGE) {
> -                return CP_ACCESS_TRAP_EL2;
> -            }
> -            return CP_ACCESS_TRAP_EL1;
> +    sctlr = el_is_in_host(env, el) ? env->cp15.sctlr_el[2] :
> +            env->cp15.sctlr_el[1];

Use arm_sctlr() instead.


r~

