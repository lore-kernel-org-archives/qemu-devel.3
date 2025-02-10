Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4ABC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc1d-0002f0-9q; Mon, 10 Feb 2025 17:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1K-0002Hk-OK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:51 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thc1G-0001LN-Ck
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:12:47 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f6d2642faso60694815ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225563; x=1739830363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OG4nl4JMn5Wb7p2n5jtmBBqr8zpE1l6Y3NgKMPJ8ndI=;
 b=tbdakS4J/X6Q8HXG95QqkB3G8+6qwu3ebGh8nJ4Y7W273t0Bflzun/TJi/q+boY3ka
 q1APFlHdSBLw26aq05+xOIW45feIkdvZXBjMZqbfo5YJUIQBGMij7Cl9A2ViDIfyGPM8
 cLmI+sDS68X70d0Pf4arFmI2xNkS2AjBNQSBmBHMKHnRwBib1aJRzz6FY52lSh1WYLaE
 Z9rrzHBlkE2SzRnXa8tbiH3j7Jxsa80wf12jamXLGAklPkKz/bXrWlniykz03CdRPRHM
 TuaTpmHJkUS0UTtL7Zflcwua25iagHdUPhVQ1NeALQSbjmUKedcKr19Y7V1pz94blYtX
 36Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225563; x=1739830363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OG4nl4JMn5Wb7p2n5jtmBBqr8zpE1l6Y3NgKMPJ8ndI=;
 b=KYjkvT3SkOnudfmuk99aFa4avIkuLK3sKguT8Bf3cd9m6HouQTE0+gl309moI05L2a
 hYjSYOkIkbKNGk/KdeO3xCKdBFoCzOLs699bQR1HKbfr6fufNkZPJdKLz4KYARccIvz+
 qYv3uTWX/aQxWdziMm0qHddNzKWmBrBv4wlP7ngeYfxXPC/1YZ85UlnQvkh/z2dSb7dj
 MMoWaS6BLw9dkCWIVSuty/F45L1L3N+OjoCa1pgp7hszFE1kY1t/krXK3YjfnE1Bc3tH
 /Daf71SRTAHd9vg7stDUD03eqQHE6+rWxMLzZlcXOiz2lgtKtk4NPoHpXW01BnTvbfZd
 Atug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDVkd3FGiSQkUAXHIv80O3DqKDee3wq9hgk0xUaMreLGypULuz9GnhWas78sUAfEJEGSNflNKDoXqZ@nongnu.org
X-Gm-Message-State: AOJu0Yy27iNFoYka83lKSxgtXfsMB2rVm+s282qfjoseqHRUoG0HNoE+
 99zekRRklWFxqYsm+3q9M+9jT3kFYmt3YQJKJvNqxwugReffzphxEYjQL4WZxSM=
X-Gm-Gg: ASbGncsyPwAObviJOrRt+VY7i4My164qRs56Qcex3UtFrIY5wIM14wVDYV7h1Rn9u9h
 QJTuL+X7pFaCDNyysknvd0qCYu1lUxPRGJuK6Dt6EeDo503G9hRlw80RhDO/I9DLxP4uSA4X1GJ
 QI/TzbeUFPmz65hcH8VHjOJLVeN4xT5he5QamQe4lHqolAsRtrIbGa0SqDAoprhcMp+MGL1pWet
 78vyHFVBHRxMX5d5LgGghv5VnJP39DA3+DI4H+ugZoguxm7XVzOch5SNDCIM90734uvMqIVYvLW
 Zr2Sho93Hz2ThW3XVg+o36Pxre4ezj6O0TlVK3F7HBzFlYABzFo4qRg=
X-Google-Smtp-Source: AGHT+IGhv9BKFiC7VvxYLTViWUQhtRyq1uyIt1CXDTYyr3OpENDDeKgMbdrve91Ui9Cl+gOrpSsiqQ==
X-Received: by 2002:a17:903:2f84:b0:216:31aa:12fc with SMTP id
 d9443c01a7336-21f4e6e6123mr233359525ad.24.1739225563341; 
 Mon, 10 Feb 2025 14:12:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650f91asm83768185ad.18.2025.02.10.14.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:12:42 -0800 (PST)
Message-ID: <d50cab06-ccd5-4ec1-af65-fbda9591243e@linaro.org>
Date: Mon, 10 Feb 2025 14:12:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] target/riscv: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/riscv/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2c..b39a701d751 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1156,6 +1156,15 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>       CPURISCVState *env = &cpu->env;
>       info->target_info = &cpu->cfg;
>   
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    info->endian = BFD_ENDIAN_LITTLE;
> +
>       switch (env->xl) {
>       case MXL_RV32:
>           info->print_insn = print_insn_riscv32;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

