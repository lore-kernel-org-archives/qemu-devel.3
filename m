Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32118C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 05:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfubX-000650-Sz; Thu, 06 Feb 2025 00:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tfubT-00064A-0p; Thu, 06 Feb 2025 00:39:07 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tfubQ-0001Hx-Sd; Thu, 06 Feb 2025 00:39:06 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-866e57ec274so248506241.2; 
 Wed, 05 Feb 2025 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738820343; x=1739425143; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Hh91lkJH4G2v2stBYhiTwErWA85jHVrA2A1cY0dyIA=;
 b=TOsIHrRlc3La/9TSSMWM5cgthOPiqpfUPOuFpwH8YSs61mKH0yNO5SXd7j9AMGuLOK
 YPVDogwlNDjqMaHIin674GOCYwUdg6ov3nKdoJybLer07yLj9wc2TtxlMSksNLUyWkKM
 GPjWNIVR5/gfrOzqN+MIiCfueEK0fhY8Q+ICbQgcixIp6sIt/OlRUIhru6je1jqP03Gs
 K7vyRi2P6wh9tiUUj26+yGNb8mZsOCf3x63RhtwCdVnwPTKLazeqx9f8Kb8DcdDBPJX1
 Cok+vRPKjWwdsotM6wTL/sY+1fydOH4fQhQcWCduFZTDAiNKRtZ1/wxk/3WRMoAHr0ez
 S9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738820343; x=1739425143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Hh91lkJH4G2v2stBYhiTwErWA85jHVrA2A1cY0dyIA=;
 b=hFx5qpayk9LOBLlqwLf7ifXT68mS4vMs7LKr5L1oW2n7qNNVoaNlu3bXU55Cs7/Da9
 JfDXSoMEt3MaO21c7FBxu+kFALT4EcNYekUs+2gfl49O8DVUz9xeNDvw6gLh4jA6OEkF
 SKjFR7zVNlDvlx5O05cF9Lf1eqYv8zxzxsWTgZsygl3s1ckp2R2znDg5/2HvgD0n/jQL
 V49LpyWbDfHiU7SAFvadD0Qu99Xq0C400GJm+XIu0/pdXncETwyKLQCFWi/qBe7FAmQ0
 wV/4C0nxh4OEkWP5Ovk58ELQjFVrmEQH1+pNKetY/+gsNGmwSf45kKSVbrAEcNhW94lc
 tKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCTXL5+v/bwRVfwpRz9+VwBdSlVnMJds3EDc74hPX754TRPhPO+47FyxQN1Jl8LfrvHriqNjCiJv5k@nongnu.org
X-Gm-Message-State: AOJu0Yx3TnsFNZohYzJZ76nvGCyBg5XBHEFaLNIA8uriqIGH9A7PCZLn
 salGrdCcu3bWlNL3yk4Cef80MABW9PED1LFolmJOgMehXrwTn/hmuExMgtwd5THiTvCcdkDnxQo
 iEJihcaJtXwIgkTDlnv7Rem5+rM4=
X-Gm-Gg: ASbGncsBBWiKAgIHn+HzDeMDfsXYftVC+Vru+7Z/E0JGbbv9p56mSprmwE8QCubsPum
 pcvcIhfMmMP3RDG/vjLl/jeAw6tnieXLInWrwNIO0OMRjUbNAeDMShyeV/AvlGWmfTCO890DkU3
 vLSRtofM1mDA0njqvkhsiGpfZ0cw==
X-Google-Smtp-Source: AGHT+IH5d0z1eLd2gPgvVo+vnnhWGEHacAlrrtEL4GC8lj2GwgCrXLGtMsmZOZugdoFHbB97JmW/J9QsQxeU9aFAU0k=
X-Received: by 2002:a05:6102:41ac:b0:4b1:f3e:882f with SMTP id
 ada2fe7eead31-4ba478b35f0mr3730409137.1.1738820342654; Wed, 05 Feb 2025
 21:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
In-Reply-To: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Feb 2025 15:38:36 +1000
X-Gm-Features: AWEUYZm5mV7vgJdT8_NcFMMFv4aWMhBxeKIg3qEMhfyBCxsHbrgLZSfVqA3MEOU
Message-ID: <CAKmqyKMhV8Nj2oUmD_vWCnZBjJgYcw=8CQ86P2jihy0S09TXTQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] target/riscv: Add support for Control Transfer
 Records Ext.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Feb 5, 2025 at 9:21=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> This series enables Control Transfer Records extension support on riscv
> platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been ratified and this series is based on v1.0 [0]
>
> CTR extension depends on both the implementation of S-mode and Sscsrind
> extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs u=
sing
> sscsrind extension.
>
> The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
> patches [3]. CTR itself doesn't depend on counter delegation support. Thi=
s
> rebase is basically to include the Smcsrind patches.
>
> Here is the link to a quick start guide [4] to setup and run a basic perf=
 demo
> on Linux to use CTR Ext.
>
> Qemu patches can be found here:
> https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v6
>
> Opensbi patch can be found here:
> https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
>
> Linux kernel patches can be found here:
> https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
>
> [0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag=
/v1.0
> [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/t=
ag/v1.0.0
> [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v=
1.0.0
> [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-0-=
c12a89baed86@rivosinc.com/
> [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-=
on-QEMU-RISC%E2%80%90V-Virt-machine
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
> Changelog:
> v6: Rebased on latest riscv-to-apply.for-upstream.

It should be rebased on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

I applied the first 6 patches as they apply cleanly

Alistair

>
> v5: Improvements based on Richard Henderson's feedback.
>   - Fixed code gen logic to use gen_update_pc() instead of
>     tcg_constant_tl().
>   - Some function renaming.
>   - Rebased onto v4 of counter delegation series.
>   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0-6=
0b993aa567d@rivosinc.com/
>
> v4: Improvements based on Richard Henderson's feedback.
>   - Refactored CTR related code generation to move more code into
>     translation side and avoid unnecessary code execution in generated
>     code.
>   - Added missing code in machine.c to migrate the new state.
>   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef94=
32@rivosinc.com
>
> v3: Improvements based on Jason Chien and Frank Chang's feedback.
>   - Created single set of MACROs for CTR CSRs in cpu_bit.h
>   - Some fixes in riscv_ctr_add_entry.
>   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
>   - Improved extension dependency check.
>   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
>   - Added implied rules for Smctr and Ssctr.
>   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write ops=
.
>   - Some more cosmetic changes.
>   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0-3=
2fd3c48205f@rivosinc.com/
>
> v2: Lots of improvements based on Jason Chien's feedback including:
>   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
>   - Fixed and added more CTR extension enable checks.
>   - Fixed CTR CSR predicate functions.
>   - Fixed external trap xTE bit checks.
>   - One fix in freeze function for VS-mode.
>   - Lots of minor code improvements.
>   - Added checks in sctrclr instruction helper.
>   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@ri=
vosinc.com/
>
> v1:
>   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@ri=
vosinc.com/
>
> ---
> Rajnesh Kanwal (7):
>       target/riscv: Remove obsolete sfence.vm instruction
>       target/riscv: Add Control Transfer Records CSR definitions.
>       target/riscv: Add support for Control Transfer Records extension CS=
Rs.
>       target/riscv: Add support to record CTR entries.
>       target/riscv: Add CTR sctrclr instruction.
>       target/riscv: machine: Add Control Transfer Record state descriptio=
n
>       target/riscv: Add support to access ctrsource, ctrtarget, ctrdata r=
egs.
>
>  target/riscv/cpu.c                             |  26 ++-
>  target/riscv/cpu.h                             |  13 ++
>  target/riscv/cpu_bits.h                        | 145 ++++++++++++
>  target/riscv/cpu_cfg.h                         |   2 +
>  target/riscv/cpu_helper.c                      | 266 +++++++++++++++++++=
+++
>  target/riscv/csr.c                             | 294 +++++++++++++++++++=
+++++-
>  target/riscv/helper.h                          |   2 +
>  target/riscv/insn32.decode                     |   2 +-
>  target/riscv/insn_trans/trans_privileged.c.inc |  18 +-
>  target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++
>  target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++
>  target/riscv/machine.c                         |  25 +++
>  target/riscv/op_helper.c                       |  48 ++++
>  target/riscv/tcg/tcg-cpu.c                     |  11 +
>  target/riscv/translate.c                       |  46 ++++
>  15 files changed, 986 insertions(+), 8 deletions(-)
> ---
> base-commit: 699291ba7774f1580584cd96f84ceda8cc4edb7e
> change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
> --
> Best Regards,
> Rajnesh Kanwal
>
>

