Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C26C4829D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAbQ-0008TA-Gj; Thu, 08 Feb 2024 15:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbO-0008S3-KM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:30 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rYAbM-0001T1-Pr
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1707422543; bh=7lMWTrQNZjdqTwsyvaOpk/L3IWGHjmXI3JYiiYwy+iA=;
 h=From:Subject:Date:To:Cc:From;
 b=fFgeLTgmTdYF7VQiQG+XcXJ9j7khSe9LLJw3WHTALn9x8OpLSfkhutt46fFT+KA+O
 lAejxLEif0PpghvYLrSVX3Hkc3/9WdtmovyM4KvpQQefTSDMF+3UWMJAzZUIRKdwjw
 ija2TWfbmEZ45MJ3vTImb1x8J7VmKyPFjMhc3e1o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH v6 0/6] hw/misc/pvpanic: add support for normal shutdowns
Date: Thu, 08 Feb 2024 21:02:19 +0100
Message-Id: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEszxWUC/33NwWrEIBQF0F8ZXNfynj6jdjX/UWahxjRukhBTp
 8OQf68ZKIQQurwXzr1PluOcYmYflyebY0k5jUMNzduFhd4NX5GntmYmQEhEID6VyQ0p8Nx/L+1
 4HziISJ6CJ0uWVTbNsUs/r8nPW819yss4P14PBbf2n7GCHOqiVBKVNhb9deEm9O9tZNtWETsvz
 IkX1RsJ0kpPKvjm4OXe2xMvqw/WCWNFF5SQB09/ngBBn3ja/lEBOB0JDB682vnTf1V9pxw04I0
 OmnZ+Xddfb7DVIa8BAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707422542; l=3259;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=7lMWTrQNZjdqTwsyvaOpk/L3IWGHjmXI3JYiiYwy+iA=;
 b=VJf8ldHBEOgxlLVBCEKOw1oArdpxt4eNPWPdzfiZ5XZoL4b9H8iUyozufdaH9YwGLslhsiY1V
 YK2Xy8F8oHmBFbGlxKGl4cA3VdEA6bipKAwuifbE3XVP/B/NUgYNdbD
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

The background is the usage of minimal Linux kernels with different
architectures for testing purposes.
Poweroff support varies highly per architecture and requires a bunch of
code to be compiled to work.
pvpanic on the other hand is very small and uniform.

Patch 1, 2 and 3 are general cleanups, which seem useful even without this
proposal being implemented.
They should also be ready to be picked up from the series on their own.

A corresponding patch has been submitted for Linux [0].
This is also where the request was voiced to drop move away from a
pvpanic uapi header in Linux.

[0] https://lore.kernel.org/lkml/20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net/

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Changes in v6:
- Replace magic constant "4" in tests with PVPANIC_SHUTDOWN
- Link to v5: https://lore.kernel.org/r/20240129-pvpanic-shutdown-v5-0-f5a060b87c74@t-8ch.de

Changes in v5:
- Add patch from Alejandro to emit a QMP event.
- Update cover letter.
- Add tests.
- Link to v4: https://lore.kernel.org/r/20240107-pvpanic-shutdown-v4-0-81500a7e4081@t-8ch.de

Changes in v4:
- Rebase on 8.2 master
- Resend after tree reopened and holidays
- Link to v3: https://lore.kernel.org/r/20231129-pvpanic-shutdown-v3-0-c9a2892fc523@t-8ch.de

Changes in v3:
- Drop from Linux imported pvpanic header as discussed with Cornelia and
  requested by Greg
- Link to v2: https://lore.kernel.org/r/20231128-pvpanic-shutdown-v2-0-830393b45cb6@t-8ch.de

Changes in v2:
- Remove RFC status
- Add Ack from Thomas to 2nd patch
- Fix typo in title of 2nd patch
- Link to v1: https://lore.kernel.org/r/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de

---
Alejandro Jimenez (1):
      pvpanic: Emit GUEST_PVSHUTDOWN QMP event on pvpanic shutdown signal

Thomas Weißschuh (5):
      linux-headers: drop pvpanic.h
      hw/misc/pvpanic: centralize definition of supported events
      tests/qtest/pvpanic: use centralized definition of supported events
      hw/misc/pvpanic: add support for normal shutdowns
      tests/qtest/pvpanic: add tests for pvshutdown event

 docs/specs/pvpanic.rst                   |  2 ++
 hw/misc/pvpanic-isa.c                    |  3 +--
 hw/misc/pvpanic-pci.c                    |  3 +--
 hw/misc/pvpanic.c                        |  8 ++++--
 include/hw/misc/pvpanic.h                |  5 ++++
 include/standard-headers/linux/pvpanic.h |  9 -------
 include/sysemu/runstate.h                |  1 +
 qapi/run-state.json                      | 14 ++++++++++
 scripts/update-linux-headers.sh          |  3 +--
 system/runstate.c                        |  6 +++++
 tests/qtest/pvpanic-pci-test.c           | 44 ++++++++++++++++++++++++++++++--
 tests/qtest/pvpanic-test.c               | 34 ++++++++++++++++++++++--
 12 files changed, 111 insertions(+), 21 deletions(-)
---
base-commit: 9e34f127f419b3941b36dfdfac79640dc81e97e2
change-id: 20231104-pvpanic-shutdown-02e4b4cb4949

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


