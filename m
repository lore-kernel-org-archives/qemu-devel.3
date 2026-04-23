Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AD3FDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG29s-0002QV-ME; Thu, 23 Apr 2026 18:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG29e-0002Pe-Ii
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:04:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG29c-0006uW-4T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:04:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2adff872068so35975995ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776981850; x=1777586650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQdVhx5EF9lFZuT5ogzLbNS2b/mvP/WVEFf78X/DycU=;
 b=xaQgFpUHQNpVALQ3voiEjd+a4pan8HPYR0XRW4RCoMP1PxA7wpGR4m/j5HxDeRy8Ys
 S3pOzbTVbuZEijF3Az1TtwBjz/9dy272W7CSm605g7emSzmYhfam7Qzw/2WtpuXCHMcs
 JghSloF0VuteMGAUmX04lW+DbKiCob9X45ghGbxDmq28LO7t/iEwdHahzpaosmBbOc90
 lEtSF45b7A0sQCIbXLwaM8OftJIz10/KnKHyM/DAxv8fPe6wL3QAcJq/mneUUa4h2s7J
 bFYjZIE6Tns3UMQNkl1eE8qtlGH3683NOYCB40xC1wPXI1ZJMF2j4/37pdP4wZNP3oXv
 hl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776981850; x=1777586650;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQdVhx5EF9lFZuT5ogzLbNS2b/mvP/WVEFf78X/DycU=;
 b=iQAnaPBnni5R14XlSs/XWFdIVfD+CsC9dkXZ6HCPXjEde+1N1cF7QWNlo8ba7JFUUy
 Z8AzSQB05yfpLPp6Vd6oRJYn5DzjF/3G5+YE+Nxrk1L1/DsV/QklZhFq2WyuRBck/f89
 I0d+JGDRng8OwsvXrs4NxJPw17FaoDFq2sbOfaP3p4Iwy2Gdw5aH3iZ4VJbtSucdVZmo
 5SbYCNvI556l6XdeYhCuLoBYeYc9kN2SQCmGAkN22BLfBDooBFGnK9SDXYTzp1tf4y61
 PXvCbLthBNTvhC8zSNnCe6Bvwo9J3vgt+pnlUjvtBaATFh6Q/Qn34Pj2M+lyCHnRPRS1
 1oMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rYcoRRDLWQFFYphWIdOcsK2k2nTw3Frky0l5XrxZQlprhUUmrtrD+GTzhK0SciJSdHcVj+W1odNdP@nongnu.org
X-Gm-Message-State: AOJu0YzOry3+vaQB4ZlZ4LwONBP6PaIi7cI27u57xrUjzUVSLBaWlD9k
 W2JE+XvpI/RtvbjnLMvGU7hcJQHrJKCtZw35JTWPRLQhhPfuAX0ys18T+oHhJtvIIiQ=
X-Gm-Gg: AeBDietEvy0+e5Ax9p27IYD6dNF5cIAxgSuewHrx6t/oaVwVdtOA+qfECQgaZJH7l3v
 uMEYJa0DS5wlE18N7UMwr9KuyAEFSpxKOoARP5J0kXFE3YifHu/I36OUaTxwpLYFSjXxQaKSBjS
 6kBR6qhfJlyGQaRgASYVW87VD42ITDuwy2SUuLBzWwheDysQimEoVKO8Zmm+sO2p6Unp09V72o5
 BJcGZhpj1CAUsjDnTYK/uxGfXnAob2CoVyNgwNRX0kvUuxdlkzwUviBjZJyEkcbEBkat6T7F/i9
 3O71JkWjbZj4qJ8liRKj+j7Q2tTGnttdvnKs+LKK+t5BGQvstwYToLNHdw8ObmK5W7sp5SE7cUh
 mbb1/9oaEfnaC42kY0h+sAkC9kfbwxc7YxoQPv7sRcR4iT/2oJN9glK1frB+WnHMLHnjgJK2h+O
 C4IipB74NfEFgcTA4VKAxYt9kfYz96tpYUOwN+eXx9EcO1Cx8MSw==
X-Received: by 2002:a17:902:d505:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2b5f9d67569mr269337105ad.0.1776981850165; 
 Thu, 23 Apr 2026 15:04:10 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cf81sm199251665ad.43.2026.04.23.15.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:04:09 -0700 (PDT)
Message-ID: <f60b9d39-a9c9-47d8-ad3a-6315c7df9144@linaro.org>
Date: Fri, 24 Apr 2026 08:04:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: Leverage 128-bit vector type in VLL /
 VSTL opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org
References: <20260423141538.51583-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423141538.51583-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/24/26 00:15, Philippe Mathieu-Daudé wrote:
> --- a/target/s390x/tcg/vec_helper.c
> +++ b/target/s390x/tcg/vec_helper.c
> @@ -48,14 +48,12 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
>       MemOpIdx oi;
>   
>       if (likely(bytes >= 16)) {
> -        uint64_t t0, t1;
> +        Int128 t;
>   
> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
> -        t0 = cpu_ldq_mmu(env, addr, oi, ra);
> -        addr = wrap_address(env, addr + 8);
> -        t1 = cpu_ldq_mmu(env, addr, oi, ra);
> -        s390_vec_write_element64(v1, 0, t0);
> -        s390_vec_write_element64(v1, 1, t1);
> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
> +        addr = wrap_address(env, addr + 16);
> +        t = cpu_ld16_mmu(env, addr, oi, ra);
> +        s390_vec_write_element128(v1, t);
>       } else {
>           S390Vector tmp = {};
>   
> @@ -206,10 +204,9 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
>       probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>   
>       if (likely(bytes >= 16)) {
> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
> -        addr = wrap_address(env, addr + 8);
> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
> +        addr = wrap_address(env, addr + 16);
> +        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
>       } else {
>           oi = make_memop_idx(MO_8, mmu_idx);
>   

Bah, reviewed v1 before seeing v2.  Cut-and-paste:

The most important thing to consider when converting to 128-bit access is the atomicity, 
otherwise you can find yourself slowing down emulation when the host does not support 
atomic 128-bit access.

In this case, VLL (Vector Load with Length) loads n bytes, as can be seen with the 
fallback code just below.  So MO_ATOM_NONE is appropriate.  Similarly VSTL (Vector STore 
with Length).


r~

