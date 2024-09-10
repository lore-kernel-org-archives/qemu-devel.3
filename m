Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F83EEE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7yS-0001VZ-3q; Tue, 10 Sep 2024 17:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so7yR-0001Uc-4P; Tue, 10 Sep 2024 17:00:31 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so7yP-0008CK-FV; Tue, 10 Sep 2024 17:00:30 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6b747f2e2b7so10212767b3.3; 
 Tue, 10 Sep 2024 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726002026; x=1726606826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GuF2q+XJduNptJFKCZo3OKL6lHgjP0SdHsR208ZITnA=;
 b=CT/sGu4B+yJFX17M/+gh912JzZKi6IjBwZq2I1Qzq+zQKkP69rO7GHcyVXYSQiNSTM
 thUbH9WaT4YnH9noVGpIhKygsBxtI5SuwvJJcTIWElRy/BHKk2TKn0gpx5xZqiKf56kv
 UFuKl1vVnlCBXFxo0DDx/IEdYtz8KQYYgzSXKGHPGNc/h7rrkoCvOjfV4ArZpal6Pxmf
 mvLp1DHi/yYny5+5rgx9gMqcQteoCyAHeJXRkaq1x1KDNSm22CvJMQqzsZ7PGLHDoj6h
 CAZoax7uL97PxSXjpTDetzheCsjKKROrTe7/p3EBIvo7Fa3Ph5zY29dqygEpCBIirAC3
 guQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726002026; x=1726606826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GuF2q+XJduNptJFKCZo3OKL6lHgjP0SdHsR208ZITnA=;
 b=A9obwgbgNDOxFruwcr2Rqe0C6bK2va/lRRhZSBCPzTVZ4l8z6FoWn8EHntoWSiP628
 yJDmxc49V0Mhl+/1+UrjhO59z3xDNBrWg7YfAYfa3MF0it1klDtBkSnam9VxA/cwmMoQ
 YPRjLAFUeWJc27ThvLLiGUlnXr+JkUkNVpFcLi0k3oKsplhZSngSXWEUjpQHCx79sORU
 3KwM4TFe2JEU9AhNMaw1pVvBsmFCgYsyWiEyb/vQpa9+BXbmO3bBxQRKQxM6Gc34rVAc
 LEOdvr4QJpHK/B615ao/IpCoxYc3rtmH0A8sbn1GG4BD8gVQjXka6jQWGs6H8FhAhqCL
 boAA==
X-Gm-Message-State: AOJu0YzRQvpnRZskNK06pIefYf0ZqkQ7I7phK+ZQNBudFUprazB8B5GG
 pMuiNOkoaOq4J8iTN6Xg5DTqfYxPSNyt/4PrpuHIHI/djCGAv7ND810WxzYy
X-Google-Smtp-Source: AGHT+IHxfo4RMJo/QpqMrirOLkuNYBI08Zdypu1c9gwuE2wotUN9OxQ9psgxrZpSXVlzlJXLyof2IA==
X-Received: by 2002:a05:690c:316:b0:6d6:7c9a:bf58 with SMTP id
 00721157ae682-6dba6e0d6b2mr13053837b3.28.1726002026372; 
 Tue, 10 Sep 2024 14:00:26 -0700 (PDT)
Received: from localhost ([2600:1700:830:3db0::14])
 by smtp.gmail.com with UTF8SMTPSA id
 00721157ae682-6db965215c9sm4387217b3.119.2024.09.10.14.00.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:00:25 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v4 0/2] Add support for generating OpenSBI domains in the
 device tree
Date: Tue, 10 Sep 2024 14:00:19 -0700
Message-ID: <20240910210021.895851-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-yw1-x1136.google.com
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

This patch series adds support for specifying OpenSBI domains on the QEMU
command line. A simple example of what this looks like is included in the
documentation changes included in this series, along with detailed information
on each option to each of the new flags.

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
  Add support for generating OpenSBI domains in the device tree
  Add documentation for command-line OpenSBI domains

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


