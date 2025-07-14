Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116BEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIqQ-0008Ko-Q6; Mon, 14 Jul 2025 09:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtV-0007CR-BP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:53 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtK-0003ri-6h
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:51 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae0dffaa8b2so838974866b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494558; x=1753099358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m/O59ZeqFnOFRxSa/swbrG3OPWL18EdennTcxn0riCw=;
 b=cKKbhfFce6+ssAHQH8Ve9drjs1zIr20Yybew3zOm19i8ZQMDR2wMfivqDh3neDxRMt
 dwyVCrm3kzn818YbqsdfS6RvoQpBB+Em8ZIxUpGrN6WnPO9fafKInnVsMzO6inA6UcFp
 TMSUbwLdWhnelcKqif1HLUbGuRsvgZkZp8nfko0CrGQHPI1TAs34cG75gxaF5dgAgH9G
 PHTcRFTanANzT/b4eQn2KAIglKJuNJAFbev+UVOKpzVHI7Be1sZKQaAP9i5NHNUnMK3Y
 gJ+Ugs/xw2Wy0C1C+zownd33ruK2q7HjSowCXcpDJQEdVXYpI8e/pc8UDnEup6zFR7bi
 OX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494558; x=1753099358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/O59ZeqFnOFRxSa/swbrG3OPWL18EdennTcxn0riCw=;
 b=XBDP8VV8AfNAzgT1UHz9Kfj1onsXq/at5zljwabhiFHUpIwF2icyGJ81QF9sikO+vi
 ABSkde0YB/6aWJ/987QuEqcQGbQ1WPKuckntVHWxShYGMeNUyWWGlmRnaIoeIXAav+ro
 aRcLEzkvRn1RiCS+821en+7YYGjbGtzLZ619pgmvbQm3Mi1xo3KOsBGhijznn7dXwQiq
 OuBUs9GT46N4Ase9Qyf7hst0ZUGQU6PiT+ZXR1XKsmP3SfAbzJOIk+tcDFRuZeoxQK5p
 9Ql2EEvNp526+cBQnkIL2M6VJlx98qJJjagevFXUqOZLvUb5Tf68zjygdnXTA1VJCmK7
 9pdQ==
X-Gm-Message-State: AOJu0Yw9xZkiOBCz6zEyCM5IIEVWdBtZ/R1Qz+64xItsAQpPNKa5vvSu
 qSpKYczd2voW7jtY+V8/xtkVg+DdpWpMl8IJ3Gva1mu5OQt6ecQAEODZ/8Vmw23udRLHB3XfKVN
 ktktd36s=
X-Gm-Gg: ASbGncvwtM3MOOIut5z7rooeY+UBAxzhM2xgJjSlwhRa2y0XpYCILbgP/W0rqZEiiOy
 7+NiB6bpQeKG9IWszJomIxi7BbwKSMOicFpK1LDlor107kM0Gzbmtw6U2kyGiC5KmloErKnh6L/
 oArFKJVuQWNAztXDCwjM8YgSvV5kjLbK2ijx4xU/hameBsHhPgCFUzt/mI93W8CYz6AYOFlEZvY
 8D3M2uScayU6x+mC1rL91f+LJG53AR8FUoaD4Orz4sQJTloygyz1OF5NGrmKd+iZY+FVIz0niBw
 lX9kQVBR5hCDYJwvpY7CxLhMvRDpyNFDyg10GJ3zb2BgUVeBGrFzds2yKKawp//WBxQ22E53snT
 iqbHQ51DnQxqmNGmrH4dFxcE=
X-Google-Smtp-Source: AGHT+IFoxKdsQ0VxnqPYeLMSssrte55NMPo00eauatnHtPaGmHz2v4r0u4cHSrRX7WBi/nxWXvtpBA==
X-Received: by 2002:a17:906:f599:b0:ae1:c79f:2b2e with SMTP id
 a640c23a62f3a-ae6fbf968ccmr1431487366b.40.1752494556471; 
 Mon, 14 Jul 2025 05:02:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e8264608sm818259266b.109.2025.07.14.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4E955F81E;
 Mon, 14 Jul 2025 13:02:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/8] maintainer updates for rc0 (gitlab, gdbstub, plugins, docs)
Date: Mon, 14 Jul 2025 13:02:26 +0100
Message-ID: <20250714120234.1524401-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-rc0-maintainer-140725-1

for you to fetch changes up to 9152540f4ef3528ff003493cbe6a27b6c0f322e8:

  gdbstub: add the GDB register XML files for sparc64. (2025-07-14 11:42:49 +0100)

----------------------------------------------------------------
maintainer updates (gitlab, plugins, gdbstub, docs)

  - update check-units script to take -n <top> argument
  - fix execlog plugin to handle tab separators
  - add gdb XML file for alpha
  - add gdb XML file for sparc64
  - use :kbd: in docs to highlight key sequences
  - clean up rst formatting in virtio-net-failover docs

----------------------------------------------------------------
Alex Bennée (4):
      gitlab: use argparse in check-units script
      gitlab: add -n option to check-units script
      plugins: fix inclusion of user-mode APIs
      docs/system: clean-up formatting of virtio-net-failover

Manos Pitsidianakis (1):
      docs: use :kbd: role in sphinx docs

Rot127 (1):
      gdbstub: add the GDB register XML files for sparc64.

Yodel Eldar (2):
      contrib/plugins/execlog: Add tab to the separator search of insn_disas
      target/alpha: Add GDB XML feature file

 docs/devel/testing/main.rst            |   4 +-
 docs/system/images.rst                 |   2 +-
 docs/system/keys.rst.inc               |  49 ++++++------
 docs/system/linuxboot.rst              |   2 +-
 docs/system/mux-chardev.rst.inc        |  38 +++++----
 docs/system/virtio-net-failover.rst    |  51 +++++++------
 configs/targets/alpha-linux-user.mak   |   1 +
 configs/targets/alpha-softmmu.mak      |   1 +
 configs/targets/sparc64-linux-user.mak |   1 +
 configs/targets/sparc64-softmmu.mak    |   1 +
 contrib/plugins/execlog.c              |  15 ++--
 linux-user/plugin-api.c                |   1 +
 target/alpha/cpu.c                     |   1 +
 target/sparc/cpu.c                     |   1 +
 common-user/plugin-api.c.inc           |   1 +
 .gitlab-ci.d/check-units.py            |  29 ++++---
 gdb-xml/alpha-core.xml                 | 136 +++++++++++++++++++++++++++++++++
 gdb-xml/sparc64-core.xml               |  99 ++++++++++++++++++++++++
 linux-user/meson.build                 |   5 +-
 19 files changed, 352 insertions(+), 86 deletions(-)
 create mode 100644 gdb-xml/alpha-core.xml
 create mode 100644 gdb-xml/sparc64-core.xml

-- 
2.47.2


