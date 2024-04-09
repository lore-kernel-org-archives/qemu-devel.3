Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D8CC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dX-00035N-FQ; Tue, 09 Apr 2024 01:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dV-000352-Jo
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dT-0005C0-HP
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:09 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed112c64beso1979438b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638985; x=1713243785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q47WV5+w5EHuyJqN5nKeJ49rNv9gzeLMdS2O5z2tA3E=;
 b=elCOqjJ7i28khJw2N/BX+Ocy9Fen46aKesCpdXRFDm1AiBjJmqO20D1HycFvyh43Wl
 EAfIgHU4osOxd5sLsq0UGyL7CPVBpMVsK6fKyvcyupTgz+zQsCK4WQI+XrlEOzm3Wstt
 UNOU3Zfn1UE/E8LsRqrYeyGxX5bZxW9oJvjqGgcPooHCoR55LolybckcZFx4ye+xaLR5
 +5VP7o+i4Ktpqt5HYiONbiFjFlej5Zwf97sc6CC1nRDz0qTzacXk2ltjtJnMjrQuK5W2
 LNWwI9ptU6VmoWh5I09hvVGPFPgieH4wNmIRcdVqcVab8nbYlZi0tAZjJ5XW0odfUciI
 FNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638985; x=1713243785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q47WV5+w5EHuyJqN5nKeJ49rNv9gzeLMdS2O5z2tA3E=;
 b=rlpKcGaSLgN5rvs/J34EDwHjHrJ9EeK/8UwdFKZPsl+3KLCXyYVgiECdzWFX7U106c
 xqs5UOa1mwb19Ht6+Y8psesMvAjH9rVxMg/mY/Dvu9j+zzvEIwFJ06+LrzlrdR30OXfF
 PEF43QiWmEjJ1Z0hFmqAy9lD5M+SJgwM08S8Lg43JMYnOmmZXa3UThKfd2bWNqVcPy1t
 t28oYoaygC4Zi09IXm0ID0V1e0Gc3o/V+wQQdFg8wgla6KLnU3ztugvUen4GKdlo0Gn2
 JIDZ8FVGdF5365phlPV8H8oz2O5clBrmJu4WWkJkeDnCxZW87mrU5B2oiHj0apsU5Z8k
 uQng==
X-Gm-Message-State: AOJu0YxWUUUbm6uKFIoEkP9gk/if/FPc3/fv8fCB8AeX9IPjjsxRS9wf
 T/XUVamvuOqhyswwRm5bjfgiQXWbtqO2CIA29D096WpQx7PqSzeX7JI4YUCW+Xdih0zZw0qNC2r
 5
X-Google-Smtp-Source: AGHT+IFVI2+1+9for0cssfnhIjb80FU40UhJrehKihTHOQA8XKYhvO9Hkz46vJTvUqq6EojdlV9jXQ==
X-Received: by 2002:a05:6a00:b84:b0:6ea:7981:d40b with SMTP id
 g4-20020a056a000b8400b006ea7981d40bmr9061668pfj.16.1712638985178; 
 Mon, 08 Apr 2024 22:03:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 v2 00/28] linux-user/i386: Properly align signal frame
Date: Mon,  8 Apr 2024 19:02:34 -1000
Message-Id: <20240409050302.1523277-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

v1: https://lore.kernel.org/qemu-devel/20230524054647.1093758-1-richard.henderson@linaro.org/

But v1 isn't particularly complet or korrect.

Disconnect fpstate from sigframe, just like the kernel does.
Return the separate portions of the frame from get_sigframe.
Alter all of the target fpu routines to access memory that
has already been translated and sized.


r~


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
  target/i386: Honor xfeatures in xrstor_sigcontext
  target/i386: Convert do_xsave to X86Access
  target/i386: Convert do_xrstor to X86Access
  target/i386: Pass host pointer and size to cpu_x86_{fsave,frstor}
  target/i386: Pass host pointer and size to cpu_x86_{fxsave,fxrstor}
  target/i386: Pass host pointer and size to cpu_x86_{xsave,xrstor}

 target/i386/cpu.h                |  57 ++-
 target/i386/tcg/access.h         |  40 ++
 linux-user/i386/signal.c         | 669 ++++++++++++++++++-------------
 target/i386/tcg/access.c         | 160 ++++++++
 target/i386/tcg/fpu_helper.c     | 561 ++++++++++++++++----------
 tests/tcg/x86_64/test-1648.c     |  33 ++
 target/i386/tcg/meson.build      |   1 +
 tests/tcg/x86_64/Makefile.target |   1 +
 8 files changed, 1014 insertions(+), 508 deletions(-)
 create mode 100644 target/i386/tcg/access.h
 create mode 100644 target/i386/tcg/access.c
 create mode 100644 tests/tcg/x86_64/test-1648.c

-- 
2.34.1


