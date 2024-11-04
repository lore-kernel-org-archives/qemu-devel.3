Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E2D1BDD5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t817Y-0001qy-8c; Mon, 04 Nov 2024 12:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t817V-0001qR-6M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:44:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t817T-00025T-IQ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:44:04 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c8b557f91so46763265ad.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730742242; x=1731347042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FztnSqTWCGlJJMXfnFUCPtRF8LgohrEIneqb5Jj/AjQ=;
 b=a9rukStRgVqCIbuhoKmskQi6b7p30u53zoAQZCRVPQzP+ZjUTL2nbT2afCIf13mB1Z
 El8VUKVBOcGlmLtN9YhJEKHikXeOzVEHOmzJDyAWtmKl3+g0U3j4tcppW6wkzLpoU3mJ
 1UPkHK0LHnJJWr/dmzTli0xIlSpEMr59P8IN8GNlxtN+A4Sp75xTY6y+Beo8LLayKpAr
 v8ZoSuHgoB7iEcWEYsjsruX9KJw/vbraotG33ECOVGexz3/XbtXTqkkKygNELPzf7UKW
 GYCaNKjsrlemsJ0YTr42dTOZvnO/Nz6o7hFrEGZ1iobrcdxzDF3lhfSEDQEjvdI6wC8a
 fH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742242; x=1731347042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FztnSqTWCGlJJMXfnFUCPtRF8LgohrEIneqb5Jj/AjQ=;
 b=pTx2tZyUOjMyerqdR2Or05Mlj3WPZuRQQVrgLSIUyUoodI6nWTX8/cSnlo28uplgix
 +mstPJ1qJma9kxVghj9TRsa281/OrM4nT1vxeJO2smOCySAV79GUBy0Br3j5MSQEWw7S
 5cyALtyRn7fQ+rNqlxuAmRaoT/qKPpCXLvQM4ieCfvR/ZMIubBxhi64JMlpweoZv5KL7
 /OR6O+IddTJVzhzo0lR+nhuKvrgzKaBi+Fi0xd1CIuoHaJAX9t+kxP56B99BUMrz+TT/
 GYvl50vpH2W6KvbhjrBJ2idYs4OxoApgNE5vm2zANbZ+TJ+KE5xi15fO/Bf/xPnm5vmr
 w27w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyhLb4h4RYdLAHGJYvACuj6/lDwB5vUXGAXXfdGAFr9el3rXaRx+9FZbLttZehZSlzyQkw0HAUW2UO@nongnu.org
X-Gm-Message-State: AOJu0YwxWG+hu/Fy1OOaObjdrT4YjUDW0GcE4z7S/qAIaX2xpI/6/ps+
 /3E0/+eir6kOLJjHGqV5U2F2GGEBvOM/dq/VZXsjWNR8n0+Eso4GhrRTRomKenA=
X-Google-Smtp-Source: AGHT+IFr40Bb5T1Ba0ekCZXsdpQ8vDxVblMuEj7R/koYbXgybsXRAbtLrGjwYT+Ljh9LQdoTwr18EA==
X-Received: by 2002:a17:902:e890:b0:20c:8abc:733a with SMTP id
 d9443c01a7336-210c6ca8b77mr465314495ad.53.1730742241939; 
 Mon, 04 Nov 2024 09:44:01 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211318b562fsm40901385ad.169.2024.11.04.09.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 09:44:01 -0800 (PST)
Message-ID: <682ad778-e714-46f8-ba44-e0afdf6f69b4@ventanamicro.com>
Date: Mon, 4 Nov 2024 14:43:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Fix leak of reg list
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com
References: <20241104173551.125069-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241104173551.125069-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 11/4/24 2:35 PM, Andrew Jones wrote:
> Free the temporary register list.
> 
> Fixes: 608bdebb6075 ("target/riscv/kvm: support KVM_GET_REG_LIST")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cbda4596da73..effd8fed815d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1170,6 +1170,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
>       }
>   
>       kvm_riscv_check_sbi_dbcn_support(cpu, kvmcpu, reglist);
> +
> +    g_free(reglist);
>   }
>   
>   static void riscv_init_kvm_registers(Object *cpu_obj)

