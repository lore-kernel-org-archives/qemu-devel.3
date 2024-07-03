Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6815C3271F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP404-0003Hi-Ty; Wed, 03 Jul 2024 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP400-0003FN-TI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP3zy-0005L2-7n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 13:42:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so33047095ad.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720028548; x=1720633348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9rsjcrfQ2cyUBUHYCAMnDhrC0DCadQBGWJaj8Yt/WK0=;
 b=xnWtmHbiiQtH2iwf3IUPCURapgNmY60kiz57HFfdZI2AnL+FG63+0fpl6uSd3s4Uo9
 3nY2KJWjtvm0bKNUO5hHt3NBVE9337kf8sf/0/VveDooN5tQh2KQKeX+lA4N8C9p4NZm
 FqFSf+rlWpxaO+w4U8XqghjgmPgBnRWRI7AQtssl/neLuXa3VDBXz6uA1EGRIdKuHS0f
 DvxNj/OsYBxKqza8IFmSKYrHGzjtg0OXHpJcDFW1z8SQMlPHNpnIPUr4q8NgFVKTJY1s
 zf0QBinW9innV2warNovpwH9d6YRpNtemCYU9vDYXAPdKkt0puXjO9bYLopwo1A1j5Cx
 Eg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720028548; x=1720633348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rsjcrfQ2cyUBUHYCAMnDhrC0DCadQBGWJaj8Yt/WK0=;
 b=uWTeqGcH/m+1pNdy2D+7h5YQw09HWAmIpHqwfPDGZTZx4ViHI8hfeRtm2nkOShYs1c
 hbvFOnSJ5vPfK1k5PSBcHsAI0DwKY6Uclfo2bMgFOHsL1SUw7Fo7gjvzvV5RXTbuvdGD
 UiPXTVCepeRK6sLtMHfE64dxxoro9lRt4KOVZ4g3ojB8CbX6mdIxqBnJILyhvCIeKLtt
 mmo5GDMd8AVPt/S4bh2jdIz5F+xGq6W7MKyIUys1axsFrZ0PoHruvjEOMaUTfnWMuONS
 sj/ZD+5xODUY9N0Jyp4Q7P1tDoIx9HAftDqaQqW6qovNavCLM7LIkiudsPjFsNokiWkS
 /YRQ==
X-Gm-Message-State: AOJu0YwgUvzELLfwdoFxEdVzFq7/Oj1e7Y3dtbtLkaQhaAPbFTKrY/Nb
 c9gHwB04swhuKOytqrj9GrzN3wOp7lOtKvWlscmV7RqgHiXwXnz+CGvvFFIQxK2bgiaV37sXuXb
 G
X-Google-Smtp-Source: AGHT+IFHf6CVaAM3dHfSeVzasX1nTvSc5x7I9DUmAKgE8dS+132DAbsP3Vu7IzWJKx+rMtKpwWki6Q==
X-Received: by 2002:a17:90a:348b:b0:2c9:5fae:4f83 with SMTP id
 98e67ed59e1d1-2c95fae5251mr4218193a91.6.1720028547904; 
 Wed, 03 Jul 2024 10:42:27 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7d7bsm11070030a91.47.2024.07.03.10.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 10:42:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] tcg patch queue
Date: Wed,  3 Jul 2024 10:42:19 -0700
Message-Id: <20240703174226.2117169-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The following changes since commit 6746482d12da3b6e4d3cdf06481a0027a797f719:

  Merge tag 'sdmmc-20240702' of https://github.com/philmd/qemu into staging (2024-07-02 09:52:10 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu tags/pull-tcg-20240703

for you to fetch changes up to a71d9dfbf63db42d6e6ae87fc112d1f5502183bd:

  tcg/optimize: Fix TCG_COND_TST* simplification of setcond2 (2024-07-03 10:24:12 -0700)

----------------------------------------------------------------
util: cpuinfo portability fixes for FreeBSD and OpenBSD
util: cpuinfo for riscv host
tcg/optimize: Fix TCG_COND_TST* simplification of setcond2

----------------------------------------------------------------
Brad Smith (3):
      util/cpuinfo-ppc: Fix building on OpenBSD
      util/cpuinfo-ppc: Add FreeBSD support
      util/cpuinfo-aarch64: Add OpenBSD support

Richard Henderson (4):
      util/cpuinfo-riscv: Support host/cpuinfo.h for riscv
      util/cpuinfo-riscv: Support OpenBSD signal frame
      util/cpuinfo-riscv: Use linux __riscv_hwprobe syscall
      tcg/optimize: Fix TCG_COND_TST* simplification of setcond2

 meson.build                       |   6 ++
 host/include/riscv/host/cpuinfo.h |  23 ++++++++
 tcg/riscv/tcg-target.h            |  46 +++++++--------
 tcg/optimize.c                    |   2 +-
 tests/tcg/x86_64/test-2413.c      |  30 ++++++++++
 util/cpuinfo-aarch64.c            |  36 ++++++++++++
 util/cpuinfo-ppc.c                |  27 ++++++---
 util/cpuinfo-riscv.c              | 118 ++++++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.c.inc        |  84 +++------------------------
 tests/tcg/x86_64/Makefile.target  |   2 +
 util/meson.build                  |   2 +
 11 files changed, 266 insertions(+), 110 deletions(-)
 create mode 100644 host/include/riscv/host/cpuinfo.h
 create mode 100644 tests/tcg/x86_64/test-2413.c
 create mode 100644 util/cpuinfo-riscv.c

