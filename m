Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705E2E9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0He-0004w2-UO; Mon, 02 Mar 2026 05:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rw-SE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HP-00061w-V9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=r+zl0+p3LpV+Wr6A/5LQfpj3b0cZ/sqTXYBDLm7685Q=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pvsDDV8AOENK0Gt5/u0szIZBt1d+kzT5mT1/nSZep6tEbnp8LwR5P25dgEwI+Mbj
 r/85w6lk6jsD/uwgwWTGrrnVQlWmVf6ax50qWWB9/dWR4QRTgO7tUkyTvqKjjFaCv
 8iN3LVgv9te1KXwAyi0DvdOQNCjOoXvxTNV/J3aTQ2HsozwkqTVdw1JI3Vf/tnn3h
 7qHjbj22rOZp9LXtar2rOdI7c7i8jTVej+E/mUWcOzOk2trqm0xmLdBqXns61nLsr
 iSpbEHSFeRrSCdMxJxuDoun6j6nldYW6phzaqLqGnaTO2xTy0GNAlE8ttLQBr/X+X
 jIBXJgPG1WiAEk0SkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1vK4dg0e4Q-00istQ for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Date: Mon,  2 Mar 2026 11:13:11 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5037; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=CJ9NqnKPLFKru4y8Cid4pevm+FERcyb1EkQ+daaESyc=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppV/7cUWljfQpr0GPJawpJO1sh5cU9iqns77lW
 zefdyJP65CJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVf+wAKCRA1qwsonF2y
 WG8XD/9CzTXdOHZB1cQ7w3OVETvxfRyffhgHM93hNaHUcNj8hJNdsGHbIzkDq4w4ROLXodVnXSt
 04teb3Dt8er3pdoCuU6MrCmB5KTIkT0R9R1TXMhnfDTEEZGb4UqdvJY+V4wUFJL6wMjWkzlUoHx
 rPRyTCxm9iSln7IdzKAelzNfx+zI23RVug6yLk7NWOwZPbN56fjI/nNu0moghsXLSf3pAVSz2Ey
 aZtaje+vzY5K02JLpX473+DDDeKgPFkrrvbO5UM58eHrl5AuGzFmrypTN1hAthbGK3PmglpVYR9
 twHY2FIKWdCwVgm+OawJTXWnEtU0VFhSormd4Q+PAseFGA16DUt3XkulPVTftcG/6HG8lE7EXSt
 WG9P7zbGWMA85FraAeEi2QoLECrOSqCj1zg76wGaX+1+nXGgBj/1tt0J7s76dMutVq+D4an/z2l
 J3h8hdqSMuOUxpehD9mhinq8hCPb8lcFtAxuAZ9ttp0Qzh37lXYI3S1TYy+wrYZUIbmMEU0LdMB
 rT7wxGJdPOP5MUUf/vIaXxJjtk7t83L1el4RF4LAaipKkveb/Cv1CNg66km19R/CbyKFCkv2pZf
 QefmCY0m3B+39uxpATU6H2gTlwSSFBdrvn3pYFvtyZz4fy+dLA+9/Jw+icXJoAYlIpnPowkeJdO
 LZO2/4fQUcnLv4w==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WrrSkJHWcd/g+6+7Mj8hwmnzn1DYhhJa3WAK2aVmJJb9Z3zyB0H
 Q2COL3vhclOi0EsfajixpRxIh3aiDb5l7q93nrczyULxmo1AF+7X56uPOy3Wfxf53TpwcEe
 cU66JFYyxq1GFXyA357Bx12lANO4zFoNlj9JEwRVki27wQiS1INWf3dTLWpCznFeaSBLkib
 qY9OgqxIS6f4DbGEwStyg==
UI-OutboundReport: notjunk:1;M01:P0:uCLPgca0IXE=;STT5wW8IJ2x0Iou99lUFESaG0Q2
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Screw b4, I'm back to git send-email again.

Hello everyone,
This has some cleanups for and adds multifd support and migration unit tes=
ts
for COLO migration.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Changes in v11:
- Use colo with return-path capability
- Link to v10: https://lore.kernel.org/qemu-devel/20260220-colo_unit_test_=
multifd-v10-0-bfe67d422ef1@web.de

Changes in v10:
- multifd: always kick the main thread
- always open the return path socket on source
- Link to v9: https://lore.kernel.org/qemu-devel/20260218-colo_unit_test_m=
ultifd-v9-0-d8dbdb0ca6f6@web.de

Changes in v9:
- Rebase onto master
- Fix two rare bugs discovered during sresstesting the colo unit test
- Link to v8: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_m=
ultifd-v8-0-7f9e5f7d082b@web.de

Changes in v8:
- Fix peter's review comments
- Link to v7: https://lore.kernel.org/qemu-devel/20260210-colo_unit_test_m=
ultifd-v7-0-23bd32f36828@web.de

Changes in v7:
- Fix peter's review comments
- Link to v6: https://lore.kernel.org/qemu-devel/20260206-colo_unit_test_m=
ultifd-v6-0-27779dda139d@web.de

Changes in v6:
- Fix the crash when running COLO with TCG accel.
- Link to v5: https://lore.kernel.org/qemu-devel/20260203-colo_unit_test_m=
ultifd-v5-0-57508b7389f6@web.de

Changes in v5:
- Remove unused inmports from multifd-colo.c
- Mention the checkpoint overhead of reset to the Q35 fix
- Link to v4: https://lore.kernel.org/qemu-devel/20260130-colo_unit_test_m=
ultifd-v4-0-7115ab6f0e77@web.de

Changes in v4:
- Add cleanup patches to remove migration_incoming_colo_enabled() and MIG_=
CMD_ENABLE_COLO
- Add more comments to the colo unit test
- Call colo_release_ram_cache() after multifd threads terminate
- Link to v3: https://lore.kernel.org/qemu-devel/20260125-colo_unit_test_m=
ultifd-v3-0-ae926ccd8eae@web.de

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
Lukas Straub (21):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      colo: Setup ram cache in normal migration path
      colo: Replace migration_incoming_colo_enabled() with migrate_colo()
      colo: Remove ENABLE_COLO savevm command and mark it as deprecated
      ram: Remove colo special-casing
      multifd: Move ram state receive into multifd_ram_state_recv()
      multifd: Add COLO support
      Call colo_release_ram_cache() after multifd threads terminate
      colo: Fix crash during device vmstate load
      colo: Hold the BQL while sending ram state
      colo: Do not hold the BQL while receiving ram state.
      migration-test: Add COLO migration unit test
      Convert colo main documentation to restructuredText
      qemu-colo.rst: Miscellaneous changes
      qemu-colo.rst: Add my copyright
      qemu-colo.rst: Simplify the block replication setup
      multifd: Fix hang if send thread errors during sync
      colo: Use file lock in primary_vm_do_failover()
      migration: Keep s->rp_state.from_dst_file open until migration ends
      colo: Reuse the return path from migration on primary and secondary =
side

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++++++=
+++++
 include/migration/colo.h           |   3 -
 migration/colo.c                   |  59 +++---
 migration/meson.build              |   2 +-
 migration/migration.c              |  80 ++++----
 migration/multifd-colo.c           |  44 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  26 ++-
 migration/multifd.h                |   5 +-
 migration/options.c                |  10 +-
 migration/ram.c                    |  12 +-
 migration/savevm.c                 |  37 +---
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 199 ++++++++++++++++++++
 tests/qtest/migration/framework.c  |  13 ++
 tests/qtest/migration/framework.h  |   5 +
 23 files changed, 777 insertions(+), 467 deletions(-)
=2D--
base-commit: d8a9d97317d03190b34498741f98f22e2a9afe3e
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


