Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DCCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 10:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3XDt-00075P-1D; Tue, 30 Sep 2025 06:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XDq-00074r-Qj
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:04:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3XDj-00031D-P4
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 06:04:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso32584075e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759226665; x=1759831465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0rzO/VT1zC0JROCevxKtQYy0KyGXEt7waNrDHcyX4g=;
 b=aBec8NuPWUYp8dmdBnseBzb/NPN1/AubaRVNAGqBGijV61cBe2zYsPtd9lop3vjxqN
 cAsjVL5988mhoa4VoWnFB5u8W33JzkiCpvSRG8ffFEQtSs6hHLr2ni9zgnRhBQnG+kLX
 qJn0rWcHhKyimH50xAfOlruVxRAIbu/iA+Uk3gXl2goSIGywM+xTAteGnwRGm0xIonWk
 W6SUfLReglCPH48jRkdUr+G8OGY2YZ7Z1oGkOAAe643l5wQieq8tdev4rtNnfTCc4kEn
 nrOQWuvuKQx+vmLEUgXCGIwVEnkPcuVkmo8TCFgeEnbmhKl2mDA0B1Ul3PAzaDHZ1kxm
 21wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759226665; x=1759831465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0rzO/VT1zC0JROCevxKtQYy0KyGXEt7waNrDHcyX4g=;
 b=s600mj4ZqcC73RtjusmZ64FWDj55yk5SGyl5udOSNBdSxv9+c53tbTIyW+yknZ/W2M
 1ZMwd76YOdrI7/k8Hfw/RDQklCXtJrIFrGhUvxT4o+w4JceOytauwbR13DNXJGayoSSS
 wy5+L83QeO265XMwIk7N3zXKKoEXLJJNH/YaB8UcOG+/4K6m3PcB7hiMMmsXVTtYFIco
 hypjx4xjxcAyvs8UmtIFx7SPCT/p7R+RLbQMm3JBGnE2DKtOA9gQmlDJ2ogALc80ycwh
 ndt4CHb8MTOBHMr8ktMXF64b3/lSipNVYdvCpRfcoWvcfHfrQqxWrXYJROIJDuhOnPq1
 a4pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvLa/fEyv56o0N4tpmZKk1Rc8HX4CTNxzwKIDOnQyIuSnyIzkUj8DA837NgX/eOSl64JNksprY5Mps@nongnu.org
X-Gm-Message-State: AOJu0YztCwmF1f1hwwClGfONzdG4Nq5c2zXpZJax/qQi82sgty4URmt4
 DzTWEBBZ1dH24cKDUP12A4higoQ0A6VRLBCNmzt6rz7vLhSLLx3ORnl+CeguZX6JdfE=
X-Gm-Gg: ASbGnctCqz7h91VDe2HYOM6t/1t9hlMQC8BRFhmR420CR8SsoWgY+2rvsE65+fiSolD
 Ln8bAwedvy7ydY07nQ9EvCaEx7EjNZVYR0mMb0prOYNLwZ2+t1xIdmjQQdXlauanH2VS6wddT6i
 G3alvtCK2nPKWCH1KpEoCjWXXar1+b18V3poV3v9gLe+nnKt31xTQYtuH8osZosoYJLkyoJKPk7
 Vevx6rXbAxxAU7XODVbQiUwd6kxDyq7VjKach3TEkMvSPk/3NiJCHnfnZcWxmtzPGrHNgKyN6rw
 tVk3Y0NQorAlqWTxvH3nCA9iuAAfSlWHf+7Nor52KdWUVWjKKTli3aCI5nhkJxXP96UzjyEguvr
 VIKYsCd9wu8xp4lvHPBrZDzEfkpb2ksRYONvUtX1yeDG0YLADDBi2SFowD6qI9d6pQZpuv66RHL
 UgNo7Qgc9BqDBbKIjt5Ovw5bBU
X-Google-Smtp-Source: AGHT+IH/MLFqaqpbjAlBHCfbxfU/prxhPdDUbX2SCsmuyFah/8ykfhCrUjP6QGTw3gXQUxbrfLBbdg==
X-Received: by 2002:a05:600c:314b:b0:46e:3d41:5fe7 with SMTP id
 5b1f17b1804b1-46e3d41626cmr145802425e9.29.1759226664964; 
 Tue, 30 Sep 2025 03:04:24 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602df0sm22064227f8f.36.2025.09.30.03.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 03:04:24 -0700 (PDT)
Message-ID: <a9cb3275-4707-4476-84e5-e42711e89116@linaro.org>
Date: Tue, 30 Sep 2025 12:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Flush the TLB entry for the specified
 address
Content-Language: en-US
To: wang.yechao255@zte.com.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20250930174849833XG1Q1ETbNvg66WU2UVBTV@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250930174849833XG1Q1ETbNvg66WU2UVBTV@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi,

On 30/9/25 11:48, wang.yechao255@zte.com.cn wrote:
> From: yechao-w <wang.yechao255@zte.com.cn>
> 
> When the guest executes sfence/svinval with an address parameter,
> invalidating only the specific TLB entry for that address rather
> than the entire TLB enhances TCG performance.
> 
> Signed-off-by: yechao-w <wang.yechao255@zte.com.cn>
> ---
>   target/riscv/helper.h                          | 2 +-
>   target/riscv/insn_trans/trans_privileged.c.inc | 4 +++-
>   target/riscv/insn_trans/trans_svinval.c.inc    | 4 +++-
>   target/riscv/op_helper.c                       | 8 ++++++--
>   4 files changed, 13 insertions(+), 5 deletions(-)


> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 110292e84d..0fe5fcb3ac 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -555,7 +555,7 @@ void helper_wrs_nto(CPURISCVState *env)
>       }
>   }
> 
> -void helper_tlb_flush(CPURISCVState *env)
> +void helper_tlb_flush(CPURISCVState *env, target_ulong addr)
>   {
>       CPUState *cs = env_cpu(env);
>       if (!env->virt_enabled &&
> @@ -566,7 +566,11 @@ void helper_tlb_flush(CPURISCVState *env)
>                  (env->priv == PRV_U || get_field(env->hstatus, HSTATUS_VTVM))) {
>           riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>       } else {
> -        tlb_flush(cs);
> +        if (addr) {
> +            tlb_flush_page(cs, addr);

I suspect tlb_flush_page(cs, addr) is the right thing to do,
even for addr=0.

Can you point at the doc?

> +        } else {
> +            tlb_flush(cs);
> +        }
>       }
>   }
> 

