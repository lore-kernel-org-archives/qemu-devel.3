Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A51C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccGG-00032h-DT; Tue, 20 Feb 2024 21:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGF-00032E-4V
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:03 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGD-0001FM-Fr
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:02 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e466a679bfso114579b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708482179; x=1709086979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehkq9tIAF8xs+P+vh+e2YJT5nFJW1cB1NMu2/G9UKOA=;
 b=ROUGvzXLtEx+jycyJPGKnio6+TjZinoJ/gZSgMxlb/gEXp1LMoNGcI0laZHp4K21w4
 CnSRDaY/slHWUgPJZzGMoaDFibpTORuhgi5mvVqpyoiv5q9W5S0CmhENdIeRepdoJjnQ
 zT/dNE8nU6fg532npDJIj+U9IRwIFPu8qCU0Cnr6veQRpJVU/TGNim9tSowk52aZp/Mn
 izfRHUMmSE6W2nNEPy1QA7ajyFv/Yt/yl0dFdua5ZCSMXxfh6yAfjoiD9avrJ14kNv1M
 +EFp/o6WwPU4ZTHCs0Rg5gI5iOl6eq5u5yp2dUcF+q/n4hA373O9bY+dpqbxpR0N2TOv
 nWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708482179; x=1709086979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehkq9tIAF8xs+P+vh+e2YJT5nFJW1cB1NMu2/G9UKOA=;
 b=i6ZAr23kL+mrm7H6jhLOtnOy1fZswLBZct0wAsozv+LrtxPe6NMptYIwDx4o4SFy1Z
 MlO4PWBJBC8JysDURbCv6MCdv5I9icErkNUlHovxFfs8ZAOZXv41Z4m6mchGVsoTcDAz
 PGlLlyQSTr0iO+I0Czp77NNYak1ukJ+xHboATOE8Hs3LxM/sIYSR9gFHYjAMorV52J8B
 kg6ZJH1ngFy5H+smGIJrg3vqV7oaqLHTOzvx9SBwZPUcYDU4n75ZDTjwMUpdzCECjGDT
 WAr+kPcQyQkziZ4M6cSxlvS9Pwhux2O+P2D/GdyEjgeBhkmLef3qaSSWrthUXei+eSNX
 hpAw==
X-Gm-Message-State: AOJu0YzPCnY1fqVILPGjIq2ycim7Oh9CYgzDDO7oLSTjmaT1X9BJHzKO
 5qPXfSP8KH86OWAoakthslMcMEbgVMUwtr5mTLw9vnbhDvLInWINaXQ22Lioetcr7ZXIw0Nq2Ae
 6
X-Google-Smtp-Source: AGHT+IFmO7Ct6NdZo8qcrd4WsvKpTOaQp2ApAPVYmJFwFrKY4ml52zAcLecsSTGXMXSTXO0a3bA+RQ==
X-Received: by 2002:a62:8185:0:b0:6e4:870c:19b0 with SMTP id
 t127-20020a628185000000b006e4870c19b0mr2223060pfd.24.1708482179326; 
 Tue, 20 Feb 2024 18:22:59 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a634945000000b005dc48e56191sm7183355pgk.11.2024.02.20.18.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:22:58 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 0/7] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Tue, 20 Feb 2024 23:22:45 -0300
Message-ID: <20240221022252.252872-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

In this new version we removed the remaining brconds() from
trans_rvbf16.c.inc like Richard suggested in patch 3. Richard, I kept
your ack in that patch.

This change caused the 'cpu_vstart' global to be unused. A new patch (4)
was added to remove it.

Series based on alistair/riscv-to-apply.next.

Patches missing acks: patch 4.

Changes from v4:
- patch 3:
  - remove vstart >= vl and vl = 0 brconds from trans_fvbf16.c.inc
- patch 4 (new):
  - remove cpu_vstart
- v4 link: https://lore.kernel.org/qemu-riscv/20240220222510.209448-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (6):
  trans_rvv.c.inc: mark_vs_dirty() before loads and stores
  trans_rvv.c.inc: remove 'is_store' bool from load/store fns
  target/riscv: remove 'over' brconds from vector trans
  target/riscv/translate.c: remove 'cpu_vstart' global
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls

Ivan Klokov (1):
  target/riscv: Clear vstart_qe_zero flag

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 292 ++++++---------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
 target/riscv/translate.c                   |  10 +-
 target/riscv/vector_helper.c               |   1 +
 5 files changed, 100 insertions(+), 251 deletions(-)

-- 
2.43.2


