Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9D0E63F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEL-0005XL-DC; Sun, 15 Feb 2026 17:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEG-0005Vz-BW
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:37 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkED-00051a-KW
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:36 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4042905015cso1741873fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193065; x=1771797865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zSXLHuUKZOgp+Nbey35qSdAbz8ZepSUL9j+8Gd3FLqg=;
 b=Y76G/Gu7kCJtA+RNl9i2Al9Zz64U7sFv+hCNghq3vyCapxCZcfDX0+XbSZ8Vtalxhx
 mNkwvdn6Q+opfk6k/29XHY5hHbl0Al/ZW6Vm8E+Wc482rPAKMH2KRXBzoAnG7UQyeQ5e
 T5DW6NH2sKYK/P7eSlwmZCGVd8REjUna1CeeqOTO4vqTZkQ/5bSfFnJfvr/dfiJwFt0O
 AyGuPRBMb3WR+QYUe7JYXhB4hYHZ7RsRaHYq3vqxlrek76fO5OJIrYeNz3z81eEslVNJ
 pDj7eLF/W3cQ75oce9DAzDtFTQSGuBylHpqMI1wl0DQFCtfJNLKQRoKqE5DA0/DC85HC
 D1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193065; x=1771797865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSXLHuUKZOgp+Nbey35qSdAbz8ZepSUL9j+8Gd3FLqg=;
 b=tTestUhxqbl6hjWBx9jGpPpDJJiCM+EHJUCYuL77fOFtHE4k1mtQKgwBGX+caoA4m1
 JK3QxmebWgioUxxe7h1Pu7ikW8HMus4U3gDQwxqn6WqctcrKpUT29vXcDRG6Z1+JJlEI
 19dKR6mJYvNiE2QlidF9bwsNgFY2YxFv/ORFvtgc/+Z1D9x8rhyU17iU4I+7l2kdX31I
 fV2bLyKuAws9uDaLzuQBiJVIjRONSdC+RPUpBaWy3M3d5XLqQ3T1lefy5Q4aw7Y79UY1
 gwJd638yGPicgtfhwjOHJWNESWx2cYmWnhOTDlejmx6HTmJu4H+tYuIbipA1zWFV0rOr
 ar7Q==
X-Gm-Message-State: AOJu0YwE4mzu7nJTV+LdRcf+lG4vLA2bBowkqno3i37IE7GHO4KzBu2p
 KWy36QQHsTPrsQ54jxKHyvttsBGP0fCKLchpk8xNqst9eJZZT9Z+jghFctHJsg==
X-Gm-Gg: AZuq6aIpk8aIOuBegiJJy8uPR/hdpXSs+nAfx3XqVkRdc36xD3w3aP9D0sqgIrIg0SF
 Bcg7hNAQllhUEin9AvGIEwHZaD917cV7Qo7mxN64j2+88IIkKtTV82tvuCbOkFh5BpS/bT+QMqg
 26gLpeT7Fd/sgBp5dqMx/Ok5jUFXEnBUGpq9CAa9hvmuospCYr5+JriYqzsXNNnnOKkDJHI+i7J
 KHFRoD+9Gdh8doUrut23WvwITH8lwBqExcuJSC3jWxoCPpUb0/qWrGfnoyyJOnsKr1EP6lh69OK
 Pi1EBOLZt6RN1QAl0HSiJBBa3lI9hb7b518n4Rb4K1kbuCZhv4kQHziyhqv+byhp+f1RmcuiuJU
 iWYb0JlOaLCsrUfQdtRo59j6opbBNIAv/Tfm+YOsk41We5fK783/WtmZzL46tylAfiVy3ewDKfF
 4+tG98N1nOvV74siDuTR68niIpds6kpOcVMJymyior6xmc6pyTHkLkMTL/u5ommM5RgtVA5Zwdk
 JB+mKwTcbLRRiNo
X-Received: by 2002:a05:6870:4203:b0:3d3:ce01:1779 with SMTP id
 586e51a60fabf-40f0d7bf00amr3009847fac.38.1771193065203; 
 Sun, 15 Feb 2026 14:04:25 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:24 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/8] Hexagon (target/hexagon) Check opcodes versions
Date: Sun, 15 Feb 2026 15:04:14 -0700
Message-ID: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2b.google.com
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

Currently, all versions of Hexagon CPU are treated the same, and all
opcodes are able to run on any version.  This series changes the behavior
such that only the opcodes available on the currently executing Hexagon
CPU version can execute.

Changes include:
Mark which Hexagon CPU version is currently executing
Check that each opcode is supported in the Hexagon CPU version
If not, raise SIGILL
Properly handle disassembly (-d in_asm)
Test case added

Note that this series borrows elements from Brian Cain's "Handle some
invalid encodings" series.  Therefore, it will need slight rework after
those patches are merged.

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>

Changes in v2:
- Rebase with Brian Cain's "Handle some invalid encodings" series
- Add older opcodes to tag_rev_info.c.inc
- Change tag_rev_info to use HexagonVersion
      Suggested by Richard Henderson <richard.henderson@linaro.org>
- Disassembly includes valid opcodes inside packet with invalid opcodes
- Remove unused function - snpring_a_pkt_debug


Brian Cain (1):
  tests/tcg/hexagon: Add test for revision-gated instruction decoding

Matheus Tavares Bernardino (1):
  Hexagon (target/hexagon) Introduce tag_rev_info.c.inc

Taylor Simpson (6):
  Hexagon (target/hexagon) Properly handle Hexagon CPU version
  Hexagon (linux-user/hexagon) Identify Hexagon version in ELF file
  Hexagon (target/hexagon) Add Hexagon version field to DisasContext
  Hexagon (target/hexagon) Check each opcode against current CPU version
  Hexagon (target/hexagon) Disassembly of invalid packets
  Hexagon (target/hexagon) Remove snprint_a_pkt_debug

 target/hexagon/cpu-qom.h             |  23 +
 target/hexagon/cpu.h                 |   2 +
 target/hexagon/cpu_bits.h            |   4 +-
 target/hexagon/decode.h              |   2 +
 target/hexagon/printinsn.h           |   4 +-
 target/hexagon/translate.h           |   1 +
 disas/hexagon.c                      |   3 +-
 linux-user/hexagon/elfload.c         |  43 +-
 target/hexagon/cpu.c                 |  31 +-
 target/hexagon/decode.c              |  48 ++-
 target/hexagon/printinsn.c           |  40 +-
 target/hexagon/translate.c           |   1 +
 tests/tcg/hexagon/check_rev_gating.c | 141 ++++++
 target/hexagon/tag_rev_info.c.inc    | 613 +++++++++++++++++++++++++++
 tests/tcg/hexagon/Makefile.target    |   6 +
 15 files changed, 898 insertions(+), 64 deletions(-)
 create mode 100644 tests/tcg/hexagon/check_rev_gating.c
 create mode 100644 target/hexagon/tag_rev_info.c.inc

-- 
2.43.0


