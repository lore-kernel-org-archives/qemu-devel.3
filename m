Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDE9C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteX6-0005EK-JN; Tue, 11 Aug 2026 00:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX4-0005Cq-W2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:11 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX3-0002l9-8t
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:10 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so2214508a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424167; x=1787028967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VX4lvEv66gGm/FAXirSpw/rf64WRVgUvNNiW8VEiAzo=;
 b=WLYhdCvZMPcfXX+Wydxh5MhKrZO4KKD+KdeBBRzo3JoHzoSZlr6Yt5HZgCjBP4kDF7
 I5ZrNpwLMx8jD2XO0gI2KH1NLcDf65Xa+6iRLgEfjvZ061ZcJg7AsQbLH7z8pSIelzo1
 4mGXxr7S6O62gU4R9NQGM9vWfYKmZ0twqcRyGq3OFThx2MRaBVI05b6Rni+AAjnF6Cr1
 oDJQMz0pJ3yY/K5cJPExuYViXl9XKkwa+7RLUy0PKpx3b1fvZ+mozryAmVt0DfEhh9q1
 wh2QD0nV9aeFAGNh7tnxsKFE4oicAgFec2UwJ3NWijj289AtwdgxxjuxOoJOssVo3itF
 zJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424167; x=1787028967;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VX4lvEv66gGm/FAXirSpw/rf64WRVgUvNNiW8VEiAzo=;
 b=YrYjdCv9jkz1cUgmNHQqzWoSK51tLT9JP0rUQU3KwZpWhe8kyL2/aRWY2ZiELMqxSS
 3JQ7CWejJ6G/M41p7gtwo1e/BFgtHC2GFZTMRhPphCZInCvRzc3R2sxa8tXAl5f8vB3g
 AO3hm6dAsSn5M9oZmUhDW7mFLI2dVe848ek1RdLI5TWKJHysa9TBc0LXuUD0BaqCNk4E
 qudd6ZAZKJckFsoXqXpS0gYG0zkD61ctv9YBYzBqqukGw5CUgXhX9qFhNJVHENDKY7Ct
 08LXtwQQAuxWpe6H/qaNN4VVU28TfO3LiftVVpSMCKTH/Qtr+FPRRzSgEv2Y9UdhmvBR
 iBNg==
X-Gm-Message-State: AOJu0YxhLWEj3ULZZ75SJbq+RDtXMlzxu3yNJ9qYEAyl8ZCYZQOjWMXR
 awmPmksasWUvAWfnjh0PX3NEAOigzRad2a5PnTWJbqaebAaz0yRRCS612nsK0FNjeZeE/ivJDKf
 SvIHn
X-Gm-Gg: AR+sD11xazjIVFIWsn6XxBIqHr7YKmoeWQZSYFaEuNf4BROh09dXtoUwCRcYkcEYnzS
 pMvrrWTlHudsk0BOS+OrDa4mF2PGdqxlXh85Ongko5CFfCg97KGmWYbSFGakwXDrh7631llg/Yq
 5mGzlEAkqizb8udrBBsFqC0izztdYpSlUJ11EQoboJ2PZhD1onubDOTGqIibIxLSuZjMfcCooVX
 c8MMAsEyTADeTYF3s8vy3qOzEqRtlhs0E4aawJ4dNAGAn7CSuY/Fx7Xue5ruUyIXKwjfv8z9dKV
 onD9ZEUxkveYSyk2p95CqDtUh8aH7l1ahRkmi7JFZHqjK2FXogN03Yv6W1Wwn8j6NQPboB+PmMS
 HfbJWHN6IhwqWXRadtwnKejDQe8Z9i9Neqb5EzQOEM+S7+ShCwGwf/hQGNXYt0h34FPtswHFMrF
 J5rMfV7lThCjsoMWxPTi/GGX8fcshon4iDT2NnAJ/3Yjg5bvKVpWtW4YjWBaUDKX9gHPAGSOmRC
 TuAeZvoTmXN9Rf3UXKTXg==
X-Received: by 2002:a17:90b:1c04:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-392ec7216a6mr566927a91.17.1786424166835; 
 Mon, 10 Aug 2026 21:56:06 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] tcg: Add revbit opcodes
Date: Mon, 10 Aug 2026 21:55:49 -0700
Message-ID: <20260811045605.1246543-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Changes for v2:
  - Add revbit8 interfaces and opcode.
  - Adjust loongarch64 target and host to match.
  - Add riscv64 target and host support for revbit8.


r~


Richard Henderson (16):
  tcg: Fix opcode dump for bswap
  tcg: Add tcg_gen_revbit{8,32,64}
  tcg: Simplify bswap/hswap expansion using bitswap
  target/arm: Use generic tcg_gen_revbit*
  target/loongarch: Use generic tcg_gen_revbit*
  target/mips: Expand octeon reflections inline
  target/riscv: Use generic tcg_gen_revbit8
  tcg: Add revbit{8,32,64} opcodes
  tcg/optimize: Handle revbit{8,32,64}
  tcg/aarch64: Implement revbit{32,64}
  tcg/loongarch64: Import REVBIT insns
  tcg/loongarch64: Implement revbit{8,32,64}
  util/cpuinfo-riscv: Detect Zbkb
  tcg/riscv64: Implement revbit8
  tests/tcg/loongarch64: Tidy test_bit.c
  tests/tcg/loongarch64: Add bitrev smoke tests

 host/include/riscv64/host/cpuinfo.h           |   1 +
 include/tcg/tcg-op-common.h                   |   5 +
 include/tcg/tcg-op.h                          |   7 +
 include/tcg/tcg-opc.h                         |   3 +
 target/arm/tcg/helper-a64-defs.h              |   1 -
 target/arm/tcg/helper-defs.h                  |   1 -
 target/loongarch/tcg/helper.h                 |   4 -
 target/mips/helper.h                          |   7 -
 target/riscv/helper.h                         |   1 -
 target/arm/tcg/helper-a64.c                   |   5 -
 target/arm/tcg/op_helper.c                    |   5 -
 target/arm/tcg/translate-a64.c                |   4 +-
 target/arm/tcg/translate.c                    |   2 +-
 target/loongarch/tcg/op_helper.c              |  21 -
 target/mips/tcg/octeon_crypto.c               |  35 -
 target/mips/tcg/octeon_translate.c            |  49 +-
 target/riscv/tcg/bitmanip_helper.c            |  15 -
 tcg/optimize.c                                |  77 +-
 tcg/tcg-op.c                                  | 186 ++--
 tcg/tcg.c                                     |   9 +-
 tests/tcg/loongarch64/test_bit.c              |  77 +-
 util/cpuinfo-riscv.c                          |  17 +-
 docs/devel/tcg-ops.rst                        |  16 +
 .../loongarch/tcg/insn_trans/trans_bit.c.inc  |  13 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc   |   2 +-
 tcg/aarch64/tcg-target.c.inc                  |  28 +
 tcg/loongarch64/tcg-insn-defs.c.inc           | 960 +++++++++---------
 tcg/loongarch64/tcg-target.c.inc              |  40 +
 tcg/ppc64/tcg-target.c.inc                    |  12 +
 tcg/riscv64/tcg-target.c.inc                  |  27 +
 tcg/s390x/tcg-target.c.inc                    |  12 +
 tcg/sparc64/tcg-target.c.inc                  |  12 +
 tcg/tci/tcg-target.c.inc                      |  12 +
 tcg/x86_64/tcg-target.c.inc                   |  12 +
 34 files changed, 959 insertions(+), 719 deletions(-)

-- 
2.43.0


