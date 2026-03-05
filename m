Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B7BEEF30C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy223-0008NK-QK; Thu, 05 Mar 2026 01:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21m-0008C4-Hn; Thu, 05 Mar 2026 01:17:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vy21j-0002Vb-Nl; Thu, 05 Mar 2026 01:17:42 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6256HKco066823
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Mar 2026 15:17:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9BpMtcFk2KI6FXMSiaVuJo/0zgkRI4m9kwaVDahtU8g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772691443; v=1;
 b=LzaFKTIdGpMmYcV35j+1k/PXnPx4ahL/vLmvX6ECQbSPtNZ0X/safA6W7zLI9c0n
 uHD7roeoBDvyniJK1ZrjAw0BTvGzFroAKhGJjwAxufpaX5B3ugbfsLtNnbPeb0dI
 NQJRsOr3E02cLDDh24ToHYL/WUZEx6MvhBbVlfXbxHAaSb4kuz+9wGco7P46eeHB
 t0Axvhi2eHvhKdYmuKjxzDZzq/DtXvMfFEGzE7pSzpGRQovwngdKahtmR0W5qQ/7
 LNaPLZ9Ks/Q7rMsdbyYGE9rTi16H+uzX+E/fe5KXbQU4Io27Yd7AYnMyXkLyzfiq
 3HmVbYFgzmmq40wRJkfqLg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 0/4] Fix use-after-free and make format overflow more
 difficult
Date: Thu, 05 Mar 2026 15:16:43 +0900
Message-Id: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMsfqWkC/33Qy2rDMBAF0F8xWldmNLJlK6v+R+lCj1GiFlup5
 JiEkH+P8oCWQru8l+HAnTMrlCMVtmnOLNMaS0xzDd1Lw9zOzFvi0dfMEFCBwJ7P60TcdkoJAtO
 BJlZP95lCPN6Zt/ead7EsKZ/u6ipu7S9gFRw4qH50UgTjSb/msm1dbGN74Ev6PKXWuPZjz27ai
 t+CBHwKWAU5GD/afhir868gfwrdU5BVsNYKOwSPHuyfwuUxMdPXoT5oeexk1hTiLk1TXDaNCaR
 6qQblnfLBdzqA1IBSh6DBYgDo0aEdK3a5AnJnHgd1AQAA
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
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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
Changes in v4:
- Patch "tests: Avoid sprintf() with '%.6f'" now has an improved title
  ("tests: Clean up double comparisons to avoid compiler warning") and
  message written by Markus Armbruster.
- Link to v3: https://lore.kernel.org/qemu-devel/20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp

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
      tests: Clean up double comparisons to avoid compiler warning
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


