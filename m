Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E06D68BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 17:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCMFK-00036z-T0; Sat, 16 Nov 2024 12:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCMFG-00036R-Mz
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 12:06:02 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCMFC-00014U-Lc
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 12:06:01 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7248c1849bdso322575b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731776757; x=1732381557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HwMirBlRSRGnf8goWUX8E13u76mbE9BlON6LBEzyLQs=;
 b=zWFX/SDVTSSJsdk1B0VwGVvwrL69YGT0HEdmbcymWlx/dsC3zTgKPqu3HdHkd41rkW
 mKep1hdvER4C23DJIB9OJQALRK30zAZOhABjhMU8ER9jJwlxSjFv1cxtPaFDbASl/ejM
 IK1AgTik1jiY3zKM33MEzfUByZbaCdWunVXahO1ow9n6ueAEPATUJO8kp1E2iShmkx3i
 qaLIHBSMSJXxGilnpHX22u2Hj8F/Tev9umBkFX0fEPj7zySHStIasZoeJ0ZNSmRBggbM
 UT5X26HHYnCabViY6+HJqt2/A3K90TdxedoYCvEKZM4eIj09+K6QzAkSS14SidDdQOTC
 b2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731776757; x=1732381557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwMirBlRSRGnf8goWUX8E13u76mbE9BlON6LBEzyLQs=;
 b=mFYBcoWs9o2sVyVU52YscegWf0TE8KX0R35YHmZZV7gvyM92jh3YfOmhdNDxWgPHAa
 EUnOSDHYua18INceW0C++kUWVI5xZ2QTtCDS5iehuhC+p7SCJNwWpeFXAuRk7u/5iMpV
 rX70uochr1NcUzm+Q2DBpvzGdokpCkmxiMssbPvecE9pCb0GzTyfHszhE7v8zPUBfiTQ
 dQa2R5H////2kNokNDr166szSqG6kD9OEV0WuqIKdnR+jcoP0uAE2J/Tord78Pze74b/
 k3cJMEN3VZFOrmBwDmmu/aVA++L0s63dtDLoigdCsUxJ+At7bBfcuSH5i5hS5LeNWbin
 6zPg==
X-Gm-Message-State: AOJu0Yw5ikSXzJIM4PLGZAvEw3gXEf3g05TG82968paIYmMDsmiMLc3c
 1bKDZkzfGi7nZIHrj33HInrKarww8hwP7UNbAN1oDzD3x6h8gKGNy/6jPEscPwvUP/rX7Hiuzyd
 0
X-Google-Smtp-Source: AGHT+IF1Uo0/DUGdtx8PQPSqBCHz2siztoTKw7OdJNCp/SJCzVwdIcD5tQJX53pP+BkPBiZp4Wuu1A==
X-Received: by 2002:a17:90b:164d:b0:2ea:f91:f32 with SMTP id
 98e67ed59e1d1-2ea154f5e5bmr8741651a91.9.1731776756839; 
 Sat, 16 Nov 2024 09:05:56 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f51ca8sm29574585ad.230.2024.11.16.09.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 09:05:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 00/15] tcg + linux-user patch queue
Date: Sat, 16 Nov 2024 09:05:54 -0800
Message-ID: <20241116170555.461462-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

v2: Include
  target/arm: Drop user-only special case in sve_stN_r
as a prerequisite to
  accel/tcg: Fix user-only probe_access_internal plugin check


r~


The following changes since commit 43f2def68476697deb0d119cbae51b20019c6c86:

  Merge tag 'migration-20241113-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-11-15 14:53:36 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241116

for you to fetch changes up to 8377e3fb854d126ba10e61cb6b60885af8443ad4:

  tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc() (2024-11-16 08:42:25 -0800)

----------------------------------------------------------------
cpu: ensure we don't call start_exclusive from cpu_exec
tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
accel/tcg: Fix user-only probe_access_internal plugin check
linux-user: Fix setreuid and setregid to use direct syscalls
linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
linux-user: Honor elf alignment when placing images
linux-user/*: Reduce vdso alignment to 4k
linux-user/arm: Select vdso for be8 and be32 modes

----------------------------------------------------------------
Helge Deller (1):
      linux-user: Fix setreuid and setregid to use direct syscalls

Ilya Leoshkevich (2):
      linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
      tests/tcg: Test that sigreturn() does not corrupt the signal mask

Peter Maydell (1):
      tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()

Pierrick Bouvier (2):
      target/i386: fix hang when using slow path for ptw_setl
      cpu: ensure we don't call start_exclusive from cpu_exec

Richard Henderson (9):
      target/arm: Drop user-only special case in sve_stN_r
      accel/tcg: Fix user-only probe_access_internal plugin check
      linux-user: Honor elf alignment when placing images
      linux-user: Drop image_info.alignment
      linux-user/aarch64: Reduce vdso alignment to 4k
      linux-user/arm: Reduce vdso alignment to 4k
      linux-user/loongarch64: Reduce vdso alignment to 4k
      linux-user/ppc: Reduce vdso alignment to 4k
      linux-user/arm: Select vdso for be8 and be32 modes

 linux-user/qemu.h                          |   1 -
 accel/tcg/user-exec.c                      |   2 +-
 cpu-common.c                               |   3 ++
 linux-user/elfload.c                       |  71 ++++++++++++++++++++++-------
 linux-user/syscall.c                       |  20 ++++++--
 target/arm/tcg/sve_helper.c                |   4 --
 target/i386/tcg/sysemu/excp_helper.c       |   5 ++
 tcg/tcg-op-gvec.c                          |  15 +++++-
 tests/tcg/multiarch/sigreturn-sigmask.c    |  51 +++++++++++++++++++++
 linux-user/aarch64/Makefile.vdso           |   5 +-
 linux-user/aarch64/vdso-be.so              | Bin 3224 -> 3224 bytes
 linux-user/aarch64/vdso-le.so              | Bin 3224 -> 3224 bytes
 linux-user/arm/Makefile.vdso               |  11 +++--
 linux-user/arm/meson.build                 |  13 ++++--
 linux-user/arm/vdso-be32.so                | Bin 0 -> 2648 bytes
 linux-user/arm/{vdso-be.so => vdso-be8.so} | Bin 2648 -> 2648 bytes
 linux-user/arm/vdso-le.so                  | Bin 2648 -> 2648 bytes
 linux-user/loongarch64/Makefile.vdso       |   3 +-
 linux-user/loongarch64/vdso.so             | Bin 3560 -> 3560 bytes
 linux-user/ppc/Makefile.vdso               |   6 ++-
 linux-user/ppc/vdso-32.so                  | Bin 3020 -> 3020 bytes
 linux-user/ppc/vdso-64.so                  | Bin 3896 -> 3896 bytes
 linux-user/ppc/vdso-64le.so                | Bin 3896 -> 3896 bytes
 tests/tcg/multiarch/Makefile.target        |   3 ++
 24 files changed, 174 insertions(+), 39 deletions(-)
 create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c
 create mode 100755 linux-user/arm/vdso-be32.so
 rename linux-user/arm/{vdso-be.so => vdso-be8.so} (90%)

