Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BFBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJJ4-00045O-Pf; Tue, 21 Jan 2025 13:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJ2-0003zW-SX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taJJ1-0005K2-38
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:48:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21680814d42so99100465ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737485333; x=1738090133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HG44YAgLX/F1jYL73raIbfXoUDahSn4ZA9nq+CnEpzo=;
 b=piVTqquoz8bRAixmi9bY6GyQ/vo3vEy+ZBW+vy1GxUGXHyRw26qwWU4sq6tPnLkIYU
 N3R9v27Dgk4Gurj/85queFoJUgPkU5jeeStGVvlwl7BxRglRsoGYCw3qSzKojWDVBh1h
 QClYB8I2XnWJu91IDOzh5IF9QXN5PqbvqpX9hLnY/aKV29qwUbzkuKYd3gLoqDIGURpO
 gtitS7Tfjns6E71v3Mmi1DKXdSysSTfDTT5xLjbbM71fReTbzRFvzA5tzqiYtD5d+nSU
 lZtIe6DbJc29inC8LaYnCRFfvfTGH0vE7wWWk2mrtPbqUKJa24hFqTxgEawURCNDhSLH
 UW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737485333; x=1738090133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HG44YAgLX/F1jYL73raIbfXoUDahSn4ZA9nq+CnEpzo=;
 b=T8iYMLieqBz2HscaI1WyTzgHBQj4kJVxeJawzPvy06CRVBqNMMvumQSmbSXRwRbvIg
 Hl2Q1dOMHnDSH89wVAXFgDerA4+qN67l43mCo9AZG6i1Lr/asVb/XvWo4UqU/jcXp1dr
 +3wum5ts5ItNzYtnDL9BpYjmTpLf4YJmYZ7fbRmeWQGrYS463L6PzgpGxDqxIfDUk5nf
 HXTVDROPa+Xf7T5PDvlr+34tdSV0G5xNSJP+4JNEXHaVlHaqIWN630A4PBkuC2ncU09b
 P0lXJXTw+C/AnW9NAInrMWmmQh03TDA5cn5djmL6KjX2r3OOQJx+xgmr18/vBRszZPVa
 Rs9w==
X-Gm-Message-State: AOJu0YyCiBPN0nfX7neJC/uMrGWNr3+e8w7iV26ng2/BExZGoT716LOx
 QZl02T2bfK6JKmZmeyVVYGHkGYW3iJJ8EgYMj3r8HwiLswrWQFzV/3uwJUS2/tCpAeyheu+GlDI
 M
X-Gm-Gg: ASbGnct2UqrjZEQfiEz6HRMoiL6gRhPxGfiZS52mIf49mERUq7gZNykMfGjIO8MULNb
 h7Ph8YuWSNqKFmvwkqLmab8d+JnP/V1CaG91Gbgd/cdGi/idV80srrCJlBha4QiLAWCJZ7IrBBI
 60VfXUcFy/5HzBL7sc0DQceqCyxWsrCp5ZN1GOGf8CYR4M9kPEQviQ/hvQ7wlV/5D+xnt5xNfpG
 zXlyHgcEpQtoEVNTULpM6KfBV/RLqBm+/ywJPRU9YyjnzB6LzvtVE1URkOt6eZD7YmXDixw
X-Google-Smtp-Source: AGHT+IHXWsk48Dox1AzMJ4wxxmU09J21v13OZS35EaHo61xoKVYETYf787BNw2+6N4akSg5xIyg64w==
X-Received: by 2002:a17:903:943:b0:21d:3bd7:afdf with SMTP id
 d9443c01a7336-21d3bd7b381mr73503305ad.0.1737485332898; 
 Tue, 21 Jan 2025 10:48:52 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ceba56asm81121865ad.98.2025.01.21.10.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 10:48:52 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/5] target/riscv: Coverity fixes
Date: Tue, 21 Jan 2025 15:48:42 -0300
Message-ID: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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

Hi,

This series contains Coverity fixes for issues found in the latest
RISC-V pull made yesterday.

Coverity CIDs being resolved: 1590355, 1590356, 1590357, 1590358 and
1590359.

Patches based on master. 
 

Daniel Henrique Barboza (5):
  target/riscv/csr.c: fix deadcode in rmw_xireg()
  target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
  target/riscv/csr.c: fix deadcode in rmw_xiregi()
  target/riscv/csr.c: fix deadcode in aia_smode32()
  target/riscv/cpu_helper.c: fix bad_shift in riscv_cpu_interrupt()

 target/riscv/cpu_helper.c |  4 +++-
 target/riscv/csr.c        | 24 +++---------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

-- 
2.47.1


