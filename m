Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9955DC48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWBO-0007oU-0Z; Thu, 01 Feb 2024 07:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBL-0007nC-Bx
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:39 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBJ-0002AK-Nv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:39 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a358ec50b7cso155137466b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706790516; x=1707395316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=49bETIGAGO5DtX3RKiRXyAPOmtwqu8Y4dqTuszg5to0=;
 b=LTgKz/dHzw5t5KWqIe8ddWPfv8RM/2egrrmpk6cZHzokhDx49AD/7VAgDaSSsQlgxU
 s16CMYsHS6ai8Lh7VRZ+qrOtEpBU0jvcUNomfdoFas41Kp8hPIAw52jQ0oldtBjE0F9T
 I15r/E80ecLqk7cKV5dYA99apI0Tjsld/KMl3orlic5Hd++lIutj81cc4pDfYiIKr+b9
 IeusIIObluuDNNZQkzgLpbSD+rnrdt7Q/JsqX/vhfyC/3N+y9VwLCi7UnAGFtVV/tipT
 ygaq4TyaTj9vKdhBo1iuw67LtW3LCxz72Kn5sdtgrcNG276HZ0fYJZKNhwK5qrQhwSud
 K6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706790516; x=1707395316;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49bETIGAGO5DtX3RKiRXyAPOmtwqu8Y4dqTuszg5to0=;
 b=V6aMo+6ljQUsjEZfYxzLU9KTBxCvOxqEQgTpHkrrZeMCbPXwYw0ojetEECPj0sFaPx
 LSDKwuwqorgQE4Idsqoa7Qp4jLJfIoqxNdV7E63C3U/IJzlydbjaexbITf62E6Pzu1nZ
 LWNW2Ubrteu6LP+lDogLLyNvr/MhM18BjkbSiNo6nb6/AefhLyN+8DHZ0pDnJDFPOHtE
 qcoZNbIQ9y89qoHMWADr1/iy+5Ry3DnupQOQvFGwFlYmTkR3I/dAVo+0U/Pji6gSxatF
 YwcdJwETYbwhf1TznBtp9h9zzlHdzUtOsvA+XjlmvBRxrX/FZpep56UQknBk728HQq5g
 uTZQ==
X-Gm-Message-State: AOJu0YxLrVxA1/Yco8NZozSYmwTlOMqE98JkZwnqVVLSjWR32c+B77Rt
 INQYnnWRZr7LdnjgmZpTPMG5yh+xQm74btAM13yMWjQrwPRAhTKUhcgIbj+zF3A=
X-Google-Smtp-Source: AGHT+IGDT0QG9z9p0hjOVy6dSp0VihBWe3jNXj6RR0DQczI/chFTjsfXSJkiCUi1EyVkpzbFBf+Viw==
X-Received: by 2002:a17:907:c01c:b0:a36:a8bb:28fd with SMTP id
 ss28-20020a170907c01c00b00a36a8bb28fdmr2189180ejc.1.1706790515940; 
 Thu, 01 Feb 2024 04:28:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV8khX4qBOXnuvtgFeQen1+WuFzW/0/MV6otlRRlqvVBGNrv+36vzpti7EAJFFGUbyOWqO3DW0k9lP7EK4kZjTDpM7qmWAlHgiAfExNyNFDESFeHCSZZfsJU68upWFxXd7ViPfG9A6mySL/QifQW65UNL9c+aV8dEXDYCqBNionyOfQ+0terOCTMvxc0vYBBM0wqiOy8vvIi6//AJwJprFJyH3XAGDRs9PFndxfzk9uAZxMxushgMez+ePx3c044aTYH9bJeKfOFQW2QWn1Kgj6H2KIxrHOLpLUdvhWLo2XabN7gfoJ3wBY2jD/C9LDJIFS/+54tUV3VkJXar8ZFZ/GOSJDpNvLVxnrk4vCWnz/uUYzQGC73A3grY8/txIUmcPOrVzUtIstthkYhoGlPaQDM86X3/9qtPzpRH7MzEu6yKBgA8fYhbheE4gsuRHhocUpDlR4AowONhon+ex6hJs4CCA6ZYaGmlAzaLBXwSmOXAcFLmFtj1Bm4xlEUjr56ZzJeuzskAN+Q+upGEanst0dMfwUfKORru9YpoQ7CE0YhyTXSViYnzIiWRPTutIDygL78d0dfmATyyf9LConT9QWmF4OcHyUeHj+txPefKFobBZk11no3WVESOOV5u6H2Tpb8aIqHoU=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m1-20020a1709062b8100b00a363e8be473sm2346985ejg.143.2024.02.01.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:28:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 447715F7AF;
 Thu,  1 Feb 2024 12:28:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>
Subject: [PATCH 0/5] maintainer updates for 9.0 (docker, plugin tests,
 deprecation, elf, semihosting)
Date: Thu,  1 Feb 2024 12:28:30 +0000
Message-Id: <20240201122835.1712347-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A fairly random collection of fixes in this tree. I've still got a
report of openbsd rebuilding which is confusing me but I didn't want
to hold up getting eyes on real fixes.

The plugins register support may get added to the PR if it gets any
review.

The following need review:

  Revert "hw/elf_ops: Ignore loadable segments with zero size"
  docs: mark CRIS support as deprecated

Alex.

Alex Bennée (2):
  docs: mark CRIS support as deprecated
  Revert "hw/elf_ops: Ignore loadable segments with zero size"

Fabiano Rosas (1):
  tests/docker: Add sqlite3 module to openSUSE Leap container

Paolo Bonzini (2):
  configure: run plugin TCG tests again
  kconfig: use "select" to enable semihosting

 docs/about/deprecated.rst                     |  8 ++
 configure                                     |  3 +
 configs/devices/m68k-softmmu/default.mak      |  2 -
 configs/devices/mips-softmmu/common.mak       |  3 -
 configs/devices/nios2-softmmu/default.mak     |  2 -
 configs/devices/riscv32-softmmu/default.mak   |  2 -
 configs/devices/riscv64-softmmu/default.mak   |  2 -
 configs/devices/xtensa-softmmu/default.mak    |  2 -
 include/hw/elf_ops.h                          | 75 +++++++++----------
 target/m68k/Kconfig                           |  1 +
 target/mips/Kconfig                           |  1 +
 target/nios2/Kconfig                          |  1 +
 target/riscv/Kconfig                          |  2 +
 target/xtensa/Kconfig                         |  1 +
 tests/docker/dockerfiles/opensuse-leap.docker |  1 +
 tests/lcitool/mappings.yml                    |  4 +
 tests/lcitool/projects/qemu.yml               |  1 +
 17 files changed, 59 insertions(+), 52 deletions(-)

-- 
2.39.2


