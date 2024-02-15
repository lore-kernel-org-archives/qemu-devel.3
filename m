Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79298C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPA-0005gB-37; Thu, 15 Feb 2024 17:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakP8-0005fw-NN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakP6-00064v-U7
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso727635ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036826; x=1708641626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6w64dO6hKqrROeNUBjWN2bBMCJB764mXYbbxFaUddJY=;
 b=eIRpQWE0rgoj2KvbRBbmskOiIFX8sPYUXMSjAswJR5jPhr7tM5rf0usnVxRMQtlnun
 YjR0FM0B8MvNGxAw+PhJ33LaXZ6QvnwKkGFE98ZnfDHreRLxRvoyH3c8tFSOhqWKYwpW
 BsqjvPcoBUbPE8pg1eC+Sh6LBg9MNjbYJIpEVtZvXV/yWChsAnC7Na9R79Ykremf25EJ
 SEti5lJA8en9aJ3+/isJbDVkeDpkll0Ifp/GeeJUfdzIeHDbfI1F08TxJnyBMBjfW9lc
 U0+egHGDsC6uKLXg2c6ubZ7wcUZFvqrJyhKz6+3lva4SEljkZzTFofrNJ9otY2NfEPeO
 Zb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036826; x=1708641626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6w64dO6hKqrROeNUBjWN2bBMCJB764mXYbbxFaUddJY=;
 b=AcwWY26pRKEBVls9CoRTnD1ftyLzS3ERmV4YCaxnTDtTX0oxF63fzDEVI9VqmWj2vV
 OCJ1Cggcfy3mWNgHjAqAKqLqsDlIo5RsNJqslBzmQVmWgv48jkgBZEZKqojTdXervZmk
 yhgRGy43T1fuKMjdXY2L5nanW/I3b2ugkmbYiknU1JAj+iIZSv+FiPTZTM03SwkTAOvk
 AiEy7fRYlXhrC9t/ajjXsS1trp0AgqsUr3R4rZ8oU8W1BByesBa+Bg2P6TvLjTMyu5WJ
 QsFqkoq5tVVatLcvKT60HwhgaQqujLlHw0tynU1+iyAluP/QivB75E8djaHVNLMQOK3x
 mTVg==
X-Gm-Message-State: AOJu0YzEDJwviQlm63mPz7v/XJQWw9dt9h33EBKp9t249QcsEEo/mBhw
 sdnU9a+bk5AZMl5ho+lGoEAznhtNqbjMyYEUsU4XK5oh0yG+6MUS6b65cFdkGwzQWL2EvDypnG6
 8
X-Google-Smtp-Source: AGHT+IHaeEEap3D4QOH3I+KGkg8hueY8PUQdonW88r23+IEa5KRnAtMzrkoGhfAPtPESXHkG8WpptQ==
X-Received: by 2002:a17:902:b7c9:b0:1db:7052:2f39 with SMTP id
 v9-20020a170902b7c900b001db70522f39mr2616538plz.26.1708036826148; 
 Thu, 15 Feb 2024 14:40:26 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:25 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 0/6] riscv: named features riscv,isa, 'svade' rework
Date: Thu, 15 Feb 2024 19:39:49 -0300
Message-ID: <20240215223955.969568-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

This new version is rebased with alistair/riscv-to-apply.next and with
more acks added. 

No other changes made.

Changes from v3:
- rebased with alistair/riscv-to-apply.next @ c93c42a273
- v3 link: https://lore.kernel.org/qemu-riscv/20240202152154.773253-1-dbarboza@ventanamicro.com/

Andrew Jones (3):
  target/riscv: Reset henvcfg to zero
  target/riscv: Gate hardware A/D PTE bit updating
  target/riscv: Promote svade to a normal extension

Daniel Henrique Barboza (3):
  target/riscv/tcg: set 'mmu' with 'satp' in cpu_set_profile()
  target/riscv: add riscv,isa to named features
  target/riscv: add remaining named features

 target/riscv/cpu.c         | 70 +++++++++++++++++++++++++++-----------
 target/riscv/cpu_cfg.h     | 12 +++++--
 target/riscv/cpu_helper.c  | 19 ++++++++---
 target/riscv/csr.c         |  2 +-
 target/riscv/tcg/tcg-cpu.c | 34 +++++++++---------
 5 files changed, 94 insertions(+), 43 deletions(-)

-- 
2.43.0


