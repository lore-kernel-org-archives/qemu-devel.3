Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C4FE77174
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIox7-00081C-Mk; Wed, 04 Dec 2024 07:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIowl-0007z2-Hk
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIowf-0007Bx-LV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so5036774f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317049; x=1733921849;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nn9w2S1HzUDyyhV3xP209KztA+EO/RuDsRBl/z8NGbw=;
 b=zNBSU1zjDSD3iGUfg0hn0gHlf/yO+7fTlPjaJHnLBwusji4BMNbisRbE1RU1Kl2uXp
 /PQsjop2gg53juLBmDFubw/OPgPtfE/dD702uyxeAA0Q67am+ayeF06Q8lxjHaLP/MJo
 HcRtgcPo4Men2qMthNhtwmOVDMD6FaZ65gtVPkcbXU/0Cym4h/X3gJ+mmx4tBwuVKYLq
 fT4qlgzmfSt/ESwoR9qVAoBjHVj7q05BDHF6yfWd+8uUVtgqww6pC3zohbouQ29+9m4n
 PNY8ptdJC8CT9nOe6cUqV1FzGeXTEckJy2yNTPU2DC05ErZWaUWPf34kNTFdsF/SD6Fq
 HYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317049; x=1733921849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nn9w2S1HzUDyyhV3xP209KztA+EO/RuDsRBl/z8NGbw=;
 b=knwTZJtth0KGb7DvRB14ubw2xM7gFPkzhSF+oVx6sHr+r1HpS9wmR4DJldrdG810NU
 0opuSQb/YQpHcCftTzd90+/iB7OhQn/SMlk1tv7JTMeENVzV7PMEUAhZn5IEwCz7h5wx
 yAVUlZNkcJgN2umPVAMpzyiqHvgpu7SZe0TpSH1oLCmcOkSJUq01kK2DPqn2y9zNvr7t
 jclq+lXzNHuP7QtMtnwJLdYRDa0fa9RJkMnY3CTMhcKC2ceUT+KUXU7UNeKl/f9FXDGj
 dTN5dZn/A4j6c080crU05ZiuNF79Qkd0U3XNGj5RGkWw8lUGNs2JMt5RLatv7d+DWvxK
 M6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZUOwoesgye+7aXTZuyVMTu/mVFrX0mgX54P25O4SW62T3DIZanDKf+VWfVINHnkWKz4H7AwePEuu3@nongnu.org
X-Gm-Message-State: AOJu0YxHKjESYfJEAn3WpXmaLgGkUEDmf4mTK0paon0eHRFaFFJYCR7S
 6jCDbDtULDea258EPVgeBtURiWtlH90N13FIuhQif0kiWn8WvXH/FkX8QKOBPuI=
X-Gm-Gg: ASbGncshUYoMbvuQ3C2k+qS8wepqIlCM7OdVfxVXtiMeJ5tn/7ta3K6HmOBSufi71A7
 JaFZkuEZg/6yzgIMt7rjUYkYFoVfBdrxOmYYszNQ7XBSlhOcwT0c6UbgPyeTy0UWFhs6+noxr+q
 RlSf+ZRcfThyIcZQYlLuGWNljSqoTHI5C2TWS4x3xIdBb0gjvTjd07XircFSlF269SzDnfrr9ZV
 cxcsXb8tjFe/cLkYxqFenuFHVagNoMsHG8Ju1m5o4TEwsGalhlO9JgnBR5oLoaJpvMge2rUHR3V
 milEPw==
X-Google-Smtp-Source: AGHT+IH7jt7YyBibHGpvkqn7FSDR3EpBa+Tcig/ZfjzWjKeu7YTsGwcbtSh6zxw/vjwT//gdiYe9Qg==
X-Received: by 2002:a5d:47a7:0:b0:385:fa3d:199b with SMTP id
 ffacd0b85a97d-385fd42a006mr5732270f8f.40.1733317049315; 
 Wed, 04 Dec 2024 04:57:29 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:29 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 0/7] target/riscv: Add support for Control Transfer
 Records Ext.
Date: Wed,  4 Dec 2024 17:56:38 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241029-b4-ctr_upstream_v3-7ab764c68bf1
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x444.google.com
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

This series enables Control Transfer Records extension support on riscv=0D
platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.=0D
The Extension has been stable and this series is based on v1.0_rc6 [0]=0D
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
https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v4=0D
=0D
Opensbi patch can be found here:=0D
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2=0D
=0D
Linux kernel patches can be found here:=0D
https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2=0D
=0D
[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v=
1.0_rc6=0D
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag=
/v1.0.0=0D
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.=
0.0=0D
[3]: https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.c=
om/=0D
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on=
-QEMU-RISC%E2%80%90V-Virt-machine=0D
=0D
Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>=0D
---=0D
Changelog:=0D
=0D
v4: Improvements based on Richard Henderson's feedback.=0D
  - Refactored CTR related code generation to move more code into=0D
    translation side and avoid unnecessary code execution in generated=0D
    code.=0D
  - Added missing code in machine.c to migrate the new state.=0D
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
      target/riscv: Add support to access ctrsource, ctrtarget, ctrdata reg=
s.=0D
      target/riscv: machine: Add Control Transfer Record state description=
=0D
=0D
 target/riscv/cpu.c                             |  26 ++-=0D
 target/riscv/cpu.h                             |  13 ++=0D
 target/riscv/cpu_bits.h                        |  94 ++++++++=0D
 target/riscv/cpu_cfg.h                         |   2 +=0D
 target/riscv/cpu_helper.c                      | 266 +++++++++++++++++++++=
+=0D
 target/riscv/csr.c                             | 294 +++++++++++++++++++++=
+++-=0D
 target/riscv/helper.h                          |   6 +-=0D
 target/riscv/insn32.decode                     |   2 +-=0D
 target/riscv/insn_trans/trans_privileged.c.inc |  22 +-=0D
 target/riscv/insn_trans/trans_rvi.c.inc        |  70 ++++++=0D
 target/riscv/insn_trans/trans_rvzce.c.inc      |  22 ++=0D
 target/riscv/machine.c                         |  25 +++=0D
 target/riscv/op_helper.c                       |  52 ++++-=0D
 target/riscv/tcg/tcg-cpu.c                     |  11 +=0D
 target/riscv/translate.c                       |  44 ++++=0D
 15 files changed, 935 insertions(+), 14 deletions(-)=0D
---=0D
base-commit: 2564f23eaefca2fc77d574c8eaf5c34138ce627f=0D
change-id: 20241029-b4-ctr_upstream_v3-7ab764c68bf1=0D
-- =0D
Best regards,=0D
Rajnesh Kanwal=0D
=0D

