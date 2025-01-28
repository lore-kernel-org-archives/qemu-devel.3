Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8934C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgE5-0005bn-7D; Tue, 28 Jan 2025 02:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcgE3-0005bI-IK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 02:41:35 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcgE1-00055l-3n
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 02:41:34 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so4187402f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 23:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738050091; x=1738654891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VrStTQmPb4a/vFdqlc3XFm4I7dpbn7TOj1YpZ4gHcTY=;
 b=NXDey/2wjejbfgR0g/5my0OPkspDsYINkTiF2zV22eZaVwxsTV3/JK2x5yrP/zNMaA
 kPPeXBrjT7882s4waO9yyVfWq1Uj8365ReJ+In8L0XHInDLa/0LkfiQJeOFQDkZLYziR
 50NWeNKK09L9QulHMHQqvKUw8IKPh1emmb7T9PnWwniZmTfZukYK8Pq+tTyoGeUaVATO
 KMjHaqacKs6Z/4XbaoM3gRmbhclv+Q/dFsN/l4P8AZAXisUQojIRMpA/vWpi6OT6b1G3
 gXcUEv3kKsTfABMhrSAGb1CGyyIDpDCrVdnenOD0dRMPfaoKSZb94YFQvdMa6ZZpH6af
 GYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738050091; x=1738654891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VrStTQmPb4a/vFdqlc3XFm4I7dpbn7TOj1YpZ4gHcTY=;
 b=F49r3kzjp+uVL2oi1OyH2IXB9rhWNsLFxt/W3z9QGmzxrLBLe5N46tbk2K8c+tw/t2
 YVqAGA5dhcOQH1ZRDjqAtLo8yvzv9U3NDIiTxG4XcmkVMZ9hOIOAfOYqcjDY4YhGfZIq
 oLZZp1Z0HyYOoP2/JDyZAKL3hT9qFLUCR2R3LRhyPs2G6i5Yqa7E7AraHVjcsuMggQa2
 lbnuXCoZDz36GfvZMGTHVZKvhKr4+5P+jMuTvuKjLZopFXH5deHilQNBUqfoU28M035K
 phutvPMzd0xBex7NrUa9RUPH/n5110plp1N0T67yNnjEKgD/Zd5MCqHBLAnIdL47LkWz
 BKoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcE9R4urA0T4E5wiafMiCqDxKa0Ko32wu1sgJowz4TXO+LD2qpbkFC6oousVW9TUOAfWKNVCQiACHJ@nongnu.org
X-Gm-Message-State: AOJu0YyLMEc8jo4qvoojNkyWebETUzSZVxWAatxGYXmBYcD9nh7mxLlf
 cc+U6guKNZQZKDKteX9YL85zJNMFooFbEqxFvv2U0N67Kx3CIPgPBH+e9rgjVVA=
X-Gm-Gg: ASbGncueWsgtQ0CAERQkrb/2DZHGZtPTSmF1Z3VdYgdfkHYR/n6O7eEwED8on7ADwNO
 D1NvjFv5hGLpomS46AFTeZzZcdJWTLfKy7LGHlj5Zyxl3CwBivuc7L4uOe8Je7BR5wUpqBheG0s
 XaeMUjxz10QBR5zOZUYN6cgR9IZSNLmCXgMpE51a+eQyYpEahU4qdOusIXeNBDCZI47CZhtdsxS
 M1u0ylp0bZ0a26mpFJ+6ASOeXi70p0ZOOsCcXoqmjeaMrSufDToDT6CaBMNFy82ITE7HYnZk2Y6
 z5rgy+0E90FqKYiu7BmLtORgjoPezexvzCVTDdUpt0aHOvhJpwjit5/riic=
X-Google-Smtp-Source: AGHT+IESRPyvVeqvcTHHp6OIuBiE18NZurkzjiFJaRoS6WfR2GExDxd7UEsPZZ3eZqH3x/uygUsJfQ==
X-Received: by 2002:a05:6000:1a87:b0:38b:da31:3e3b with SMTP id
 ffacd0b85a97d-38bf5678466mr39900548f8f.3.1738050090807; 
 Mon, 27 Jan 2025 23:41:30 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1766d8sm13715088f8f.14.2025.01.27.23.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 23:41:30 -0800 (PST)
Message-ID: <171ef7fb-88b0-4db6-94f2-dbe16676f64d@linaro.org>
Date: Tue, 28 Jan 2025 08:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] target/ppc: Move ppc_ldl_code() to
 tcg-excp_helper.c
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-6-philmd@linaro.org>
 <34b75938-ce88-47d5-ab86-715e50de4cb8@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <34b75938-ce88-47d5-ab86-715e50de4cb8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/1/25 07:13, Harsh Prateek Bora wrote:
> 
> 
> On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/excp_helper.c     | 21 ---------------------
>>   target/ppc/tcg-excp_helper.c | 18 ++++++++++++++++++
>>   2 files changed, 18 insertions(+), 21 deletions(-)
>>
> 
> This patch also needs to remove the function declaration introduced in 
> internal.h in patch 3.

No, it is still used in 2 distinct units:

$ git grep ppc_ldl_code a09cb1ead
a09cb1ead:target/ppc/excp_helper.c:1291:    return is_prefix_insn(env, 
ppc_ldl_code(env, env->nip));
a09cb1ead:target/ppc/excp_helper.c:1516:        uint32_t insn = 
ppc_ldl_code(env, env->nip);
a09cb1ead:target/ppc/excp_helper.c:1519:            uint32_t insn2 = 
ppc_ldl_code(env, env->nip + 4);
a09cb1ead:target/ppc/internal.h:271:uint32_t ppc_ldl_code(CPUArchState 
*env, target_ulong addr);
a09cb1ead:target/ppc/tcg-excp_helper.c:38:    insn = ppc_ldl_code(env, 
env->nip);
a09cb1ead:target/ppc/tcg-excp_helper.c:209:uint32_t 
ppc_ldl_code(CPUArchState *env, target_ulong addr)

> Otherwise,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks!

