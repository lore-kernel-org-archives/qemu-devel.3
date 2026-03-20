Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B91098784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3a8D-0001SG-QQ; Fri, 20 Mar 2026 09:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a82-0001QX-Qt
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1w3a7z-0006ns-I8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:43:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so5065745e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1774014181; x=1774618981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sn9ZP3minX46KfLXXqBIYUCihpaQH/kNHzfO/u09ZKI=;
 b=igt0bYTIDd7s+oBg6u5yE2R1xoiYffzqvfELBZJBnbP0ZbqjAPYvOM0RqyM3rH+Q4g
 K7R8svqaslEK0X7ZQ1HL8tjU4fZ6dCDfBpzgFSlpwQz+vLV4keYFl1VaD+S2YCJltjpy
 581JlZp1nNxMIsGYG3kuDUUwJNhvemY//+5R7OWKPLTuPkbGDvLOzOvFa6jwSZ4mAM2K
 m46irb4PHhVLV3TA66e7fmzEgOcYFle99AzzgaLK6V3/CFE6nsLXTvlaQr6WkYNy5z2u
 nWr23QaIugZR8mK8NPJFfSJxeWK7gFgLSrCs6W+SpisyfigyTGhoPfFPyqLO+xiz3/vM
 Jqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014181; x=1774618981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sn9ZP3minX46KfLXXqBIYUCihpaQH/kNHzfO/u09ZKI=;
 b=n+h0ef7cGfFlPT/aXCEnmoqJ/okhftQgfDVqTHMyCR+Hllu0rExv8Jm14Ypvi1W1v1
 GThLtJg4mn5q1+iQxDdiNOzfF5Q9FEIt7hVj3E8QD3Y55bUFl7/PJORLrrF7ub2B4SWY
 0/5/9ctJPyps6W/FLNXm26oabHK2z+LjBcVmONYPxOX8DhcEQEfKt2XgyP2bHUg8bw1J
 lAFeGnckDzdALhndk4zCW1KuU35xwFwGxsNfXx0xnHktzCwGrlFOjzSJ3XkjnhLmJJJu
 pTav9Vb+QZBSa6TNEq8vu/K7V8Q1o5ZsESnJqbXepjzL8z8FupnZ9AfZJhxVu71QYscQ
 aVzg==
X-Gm-Message-State: AOJu0YzI/wz8Q0/oEjZgI6/7vEafxIaqaP1hQRMHccjdOGbLFzAk84tk
 6cZjh80V4zJLYYJON5+RY8XFXc2g8d6TOtPtUF9QlhUj6EYbtfE8it+N6Pqa397tjko=
X-Gm-Gg: ATEYQzzWJ7cmCjEfBHcwI03Pt6WXlT9ZGBJtvV4E4VarPsDhEK3GugkZLGJ6eKqiUxv
 fe720A7GfaTGb3PcuHyF9CvmCY5muV26i1GDiqAQNe7LVOpHtLXL9mW9WlQcxq4I8VwSv8Da+ST
 G5ogVyWlhe4WTj4ZYrk1ef5LfLxnUw31+V12BWkyreh6fsY18eRFvcU7D7Gow5I2163fXVpMwHw
 kjVBRcLCSYC6X+U/8uNIOLXmEBfLhCg3KpL32acV8uzjUcjVPvSV4OqoNeo8RjNqw+wSFNOllJ2
 ni3TLlC9E1AxY6YEYK1YlInKwNQj7BD860XC1qFLCQMyzNorByJc6BLfF+Cs9sRxXlnmpa0v6j5
 2eDwz/sNaghlgCdnqgwXBpmdhCcKnZE1LHDfC3VwuQP2eWHCNaDXEDOVusxy9AV9RmEDjWEkbWk
 KX2Bny8tcnof9//iHtS2I+aSgDBSs5lTsPpTwclHEJkj/C518EvhxiwxagwiSdMbtuVcs3Sx2Wo
 vEHTM+mU6sy2gfVkeKM
X-Received: by 2002:a05:600c:1f86:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-486fedab44amr47764735e9.5.1774014180859; 
 Fri, 20 Mar 2026 06:43:00 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (236.139.189.80.dyn.plus.net.
 [80.189.139.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85ed6asm18328885e9.1.2026.03.20.06.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:43:00 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v5 0/3] target/riscv: add draft RISC-V Zbr ext as xbr0p93
Date: Fri, 20 Mar 2026 13:42:51 +0000
Message-ID: <20260320134254.217123-1-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wm1-x32f.google.com
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

>  This patch fails checkpatch:

Oops, sorry about that. Fixed the license header but the original
`crc32c` file didn't have a `MAINTAINER` so I haven't assigned one to
this new file either. I hope that's okay.

> Please keep previous tags in new versions

Do you mean the `Reviewed-by` lines? I've kept those in this series.

James Wainwright (3):
  util: export CRC32[C] lookup tables
  target/riscv: add draft RISC-V Zbr ext as xbr0p93
  disas: diassemble RISC-V xlrbr (crc32) instructions

 MAINTAINERS                               |  5 +-
 disas/meson.build                         |  3 +-
 disas/riscv-xlrbr.c                       | 79 ++++++++++++++++++++++
 disas/riscv-xlrbr.h                       | 19 ++++++
 disas/riscv.c                             |  2 +
 include/qemu/crc32.h                      | 14 ++++
 include/qemu/crc32c.h                     |  1 +
 target/riscv/bitmanip_helper.c            | 20 ++++++
 target/riscv/cpu.c                        |  4 +-
 target/riscv/cpu_cfg.h                    |  1 +
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/helper.h                     |  2 +
 target/riscv/insn_trans/trans_xlrbr.c.inc | 45 +++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +
 target/riscv/xlrbr.decode                 | 30 +++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-crc32.S            | 64 ++++++++++++++++++
 util/crc32.c                              | 81 +++++++++++++++++++++++
 util/crc32c.c                             |  4 +-
 util/meson.build                          |  1 +
 21 files changed, 380 insertions(+), 5 deletions(-)
 create mode 100644 disas/riscv-xlrbr.c
 create mode 100644 disas/riscv-xlrbr.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
 create mode 100644 target/riscv/xlrbr.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S
 create mode 100644 util/crc32.c

-- 
2.48.1


