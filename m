Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B47E63CBF
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 20:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk6ud-0006xp-9V; Sun, 25 Jan 2026 15:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6ub-0006wt-CT
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:45 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vk6uZ-0006CZ-G4
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 15:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769373641; x=1769978441; i=lukasstraub2@web.de;
 bh=xQpb7NS2AOnJhl/w72dxdH9hnJ1qoweWf+AxQ8GXNx4=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MQTNA4Tth+IexwbjLEpfwSYxPe9/qYPAVGVHXGUJokwImQK1+MSmC7rBdO4+2LjV
 Aa/iTAH+dX6UiMhWF2N8jJaMXe9hKmFM+Bkp113ztiA+sl4IB8Uvb+xjV0aonK2gO
 GHKanLy5al2lUPpSAtB+ip7riS+pI3DjkKljtXbdREso88GX2I9J7jNGjb9DjHin1
 TsMNQ/jMNd8lTw7q+MNYtINI/El55iNTnSHgaR+DjUskZ4nRjR+GddUp4C5KNjEZ1
 KZs6JIs2tF/rpYuo8kORZEkLH8ZeNQqDI05rFg9bT0H+sdOSJMpsrwRBIr3d670v1
 Oc3sZDv+giWbRBf9YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1vyRnx1znI-017ncy; Sun, 25
 Jan 2026 21:40:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v3 00/10] migration: Add COLO multifd support and COLO
 migration unit test
Date: Sun, 25 Jan 2026 21:40:05 +0100
Message-Id: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAKV/dmkC/4WOyw6CMBBFf8V0bQ0tlKIr/8MY0sdUmkAxbUEN4
 d9tSYwr4/LcyT13FhTAWwjotFuQh9kGO7oE5X6HVCfcDbDViREtKCO0LLAa+7GdnI1thBDbYeq
 jNRo30rBGK5C6qlEqSxEASy+c6nJ9ECGCz4e7B2Of2+LlmrizIY7+tT0wk5z+3ZoJLrA58rKSi
 leKk/MD5EEDyr6Zfhx1QQj/6aDJISSjhHNuBPs61nV9A6I8jEUWAQAA
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=+Be8pyBVbEBAu1/8IK3ICPs3Nh9cvQkigNOcaxX9dvE=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpdn+74No8nDpBsLUJFZWAYzB19VK1+AlWjJXVv
 FBpOYPfctuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXZ/uwAKCRA1qwsonF2y
 WIbiD/91UmAJeWU4tiyYNyVjWie5Z9BXMPS9RfE0HS1eBt//URhfe0WRym45lKqAgQH9MmMWXIp
 uWuW8gPXZFtWyl7BCk2wtRPCbv3BCVJt/S4Dc41t60E9rlm7zKgucEwDfsbvHuoMK0RfpbueXUX
 KaYz7RvlgpsD24kV0bv0hp6OX8UmqxIETAyuYxdqI/FHv8v1t+nWSg6K0IySmuznDGCrwmLgmck
 +3i87B9o4ZithVeUul+j2gdb68551bu5mQHASkXrTF2e+R44i5HPWy+NR8Cn2yzwX07vhePqp+q
 dF6jCsIEix4Qame9vw6IJm6Kuj8ldkPfCaWFHboqjPWW1CfMdOlKXBb/34PcIY+yZEi/p/Fod01
 qoKSTa5DUhPijch6qxIIp7kh+GYljHHkFwDoBoOzycyaJ7A9LoQF5zZN8rDegbERozJGxT6jhij
 K3nfl9Vlgu9WmUbilgcnxezkKE6LcyoW5RIo4o4as4AMNgec2iXAaeY17sr1USVTmsRFkNjTSzy
 nU3fEzlK0WSqGmq51Q5c8nUEvGjnzwy3llhBRbfRsLacQyce+mkb4+hj4pdyE8rURx0YepSwuom
 RgnXVe40+te0JMOcyGHl5YLPK8lkYDWAzFiN9mVSvyMi5M1UAKEJPNB6vVG8dGe4LxWJvDbvSif
 9ejD9YEh/wgzbHw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:9XQwZI0mhPI5ke3AS8MLn9RbAqT16CAKk7A8a21LOHqg7vxortA
 tJnKRTLwUjyH88Pp0eYZtO4uk4ZX2sQmgRDnXF7kwag2i2ftIknnsHsdo6mIoiN4iqqxUhx
 j4p4lX30/jjU8EP507K6NuLeVDRqYA8NFliP90pw7sQC6plh8Gc4vKnR8/EZKx7i5nOm+jZ
 plIxqLEp7RyFKpyWZVFRw==
UI-OutboundReport: notjunk:1;M01:P0:iEc11qMi7s0=;lM4xtq6haup/naWbKfOfbWgEIbC
 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
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello everyone,
This adds COLO multifd support and migration unit tests for COLO migration
and failover.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Changes in v3:
- Fix peter's review comments.
- Fix COLO with Q35 machine
- Link to v2: https://lore.kernel.org/qemu-devel/20260117-colo_unit_test_m=
ultifd-v2-0-ab521777fa51@web.de

Changes in v2:
- Fix review comments
- Hide stderr in colo migration test since the logged errors are expected
- Add benchmarking data for multifd
- Add myself as maintainer for COLO migration framework
- Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_test_m=
ultifd-v1-0-f9734bc74c71@web.de

=2D--
Lukas Straub (10):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      Move ram state receive into multifd_ram_state_recv()
      multifd: Add COLO support
      colo: Fix crash during device vmstate load
      migration-test: Add COLO migration unit test
      Convert colo main documentation to restructuredText
      qemu-colo.rst: Miscellaneous changes
      qemu-colo.rst: Add my copyright
      qemu-colo.rst: Simplify the block replication setup

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++++++=
+++++
 migration/colo.c                   |   1 +
 migration/meson.build              |   2 +-
 migration/multifd-colo.c           |  50 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  19 +-
 migration/multifd.h                |   5 +-
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 15 files changed, 687 insertions(+), 341 deletions(-)
=2D--
base-commit: fea2d7a784fc3627a8aa72875f51fe7634b04b81
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


