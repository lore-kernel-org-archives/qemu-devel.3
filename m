Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8623E1094478
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 14:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3x5e-0006IK-9Q; Sat, 21 Mar 2026 10:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5b-0006Hu-36
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3x5Z-0003lj-GZ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 10:14:06 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-829b8b6c4d0so2401214b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774102444; x=1774707244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UGlDflTIYr6edYigxi6RCqSooK49D4FtOu462+fyklM=;
 b=mustQ04nzVGmF6wSOuPOS5fvXkA4nPPwTfc43y9PQJ11flNPEAcLp9W9ga6kfVMk4c
 xGkxzm93DtFdEKCWaCNRapNtzeZd56juT8+VEnUgrTbRmBOtEQsWQlpULiuiKKa/BCc9
 rsf3i0Z7BP7lA8BnW92UNXH8FBAGVLWxuOw1mBzHeP7xf+UIJc0e9gaL41UleRABS9M3
 Vs3+XieaQvKLlZCS3zOSjwiZ7pskbWgsTBPFgeajmZmXQ8/8l34emh8k5X/sASmHLTmD
 nMomLi9VY5/BFM/xbgfAmGy8KfZmLdra/utDzfNU6fapu8phGUfvYCKj/kX0fmsqb5M2
 Qqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774102444; x=1774707244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGlDflTIYr6edYigxi6RCqSooK49D4FtOu462+fyklM=;
 b=Z4JxIYU55ARG9gZFg1OD9OlMXakOs7XXTQIyiEwACxmh4MFR8O2OXb2QUjTksAHPa1
 OPpIMqZGNXZksKp1DqzzWxw27W3Mj8T5O84xPidUhTNXXy9yYo8ZZ8gYiJMkjfsyKdcm
 s9aV8IfwVKWHPCpXE8r5dPcqag2UkPQHTHGa3/SYbbWvooefsEQJK2o/YieDhPEpDEVY
 GVGOhNflZRNtGnOO3I5xS2QZDbF3F9+0udppBSK94emWr+8lN/XbFqQbpEkc7fqnYpit
 b591t7ctALZUPDzYea9NZiODLdg5x+zQuys52myqZiyNN29JFKzbg7Nn7JTIWc3ayj2Z
 cYtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZxBMVO/KK09kvWJmvrtRM6eDGyAux/IWdmiNB1fK0Pzf7lVZM1zUXWGE5ni9CvoTAJ+xs+VWH9wG@nongnu.org
X-Gm-Message-State: AOJu0YwTtCYqgnm+8i+mz2MHqopjVbwSA0Sv45TkyG9/pMcpMYeKjPQY
 AH+pRlAggi6BY+mP+6aYl5aMm1O1xLrHMeO2N9nqPBxbc8cdQ90V/vR2
X-Gm-Gg: ATEYQzy7EqsYtzFEOI04Ibj3PtCb3f38tgHiIKhiSVymzrcwjiE8pja/UYV1Dm0i1kb
 P1WDzNQGAGCfhoLb4vpoL8CmgjsKH25LNEOIw+fnOt0UKbDtVbFsN8OTo0jBLVWvo7aQt7dWQK5
 JaNEaN23rHV+OlCK+7po7D3jDH5ydtJpNGWXqPAgx7BKoj906YCKYJgdESVDGUPo4/7MmQ86uj4
 ZIMWMchE5DUFcE12sxmz7ffRbQsan2xW4sfDUZS6TtJZQWlACabdHbDJCxU9VNw5JIDCPlYYMI5
 gWqjSLaEdSCjsTNtxHipYhTY2ccm0gEZOire/GMCrYh/kHFieXl6UKYV+00569+Q5DBYtOv//pG
 dXauKDUKVwBAJRHvP40/rkFdSRZsYRUfW5E7oG0OEqxHcPmmbxbY+vtbpqPuShemql+2sfgHJOM
 //V8iteEqqto6kmnsdaTnYa2u3cmQnBC8rGDavp3EAZMH+aq+aseiZ6fNNAJ6di7+R5wqB
X-Received: by 2002:a05:6a00:1acf:b0:81a:b183:44fc with SMTP id
 d2e1a72fcca58-82a8c22ce0emr5970056b3a.23.1774102443960; 
 Sat, 21 Mar 2026 07:14:03 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040debf9sm4764875b3a.47.2026.03.21.07.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 07:14:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 0/5] linux-user/riscv: add vector state to signal context
Date: Sun, 22 Mar 2026 00:13:38 +1000
Message-ID: <20260321141345.599105-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

Changes in v3:
- Fixed up a bunch of good review comments that Richard made against
  the v1 series here https://lore.kernel.org/all/06afcbdc-28e2-4d13-81d4-26fd257ed8a3@linaro.org/#r
  in particular:
  - Restoring vl/vtype state using CPU accessors rather than stuffing the
    values into the registers directly.
  - Fix ABI types.
  - Fix some confusion with host/guest pointer mapping.
  - Fix error handling to SIGSEGV.
  - Style fixes.
- Fixed build issue without riscv intrinsics header.
- Add some more test cases.

Changes in v2:
- Fix 32-bit compile
- Moved sizeof_rt_sigframe change to its correct patch (patch 2 is the
  one that extends the size of rt_sigframe, patch 3 is adding new
  extended state to the frame which is added dynamically).

This series adds vector state to the linux-user signal handler,
and adds a basic signal handling test case. As a sanity check, I
also verified the signal handling test works in the same way when
run under a real Linux kernel.

Thanks,
Nick

Nicholas Piggin (5):
  tests/tcg/riscv64: Add a user signal handling test
  linux-user/riscv: Allow restore_sigcontext to return error
  linux-user/riscv: Add extended state to sigcontext
  linux-user/riscv: Add vector state to signal context
  tests/tcg/riscv64: Add vector state to signal test

 linux-user/riscv/signal.c                | 281 +++++++++++-
 linux-user/riscv/vdso-asmoffset.h        |   4 +-
 target/riscv/cpu.h                       |   4 +
 target/riscv/csr.c                       |   7 +-
 target/riscv/vector_helper.c             |  19 +-
 tests/tcg/riscv64/Makefile.target        |   5 +
 tests/tcg/riscv64/test-signal-handling.c | 517 +++++++++++++++++++++++
 7 files changed, 807 insertions(+), 30 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-signal-handling.c

-- 
2.51.0


