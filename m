Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A901CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDU-0004TS-Ew; Mon, 11 May 2026 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCA-0003xA-Uw
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRC2-00061T-Vd
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:15 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so4731295a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508065; x=1779112865; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3eqSPE3Submx9ZcwazarbYXPZO6TQxftnN02xfQJBZQ=;
 b=HFxC3an5uU0cmHgEKNPgdZ+y9sp2UL7tGGh31PFILusQ3wKyBTPYw/73imxxGLhsod
 t7O/8xqVVWnH3C1ezW95sgKDu97p/Zlg1hA95zyMrJINWvxzGQfTQQZZ+Blfr5HmflEG
 0OypIEFC110Oza/RZiBnauKjpi7y02Xqwzj63VU03FGpstRwsNz86A9EP7LsfMVeOYBN
 meOdVNTz7GGXPRqMG6DiS7y31TNVFGwYevQiUR5ULdXL/ClJcnq0aj/31VvCyctDd+SV
 lyjS3R5Qf6M5cQBLzyCKeC7NShtowgiw+dXpD+STVs9+iZ/gnGM3G3KMBvkLNJ6qzyOG
 DtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508065; x=1779112865;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3eqSPE3Submx9ZcwazarbYXPZO6TQxftnN02xfQJBZQ=;
 b=ZS9BcVyTG4ND94jgYEZXwUFoMWbavMKhpwuwfsfUwEk4gD+42PDHi3lk/v9JgrBQdW
 dzkTMQAL7/FhewmrTx6CZZaegn9PYvLyRMr+JAvBzEO6zw8ikrLGUiZ4pILdxvBheKBb
 xXZc3jakdGDo1y7yjHvzfgKMkffxdKH+tnKqTXX2HMi1J0+ECbZXclyzdgTtR8B7zJF2
 JyptCh6WxJrOPQEJu5rmXvycdinyb6jLAbpIOBOKOHLp95Cj/+XQPcBlugLpkn7AnFgu
 YMamWs/l4koEoSUoZJNZlWMvZaabN3XVxwoZTQQSkatU0yXM96CwbgxHNJtjQ+1JemC7
 OGPQ==
X-Gm-Message-State: AOJu0Yz75YR6OLT1AkiK1X9kEla8zSnei2nIaSHYXAaJatUwCNxMngZ7
 bg+bY4A+0HoAaJl+aX204g9fnaRzvPlcxDq0xr4h35+EIzn4XANTROcW
X-Gm-Gg: Acq92OHxnRDYbuHBHOlEC4VgGh8JTGB5/4d9E4e+F3/66PE/NgG8cH6T2GdXD+XiUD4
 gPKVi4XfcP43wLEsJ3Fku7nMH7HVQNIMky408SYM2NSy8sF2zH1pBi1JLWOgfruyAFMWsz6qKRr
 8v5Fm3FhHIF9wZl/I1SLgUdW0jlDjqBC3L5EOVhrcVcOt920NGAQy7ErBey8yhlkRrODqa0uxg4
 jMoMqCrMl8SKVjFUMJXRvnKrDbawdD7RKR5VlequpYEzuJ6jW8sV0M/CEn6YQskvNhKTXI6ed0O
 ntVKUaMsUq/iYYnYW5LxWj/fKuC9yoq+dRAxlRCNmp5BoIIzWxhrI7JdnQr5W23Jn/k9bXbag1d
 EX1984h4kFdSfUalLSA/+D+Oi9thpeNlAzafM0XlgNFkg7vKbrZsO+ctc86vsRhJqdI8DxSiSwK
 C84+jJLKhtdwHYNyj69WRMVMlvpJ1/U/2Vwxzkb4aC
X-Received: by 2002:a05:6830:6b0b:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7e1dee81175mr14384517a34.6.1778508064938; 
 Mon, 11 May 2026 07:01:04 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:03 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Subject: [PATCH v6 00/15] target/arm: add support for MTE4
Date: Mon, 11 May 2026 10:00:58 -0400
Message-Id: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13PwW7DIAwG4FepOI8JDJiw095j2sFLTIu0NFMSo
 U1V3n1utak0xx/z/bIvauG58KJeDhc1cy1Lmc4S8Omg+hOdj6zLIFmBgWCtSTozrXpc2WuM3hD
 KgDun5P/XzLl837re3iWfyrJO88+tutrr61+LtU1LtdroCJxDnyFiTq/Hkcrncz+N6tpSoZXYS
 hCZKFqAj5gp4l66f4nGmtBKJ7JDMkNKnIH9Xvq7dA83Vy9yIMrGxSC3D3sZ7jIY38ogEhwQ+o7
 R9Q/bbtv2C7QA4IeKAQAA
X-Change-ID: 20251109-feat-mte4-6740a6202e83
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=5668;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=SK5q1H5I9CXbhkzwKm1EpLHwA9mUPunZAQ5iIOup6vU=;
 b=4sbgazomPUAfMQloeY0nZGBNBUbRg0eI3ApK78QXy/5BEHmcDVuyPijd6osO7fcVgWrOCdLfc
 1B0iWdAp6NDC5aNA1PtuoDwarP3uUWCpEVb9I8od8t19QQD9VAvdG93
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=brookmangabriel@gmail.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series implements ARM's Enhanced Memory Tagging Extension
(MTE4). MTE4 implies the presence of several subfeatures:
FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
currently implemented in QEMU. This patch implements all five.

Testing:
  - Included for FAR and STORE_ONLY.
  - The MTE_CANONICAL/NAT test from v2, modified so MTE_CANONICAL is
    enabled in user mode (removed from tree in v3).
  - A bare-metal testsuite that sets up page tables for S1 and S2
    translation, to test the Tagged NoTagAccess fault.
  - The bare-metal testsuite also was used to test LDGM and similar
    instructions not permitted in user-mode.
  - The bare-metal testsuite also was used to test the mtx related
    patches.

Thanks,
Gabriel Brookman

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3116
Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
Changes in v6:
- Moved certain functions between patches (Richard)
- Added G_NORETURN to canonical_tag_write_fail
- Updated ldg and bounds check functions to Richard's versions, tested
  these
- Link to v5: https://lore.kernel.org/qemu-devel/20260504-feat-mte4-v5-0-232a648e63c6@gmail.com

Changes in v5:
- MTX check feature split into three commits as per Richard's suggestion
- MTX passed down to instruction helpers in a new argument
- allocation_tag_mem_probe checks for probe in MTEPERM case
- tbi helper combined into tbi_or_mtx_helper
- MTX checks added to sme and sve functions
- bug with type conversion in LDGM helper fixed
- fixed multi-page tag-check bug and multi-page ST2G bug
- removed erroneous changes to _stub functions
- reorganized PAuth & MTX interactions to make them more readable
- Link to v4: https://lore.kernel.org/qemu-devel/20260309-feat-mte4-v4-0-daaf0375620d@gmail.com

Changes in v4:
- MTX now interacts with PAuth.
- Canonical tag checking only takes place in canonically tagged regions
- MTX bits enable tag checking
- MTX bits are placed in MTEDESC for access in mte_check helper
- Separate feature bits are used to delineate each feature
- PRCTL functions renamed and refactored as per Richard's suggestion
- Link to v3: https://lore.kernel.org/qemu-devel/20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com

Changes in v3:
- Added prctl for MTE_STORE_ONLY to linux-user
- mte_check is no longer generated on read when STORE_ONLY enabled
- Implemented LDGM instruction
- Removed "long" datatype as per Richard's suggestion
- Implemented masking for VA range checks when MTX bit enabled
- Implemented MTE_PERM, with NoTagAccess attribute
- Removed user-mode test for MTE_CANONICAL, since can't enable in
  user-mode.
- Removed TBI from mte_check generation logic
- Link to v2: https://lore.kernel.org/qemu-devel/20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com

Changes in v2:
- Added tests for STORE_ONLY.
- Refined commit messages.
- Added FEAT_MTE_CANONICAL_TAGS and FEAT_MTE_NO_ADDRESS_TAGS + tests.
- fixed TCSO bit macro names.
- Link to v1: https://lore.kernel.org/qemu-devel/20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com

To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

---
Gabriel Brookman (15):
      target/arm: implement MTE_PERM
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: mte_check unemitted on STORE_ONLY load
      linux-user: add MTE_STORE_ONLY to prctl
      target/arm: emit tag check when MTX without TBI
      target/arm: add MTX to MTEDESC and DisasContext
      target/arm: add canonical tag check helper
      target/arm: add canonical MTE check logic
      target/arm: load on canonical tag loads ext bits
      target/arm: fault on tag store to canonical tag
      target/arm: skip tag bit bounds check if MTX is on
      target/arm: tag is not a part of PAuth with MTX
      docs: add MTE4 features to docs
      tests/tcg: add test for MTE FAR
      tests/tcg: add test for MTE_STORE_ONLY

 docs/system/arm/emulation.rst        |   5 ++
 linux-user/aarch64/mte_user_helper.c |  11 ++-
 linux-user/aarch64/mte_user_helper.h |  14 ++--
 linux-user/aarch64/target_prctl.h    |   6 +-
 target/arm/cpu-features.h            |  15 ++++
 target/arm/cpu.h                     |   5 ++
 target/arm/gdbstub64.c               |   2 +-
 target/arm/helper.c                  |  36 +++++++--
 target/arm/internals.h               |  40 ++++++++--
 target/arm/ptw.c                     |  60 ++++++++++++--
 target/arm/tcg/cpu64.c               |   8 ++
 target/arm/tcg/helper-a64-defs.h     |  16 ++--
 target/arm/tcg/helper-a64.c          |   7 +-
 target/arm/tcg/hflags.c              |  25 +++++-
 target/arm/tcg/mte_helper.c          | 146 +++++++++++++++++++++++++++++------
 target/arm/tcg/pauth_helper.c        |  18 ++++-
 target/arm/tcg/sme_helper.c          |   4 +-
 target/arm/tcg/sve_helper.c          |   6 +-
 target/arm/tcg/translate-a64.c       |  45 +++++++----
 target/arm/tcg/translate.h           |   3 +
 tests/tcg/aarch64/Makefile.target    |   2 +-
 tests/tcg/aarch64/mte-10.c           |  49 ++++++++++++
 tests/tcg/aarch64/mte-9.c            |  48 ++++++++++++
 tests/tcg/aarch64/mte.h              |   7 +-
 24 files changed, 487 insertions(+), 91 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20251109-feat-mte4-6740a6202e83

Best regards,
--  
Gabriel Brookman <brookmangabriel@gmail.com>


