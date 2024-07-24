Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB3C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQTo-0003UP-Fu; Tue, 23 Jul 2024 21:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTm-0003Tk-Ta
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:42 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTl-0001u5-B0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:42 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3dae221e42dso2662284b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721783259; x=1722388059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DeAgii3n/BHhvuLBkCk7o4Q4OJQ51qy21pRxeXkI7zk=;
 b=aoTf2G0RTk3sqRpDzXHAR5Jd3sTQXPWWJj9truzZK/C7L4+0AuaY2xIJG4Er4qY/YS
 LfiWTUwFV9rMgeNyvCrmBCQ8wbzU+6tpSaFVffVDZTsrgVjnnz8IpO2mjANl9DYwVWSn
 x6nstXwsebqy9g4vIpzsAZnquDVgCbkT3b0cXRS1TQo9FlHzXYNfy/z3wSZpbv9ImNIP
 +ND1+xniG0mUjqXTy2n7nfA3L9esHGHILqS0AoyD9LZD/weS6Scsen3JyqhKgxW3b/ri
 dMyyKNIdrcIfFMRveY9hfnF77Nz9jyK88FK8VWOEX8YnNzPvYS4YWZShf3XcUpz0rVRF
 Ps4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721783259; x=1722388059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DeAgii3n/BHhvuLBkCk7o4Q4OJQ51qy21pRxeXkI7zk=;
 b=JdbtyLVg6IaF5Dg24rxtYJdX0gwY2qBU8wDi/JIp8XWm/FcSggOgN/o4x71YYRt+cc
 tfy8AzcWJjWFa4RZ0XFlOqi1lDMdu6wtwaKsKlX8jV0djZETdzjvdfQCmlLjGGhpLPAn
 c8Cwtt7K+5tSY6/bMC3K8xdm0Zx/IlqUSEPbOBfZDQHVs67Mv08MwNV00tAp0CycN526
 uT+/cCoO3PRixI5MA/XAzfLWR1Q8zDMmJ0lIbb8uw2cTFV6dcO13Paz4ZjrGe1uMs7uQ
 UJvwXCNKC7/btyhg/bTa6j+PHAAS0VqGoo4W+fmMYZXFLZlXwlg6ypENX5fGV0CVT6dj
 LJOw==
X-Gm-Message-State: AOJu0Ywd5ekbudd+ghk3h5A8DnzzsREHijm1r3hbT4WPUdvbywFqrMQE
 TRJkCVBCqBo7om8dUo0PhY0iPnNmP0Gs0WY7kDXa8NfgazcpX3u4Q5S/egAXHQA7QuapZEDo5q8
 qyx1uiQ==
X-Google-Smtp-Source: AGHT+IEixmMl8eyGSr4WMxkjX0tpiL77aqNQZPx0XAeKBEGptfqS6oz093/iTRQjv9YxSEdNdB5yeA==
X-Received: by 2002:a05:6870:15d5:b0:25e:bd3d:635e with SMTP id
 586e51a60fabf-2648769307amr1649103fac.13.1721783259403; 
 Tue, 23 Jul 2024 18:07:39 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0e6c947esm6961093a12.74.2024.07.23.18.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 18:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 0/2] tests/tcg: Fix new cross-compiler warnings
Date: Wed, 24 Jul 2024 11:07:31 +1000
Message-ID: <20240724010733.22129-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Recent updates to debian cross-compilers have enabled some
new warnings by default, which encourage good behaviour for
userland binaries.

Neither are applicable for our system mode kernel images,
but we do have a few userland tests that are affected.

The --noexecstack assembler flag takes care of adding the
appropriate .note.GNU-stack elf note for us, rather than
writing a dozen lines of assembly template, and so is a
true fix rather than merely disabling the linker warning.


r~


Richard Henderson (2):
  tests/tcg: Use --noexecstack with assembler files
  tests/tcg/loongarch64: Use --no-warn-rwx-segments to link system tests

 tests/tcg/Makefile.target                     | 2 +-
 tests/tcg/aarch64/Makefile.softmmu-target     | 2 +-
 tests/tcg/alpha/Makefile.softmmu-target       | 2 +-
 tests/tcg/arm/Makefile.softmmu-target         | 2 +-
 tests/tcg/arm/Makefile.target                 | 2 +-
 tests/tcg/i386/Makefile.softmmu-target        | 2 +-
 tests/tcg/loongarch64/Makefile.softmmu-target | 4 ++--
 tests/tcg/riscv64/Makefile.softmmu-target     | 2 +-
 tests/tcg/s390x/Makefile.softmmu-target       | 2 +-
 tests/tcg/x86_64/Makefile.softmmu-target      | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.43.0


