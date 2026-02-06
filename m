Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC281EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3A-0004Ek-L0; Fri, 06 Feb 2026 15:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS37-0004EX-Fo
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:29 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS32-0008Ne-1b
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408201; x=1771013001; i=lukasstraub2@web.de;
 bh=ZfRYJ/sKAuzqWHOHRAUVJwQoeZy0whkASyMyJlLKtB0=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PkayoU1WWx/b5/KnEBAj1oCJY+1cOhQDdfhcMgrmtXEhY4jB30WQbVubhxLFdklG
 MwLihW5PTn7IwCWzoWsqjdJASrtTNrVecD6yRE1186enB9SwuV3osRpUYDD6nqyC6
 tMFrFNVDhhtMgArHr4nvxdETe0BL9H71s0erIEl5xRdFJV22wnx3Lax3Cu+XRMEtK
 YZtQkbOmAN7Rte/IFO8eFDy34WRCnN/9AWexuixJMc+Sxe7PJtFXQOM+WN4cO9wty
 +PzwQqbCgyPj15dQvV0FGmUtGjpdSLSJWPsSMc0YHmvPK67fdsuVbaIcpm7tpCa8T
 2eCDuEJ8MvtpqIi3qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1vfkvx10am-0136qA; Fri, 06
 Feb 2026 21:03:21 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v6 00/18] migration: Add COLO multifd support and COLO
 migration unit test
Date: Fri, 06 Feb 2026 21:02:58 +0100
Message-Id: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAPNIhmkC/4XP207DMAwG4FeZck1QDk3c7or3QKjKwaGRthYlW
 QFNfXfSScB6Ubj8bfmzfSUZU8RMjocrSTjHHKexBv1wIG4w4yvS6GsmggnFhWTUTaepv4yx9AV
 z6c+XU4nB09YG1XqH1jea1GFrMlKbzOiGdfxscsG0Nt4Shvhx2/j8UvMQc5nS5+2Ama/Vf3fNn
 DIaOpCNddA44E/vaB89ktWbxbehGeewa4hqGKsEB4Bg1NaQd4ZQu4ZcDeyEds63aHBjNHfGH78
 01QDOlbE6MATYGOrXEEzuGqoaChRrLci2C/rHWJblCzTDmrriAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3730; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=DKeU6DlcadWxu2FvubJJZ+hoFLcb2KkPOOXdSQjuLL0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkj6efDx6rzqHMa+TLHqhCamZXsPEMohQNPSu
 mi53Qz4J9qJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZI+gAKCRA1qwsonF2y
 WMIOD/98HhHT7hVI05gFp9N+oagPkfvtDnG4Q7XTxAjsxMdrgfPKOfpcvx+tuGEvOBwGPCbQJZO
 yCea6x2vG/GVB57PR50cQj++Y2C3JcO1ubnEDSzttFSU3qMmOGWe2f4eRZzjI9bhlbA8a3A0fnr
 BjMsU1fNh1qK7eJzRZ/i+Sd5yrXmzSdz8kcp24uzSlcxoj0lP6V0Ror2HJx3NCoBGdNYIq5kkWe
 XwfqEEFNlab39I1EEgHBvCS/I5iQDMpC19NKgHoJ8I6H3QsSSeyvTLEDdVzWOo/ukXzgAM4HGpz
 MfevsyDhFL3SMNlcudVJKxEl1Ie32rS9zoHfjT7CORuLvJOQBn33ZNDC2pkfUdcGhyDRFBLuOhU
 8/4MMr1jw9As+lnov1QOcfpCD6xNdDqRZoPbOx4+c+HjuRGFigblw8kvXhq98APz8MzX1ydnj/g
 yzAZ/XbuzrIyMPtEqNXUz7iN09ZjLPH6B/MYQQcXvR5p5raPC1iV5+PAh66QQQawfmPlX+nBI3O
 gTJWiEXTaXE/sVF9LhXZqe/4JuJuDiRgq5vRexAtLRVv7KGAmh9RmTgOokyOL6GDlvZFdi5AyZB
 evA42YQHmq6XFAP2BrmnpkKcLz5qEALn0zgJvRgvXQykbmm3Ua0xgNueEVd1rt8bIutDht8EK9o
 gzr4eJec9TDZhsA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:gCPUNKF/Qs933XKfYswvmuYZyVe6xV98N/fHE1kQ8VxfNYw6VyZ
 GtWFJ6KNbO4MiHodZOdF8OHDDQZUqSQBN6YItHkKneIipOz9Zlp/9BKRkEPA7gOzWZDWkX3
 3K6zNokl3ZlQVCklQtXHdtU28rV7gsr6e0+AMS+r/75G8qhocK+/CLCMlnMKohwCVVQQkR8
 jbGhez/TNELHv5cBb8NyA==
UI-OutboundReport: notjunk:1;M01:P0:aNAvgB4IQvk=;GzOyrgOML08LaP6/VtUo+nMG31m
 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
 qCwAuKiM=
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
Lukas Straub (18):
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
      colo: Hold the BQL while sending ram state
      colo: Do not hold the BQL while receiving ram state.
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
 migration/colo.c                   |  21 ++-
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
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 716 insertions(+), 433 deletions(-)
=2D--
base-commit: b377abc220fc53e9cab2aac3c73fc20be6d85eea
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


