Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB731C54F52
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0e9-0005Cy-4o; Wed, 29 Jul 2026 05:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wp0e6-0005Al-N0
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:32:14 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wp0e2-0007mB-Td
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:32:13 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2ccc2e84048so5048725ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785317527; x=1785922327; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pADPS5kItWz52rV9U3ZDa7YMjwLepBrZDe1qvMAiW7A=;
 b=stst6E2NNrQyXJyWxgevPleCQk3ltKtMMMm5btyNl5UgFJFgm64MnkDBRZeFOWzicc
 MMXNtf8tzQ0mulq6ZTbXOnWWDSE3y6GLMcMMBprNGTBaIArd4VTr8xMlRlPjuPxtQ5A3
 mZraRq/JTiijYuGI/Mq1f6N/uuIIF362lfVYrhngQriANVxr71al/yA53qfh0yd5nl/L
 1oXuqCQKfhhJAIO0DohR/pp023f/eapiGNMme0fQ2rsCIlyTKE8qvpTpkqq6iuJ0jxTK
 IWKyxXUx0JalzgZM9GczbCZLHeNOJQWIZR+Wp4fec3LR+M59N/d/SJIta1oJRGiUfMx3
 BCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785317527; x=1785922327;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pADPS5kItWz52rV9U3ZDa7YMjwLepBrZDe1qvMAiW7A=;
 b=bOyaP5duQNoZ1MoNK2pDjYeyCtS2hnHHLnJwsJAOm1ZHDqLbdARnc8OO9/2ZUevhph
 z51sj+znJP7oMr953tQFCJ7CNk1z11mYr3MffOFJgcL/uPw32FHyYsBEoZWDgJC8Bz78
 WhBlsH/h9h9OXSrqi8xrcq4Y8XtwjqxtviZ4ArwEl6rU+/ghaihyMZXypXDtNySR4dvh
 bYt9YoSz7VStLONjOJqjfjFc3R3kPCmUsd4P4zpvrRn0gL2HLTeKyd1kq6lCWNWKYyCy
 ldM6IZ8mfMOIxHIPxph5/NHzjh16QCT+2rsT3hpJZOzsXnwsGY8ajAdiLhxkReA6V98Q
 uVFw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3QIoa+FqD6Poy36hUgU6apHB0WyluDdF1R6/UYPyiBq0PxyNuh10JXocCwFhgby3MHZFeGHavrAZB@nongnu.org
X-Gm-Message-State: AOJu0Yy586JgjcxHj6kkUQYvHrKhfd1jSy77BXgt5FvOOyrVgm8nbLrz
 aXnVQscvfvxFDpn4dmpMDikF5d2zv6EHoelVerR2dA8IXnrhR0tLfskG
X-Gm-Gg: AR+sD12ANAwgRPuU+WGmVhGZeJe5OYmjsbyfpja+Kp/yFrA4x701/a1c4q5yXLPaHRU
 0yOQYvyDwe9cIPg+6wj3ZWnxoU/HSY2RHGXI5Cw8389CnTS9xI0iamLduQkiGCafbeDfzrkqHas
 bPiMbAg1B0mKGQGsfOp0ep5ZDB3yDdiSqIeD0hdqNo7G7nriBNjFw+N0uuvtDdPCs6yycisvi+/
 ehzLHWyrrXNxnrqzmS+GI3danyANzCmH4vp3o3HI8tEJ+u7N5JMyxy1PMARFVcPNoUEHFlIJmna
 GsgRmX+rmGCogeFUcC5m0VSHJsi53qk5XOtyvockYcL/Ncd1zQD7XQbh2+PIDTaBiZYU32REnEh
 QiYA15dJU11+PlEP7+x3r0SuysVmnzvTzCh59QAnhjodvp2fOHuS94jrGhSlm56JqdIgKkgRakp
 BTS+s3UTc37xu2dbpfO4pwB1LyQt8Ukxu40pxajhzZ55fhPAiZKLNu+n/bbRaw81ct19dWW3lHH
 s7lW1gZHdk51BdttH3qwH5Msrg=
X-Received: by 2002:a17:902:f645:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d015a4d753mr69995375ad.11.1785317527294; 
 Wed, 29 Jul 2026 02:32:07 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b125bbsm8285912eec.5.2026.07.29.02.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:32:06 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:32:03 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/18] target/riscv: Add support for RISC-V P
Message-ID: <amnHq8A14gOpHcg0@ChaodeMacBook-Pro.local>
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784280142.git.xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x04.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 17, 2026 at 10:06:53AM +0800, Molly Chen wrote:
> This series adds support for the RISC-V Packed SIMD (P) extension.
> 
> The P extension defines packed-SIMD fixed-point operations intended
> for DSP-style workloads such as multimedia and signal processing.
> These instructions operate on packed subword elements within
> general-purpose registers (GPRs).
> 
> The implementation follows the current development draft of the
> specification (v0.20):
> 
>   https://github.com/riscv/riscv-p-spec/
>   or
>   https://www.jhauser.us/RISCV/ext-P/
> 
> Compared with v1, this version reduces implementation boilerplate by
> defining and reusing helper macros for common patterns in
> trans_rvp.c.inc and psimd_helper.c. It also consolidates the P
> extension prerequisite validation in riscv_cpu_validate_p().
> 
> The Zbkb dependency has been removed to align the implementation with
> the current specification. This version also implements the
> specification-defined control of vxsat, which was missing from v1.
> 
> All instructions have been functionally tested using the following
> test suite:
> 
>   https://github.com/mollybuild/qemu-riscv-test-uart
> 
> The implementation focuses on functional correctness and ISA
> coverage. Performance optimizations were not considered at this
> stage.
> 
> Feedback on the implementation details would be highly appreciated.
> 
> Tested with:
> 
>   - ninja -C build test
>   - make -C build check-qtest-riscv32
>   - make -C build check-qtest-riscv64
>   - Functional tests for all P extension instructions using
>     qemu-riscv-test-uart
> 
> No regressions or test failures were observed.
> 
> ---
> Changes in v2:
> 
>   - Refactored trans_rvp.c.inc and psimd_helper.c by defining and
>     reusing helper macros for common implementation patterns, reducing
>     boilerplate and overall code size.
>   - Moved the P extension prerequisite checks into
>     riscv_cpu_validate_p().
>   - Removed the Zbkb dependency to align with the current
>     specification.
>   - Added the specification-defined vxsat control mechanism, which was
>     missing from v1.
> 
This patch set is a significant improvement over v1. I think there are still
a few common issues we can address together:

1. The line break characters '\' in the helper macros we defined need to be space-aligned.
2. Every patch is currently missing a commit body. 

I think these changes are quite necessary.

Thanks,
Chao
> v1:
>   https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html
> 
> Molly Chen (18):
>   target/riscv: Add packed SIMD extension state
>   target/riscv: Add packed SIMD helper framework
>   target/riscv: Add packed SIMD arithmetic instructions
>   target/riscv: Add packed SIMD averaging and rounding instructions
>   target/riscv: Add packed SIMD absolute, difference, compare and mask
>     instructions
>   target/riscv: Add packed SIMD shift instructions
>   target/riscv: Add packed SIMD exchange instructions
>   target/riscv: Add packed SIMD horizontal reduction instructions
>   target/riscv: Add packed SIMD pack, merge and count-leading
>     instructions
>   target/riscv: Add packed SIMD multiplication instructions
>   target/riscv: Add packed SIMD multiply-accumulate instructions
>   target/riscv: Add packed SIMD Q-format multiplication instructions
>   target/riscv: Add packed SIMD Q-format MAC instructions
>   target/riscv: Add packed SIMD two-way MAC instructions
>   target/riscv: Add packed SIMD four-way MAC instructions
>   target/riscv: Add packed SIMD load-replicate instructions
>   target/riscv: Add packed SIMD RV32 only instructions
>   target/riscv: Remove Zbkb dependency from P extension to align with
>     the spec
> 
>  target/riscv/cpu.c                          |    5 +-
>  target/riscv/cpu.h                          |    8 +
>  target/riscv/cpu_bits.h                     |    2 +
>  target/riscv/helper.h                       |  529 ++++
>  target/riscv/insn32.decode                  |  829 +++++
>  target/riscv/machine.c                      |   19 +
>  target/riscv/tcg/csr.c                      |   39 +-
>  target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
>  target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1389 ++++++++
>  target/riscv/tcg/meson.build                |    3 +-
>  target/riscv/tcg/psimd_helper.c             | 3165 +++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |   46 +
>  target/riscv/tcg/translate.c                |    6 +
>  13 files changed, 6038 insertions(+), 6 deletions(-)
>  create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
>  create mode 100644 target/riscv/tcg/psimd_helper.c
> 
> 
> base-commit: 8fb307591625731060d399aca42373c02c7cb040
> -- 
> 2.34.1
> 

