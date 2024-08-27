Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF6C54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5W9-00038B-1E; Tue, 27 Aug 2024 19:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5Vt-0002AK-Pz
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:22:15 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5Vr-0001Mo-I7
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:22:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7cd895682fcso2271797a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800929; x=1725405729;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qTm/Z8MW3JObu40DamPDnh7NBOVUkak+ZIuijuMxFUk=;
 b=dbysqH7kvVdyG1/EKn9ZsHKwafFzIUusZmh4bbrj9xqmYorQDIL07naCZ4XcoXJiLS
 B59d0VEQmx3R/On3MR0NjI2qnyxfRQyZ5Ib6c/+IBv/3kX5XsBAaRq3OTlRqhX09iPge
 +H8Bbw9sSh4cj1x2pz7BXQ+uy1xz73wVS88jaruw+tv2QWuPpBgtsIWd5JcUUxO+P//A
 lkxxFiSrYDlTqJieTZGOMJb4PEt8aMHg5cSjnBAiFlDq/5/tlt1PhgeBBaw/NgBY8jR+
 Nx5+efgmZ3HcSV/6EJ46dA2u1qYVKPvOw0VYs0BD81vq4+/EPlA3D+2igVCdEiSFCXfj
 hfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800929; x=1725405729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTm/Z8MW3JObu40DamPDnh7NBOVUkak+ZIuijuMxFUk=;
 b=wt/pYkN2vYGCmKJkdFOO8sH7YflEhh8pvuGUi2fFZSV4FusdS4y5Nz/d9zMluu7WIK
 XI15TjG/YKJY+hwRV4idoi5eWDcZSPdHT1YrHVo96CfLoviQj/chOLckk6DuicQPbZZt
 brlJ3cHFYBvkR2uhiu1Cc2t8aIgUPA/XD3F6ZjSpsoxqOeHZn3KiybZjsnfKYM55fTIr
 Go0KExRjftLxAXTQrt53+9UIzUheYmC/Uo+Qn2rNK0ItzlCcfr4P96ffNV7FP/oEg9Ny
 +hgNTXAM+SagEmeOSuAGGFhrerzTFDQsg5Caa8rgTI32KJQ+uNZz2c7HCBR1HbjZf4jU
 6qCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdGcSs1gys1jvv74XbS0C8DVDX+oehDnoaNYWh92KuY/AX1jchXWqgHdK7yRUJe/Zin2wAoOYpqa6V@nongnu.org
X-Gm-Message-State: AOJu0YxG4L18wDn3EdXtJpFWGYVLHqISMIuYnD0MMPhD5YfmH4UMKIA0
 t+ZgdM9KkVqdrRkpUyNWO4RLwE43FnyTe0HTiJZ/A1X3LF2eDJw45dPP6S/3IOQ=
X-Google-Smtp-Source: AGHT+IEE3K79UoTfx/lJQj7m1iXJRKjiq75cYt2jFXdrfpt0zN4WkNT7hcKKO3D0dcN2YYeOMmns5g==
X-Received: by 2002:a17:90b:3d83:b0:2cf:cc13:471a with SMTP id
 98e67ed59e1d1-2d646d81620mr12114532a91.43.1724800929034; 
 Tue, 27 Aug 2024 16:22:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d84467e748sm68503a91.55.2024.08.27.16.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:22:06 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v10 00/21] riscv support for control flow integrity
 extensions
Message-ID: <Zs5fniWWETHSfs7Z@debug.ba.rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 04:18:44PM -0700, Deepak Gupta wrote:
>v10 for riscv zicfilp and zicfiss extensions support in qemu.
>
>Links for previous versions
>[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
>[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
>[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
>[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
>[5] - v5
>+https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
>[6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.html
>[7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivosinc.com/
>[8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivosinc.com/T/
>[9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosinc.com/

Sorry forgot to include URL to specification in cover letter (its in one of the patches)

Link to Specification
github: https://github.com/riscv/riscv-cfi
pdf: https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

-Deepak

>
>---
>v10:
>   - Exposed *envcfg CSR and priv to qemu-user as well and removed special
>     state management for *envcfg related feature enabling for qemu-user
>   - Exposing zicfilp and zicfiss as different patch
>v9:
>   - fix switch case fallthrough for sw_check excp in patch 4
>v8:
>   - fixed up `gen_cmpxchg` to store extra word2 during compile to raise storeAMO always
>v7:
>   - Updated decode_save_opc to take extra argument of excp_uw2 and
>     updated callsites
>   - added a helper for promoting load faults to store faults
>   - Removed stale comments and edited existed comments
>v6:
>   - Added support extra store word 2 for tcg compile and extraction during unwind
>   - Using extra word, AMO instructions and shadow stack instructions can raise store fault
>   - some alignment and cosmetic changes
>   - added vmstate migration support for elp and ssp cpu state
>v5:
>   - Simplified elp tracking and lpad implementation as per suggestion by richard
>   - Simplified shadow stack mmu checks as per suggestion by richard
>   - Converged zicfiss compressed and non-comressed instructions to same translation
>   - Removed trace hooks. Don't need for upstream.
>
>v4:
>   - elp state in cpu is true/false instead of enum and elp cleared
>     unconditionally on trap entry. elp in *status cleared unconditionally on
>     trap return.
>   - Moved logic for branch tracking in instruction translation from tb_start.
>   - fixed zicfiss dependency on 'A'
>   - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
>   - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
>   - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
>   - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
>   - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
>   - removed vDSO related changes for now.
>v3:
>   - Removed prctl specific patches because they need to be upstream
>     in kernel first.
>   - As suggested by Richard, added TB flag if fcfi enabled
>   - Re-worked translation for landing pad and shadow stack instructions
>     to not require helper.
>   - tcg helpers only for cfi violation cases so that trace hooks can be
>     placed.
>   - Style changes.
>   - fixes assert condition in accel/tcg
>
>v2:
>   - added missed file (in v1) for shadow stack instructions implementation.
>
>Deepak Gupta (21):
>  target/riscv: expose *envcfg csr and priv to qemu-user as well
>  linux-user/riscv: set priv for qemu-user and defaults for *envcfg
>  target/riscv: Add zicfilp extension
>  target/riscv: Introduce elp state and enabling controls for zicfilp
>  target/riscv: save and restore elp state on priv transitions
>  target/riscv: additional code information for sw check
>  target/riscv: tracking indirect branches (fcfi) for zicfilp
>  target/riscv: zicfilp `lpad` impl and branch tracking
>  disas/riscv: enable `lpad` disassembly
>  target/riscv: Expose zicfilp extension as a cpu property
>  target/riscv: Add zicfiss extension
>  target/riscv: introduce ssp and enabling controls for zicfiss
>  target/riscv: tb flag for shadow stack  instructions
>  target/riscv: mmu changes for zicfiss shadow stack protection
>  target/riscv: AMO operations always raise store/AMO fault
>  target/riscv: update `decode_save_opc` to store extra word2
>  target/riscv: implement zicfiss instructions
>  target/riscv: compressed encodings for sspush and sspopchk
>  disas/riscv: enable disassembly for zicfiss instructions
>  disas/riscv: enable disassembly for compressed sspush/sspopchk
>  target/riscv: Expose zicfiss extension as a cpu property
>
> disas/riscv.c                                 |  77 ++++++++-
> disas/riscv.h                                 |   4 +
> linux-user/riscv/cpu_loop.c                   |   4 +
> target/riscv/cpu.c                            |  10 ++
> target/riscv/cpu.h                            |  31 +++-
> target/riscv/cpu_bits.h                       |  17 ++
> target/riscv/cpu_cfg.h                        |   2 +
> target/riscv/cpu_helper.c                     | 155 +++++++++++++++++-
> target/riscv/cpu_user.h                       |   1 +
> target/riscv/csr.c                            |  84 ++++++++++
> target/riscv/insn16.decode                    |   4 +
> target/riscv/insn32.decode                    |  26 ++-
> .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
> target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
> target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
> target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
> target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
> target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
> target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
> target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
> target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
> target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
> target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
> target/riscv/internals.h                      |   3 +
> target/riscv/machine.c                        |  38 +++++
> target/riscv/op_helper.c                      |  18 ++
> target/riscv/pmp.c                            |   5 +
> target/riscv/pmp.h                            |   3 +-
> target/riscv/tcg/tcg-cpu.c                    |  25 +++
> target/riscv/translate.c                      |  45 ++++-
> 30 files changed, 726 insertions(+), 53 deletions(-)
> create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>
>-- 
>2.44.0
>

