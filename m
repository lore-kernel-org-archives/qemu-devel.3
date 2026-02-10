Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20848EA811F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpohk-0005E5-8d; Tue, 10 Feb 2026 09:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohV-00056U-CK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:50 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohT-0005kQ-Ks
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733599; x=1771338399; i=lukasstraub2@web.de;
 bh=0Ii1nYRVPhAxmQKw8S0oqCL83AIlE4UdfvltY2uOh4c=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=xA8+i0WnHBtTaFQWNBB0prHa2GWjkQ4Wr2Otgj63x7h3bZ7uNI6L3CVpQ7gBKj2m
 z0fX96+KvxZGNJt51a1H70L7x0C+rE5uFWxRvRqR8WZyiWTzCxMLlxWNfsUJzQjfC
 wyKTCy/cio7jNsK3vg1Z3Ck2MvXb77kIcY6GFThyHXqaD728oJ8hgUZD0kdfnIvOD
 js7RtaGVJivuOPf3QippmZlsAGa7astfC2of8pgw7/dOCioSVxhTjBHupFAWtrFqU
 mZPpg5EcPP5d09EUvLZ82aijVsWK6B41BOWQHflI5uR553dBYvKxh3c5poCn/xGAp
 ajFQvS8condBP8Ue/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SPD-1vfDEm0Klz-00reK1; Tue, 10
 Feb 2026 15:26:39 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v7 00/18] migration: Add COLO multifd support and COLO
 migration unit test
Date: Tue, 10 Feb 2026 15:26:12 +0100
Message-Id: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAARAi2kC/4XQS07DMBAG4KtUXmPkR+xJuuIeCEV+jKmlNkG2G
 0BV7o5TCUgWgeXv0Xwz4xvJmCJmcjzcSMIp5jgONcDDgbiTGV6RRl8zEUwoLiSjbjyP/XWIpS+
 YS3+5nksMnrY2qNY7tL7RpDZbk5HaZAZ3WtovJhdMS+EtYYgf94nPLzWfYi5j+rwvMPHl9d9ZE
 6eMhg5kYx00DvjTO9pHj2TxJvFtaMY57BqiGsYqwQEgGLU15MoQateQi4Gd0M75Fg1ujGZl/HF
 LUw3gXBmrA0OAjaF+DcHkrqGqoUCx1oJsu6A3hl4betfQ1RD1LzrvDZed/zHmef4CkWlm/CYCA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=REz/NnsnWIpRIHTwNvkBz+xU2ZWS7PGVGTilDiDERbA=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0ANZL45IYI1rTBXffA40XiN9LQI4+8ymKWDP
 572xESOLMeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtADQAKCRA1qwsonF2y
 WA1uEACf290VV8C4p2hTYH3I+qX05O6Hji3+ppwKD2WGiCd3WRCYr0ofnKhc3/Gd0X2kipGu5Vh
 mnWwcKZNcrTuFOBo0NaXyFxeMxe+8Aj2SOenKPVxAn0wjMWSkk1SMB4UFwF9KGd+xjro/rMQfp5
 Tjw98SwYoFz10awWhqo6L2kawwK1OFzKh64kYku6IemJpP3GXg9fWo7KgIGt/43F/iZn1U6I0Kn
 sDshWpFDQ5Ma97eGWVBsyrrnrrLNRjv6UrJJdmQbG8f2pEa6PZZ/2+wk0zOEii2Ai3DAvPaPMEW
 fQUAds+83U85/mN2MnbhQ+0XyRzknbCG/ef8TsSbfRw5CxTAxUYW3hYKaNQOWh0dqsXVQAdhcBA
 3KSMBrDvK/fjo8J9y9H3vewjS6RG/ifWdOEng3gsdpa7zBSNgoDOpOG7r6iqkfgWPkRUXMOz+0+
 9bDOkBmsn8ssCirwG97KS2140IpI++tmsHUY2bZGQG4qghl0IQn21wk45aml7cJJvJMEw+icS2h
 /BMW2fbklt328dW/NbwMsjvia4nXo35CFuGSJ4ka/QCwNI+MW/kZj+8jWN1/y4Bc4h/Bdl9+hMO
 tbtmZN40U3iaIr+ulE0H90REl+KFWxUuBI/ALVxpaByep9Il6+1WnLobG57MLymXNa2XhOBvQVI
 MvVeFAQU9RpY8DQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ICuFh81KDBK0NaulbRgSWip30B7Cx+e9dtg0iZn+IXm2e/tslVK
 2uMe0foyO+AwkX08JhAkJ3QA2okFgO1J8CWzxdkDu0AAoG9hTmcxLNciB7Vl7saUqQqXArF
 7zofPno1TsZdyXzb8b6SJNhGXq5W6PqXC7Hi1JUNWC3elUBvCMTxqxd9bbm529F6VncpvF1
 ceEfnnL3bxNFX94whgUdw==
UI-OutboundReport: notjunk:1;M01:P0:g5O9HqNVMyw=;r7m5Aak6866bxyjzowBVWMIpdEh
 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
 NwRFQ+EpCfJzp7S5LH+rogB97AkeG
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
Lukas Straub (18):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      colo: Setup ram cache in normal migration path
      colo: Replace migration_incoming_colo_enabled() with migrate_colo()
      colo: Remove ENABLE_COLO loadvm command functions
      colo: Don't send ENABLE_COLO command
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
 migration/savevm.c                 |  30 +--
 migration/savevm.h                 |   1 -
 migration/trace-events             |   1 -
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
 tests/qtest/migration/framework.h  |   5 +
 21 files changed, 716 insertions(+), 433 deletions(-)
=2D--
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


