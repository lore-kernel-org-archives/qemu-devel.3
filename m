Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB451E6916D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 15:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEVi0-00018F-5G; Fri, 22 Nov 2024 10:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEVhx-00017O-NF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 10:36:34 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEVhw-0002YI-3R
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 10:36:33 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7181a8af549so1253163a34.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732289790; x=1732894590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2QFOshhDITpvKIH4tZTJgDwGN2m82TW+6CgyD7oeHiM=;
 b=IqDKF8NV13S2yLzKQ+PYYTPVi3SmPtQtorZc1huRAJ1Uw6K5Xg6ybOtF8Z2mzBZbf+
 WgWG0ZTqkVHtbhK+JLxZhgk0nUzKWHQo8HGhtj7Zna/BBRWl04F4ttR2sX0oomAj/iYu
 cfmNnT2pC5RuewVWUkA/5La7eCyvNlBtRD5czcFqbH1Wwp+Pm+mye9CCHL19n6d04Vf6
 iAKX1ZV6KOQo0ECHrQMORdNQJ0/s0krdDVtBNM2Y3XUQVjs9JzpLkY2cwUS5lvsbtTHg
 J0xZ2YEfSaUOkYqCQxcSZtdTi/xUg2YHpWvhDEEDY8tl/y+Mi5BfP/nKROpvrkMfoewF
 +Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732289790; x=1732894590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2QFOshhDITpvKIH4tZTJgDwGN2m82TW+6CgyD7oeHiM=;
 b=BTVpeh3vzfQ1Vzt4nk3iAgpTWaCyOaAIqJTwz+dRo5wgoAHBf35OH1K++txbVcC9tp
 VjiRlFBgGX0K0OomxOAjhi0QPUs8vaS0A+aDAgAZKv1pSidsDSwaWe6DV0TCH6bmHLpd
 UEriu+lIvmzOJcodw9nWhk7pKGkX+6mj4QIRQFYkL4+eKm91wNK5bFpFYlngwbbw+P3U
 wVxWXfXFghVby0LVVSeueuGwYjEibWOdaDnvC+086MYriFJ/KZAbketpJgSeksqXO9ld
 ydRDIuynuTZAEMBHXDlhArCP/smfUUM2u9qmw4qolzqeT/GtBpFfmzddBkYZqhOw3KqD
 oO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb6Wj5SBUutCwdaUC72504VyD/NEp1blr59QXLFt9SgnXpoHZILzDwMGGw7DlLWy+oDE/zOzalB9+x@nongnu.org
X-Gm-Message-State: AOJu0Yxlc0q8luqk1GpLIqhGsI6m/HHTxe9lq7t6Is/hZ0XNznZ2JxC7
 iHKdsKk3rpem6NMnB1QkB5F7YtRdqhxlSmG4ZRT8GQkdLXGhVmSwoXAp56NYKiU=
X-Gm-Gg: ASbGncuVfGmM866VZAk8t3Lha7vvP9Lwyx8sDSoAXIAD/fDE6nxh2CT2OL1U18ersf5
 YXrNCCasgUqlTh7lAk2JckF3qCzILRw/aFcqlVWguR1II/7qHmBxSWftUrwdCLxu6bK501DZXh7
 6qrwTxaayyWCtSLaybTzeiGq3FRimvpJqfd2I19Pw5lgkE612qX1eO66dBr+sZOud1j8tQXD8iv
 vdfmiGmv5pikYc4eLYbA78JCfJ5vK/tfEg74adkg+mLr7YZZxLMTcO6WJGdKIS3gDbBkfA=
X-Google-Smtp-Source: AGHT+IEf6wb85w64y37olOxO2plMkgKJ9jPrxHGN/JWBaOC09s2Rs9W5CMJ9UDqe2ZOHmj0gPn4miw==
X-Received: by 2002:a05:6830:eca:b0:718:5a53:cc61 with SMTP id
 46e09a7af769-71c04cf0c8cmr3276987a34.30.1732289790510; 
 Fri, 22 Nov 2024 07:36:30 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c03756313sm448919a34.9.2024.11.22.07.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 07:36:30 -0800 (PST)
Message-ID: <a6dd816e-9d7f-4a69-8ce3-b60b07a3d297@linaro.org>
Date: Fri, 22 Nov 2024 09:36:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Don't start user-mode with VILL
To: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20241122003247.8955-1-palmer@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122003247.8955-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/21/24 18:32, Palmer Dabbelt wrote:
> This is still under discussion in the psABI, but it's looking like we're
> going to forbid VILL in userspace in order to maintain compatibility
> with binaries that don't expect implementations to trap whole register
> moves under VILL (as in QEMU before 4eff52cd46 ("target/riscv: Add vill
> check for whole vector register move instructions"), for example).
> 
> Fixes: f8c1f36a2e ("target/riscv: Set vtype.vill on CPU reset")
> Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/454
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   target/riscv/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..d19a44de99 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1022,7 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       cs->exception_index = RISCV_EXCP_NONE;
>       env->load_res = -1;
>       set_default_nan_mode(1, &env->fp_status);
> +#ifdef CONFIG_USER_ONLY
> +    env->vill = false;
> +#else
>       env->vill = true;
> +#endif
>   
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->cfg.debug) {

This suggests that vtype_check() in tcg/riscv/tcg-target.c.inc needs modification.  If the 
probe fails, we need to set vtype back to any valid value (e.g. 0).

Also, may I suggest stronger guidelines about which VSEW are required to be supported in 
various configurations.  Right now, it appears as if the static compilers simply assume 
all combinations of SEW/LMUL work.


r~

