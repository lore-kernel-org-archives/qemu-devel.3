Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFE0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkdg-0003Ob-S9; Wed, 20 May 2026 13:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkdd-0003I9-0m
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkda-0003OJ-Lt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso4643112f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297795; x=1779902595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C3+j/VboBBWTqP6JT6AzSI813AYe7UsE6MMZpzqeDGo=;
 b=ex3Z8Gf80RcOpDD3CNSquQJFr9vHDJkCdpwocbljHfuoXFl73TTqh0UNGEiUZz8mgi
 I0X2fNOU2L7Ir4vcyhszvladbMoeWROfprHM7FNJ0hluKYT4J1rqeoRDWuMofS5P3hfZ
 xmyGyquf84CdRCM1qeKBEfP8CyPqSZwBjIdejTB1V73MIuRBpyWRMj7WNSq9KEmffkVN
 7S1a86v5daTF2FR1i8kpYmbGgU8sWO+nL+ceR7pmxMQ/H34V5eMIXD1b/I0l9lecbLW4
 kS05TjiHm4N89We2CpM71aeDgyfy41RRw7a6M09nAVNwp6PjH2wjvM1K7oNvPm40vbV8
 7jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297795; x=1779902595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C3+j/VboBBWTqP6JT6AzSI813AYe7UsE6MMZpzqeDGo=;
 b=eHkLQ8CeZJ2poEyE55+fsxUJy1WXf9SecUFIApvTA5T8YtS+thkJB2b6rptKT30f3F
 ntNa4mYxq8GdN+CMHckKWY5ttKe0dRqyV7vVuV1V+/oZ4OMosALVFvDmTTp30+RXySjI
 RosgRPIuM5qZ19jr4M5ARU7I4YTQMHEir/WWkYk7YOA19tzqonXqOkoXMN5b+EEtNNQQ
 YN33/oeQx5baBr7/HfZfl/IbhPbnCdi7mrkEkY7F6Clw48296ZdaX93y2GaIXfEITi8f
 4Tqaq4xIa7agsu9FI4lh27ffeS44uw7gi4qMXj550WPUYx+J836qaBNEoQDc+/GmNs76
 umFw==
X-Gm-Message-State: AOJu0YzgUkaRfAn/U3fXL9JbgDwz4hg15jiw0RCBZt4rj94V9OvTBBpl
 BL1l/jnv/H9LCfJ5YzzNPpKWFYrRL7Rnc0kKEuzRxUe0zJIbVWzz/rZQspAqa5iwQvBIQBObayR
 zL5TXzkk=
X-Gm-Gg: Acq92OGrLUmZPSIzjkgT7YI9NEGNPx99A9I68kAEWkKyc2VJXM3UEHdLbKcePEpnKOo
 nLiXg59bc92sYDW4arL8RSAFE3ufG55CaBn5hCIIU+f3OUB4Mfl5OaJHIJqJKVov0jpYv4D6go7
 1WJX951guhQ3JOqsIz4utFDaZL6RzYpjOHyaHBDdNip5NiRURmRKxCyDkHytnwTvoyfGmrMRNMb
 rZRwWQnh8l3LJbEQcEaiW1SqrwvGqyWSKYzy1YqUnCpFeiE3o6+/yhf9h69/hww7DWEBSpUcn7L
 77boYmL/BlUR05X4ulDxMhvaoAIOreCy45hsrygX0Uw7Fv2NnpbYHl9B8mzzDSntphoxZ+SX/po
 1qjmCgVDr2bQWF7DCWyoTVrEKdjkCmx91vHvlGwzUjdFfZG/c4gX7oPeSPWa/GPx4bmJKF+zr5E
 MUUViSX+0Kr94de/CS47pwad5TXES9/zJ4kvrW0rMH2w//6ou9Uw4hqh7RyWXnCk5weZCM8RhzQ
 xxJ8Zw6C/w=
X-Received: by 2002:a05:6000:401e:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45e5c59ec1cmr39859280f8f.30.1779297795080; 
 Wed, 20 May 2026 10:23:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm54926096f8f.19.2026.05.20.10.23.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 00/24] target/mips: add missing Octeon user-mode support
 (first half)
Date: Wed, 20 May 2026 19:22:48 +0200
Message-ID: <20260520172313.23777-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Since v10:
- addressed rth review comments (rewording comment)
- pass gen_atomic_*() in do_atomic_ld()
- use tcg_zero_i128() in ZCB*
- re-order TRANS(trans_lx) lines

Respinning first half of James v10, adding tests with each
patch modifying an instruction instead of all at the end.
Split SEQNE/SEQNEI patch to ease review.

Based-on: rth/tcg-next

James Hilliard (23):
  linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
  linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
  linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
  target/mips: expose Octeon68XX floating-point support
  tests/tcg/mips: add Octeon instruction smoke test
  target/mips: fix Octeon arithmetic destination handling
  target/mips: drop Octeon zero-register fast paths
  target/mips: split Octeon SEQ/SNE decode
  target/mips: split Octeon SEQI/SNEI decode
  target/mips: add Octeon LBX instruction
  target/mips: add Octeon LHUX instruction
  target/mips: add Octeon LWUX instruction
  target/mips: add Octeon SAA instruction
  target/mips: add Octeon SAAD instruction
  target/mips: add Octeon ZCB and ZCBT instructions
  target/mips: add Octeon multiplier state
  target/mips: add Octeon MTM instructions
  target/mips: add Octeon MTP instructions
  target/mips: add Octeon VMULU instruction
  target/mips: add Octeon VMM0 instruction
  target/mips: add Octeon V3MULU instruction
  target/mips: add Octeon QMAC instructions
  target/mips: add Octeon LA* atomic instructions

Richard Henderson (1):
  tcg: Introduce tcg_gen_addN_i64

 MAINTAINERS                                   |   2 +-
 include/tcg/tcg-op-common.h                   |   1 +
 linux-user/mips/target_syscall.h              |   3 +
 linux-user/mips64/target_syscall.h            |   3 +
 target/mips/cpu.h                             |  16 +
 target/mips/tcg/translate.h                   |   2 +
 target/mips/tcg/octeon.decode                 |  54 ++-
 linux-user/mips/cpu_loop.c                    |   5 +
 linux-user/syscall.c                          |  56 +++
 target/mips/cpu.c                             |  10 +-
 target/mips/system/machine.c                  |  33 ++
 target/mips/tcg/octeon_translate.c            | 384 +++++++++++++++---
 target/mips/tcg/translate.c                   |  24 +-
 tcg/tcg-op.c                                  |  42 ++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 204 ++++++++++
 target/mips/cpu-defs.c.inc                    |  10 +-
 tests/tcg/mips64/Makefile.target              |  20 +
 tests/tcg/mips64el/Makefile.target            |   8 +
 18 files changed, 817 insertions(+), 60 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target

-- 
2.53.0


