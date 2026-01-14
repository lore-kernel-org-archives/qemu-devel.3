Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562D0D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsn3-0003RN-QI; Tue, 13 Jan 2026 23:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsmz-0003MD-KO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsmy-0003hn-0g
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso55997595ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366042; x=1768970842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bv6dZAwdx0sMQ8eiUvMYGeMPip/M+vWSOGa7han7+F0=;
 b=eixEJEgO3an5g8sknPhxCnS8udtQDlU/00ZHkXlYD4eStVq9LJRqjtCv/mzwXiflCs
 QbzUSyg2PXnDYgBpEhylKiG98/eGPaHP6BWUOV7egplpn1YWOmTtIIb0DJedvNWQ8eHR
 dNcNt6vaujrWD25s4okkJwSm6MYehk0xYuuNghG4a6RLe/eoJzScepIiFGSw1UYqqEAV
 cLdmEDjwpqehUBqbz+7qZUhYHj5wBytPeziyTMqBzRTP7S9vzBxKfiYEbV2oWEYfm3aG
 fLh7CeVqtfer+SdhZxxQwFZd20mLA2zjZbij+eE7oIVmG8j86CgCtg4WFZ326kiQTFpw
 VMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366042; x=1768970842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv6dZAwdx0sMQ8eiUvMYGeMPip/M+vWSOGa7han7+F0=;
 b=URSFhJkxVV0Ih2JAulEkBsu4Dyaw4YhUVlEqGgzlodJ3X1vqTOm7Zhl8aARq0peSK6
 KAI+1326L9x7MYFtf5wa1WrAnYtpKp4cYRnaeAbyPw1wYEkV77Z4VV+l6caTlno7OHyD
 hlGyzdbW0uZH4QV0ltEcavHlKJp8a+NewPulCQqOTtLxSYtwIM1wuW0da/+uM9JvNTR9
 agk7obMNi+J41P43KurRSkuC8TJlBCo1LuRV218F4Rg8AEBIangBCpoPJkRrFttUsmNO
 cgsMWqSn1xl3m0lkIEgqJAcqMpn++PNUSywSpuK/dzEz+RlL14esM9zsGiBGZeKEwm2f
 x5oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTT6FMC1fU7IImxd6plbYhat2yzm5MoUdhhpB6VfAEx4Um6/6m3zzrlXRNGcaG1skAU4Oc5FqE7omP@nongnu.org
X-Gm-Message-State: AOJu0Ywjn2tgLyfk+WlFGarlX7IJuIaLKXsgFJbzjSIwK9lzlfOw9T/q
 KDlV+WncacuHHKZsSoTd1C4WKFFamT4C9QPmoegOs5lhePpFFcLbEBUm
X-Gm-Gg: AY/fxX5kA2EY+nK+vCCAC3QuYXnXxWOROT709EhGCFPHJ/tTyk/uSMVISf42PKpyT4X
 6aJIsn5aQx2J4qCyIRTaUjQnHjRR7LyYP0mk8CnI+k83rrAGvMPR8F+MuZkdRJxtnasvvFymJod
 Am7GsD5wh2rJfr3eB6d21HMwc74loW2nBi8Z2206W4ZR4Y0UW/j363Dg3mXGz7ovIXODdw/uT0H
 wcTJYk/6uHHiN2WfEEimMO/ZDTfe1Blac/vHO+w67ug1PDZYstKjyqDXVEL4WZ742PHSIyjfXAc
 TOWmMpSucEgBp4yXzbHeTDLDn7/2m1GprMPQqN84KtL2lh9BBN3sTe6pXH0SnL1k35u/t0O//rt
 HiaHEP8PX3kp67l7zebjBqtVmdgc3yeiWGwz3Kltn7+CTRgsXQZ7wpYtiNU2yb5yIJxcWXHzYiM
 4fMFsaz3lbiBwTZhVrg9ymK5l8M11QHHPc+EheolNSFxc5RQJmKM0JQrFaSlQ=
X-Received: by 2002:a17:903:234a:b0:2a0:9028:11af with SMTP id
 d9443c01a7336-2a599eac3f9mr15564495ad.59.1768366041937; 
 Tue, 13 Jan 2026 20:47:21 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 00/25] target/riscv/debug: Sdtrig fixes and TT Ascalon
 support
Date: Wed, 14 Jan 2026 14:46:33 +1000
Message-ID: <20260114044701.1173347-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Hi,

Sorry for the big series. The Ascalon CPU implements Sdtrig with 2
different types of mcontrol6 trigger and the icount trigger, so in
the course of testing and bringing up OpenSBI and Linux support for
this, I've accumulated quite a lot.

My new year resolution is to start being better upstream contributor,
it's taken me a while with changing jobs and architectures. So I don't
expect others to drop everything to review this! Joel has been
prodding me, and noted there is some other Sdtrig work going on
with the v1.0 support patches.

I think the debug v1.0 patches are somewhat orthogonal to this series,
but both are addressing aspects of a common problem of Sdtrig
implementation specifics. I wonder if these should be reconciled or
left separate. Sdtrig v1.00/v0.13 configuration is a single boolean
which is feasible as a CPU property. Whereas the entire space of
Sdtrig implementation seems like too much to make configurable in that
way.

Any thoughts would be welcome.

Thanks,
Nick

Nicholas Piggin (25):
  target/riscv/debug: Check only mcontrol triggers for break/watchpoint
    matching
  target/riscv/debug: Handle changing trigger types
  target/riscv/debug: Implement permissive type unavailable trigger
  target/riscv/debug: Fix icount trigger privilege check
  target/riscv/debug: Update itrigger_enabled after changing privilege
  target/riscv/debug: Implement get_trigger_action for icount type
    trigger
  target/riscv/debug: Fix migration post_load icount_enabled() test
  target/riscv/debug: Fix icount privilege matching icount_enabled()
    test
  target/riscv/debug: Implement icount trigger textra matching
  target/riscv/debug: Maintain itrigger_enabled in
    helper_itrigger_match()
  target/riscv/debug: Fix breakpoint matching action
  target/riscv/debug: Put mcontrol load/store match address into tval
  target/riscv/debug: Remove breakpoints on reset
  target/riscv/debug: Move debug CPU post_load details into debug.c
  target/riscv/debug: Insert breakpoints after migration
  target/riscv/debug: Remove itrigger icount-enabled mode
  target/riscv/debug: Advertise icount trigger type in tinfo
  target/riscv/debug: Reset trigger type to unavailable
  target/riscv/debug: Add new debug state format
  target/riscv/debug: Migrate mcontext using new sdtrig vmstate
  target/riscv/debug: Implementation specific Sdtrig configuration
  target/riscv/debug: Support heterogeneous trigger types
  target/riscv/debug: Support heterogeneous mcontrol access types
  target/riscv/debug: Emulate TT Ascalon Sdtrig
  target/riscv/debug: Fix minor comment typos

 target/riscv/cpu.c         |  65 ++++-
 target/riscv/cpu.h         |  41 ++-
 target/riscv/cpu_helper.c  |  10 +-
 target/riscv/csr.c         |   7 +-
 target/riscv/debug.c       | 571 ++++++++++++++++++++-----------------
 target/riscv/debug.h       |  19 +-
 target/riscv/machine.c     |  96 ++++++-
 target/riscv/tcg/tcg-cpu.c |   5 +-
 8 files changed, 510 insertions(+), 304 deletions(-)

-- 
2.51.0


