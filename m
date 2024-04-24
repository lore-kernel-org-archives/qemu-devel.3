Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4AEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlSd-0006vr-3L; Wed, 24 Apr 2024 18:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSb-0006vS-4q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:29 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlSZ-0006eY-C1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:51:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so418275b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999086; x=1714603886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NomqmSPMRpqEitleAPYfKErbwxRTqwPCVGJLQagZKDY=;
 b=ChtvcujQKTfHWxhNrHmZGGJQqLQf721AOy9cCKCv28DP3DpXiJTj+UAiJCCAWw3+QA
 g1kO5+P4V5L98atNCFGEKuepbA23cux94nKHL6IgAwvX3TJWLxO7+nq0lPER67O5OuRZ
 tL+gIz29ru/ptDc1neEc5D/l1eaDTjDow9tWc5swCfsQHX4H7EA7co/cD0CdZOfcJR36
 1LeSSM26fzAhKNf48L3Fl8A/tarovfSV35tQE/8DB3hMCPvdZPliQe1NTP8wxJwNgge2
 3n0bVAaU605gbaOt4rD/54ewvSv8yNM8G1+v9yMcVv9OmLiHm85cUgGkV09ms4ygkTIc
 zGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999086; x=1714603886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NomqmSPMRpqEitleAPYfKErbwxRTqwPCVGJLQagZKDY=;
 b=KryJcbWIYT3pztq2ew28UcXXfrkqRUIwtZMq/pI8O+1sv4D/M0Zg77Ifc7GldzV1ZN
 cS71uRuA7MaOqC2UyBCV/iV+GXMvanQrdHU51TQBlA7MIkx4Sd2prUQF3Ei6YFGviBTk
 9WWMlq96D1vlb4URbI9+520r+S7QhmjMiJsTMh6KAIBOK83NG6Hs09kvrgSU2x3RQCLa
 +/bFHG1NcEHauDEh/F9wmuZuC2aMTM/o+xrLZpGaCZPUNP2WngmBtFJH83Asq4ZGoUYU
 qsSofDUqhIeRh97VAEoaFqlNjlj3hXu5Nq5PqIfQndmDx8+IiBeJ7dm7+AXHAKUxNrN0
 /zDw==
X-Gm-Message-State: AOJu0YwwoTVMZGk+eBOLxlThch2AQNsrkK3UEa8FAsa3Hx/7Wx3Csvyp
 3+/Scqg1Vc7k+KaOBvdkVrGE/UcxOapG/QazgOS3309gPsvgvrOVQjkEA/vkIRuVCYIbklkLHky
 j
X-Google-Smtp-Source: AGHT+IF01S4FZ1ASgQy6JnPScRt0RjwguvQ31v7mxLgLnpDCZ9YziHiDSDtZ1LpqSZuRhpCes2xVBA==
X-Received: by 2002:a05:6a00:240d:b0:6f0:c828:65c1 with SMTP id
 z13-20020a056a00240d00b006f0c82865c1mr4291495pfh.2.1713999085582; 
 Wed, 24 Apr 2024 15:51:25 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 it12-20020a056a00458c00b006ead792b6f2sm11960864pfb.1.2024.04.24.15.51.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:51:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] tcg + linux-user patch queue
Date: Wed, 24 Apr 2024 15:51:14 -0700
Message-Id: <20240424225123.929152-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

A few patches that missed 9.0-rc2 and were delayed.


r~


The following changes since commit 85b597413d4370cb168f711192eaef2eb70535ac:

  Merge tag 'housekeeping-20240424' of https://github.com/philmd/qemu into staging (2024-04-24 11:49:57 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240424

for you to fetch changes up to 0815c228bd1e0c24ac064ce299807b32f8e05d83:

  target/m68k: Support semihosting on non-ColdFire targets (2024-04-24 15:46:00 -0700)

----------------------------------------------------------------
meson: Make DEBUG_REMAP a meson option
target/m68k: Support semihosting on non-ColdFire targets
linux-user: do_setsockopt cleanups
linux-user: Add FITRIM ioctl

----------------------------------------------------------------
Ilya Leoshkevich (1):
      meson: Make DEBUG_REMAP a meson option

Keith Packard (2):
      target/m68k: Pass semihosting arg to exit
      target/m68k: Support semihosting on non-ColdFire targets

Michael Tokarev (4):
      linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
      linux-user: do_setsockopt: make ip_mreq local to the place it is used and inline target_to_host_ip_mreq()
      linux-user: do_setsockopt: make ip_mreq_source local to the place where it is used
      linux-user: do_setsockopt: eliminate goto in switch for SO_SNDTIMEO

Michael Vogt (1):
      linux-user: Add FITRIM ioctl

Richard Henderson (1):
      target/m68k: Perform the semihosting test during translate

 meson.build                   |  4 +++
 bsd-user/qemu.h               |  6 ++--
 linux-user/ioctls.h           |  3 ++
 linux-user/qemu.h             |  4 +--
 linux-user/syscall_defs.h     |  1 +
 linux-user/syscall_types.h    |  5 +++
 target/m68k/cpu.h             |  2 +-
 linux-user/syscall.c          | 73 +++++++++++++++++++------------------------
 linux-user/uaccess.c          |  4 +--
 target/m68k/m68k-semi.c       |  4 +--
 target/m68k/op_helper.c       | 14 ++-------
 target/m68k/translate.c       | 50 ++++++++++++++++++++++++++---
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 ++
 14 files changed, 107 insertions(+), 68 deletions(-)

