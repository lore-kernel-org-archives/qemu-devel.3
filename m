Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315C4C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFN-0003qm-Q1; Wed, 15 May 2024 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFK-0003py-Ow
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFE-0002kt-RX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41fe54cb0e3so43431095e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785719; x=1716390519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ecNMDS62/JucAdTPnqF6LAEtH+KjC/HjVVwhzvAufKs=;
 b=m0CFrOc8Dd2cHjnQC94R3S6TUBw/oYObUL04Z8LN7BnYFpvIDbWxW+cVaCOfLFbAR1
 ZFL1ZaAOTDTFqTKBOZSGujjYm+dSwKIgmb5lVV3BREpO605c4JNLu+9j/jv51niqkU9/
 HsBpy/1TXnIEvBCwDMM2aXvxcZssigXI/2DNv9QSi0DL+SGAbVzU4znlXsJpiuSJByCp
 65HUctUhVHpCxmLVjbIycwFa6WbK87AVz1NC+6ensE1BOIWGV6nMVh7PHY+VvicyzXYF
 fWdOWDZcOlujdped2gh4Qt2wtXRZjxoA+YBj1vViBLZlswB1ngiaj7/DS9oZ8zDRSHVh
 nB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785719; x=1716390519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ecNMDS62/JucAdTPnqF6LAEtH+KjC/HjVVwhzvAufKs=;
 b=iaeG+yqAEpFMAEYG5kzkExHEiNJy7uhM2TJIIsj/k0ESxyHYeaTdEycJF26oloZ0/T
 QDRZijDFnrnz33bKHgj1JdaNVLWl51qYc82UM1QTQoCetHoRD9N+USRUMewRZjIMaV47
 BbHnyvAGM4MNZreYKdeEqTJjtCwynz3znJh8lRwi4cwDixQT9T1JHzpR8oRF1/4/oU/+
 lBwgYxCGIrKJG9xBJWEaU+arE6ABjg8vPXEaO49qB1W+wmYyZsqdrf2TPb0vJ+JxCPN9
 lCsp+36CiQ/1pHn4VfDDkSIujOMkcOcvPXZPV7SqnJ3/9M6XU+6UKo8orjPRxIZafo+j
 bnWQ==
X-Gm-Message-State: AOJu0YzYNZUEOwiPGwS/Qrqwap6Bs5l2yRderSCj63O0BnC/YQ0C2fmV
 aDSw9Vp35pCihMfMam6UMKKCHe4t2Guh4hBpP+T/e7mbLRj0a0X22rkziVTi3v0sfChFMM8mk80
 D/qo=
X-Google-Smtp-Source: AGHT+IHiQZZD+dGKx7mqd5lu/UKmJSYVMu9NeOLzhMjcv/S6rqI/SK2mZBb8YqLRzpLsopS7/vP8LQ==
X-Received: by 2002:a05:600c:4f93:b0:41c:97e:2100 with SMTP id
 5b1f17b1804b1-41fea93a251mr108190675e9.3.1715785718738; 
 Wed, 15 May 2024 08:08:38 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 00/28] linux-user/i386: Properly align signal frame
Date: Wed, 15 May 2024 17:08:09 +0200
Message-Id: <20240515150837.259747-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v2: https://lore.kernel.org/qemu-devel/20240409050302.1523277-1-richard.henderson@linaro.org/

Disconnect fpstate from sigframe, just like the kernel does.
Return the separate portions of the frame from get_sigframe.
Alter all of the target fpu routines to access memory that
has already been translated and sized.

Changes for v3:
  - Address review issues (bonzini).
  - Rebase.

Patches needing review:
  02-target-i386-Convert-do_fldt-do_fstt-to-X86Access.patch
  19-linux-user-i386-Fix-mregparm-3-for-signal-deliver.patch
  23-target-i386-Honor-xfeatures-in-xrstor_sigcontext.patch


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
 linux-user/i386/signal.c         | 671 ++++++++++++++++++-------------
 target/i386/tcg/access.c         | 169 ++++++++
 target/i386/tcg/fpu_helper.c     | 561 ++++++++++++++++----------
 tests/tcg/x86_64/test-1648.c     |  33 ++
 target/i386/tcg/meson.build      |   1 +
 tests/tcg/x86_64/Makefile.target |   1 +
 8 files changed, 1024 insertions(+), 509 deletions(-)
 create mode 100644 target/i386/tcg/access.h
 create mode 100644 target/i386/tcg/access.c
 create mode 100644 tests/tcg/x86_64/test-1648.c

-- 
2.34.1


