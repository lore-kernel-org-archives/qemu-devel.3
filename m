Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D20BD1714C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32Uw-0008Rl-K2; Mon, 21 Oct 2024 20:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Uv-0008RD-8W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32Ut-0005Sp-2W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c767a9c50so46747925ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555896; x=1730160696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=99fRrREwRl3WLDHY7YPkZuyfMoB4krDPkvPCe88Rg5I=;
 b=kEguL2oPOiHuBV2jaPGDpQ8uB/bM1O3brc8vN418y56ZfVkv0IpBrbMvyi/6grISxz
 FJew9GHtKGjQS19rzzqaSARh42DyP67T6Hw46t3l3zyEKTNorDCPgwX8EdDBgHn9g0hO
 pMzsXj4me8k/YZXGR8oqwqt6DiJY60ONnrCHOw9/CJOzncw1gpvvyBRAfKhzRSbzeWpB
 wyGk78tcfD+MXZ/8/yLIttjUhVTRkL3txK7wklR6PBtVsH4zQx7kzQGmXoeelSbA69my
 A3nh7JjnUYt4MWfo2Ej7DTxaNOvLKX/1FO+j1issUWHpjiT5lz6SSl8sxa/cnr08Exzb
 xt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555896; x=1730160696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99fRrREwRl3WLDHY7YPkZuyfMoB4krDPkvPCe88Rg5I=;
 b=L4krJk1VdNxaUg3+EIn7oiIGDeTktCYrePkdi2AOlpi4yyrHb0zG/+vji2v2qq4ezP
 Whg4T+uo4U2zeenG3oSDlSjKdcb+aabHcC6SLaHWCAgP6KlL0E5sA3ljkuvRtK6RvImy
 5jPm7u5mqBalvfSHHJMJQ0WbhdQNHM7OuUDmr4G2ZmeH48/xsI69S2gRZnp5jUIe8yyq
 OyRt8/tG1IWvnYDYte767dP702+NnBBOhKzPoG2hESbWuAL5c9K/M0VPOZL+F4Ku+Sn4
 ODytbQ2yAMCBmriIZSClhBurWSAWCP52EHvQynMI2e3yMQUPwhqV/z6Za48vfFRwq24X
 7ZQg==
X-Gm-Message-State: AOJu0YwMF3oWKdPNv6iTrArPRmsv2I+0IzCg7P+XRKWtNxsX6N6U9fg4
 VFw2BaHMeSJaM+aiBGAj651I1j0vHuPnFsP0K1L+Qefk//Gw/uLieSEh/1RW36G+XC3D+4N7LAp
 u
X-Google-Smtp-Source: AGHT+IG1bwqZTPiNB8U5+OCVPY+fK/ti72UWB/BnCk3MdJt9zkw/JQjjtAB7kO48fXcXRy6rCIR2VQ==
X-Received: by 2002:a17:902:f789:b0:20c:f6c5:7f76 with SMTP id
 d9443c01a7336-20e5a73413fmr193330665ad.6.1729555896185; 
 Mon, 21 Oct 2024 17:11:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	dbarboza@ventanamicro.com,
	alistair23@gmail.com
Subject: [PATCH v7 00/14] tcg/riscv: Add support for vector
Date: Mon, 21 Oct 2024 17:11:20 -0700
Message-ID: <20241022001134.828724-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Introduce support for the RISC-V vector extension in the TCG backend.

Changes for v7:
  - Adjust cpuinfo-riscv.c probing for vector support.

In addition to adjusting @left, assert expected value in vlenb.
I wondered what would happen if a binary built for -march=rv64gv
was run on a host without vector support.  In my case it got SIGILL
in another constructor before reaching cpuinfo_init().  But that's
certainly not guaranteed.


r~


Huang Shiyuan (1):
  tcg/riscv: Add basic support for vector

Richard Henderson (3):
  tcg: Reset data_gen_ptr correctly
  disas/riscv: Fix vsetivli disassembly
  tcg/riscv: Accept constant first argument to sub_vec

TANG Tiancheng (10):
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp/cmpsel ops
  tcg/riscv: Implement vector neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shi/s/v ops
  tcg/riscv: Implement vector roti/v/x ops
  tcg/riscv: Enable native vector support for TCG host

 disas/riscv.h                     |   2 +-
 host/include/riscv/host/cpuinfo.h |   2 +
 include/tcg/tcg.h                 |   6 +
 tcg/riscv/tcg-target-con-set.h    |   9 +
 tcg/riscv/tcg-target-con-str.h    |   3 +
 tcg/riscv/tcg-target.h            |  78 ++-
 tcg/riscv/tcg-target.opc.h        |  12 +
 disas/riscv.c                     |   2 +-
 tcg/tcg.c                         |   2 +-
 util/cpuinfo-riscv.c              |  34 +-
 tcg/riscv/tcg-target.c.inc        | 994 +++++++++++++++++++++++++++---
 11 files changed, 1022 insertions(+), 122 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


