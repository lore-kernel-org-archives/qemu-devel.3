Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA2CF8FA9E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtK-0003pm-1r; Tue, 21 Apr 2026 13:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEsw-0003lL-NC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:51 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEsv-0006ge-2D
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:42 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4670464029eso2406273b6e.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792459; x=1777397259; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2eIWcEVbGT2Bkdbdk0f71Ip+HemYRMLHjbbivqGNFTc=;
 b=Ff2kxor5bi9jt0ZOS4tIc56xm5uwZbOYW+4p2tqHd7vRZyvK7ZET+oC/fsDCIOyW4p
 uqC6CUiB/c4q+ZlZZRPUhHOmE8Dd5pFvznYhkb/x2HfM1flV8XMspg2IOIzhIKUkuYhq
 gm0/eSQpuGIlBcogs08/98dyDY1FvxdzUcTYrGE/M00NKWke6Ueu+ODwXaYlhWYgmjPr
 xRwwTvrRclwhy995TqLDWOy3jPl7r6cS8aCgUom5mFZXYbHDOwBp7bd8eFUG3aOKNhR9
 2HbbwqxasHFfggx399V02Slxc20jzRrZbb6hVKcQiaFaY+i7e1bZznPn/ccOWXlgzsWE
 ygSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792459; x=1777397259;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eIWcEVbGT2Bkdbdk0f71Ip+HemYRMLHjbbivqGNFTc=;
 b=KCcVkSvKbn1h067z/pvVgT4fPCDdFiwfWHWOYWQ0gqijaabWtlkURADy71IQ6pzyZm
 OQd+sKsYZbBE8/ilhC+Du85lGlIGnxIvhhMB20rsE/gmc15b8ynPTcEx6LwUBTIC5W/h
 oM8EpGYmr4upnpYMUiFJSAS0ej6QSJ/pZ8vk4ch3EajXRQ2ypJ19nfGSCAISxfDwSl8W
 iaaPqo9EujEYv/9duHc5AzO9Y0PTt8kbJfY5JFV6dc02CX2cfmrppX4jbt8odSB21WzE
 9S/fSjdImqrtMrXCIsGyZ2tc6F6A7H73Gd9CrYTJXOGWN5+ofFpoAEeXzFQsnwi6hywU
 9kxw==
X-Gm-Message-State: AOJu0Yxjho9+boCjCRZi8tNsRaAlq1JEvLxdfodLb+540ymZRZZnKmw7
 FrcKdy90Ws7YsHykX/4TYxD4NgvjYwy2QPzxbZ1u7AeEdvW78wCIHRNV
X-Gm-Gg: AeBDievDOV4uEm9MZjxWkCFILyrXhCYh+vCScm3ihOpAr6MWVJi916VQopMEbw7af3o
 4Xrt6ut4iIbvcOQ1ZbEDnCMqQKQE0Ahr3xo/jemy3hkMSH9zkiClxSwYVVF2iGkS5QUju+bw9KN
 v7bUvB6Sx5NND1WoVz5MyAgBfNuqpTQHbg90bQjKyyC7cR2x4lSGulOcoo7iGi9yATeoMPPzaPn
 syNjJKZ6hj0M5MW+Czww6IJECi4xF1aDfQTjP0nuWnQJsC8XbDfYiuooDS2L5rdoxfrKOTI5vFr
 mnky/3HNOtoJYjndnylRm5vv2nHlJR3LZSGZDm8AiIhoFbL2S0FGGMpcxB1VdG6o61WDz1KUWnW
 ehGQX8vPhzDGAtoAbwxHSrkA8suG+iVxzN5sn+6GhQoUnQsyxIIDP+7HHBW2tuFGYS2CKo+zyNg
 IxyYIPYNauyzbgJmOepgBEpDu5J6thMrwbmDh3WUkOE8c++GWm658WxKfaW4/MyCXi4bEDUsrp/
 fjNql6KbsdWOH+JX3rxDnu0i6j6yqSi3AO4UWmEVc2Mk8AKz9Xkpz6onoqjzSlz2I0VA7AhyXFq
 n26tPw==
X-Received: by 2002:a05:6808:10cc:b0:479:eb19:6e69 with SMTP id
 5614622812f47-479eb19b035mr2700022b6e.6.1776792459356; 
 Tue, 21 Apr 2026 10:27:39 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 00/13] target/mips: add missing Octeon user-mode support
Date: Tue, 21 Apr 2026 11:27:27 -0600
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxG4auUrA0MUVv0KuJCY1ojmCnz1yKU3
 t1Rd+/bvIVgxQ10bBYqNjs8R4VsGtL7JQZjv1WTJGnTThI/fQRnnSxHbcBjYA8EeBbeW3vYdl3
 SXpTqYizW+/u3P53/xuv6MJ2+T1rXD2CyRfiAAAAA
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series updates MIPS linux-user unaligned-access behavior and fills
in missing Octeon user-mode instruction support used by existing Octeon
binaries.

The first patch models the Linux/MIPS MIPS_FIXADE policy so user-mode
unaligned scalar accesses default to software fixups and
sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.

The Octeon patches add integer, indexed memory, atomic, multiplier, COP2
crypto, CHORD, and LLM support. The series also adds a small
mips64/mips64el TCG guest test covering representative Octeon integer,
multiplier, and COP2 selector paths. The final patch corrects the
Octeon68XX CP1 feature bits and FCR defaults.

Changes since v1:
- Split BADDU/DMUL destination fixes into a preliminary patch.
- Split the SEQ/SNE decode refactoring into a preliminary patch.
- Moved Octeon multiplier state to uint64_t arrays and updated VMState.
- Switched Octeon helper ABIs to i64/uint64_t where applicable.
- Moved COP2 selector decode/support logic into octeon_translate.c.
- Converted Octeon translator TCG ops to explicit i64 forms.
- Added in-tree TCG tests for mips64 and mips64el linux-user.
- Used switch ranges and g_assert_not_reached() for SHA3/ZUC shared
  selector handling.
- Dropped Octeon prefixes from generic Camellia helper routines.
- Replaced the reflected GFM 64-bit carryless multiply loop with
  crypto/clmul.h.
- Moved the Octeon68XX CP1 CPU-model correction to the end of the
  series.
- Added migration coverage for Octeon COP2 crypto and LLM sparse state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (13):
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: split Octeon SEQ/SNE decode
      target/mips: use explicit i64 TCG ops for Octeon translation
      target/mips: add Octeon arithmetic and memory instructions
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto core support
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: expose Octeon68XX floating-point support

 MAINTAINERS                                   |    2 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   60 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   75 +-
 target/mips/cpu.h                             |  249 +++
 target/mips/helper.h                          |    6 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   47 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  704 ++++++-
 target/mips/tcg/op_helper.c                   |  105 ++
 target/mips/tcg/translate.c                   |   23 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 +++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 22 files changed, 4129 insertions(+), 44 deletions(-)
---
base-commit: 98b060da3a4f92b2a994ead5b16a87e783baf77c
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


