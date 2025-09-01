Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B017CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2aQ-0006E8-8W; Mon, 01 Sep 2025 07:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2aO-0006Dh-M2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:20:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2aM-0005RI-MN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:20:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b7c01a8c1so33268455e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756725628; x=1757330428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmHXeMeHaplpbeWWRJ62t2pphWP9VF2eLLTmdjZCQKA=;
 b=HpTwp2t5mBNVsBPMUiMLQ5G/aHrVmDL6MWMxll9VJ7lCATw9ykQ/j6RzPwwAzx0PWP
 PnaGRXDtQGFu1QKZmV4HCFXJu0p14kEVLBKbOTXkBbB1SZKra9qJGtkxfPdUouNYrAMy
 ZRctor6uPp3tqIXIw03Zct6mGu4mcp2DX5JuheZzkm8GXXgzhhGyrvc8Egl/7CsV5+C/
 uU2St48VWNAYSzz1UTgKudp8udj8qQgMHAbVgi+xt8y6e/+k4cIh05CSVXu0A4W6WCI0
 pxsQV0Qm2IIMPwcqu7fmEr2p7LMSp7t2+w3kxx9xrX5a/5l+Tf/TYc0+oGQQsm7k/yZG
 KNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756725628; x=1757330428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmHXeMeHaplpbeWWRJ62t2pphWP9VF2eLLTmdjZCQKA=;
 b=ahnBf11hyafCgXNSDe/QVJ+ELznmXEmxjAthk4+wszGIm08i60NMvQnPTU2hUKzP/V
 s8mrqwYshXqktKZ+kwlxzmiX27Yx5w6IVv6ZDp8Ka3rKH26h/EKGgyshXAIWeCxS2TDd
 86eAqjgPFv/tVP4qAqB4SzgMq3xByaexxoV61NsMc35gKECb9Z3xg5MMi3dutLMYrF9z
 4N32BomuombcfvWprXN5JcPS+RHPy7rJ+5qZwjgctk9dsNBjz/IrjmvQZS73Is2CK5te
 kQS/6ACiG5yHrRQ/Cp8ziAw/mLiF1A6A9X9L1fXY2HOEzNXGac4j/9BBO3QSt1MU+Y7R
 1mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULhK0TbN9Jfrd20+qG9+vt4NRWhDM/0nA9X6DuBUEXlu4R0DRUs8qAShiW5s5lV4UkZYSGMXZsWTJG@nongnu.org
X-Gm-Message-State: AOJu0Yy+ZICLIGMmqja8iGNGEC9DQTPxRSpzLIwr83rOK6LsZNrDBQAD
 NdbFSOgp1FZ1l7N0pOpRcEXc5ZTY5WMhx46wQGwLvOQZOsD7aKMt3kaVTuPtmQYADTQ=
X-Gm-Gg: ASbGncv22hUn2uUScUqxRO5ZsrUBNhLJt/tivjYPFesrUFxLCf9MlWjxtYV909NWTnZ
 hJBlhy5t/Ve333Kab4sCW79wkThgu6wP1zj/W0boAusWvSg6ln7RAayS4BxV8TtxxyTS3NcY0p5
 5spEHSfLitCoh84ntdSxDhtC/H+3YscGqEN5NATinaVevKNiPGCIvuhb8us32jq/9dvOx0K2Kkt
 TdSNnfCF4oHZEMM3MMHmg/OJh/Qzf7RVe3RbhB3gQ/9roIlLbsfr4rHDfApLXjI8J6NRJKdxYjA
 n/iGnGM1ahFatP20n7dq2yjqX+TzsI2aVIj2Yn5GdPXqmrHStg2qA98/yRClSxMrVGasWI3I3fG
 T00ZZJs2jZqfyDw/vUmfElrbd4KjgArIxPJ4mq420g+6TyxS0UhjpZQeTkceFC5S6+A==
X-Google-Smtp-Source: AGHT+IF+qjjtnqzTk/gos9e0Ai9VpTUirJLKlLNM7p4X+UQUwJK6pflvHccoRAacJZGL0OemQk+JnQ==
X-Received: by 2002:adf:b343:0:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-3d29cbf607bmr3435603f8f.6.1756725628549; 
 Mon, 01 Sep 2025 04:20:28 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d690f2edf1sm4181626f8f.16.2025.09.01.04.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:20:27 -0700 (PDT)
Message-ID: <7b9332de-3e59-4c73-9ab2-b2b34aada996@linaro.org>
Date: Mon, 1 Sep 2025 13:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/sparc: limit cpu_check_irqs to system
 emulation
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829152909.1589668-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250829152909.1589668-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 29/8/25 17:28, Paolo Bonzini wrote:
> It is not used by user-mode emulation and is the only caller of
> cpu_interrupt() in qemu-sparc* binaries.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/sparc/int32_helper.c | 2 ++
>   target/sparc/int64_helper.c | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index 39db4ffa70a..fdcaa0a578b 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -65,6 +65,7 @@ static const char *excp_name_str(int32_t exception_index)
>       return excp_names[exception_index];
>   }
>   
> +#if !defined(CONFIG_USER_ONLY)
>   void cpu_check_irqs(CPUSPARCState *env)
>   {
>       CPUState *cs;
> @@ -96,6 +97,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>           cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>       }
>   }
> +#endif

I'd rather see these moved in system-specific files.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


