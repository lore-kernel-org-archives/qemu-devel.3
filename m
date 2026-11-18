Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8D606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=b6oqggTg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYs-0008JV-W4; Wed, 18 Nov 2026 04:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYh-0008G4-PD; Wed, 18 Nov 2026 04:02:27 -0500
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-000425-Kt; Wed, 18 Nov 2026 04:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992515; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=hDgcpGiEPGUWUernPfZIy9OSE2O5xguTCPC9/8HU2gs=;
 b=b6oqggTg44djAcd9NAq/Svdqbnf4YK4tdemgpGPm3xae+57ba/vuhJCk5tcp1f0pYMRcD64kmFeKrpJ6uhQRyg1bTnpwREJyOw9ZDli7yg+n8PmbtT2rsYKEQT+Vvcq/2VOREW/JJ7Nssngzsi7+NE7aLb3h0VxcQa+/uzJ5zPo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0GqgG_1794992513; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0GqgG_1794992513 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:54 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH RFC 0/8] RISC-V: Experimental fetch support for 48-bit and
 64-bit instructions
Date: Wed, 18 Nov 2026 17:01:27 +0800
Message-Id: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdp/WoC/yXMywrCQAyF4VcpWRvsVLxuhT6A2+IiM2ZsoE4lK
 VIsfXfHdvkfDt8ExipscCkmUP6ISZ9yuE0BoaX0ZJRHbqjK6uCcO+K3wxfZwIon9oGIy/N+FyH
 /38pRxsVq4FZf4Z5HT8bolVJo/0wfowShbrsaMM8/Vdw4a4IAAAA=
X-Change-ID: 20261117-zl-master-8ebcaae0953f
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=3546;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=M+MmlVxIxRVMLg7vuJcZj/YG3r2A6ueDhBVQ9vRqT6k=;
 b=JmIrEdCLqNAESq4SLdK80ffhphtoDjcokNUQSbV2b7WVAho71/21yNXAxLOgWkxz6KnUbiB+o
 PO3FdBSQKjdDP4zAZZPc7aZV9rld7joEjE23u6GVtDuMtxutt7bg0uR
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU's RISC-V TCG implementation currently supports only 16-bit
compressed instructions and 32-bit instructions. This series adds
experimental support for fetching 48-bit and 64-bit instructions and
for halfword alignment, following Zl draft 65c377a [1].

This work is motivated in part by an AME proposal that encodes operand
datatypes in instructions and is still under evaluation [3]. Larger
immediates and longer-range direct calls are other uses under discussion
[1,2]. This series provides instruction-fetch, alignment and trap-reporting
support for long instructions, without implementing individual instruction
semantics.

The x-zl CPU property is disabled by default and supported only under
TCG. When enabled, the translator and built-in disassembler share the
length rules, and halfword alignment does not require C/Zca. Compressed
decoding remains disabled if C/Zca are disabled. Complete 48/64-bit
encodings still raise illegal-instruction exceptions, and the
disassembler prints "unknown".

For an undefined length, fetching stops after the third 16-bit parcel
and no instruction bits are reported. This avoids additional fetches
solely for trap reporting. Feedback on this choice would be useful.

Patch 1 fixes incomplete instruction reads in the disassembler and can
be taken independently of Zl support.

The code was built for RV32/RV64 user and system emulation. RV32/RV64
bare-metal tests check RAM-boundary fetches and trap values, halfword
jumps and returns, and rejection of compressed instructions with C/Zca
disabled. The Zl tests and existing MEPC regression passed with Capstone
enabled and disabled.

[1] https://github.com/riscv/riscv-long-instruction/blob/65c377a665feb29a4848384ad566a9873c5fd423/src/unpriv/zl.adoc
[2] https://github.com/riscv/riscv-isa-manual/pull/3269#issuecomment-5328426143
[3] https://riscv.atlassian.net/wiki/spaces/AMEX/pages/2445836308/2026-11-09+AME+Meeting+Notes

---
TANG Tiancheng (8):
      disas/riscv: Reject incomplete instruction reads
      target/riscv: Share instruction length helper
      target/riscv: Prepare Zl instruction alignment
      disas/riscv: Decode Zl instruction lengths
      target/riscv: Limit instruction bits to the trap CSR width
      target/riscv: Fetch 48-bit and 64-bit instructions
      target/riscv: Enable experimental Zl fetch support
      tests/tcg/riscv: Check Zl fetching and halfword alignment

 disas/riscv.c                               |  49 ++++++---
 disas/riscv.h                               |   4 +-
 target/riscv/cpu.c                          |   6 +
 target/riscv/cpu.h                          |  10 +-
 target/riscv/cpu_cfg_fields.h.inc           |   1 +
 target/riscv/insn_length.h                  |  29 +++++
 target/riscv/internals.h                    |  17 +--
 target/riscv/tcg/cpu_helper.c               |   7 +-
 target/riscv/tcg/csr.c                      |   7 +-
 target/riscv/tcg/insn_trans/trans_rvi.c.inc |   8 +-
 target/riscv/tcg/op_helper.c                |  10 +-
 target/riscv/tcg/translate.c                | 101 ++++++++++++-----
 tests/tcg/riscv/zl/zl.S                     | 165 ++++++++++++++++++++++++++++
 tests/tcg/riscv32/system/meson.build        |   9 ++
 tests/tcg/riscv64/system/meson.build        |   9 ++
 15 files changed, 359 insertions(+), 73 deletions(-)
---
base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
change-id: 20261117-zl-master-8ebcaae0953f

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


