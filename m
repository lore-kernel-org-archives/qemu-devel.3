Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0F7C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSh-0001gM-5D; Fri, 11 Jul 2025 13:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSf-0001fe-B3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:01 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSd-0002z7-IY
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:01 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-40a7322f081so744149b6e.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254578; x=1752859378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVfb7RJhAElHAt1oZrn7ugInJPo/ORZN1lJrI4atpxQ=;
 b=XCLD0V1VGqX/Envkkxxq8njud51ZP+HNNrUIxHxJyDMtcMPYwPxR+P/x+fTj5xR7Zf
 DuXwvsXPS+JO2k3QB3pgvvGnRHP4Fkg+4vFqCpErZf9It7E3YOFWaHDf0O1fQgRXglTs
 GLk1+RAjVyObu8HDka0QGZB+WV/p1dTFSP3wWyEeYm/NXFpjsErhWSO+dzrb0fzFm+Gv
 XT7553VUMA0SzB2Nr7jkw1NWPMKSlDQDNnrr3VelD/3heu06TwL45skr1R597rYS36OR
 Ux2gdWXmMKYiBVJEpUuna8E25MyvBgNuygKE/qCZxuQqRf0xxV5iFTWxDG1Qj7/+jROq
 sWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254578; x=1752859378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVfb7RJhAElHAt1oZrn7ugInJPo/ORZN1lJrI4atpxQ=;
 b=b/AOEbpPw6hIXRsAluvBfJXXxCOl+dxQ6+KZ5q5LFBmuS/0Nt4FuST8XpFW/WkGPwb
 JrCK9yxdftubbJ6EwXKTmk6SxVYtiVQqyQEq6eKZTJuYv9VMiWINFMhx2D3+uymZJ3Me
 t5tDWww2N08ZKIEHG+auBc+/YuECs/re/ixO72tZPuSJCm8wf4M30K9fDqAZsyKRRy/c
 0HN+jLRVfhOxZe9nWnptltCY50GT7VBWoKPHCTPjrMMsAlz2TRaxF0OpKW2U5qZ3VOm4
 UvamtFFPa5sEchn05eyfj+pDm/hTwkCysTHUioXQvCPEFa0DuUXPn38sBARkgOUZ7XuN
 Qmpg==
X-Gm-Message-State: AOJu0YxFUwknT0errTK0Pn3mywgXXKGpVEvMLS6tqkZbGVXQHiRcgmsJ
 XvpdlXO4UPWkt+DTtPQXBRS3lrrgY/eV0ENkPiSPH5TiJUrhnKX9rFMIRKxQOBqvFVDQxBMhTA8
 0NF9IYMc=
X-Gm-Gg: ASbGnctvttejt6PF5uoIWCl7nGuDW90DK22VClMOD6WtXfYoXu16QsvKk/8jR5wd1VD
 oLOoeMqoEqOei/QxDFROVGc6l+TWQjDzC6bElmzPSmVd58XRBCeKskfgZrPOwacWXdz2RX9ZXOm
 8se2WNJeEaRGPlP0lyFzeJNiFM64L/Ugpufm2XGCfiJPfSdi1Fzo3f1zZ2eMC9jSXU3gWT3TWmT
 akrv6JIdIpTynjr3TM+k9dddAvMRs0ZXtNBVGYOwZIAIIEOGqjvPSqxvJ7REEH9Q201sAzD88Yo
 Tr5KEuIGk7sJlwItdbEojb7xlOYZlH+CXEYaQCfQfL4Poj/stZ/qbmZwWKtWLswn7UWo1BG0PAI
 BHRnldO4i91/gFSH3hnE1copy3KVnCY2WTcwEna1Lrt/dpIBe3gTRT1erMK318FFGdvax5X3dHJ
 nkE1/4iZtQ
X-Google-Smtp-Source: AGHT+IEERVQoD4FfQHIb01/46WgHti01tbT17t/wcFt64/AjJ++W1YPRkDGkk0eRpXew946MylB+0A==
X-Received: by 2002:a05:6808:3505:b0:401:16e:918e with SMTP id
 5614622812f47-4150d645624mr3521097b6e.8.1752254577449; 
 Fri, 11 Jul 2025 10:22:57 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.22.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:22:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] tcg/linux-user/fpu patch queue
Date: Fri, 11 Jul 2025 11:22:45 -0600
Message-ID: <20250711172254.229201-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250711

for you to fetch changes up to d6390204c61e148488f034d1f79be35cd3318d93:

  linux-user: Use qemu_set_cloexec() to mark pidfd as FD_CLOEXEC (2025-07-11 10:45:14 -0600)

----------------------------------------------------------------
fpu: Process float_muladd_negate_result after rounding
tcg: Use uintptr_t in tcg_malloc implementation
linux-user: Hold the fd-trans lock across fork
linux-user: Implement fchmodat2 syscall
linux-user: Check for EFAULT failure in nanosleep
linux-user: Use qemu_set_cloexec() to mark pidfd as FD_CLOEXEC
linux-user/gen-vdso: Handle fseek() failure
linux-user/gen-vdso: Don't read off the end of buf[]

----------------------------------------------------------------
Geoffrey Thomas (1):
      linux-user: Hold the fd-trans lock across fork

Peter Maydell (5):
      linux-user: Implement fchmodat2 syscall
      linux-user: Check for EFAULT failure in nanosleep
      linux-user/gen-vdso: Handle fseek() failure
      linux-user/gen-vdso: Don't read off the end of buf[]
      linux-user: Use qemu_set_cloexec() to mark pidfd as FD_CLOEXEC

Richard Henderson (2):
      fpu: Process float_muladd_negate_result after rounding
      tcg: Use uintptr_t in tcg_malloc implementation

Thomas Weißschuh (1):
      linux-user/mips/o32: Drop sa_restorer functionality

 include/tcg/tcg.h                   |  6 ++---
 linux-user/fd-trans.h               | 10 +++++++
 linux-user/mips/target_signal.h     |  1 -
 linux-user/syscall_defs.h           |  4 ---
 fpu/softfloat.c                     | 54 ++++++++++++++++++++++++++++++-------
 linux-user/gen-vdso.c               | 16 +++++++++--
 linux-user/main.c                   |  2 ++
 linux-user/syscall.c                | 26 ++++++++++++++----
 tcg/tcg.c                           |  9 ++++---
 tests/tcg/multiarch/fnmsub.c        | 37 +++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc           |  4 ---
 tests/tcg/multiarch/Makefile.target |  1 +
 12 files changed, 137 insertions(+), 33 deletions(-)
 create mode 100644 tests/tcg/multiarch/fnmsub.c

