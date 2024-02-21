Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E302C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuC5-000450-HK; Wed, 21 Feb 2024 16:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuC0-0003p9-JW
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:31:52 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcuBy-0004E2-9u
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:31:52 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc09556599so9324565ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708551108; x=1709155908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ngFPsHcLvSIetwsO8hn0Re76JJe/rAv/Vqg3q6qteo=;
 b=ZAns/UkJd4/sKZI9PEeJp+dkzOPOcDrC2o2yyUHvcbo2lhfpUJ2CXT2XSSlbKvNB7D
 QhwK7L5UAHYcZIwhWK9CtDyuSlDeycaOuhcnKHsbVT0HRVbeHX34WghD7F19IhCsCrHP
 I2qahW5B0+lgXM6QmZDb5OnuVvdF+zhcRcAr11L+Rr1F0tLVb1SX0qXNFXyBKtlGO91n
 34zaz0Z5/OR7ZeUmYFcIwkdwzArvPuTp2qYESKWDMsZpBYoGjdQJAX9WQM4ESTlW480s
 jFa9mDV3i4O2XTgt5Bj49PDga5W+NGzRq+9Wemd0O/y1DRyi+k1eSIScHTgmiBG7XacN
 a7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708551108; x=1709155908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ngFPsHcLvSIetwsO8hn0Re76JJe/rAv/Vqg3q6qteo=;
 b=LsxGl8Zbx1pkBEp3Dps3fPDRDEL3RkCGfPKAOHiIFLOOmUNtojzY0jBLUzI5Gtxsej
 4JUorgV65/9RZuk2HaJ0uM6LkYHYlYyyTCkZ3rPDq3eK+OVEdgcqxAIKRK1FBtq99SN4
 WTyxAStHxpAGj5YPTxl910CSdk6QOs6dncMUTg6AzmiXN4MVKbjZwJ5xzQ3MzwUl3qfa
 +XkoyJy/QYA+T0HSA5VmE7DzADeMCYVYcdWBp9pUy7Gp3q+P+jIYif4PPd75u4C88976
 K9YBNcavPjT2aYVcEUgXKW5AM2j0VejhLfdh8sF+1lSPN4a12iJs072j9tLUj5/kRSQ1
 ImBw==
X-Gm-Message-State: AOJu0Yy1ynxZn62TusI9G9G2KZhh1dZnIWaHigWE6Ifdue8b+/xIYfsQ
 PuzYLvqPjXtMoQeBbEcE8L5+jwsoicnjokJzN8l2DayHooPBDIG11iskNz7SyQYVJEMJzzN2VRB
 k
X-Google-Smtp-Source: AGHT+IEwj2EMpM9JtWQWljEkZ9LIDJ3SoBYBSPv5ro6e8OWCGayS2KTmbLKkelMxk0JcSDERMEIsrQ==
X-Received: by 2002:a17:902:a3c6:b0:1dc:3919:da5f with SMTP id
 q6-20020a170902a3c600b001dc3919da5fmr1769917plb.14.1708551107793; 
 Wed, 21 Feb 2024 13:31:47 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a170902ee9300b001dbb0348733sm6618051pld.67.2024.02.21.13.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 13:31:47 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 0/9] riscv: set vstart_eq_zero on mark_vs_dirty
Date: Wed, 21 Feb 2024 18:31:31 -0300
Message-ID: <20240221213140.365232-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In this version 2 new patches were added:

- patch 5 eliminates the 'cpu_vl' global, and do_vsetvl() now loads 'vl'
  directly from env. This was suggested by Richard in the v5 review;

- patch 9 does a change in how we're doing the loops in ldst helpers.
  This was also proposed by Richard but back in v2. 

Patch 9 is not related to what we're fixing here but let's fold it in
and avoid leaving any code suggestions behind.

Series based on alistair/riscv-to-apply.next. 

Patches missing acks/reviews: 5 and 9

Changes from v5:
- patch 5 (new): remove 'cpu_vl' global
- patch 9 (new): change the loop in ldst helpers
- v5 link: https://lore.kernel.org/qemu-riscv/20240221022252.252872-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (8):
  trans_rvv.c.inc: mark_vs_dirty() before loads and stores
  trans_rvv.c.inc: remove 'is_store' bool from load/store fns
  target/riscv: remove 'over' brconds from vector trans
  target/riscv/translate.c: remove 'cpu_vstart' global
  target/riscv: remove 'cpu_vl' global
  target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/vector_helper.c: optimize loops in ldst helpers

Ivan Klokov (1):
  target/riscv: Clear vstart_qe_zero flag

 target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 294 ++++++---------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
 target/riscv/translate.c                   |  11 +-
 target/riscv/vector_helper.c               |   7 +-
 5 files changed, 104 insertions(+), 256 deletions(-)

-- 
2.43.2


