Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF34C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRU-0004UD-E3; Wed, 05 Feb 2025 06:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRM-0004OT-OK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRJ-0003xZ-SN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso45437765e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754368; x=1739359168;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CbLXcgySYFJKgWzge/tmznui5ZuIe11I4CAbKzqTq8M=;
 b=Wgnag7zizHpCoWy+Ytzd+VKiBpQ+bqMlq7EQq3a82KZKhVywdt5sArKPnigxyispNz
 254hszQ9QcLvupAibWLg5PG9vmHpAkIhex6zC36lli8RBz2sSl4CeOam9KC847hl6Q/8
 bd1wPa7dl8iniQIT7Mvs9E5feAohJaBCdIbo9KUqHie7ZGG0NsT4lTvzsitBXw7tPZRC
 oEKFxCdt+TBeGcDUyh475v9I84WqScLWYcGxmdBL5/EyZXYyNJnH8sStyLUea1ROND+m
 Z5tYFqgIxAgEWcqU3NT28xcYVjX9mLymxmAgpX+FWP5sG1VVsazS67578NS+x5qofgJf
 DKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754368; x=1739359168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CbLXcgySYFJKgWzge/tmznui5ZuIe11I4CAbKzqTq8M=;
 b=DD8EopU8jFIVWoZ8CgPrEFVLdW853zYm0RZtxTBEp8HMmG+XzZMA3o3Bnlm/8unv+i
 sAqf0pNtsxqRZoHd1X970uDI+SwJRsHy14Ck0Zwua91s5VD6NEjDuhJF03r3cOeXltB3
 i5wuohGfwTKXElnmlLz1CMV0Q/+pB7LmYB/iUa82qfZryCC7TiPVKnlUk4Az5UDPw+kF
 WjypJnJTYgsEJw27RqddzUM68Pc5MiDyQFqIw/WGL4wYiqA/vtZiIqbX7qLIIzhZwqFi
 R37nlpT58hS7RmSdGsqWdgGozhh6E+Isc7mu58zm9CqPiwmnbNC8F6g2rvQnZti5Pppl
 xm7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVHs+rbaH2Yl479721mJk3vatp0n+z9ctyGmorZt+tibcdcAM6aD1peWXyj1fwz2rWgbPPkmYOyDA1@nongnu.org
X-Gm-Message-State: AOJu0YwZHSp3ZfXv62761C3psHI26awUerRv5oxdxeui+nW3h+pgdtH+
 TG2/yPjwXkI0yhZBvXNYyjINtVXF6/HVQDiVS4KSyiuTJRkPZvSL/ihLFvDqYeY=
X-Gm-Gg: ASbGncts2yNpZkeILXYxRRKNMKwUymvUzwspgc34MOo+ggvlgsS2OJEJ98I1y3FbCJV
 14eRteo4pJteVn83IUKsx3c2D1HN6C5HPvUfhBzGfm7gcrnF10T0GiYN0UBI8ReTcI7q5VYEIvl
 1WFK8ySpL4ZSVqwcy3a+yiJUHp3e+aqzd8zkr2FXgq+9rK+nP+9De/LycGHWn/DvZVXWjK2T5a8
 CL6KGJQ2J0of8otT9I9lTcjdpBGG0+DfQCa4YD/j9FF4YfLrTt1wxSTw8tbU04z+futFwX3AisW
 lpHsz7yngMOKHiu7IB2iig5X9R0=
X-Google-Smtp-Source: AGHT+IG6nqfILbw5eBHZgd18fktKdwDUIiNgmiW33onF/W9P6V7MNreiDUya833ZUkSli6YcA9r1hA==
X-Received: by 2002:a05:600c:45d2:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-4390d4360cbmr21712705e9.11.1738754367713; 
 Wed, 05 Feb 2025 03:19:27 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:27 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 0/7] target/riscv: Add support for Control Transfer
 Records Ext.
Date: Wed,  5 Feb 2025 11:18:44 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250205-b4-ctr_upstream_v6-71418cd245ee
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series enables Control Transfer Records extension support on riscv=0D
platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.=0D
The Extension has been ratified and this series is based on v1.0 [0]=0D
=0D
CTR extension depends on both the implementation of S-mode and Sscsrind=0D
extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs usi=
ng=0D
sscsrind extension.=0D
=0D
The series is based on Smcdeleg/Ssccfg counter delegation extension [2]=0D
patches [3]. CTR itself doesn't depend on counter delegation support. This=
=0D
rebase is basically to include the Smcsrind patches.=0D
=0D
Here is the link to a quick start guide [4] to setup and run a basic perf d=
emo=0D
on Linux to use CTR Ext.=0D
=0D
Qemu patches can be found here:=0D
https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v6=0D
=0D
Opensbi patch can be found here:=0D
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2=0D
=0D
Linux kernel patches can be found here:=0D
https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2=0D
=0D
[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v=
1.0=0D
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag=
/v1.0.0=0D
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.=
0.0=0D
[3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-0-c1=
2a89baed86@rivosinc.com/=0D
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on=
-QEMU-RISC%E2%80%90V-Virt-machine=0D
=0D
Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>=0D
---=0D
Changelog:=0D
v6: Rebased on latest riscv-to-apply.for-upstream.=0D
=0D
v5: Improvements based on Richard Henderson's feedback.=0D
  - Fixed code gen logic to use gen_update_pc() instead of=0D
    tcg_constant_tl().=0D
  - Some function renaming.=0D
  - Rebased onto v4 of counter delegation series.=0D
  - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0-60b=
993aa567d@rivosinc.com/=0D
=0D
v4: Improvements based on Richard Henderson's feedback.=0D
  - Refactored CTR related code generation to move more code into=0D
    translation side and avoid unnecessary code execution in generated=0D
    code.=0D
  - Added missing code in machine.c to migrate the new state.=0D
  - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432=
@rivosinc.com=0D
=0D
v3: Improvements based on Jason Chien and Frank Chang's feedback.=0D
  - Created single set of MACROs for CTR CSRs in cpu_bit.h=0D
  - Some fixes in riscv_ctr_add_entry.=0D
  - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.=0D
  - Improved extension dependency check.=0D
  - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.=0D
  - Added implied rules for Smctr and Ssctr.=0D
  - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write ops.=
=0D
  - Some more cosmetic changes.=0D
  - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0-32f=
d3c48205f@rivosinc.com/=0D
=0D
v2: Lots of improvements based on Jason Chien's feedback including:=0D
  - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.=0D
  - Fixed and added more CTR extension enable checks.=0D
  - Fixed CTR CSR predicate functions.=0D
  - Fixed external trap xTE bit checks.=0D
  - One fix in freeze function for VS-mode.=0D
  - Lots of minor code improvements.=0D
  - Added checks in sctrclr instruction helper.=0D
  - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@rivo=
sinc.com/=0D
=0D
v1:=0D
  - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@rivo=
sinc.com/=0D
=0D
---=0D
Rajnesh Kanwal (7):=0D
      target/riscv: Remove obsolete sfence.vm instruction=0D
      target/riscv: Add Control Transfer Records CSR definitions.=0D
      target/riscv: Add support for Control Transfer Records extension CSRs=
.=0D
      target/riscv: Add support to record CTR entries.=0D
      target/riscv: Add CTR sctrclr instruction.=0D
      target/riscv: machine: Add Control Transfer Record state description=
=0D
      target/riscv: Add support to access ctrsource, ctrtarget, ctrdata reg=
s.=0D
=0D
 target/riscv/cpu.c                             |  26 ++-=0D
 target/riscv/cpu.h                             |  13 ++=0D
 target/riscv/cpu_bits.h                        | 145 ++++++++++++=0D
 target/riscv/cpu_cfg.h                         |   2 +=0D
 target/riscv/cpu_helper.c                      | 266 +++++++++++++++++++++=
+=0D
 target/riscv/csr.c                             | 294 +++++++++++++++++++++=
+++-=0D
 target/riscv/helper.h                          |   2 +=0D
 target/riscv/insn32.decode                     |   2 +-=0D
 target/riscv/insn_trans/trans_privileged.c.inc |  18 +-=0D
 target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++=0D
 target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++=0D
 target/riscv/machine.c                         |  25 +++=0D
 target/riscv/op_helper.c                       |  48 ++++=0D
 target/riscv/tcg/tcg-cpu.c                     |  11 +=0D
 target/riscv/translate.c                       |  46 ++++=0D
 15 files changed, 986 insertions(+), 8 deletions(-)=0D
---=0D
base-commit: 699291ba7774f1580584cd96f84ceda8cc4edb7e=0D
change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee=0D
-- =0D
Best Regards,=0D
Rajnesh Kanwal=0D
=0D

