Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB713D58E73
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 07:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwy1M-000468-Og; Mon, 02 Mar 2026 02:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwy1J-00043R-WE; Mon, 02 Mar 2026 02:48:50 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwy1H-0001An-7Q; Mon, 02 Mar 2026 02:48:49 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6227mGm1070526
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 16:48:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/52UK39RxJY5TDMCAjODP8aWlDQGfP/SXUC3Iqm+4qw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772437704; v=1;
 b=div63DEgopaq25q97qxJAR5SSD3pgtFSZHqle+ECptrcedUBCO+vUQdW6Wyq1M1C
 ovmDsg/6XwbCXW5EI3K9G5giTA/bokQNIJ2YZ5EDSYDTzOuh27VpQvL3QbKnESa0
 zYyw042nUIOx4u+dbrzeHQVPNZYiBYxXWpDCNK1xgGMrJyErU74YFl0mdkFsIYvf
 p0+qjmCt/CBLOYAoKvo2eS4mv26ZZD4IlZ4J4NkDDNJQ0cVwS9XIggmgixu/Oi/9
 BfHQaqD9nwJUraDZAXVHb79iCOVbN3h1OsXw9GyhGcDY20aLCk5YXR5xZJae3pJZ
 o7rcrH7cStT9vkPhedsAwA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/4] Fix use-after-free and make format overflow more
 difficult
Date: Mon, 02 Mar 2026 16:48:07 +0900
Message-Id: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALdApWkC/13OwQ7CIAyA4VdZOAspbEPZyfcwOzAoWs2Gwlxcj
 O8u6s3j3zRf+2QZE2FmXfVkCRfKFKcSalMxd7LTETn50kyB0iBVy6dlRD40WksE24BBVlavCQM
 9vsyhL32iPMe0ftVFfqZ/wCI5cNDtztUyWI9mn/JROBIk7nyOlzUK68T5yvrXj094u5fn5t8NN
 tiM3MVxpLmrbEDd1nqrvdM++MYEqA2o2oRgYFABoFVODbuCvd66lNeQ8QAAAA==
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
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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
Changes in v2:
- Rebased.
- Changed to use g_strdup_printf() in patch
  "contrib/elf2dmp: Grow PDB URL buffer".
- Link to v1: https://lore.kernel.org/qemu-devel/20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (4):
      contrib/elf2dmp: Grow PDB URL buffer
      vfio/pci: Grow buffer in vfio_pci_host_match()
      tests: Grow buffers for double string
      meson: Add -Wformat-overflow=2

 meson.build                              |  1 +
 contrib/elf2dmp/main.c                   | 32 +++++++++++++++-----------------
 hw/vfio/pci.c                            |  2 +-
 tests/unit/test-qobject-input-visitor.c  |  2 +-
 tests/unit/test-qobject-output-visitor.c |  2 +-
 5 files changed, 19 insertions(+), 20 deletions(-)
---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20260125-nvme-b4661e0a409e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


