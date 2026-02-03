Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892B3E8307D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSF-0007XN-Ij; Tue, 03 Feb 2026 05:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRv-00074X-3c
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:04 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDRq-00027p-RA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113747; x=1770718547; i=lukasstraub2@web.de;
 bh=tWWj0aufKxgQYakHUANPYhnwbFRV/at4wOipGDLGT8A=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=D36EgOsO6EDdgcXGRHqOCvarTnBaSyDOJIHRBOp8GtI7jcXHthg4gjiGhLQcws2J
 ZSGjhRcyiS2ihDUg2qGsNlsLOPpBTxFtYG36UwSuZv2RmkF74WPdWvlmgFHqFkLMZ
 r0TO0kmx6fJTGp0G8G4cxmDTpHfrt1G6SadnU2O3tMLqfte4YlvfPS1iMh49CNtrE
 iMqYABL/0jOjGaFtbDjt6OXBpfKaVH+PgjMDECsMn/C7kvu91jH2GNlupCRWebge/
 ryq5eG4NnseeiMMXVS/7iNHS05DCe+K8nPz/RUEv2jqG9FMVjsSB3BjCfjvX5b4Gw
 J0MCZDsUEA8RZG2mqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1w0C0p3QSP-004SeV; Tue, 03
 Feb 2026 11:15:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v5 00/16] migration: Add COLO multifd support and COLO
 migration unit test
Date: Tue, 03 Feb 2026 11:15:06 +0100
Message-Id: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAKrKgWkC/4XPzU7DMAwH8FeZciYoTpO648R7IFTlw6GRthYlW
 QFNfXeSSaDtMDj+bfln+8wypUiZPe3OLNEac1zmGvTDjrnJzG/Eo6+ZSSE1yE5wtxyW8TTHMhb
 KZTyeDiUGzwcb9OAdWa96VoetycRtMrOb2vjR5EKpNd4Thfh52fjyWvMUc1nS1+WAFVr1310rc
 MHDHjtlHSqH8PxB9tETa94qf4xeAOBdQ1bDWC0BEYPRt0Z3ZUh91+iaQXvZO+cHMnRjqCvjj19
 UNRBAG9sHQYi/xrZt33CUnnCeAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=sR7C45oshMkNJsq7HlBZV8k3wtwwL9DoGjEe7yH2zgU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcq9AhQiGx4IkAKdZTt+AB6K08FI4legGG3lT
 +lTe1t8LWiJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKvQAKCRA1qwsonF2y
 WP7uD/47++4gBnBSrbb/tRvbLVT0zVcyIhKVcWM6R632dEhloO0HrDRgmDEXXHdsIf4ShZSvjt3
 TiknR+FH1OsU32nIKVGWv2OdhOZK8mMr3qigr7iCR65InGrPKxORyMTdwqBP9yitCH9RTBfYn0L
 3HIgodYXs4HbNey+NXZ4okEfPVtDO4y8WV+UUZQGULX8162dqysj/zbSrjI+SGpDy0/T8ml2Yyh
 dekArMu+9sdz+6YIjyYe9CXQsLPJtDMeU5FpSnmX7Nr3pUteuU5EzBt/OUaHN3ondFUXfFa2RPp
 Vgyih0Ww3vAkK03AblU104L9z1PS5QsOq5ybHfbURzIHo6HKcHJ43iAV7v2kvNkrYEmiTaHFRU8
 MuchOKH/4002kVfTOSJKKzXe6isTjazINwwgOSWAfFIKxqKYBT3QgxBnbl29HKWm7uoxc2BKGxQ
 gMB3gDmp/2l3YsN8bBu+j8PTsM9l1lghOZvzbZ7m/f3YOabsCng9vExuwuWbX99vLjsRnIbronH
 S70o4YiEl4FHOmiUnOyVPMGLyAL6aSLN3DNUhJRoiDz356w63K9fSEA7u5fhl8Dda4zY2nq/Ubi
 3iksMaMGm3mmYpwhMyQF0TGV3erSsg+Mj5yD4kzswLBOiCYjvyGrYKlRFveCOnMj3u0zPMCMBbD
 dX0uUi1Rcfc7hLQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:fN6R7bNAr69LFbpZmFQENzozn46b31rAmajKnLBxG0ey70olLTm
 LEB+HBftR8b6t1084icCxizGZcYlKAWX8vAjwmITGgkotCVHejrMLr0B3Yp3IN+xWrKya28
 prXywZ25XLGKF8o0M7iyOOejlhGPSmSZTxjptj7e0hrm12cWdiIf+4PtERSuG0fKILkiLuq
 q9Ad7rIZDYTqGxeIL3R1w==
UI-OutboundReport: notjunk:1;M01:P0:nDXmlTBPQ6g=;M8UWzrSNCnbSj5+WTxGBlgRhW43
 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
 Kx9B1d2Ysly5X3wb+evUP4P2gjUom
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Lukas Straub (16):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      colo: Setup ram cache in normal migration path
      colo: Replace migration_incoming_colo_enabled() with migrate_colo()
      colo: Remove ENABLE_COLO loadvm command functions
      colo: Don't send ENABLE_COLO command
      ram: Remove colo special-casing
      Move ram state receive into multifd_ram_state_recv()
      multifd: Add COLO support
      Call colo_release_ram_cache() after multifd threads terminate
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
 include/migration/colo.h           |   3 -
 migration/colo.c                   |  11 +-
 migration/meson.build              |   2 +-
 migration/migration.c              |  61 ++-----
 migration/multifd-colo.c           |  44 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  19 +-
 migration/multifd.h                |   5 +-
 migration/ram.c                    |  12 +-
 migration/savevm.c                 |  30 +--
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 206 +++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 720 insertions(+), 427 deletions(-)
=2D--
base-commit: b377abc220fc53e9cab2aac3c73fc20be6d85eea
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


