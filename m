Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF155EDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfja-0008L0-02; Wed, 04 Mar 2026 01:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjM-0008Fd-Qo; Wed, 04 Mar 2026 01:29:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjE-000584-EU; Wed, 04 Mar 2026 01:29:07 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246SbBM071191
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:28:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=b/SVMcXZ2QWGmVU2DOJZIZ77WaPYbQu05fSDv3JbN8M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605724; v=1;
 b=l3viaiSb0PsFjSbUKa2TTLXn5hUxrfY3bkIktEbvOf6MjJYgW809w5Wzm0L64PRe
 tOCchGIGmuu1Tuyj+7kVEbzTi/7B6zhT7vpieyQgaW8ZvHrz3kaTNlXfnIVq8tUz
 60f5Aw/heEn9cuCbn+wasgl6glCCqaqze0Kjd+MXY3sgqhzPznSdq4NHaCf2E5s5
 VFno0fvyLGu078G+EwLT1pTfFz4eI3S8OI9dov5BAwv9Rnh5jWLJW7OEnAIQaTKP
 sxHvBe8e55iBI/8Ihy/729kCqCJ73SVB9W9a1PsGfh7bXkzssA0XBVN9FD8icata
 LTM7OUpy2GCm9rivSNRV/g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 0/4] Fix use-after-free and make format overflow more
 difficult
Date: Wed, 04 Mar 2026 15:28:32 +0900
Message-Id: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDRp2kC/3XP3WoDIRAF4FdZvK4y6uquuep7lF74Mya27JroR
 hpC3r0mKRQKvTyH4ePMlVQsCSvZDVdSsKWa8tqDfBmIP9h1jzSFnokAoYELRde2IHWj1hzBjmC
 Q9NNjwZi+Hszbe8+HVLdcLg+18Xv7B2icAgWtZi95tAHNa6l75hNL7Ey3/HnJzHr2cSR3rYlfQ
 YL4EUQX5GTD7NQ0d+df4fYcWPB07u9tz5XE2YrU52VJ226wEbWSetLB6xDDaCJIA0KaGA04EQG
 U8MLNHbt9A0KhC4EzAQAA
X-Change-ID: 20260125-nvme-b4661e0a409e
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alex Williamson <alex.williamson@nvidia.com>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

nvme-ns has a use-after-free of a formatted string, so fix it by
embedding a fixed-length buffer to the object. Embedding a buffer lets
me avoid a chore to add a function to call g_free().

But I don't want to worry about a buffer overflow, so let the compiler
check that the buffer won't overflow; C is so restrictive that it cannot
enforce the existence of g_free(). Compilers can check the length of
formatted string on the other hand.

Then GCC started complaining about buffer overflow, so let's treat them.
Fortunately, the potential buffer overflows it detected are not
user-facing or very subtle. Treating them by growing buffers can improve
robustness with practically no cost.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Changed to avoid sprintf() with "%.6f" in tests.
- Replaced the message of patch "vfio/pci: Grow buffer in
  vfio_pci_host_match()" with a improved version by Alex Williamson.
- Link to v2: https://lore.kernel.org/qemu-devel/20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Rebased.
- Changed to use g_strdup_printf() in patch
  "contrib/elf2dmp: Grow PDB URL buffer".
- Link to v1: https://lore.kernel.org/qemu-devel/20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (4):
      contrib/elf2dmp: Grow PDB URL buffer
      vfio/pci: Grow buffer in vfio_pci_host_match()
      tests: Avoid sprintf() with "%.6f"
      meson: Add -Wformat-overflow=2

 meson.build                              |  1 +
 contrib/elf2dmp/main.c                   | 32 +++++++++++++++-----------------
 hw/vfio/pci.c                            |  2 +-
 tests/unit/test-qobject-input-visitor.c  |  8 ++------
 tests/unit/test-qobject-output-visitor.c |  7 ++-----
 5 files changed, 21 insertions(+), 29 deletions(-)
---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20260125-nvme-b4661e0a409e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


