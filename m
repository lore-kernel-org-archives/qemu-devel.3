Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB651CFC60D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 07:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szAGk-0003wp-1z; Fri, 11 Oct 2024 03:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1szAGi-0003wg-4P
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 03:41:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1szAGf-0007mI-P8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 03:40:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so819321f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728632455; x=1729237255;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mDip/0ow4XhgssxP8kgnUXoLAwS2RmrmHC/lIU88cg=;
 b=Hcdiam+Uq5wObpnSYquq9l9L5cLIlxwL0t1LoqAIp8t6YqXVqwOsEJaFu7fpXWRn7a
 14KTa/8la7x+gI46Dn20DFWMrRi54lzJSFlJyvTPfO+zd8kuaM0vTurHylBrKpGORlul
 AUzywDUR+jH5ThopCwyYe+h3vNhQ3KpWqe8XcWgjgoiEUejpLSDoMVpBeVoKalloV60M
 UBApx4aJgIqTkWaOfTJzijhr2pWjtgVsfXEpOd8D2L2/end+j1y0UsdjqPM9XeweldCS
 LHcDA6Wu79R//ldgNmr6C26e12qDeTex8z/lmv2GXSV6b6o88y9xHXUAWJICn/Xi6c3p
 2smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728632455; x=1729237255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mDip/0ow4XhgssxP8kgnUXoLAwS2RmrmHC/lIU88cg=;
 b=qT9vtqRzNwmHUegEoQltRFLW9PPgpEcTsirx3dI8roTHL+IffWkDcckD8J3YFgHPMH
 bgdgEbjlzHunmqZpp1AtXPqKqOn4iNZWCF9VpyDrVD0n6SV5TnmS/3HAp5iwA2n2xDhj
 RHiwRg3BCqX+3cn3Wouw0GySWkYSfB6X5cFZP/4EhqRaLOLE6rM2FFxvxY+P2qHYnD6t
 wrJjowFhF76y3jL1fqpdYI36FK/jnW6D1WrK2SLjY16oVHAgtQ/6EK7YN1E9Xuw1Vz/o
 hR6xjCNV8Nr45XrDCQ+EDDUJChBlQcWoe++6U4W1EH37bqqwKJxD7Od6/6ySzDb35Lz/
 ZkBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCANyIE5t/u9GsQLzrrebCtnm6QudTquiGCvsZq2o+0JIrtYWYInEKYGNJENC4JFO1oe2iRe33GBBH@nongnu.org
X-Gm-Message-State: AOJu0YwxUb1t+FsjTcbq88g/LvdJgg3M1a2Wgcu+GrzBNzrP5VlQvd9D
 7zQGKLLUC3aXUnDIFZIj94huomxwpY9VXMZM3njvhnNUDmT1Jvcv0aF2AQPTg0YkEsO1Ad661V1
 m
X-Google-Smtp-Source: AGHT+IGWo1yhhAqe+RwYPK8XY5kaHbyd0yk1WgppbPsNNXFObopaTKoNvzbdK4bKcuizfY3L7XSImw==
X-Received: by 2002:a05:6000:128f:b0:37d:364c:b410 with SMTP id
 ffacd0b85a97d-37d55304616mr1272751f8f.33.1728632455264; 
 Fri, 11 Oct 2024 00:40:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6bcf04sm3260388f8f.33.2024.10.11.00.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 00:40:54 -0700 (PDT)
Message-ID: <1c90b0b6-b8c7-48bd-b31b-961080210231@rivosinc.com>
Date: Fri, 11 Oct 2024 09:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] target/riscv: Add Smdbltrp CSRs handling
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue
 <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240925115808.77874-1-cleger@rivosinc.com>
 <20240925115808.77874-6-cleger@rivosinc.com>
 <CAKmqyKP0ZX7C+grozW2y=YGeQAJZ0Thm5L7Q=GwiCQ=4-Dz2=A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAKmqyKP0ZX7C+grozW2y=YGeQAJZ0Thm5L7Q=GwiCQ=4-Dz2=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 11/10/2024 05:30, Alistair Francis wrote:
> On Wed, Sep 25, 2024 at 10:02 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  target/riscv/cpu_bits.h |  1 +
>>  target/riscv/cpu_cfg.h  |  1 +
>>  target/riscv/csr.c      | 15 +++++++++++++++
>>  3 files changed, 17 insertions(+)
>>
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index 5557a86348..62bab1bf55 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -561,6 +561,7 @@
>>  #define MSTATUS_SDT         0x01000000
>>  #define MSTATUS_GVA         0x4000000000ULL
>>  #define MSTATUS_MPV         0x8000000000ULL
>> +#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
>>
>>  #define MSTATUS64_UXL       0x0000000300000000ULL
>>  #define MSTATUS64_SXL       0x0000000C00000000ULL
>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>> index dd804f95d4..4c4caa2b39 100644
>> --- a/target/riscv/cpu_cfg.h
>> +++ b/target/riscv/cpu_cfg.h
>> @@ -78,6 +78,7 @@ struct RISCVCPUConfig {
>>      bool ext_sstc;
>>      bool ext_smcntrpmf;
>>      bool ext_ssdbltrp;
>> +    bool ext_smdbltrp;
>>      bool ext_svadu;
>>      bool ext_svinval;
>>      bool ext_svnapot;
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index d8280ec956..cc1940447a 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -1617,6 +1617,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>>          }
>>      }
>>
>> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>> +        mask |= MSTATUS_MDT;
>> +        if ((val & MSTATUS_MDT) != 0) {
>> +            mstatus &= ~MSTATUS_MIE;
>> +            val &= ~MSTATUS_MIE;
>> +        }
>> +    }
> 
> This should also be set to 1 on reset

Yes, this is actually done in patch 7/8. I'll squash this change in this
commit

> 
> Alistair
> 
>> +
>>      if (xl != MXL_RV32 || env->debugger) {
>>          if (riscv_has_ext(env, RVH)) {
>>              mask |= MSTATUS_MPV | MSTATUS_GVA;
>> @@ -1655,6 +1663,13 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
>>      uint64_t valh = (uint64_t)val << 32;
>>      uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
>>
>> +    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>> +        mask |= MSTATUS_MDT;
>> +        if ((val & MSTATUS_MDT) != 0) {
>> +            env->mstatus &= ~MSTATUS_MIE;
>> +            val &= ~MSTATUS_MIE;
>> +        }
>> +    }
>>      env->mstatus = (env->mstatus & ~mask) | (valh & mask);
>>
>>      return RISCV_EXCP_NONE;
>> --
>> 2.45.2
>>
>>


