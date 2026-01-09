Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFEAD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6ft-0000cb-LZ; Fri, 09 Jan 2026 02:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6fo-0000WE-5W
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:12:41 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve6fm-0004rh-7D
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:12:39 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso88669b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767942756; x=1768547556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRcbzZf9qdEPrfIS8uirMZUm55BxAVX2zIEFNHXdt6E=;
 b=g2QZ7lOv23TSk3Dpd9x40ClhTLitK7Cpd6HnqP6z5xso+fkOv40pfzpWgNlqLd+8ba
 M8ivD15QjLUwDjiZOIXG/f1jpLOAaQz0CIzA6oHlGw7G293Y2+O/JwaJZVlmTs2zhnSS
 KDMC2qXOSnLLPSU0Q6Q12J2MDieQPVRvqcg58nKZwdlNxZIDwmuJC1cgZtYkV87sJmXr
 qmeFp2WaDgFyvwTJY2z3n1laKbRJr+rzaxMMxPL5SwdzObWO6gZj2G0xp5OK6VDDU4pE
 05ObYuroTUO8ZCYSWvytNCny3Yag5selrVXpZSQPDG3TTSqYbLWootFcXBQrg22PQqje
 EYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942756; x=1768547556;
 h=content-transfer-encoding:in-reply-to:references:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LRcbzZf9qdEPrfIS8uirMZUm55BxAVX2zIEFNHXdt6E=;
 b=FS+qI7JNrImk5ZNiqG/EwFPnAC+6RYrz7ipmpiEh3D0A5I1Ljis+NbLE2vaIKai1Z6
 SCvKolmdyRJ0fjQXrYmTB99RL3cKY6wAqd6IzUD4kLI9slkph3/M5JX7AjXi+E3fHj2a
 lHI6Oz5cj2gfQV8+iz3jrPXFf2vgzCQ57qmt2g5HNxuKJ7QpuDbLrIqzyU1TCIU+KfY0
 DcYEodl34zv5QSdvZKYrtv7e5z2NqlyqQIFFSZeo+LWP0wE12QB7WiBVmgp6DtV/9fev
 mAuYwjRXL+Aqttf/laBGdPvqpjrgjs5C8NvkQmfRpgkuWKvUVQHu3l4+AvrQ1qg6B0yc
 +Lcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQxgI+D6hPZgITqw3l6GMx07gFnafgGmf+oTsUbnHPGdYSPvOVY3R6kH6M/392MyNFpiZ4NsxoVXI@nongnu.org
X-Gm-Message-State: AOJu0YwzGVe7W+j8/HNfTXCw147uKslRf35zxcCb5A/KNjQL06HGc/XX
 2qoikkJgsdtR1vmHnRDNsN0vCL60eCX6/wutvyiEod27mupBKZhgObWX
X-Gm-Gg: AY/fxX4ovzBgQT7IuQ3J7+lRVNg+Uxmu/n7cm2/9RDYpMLI4aTi/jSeXDx3naG7NL/7
 T7WbYAJJJhUgQUUgK4LrLMhJFivqapbpni4I/falQk4RVQ/2lw35+sXaeRwClYlc/1Enf7Nj+dO
 HuPlXV9LnwgsE2BZDAjYST/wU++uHj5XCR8C6LN2s++5R9+4rm2lYxVwIL0m8f/jmtOA5jO4ipn
 2fAeR3Ds97G+L0v+jmJaaSYR+JpoW+wBjils81/lp5bw2fFKJM95DNm6o+P560VCPm01aoVmZ/h
 yXl1OZEVLAXv+1M1h826b7R9MKVPpU6ubWeiOxATi3hmCY8HZD+KCArTlpDPY1ifyCXRpYUwtj1
 IvBwd0qjJw9K+eDu0hBTaYlRKC6Mf7Qlel63kvhfYvQTf52fgGabNXKfRp0t4y8KPZVP13MUhpZ
 WwQikpuIb3rjDfeh71+lvl/q858V38EKQrM8vLI3W9AdkgissHXrDuK4MvLbM=
X-Google-Smtp-Source: AGHT+IHa/rjS3HHQ0/a7WkwiG5+qNp5y2dazAZekzhwpwYnARDITiljPDhZZ2JtEPMJ6ZuVLbwxh4A==
X-Received: by 2002:a05:6a00:2a0e:b0:817:9a85:54af with SMTP id
 d2e1a72fcca58-81b806ce675mr7277255b3a.43.1767942756091; 
 Thu, 08 Jan 2026 23:12:36 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e826asm9491005b3a.54.2026.01.08.23.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:12:35 -0800 (PST)
Message-ID: <6fefbbbc-94c6-409b-915d-ada609fe492e@gmail.com>
Date: Fri, 9 Jan 2026 15:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH 00/18] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> This patchset adds support for the OCP (Open Compute Project) 8-bit and
> 4-bit floating-point formats, along with the RISC-V Zvfofp8min and
> Zvfofp4min vector extensions that provide conversion operations for
> these formats.
> 
> OCP Floating-Point Formats
> * The OCP FP8 specification defines two 8-bit floating-point formats:
>   - E4M3: 4-bit exponent, 3-bit mantissa
>     * No infinity representation; only 0x7f and 0xff are NaN
>   - E5M2: 5-bit exponent, 2-bit mantissa
>     * IEEE-like format with infinity representation
>     * Multiple NaN encodings supported
> * The OCP FP4 specification defines the E2M1 format:
>   - E2M1: 2-bit exponent, 1-bit mantissa
>     * No NaN representation
> 
> RISC-V ISA Extensions
> * Zvfofp8min (Version 0.2.1):
>   The Zvfofp8min extension provides minimal vector conversion support
>   for OFP8 formats. It requires the Zve32f extension and leverages the
>   altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
>   E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
>   - Canonical NaN for both E4M3 and E5M2 is 0x7f
>   - All NaNs are treated as quiet NaNs
>   Instructions added/extended:
>   - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
>   - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
>   - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
>   - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
>   - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)
> 
> * Zvfofp4min (Version 0.1):
>   The Zvfofp4min extension provides minimal vector conversion support
>   for the OFP4 E2M1 format. It requires the Zve32f extension.
>   Instructions added:
>   - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion
> 
> Modifications
> * Softfloat library:
>   - New float8_e4m3 and float8_e5m2 types with NaN checking functions
>   - New float4_e2m1 type for OFP4 support
>   - Conversion functions: bfloat16/float32 <-> float8_e4m3/float8_e5m2
>   - Conversion function: float4_e2m1 -> float8_e4m3
>   - Implementation-defined behavior flags in float_status:
>     * ocp_fp8e5m2_no_signal_nan: Treat all E5M2 NaNs as quiet
>     * ocp_fp8_same_canonical_nan: Use 0x7f as canonical NaN for all OFP8
> * RISC-V target:
>   - CPU configuration properties for Zvfofp8min and Zvfofp4min
>   - Extension implied rules (Zvfofp8min requires Zve32f and Zvfbfa)
>   - Vector helper functions for OFP8/OFP4 conversion instructions
>   - Disassembler support for new instructions
> 
Nice work! The code quality looks good. I've been working on similar stuff
recently, so happy to review.

A quick suggestion: run checkpatch.pl to catch any style issues.

Also, are we planning to add softfloat unit tests for OCP floating-point
formats? Would be great for code quality coverage.

Thanks,
Chao

> References
> * OCP FP8 specification:
>   https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
> * Zvfofp8min specification (v0.2.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
> * Zvfofp4min specification (v0.1 commit e1e20a7):
>   https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc
> 
> PS: This series depends on the Zvfbfa extension patchset which introduces:
>   - The altfmt field in VTYPE CSR
>   - BF16 vector operations infrastructure
>   - vfwcvtbf16.f.f.v and vfncvtbf16.f.f.w base instructions
> 
> Based-on: 20260108132631.9429-1-max.chou@sifive.com
> 
> Max Chou (18):
>   target/riscv: rvv: Fix NOP_UU_B vs2 width
>   fpu/softfloat: Add OCP(Open Compute Project) OFP8 data type
>   fpu/softfloat: Add convert operations(bf16, fp32) for OFP8 data types
>   fpu/softfloat: Add OCP(Open Compute Project) OFP4 data type
>   fpu/softfloat: Add OCP FP4 E2M1 to OCP FP8 E4M3 convert operation
>   target/riscv: Add cfg properity for Zvfofp8min extension
>   target/riscv: Add implied rules for Zvfofp8min extension
>   target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
>     conversion for Zvfofp8min extension
>   target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
>     extension
>   target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
>     for Zvfofp8min extension
>   target/riscv: Expose Zvfofp8min properity
>   disas/riscv: Add support of Zvfofp8min extension
>   target/riscv: Add cfg properity for Zvfofp4min extension
>   target/riscv: Add implied rules for Zvfofp4min extension
>   target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
>   target/riscv: Expose Zvfofp4min properity
>   disas/riscv: Add support of Zvfofp4min extension
> 
>  disas/riscv.c                              |  12 +
>  fpu/softfloat-parts.c.inc                  |  77 +++++-
>  fpu/softfloat-specialize.c.inc             |  57 ++++-
>  fpu/softfloat.c                            | 274 +++++++++++++++++++++
>  include/fpu/softfloat-helpers.h            |  20 ++
>  include/fpu/softfloat-types.h              |  28 +++
>  include/fpu/softfloat.h                    | 124 ++++++++++
>  target/riscv/cpu.c                         |  35 ++-
>  target/riscv/cpu_cfg_fields.h.inc          |   2 +
>  target/riscv/helper.h                      |  15 ++
>  target/riscv/insn32.decode                 |   8 +
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  32 ++-
>  target/riscv/insn_trans/trans_rvofp4.c.inc |  54 ++++
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 115 +++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    |  39 +++
>  target/riscv/tcg/tcg-cpu.c                 |  15 ++
>  target/riscv/translate.c                   |   2 +
>  target/riscv/vector_helper.c               | 131 +++++++++-
>  18 files changed, 1022 insertions(+), 18 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc
> 


