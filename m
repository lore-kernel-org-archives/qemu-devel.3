Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1453AC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JC-0002eU-G2; Thu, 17 Sep 2026 04:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J5-0002df-AX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:25 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J2-0001sj-Ml
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:22 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6d6660191so336443b6e.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633039; x=1790237839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RynKwbDJ5WhIawY0ibtddWnM+8/wOxG1N4h0/aW2ZTs=;
 b=MoKAbHMFcrGhkFYIR3wt9lekhFd7T8GUgSGPv24FsgC4MidCxPJFL6LCs/vfze5f+g
 ONyp2KL+qwNiowP3DVvMuqIO1e0VpzFH6yZ1tUHs2M7tV6pj7E/ovkHF+8grq8IhOjjo
 8/CEwgF0rCilA7O0jA8I2D4mwZGurWOtxjldjYCPDFQ9lYW9vGgk00Rr6CX605x9HuGR
 Aeu779IVHn40qkYLbIhMLr6yGbD+MO8qd+LO6Rc6rjgxyM0ZaaXT3T8t8xaqPw47SMgI
 AGXfw+kUG9IIQgeM95OT+ZInAlS6gcnGnFU4lCcwGjM17mo8xqHkEepuzY2mL/X7JSkN
 h1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633039; x=1790237839;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RynKwbDJ5WhIawY0ibtddWnM+8/wOxG1N4h0/aW2ZTs=;
 b=BuPiqJuc7E3f7ZUEHsgi1Fa8nxySfG+8V/koiIWzzZ1ncp4qPVBHmwnO3oSMdXQK/q
 FV8itM6dfkqVEK3Y5VAp4AjHY6IsKbgpUpEgz7ZSOsCcAeCh0s3mLzLIDfVVKW1eMj79
 AchPTOfYkwCuXVCgPeFU6l9kvoG4j0ZGtUWB5fOq4WTaqFvoxE08uuXI1HjvTB/9NhzS
 fHUPII7YE2lboDfptA1580aAD9+T1whnJFhMGA+4XHu4E5/6SacNV02YTElL+VHmtYu8
 5IeCTj761oCbfgh3KqIKvQGccqwKSFE0U6UqovyNiRGe38UNNgAqci2cLuhAtJhvR0cf
 Hung==
X-Gm-Message-State: AFuF++nCHR1tu2C8ELxuRUMjhYAQhqroz9tSn980++LHP3N8YbiaDISR
 HTLSQcvDsb/fRP/7PgcrjTUZyp2qUDF7Cwe2idsPDRalatGAOjup8hHjFV3w4drLWGTp65Of7/z
 Z2V9IbOw=
X-Gm-Gg: AYBFou1VfuD30YCTkOlJ/72SpVqsiX98HaRewIoHtc6qLvrmX8OZIkkZSMIkSXsFU8s
 tuxAaTqkvil9Y1i10AIyw/zmpGpJqwKisczG+HXIlSoq6xIS8kPZSvyfeK3GAu0jQhnOsa9DlKE
 V7LhPuE6q0G3lnPHx3b864jdJ0I6TjKRIgDAB/Q8pu4enXX1irT00vI4UDOuwpr9mynSgE0vMln
 3Iq6QHRCEMFtesFZsCDq373j053V1z7+uHdxypxB+ebdYFASAx3mYDIp+Qqstky4nKGiSMu1D/W
 M6AoQatzFONUaT1lTjC0SNufeIkfNgQIGChgNt/J2Vwxl20ADef/ZL2hmpI5+7RJwg8cuLvil/E
 QSbnSURzhP8vR40C1vBaBP3sy17cbtuRkl6gdbdeb1wPUdpzkYcHCaS1p3+ciGmJye7svgkoAHS
 O+lWgtVrOYPUdgHbzY5X9y5sP39ZqaNFfHVhIP0tAhkuRb8H/4X6gPchgMLPpnNj56d48MDtJEC
 lTCd6c=
X-Received: by 2002:a05:6808:120e:b0:4c4:73ca:3edd with SMTP id
 5614622812f47-4ca49fded3emr6099285b6e.12.1789633039033; 
 Thu, 17 Sep 2026 01:17:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] tcg: Introduce INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:00 -1000
Message-ID: <20260917081716.946668-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add a complex addressing mode primitive, and some trivial use cases.

This came up in conversation with Matt Turner re his inline jump cache
expansion.  In particular,

-    tcg_gen_shli_i64(h, h, 4);
-    tcg_gen_add_i64(ent, jc, ent);
+    tcg_gen_lea_i64(ent, jc, h, 4, 0);

With the use case in target/i386/tcg, we get nearly full coverage of
all the possible use cases.  The only thing I didn't immediately see
is shifts > 3, which could be visible with loongarch64 guests.

There are plenty of other places in target/ that could use this, but
the shift/add/imm extraction/generation are inconveniently separated.
E.g. m68k address generation, arm add-shifted, etc.

It may not even be worth converting those, but instead adding some
trivial peepholing along the lines of Matt's user-only guest displacement.

Changes in v2:

Based-on: 20260917042823.542588-1-richard.henderson@linaro.org
("[PATCH v4 000/101] tcg: Generic expansion of most operations")

Plus other transitive dependencies.  Full tree at

https://gitlab.com/rth7680/qemu/-/tree/tcg-lea


r~


Philippe Mathieu-Daudé (1):
  target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V opcodes

Richard Henderson (15):
  tcg: Add INDEX_op_lea
  tcg: Add tcg_gen_lea_{i32,i64,tl}
  tcg/optimize: Handle INDEX_op_lea
  target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
  target/loongarch: Use tcg_gen_lea_tl for ALSL
  target/riscv: Use tcg_gen_lea_tl for SH*ADD
  target/s390x: Use tcg_gen_lea_i64 in get_address
  target/i386: Use tcg_gen_lea_tl in gen_lea_modrm_1
  tcg/x86_64: Introduce TCG_REG_NONE
  tcg/x86_64: Implement INDEX_op_lea
  tcg/loongarch64: Import SLADD insns
  tcg/loongarch64: Implement INDEX_op_lea
  tcg/aarch64: Implement INDEX_op_lea
  tcg/riscv64: Implement INDEX_op_lea
  tcg/s390x: Implement INDEX_op_lea

 docs/devel/tcg-ops.rst                        |  4 +
 include/tcg/tcg-op.h                          |  2 +
 include/tcg/tcg-opc.h                         |  1 +
 tcg/aarch64/tcg-target-has.h                  |  3 +
 tcg/loongarch64/tcg-target-has.h              |  3 +
 tcg/ppc64/tcg-target-has.h                    |  3 +
 tcg/riscv64/tcg-target-has.h                  | 11 +++
 tcg/s390x/tcg-target-has.h                    |  4 +
 tcg/sparc64/tcg-target-has.h                  |  3 +
 tcg/tci/tcg-target-has.h                      |  3 +
 tcg/x86_64/tcg-target-con-set.h               |  1 +
 tcg/x86_64/tcg-target-has.h                   |  3 +
 tcg/x86_64/tcg-target.h                       |  3 +
 include/tcg/tcg-op-def.h.inc                  |  1 +
 target/alpha/translate.c                      | 20 ++---
 target/i386/tcg/translate.c                   | 27 ++++---
 target/mips/tcg/mxu_translate.c               |  3 +-
 target/mips/tcg/translate_addr_const.c        |  6 +-
 target/s390x/tcg/translate.c                  |  4 +-
 tcg/optimize.c                                | 66 +++++++++++++++-
 tcg/tcg-op.c                                  | 43 ++++++++++
 tcg/tcg.c                                     | 22 ++++++
 .../tcg/insn_trans/trans_arith.c.inc          |  4 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc   |  5 +-
 tcg/aarch64/tcg-target.c.inc                  | 11 +++
 tcg/loongarch64/tcg-insn-defs.c.inc           | 30 ++++++-
 tcg/loongarch64/tcg-target.c.inc              | 15 ++++
 tcg/ppc64/tcg-target.c.inc                    |  3 +
 tcg/riscv64/tcg-target.c.inc                  | 17 ++++
 tcg/s390x/tcg-target.c.inc                    | 14 ++++
 tcg/sparc64/tcg-target.c.inc                  |  3 +
 tcg/tci/tcg-target.c.inc                      |  4 +
 tcg/x86_64/tcg-target.c.inc                   | 79 +++++++++++--------
 33 files changed, 346 insertions(+), 75 deletions(-)

-- 
2.53.0


