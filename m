Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70717D59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6FO-0006Mb-Nx; Fri, 12 Dec 2025 11:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6FN-0006MJ-Gc
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:44:01 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU6FM-0004Tq-2s
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:44:01 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e7f68df436so1032141fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765557839; x=1766162639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JF+1MLSb2rLoFv/0j9h1zh1U1uUTJwVnagOsFBmTXMU=;
 b=ORfn1JETEJO5BAnlwZzwLD5ZEsinEfPm25akoCVeKbuJQDIQaYzrSTa+CkI2k+XPJJ
 BJnt4PRRBelU4us70IsNxsvaULzJOnoKOzlhJKLRM4TL8pGb0VJcLq13DhJ8m+KflI7A
 JlBdBqB7vkWYoyHLvafv9L9i172f8ni6lBXFA5crGXjEFeKdiq0E9UXPyMug9JcsNYUG
 sfhmUxif/W99I1hHgaAYQGQQX80tvDl8vZzy3qnwy8BEehF0MlHIzQHYEo22fr8YwaG7
 2Nq6quQYSrXygjzZKOj4ayvUnXs6OMato4E6NY8Z5IppAaGZ4orf7Qb+XK9hw9ppE8yL
 8O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765557839; x=1766162639;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JF+1MLSb2rLoFv/0j9h1zh1U1uUTJwVnagOsFBmTXMU=;
 b=fVFT8gfzr1H3dJAMQMO5kaRRTXeOlYsBVrgei8kHGsc8AskmEOOcaDW3HJs2lBbRtC
 mqMtzXTow8xUhCK0TmjMwOznl3OzByskj+YrEpsN4WVfhMjvnBIw507jbTlM3FtXV0Hb
 GrtiFeatx1qWw8xZ0+FIMMkHb0HxNlEZJL87ILfhIP1p5hkniPAJDmLx5MaO7HLF965p
 iK/USrDcEGfJcM2bRRLpjCyj0Kux02XXm3Dn3XaaWBOkjx/4tv31kBh/8C4fM7j9uOik
 Ge7aWDy0HZSa7i6iS091DnJE4ChpCw/uS1BmR0l25UH84w4Z1TZwcz57YwywHXPEPQlk
 /aHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS33kxE+F8wQhVn/XC3WzWGu3YNYFn1w8/E43BZGrhg7wpbNFFnVDsppwkfzdBRWpWbauQofNaezpl@nongnu.org
X-Gm-Message-State: AOJu0YzCEkAoOdBCUQmHQfC0q8H5bS2znQKfI5E4R7R8LgyU8BLVXCda
 Y+ySYvFWys95rWRpKu/eHFhQCOM4TiBhJ0/vrcNRCLMM/MVa6pIted3i3LBd1S25q9E=
X-Gm-Gg: AY/fxX7tqCIHh8TGDBMSdPQxz7gNkr6wtGYY9tLGVmQanEGEqZqFQFkbQnqceeplAVt
 SkKfKw14MDi8LFmaGVrkhOKYwYNBOF92f0uFpcBJVSMXv3ugjmkN4v7K8e8RBRXTo7KAEI9pz90
 pDYn3DNP1I+fouMMiJEVm92OWX9xuvuTYOMM7iKUOG5nfmGig162qIH0kJPOdfXGsbOADIN1pIP
 Xetu3C0XGbVNAPpH8pMRBt+pMlNzRAWqOxXVrz6jJIw/MgTqPunzkCIPnnuMHJ+boiuppgwt+9a
 UckiZgsbn9J8DkXYK3My7NsgZsr0gerAVFh7c0dVuiXSY6kYqS9GGsPMhXgIVBIc4UXgzj9OuRS
 70F7rSsXjrJW18+xb3/0Rm6LDmBa6iZTPlDURVD/DsuQ+VOz7jxpolOLCtJaQXmfb+qay56sUV7
 iDgtmyHU7urNhLP2pJeJPMAXr1A4jO
X-Google-Smtp-Source: AGHT+IGjQkHTO3MM0YD/sAtXFwRAp8C2Dz4LBJfu3IVSgRoVKvqjVHRAighW08+oL9FP/MT3C5O+SA==
X-Received: by 2002:a05:6871:79aa:b0:3e0:bd2c:f459 with SMTP id
 586e51a60fabf-3f5f95ba209mr1471128fac.12.1765557838597; 
 Fri, 12 Dec 2025 08:43:58 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5fe287f66sm1282767fac.1.2025.12.12.08.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:43:58 -0800 (PST)
Message-ID: <ee4ebd4e-b475-4d76-8fd2-8b04c30b183c@linaro.org>
Date: Fri, 12 Dec 2025 10:43:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 14/22] target/mips: Drop almask argument of
 HELPER_LD_ATOMIC() macro
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-15-philmd@linaro.org>
 <b0ea5035-bbbe-43cf-aa29-8585c2662070@linaro.org>
Content-Language: en-US
In-Reply-To: <b0ea5035-bbbe-43cf-aa29-8585c2662070@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 12/12/25 10:35, Richard Henderson wrote:
> On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
>> HELPER_LD_ATOMIC() now has a MemOpIdx, from which we
>> can extract the MemOp size. Use it to check the address
>> alignment.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/ldst_helper.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> True, but adding MO_ALIGN to the MemOpIdx (and thus to the MemOp) might be more useful, 
> allowing you to remove this explicit check.

Follow-up: You'd also reorg the function such that

      env->llval = cpu_load(env, arg, oi, GETPC());                             \
      env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
                                                   GETPC());                    \
      env->lladdr = arg;                                                        \
      return env->llval;                                                        \

so that lladdr and CP0_LLAddr do not get assigned when there is an alignment fault.

Also, the cpu_load will have either faulted, or pulled in the translation to CPUTLB.  You 
don't need the full PTW of cpu_mips_translate_address.  Using probe_access_full will 
quickly grab the CPUTLBEntryFull, from which phys_addr is your required value.


r~

