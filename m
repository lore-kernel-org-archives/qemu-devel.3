Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8306ACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoLV-0000Lx-Js; Mon, 20 Oct 2025 07:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoLT-0000Ko-El
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:46:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAoLP-0002Lw-V4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:46:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so39710515e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 04:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760960790; x=1761565590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zd3Py3ZEyCCWS6jCAb9KniwqiCwGr6TQzfHbb/y9fII=;
 b=cIGobOfrUUDeKFRBgclDLuIwcxJ+BlxOl063TUxW+lKGeenGl/6jkKpy9UGyaWZWd0
 YEySTItCG6ZkXjGAgqBgfGbDoz7PAz09ppb+NIdSjunUrW1p/yhG9bORDNN7dyF/ofBK
 ZflM0pWx1Kjv4/5HsYe6WWEV7uQKVEWN/7/FUVjr1DQwZNe5rkYwMNOq3eZx+/zAcQkK
 RBA0g9aAdCkm10aKMcM1N/N0ZE5BFoaYHRUHTXkskizuGR9FJL4flIdqyrvLtohSJGQz
 ry5rP8gXhP6MGsW1NawIUbjX2gYTUeNRGh7Z4gmEMQeLSP2eMaoF4MYAOAlz8bjJNXOL
 u7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760960790; x=1761565590;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zd3Py3ZEyCCWS6jCAb9KniwqiCwGr6TQzfHbb/y9fII=;
 b=CzbeTkQCFsIB0VeNJXdetmkxMFWt5R5kq/3RPfpT4n7IJ+inZec2/NkbNkm9uPm5zf
 U8i2bsPiho4tAUVZqxSNYkeBg6mrP+5dWNSZFx8VLhaTWKQLdcRZqu5rprfBMqtyygMp
 8gB1U//eHs9VmWY49sSgYWjI+O6upV0RWRRYbYw02FFEGOZYGGhxa90GAsw+9xi2V16U
 12tAu5HpMPtIbRRPn0mlW/UsLNV7twIB0ZxRsW7NgUwdFcfoSHxjmEyU1NFrcVbIyI0f
 KQ3z62jL1bxhzBB7GQs9ur1qTbNpPk+lugPxSmAFLA/mJ0XnzRYh+tlnLKMP3bOb2BhU
 8goQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfnfHSHdR7VBKL+kHLa09mdbyegzYZNPJPvJzcwj03MSzRm8iT2L2rcVeU39eRYe6Ynk2WXlhtFHPF@nongnu.org
X-Gm-Message-State: AOJu0Yxi+2lf9m/h/PQf5rdbxh2vyGjiaR7q9t+3yw+XTHBVY3hJkPKZ
 J68s5K0+6mZvz0QRO/XMPoA6MCU3zZBkEZHlNiV7mF8y2JidQJdP5/cTm/I2HVOev2qrhUKMb3W
 +ZQPH3Gg=
X-Gm-Gg: ASbGncvJlN0TNDlGNbF8WFCtQAOyRScJDaYM7Fx2nN5Mes7S7xskhkC4jlBF8hodm6H
 W+slVs4WU9U2Kf2vdCMWZDVLlJMiVrDoFlSfg08HQOFBsQcXv+eYgGHHKRk8vXAQZGu219YwBot
 2w8GGNQ/VfvcPAJB8y0NsddbuuGOjWf6mIxWPMPLLqQ6zjrp5UYlOtQTvTgUtIZoKfflMjWaYD6
 5lFpO8wnCNtF7r3etY6kxJvCkxg0ctgqncXssEN7DRQakJO8CY/JUouAKo2q4fSYb/TixVDTZtt
 9XwG9G+DRofnozT7qnRjrUEIq2IC6s7FKyZd4cPLkbAp1GP3gwv8vkKRzrSPYjsSVGfsOVDwMlm
 SQ/JUwKkbNmlyXzlUgQP5voOCti1fncC7Ue8xIPJls3n7HatPgiq7fKheayH0/h+Pe1npOMB49E
 7j8FmOwWCqwx1oVPX94I7qceZ5GYy0LlDIu0IDdl0V8eY2ZVa5Z341NnlXAybIqSrW
X-Google-Smtp-Source: AGHT+IGsi5vROoo4788dI/m8QV5scE6tw3ZBPEeovmHg/OnafJQNvOfbTclPpjY9Q67uwLftfq8aUA==
X-Received: by 2002:a05:600c:310e:b0:471:1645:458d with SMTP id
 5b1f17b1804b1-471179122ccmr85501375e9.20.1760960789786; 
 Mon, 20 Oct 2025 04:46:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710e8037aasm116627355e9.2.2025.10.20.04.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 04:46:29 -0700 (PDT)
Message-ID: <7cb7c2b8-2982-4107-a562-723dae7f5a48@linaro.org>
Date: Mon, 20 Oct 2025 13:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] target/ppc: refactor MMU helpers
Content-Language: en-US
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20250915124650.435777-1-d.zhebryakov@yandex.ru>
 <20250915124650.435777-3-d.zhebryakov@yandex.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250915124650.435777-3-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/9/25 14:46, Danila Zhebryakov wrote:
> Changed most of the PPC MMU helpers to take CPUTLBEntryFull* instead of pointers to real address, prot and size.
> This is needed at least for booke206 MMU to support LE bits (which need to set TLB_BSWAP in tlb_fill_flags), but also seems reasonable to do to other MMUs for consistency.
> This should not change any behavior at all.
> 
> Signed-off-by: Danila Zhebryakov <d.zhebryakov@yandex.ru>
> ---
>   target/ppc/internal.h    |  3 +-
>   target/ppc/mmu-booke.c   | 63 +++++++++++++++++----------------
>   target/ppc/mmu-booke.h   |  2 +-
>   target/ppc/mmu-hash32.c  | 30 +++++++++-------
>   target/ppc/mmu-hash32.h  |  3 +-
>   target/ppc/mmu-hash64.c  | 14 ++++----
>   target/ppc/mmu-hash64.h  |  2 +-
>   target/ppc/mmu-radix64.c | 20 +++++++----
>   target/ppc/mmu-radix64.h |  2 +-
>   target/ppc/mmu_common.c  | 75 ++++++++++++++++++++--------------------
>   target/ppc/mmu_helper.c  | 15 ++++----
>   11 files changed, 121 insertions(+), 108 deletions(-)


> @@ -851,19 +851,18 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>   hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>   {
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    hwaddr raddr;
> -    int s, p;
> +    CPUTLBEntryFull full;

I'm not convinced "full" is a good variable name (apply to
all changes).

Please zero-initialize with { }, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       /*
>        * Some MMUs have separate TLBs for code and data. If we only
>        * try an MMU_DATA_LOAD, we may not be able to read instructions
>        * mapped by code TLBs, so we also try a MMU_INST_FETCH.
>        */
> -    if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &raddr, &s, &p,
> +    if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &full,
>                     ppc_env_mmu_index(&cpu->env, false), false) ||
> -        ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
> +        ppc_xlate(cpu, addr, MMU_INST_FETCH, &full,
>                     ppc_env_mmu_index(&cpu->env, true), false)) {
> -        return raddr & TARGET_PAGE_MASK;
> +        return full.phys_addr & TARGET_PAGE_MASK;
>       }
>       return -1;
>   }


