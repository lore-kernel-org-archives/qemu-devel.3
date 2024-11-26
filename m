Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8412FD3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw6z-0002fL-4Q; Tue, 26 Nov 2024 09:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw6v-0002dy-Gs
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw6q-00055o-UO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3824709ee03so4080536f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629606; x=1733234406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+0sZwpxsobSsA+pG02o+USrr/StGVaNcWk3HwjSvUks=;
 b=KqZ39sRIwu7dtWm6AFUYQHp/S+KI3eh6q62/hPxuW45pKYmhc+1DQXid4Kxq49HfXu
 y8OZSY9KIK1N+LS3/q/ZIfxxacOvIwOPFOChyM65wg/2Fh2Glu7pHPbkd5ZEBadymmmn
 X5dOxrPTUyrhAL1nMKgUvNOWGsyo7UO4LQHCAcs5A/kCCwHMFef0bt/Xg7H63Y3fBHtq
 lINsxhUtlFMSCneHBQpemYv2Xboe4uIKCOWAq1dgP14sQXptnz1rsUoYOuRzIINiTAcI
 sWjIrYP8GlM5plKmu5ATme2UXzJsHFjHhdWOVkWjEb/KcEnmRFQeA60whW+kb7OT/chI
 xKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629606; x=1733234406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+0sZwpxsobSsA+pG02o+USrr/StGVaNcWk3HwjSvUks=;
 b=AsixAeBiOWHF+yzWuoZkxgGbWL3fPZifww5K5BX5pfW79WjWnSmT3KHiTVWjk+EZ+G
 rvhGS8FbOg6wfTJhyvWfaU7SUzNhpAQEx785VEX3lqAMzEpb+EBsaew7+jGKs6GqkNZ8
 3WHYQM0tUl7knjZQ2EXremFaBi9aqq3qokRjpvE/zCjkUC/4hcDRUoxAcm6pCnkQNHXW
 HHjsuH3eyGA2ABOXrRCzCj0Iy7JZc11ZKQHxW8GMIsxNZDqhJPqBFkbqZpDWz/h2Bfiv
 tYBVGHXNB0tDcbExnU0g5T9C9jVTUzjIMgzdZ/HABRqL+ruFKloC5wf2NLs+E44X0/j1
 8hyQ==
X-Gm-Message-State: AOJu0Yy94KsPCMaN4XPyspzrW19iQjc+49HPLpF/nHEUgLI+hLtgF9op
 jHv4gFCKEs8gWyUEL45yuB5+r47UD2bqlzBlzugQZqrpDluY07Kl2Hjd0SBg/2hoNURz1XF3YMO
 A
X-Gm-Gg: ASbGnctq1UsibvPwJOuuFLzLYocNgcAyxT5D2gCjQClaxWvAhf0S6QTFdObuSOtuMmW
 6GeGmhxmaSwYAATrKRX26+k3GFXaQy3eIUQtRXmq0yayIU4jjXQJ4bqP1fRL8v2KijyK8ZEta2E
 TS1SkLbrMjiQ4kiPQoIVrSuYoAyFJBgV/kP195mlPPo4NyxalQa8P3AXfo3umgpicLjRmdRT394
 +y0+3jk4pNZ394A3xgFKOmuQ35sLRuXLrJsGEbKB5fKzWWTeEpxFIMRlv9ZelWpnHOj3q9EFo14
 JQ==
X-Google-Smtp-Source: AGHT+IG7gGAP67jgBu1mknnL9S4x1BtJWJAvy28E0l7RjNbPTfaRjo0tRl+siV3CgCZyRdrDQHzYZA==
X-Received: by 2002:a5d:6486:0:b0:382:38e6:1ed8 with SMTP id
 ffacd0b85a97d-38260be52bfmr11122986f8f.49.1732629605795; 
 Tue, 26 Nov 2024 06:00:05 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafeceesm13405630f8f.37.2024.11.26.06.00.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 00/16] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
Date: Tue, 26 Nov 2024 14:59:46 +0100
Message-ID: <20241126140003.74871-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Since v2:
- Fix translator_ld() calls
- Add support for 48-bit nanoMIPS opcodes
- Convert Load Immediate opcode
---

Prepare buildsys to decode micro/nanoMIPS opcodes using
the decodetree script.
Simplify gen_lsa/dsa() and convert micro/nanoMIPS LSA
opcode to decodetree.

Philippe Mathieu-Daudé (16):
  target/mips: Extract gen_base_index_addr() helper
  target/mips: Extract generic gen_lx() helper
  target/mips: Convert Octeon LX instructions to decodetree
  target/mips: Call translator_ld() in translate_insn() callees
  target/mips: Have gen_[d]lsa() callers add 1 to shift amount argument
  target/mips: Decode LSA shift amount using decodetree function
  target/mips: Introduce decode tree bindings for MIPS16e ASE
  target/mips: Introduce decode tree bindings for microMIPS ISA
  scripts/decodetree: Add support for 48-bit instructions
  target/mips: Introduce decode tree bindings for nanoMIPS ISA
  target/mips: Convert microMIPS LSA opcode to decodetree
  target/mips: Convert nanoMIPS LSA opcode to decodetree
  target/mips: Add gen_li() helper
  target/mips: Convert microMIPS LI opcode to decodetree
  target/mips: Convert MIPS16e LI opcodes to decodetree
  target/mips: Convert nanoMIPS LI opcodes to decodetree

 target/mips/tcg/translate.h               | 10 +++
 target/mips/tcg/micromips16.decode        | 20 ++++++
 target/mips/tcg/micromips32.decode        | 19 +++++
 target/mips/tcg/mips16e_16.decode         | 17 +++++
 target/mips/tcg/mips16e_32.decode         | 18 +++++
 target/mips/tcg/msa.decode                |  3 +-
 target/mips/tcg/nanomips16.decode         | 16 +++++
 target/mips/tcg/nanomips32.decode         | 14 ++++
 target/mips/tcg/nanomips48.decode         | 16 +++++
 target/mips/tcg/octeon.decode             |  8 +++
 target/mips/tcg/rel6.decode               |  4 +-
 target/mips/tcg/comput_translate.c        | 21 ++++++
 target/mips/tcg/micromips_translate.c     | 43 ++++++++++++
 target/mips/tcg/mips16e_translate.c       | 28 ++++++++
 target/mips/tcg/nanomips_translate.c      | 43 ++++++++++++
 target/mips/tcg/octeon_translate.c        | 12 ++++
 target/mips/tcg/rel6_translate.c          |  5 ++
 target/mips/tcg/translate.c               | 84 +++++++++--------------
 target/mips/tcg/translate_addr_const.c    |  4 +-
 target/mips/tcg/micromips_translate.c.inc | 29 ++++----
 target/mips/tcg/mips16e_translate.c.inc   | 24 +++----
 target/mips/tcg/nanomips_translate.c.inc  | 54 +++++++--------
 scripts/decodetree.py                     |  4 ++
 target/mips/tcg/meson.build               | 11 +++
 24 files changed, 392 insertions(+), 115 deletions(-)
 create mode 100644 target/mips/tcg/micromips16.decode
 create mode 100644 target/mips/tcg/micromips32.decode
 create mode 100644 target/mips/tcg/mips16e_16.decode
 create mode 100644 target/mips/tcg/mips16e_32.decode
 create mode 100644 target/mips/tcg/nanomips16.decode
 create mode 100644 target/mips/tcg/nanomips32.decode
 create mode 100644 target/mips/tcg/nanomips48.decode
 create mode 100644 target/mips/tcg/comput_translate.c
 create mode 100644 target/mips/tcg/micromips_translate.c
 create mode 100644 target/mips/tcg/mips16e_translate.c
 create mode 100644 target/mips/tcg/nanomips_translate.c

-- 
2.45.2


