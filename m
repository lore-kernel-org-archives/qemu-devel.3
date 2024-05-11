Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB61BC25B75
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIn-0000H9-F9; Sat, 11 May 2024 07:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIm-0000GR-2j
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIk-0006wh-8H
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34d99ec52e1so2146714f8f.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428444; x=1716033244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fw1419k9xznNHwWWoHv88CeBNJdgtSAObsXcS2fvzv0=;
 b=x7SFmFo7z3hoArXdRPz6lISHm8JCniWzvJDzkUmBPUp3M+UWNUFFqbXC4JO98o3Mmi
 kK9PY9UVS0cNKh+0i/E28TfdX8suAEEJV5YRQLIslB4OrX5ZO8U1TUPsKK27BuWtBneo
 hq+iMNgd9AcEATC0cgH2bTovZSwax+zH328FnXCetMmaX/qp659/jc+OWMWs9OPEeDn1
 zZ9NPRDcDTwRD+JLuyX5pf6uAayuUWMU3GzwwB11QsI3cuSzRZtIzEa5PnybfRKpzjts
 lNKtKpwCK1HReTUjzGJ3E/VdkK0Ox2jCG4kqrlCBxFrqMX5Ojf83+jjUpzpbjIjhtufw
 BTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428444; x=1716033244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fw1419k9xznNHwWWoHv88CeBNJdgtSAObsXcS2fvzv0=;
 b=EWyolLoUQYmMLJymDaqPR6UX6N1y3LXswPwZO1qlVpDQo9vkxhvCNLy7dPdRFrrjqt
 t6aIHqznLT5IZA+LhY64a878jXxm0Icj4fmtQ46OExSbcAwqL5s9rgU4YnlHVXIiX2TN
 ZRKkGvVsOVRzydJYkCBGLxwK0V9+Tvn4SRzgkMo8kw7qhi8RtJXrPwo1lWj6I25tkDbT
 Ftl4P/3A7F6kTmI4IaylZpw4r5rY7OMLwsLFi+LVfS0XSaZunfvX9EFfs0TaUawDxkOj
 H5YXAWHneI1xMF1yPJ9+YhoCO58l+Rwv+84KfV8IVqFh1yfoIvk0gAW+40btcYJyJ+KY
 kTnA==
X-Gm-Message-State: AOJu0YxCxnFDekYbmTUVHNcg4gC7xviqlFrURSuHNEj/3Gs2qtNmCyMb
 XpKMAn6RwzUUHId7rlSpAN+0maLejAuQXEVmZi/RopaKnEstdhooTK8DkwhkWj+CbrAaukQ+zie
 j1HM=
X-Google-Smtp-Source: AGHT+IFIw5NoqQR35SXxhgMnejsr1RL8p4eWh6Rg6hqshKGaBwMwBVANHhyT37YR7ousbH/HaRXYYg==
X-Received: by 2002:a05:6000:551:b0:34d:ae55:8fb9 with SMTP id
 ffacd0b85a97d-3504aa6339bmr3470883f8f.66.1715428443246; 
 Sat, 11 May 2024 04:54:03 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 00/17] RISU misc updates
Date: Sat, 11 May 2024 13:53:43 +0200
Message-Id: <20240511115400.7587-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Some of these have been sitting on a branch for a couple of years.
Except perhaps the first, which I assume to be some sort of odd
build error from the time, they still seem reasonable.

There are some updates for SME1, but not yet the ZT register for SME2.
I'll get to that later after I've done the qemu linux-user work.

Finally, let's start phasing out raw binary test cases.  We can
make it much easier for ourselves if we package test cases in ELF,
which "objdump -d" can parse directly, without having to be given
all sorts of "-b binary -m some-arch-flags" etc.

For future work, I plan to make changes to risugen so that it writes
out asm files and invokes the assembler and linker to produce the
final output file.


r~


Richard Henderson (17):
  ppc64: Fix <sys/user.h> include order
  Fix load_image error check for mmap
  Standardize reginfo_dump_mismatch printing
  Add --fulldump and --diffdup options
  Remove return value from reginfo_dump
  ppc64: Clean register values in reginfo_init
  ppc64: Compare all bits of CCR
  ppc64: Simplify reginfo_is_eq
  ppc64: Clean up reginfo_dump
  aarch64: Tidy reginfo dumping ahead of ZA state
  aarch64: Add support for ZA storage
  aarch64: Trivial SME test
  Use bool for reginfo_is_eq
  aarch64: Use bool for sve_{z,p}reg_is_eq
  risu: Allow use of ELF test files
  configure: Enable loongarch64
  Build elf test cases instead of raw binaries

 Makefile                   |  19 ++--
 risu.h                     |  12 +-
 risu_reginfo_aarch64.h     |  52 ++++++++-
 risu.c                     | 178 ++++++++++++++++++++++++++----
 risu_ppc64.c               |   3 +-
 risu_reginfo_aarch64.c     | 218 +++++++++++++++++++++++++++++--------
 risu_reginfo_arm.c         |  28 +++--
 risu_reginfo_i386.c        |  16 +--
 risu_reginfo_loongarch64.c |  21 ++--
 risu_reginfo_m68k.c        |  45 +++-----
 risu_reginfo_ppc64.c       | 134 ++++++++---------------
 risu_reginfo_s390x.c       |  28 ++---
 configure                  |   4 +-
 test.ld                    |  12 ++
 test_aarch64.s             |   4 +-
 test_arm.s                 |  16 ++-
 test_i386.S                |   4 +-
 test_sme_aarch64.s         |  63 +++++++++++
 18 files changed, 588 insertions(+), 269 deletions(-)
 create mode 100644 test.ld
 create mode 100644 test_sme_aarch64.s

-- 
2.34.1


