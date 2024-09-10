Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849ABEDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8Mm-0001sG-CF; Tue, 10 Sep 2024 17:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so8Ml-0001oZ-Bk; Tue, 10 Sep 2024 17:25:39 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so8Mj-0002IK-Q4; Tue, 10 Sep 2024 17:25:39 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e1a9f84699cso1188766276.3; 
 Tue, 10 Sep 2024 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726003536; x=1726608336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=22XBIU3pc0P+VXjFfMQTf9BHKfxrdihaJYixQ+/HslQ=;
 b=OoaS13CfwtHpdn7jG/GOwplGsrRbWuKUeJhBtvFxpMnqS0gPzMKz4UbHwyiBtowlYv
 2yDs4CnyV7CKSNVdj3x9gx8a/SYxtcD/J5yS22k622aYF2HvvOzuNuVlNk9ypXNju9cu
 j2WbrOyBqSqbaJMIYBLFBZtRbwEAN0vRSXze0esgNGL3h1REqoCNxTlbbl0AG5s2G5Hw
 AZ/3NO2ANwvvsrI79JluPn/dQfY/sT7f4reO0YdwhUmUUffP/fZL9xWmeo+rbiF7SbZ8
 5ChAL5aAm9urQpNR5dUZXopLogVvruq5ocynLyeKNratz/1ofvyn8SQtKdU8wl22a6EH
 ZrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003536; x=1726608336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22XBIU3pc0P+VXjFfMQTf9BHKfxrdihaJYixQ+/HslQ=;
 b=vG8+BXbO+LMsY2IEVl4cAupmciBBMkbOQQZ0BGmsW+fDG/wSI2zDbU7TA0vmAOV3fZ
 CZOXD6D3niNmP7Xc+tsaJFTBO3dZnsNPnLIOyPxWSr6OYeKjteRPJ3UNIZkfuJTeKBsT
 XK26aD7NIIWF5ayJsIN66BlU0F4qKVdISJg7OrwXqickUNNP8umWNhvx71Kl0vzsOUwI
 DL5tctYXtqStVHrirNAjRodSWQJYabWThZ/nRo6WjDdszv7CCuuW7z5OFqjnGz6KhRr5
 2K/1CtrdSf5nL3wpXxfhS2Z6PrHpru1xnygespg9xApiW1X4q+NXL/ZQxkItnpUNsL7y
 lsAA==
X-Gm-Message-State: AOJu0Yyde0ZrSlRfRjmCILltq5fAls34ah4LzKLJNurttZtkuSSPv6zs
 GVRL7ZvBPdcdU/9OiGnp7+QEY7+1NGm888wTUjojw5j4VG+62QixFLtDQ+2u
X-Google-Smtp-Source: AGHT+IF5tMLJTThQKUhN6jHYXmU0V4XhmmYX6bhzrsborRfVr4GM+q4ntfkZNaC0p98lON/Ob0BC7A==
X-Received: by 2002:a05:6902:250a:b0:e1a:441f:3208 with SMTP id
 3f1490d57ef6-e1d8c38d412mr986649276.23.1726003535957; 
 Tue, 10 Sep 2024 14:25:35 -0700 (PDT)
Received: from localhost ([2600:1700:830:3db0::14])
 by smtp.gmail.com with UTF8SMTPSA id
 3f1490d57ef6-e1d7ba1c297sm459686276.27.2024.09.10.14.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:25:35 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v5 0/2] Add support for generating OpenSBI domains in the
 device tree
Date: Tue, 10 Sep 2024 14:25:29 -0700
Message-ID: <20240910212533.986734-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Apologies for the double-email, forgot to run checkpatch ...

This patch series adds support for specifying OpenSBI domains on the QEMU
command line. A simple example of what this looks like is included in the
documentation changes included in this series, along with detailed information
on each option to each of the new flags.

v5:
- Add missing Signed-off-by line in the documentation commit

v4:
- Added license comments to the top of each new file
- Made id mandatory for OpenSBI domains
- Added documentation

v3:
- Addressed review comments from v2 by adding default values to new properties.
  This results in concrete errors at QEMU configuration time if a mandatory
  property (as mandated by the OpenSBI spec) is not provided.
- Changed command line encoding for the possible-harts field from a CPU bitmask
  (e.g. where bit X is set if CPU X is a possible hart) to a range format (e.g.
  the possible harts should be CPUs X-Y, where Y >= X). This does constrain the
  hart assignment to consecutive ranges of harts, but this constraint is also
  present for other QEMU subsystems (such as NUMA).
- Added create_fdt_one_device(), which is invoked when scanning the device tree
  for a memregion's devices. This function allocates a phandle for a region's
  device if one does not yet exist.

v2:
- Addressed review comments from v1. Specifically, renamed domain.{c,h} ->
  opensbi_domain.{c,h} to increase clarity of what these files do. Also, more
  consistently use g_autofree for dynamically allocated variables
- Added an "assign" flag to OpenSBIDomainState, which indicates whether to
  assign the domain's boot hart to it at domain parsing time.

Gregor Haas (2):
  hw/riscv: Add support for generating OpenSBI domains in the device
    tree
  docs/system/riscv: Add documentation for command-line OpenSBI domains

 MAINTAINERS                           |   8 +
 docs/system/riscv/opensbi_domains.rst | 156 +++++++
 docs/system/target-riscv.rst          |  10 +
 hw/riscv/Kconfig                      |   4 +
 hw/riscv/meson.build                  |   1 +
 hw/riscv/opensbi_domain.c             | 558 ++++++++++++++++++++++++++
 hw/riscv/virt.c                       |   3 +
 include/hw/riscv/opensbi_domain.h     |  69 ++++
 8 files changed, 809 insertions(+)
 create mode 100644 docs/system/riscv/opensbi_domains.rst
 create mode 100644 hw/riscv/opensbi_domain.c
 create mode 100644 include/hw/riscv/opensbi_domain.h

-- 
2.46.0


