Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86F6E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7T-0007BQ-EV; Wed, 18 Feb 2026 16:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7J-00078j-3D
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:53 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7G-0007NI-GF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450176; x=1772054976; i=lukasstraub2@web.de;
 bh=cxSL5cNeHRNAVuPbZKWnxtxlFkfCFeEU71LM358o/Ao=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j+CyW7oTzypgfMN1AvY7izblNgBRrOKo7gFRvC7ntj4FJLlJvqGwWfyHSpap+MKW
 OPPE17TNlAo/aBAs+Olz+rLzRcDdFhRXs8F7gZKS+JHC/leKWzYYe5t2KrBCsNLWH
 maAqHVUkeurwiw1BR1onPuP7yUPwSjFjWbWkyg0A4Sj9N3o891hIeEFctwkMtIdPV
 NtjpoXfCw81h8WnWVJqH8PHd7ZSRcJ1ZhV4juK8QBBDuCTIWMVcytylkOc9gg1c0w
 B9osaPTTAFmKE53xva7c6LDIo/o+9PzoqHKOnc93B8UhDonhs87XAmH3/z0Zoxxws
 Ii1yxlUXfRKDD7QCJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1wKcJR2ezN-00R6m6; Wed, 18
 Feb 2026 22:29:36 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v9 00/19] migration: Add COLO multifd support and COLO
 migration unit test
Date: Wed, 18 Feb 2026 22:29:20 +0100
Message-Id: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIADAvlmkC/43QS07EMAwG4KuMsqYojyZOWHEPhKo8HCbSTIuaT
 gGNeneSkYB2UWD5O/Ln2FeScUyYycPhSkacU05DX4K5OxB/tP0LNimUTDjlknFBGz+chu7Sp6m
 bME/d+XKaUgyNdlHq4NGFVpHS7GzGxo2298fafrZ5wrE+vI4Y0/tt4tNzyceUp2H8uH1gZrX65
 6yZNbSJBkTrPLQe2OMbuvuApHoz/zIUZQx2DV4M6yRnABCt3BpiZXC5a4hqoOHK+6DR4sZoV8Y
 vu7TFAMakdSpSBNgY8sfgVOwashgSJNUOhDZRbQy1NtSuoYrByy1MCJYJEzYGrAy2vwtUQ7gge
 BRKc70x9P8MXe8RDcoIgWruvo1lWT4B93X2+a4CAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4349; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=RitPFCi0PaqNYoL/psswhsE9H5fm5kf6Un0FpcAmujg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli8yzCxqodgnQUWhAQISiBwJlLbIFdpRu2O09
 N0bY48by/yJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvMgAKCRA1qwsonF2y
 WGegD/0TIj8JBrQvUBFLxC9LMmtCOV/1IqbcLNS9VTVOTI9Qd1hZ1PIz57F3srWKPxlbYfbxFn0
 U5ZaNAHuFVgtHf2uWHAiOw72K5yMpi3PwJXlyg0o0h9ZeOm7iqs3RbyyR+qEUvBRC5JD0TeQPbO
 RNF9MAT8xUp/Ww8mFv+l3cG0QighA8uC2q49oLqOFf9cJNLSECa+Er9NeA9oOkZ2pcgqJwOibnA
 IkEhxBKPhWcCGgW5FPzH15Js6ZAMm1Zl54LT8TclhXujqZmWEtdulLwcyTCJh/uRsy8cowogqfN
 ZpvGcPxpPxTpj5mplegFxPSy652uKa2POhkW/pid26KNW02Cv2kL30mBLOF+ljIX0Fse3Z9CcTy
 Bnn4S1hbnUAqae9BtN08I/uDiyJ9h0YpFb+DF9RwvEV2FytWTekH74uq1yDvsjYyDP4RztjEOf3
 a/PXgjBybxma0iSLZPtW3onE4KdBNfAHzCRNmDAGJpgWZnS9uwujm0kLWP7W6ThB9Xlk7JTk40F
 qXLg/au5IupUleuYe8lMkp5TH7OK4aNmvZwWWtoD8WFhepqUKqQlMwpQh1ezCefZg4RBs4PLbWD
 AbmnNg7i+iuOJAY98LgRhoALE8i8CWCa+uK4ho6Wiz44QRooR5R4leoJPZJzMyVpSGlJKFxa/qA
 JE0FCjg1SYyLe/g==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:e/ICqNvkqNM0+GAzXdlrgd+gSegy2quO+k77NB8cOB6cPotcuhH
 hDttAlHEiqdMHBurs0eWwiO/8gP1sqT7XxoJCTHRX7iDcUkaGve8YqfGqjvbZv/GDpRQqUu
 paT2Z2yGBjoMUla2qWrTB6DDyZP4hrSNZIJaEFjdPlK5W2X2kAhnm5Z4bg4N029u8MC1gYi
 TBspCCvA7v2/rJ4t9VKpw==
UI-OutboundReport: notjunk:1;M01:P0:oSNpvxRZ5Ng=;9Q53BgoL20uJa81EkqVb128DDgA
 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
 0L7K6vTlhY++HnnknxOXpKhPJvMCH
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
This has some cleanups for and adds multifd support and migration unit tes=
ts
for COLO migration.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
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
Lukas Straub (19):
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
      colo: Fix a rare crash during shutdown

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++++++=
+++++
 include/migration/colo.h           |   3 -
 migration/colo.c                   |  44 +++--
 migration/meson.build              |   2 +-
 migration/migration.c              |  61 ++-----
 migration/multifd-colo.c           |  44 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  20 +-
 migration/multifd.h                |   5 +-
 migration/ram.c                    |  12 +-
 migration/savevm.c                 |  37 +---
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 736 insertions(+), 444 deletions(-)
=2D--
base-commit: 314f2d7fe601b8dba2a88ac4870469e9f6bb8464
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


