Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABEEC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrIu-0007vv-TI; Wed, 21 Feb 2024 13:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcrIr-0007v8-9a
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:26:45 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcrIp-0004HW-53
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:26:44 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso5315885a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708539999; x=1709144799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5JhbzFWxHmHILiNel/9+wU2VgMZPucheU/HjlzzLBGc=;
 b=Uc60EGO8XXNDxC1vC3RCX4wi7TduPv4QEdZsNwQa8V7veTFgq4gOpQbfivCEHll9tI
 ITz28dy6DigEug/b115T0bI6a6dmfIL6Re9Li464SAY+YgD8gDpmKDGPoKC6N5DFntUb
 al4PnHqQBmmY2BddtATZmapRdOIGqHgC+fdg4SSs/UtRtaeezh4kaPCnyyQL5m7WrhvU
 z+Tbazq6MTq6iiRo8ExygSj1TXwph8OC2COQ+9o1+bZyeOkgC1ByNCsT06BVVfoJ+6Kf
 Wnt2ml+wpzJFlQTW1VjIveK95pes2i3p323Xq3t8jV/G9k3UndsKCOZyemQXitZPpdfi
 sYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539999; x=1709144799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JhbzFWxHmHILiNel/9+wU2VgMZPucheU/HjlzzLBGc=;
 b=lX/Astw+AhNb6svPW8/0EsGlbMuy9DeklYRpAFJpEFF9ySA17Tk64IZkkXXIqNpOSZ
 OUEElpb8E7DFX/SUZoWnl9RKJGVLUEFwi4dVx5F/vzlRQ4itiPeIbWY/p4wrRMbtHGMC
 /xFhTl3g3ngK8CwyNpOLfnpopkhXax5InK2GK6ksX7A5VvWnkHt1q26XZ+R1KIqVUanY
 tWAzTFs/HErZRZCvYEyR1z0yvXGr51MIHpBUjWoaLMDa8A+SPyqoiLNu68S+o8BZt8+F
 BsXFN0u7TU0nJz3fHu3Mh9pSEptoV0oF2ReboOvlRSo6bnRuOz4k2nRQlh5WO3Rb5qVL
 CECg==
X-Gm-Message-State: AOJu0YzI6ZJd4rGsfYtRM9OfeT8kE7DDHAe7aZNCQy0UfHwLV8N+oMBF
 ZlVHAyTXkKy1m0hmwoCK+DcG0NUdme3TVD7CzE1gJkDxxugReNJC8v0PXdwjzgY=
X-Google-Smtp-Source: AGHT+IE4Yf6LMBhZoZFF3UVUrH1Y9mrB8eamGwA5xUefQ9A+JQmaMVRsi9fKexQA3DHe31Jo3FKHaQ==
X-Received: by 2002:a05:6a20:93aa:b0:1a0:7fa2:305 with SMTP id
 x42-20020a056a2093aa00b001a07fa20305mr20569579pzh.47.1708539998955; 
 Wed, 21 Feb 2024 10:26:38 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a62f243000000b006e45e20e3ecsm6784003pfl.60.2024.02.21.10.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 10:26:38 -0800 (PST)
Message-ID: <de514d34-b0e3-4776-890d-3d5dc738785c@ventanamicro.com>
Date: Wed, 21 Feb 2024 15:26:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] Add Counter delegation ISA extension support
Content-Language: en-US
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com, Andrew Jones <ajones@ventanamicro.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com>
 <CAHBxVyEnRcvB5iGDv8rE6oJ6L+yvM12ia+T0ZtsAx73TW5PfrQ@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHBxVyEnRcvB5iGDv8rE6oJ6L+yvM12ia+T0ZtsAx73TW5PfrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/21/24 14:06, Atish Kumar Patra wrote:
> 
> 
> On Wed, Feb 21, 2024 at 6:58 AM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> 
>     Hi Atish,
> 
>     This series and its dependency, which I assume it's
> 
>     "[PATCH v4 0/5] Add ISA extension smcntrpmf support"
> 
>     Doesn't apply in neither master nor riscv-to-apply.next because of this patch:
> 
>     "target/riscv: Use RISCVException as return type for all csr ops"
> 
>     That changed some functions from 'int' to "RISCVException" type. The conflicts
>     from the v4 series are rather trivial but the conflicts for this RFC are annoying
>     to deal with. It would be better if you could re-send both series rebased with
>     the latest changes.
> 
> 
> I was waiting for Alistair's ACK on the smcntrpmf series as he had some comments. It looks like he is okay
> with the series now (no further questions).  Let me respin both the series.
> 
>     One more thing:
> 
>     On 2/16/24 21:01, Atish Patra wrote:
>      > This series adds the counter delegation extension support. The counter
>      > delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple ISA
>      > extensions.
>      >
>      > 1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
>      >     5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>      >     RISC-V CSR address space.
>      > 2. Smstateen: The stateen bit[60] controls the access to the registers
>      >     indirectly via the above indirect registers.
>      > 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
>      >
>      > The counter delegation extension allows Supervisor mode to program the
>      > hpmevent and hpmcounters directly without needing the assistance from the
>      > M-mode via SBI calls. This results in a faster perf profiling and very
>      > few traps. This extension also introduces a scountinhibit CSR which allows
>      > to stop/start any counter directly from the S-mode. As the counter
>      > delegation extension potentially can have more than 100 CSRs, the specificaiton
>      > leverages the indirect CSR extension to save the precious CSR address range.
>      >
>      > Due to the dependancy of these extensions, the following extensions must be
>      > enabled to use the counter delegation feature in S-mode.
>      >
>      > "smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"
>      >
>      > This makes the qemu command line quite tedious. In stead of that, I think we
>      > can enable these features by default if there is no objection.
> 
>     It wasn't need so far but, if needed, we can add specialized setters for extensions
>     that has multiple dependencies. Instead of the usual setter we would do something
>     like:
> 
>     cpu_set_ssccfg() {
> 
>           if (enabled) {
>               smstateen=true
>               sscofpmf=true
>               smcdeleg=true
>               smcsrind=true
>               sscsrind=true
>           }
>     }
> 
> 
>     The advantage is that this setter would also work for CPUs that doesn't inherit defaults,
>     like bare-cps and profile CPUs.
> 
> 
> Your suggested approach looks good to me. But I was asking about concerns about enabling these extensions
> by default rather than the actual mechanism to implement it. Few of the extensions listed here such as smstateen,smcsrind
> sscsrind are independent ISA extensions which are used for other ISA extensions as well.
> 
> It looks like you are okay with the use case also ?

I don't mind setting new defaults in rv64.

> 
>     That doesn't mean we can't add defaults for rv64, but for this particular case I wonder if
>     the 'max' CPU wouldn't be better.
> 
> 
> Not sure what you mean here. What does 'max' cpu have to do with pmu extensions ?


Save a few exceptions, all the extensions declared in riscv_cpu_extensions[]
will be enabled in the 'max' CPU, regardless of their default value for the
rv64 CPU (see riscv_init_max_cpu_extensions() in tcg-cpu.c).

If we count both the v4 and this RFC, the following extensions were added in
riscv_cpu_extensions[]:

+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),

+    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
+    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),

+    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
+    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),


All of them will be enabled by default in the 'max' CPU.

This is what I was referring to. We can just use the 'max' CPU and don't worry about
enabling defaults in rv64.


Thanks,

Daniel

> 
> 
>     Thanks,
> 
> 
>     Daniel
> 
>      >
>      > The first 2 patches decouple the indirect CSR usage from AIA implementation
>      > while patch3 adds stateen bits validation for AIA.
>      > The PATCH4 implements indirect CSR extensions while remaining patches
>      > implement the counter delegation extensions.
>      >
>      > The Qemu patches can be found here:
>      > https://github.com/atishp04/qemu/tree/counter_delegation_rfc <https://github.com/atishp04/qemu/tree/counter_delegation_rfc>
>      >
>      > The opensbi patch can be found here:
>      > https://github.com/atishp04/opensbi/tree/counter_delegation_v1 <https://github.com/atishp04/opensbi/tree/counter_delegation_v1>
>      >
>      > The Linux kernel patches can be found here:
>      > https://github.com/atishp04/linux/tree/counter_delegation_rfc <https://github.com/atishp04/linux/tree/counter_delegation_rfc>
>      >
>      > [1] https://github.com/riscv/riscv-indirect-csr-access <https://github.com/riscv/riscv-indirect-csr-access>
>      > [2] https://github.com/riscv/riscv-smcdeleg-ssccfg <https://github.com/riscv/riscv-smcdeleg-ssccfg>
>      >
>      > Atish Patra (1):
>      > target/riscv: Enable S*stateen bits for AIA
>      >
>      > Kaiwen Xue (7):
>      > target/riscv: Add properties for Indirect CSR Access extension
>      > target/riscv: Decouple AIA processing from xiselect and xireg
>      > target/riscv: Support generic CSR indirect access
>      > target/riscv: Add smcdeleg/ssccfg properties
>      > target/riscv: Add counter delegation definitions
>      > target/riscv: Add select value range check for counter delegation
>      > target/riscv: Add counter delegation/configuration support
>      >
>      > target/riscv/cpu.c      |   8 +
>      > target/riscv/cpu.h      |   1 +
>      > target/riscv/cpu_bits.h |  34 +-
>      > target/riscv/cpu_cfg.h  |   4 +
>      > target/riscv/csr.c      | 713 +++++++++++++++++++++++++++++++++++++---
>      > target/riscv/machine.c  |   1 +
>      > 6 files changed, 722 insertions(+), 39 deletions(-)
>      >
>      > --
>      > 2.34.1
>      >
> 

