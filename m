Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADCAF9D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCkZg-0006Ye-Fw; Tue, 14 Apr 2026 16:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1wCkZf-0006Y8-FY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:41:31 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1wCkZd-0000Pw-4n
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 16:41:31 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso73620576d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1776199286; x=1776804086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GBISdj1RjOfn+3GQ/SOAEzCnoHVkWuGBKNRu7yFEMAw=;
 b=R0ZcM4UDjrJNhkik8qjnfMoQxu6W6c+o/ilcWrKgOkIqDhCYiZFUdsDxM6ZCTGSQn0
 3SnPEZjpMHIU2FcLloG3OqQg6ftdd/+03STI10Qpko2uO3SHmHpMbISyJGAW1ZKjyVG0
 igPR7Hi/+nGnE5NvVsQPM9mQQOU2yTaDHvtcXIPg5bFk10J9wtNiHSwUyaZgdL3NLTgo
 D9rECHg77OOJq6AxUPUWNLqBohrzE8gX0I36nReHMnQ8WQWqT75FfVo6UFKJFrAzWE3B
 RmfoUfxUwHjWaq5+LFDOwJwV42/9BeptzjUHG5wIyNTC9QlVqLh5N7mVsd5YrVMdTX2O
 X6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776199286; x=1776804086;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBISdj1RjOfn+3GQ/SOAEzCnoHVkWuGBKNRu7yFEMAw=;
 b=edzF+xjcAOfk1XPi/gVwmeSoftkkcbbawMzVHELfYxzlTU9kCj6bvQKk4DEA60rOJf
 bbXvs1j8SDMx1GtK89uQqFgkhjSvqXaQcbopivP9S9/1rZ7kwg0gvbuJ/pUJnOUvcf2X
 wN3tszh96OZIDlYMyZtk23OJW5kwUnL1yY9YHVyVWF3rOuQ/7kBw5MDOn2c0QO3j/7MZ
 C6WHoybLiHsND6StLS5NukkQ+KBl3MLBuQa7tkU6s51x4KRtAu48nVbJfMFxi4q/ghGk
 BT3hvHJZTbBVlN1uvLASdM8a+BL9ZH3TCHDCiQ48V84DsZ51xlolIXQyc1nyH9BrCdR3
 Hq1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ99xc30ZKw1yTFqFrnoVuZTQd/jfVkcoceCaxOFU6QEEDbeV6dzrs9L+V8at8+yZ9aIB8iwERvF4TPK@nongnu.org
X-Gm-Message-State: AOJu0YySWgWlvG+gmHoLp5kl0hlQblDxGFIICv1fgH1opHF5DqjFkEne
 JoKGSvoLDb4H5jwpds2cfUGsdtuvxar+/de1Dv1Kro0goqhyU2PsHrzIXtP52fMO988=
X-Gm-Gg: AeBDievvkOPcaHmlK/pPZ37POiQ3y8XM8CLUbEn7A7ARwMtF675754MV9a7qMWZsIjo
 DbJX87P+nH1nQj6IcQGv5mQLDl00dHwEjdxWfVPlzDKKnt5zRFvl6SLLkqpnZ8zXdPQo0p6qFrQ
 fS7wbgZnzOhxvjnCF2FkDH/pC1gifua8EOXNfAvgPEyAE+Z5g9RlxrCZQ4nT2QUhVnMj4HmI+eW
 A7wRo3mrV6gJwN+osKNsSJEC36CalSnYvHxtt6TL31oFhhvGcRXJbHjuz1reKtSC+sQcSXwQPCP
 7EU7DqyoKLhQHe1odMm7kBIcWfJRWtWOEc4vmkBQYKAnODNzJnJ40Ij2eynr0EQ5hzZph9o7Rqh
 gcXE/H6wZnaGUvYhk4070TYmfzlei/TR7uCMYBe35Y/F5vBa5paOJ32uTdcVoey/jH6P/sjRQfh
 BQjhM7Js+9GGA0YuBbKRzLiV+E0rPPuVjLTlIuPejgTeYSG9Uwiw==
X-Received: by 2002:a05:6214:242a:b0:89c:da0c:1703 with SMTP id
 6a1803df08f44-8ac86163c43mr322529756d6.11.1776199285992; 
 Tue, 14 Apr 2026 13:41:25 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.35])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca9f7e0b0sm68414126d6.11.2026.04.14.13.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 13:41:25 -0700 (PDT)
Message-ID: <a1265369-a8ec-481c-a1ea-c3c45543d053@ventanamicro.com>
Date: Tue, 14 Apr 2026 17:41:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf30.google.com
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

Greetings,


Seems like we can queue this up for the next release.  Maybe a rebase + resend
is in order to address Chao's comments.


Thanks,
Daniel




On 3/4/2026 10:39 AM, Max Chou wrote:
> This patchset adds support for the RISC-V Zvfofp8min and Zvfofp4min isa
> extensions that provide conversion operations for OCP FP8/FP4 formats.
> 
> * Zvfofp8min (Version 0.2.1):
>    The Zvfofp8min extension provides minimal vector conversion support
>    for OFP8 formats. It requires the Zve32f extension and leverages the
>    altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>    E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
>    - Canonical NaN for both E4M3 and E5M2 is 0x7f
>    - All NaNs are treated as quiet NaNs
>    Instructions added/extended:
>    - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
>    - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
>    - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
>    - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
>    - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
> 
> * Zvfofp4min (Version 0.1):
>    The Zvfofp4min extension provides minimal vector conversion support
>    for the OFP4 E2M1 format. It requires the Zve32f extension.
>    Instructions added:
>    - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion
> 
> Chagnes in v4
> - Rebase on riscv-to-apply.next (commit 21101a7)
> - Remove the softfloat library related patches (Thanks for RH's help to
>    split this part)
> - Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
>    patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>    conversion for Zvfofp8min extension)
> 
> Changes in v3
> - Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
>    in patch 2 & 3
> - Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
> 
> Changes in v2
> - Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
> - Added new v2 patch 2 to refactor the IEEE format NaN classification
>    functions (float16, bfloat16, float32, float64) to use internal helper
>    functions, reducing code duplication and improving maintainability.
>    The OCP FP8 NaN classification functions follow the same pattern.
> - Refactored softfloat implementation to use capability-based FloatFmt
>    flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
>    instead of monolithic flags
> - Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
>    from float_status; now using local float_status with no_signaling_nans
>    and default_nan_pattern for RISC-V Zvfofp8min instructions
> - Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset
> 
> v3: <20260204051756.667397-1-max.chou@sifive.com>
> v2: <20260127063723.442734-1-max.chou@sifive.com>
> v1: <20260108151650.16329-1-max.chou@sifive.com>
> 
> References
> * OCP FP8 specification:
>    https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> * Zvfofp8min specification (v0.2.1 commit e1e20a7):
>    https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
> * Zvfofp4min specification (v0.1 commit e1e20a7):
>    https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc
> 
> Based-on: <20260304132514.2889449-1-max.chou@sifive.com>
> ([v4,0/9] Add Zvfbfa extension support)
> Based-on: <20260226071817.1417875-1-max.chou@sifive.com>
> ([v2,0/2] fpu: Fix OCP FP8 E4M3 conversion issues)
> 
> rnax
> 
> 
> Max Chou (14):
>    target/riscv: rvv: Fix NOP_UU_B vs2 width
>    target/riscv: Add cfg properity for Zvfofp8min extension
>    target/riscv: Add implied rules for Zvfofp8min extension
>    target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>      conversion for Zvfofp8min extension
>    target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>      conversion for Zvfofp8min extension
>    target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>      extension
>    target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>      for Zvfofp8min extension
>    target/riscv: Expose Zvfofp8min properity
>    disas/riscv: Add support of Zvfofp8min extension
>    target/riscv: Add cfg properity for Zvfofp4min extension
>    target/riscv: Add implied rules for Zvfofp4min extension
>    target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
>    target/riscv: Expose Zvfofp4min properity
>    disas/riscv: Add support of Zvfofp4min extension
> 
>   disas/riscv.c                              |  12 ++
>   target/riscv/cpu.c                         |  29 ++++-
>   target/riscv/cpu_cfg_fields.h.inc          |   2 +
>   target/riscv/helper.h                      |  15 +++
>   target/riscv/insn32.decode                 |   8 ++
>   target/riscv/insn_trans/trans_rvbf16.c.inc |  32 +++--
>   target/riscv/insn_trans/trans_rvofp4.c.inc |  43 +++++++
>   target/riscv/insn_trans/trans_rvofp8.c.inc | 105 ++++++++++++++++
>   target/riscv/insn_trans/trans_rvv.c.inc    |  39 ++++++
>   target/riscv/tcg/tcg-cpu.c                 |  10 ++
>   target/riscv/translate.c                   |   2 +
>   target/riscv/vector_helper.c               | 137 ++++++++++++++++++++-
>   12 files changed, 421 insertions(+), 13 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
>   create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> 


