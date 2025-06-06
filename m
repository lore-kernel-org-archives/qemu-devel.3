Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDCFC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNRSO-0005Cm-W4; Fri, 06 Jun 2025 03:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uNRSK-0005Bo-KK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:25:39 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1uNRSH-0007ZP-QG
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:25:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-312028c644bso1418877a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1749194731; x=1749799531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eqQgg7FhIoL/447jsGOcCEkgWZv5U2WvjQztrTXd0ZU=;
 b=LIYhJSq9/V9PYT+INuLGvO4VBzSGsee5quRNn46rmQwdTb+cS1uDahfSCrCNL3KxTF
 piJvOxtLR/HUKS92xZ2jTiyVdN24riS4UMODyScffXz8wp45CpFkiQwP7RvbRP5u1iIC
 F4F+2BuJSraMA/hj+PgOsO29GUL3klGCLCRdHvKNzJQwzFnzA38ED/pPGw2Rf5v4aFBn
 NmR+LgRcVCi4WpxWDqkbV4DpF61dqYO4574GX57nCvIezedvOlVJFylnpzSUtJA25NF+
 3TuOFwsEhfJ/pRgxBLBaVLXf6UIOS6zKpR3wK6zloY08mHAYccQVMFuwAEFDtNvqLHDT
 FAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194731; x=1749799531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqQgg7FhIoL/447jsGOcCEkgWZv5U2WvjQztrTXd0ZU=;
 b=gPg+HwIJ7+P+LdE5h4kAqxTeI08MW/Yydm86pXBSZzH4y6bth/r21fuDgk74pv322G
 Hq2Uso9nD+7TIjiu/91KN0CnEPxWWrulBN3SwooblePVLqGgIVSrEJ/SyxwxeLYqH6Dw
 +c7yCpMP5BbxxsRwqj2/a5zJ5I6tw+zUiMJJQJ8vLatacaEHWekdS+BhqvfiBkeAzRCE
 QhG+EuaF+pRa2eEeRB6VxGsFnRDksceTTEiM1Z390cBB0fBlJOAWM2OEfUBtWrJMCOB/
 UK3v8Nv3IHHxoSf9iyhp4OoLbq7CgocgS4M7thzP+n5woJXWOvSasD4EnbXI4YheGQ72
 bioQ==
X-Gm-Message-State: AOJu0YzQsv3NcXK5R19/BaH8QFTSQjjsMcmcXrbZwiM3zBPtts8Ug88R
 YdUVf2zXmPblRmKofGORCYuzokR0QAjqCq4t7mP4wFL3u6rvjQbnp0d0T1/142zmf4xUbzuMKs9
 jgMkpehZhHhV0TPZUNL1T8z4m/75nBwUowlMVu/fVqf2qiFNxXB7gsrPUcwZrPaAzdQR6Ahjpre
 CMbe/7h4FKsC0U4MmEV20rYnD5cog54cna1EXAnu70
X-Gm-Gg: ASbGncumXXq9rpYEoOZXDoJxuW5Lp5g5PnRYla0CQnmsJIY9hvUV0OiT9CTeqrCiVex
 9SlCWBQ7xOLSC8fmTRxguCBBlCTiTIe6vu+vsDfCKT6M7ZoZ0RFl0rLhbm57Wr3T5CcQkC8GMcT
 QTCzxg/xCLkgKXQshY41dzPZmze2IH9i+qbZyDyRqWepjq4BYT2Mhbvi1KU/jLlYubkBNWmYnOd
 iBMg1dckKkPq57ChG7CIiCMTh4STl0UwXQAFlzZe5hAu6YzQXJDxKOAa+tUvA0xZv7y/VbvmkKG
 uiQp1I7jiDdAEgVsoujroPEYBPCagoZxgZVTGJz75Q/qp2JL+jQQd1SqOEV7kWP/SEfxYhmNuU5
 brUxRjlb2dLRZ6hI=
X-Google-Smtp-Source: AGHT+IH3uP+SzyW+Hb0EtoTBQrLVDPauSC7nKygY/6do2xIwQgfQRdL0UNdsEIj4gKOeVO7B9nsO3Q==
X-Received: by 2002:a17:90b:5345:b0:311:ffe8:20e9 with SMTP id
 98e67ed59e1d1-31347308c79mr4429732a91.17.1749194730855; 
 Fri, 06 Jun 2025 00:25:30 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349f17bddsm774703a91.9.2025.06.06.00.25.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 00:25:30 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v5 0/2] Extend and configure PMP region count
Date: Fri,  6 Jun 2025 15:25:23 +0800
Message-ID: <20250606072525.17313-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The first patch extends the number of PMP regions supported up to 64,
following the RISC-V Privileged Specification (version >1.12), where
RV32 can have up to 64 PMP regions configured through 16 CSRs.

The second patch makes the PMP region count configurable via a new
CPU parameter `num-pmp-regions`. This allows platforms to adjust
the number of PMP regions without relying on a fixed default value.
If unspecified, the default remains 16 to preserve compatibility.

Change log:
  V5:
  * Dropped all pmp_regions = 8 overrides except SiFive-specific cases,
    and every other vendor CPU should set its own default if they want.
    (based on feedback from Daniel)

Jay Chang (2):
  target/riscv: Extend PMP region up to 64
  target/riscv: Make PMP region count configurable

 target/riscv/cpu.c                |  48 ++++++++++-
 target/riscv/cpu.h                |   3 +-
 target/riscv/cpu_bits.h           |  60 ++++++++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/csr.c                | 129 +++++++++++++++++++++++++++++-
 target/riscv/machine.c            |   3 +-
 target/riscv/pmp.c                |  28 ++++---
 7 files changed, 256 insertions(+), 16 deletions(-)

-- 
2.48.1


