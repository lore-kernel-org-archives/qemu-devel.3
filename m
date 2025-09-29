Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28DBCAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mc7-0003iV-Ry; Mon, 29 Sep 2025 18:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mc6-0003i9-At
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:44:58 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mc3-0006ZY-QW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:44:58 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso5083392a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759185893; x=1759790693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ybfJb5nqPb52rQIWYkX7tyPYijpeI3NKeR/Gahp2SwQ=;
 b=chfGbL5kIVmm8PCB7NABT7w0/vui3g0Y64PbX7ePj6M7Vp2qx/zXDiHWy2CxGtmXYM
 74PSgRx/LnBTAq2+Cns9QxFRUzYaDvMrXrjwJxEURBibzsCdIRY2h83e3lHxr1FYnlwD
 QEfmrTTDMyGdwmLNtD3Kcy7naP8Pd6Bn5RfhXom5wNB5CMwZlPDEQ72uWrf6rTSdPsvO
 LTQtZWbMq5DTHwYPFRQG6EovpkDNKBQVUCrAfGyoFvw5qWtXERZl6KY7oj2fqwq/oo4M
 TNwR65oBzuYFcfeMwTCDkIUdzy1/iSR8O2GDaVaMDpT3HLmXLNTDFIIyhLF3/1f7DVW7
 7flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759185893; x=1759790693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybfJb5nqPb52rQIWYkX7tyPYijpeI3NKeR/Gahp2SwQ=;
 b=TwQtpAXbuB4YO0BKyp1sp1/b92GHdDhI8NrfpiP88qrU12v3sZAepUfqMf6MEE+YHK
 RO2+iFdpanRBXxJqrAU56Rq4Y7Y49rFJwZP9yPkAxTwepHm65ptcM8f1a25FTBxf1lUa
 BFPtRMNAsOC2FRvPRNpzGXgkFbOUZ7navz4rlywytb97CNsIAvZsSVC/uTEyfxuSd6j7
 BnqyB3IYUVOcUv1wdEqW09Ib7RKWA8Yv7RooxGipuGlI2he0Ovaau1Qg3GoYSOT4bsRx
 2fbvtmqXAlD4KbTJ+xHckpYAZRfWCYY9ioOKeypma9kEn8pA42PG9gtM0pkYfGRyw+CZ
 N2rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo+svTho1/tJ50lLtBEAwLqXw6r6DZPv2mGG6vCC9rEi8ZePSUacdDucVx98ZzHrkmVvWg4lkF47go@nongnu.org
X-Gm-Message-State: AOJu0YxZUYfJT+Nl1GxMEb1gcKJgbAZ78Ju7dfrfAZ/aABrwfMiaqXt0
 Da9WYaI0BXDoyGIFwYjyJqO+WbotEOknc+6kZIBygnMypSllGZaIdnvx3wNlOnPRohU=
X-Gm-Gg: ASbGncv9Mvv/x6Pjk+uVGnGmfTlyX1s8jwWokm46OmyziGH9PTTB+1OObaB6a51sQqa
 N072GGBer0hnVRhZA+z0VoAy8geAbdtsgOBXMfxnAN+Nv03O/kBVGU815lRvgicZs1JLn5cTKTf
 skPvcMZtyZsJOu9CsHgUNHU7q9gctLxpTRsxmKFg7GY3JdpitTDV1Hbmcg2OFUSrIJWjlwmSTE2
 ExvxtneNsDpkgg7bCcHjmQxjPXSY3lbCk3OQUf7WfLi3bKHAnaubT1GLF2RJzPf5uGd+pZUCXSr
 esz6IY/eh1jUIK7ieEkhwOIN90nn8OxNDH/RrAMY7sGen6kHCfitXpVliNzFU+aYMQZXjaCcpg3
 Tz7VUoPP/BfPxJGjFni/yHH6zUreO7GBWDL0=
X-Google-Smtp-Source: AGHT+IHk1PGCJ5wR8wnoYii/Hvj2a2AahSgA+aGGRqNkky4JCsQ/lHGOBgt++CDydyUqN7tKaalNdQ==
X-Received: by 2002:a17:903:228e:b0:275:b1cf:6ddc with SMTP id
 d9443c01a7336-27ed49b86c6mr252601615ad.5.1759185893057; 
 Mon, 29 Sep 2025 15:44:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-338386f5786sm2376187a91.1.2025.09.29.15.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 15:44:52 -0700 (PDT)
Message-ID: <427722cf-c91c-4c2f-b5a0-8d127c3dddea@linaro.org>
Date: Mon, 29 Sep 2025 15:44:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/34] single-binary: Make riscv cpu.h target
 independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20250924072124.6493-1-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250924072124.6493-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

Hi Anton,

thanks for joining the single-binary effort.
You didn't start with the easiest part :).

On 9/24/25 12:20 AM, Anton Johansson wrote:
> Hi,
> 
> this is a first patchset moving towards single-binary support for riscv.
> Additional patchsets for hw/ and target/ are based on this one so it's
> best to make sure the approach taken is ok.  Most patches in this set
> concern fields in CPUArchState which are either widened (usually to
> uint64_t) or fixed to a smaller size which handles all use cases.
> 
> General purpose registers and fields mapped to TCG are dealt with by
> widening the type and applying an offset to tcg_global_mem_new() to
> correctly handle 32-bit targets on big endian hosts.
> 
> Quick question to correct my understanding. AFAICT riscv64-softmmu is a
> superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
> concerning single-binary do we for the time being only need to support
> riscv64-softmmu?
>

Changes to riscv64 will probably impact riscv32 anyway, as they have 
files in common (that's the tricky part of single binary porting effort).

A possible solution to this could be to duplicate (manually) compilation 
units between 32 and 64 bits variants, but I don't think it's worth the 
effort. It's better to do the change for all variants for a given 
architecture so all the code is cleaned for a given base architecture.

> Let me know what you think of the direction taken here and if you would
> prefer something else.
> 

Overall, most of the changes you do are correct, widening types, and 
combining low/high part in single 64 bits integer. For this last part, 
I'll let Riscv maintainers decide if they agree with the approach.

However, the main issue is that changing size impacts migration 
(VMSTATE_UINT.*), which would suddenly create a breaking change when 
importing 32 bits machines.

We have two ways to deal with it:
1. call it a day and make a breaking change.
On Arm side, we were lucky to not have cpu structure defined with any 
target type, so the problem was not found yet. But we observed that 
other architectures would need a solution.
If Riscv maintainers are ok for a breaking change, this is the 
easiest/fastest solution.

2. introduce a backward compatibility change, to selectively import size 
if we import from a past QEMU version. In this case, we would keep the 
VMSTATE_UINTTL but adapt it to do the right thing when restoring, either 
writing 32 or 64 bits.
I didn't dive deep enough in migration restore code to see if it's 
easily doable, or not.

Let's see what people think of 1. first. On arm, this is very 
conservative and migration backward compatibility has to work anyway. 
Maybe it's more relaxed for riscv.

> Anton Johansson (34):
>    target/riscv: Use 32 bits for misa extensions
>    target/riscv: Fix size of trivial CPUArchState fields
>    target/riscv: Fix size of mcause
>    target/riscv: Fix size of mhartid
>    target/riscv: Bugfix riscv_pmu_ctr_get_fixed_counters_val()
>    target/riscv: Combine mhpmevent and mhpmeventh
>    target/riscv: Combine mcyclecfg and mcyclecfgh
>    target/riscv: Combine minstretcfg and minstretcfgh
>    target/riscv: Combine mhpmcounter and mhpmcounterh
>    target/riscv: Fix size of gpr and gprh
>    target/riscv: Fix size of vector CSRs
>    target/riscv: Fix size of pc, load_[val|res]
>    target/riscv: Fix size of frm and fflags
>    target/riscv: Fix size of badaddr and bins
>    target/riscv: Fix size of guest_phys_fault_addr
>    target/riscv: Fix size of priv_ver and vext_ver
>    target/riscv: Fix size of retxh
>    target/riscv: Fix size of ssp
>    target/riscv: Fix size of excp_uw2
>    target/riscv: Fix size of sw_check_code
>    target/riscv: Fix size of priv
>    target/riscv: Fix size of gei fields
>    target/riscv: Fix size of [m|s|vs]iselect fields
>    target/riscv: Fix arguments to board IMSIC emulation callbacks
>    target/riscv: Fix size of irq_overflow_left
>    target/riscv: Indent PMUFixedCtrState correctly
>    target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
>    target/riscv: Replace target_ulong in riscv_ctr_add_entry()
>    target/riscv: Fix size of trigger data
>    target/riscv: Fix size of mseccfg
>    target/riscv: Move debug.h include away from cpu.h
>    target/riscv: Move CSR declarations to separate csr.h header
>    target/riscv: Introduce externally facing CSR access functions
>    target/riscv: Make pmp.h target_ulong agnostic
> 
>   target/riscv/cpu.h                            | 341 +++++++-----------
>   target/riscv/csr.h                            |  93 +++++
>   target/riscv/debug.h                          |   2 -
>   target/riscv/pmp.h                            |  20 +-
>   hw/intc/riscv_imsic.c                         |  34 +-
>   hw/riscv/riscv_hart.c                         |   7 +-
>   linux-user/riscv/signal.c                     |   5 +-
>   target/riscv/cpu.c                            |  11 +-
>   target/riscv/cpu_helper.c                     |  37 +-
>   target/riscv/csr.c                            | 284 ++++++++-------
>   target/riscv/debug.c                          |   1 +
>   target/riscv/fpu_helper.c                     |   6 +-
>   target/riscv/gdbstub.c                        |   1 +
>   target/riscv/kvm/kvm-cpu.c                    |   1 +
>   target/riscv/machine.c                        | 133 ++++---
>   target/riscv/op_helper.c                      |   1 +
>   target/riscv/pmp.c                            |  13 +-
>   target/riscv/pmu.c                            | 150 ++------
>   target/riscv/tcg/tcg-cpu.c                    |   3 +-
>   target/riscv/th_csr.c                         |   1 +
>   target/riscv/translate.c                      |  53 ++-
>   target/riscv/vector_helper.c                  |  22 +-
>   .../riscv/insn_trans/trans_privileged.c.inc   |   2 +-
>   target/riscv/insn_trans/trans_rvi.c.inc       |  16 +-
>   target/riscv/insn_trans/trans_rvm.c.inc       |  16 +-
>   target/riscv/insn_trans/trans_rvv.c.inc       |  22 +-
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  22 +-
>   27 files changed, 644 insertions(+), 653 deletions(-)
>   create mode 100644 target/riscv/csr.h
> 

Thanks,
Pierrick

