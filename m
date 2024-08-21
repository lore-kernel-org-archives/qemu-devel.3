Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb2y-0000Uu-UW; Tue, 20 Aug 2024 22:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2w-0000Ll-7k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:02 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2p-0006D9-Uq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:25:57 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db35ec5688so3433378b6e.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207154; x=1724811954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H8MxOCFT1492/H8/vhTjN4EuhT6lU2u6x0ImxpIXlGg=;
 b=helcckDvB0VXTVzmCDzOom/R6320xfLL/vqfonvP4iOV6YBgCUi9xUnvlXixC7cUq8
 cIO/7QrGoqaK2peK3Yt2q4VK0E3hYTW1KjTmi9UcjrV41FGABBZPYbCI0+Oy8VKqOUjL
 djcWirjCYdQY0kvqZz9WW++aup1vdMS0MVykJ2OB0uhIxTUyPKRgmSa9OM3tknmbcjrt
 FbMnvS91F3o7DC2GjSKMCnb/O6aqNfz8nMF0x5kDLjfVkKSZrf7ir0VGYHMX98iHWWm2
 BJEl3sfAtRQU8yHEpv+2xgoqFavWnzjxahowdwiQC0ZKOK3K/8UPQkzKVd2otgEwflLz
 pwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207154; x=1724811954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H8MxOCFT1492/H8/vhTjN4EuhT6lU2u6x0ImxpIXlGg=;
 b=JPttTJhiibj2K4QHNtT3VQNroVm9vHSj47blOxsXw+1b4RbbW+W67K+lC70DugmUKR
 1IicAzaAeuOBSRNu45WuHEI8bS5EyvJPN9eGOxla0Pd+Fr1UumAHBN2t7JitVZ98rvYa
 iVJku3CrHVfxxN2TMpaTDk0KE4wZGZL1e0JXfz2QHwL4N8xfiUiJhDNpsA1WahJhL2PI
 R9IdI9Q7o7glXR/fxonw7od9tbklB+1MMgB9BuuDrRmZ79AXUy3bUp3bTrii7PcJb0Rz
 9QtbBJKRZSASWEuRbpd2wRqRbQIV7mcmaQpW4gIxobwYGw0cqb0CAGNsTzz7TKt4s+QM
 7KLg==
X-Gm-Message-State: AOJu0YyazLS8DmQCQXz2PG3wHUXj0njqEzGjYMoHEWr3LbiG2IHse5Eg
 sclnGoDdqLbjqMUfeE2n5AxwrMLbVpV6//1v0U4ygQymCmwvLGc698nZG/kPNXqcrxBQ7C7HsHA
 r/o4=
X-Google-Smtp-Source: AGHT+IGVNs/aHTyEm8EBCmy5tJeAJmHOfKM/w6OTQOWEUO8Kp6CL/qQFcx7HMP8H22PRl/YkMa7J8A==
X-Received: by 2002:a05:6808:1926:b0:3db:16a3:748a with SMTP id
 5614622812f47-3de19d20f52mr1249391b6e.32.1724207154072; 
 Tue, 20 Aug 2024 19:25:54 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.25.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:25:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] misc patch queue
Date: Wed, 21 Aug 2024 12:25:43 +1000
Message-ID: <20240821022548.421745-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Two x86 fixes and one {bsd,linux}-user fix.

r~


The following changes since commit 9eb5bfbe3394b92fb37cc6f155ceea4d6c9e401c:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-08-20 21:29:52 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20240821

for you to fetch changes up to ded1db48c9f9b35f6d9569e53503e2b345f6d44e:

  target/i386: Fix tss access size in switch_tss_ra (2024-08-21 09:11:26 +1000)

----------------------------------------------------------------
target/i386: Fix carry flag for BLSI
target/i386: Fix tss access size in switch_tss_ra
linux-user: Handle short reads in mmap_h_gt_g
bsd-user: Handle short reads in mmap_h_gt_g

----------------------------------------------------------------
Richard Henderson (5):
      linux-user: Handle short reads in mmap_h_gt_g
      bsd-user: Handle short reads in mmap_h_gt_g
      target/i386: Split out gen_prepare_val_nz
      target/i386: Fix carry flag for BLSI
      target/i386: Fix tss access size in switch_tss_ra

 target/i386/cpu.h                        |  5 ++++
 bsd-user/mmap.c                          | 38 +++++++++++++++++++++++++--
 linux-user/mmap.c                        | 44 +++++++++++++++++++++++++++-----
 target/i386/tcg/cc_helper.c              | 18 +++++++++++++
 target/i386/tcg/seg_helper.c             |  5 ++--
 target/i386/tcg/translate.c              | 27 ++++++++++++++------
 tests/tcg/x86_64/test-2175.c             | 24 +++++++++++++++++
 target/i386/tcg/cc_helper_template.h.inc | 18 +++++++++++++
 target/i386/tcg/emit.c.inc               |  2 +-
 tests/tcg/x86_64/Makefile.target         |  1 +
 10 files changed, 163 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-2175.c

