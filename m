Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF51FD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3P7-0007Uy-2Q; Fri, 15 Nov 2024 15:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P4-0007U0-R3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:55 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3P2-0004Lu-US
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:58:54 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ea0bf6bebbso1520202a91.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704331; x=1732309131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HiIZ4k8MhNiSYkTLAwBKepCxeOw0tCftVCByRp32a04=;
 b=F+Q9mS4+n+yP0crayfTAdUmGYCAqwbEn+j+kQid6tbmge8CqoPvhfr5DNR7c1tXlnc
 JFd1A9Pg4IBi/vhL/iKM+XBsfWPe4nivTNOtBBGIfgLKcQqz4P07rQ0AoBcwL9k4jzJa
 UDW0bpFYEtVJJOjGcqXmVxjGTi1B1NltV1vRx60YWL9dWvcp/rUmntgjS26q9s3iaZOC
 1ScUNNK4VqCDLDPtwhIioh6gEcQFZI92GTfhd5bMhKDSUKSJFGJ+axDApkySIGGZn2m1
 s9h2I02pEbXPtGf4fli1DwNEbhgYAD2WGsTwaSmA2mY6P0qpSMreiMhbR73vrTuS/Zkv
 OZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704331; x=1732309131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HiIZ4k8MhNiSYkTLAwBKepCxeOw0tCftVCByRp32a04=;
 b=ijQtn6Y8JHntILultCnvJhOa9rOqNeNwUQUBw3WcLbJKlwui/pdUW9hEmkeeHyUNon
 nvX8xNE51foavB9+o05jEMXbsmD5boIRlsry5K2FSvqLGfb7xrNjmqX+AoY4QGlMchUm
 F92UL86qNjfUriq0/e1mQeeOpUvH8SKvdLASp3bUFsreWZrCClHXnrJhx0xYV2ZHaLMV
 QVwHoKvgCf0wKdRElqO2/gD5w328adDcAR0PpnRu7O9egQ58hJZQWOwM97N+usvbNKmu
 rFnIQxu84+mMPiu0dIGIeQm0NTGw6aP783YI9e/I4hWCIDqLbv5/JumBp4f/6GI9Rejh
 mnkA==
X-Gm-Message-State: AOJu0YwfFs3CAsHSYtI9WeRDhCRA0hisxv/7XhR098c2zJP+LJAJLTo8
 KcD49jEltACfmm2yWcDj05/FpjrE4gnReYcSwYHIwzqzO9QY3DPPD/KaOtdMeVIMhycyZXcJzwL
 4
X-Google-Smtp-Source: AGHT+IGh/jpUMGOExnPGOUNgIVrWbwBWhDLa2QLWJm4z+ZwWam0XydKmwH9zie28IHR7wt4U7FS4DA==
X-Received: by 2002:a17:90a:d005:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2ea154f7448mr5409847a91.16.1731704330980; 
 Fri, 15 Nov 2024 12:58:50 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.58.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:58:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] tcg + linux-user patch queue
Date: Fri, 15 Nov 2024 12:58:35 -0800
Message-ID: <20241115205849.266094-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:

  Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241115

for you to fetch changes up to a020e0a807a6e34890d1f2ca02e49f814fd0b64f:

  tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc() (2024-11-15 12:51:27 -0800)

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

Richard Henderson (8):
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
 23 files changed, 174 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/multiarch/sigreturn-sigmask.c
 create mode 100755 linux-user/arm/vdso-be32.so
 rename linux-user/arm/{vdso-be.so => vdso-be8.so} (90%)

