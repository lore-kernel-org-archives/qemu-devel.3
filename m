Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDD6CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hW6-0000iN-3S; Mon, 22 Sep 2025 10:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hVz-0000hh-6E
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:27:39 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0hVs-00087Q-TP
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:27:38 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b5516255bedso2358448a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758551249; x=1759156049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0kGRndg9C9jpLmtjmA+vu1Kotb6RjI+4Eysy1yo7HGI=;
 b=VuXKABUjEN6IcZADA5xbOeZMJEHjDy29CmpC2s+aJMK6VBpZC2V7nMbbAkYlpdCAw4
 QhUgs7oGdRvkMbBH1oyGiPOSfTT0UyKzWjvsATfSlyqXDwrUZMnBYxaQRHh3H9Wa1psb
 +dfq1vxTEy51QjEQurO1uMQSmJPbVb/B+C1hE0BwFGsKTAuhh5iv8SCyEf3yBzZV7KXG
 PZR6reuCp4ojO5bQf07TJU8u9Wt0u5KCr7wbxstRo2vzQEHhwQwDYI0k5a+KzqavIJ2u
 MYwjXuDQ1uRu/S3qZQyCZtXV3lMwkg6QY01CiPss7G6tnap/ouJD+Ae0Wca1C+JcT03w
 uuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551249; x=1759156049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0kGRndg9C9jpLmtjmA+vu1Kotb6RjI+4Eysy1yo7HGI=;
 b=fyEBXJAH/8wAIzBY0gRRnjwGJrOl3rDm/Ri/r+EFx7ZVJTiqbroWwB9rHtNyUNNfB4
 AnhgApb87FnOatoVPsSo5Vp4UcJqeF/VfFCb9zYOv+GVcGvXEUXtqww2Enl1Cn3tLTp2
 Aiki8wD3oMaB2GukVaWFXVQui62S02GbM+1MD898BesNmLOhTBXkbOVAQty75AEoZ6kM
 JldG67LsiRlc/GtOe+wojslpq9JUz9Bu1KHY/3rMLHWBVOmlV4gKq9IfmCJqLWvQz6+U
 8XR+BxdrHKUc68v+KopGhkU2xw8WShuw0uNxSxsKrC2CF1TiRb+PoNAWTOIAsc++9qm1
 NdTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUn3Wp9GhsMQGqiUZ4Piqd++Kn2nfRjJ0l/Ega0XIp16Yff5JM6byolwrwrepfp26Ysm8b9qa+AjIa@nongnu.org
X-Gm-Message-State: AOJu0YwsD3rrS+UdlFdZ5iaTu5NaLKkO7bd1CT7HrmWiKihG8tLIFxg1
 Z2ZE8n+kjV3JwYnL5NbP4cVHRq5+cATcbs5zLZbxm5M6MAMkla3yAwedqlIvLD13LB5n2bBFNpF
 oxO7a
X-Gm-Gg: ASbGncv4D+2bXHY+uIM/v/OoRHdzikAuL0xVCHKgumVX+r4Xrjpi5fO7qG6q/j4lF5i
 q6RcYLZ/540xRwvZZBZztk1eKPA/F+dzJbwQRPepUHatk122SpL2BfmWsDjGAQ2fz+m77Bj5pOj
 6zi6BeopzpeQu6JVoLu+ojDVjvbMrx7OQ2kjGi53Jn+LYdESpPk2wgIMNZ4UbgT/HsLn4tSkl+/
 5fzmwobwwlwn49UOYT760jkPTJfmYKViF94sFS78+NOA4IPYoFLqH0ET8YMGSzxVEfi61KlH1OQ
 Bjf/4wcFm+S9Wx0Q1f4qP4LqcnKqAZpNzMTPBtgwy8Qn3e2TjPxcNKRmRVcwbydS6OLWZrgZwVR
 hghnKpYO+nK9+ZdMMG7AcWM7uVyGO2SE/xRX2
X-Google-Smtp-Source: AGHT+IHlMfEtxe2DcZfF7LfEDn5a1pJ81BfHgqxQf1JtLMnF4bJOwcbIj18OotCncmMgew23Fyfkzw==
X-Received: by 2002:a17:90b:2c8f:b0:32e:96b1:fb70 with SMTP id
 98e67ed59e1d1-33098004a50mr16730947a91.12.1758551249294; 
 Mon, 22 Sep 2025 07:27:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33060619253sm13528553a91.4.2025.09.22.07.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 07:27:28 -0700 (PDT)
Message-ID: <284089de-899c-40d6-b154-dfbfa699c387@linaro.org>
Date: Mon, 22 Sep 2025 07:27:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/loongarch: Set function
 loongarch_cpu_has_work() as public
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250922073400.1308169-1-maobibo@loongson.cn>
 <20250922073400.1308169-3-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250922073400.1308169-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/22/25 00:33, Bibo Mao wrote:
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -478,6 +478,9 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
>       }
>   }
>   
> +bool loongarch_cpu_has_work(CPUState *cs);
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +
>   /*
>    * LoongArch CPUs hardware flags.
>    */

Better to declare these in internals.h.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

