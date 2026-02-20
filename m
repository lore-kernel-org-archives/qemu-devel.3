Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD8BC5AE5D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXm-0000Va-VX; Fri, 20 Feb 2026 14:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXf-0000Ty-DV
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:59 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXd-0001Rf-7r
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617107; x=1772221907; i=lukasstraub2@web.de;
 bh=gHlwj9WCh6osXkhuLUTP3vFvtpWY9qk1yXFSr1/f3ZA=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fJe53Ya0lDrTj7vllktQqbhtH8Q1OnYZv7MDBq5G0wKt+bXJb0mvM7HWwOKjzQ3a
 ixTO4WGJNo7cnED356t5M2K25YTFU3w7IyTKEvyQgLCn5YgWJAyScpaNljscwZvUx
 /YbDRQe3G+7HAa/BKqXZ3wWAc7339HVuhdkM2IgA+wf42BOeoi5+hU2C7iMjGoAym
 JFUrI3nFA+PEpIYDbFgPYbrKVnrijzBTxSdAtGQ7poIprwohjxORn1pQ5I9Io43qt
 5WPAVmI5R957CxmycIm6GpgdgyrmRUeafyQZivjeCKTGLxCYWw3noidzPrK+cMGDA
 aJaQjzylWfb6DmgTtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB3y-1w1jUC0kQg-009ImM; Fri, 20
 Feb 2026 20:51:46 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v10 00/19] migration: Add COLO multifd support and COLO
 migration unit test
Date: Fri, 20 Feb 2026 20:51:22 +0100
Message-Id: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIADu7mGkC/43QS07DMBAG4KtUXhPkR+yxu+IeCFV+jKmlNkFxG
 kBV745dCREvAixnrPnG819JxilhJvvdlUy4pJzGoRSMPuyIP9rhFbsUSoNwyiXjgnZ+PI2Hy5D
 mw4x5PpwvpznF0GkXpQ4eXegVKcPOZuzcZAd/rONnm2ec6sPbhDF93Fc+v5T6mPI8Tp/3Hyysd
 v/ctbCOdtGA6J2H3gN7ekf3GJBUb+HfhqKMwabBi2Gd5AwAopWtIVYGl5uGqAYarrwPGi02Rr8
 yfrmlLwYwJq1TkSJAY8gfg1OxachiSJBUOxDaRNUYam2oTUMVg5csTAiWCRMaA1YG274FqiFcE
 DwKpbluDP0/Q9c8okEZIVDNXWOYtaE3DVOMoIMLjnqrVnncbrcvLSmym/MCAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=r0/K46PhXmdgdleLJ5ajF0h/sdkpUTA3qdOEPM1KxAU=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtEHixuO9sdiWSbOCNcimvfIY1IJmPE0jW7V
 7BLoSfwovmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7RAAKCRA1qwsonF2y
 WAHAD/93dA19cytm/IbQtfKVXiTJyAgzh699cSKr1UxXWIkzsg+FEvbHwMhAsNDLWRlLzGyG//U
 czE9MiZOLb/RL3Rw8WBEn4YLcf+Rp9SGSJjaSKf50RWntsrlmAGxOLDyCr8PqnCLbW5LiULcjFO
 GDXP08JO1oQ8Ud7g2b4rEe5eoj1+HUqIzCYm9mxsQbewW8KlNd9c95F+UyEYD+6P6u2Gm8olcdH
 jToCgS6LXNxSmx/BqX/ctex/yKossSW+gwfN2YJRUZQXHxNyDUEvwiFsCawoY8ISMa6J2cP2Taa
 BLn1Zvb7vjsK5SEbrZkYGnemSdwscAGoMbKW/gFk5oR5D0OaJ09xpDXcjxtqB/8kNcgaa74SGme
 2yGfabi0BvHF/v59iJZFlxOKzxeMBOPXXatYBWfNzCqJjTMvHgUCF8yNy9jtG/LMEkw7IjBtVg7
 I3r8UI9OQ8M4R9AG1nlMPy4hjHXECoXLqUzguVSUi1Xp6by4EO+Bb6eIkxuGK4Ma/rKFnM2gN2Z
 xezzb9YdqxYncPwPBkLk/SDNOB8weFTykPZ5leXoLarLLl0emJKaEdlyoEqzXGLqLlXPBzMrg8R
 6hF3gF7YzosO6+RdJEkFshxoM8wtulaQnc8ZxXCr5T6wWp+VPM/UyeIU5r07qTJk3hASMQWY00a
 ymeW/vg29lIe8eg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:uUWGdjwdpfh4wV/NmcIfdgQK5Av4oV3ISqnZguxyFZhSYXkan/W
 bhMOcE3niSM1hDSc3BpCdyQPnUHslOekkS1DYmn7pCW4MMU1KevKMIpP2vQiTBJMGaOoNyP
 ourj3BHGgbVuQSuC9aS98dYVa6YTzV0nzzMlGXSohQJHeC4JSeNdXSTx0xxa+ITTWEqbMIr
 NqlraCvlEbR/rrNSzrIkQ==
UI-OutboundReport: notjunk:1;M01:P0:bM1OSiypZzc=;6DXBDkn8NQTL4itNgj/eqMe40M6
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
      migration: Always open s->rp_state.from_dst_file on the source

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++++++=
+++++
 include/migration/colo.h           |   3 -
 migration/colo.c                   |  50 ++---
 migration/meson.build              |   2 +-
 migration/migration.c              | 138 ++++++--------
 migration/multifd-colo.c           |  44 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd-nocomp.c         |  10 +-
 migration/multifd.c                |  26 ++-
 migration/multifd.h                |   5 +-
 migration/ram.c                    |  12 +-
 migration/savevm.c                 |  37 +---
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 770 insertions(+), 499 deletions(-)
=2D--
base-commit: 07f97d5da04a9f97e273de85c76f5017d8135a6e
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


