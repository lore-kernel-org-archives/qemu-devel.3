Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392DE63C85
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 06:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjtqp-0003KI-F6; Sun, 25 Jan 2026 01:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjtqb-00037R-QC; Sun, 25 Jan 2026 01:43:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjtqX-0001OU-Lr; Sun, 25 Jan 2026 01:43:45 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60P6h74b079417
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 25 Jan 2026 15:43:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=UmucyWBCzLPpnX2a0Igo3zYoHzAzYhL78HxlJTj7R0w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1769323397; v=1;
 b=uSGvURE58ooe5EWMxYkSVNTx5mA/2Giqa16810fRLYSAGJNhopwjFeZJEPsJBOFu
 q+0p26/sC6v5GV/lirUjfmFOJLwC6OsM+g+LYAEE191y0EZFoyvfz0mF7RstJXH/
 M/kbPrqoh891Bd3DMXcAAZukj9al1o9cJ7y8QSjpWkxaXlODMXcnzLCJxpHqBn9H
 PqG1ixkYhHMPABArNZZ6kXXC4NLXVgPICdVt0ev4OAswMZtKBMCeSkGR8XAOEmd2
 N4Wi++1xDL8aGfMx67u3fJc2gQqS2hBt0Vm5Lsg30OjyWd5sGXoEHki9gM6K1M68
 uXyN3lNS2KX6BnqKrZHEVQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/5] Fix use-after-free and make format overflow more difficult
Date: Sun, 25 Jan 2026 15:42:42 +0900
Message-Id: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGK7dWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNT3byy3FTdJBMzM8NUg0QTA8tUJaDSgqLUtMwKsDHRsbW1AHiSjkl
 WAAAA
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Akihiko Odaki (5):
      contrib/elf2dmp: Grow PDB URL buffer
      vfio/pci: Grow buffer in vfio_pci_host_match()
      tests: Grow buffers for double string
      meson: Add -Wformat-overflow=2
      hw/nvme: Fix bootindex suffix use-after-free

 meson.build                              |  1 +
 hw/nvme/nvme.h                           |  1 +
 contrib/elf2dmp/main.c                   | 27 ++++++++++-----------------
 hw/nvme/ns.c                             |  7 +++----
 hw/vfio/pci.c                            |  2 +-
 tests/unit/test-qobject-input-visitor.c  |  2 +-
 tests/unit/test-qobject-output-visitor.c |  2 +-
 7 files changed, 18 insertions(+), 24 deletions(-)
---
base-commit: d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f
change-id: 20260125-nvme-b4661e0a409e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


