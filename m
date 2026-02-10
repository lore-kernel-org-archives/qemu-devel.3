Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB853EB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWd-00014A-4g; Tue, 10 Feb 2026 11:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0000iw-5F
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:34 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWS-0006yN-1G
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740602; x=1771345402; i=lukasstraub2@web.de;
 bh=FEz7RQFPlqqP6SwrmfiQ9xbkkyi39eHDt7fa5v3cXcU=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=A8Jo1RC7ROIPZ/1I4wGQRDLuHrVzjFIqaMMRvbEUc/BcCM+06VWCIlMLi4dNVxqa
 cqEdT090ZjfB33VPZhHwM0WgrdG/1dBCHUTePnthGwB11y94drk63p8WRozudM4Vm
 +Tc1IpKHeKQvuQoeuyepMQnjCz+shugCcWAk1ts439ZtWlBvN13z+dv39m7M33+m1
 6b7J2eLBwkjt4PBMfYflqh6nlH72Leb7SUfrJWSG/Sr+b6cYTaIy1zIRfcmB/mepC
 vg6xcz8Zxda0ZTw6ofqKFOB3u2Ay0WVbGNYoiQwHl1LIeMQ+4WkdW+O/woXZo3KWq
 TNfe2Fk14QicpcQaNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1vqwz01HS0-0016hH; Tue, 10
 Feb 2026 17:23:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v8 00/17] migration: Add COLO multifd support and COLO
 migration unit test
Date: Tue, 10 Feb 2026 17:22:58 +0100
Message-Id: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAGJbi2kC/4XQS07DMBAG4KtUXmPkR+xxuuIeCEV+jKmlNkFxG
 kBV7o5dCUgWgeXv0Xwz4xvJOCbM5Hi4kRHnlNPQl2AeDsSfbP+KNIWSiWBCcSEZ9cN56K59mro
 J89RdrucpxUCNi8oEjy40mpRmZzNSN9ren2r7xeYJx1p4GzGmj/vE55eSTylPw/h5X2Dm9fXfW
 TOnjMYWZOM8NB740zu6x4CkerP4NjTjHHYNUQzrlOAAEK3aGnJlCLVryGpgK7T3waDFjdGsjD9
 uaYoBnCvrdGQIsDHUryGY3DVUMRQoZhxI00a9MfTa0LuGLoYof9GGYLlsw8aAlcH3b4FqSBeki
 FIbYX6MZVm+AObOQz9qAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4024; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=YatGqmQ+VfWsrZOZzgKme31xJYd252TRHoU8ImmvpqA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1tk26Dz9ZNMlmY5kXaR2fr2X/mlAhOGSTiVL
 +GX4O63ideJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbZAAKCRA1qwsonF2y
 WKGnEAClQ76vuBBctntxcYAxAc7PB4Kvs/2E2DheSUoqmeCC0rX6LTJjQ9x+1EJaaT3T7s0PRlH
 ce47v/jeiqaeQB0AhjEA+HGdmblOwRNW7dNVRgsgQlRjBLyO6oFB2zwjW4/uhSUUR7m2WxAPehL
 nhtvM4fDTLieDi6mn5pReZCpKymRD4+yQJG555mu6Jv95/w6EpegHFAMjNLnZ4umYR4TO9X1BFV
 95gVTdpT9j/cni9AxdyjUwwh2BBw0xjeN4/G0iuS/q/m4Ewsp+ACTyKKIPlHvfoWIHScwoIWgnV
 qsbrDOUf7wWb6tJ5izz39Z/kOZFtlBZ3fkVBHC3RFnLQ6kpMvlwa+y/saVsQUpCMG4ahdllI+i/
 5YXwAxPPg6AuAZc96HU6jnfbp13GRuoYanEK7HZpZAKDlm6rHL6d3V7MPNbzqqbWnav/9bK++Qf
 K1GCXM1FqvermZjbO4dp8USIqMtii0PYPGCLq6wCek3jw/Aqhy7Gv4Qd9Nh2WghY2U4VhpRof2t
 6qQYNG5noU5nhdirolJGIhaq1hiStQiUiHz5BoukhMAk02Vc1OWIGqpE2xHMn7BOkpofJ1CgaqX
 nCXrelAJ1hzoV3OU5N7dYEJCLSNQh9XT8wtCAPi3LpgrUjTKWaDAyWO/24d3LauMdK/otqTaLsP
 HQVPCvLpL0bHavg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:bgRlgQDAnGi3KHXBlrzIsmFfF2NFAVmbUqax6DOoyuibYaMggK6
 mcXmm8jwVO3jg4N9jcIZvK/LYh7A74AhtMY+fQ4Jfv/dWncwteHWh2R3gApxQeI7A/Xdng2
 BbNbrMB1/LQ9wWV9/qCkxiPLT6ARutAWb1+IuO++UcjJiZKCE+1beE5FcordPrDAM80Z43d
 h/FltLWDpjKA63ylyu6QA==
UI-OutboundReport: notjunk:1;M01:P0:Cdgg9Di8QMo=;74oc4r+nKxK8oW0FeO78wFrvLjR
 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
 cDmfmr1g=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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
Lukas Straub (17):
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
 migration/savevm.c                 |  37 +---
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 720 insertions(+), 436 deletions(-)
=2D--
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


