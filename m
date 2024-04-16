Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5DDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 23:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwrr9-00032w-Du; Tue, 16 Apr 2024 19:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrr6-00032H-MZ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:48 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrr5-0007PD-5j
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:48 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-36a118d3b30so27945385ab.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713308685; x=1713913485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1RmPJZ9KcsiGov9nWtTjzRQZrttVXz+lqoXpp8ZZUdc=;
 b=ZWXJwG4tSefiQ3LaaaEGZE+KXBdGGh+AnUBXPaqjUkA4ZEgZvPTOIQujaR/tNY4pB6
 5GfAKoYu8VYrEq2oKRHgPcFcCEfj5FdkYKCbot2v+x37z2/umffRRKzcK7kI7k4NNagN
 DxEe3Iuty1VQF6cPBQDTYoXodndyjlZRaa6y2KABwn3pbq00weKAKXlKFTVM/OGNERht
 E6CaBdSu9VD1YJxAvmX+H1StcCrroZs8YTAGqUvzDLVVkpIomyHtwr/2BaEsIxWCX6Il
 G4c9EpNZjfVaLzkl0sCXWW1/2BOsQgBNk0HOmqeaYNTT5AWYgIiSFN7jL6bP9VWS6KDJ
 Wjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713308685; x=1713913485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RmPJZ9KcsiGov9nWtTjzRQZrttVXz+lqoXpp8ZZUdc=;
 b=ubVsULn/6FlSiNRyoc8HaUTLNJTpTtvYvaEI3N7uskv1ZQtpgMAL/wuArCSWP7vAHo
 qkU/48ZYIYPXmUubR05RyupaG0r9zQ0xWNs+IBv2kdcks3eGC1RC6uq+7yypfGmIM/Et
 eT6F/BUq+gMU40pkSO6E9DIHcaIcTtHEWQUHoC3Uf453ciZGxF8TeYcLYrwKotjeReRh
 /u72K3+KdW46PVO8WNLdnJNQoEpYTkz09FQ/HKE64fisefuUYke0riQAwq3ewAzhL5B7
 W0VLiDH5T3qgMYmmUaC4JfrzTt9g13iw5/Ho6xHDyg4O40YTJKiQ0/J2CXhOLu+NQjLR
 BCXA==
X-Gm-Message-State: AOJu0Yz+8iFA6HSTAzT4qt8FuSlg5XABWWxjTPkv2c35O1Jxdx9c3HEB
 m+H5vQPEnNaqOutp5WY35whLUco/ZD+u2cNs8Uf6dHL4s26AdTt1+I+AHZJTphQzYiPgMdwuzBF
 3
X-Google-Smtp-Source: AGHT+IHSdgReusM/GN6S+3FF7vXUMkMDMFPkqDSpKxlsF/GCymZZn5X7QFCmTTlHjy/1JuizZurK7A==
X-Received: by 2002:a05:6e02:1a26:b0:36a:ff3a:f135 with SMTP id
 g6-20020a056e021a2600b0036aff3af135mr19307479ile.15.1713308683717; 
 Tue, 16 Apr 2024 16:04:43 -0700 (PDT)
Received: from grind.. ([177.45.186.202]) by smtp.gmail.com with ESMTPSA id
 g10-20020a63374a000000b005e4666261besm9399555pgn.50.2024.04.16.16.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:04:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v3 0/2] target/riscv: set tval in breakpoints
Date: Tue, 16 Apr 2024 20:04:35 -0300
Message-ID: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x134.google.com
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

This new version has a change suggested by Richard in v2. No other
changes made.

Changes from v2:
- patch 2:
  - use tcg_constant_tl() instead of loading a temp and doing a
    movi_tl()
- v2 link: https://lore.kernel.org/qemu-riscv/20240416194132.1843699-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (2):
  target/riscv/debug: set tval=pc in breakpoint exceptions
  trans_privileged.c.inc: set (m|s)tval on ebreak breakpoint

 target/riscv/cpu_helper.c                      | 1 +
 target/riscv/debug.c                           | 3 +++
 target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.44.0


