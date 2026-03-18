Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BB2107760E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2woQ-0005tw-0T; Wed, 18 Mar 2026 15:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w0j-0002TP-P6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:52:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luisccunha8@gmail.com>)
 id 1w2w0h-00064E-A8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:52:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so1510405e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773859969; x=1774464769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2kipvqjqEywFr6hg3uICxgPbpohUo4kd3OBwgbhRmO4=;
 b=N1+cHPybEetjQz1J0qpYc5tOdi3c9FDFcWn8FiuzF6Bk+zxzgM7a8eEClbSeFul0sJ
 lUekU8ZkF2rw9s9H35cCiFNbC+nGnxR7cOTCTAEE7dYk95F9wL+7lc7HmzFuVgmr9TTb
 y7awPfZ6LvB0ulDvxpq5oMSyNw8/hPSYCToBuEJ+/ToFGolQXfTWOqoPWOimT6uyjYAk
 wnOOPkk0LKRY3WKp8qlEHgDmzvtNGn9KdqB2J03UapYhDxggSj/oqB1Dx2niJbm3nyzj
 0STVtlmDhLpf+NT9VWyQZUzcqrjMDSzDqHGO4Y+YPeuVHyf66BSEIphceCYQOaYyJLZc
 3T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773859969; x=1774464769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kipvqjqEywFr6hg3uICxgPbpohUo4kd3OBwgbhRmO4=;
 b=n3W0JmXOmEP5Tr6I+xFW2SjhntURMG7ZgogS+hMBkR0AaLZjAkDaYebJvpwq2KvgLP
 ACCejKqRBokanf1IhrD3d098+Ck3cDRXi/S9lHW67P6cnTitpLGix9F4BFUKpXr+p1YQ
 WLdNei//AN1wXgvliT640NrWhM6ZsLAksfYxjNSPi2M4G3G15+d7j2LIFPscBHKin7h5
 FJCOXxe0gqYw+ymKSfUTKFH5mBsqWaHNV3547m+9fqxD0vqxBtxi7saMiyh6Qtxd8t7a
 aCjfVgNycLm5Q/nwwNIVq5XBirFph+YlTRUE5ZFBAP6Z3eIE9mQDhkEVgLHM92ZZvbzS
 bZ/A==
X-Gm-Message-State: AOJu0YxSZDltbGPq3w8JKPq8l5+UkttpqbOnFoyct56eGu5i44kkSlzz
 QuqnepcWAtaWbQ0yuKI2IzT4zC4gnusa/91t9IRsS5FAdDAKAbGim5DKc4WzTl6i
X-Gm-Gg: ATEYQzwcEyR2YzqixWPiH62MH57Te4LAWSbZ4tFt7ZrVYleEtByS+WrEpF3OqJBPFcC
 p+rTYG8xYS0lQNqUZudPx/c7WliNu96jLArXQlHc2h9aAVMq+eUr/jNciPcfKe2b6JiHbij25B5
 Ynu7Yt9s3xsJlDtvRTocsx0iC08ZPA37QVtDzl5WYSHps71VXdhUrWMhYgz7sPrdBBusqt3PvSF
 I5uMwBOhwyub4yvDN+O0v93Zceh6BomTWlvbHVi7j9Q3SfliVc7WVMkeZg2cevHbe0bXqFTZ5BS
 KpgWne+l+/73BU+AKJIUlnKgHbo9Fcy7A8Ppspk4AQ8THtEAA49wccMyG5T42leKvJGUlVfyQb1
 6SFAupa0FSCMOn7TbKO86VE5A8Sl82tZKzuzra88unn7gi3lvljBUqQ+QhFyY63OEykQiJrHdCZ
 CIYwCnGhGSq14bUeLHzGnItkmj0IjIyfV0WrU8Us4LyQ39NwF/HjOxm0okmS2P5hur/zvHlisGT
 sJruzWzWP7FU9WXR4hGbtEFoQ4kvaJMOx892Kw=
X-Received: by 2002:a05:600c:8486:b0:485:3f17:410 with SMTP id
 5b1f17b1804b1-486f444862cmr78917695e9.16.1773859968548; 
 Wed, 18 Mar 2026 11:52:48 -0700 (PDT)
Received: from luis-IdeaPad-Flex-5-14ALC05.. ([148.69.202.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b0bc58sm16135905e9.3.2026.03.18.11.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:52:48 -0700 (PDT)
From: luisccc <luisccunha8@gmail.com>
To: qemu-devel@nongnu.org
Cc: luisccc <luisccunha8@gmail.com>
Subject: [RFC PATCH 0/6] Implements RISC-V S-mode Physical Memory Protection
 (SPMP) and its extensions
Date: Wed, 18 Mar 2026 18:52:30 +0000
Message-ID: <20260318185238.99143-1-luisccunha8@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=luisccunha8@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 18 Mar 2026 15:44:11 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset adds initial support for RISC-V S-mode Physical Memory Protection (SPMP) to QEMU.

Implemented version of the specification:
https://github.com/riscv/riscv-isa-manual/tree/d539cf2fe65b02a734bf97f210474f82bd5e9393

The implementation introduces the SPMP checks to the core, CSR support, delegation handling, and CPU properties to enable SPMP and corresponding extensions.

SPMP can be enabled via:
  -cpu <model>,spmp=true
Note: smpmpdeleg, sscsrind, and smcsrind also enabled.

The sspmpen extension can be enabled via:
  -cpu <model>,sspmpen=true
Note: SPMP and its depedencies also enabled.

luisccc (6):
  target/riscv: Add SPMP infrastructure
  target/riscv: Add SPMP CSR configuration
  target/riscv: Implement extension for Sharing Hardware Resources
    (Smpmpdeleg)
  target/riscv: Implement extension for Optimizing Context Switching
    (Sspmpen)
  target/riscv: Enable SPMP support in CPU
  target/riscv: Add CPU properties for SPMP and sspmpen

 target/riscv/cpu.c                |  88 +++++
 target/riscv/cpu.h                |   9 +
 target/riscv/cpu_bits.h           |   9 +
 target/riscv/cpu_cfg_fields.h.inc |   3 +
 target/riscv/cpu_helper.c         | 139 ++++++--
 target/riscv/csr.c                | 167 ++++++++++
 target/riscv/meson.build          |   1 +
 target/riscv/pmp.c                |  14 +-
 target/riscv/pmp.h                |   1 +
 target/riscv/spmp.c               | 516 ++++++++++++++++++++++++++++++
 target/riscv/spmp.h               |  83 +++++
 11 files changed, 1005 insertions(+), 25 deletions(-)
 create mode 100644 target/riscv/spmp.c
 create mode 100644 target/riscv/spmp.h

-- 
2.43.0


