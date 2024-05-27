Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04F1C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZ9-000776-0M; Sun, 26 May 2024 20:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYv-00071Y-SK
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:12 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOYu-0003Wa-0L
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:05 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d1bb1c3dbcso788001b6e.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771002; x=1717375802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+VoQQ5ZIHW/J0jaRl3Q/WK51I6oNp3fORIj4jttIYm0=;
 b=RkDX1VJ1yM4b5qTaIky5n3UeJJdu8HGOC6w94l+NLaKa3BXoBQ3O31Qpk83QQLOpzz
 0O7Lhm7XT5un3VpE7Xzcvfj2gI7AECNPrsXtYufr75Fx/CUKVRl2CtDGfSNAcOUhJ3Iv
 89JTbo40ltnctgLctnMqt2b+5ugwlITFAhw/PGO+QGBvO97Egfv9MuYXCxlGyAx6uuef
 6O+/KBIYXkwP5gfEc/yniFQ8MrwC+7/5UoT7o0jYZjdMsuzuRdDv0Ose7Ww0gRRLNSuR
 Xl58RqYBpXlUEPzQ7VMyMbT3FmrZa03miK9Wghwo0Z6Bf4K93AQV6Jo308dhI+iDKxbq
 z0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771002; x=1717375802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+VoQQ5ZIHW/J0jaRl3Q/WK51I6oNp3fORIj4jttIYm0=;
 b=DdVyGBc0DoM4Q+rQXPBez/W1rBYkVougdLdx5jhLnUapJhjymBWL4qBuEwH/+eiiMV
 rZDUvVwps4nEKFmBjcI3tuh3k5cWaGpWhbMg2RRJOArQS+yUhlY7PuYeWhRTipQHmItq
 Z+ZFzww+ciXhWW2k0tNXjmC2dxrdXXYyu9+gI3yU4+ZNuaWt7ODGsWXrLsY+F0Yfo77Q
 wRV7y953fdSuMuFqMfxnpEWtQBl/jzRQjyCKuM1WPJRj9faVCHAyTtdX7iGThz6rF+B2
 OZFM3qfG550R99Jr/MW68j/v77DBOyw/0TnD4wTilwLeKRRkg7H2l53sNBsLYz84rT9a
 pevA==
X-Gm-Message-State: AOJu0Yy5v94ojpQV/juYBG+2MwHtARHNn2TPiEC0Be30DWxsiMrFsua7
 G6Pm2p14vo9V/Tc8Gv/syo4ryPTM7doLTatndyIoCiyf6VB9VJFIfdwK9lLuxX8p1mNFiQdGyxT
 x
X-Google-Smtp-Source: AGHT+IE9wgsBBclPypmhAMkxTVWQIsqyWENb8zrvi7M3y21+2Xh4vmN/78goq6ONOCO9uGNiuUBZZA==
X-Received: by 2002:a05:6808:614:b0:3c9:6ad1:8634 with SMTP id
 5614622812f47-3d1a7d298f3mr7822652b6e.58.1716771002450; 
 Sun, 26 May 2024 17:50:02 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] linux-user patch queue
Date: Sun, 26 May 2024 17:49:33 -0700
Message-Id: <20240527005001.642825-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:

  Merge tag 'pull-tcg-20240523' of https://gitlab.com/rth7680/qemu into staging (2024-05-23 09:47:40 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20240526

for you to fetch changes up to 701890bdd09b289fd9cb852e714e91373088b0f3:

  target/i386: Pass host pointer and size to cpu_x86_{xsave,xrstor} (2024-05-26 15:49:58 -0700)

----------------------------------------------------------------
target/i386: Introduce X86Access and use for xsave and friends
linux-user/i386: Fix allocation and alignment of fp state in signal frame

----------------------------------------------------------------
Richard Henderson (28):
      target/i386: Add tcg/access.[ch]
      target/i386: Convert do_fldt, do_fstt to X86Access
      target/i386: Convert helper_{fbld,fbst}_ST0 to X86Access
      target/i386: Convert do_fldenv to X86Access
      target/i386: Convert do_fstenv to X86Access
      target/i386: Convert do_fsave, do_frstor to X86Access
      target/i386: Convert do_xsave_{fpu,mxcr,sse} to X86Access
      target/i386: Convert do_xrstor_{fpu,mxcr,sse} to X86Access
      tagret/i386: Convert do_fxsave, do_fxrstor to X86Access
      target/i386: Convert do_xsave_* to X86Access
      target/i386: Convert do_xrstor_* to X86Access
      target/i386: Split out do_xsave_chk
      target/i386: Add rbfm argument to cpu_x86_{xsave,xrstor}
      target/i386: Add {hw,sw}_reserved to X86LegacyXSaveArea
      linux-user/i386: Drop xfeatures_size from sigcontext arithmetic
      linux-user/i386: Remove xfeatures from target_fpstate_fxsave
      linux-user/i386: Replace target_fpstate_fxsave with X86LegacyXSaveArea
      linux-user/i386: Split out struct target_fregs_state
      linux-user/i386: Fix -mregparm=3 for signal delivery
      linux-user/i386: Return boolean success from restore_sigcontext
      linux-user/i386: Return boolean success from xrstor_sigcontext
      linux-user/i386: Fix allocation and alignment of fp state
      linux-user/i386: Honor xfeatures in xrstor_sigcontext
      target/i386: Convert do_xsave to X86Access
      target/i386: Convert do_xrstor to X86Access
      target/i386: Pass host pointer and size to cpu_x86_{fsave,frstor}
      target/i386: Pass host pointer and size to cpu_x86_{fxsave,fxrstor}
      target/i386: Pass host pointer and size to cpu_x86_{xsave,xrstor}

 target/i386/cpu.h                |  57 ++--
 target/i386/tcg/access.h         |  40 +++
 linux-user/i386/signal.c         | 671 +++++++++++++++++++++++----------------
 target/i386/tcg/access.c         | 169 ++++++++++
 target/i386/tcg/fpu_helper.c     | 561 +++++++++++++++++++-------------
 tests/tcg/x86_64/test-1648.c     |  33 ++
 target/i386/tcg/meson.build      |   1 +
 tests/tcg/x86_64/Makefile.target |   1 +
 8 files changed, 1024 insertions(+), 509 deletions(-)
 create mode 100644 target/i386/tcg/access.h
 create mode 100644 target/i386/tcg/access.c
 create mode 100644 tests/tcg/x86_64/test-1648.c

