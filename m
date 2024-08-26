Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE659C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sihHx-0004jU-UL; Mon, 26 Aug 2024 17:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sihHw-0004Zr-1H
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:30:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sihHu-0005Zr-EG
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 17:30:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso4322769b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724707809; x=1725312609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ET58ZsFht/AM1e8o3WIpvgr3yTX7mvXQ5zS8Bvlr03Y=;
 b=X/yi9Gbv972zuRtbDDeF4RR2xhCd3X4QoKIwlc3T6TQ93KluC58B7NHuFUH4L87rT7
 /4t61xmgi9tHWPOPXWGiGC2SEWfEOsAbPQe4PnPJdzlyYBTB5t4wT4seTU5iE17FMwQ9
 MFrN+E1wj3WF1inf2/g8jjTvBicFChXFgabutRxwpgoDp8HILirwXx/+3pvXpkdeBxQl
 pC2byBEtF0ebHwARi0WjOiBvv26IR855VN2sGM9O5XYQRcJWMBsA4t6JGkYPFs+dh5cT
 Jt4a1Bzy9n+g8I9Lju2hP7PneTxLfNkMfDJhTE55mgVYYfRVbg2ocXq3+EPneKTfIb2y
 xqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724707809; x=1725312609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ET58ZsFht/AM1e8o3WIpvgr3yTX7mvXQ5zS8Bvlr03Y=;
 b=vLJRNNpsI728BgQvM45/URhljl0HgOOOcvXIyavaHH+xMB09oKw/W6qYXAMMfdLEnP
 j5IRB7S60EE1UMZxOjX5xkezTAMDzQpAnggPSw4kA0e+aqG0HyQLqJ/CAr2szGF2oMPO
 N5tydNpa1UQ6CNyzZYH4RRLYeJ1ie9JItbPaMJLoxbcB13/z1c07ALC6V7tiOzTTr7lX
 TXPRwxsIo/DmoNsoJHHLMMkiA0lq5RyWN9FRb2EXBd8zKh6txmCBg9F/R8773jAqrUrt
 3VNvv0Rf5IjZ+fKDibzZKBugETG/o+hHtqof61oqTzhrl2AqBwesCdm3W50N4WN+T64z
 sbrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpnKm5ApDFhaev5gIY/C0Lj3hjN/5rvqPLbJ3I+iuVmYtYAC7FoVRwMY5+rNoiQQoqUWP2itnVItlR@nongnu.org
X-Gm-Message-State: AOJu0Yw4cXNXrlygaHz9DoFMEblCfmHYx5Kbp+D0fxqaxadfcCnZRqjN
 RJT1QoQ2UT+Z0nK03w/D/jtI/i0lT5K9VKAy3/MMGuuEs8D7ym9PdJ6nh16pVZ0=
X-Google-Smtp-Source: AGHT+IHCK4Qmmj46WFnHuBaX2Lbiwn/lEnh1Mq/sIjNX0tCHkFuE5Vd6YqiC3ajGv8HYyLKqUyQ7+Q==
X-Received: by 2002:a05:6a20:a106:b0:1c4:942f:1ac7 with SMTP id
 adf61e73a8af0-1ccbffbf46fmr1447479637.0.1724707808753; 
 Mon, 26 Aug 2024 14:30:08 -0700 (PDT)
Received: from [192.168.98.227] ([1.145.75.248])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acbfc09sm8107886a12.37.2024.08.26.14.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 14:30:08 -0700 (PDT)
Message-ID: <a10c10b2-498e-4572-9718-df384b3c022f@linaro.org>
Date: Tue, 27 Aug 2024 07:30:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] bsd-user: Implement RISC-V CPU register cloning
 and reset functions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
 <20240824045635.8978-4-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240824045635.8978-4-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/24/24 14:56, Ajeet Singh wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Added functions for cloning CPU registers and resetting the CPU state
> for RISC-V architecture.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
> index eb37b062a3..522cfc099b 100644
> --- a/bsd-user/riscv/target_arch_cpu.h
> +++ b/bsd-user/riscv/target_arch_cpu.h
> @@ -130,4 +130,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
>       }
>   }
>   
> +static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
> +{
> +    if (newsp) {
> +        env->gpr[xSP] = newsp;
> +    }
> +
> +    env->gpr[xA0] = 0; /* a0 */
> +    env->gpr[xT0] = 0; /* t0 */

Now that you're using proper symbolic constants, the comments don't add anything.


r~

