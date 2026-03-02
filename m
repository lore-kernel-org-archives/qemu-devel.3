Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E6E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1gq-00054J-Mb; Mon, 02 Mar 2026 06:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gn-00053c-Lf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:53 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1gk-0005hg-Ux
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451823; x=1773056623; i=lukasstraub2@web.de;
 bh=f7/7kGH2HfMJrXAWGyVdHKWxfzdUSD7DAtVuKQIpOeY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nw4LWqBS1rtZh8rSgifE0qYtCBOVwASUVgrBVXZqfVb1wyOJUU99eqEPplewZWop
 4zpkG1VtR6SZTrpAHk55KoNbkI1dClvmg5Vr/FMd8owzZCEvoDg3jlWPpUOINH/fn
 PUMvjPlToYtIeorSw7xhBYBSJuNVFHnO40Vo/SDfKnRsqKeeptcLoAM8wEyeR2J7H
 Hp5006kECrXLBzijQPtyPtCo9MnyAJA7newSEoFTz5UKSro6LT+MsgYzlF9/Rm0CP
 AGKr9bnWktQSIDZb8I4vSncoKBTlMfTd0Q91/oGAH68H69ApE6NWWMEc/u6zquBSV
 FmonJ3ZlpcSopR3Fgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1vk9L22bcR-00rRWL; Mon, 02
 Mar 2026 12:43:43 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juan Quintela <quintela@trasno.org>
Subject: [PATCH v11 00/21] migration: Add COLO multifd support and COLO
 migration unit test
Date: Mon,  2 Mar 2026 12:43:30 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5077; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=PLaP1lo4VNvd4lsYF+GXcvDW59jiM2VQSVVUFM36KWo=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6TeAe7MmEB61JYoUYdEYTIgr7uczYhqlsOJ
 VEPu//YC9yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVukwAKCRA1qwsonF2y
 WMwmD/0UWe+OMv8GnlggjEWwYZvD5dNfRF8DKfpEbhVdP/kLpqp1UPHp7MSUpnZsDjG4Tm/dVYJ
 fti4ka0hVu/LJsYAsiO+NnIwVceqPeRM/3LW/3R9JOOWvO+drupcOFzCm02ypUbePEoSyNCrD/k
 DRFOOnezv7jyLPe6PZlTvLWzBGSBSaHjQgTIMC71lluiCAbOTz95ZN6Y/9SEX9jKs7JWk9Zbw3t
 KjF9POmQNGMfTwDeEEX4uT35xXIHab/dDAUiMWC+BiTNkWN03XNs8GDJzJ8tLGh0hVchBVLBLgF
 RFB/OslkqRP0FWAFALdYMroyyQokklBZRQDZm9SCmRO5VZa69J61A6oYHo51dQgRiXTfdi4VIQ7
 QAQ64+nJrH7x0iDzdPgkw9noh4A0RQGTXAw2OMH1TRnSeGHGXTr1x4FD0z/5CROqcF24kYLLEc6
 XxE+2TafK1HA+IWi8oIOf5OBG9ZkA4AHEsZOSXwC9f5MzA029ixPKDrdNiu4sZk5mE8LB7cQLb0
 nNTlP0JaJ27g2vUxyPZepggk35sLPSRknQUrRuigOFyFvK4f7zSchveKiErWc17qHsm1+GDDPVl
 +skrWVh0qf6xJBfdNf1ZuXuUiidd6xO8b5pALdWD1g3+DhSooj6Zju1DBCHQ7pfi83KXgfaIi1T
 6qC7OqGD/6jsHXQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:msfI9+z9j8jHAaXuHpppywlcc3POZ6ur0cGXlWx7I8s3JWGTh0z
 IG6Acsj3M2DN0iePEeMY2EfRXmES86WemHsoz+tnPEV3CTXnnLCnbkQOguRpr5CSe/9NcTD
 Kf7S4rAxbb28jV0gztiHRz38VJokpG1n/1lbtX9CPqKzMIjiUnNlY+CnjDBxOTnle0MP9BF
 WpYZuBcfiLzQO/NY40WZw==
UI-OutboundReport: notjunk:1;M01:P0:sXVAbQ/jZYM=;LsE+lVbwjwjsLpIF/1cI7z7JsrA
 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
 +VYuvmTHnskppwZ7y8qkGq3PV9UO6
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Screw b4, I'm back to git send-email again. Also screw my email provider b=
lack-box.

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


