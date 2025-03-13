Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EE0C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspX8-0004Vo-U7; Thu, 13 Mar 2025 16:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspX0-0004TU-Jd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:51:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspWx-00052K-LS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:51:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2241053582dso36406605ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899110; x=1742503910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a5CkXMQGPRbNszlfPUAbD5Rg1fAnhfawNyWHW1qdBjU=;
 b=s1T9q3uUu9qvjc6KAKQw7H645l4+laoReU/ml8neWcLNjG0DHHVOL1UypKZFiODtC7
 +gXSEQYcmMot/zSugKI5y0L+KmpLztx5S/pP+E7vm8JC79mMRzlWajZlJJg+rqnsW0fB
 c72aMJBL1vir6GngLDWvBHNNsPuv4/X1Xumu7o6tB8QqY3xdvN5k3rW2GhyyfFYQIZOg
 giap8BwpPHD64Sipg7B7ofLo4RisrEQiF6Kb4mrXKhiTjMKXjf5soTlBGxdDCwN3pOfw
 ZToOjxHixKKU2ZOyhAmQRgC6R9aqQY56qgI3OemM+5g2HtlSmK8dRm6chJwJOMCdVxyl
 JCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899110; x=1742503910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a5CkXMQGPRbNszlfPUAbD5Rg1fAnhfawNyWHW1qdBjU=;
 b=n4lw4wSLTxhgVa+wbwbOcxtfP29tXcmcgD0BK/ah/iENnqlfAzCKHRoSRTyM7vgq2p
 0g+SJB2ZjBngQ2ogiPpZrmEAfxquF4uJxfBqFcFTpIEJ/ilB735jL0RCoU3OotQxfOsa
 QJANcVsHxGhliOzMv+FNPN0DIe2ftLlyBv+vbYJIAhemHcPSFFAC7QmSW1zWekhioYLO
 4pse9J2izUE6I+la959RmxV/bTziymgwuh+Mvoqv4hUdXyPDADI4p+fNwtqa0XsGv6I1
 G/CJF+y9RHeFskaX3wE+pueXQgStndCGHHDd3poVlC5QkF0cZ2Plzs4hEII+0m6/fKKo
 9Gkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe44FRpsG0KXM9rdKGxaePn1RIwHEn3S6Dm2PPfOW+9DM/CkClROLadWhqr4qITfoUcwoXixveaGfe@nongnu.org
X-Gm-Message-State: AOJu0YzoX0tPFwtt5vJGZpxSaOQ5cE8XqbEn4VHLCu2DyRQGTqKoKnh8
 PYaZkKJTwVpDNYaey5h7/YU68phu1xQ6rSMsqTwKYGR/KcbnPaSCHBCeoBoSkCCjah+BmuK9MEe
 hwOo=
X-Gm-Gg: ASbGncsshI2WPTJcqlDoDdYetTNcUjAziavc16MQ+XxYM5tpcW+XlaT1MvMEC/3mK2J
 bkVSnAYR4fQeBEm2CJKHmzthZHayYL2NQ4OWpsafNcIELYKieCwaNg72Xd2GNRpCq66btx6uOwz
 iKjr4SfVtID2fWbuAjEzI0WM9lTYJwnWSxxxs9HZoir2jsAPE+xE8JYsIUqCIeWMwLzqVs8jAOR
 Yd3PcZW0SNhjzFZy4WBDJH8MXtqZ/6rJ4/KJ0HEImP+VgnMnaQqKiu5rMZ8WdGbHY9zNAPWCoCF
 JgQ9c9zxuTIs5mH3HLvWNPtN6nGLQA95O4j0ecZ+zza4bGgkNaKIYkioIw==
X-Google-Smtp-Source: AGHT+IH8WgNxlD3fIleMtWxbZJQH6A+zPgndDuiJgAHbWgWeHW5kYlH6lQBmpbunrabbrcxWji8ywQ==
X-Received: by 2002:a05:6a00:a21:b0:737:e73:f64b with SMTP id
 d2e1a72fcca58-7371f0b2acbmr1126480b3a.1.1741899109933; 
 Thu, 13 Mar 2025 13:51:49 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167daefsm1786218b3a.113.2025.03.13.13.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:51:49 -0700 (PDT)
Message-ID: <184ce4dc-22da-43a3-85ce-b8cffe271476@linaro.org>
Date: Thu, 13 Mar 2025 13:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/37] target/mips: Protect semihosting call with
 CONFIG_SEMIHOSTING
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-21-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Semihosting is not enabled for user-only.
> Avoid the test for that case.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index b207106dd7..1ca182c1a2 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -415,11 +415,12 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
>       restore_pamask(env);
>       cs->exception_index = EXCP_NONE;
>   
> +#ifdef CONFIG_SEMIHOSTING
>       if (semihosting_get_argc()) {
>           /* UHI interface can be used to obtain argc and argv */
>           env->active_tc.gpr[4] = -1;
>       }
> -
> +#endif
>   #ifndef CONFIG_USER_ONLY
>       if (kvm_enabled()) {
>           kvm_mips_reset_vcpu(cpu);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


