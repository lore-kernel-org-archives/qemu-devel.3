Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF57E6BF05
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 12:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlnOZ-0001ZQ-Mh; Fri, 30 Jan 2026 07:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOX-0000tp-7r
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:37 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vlnOV-0001qs-7Z
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 07:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769775273; x=1770380073; i=lukasstraub2@web.de;
 bh=+PzDer1j/6Oe5Jwm/OytqW7J1I+fjGb34nrTAKB7MaQ=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oidwZHFxNG+Zy45LkHFrlK0QkmVMc0MxsN9nx3NApu65YnZvEXdq0N1AcAuX22fC
 91gh5auWHNgsnVbeJSQcX1iyVMeZW4mCYxSsATO+zAsY6kVFmsNPhHTZAXe5pg+uS
 tDxw73ORTxnE2uOHex7/FT1k6zKfLHPp5Rhzpry4PvAkJrQ93ryFmnCsC0rIOFU9W
 lO+a71sR66NeMdxbD/YlYW32Eb9Gnbg7wYXrksUb0TustbpbEmTTHkFP1JJIuiqwZ
 HUSdrHg7YZFtIibHfyJWFaH4ikGurVBmfFxq1QbYkDA+AWHa8Gaw4lEjUFeSkoVej
 kDKG1ybn73BeimTJjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVKK-1w3sTb1NMQ-010dsg; Fri, 30
 Jan 2026 13:14:33 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v4 00/16] migration: Add COLO multifd support and COLO
 migration unit test
Date: Fri, 30 Jan 2026 13:14:08 +0100
Message-Id: <20260130-colo_unit_test_multifd-v4-0-7115ab6f0e77@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAJCgfGkC/4XOTQrCMBAF4KtI1kaatGmqK+8hUvIzsQFNJUmrU
 np3k4KiC3H5ZnjfzIQCeAsB7VYT8jDaYHuXQrVeIdUJdwJsdcqIFpQRWhZY9ee+HZyNbYQQ28t
 wjtZo3EjDGq1A6qpGqSxFACy9cKrL9YsIEXxeXD0Ye18uHo4pdzbE3j+WB0aSp39vjQQX2Gx5W
 UnFK8XJ/gZyowFlb6Qvoy4I4T8NmgwhGSWccyPYt1F+GJT9NMpswJbWSukGBLyNeZ6fePSGpFo
 BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=K9WZ7GA0GaxMHva7oK9M9QMAA9V50xdeEBErvFEbtC4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpfKCbVAdw8wMXXywkrT3TICD/Kpf9JNsOoZKSI
 dVnrXEftc2JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaXygmwAKCRA1qwsonF2y
 WK9xEACvENNSNlyiJiNLe28Lli0e0TjcAK8T1KcByRrkJZ5yI81AI54IyBM9luG7MNHJ8QxtEEp
 gXj/oa2u8FwzoejqSB2sLheEnE0Adu6OPsyvwaNxDYW9+otl9dNzvIrqlCDui0QOWJBMUWKGF0T
 m6jYFBIL9XgHL6+9ROyUeSzJbfH1cg73LFCLkKJxCVGsiOxRe9QTdahuOxXGuwR668lTq3CBXr7
 sIlbPpnP4jJTuIhRT0o/GZpQ693QEe52K+CPd7LOPc1wEjKGLxSmQ/S+OQBd4ty1tj0RyvjrR9M
 qovw+ZDDF79LWJikqf4VT5HCL+Ihgzu0VMEdFl0DLT08xN5nk+IizkUHhjxD6+ov/Wzo9Vcxlz/
 G87U9WASUJU7i2lChfg+UnKFX+0k9O8UDoji9UUAozVQYxvfLk88p54Za0NjcxAR7RDGkPIvbgQ
 NiVkW0JdhorBEv2257m6XtxIfFzzJoUJQXj9Rx7lByEvy4RuhEDBifw7zfaUcvmMng+Zs1PQ8xu
 fIu0WNcrjdWksZSh1hlsLmIaxIF3T4X3zDP4nJvfeZvyc0SWIcg9AjE9xuafmZ8Ytx24VaNdvu3
 sJMlnHNUTRtlGcmuV97rsvs55/eOoJN3HveoI6+JIphx0zHzZ/R0BlDEthW5KIWPtcrGdLwLH/I
 5uJQPXJeEi1plCA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:B+4mbyE1CLBAYxD9Bilbnx2pHhldq2JYup4mHk9x5CMVhj13PcF
 2iTZ8s/9Fvuipe0b79rYiosZ7ve9XvGSrARfSfnvaIc4L4orp6bhYxAcBRT1cfThCgZCk+q
 6mJD3GImyZVG6yREkIQ69kbs4CoRWO9kshMT4ZaN/8XkctUn6mKyTsvN9/grWpIjzGekoen
 +3zRwJMPxHX59Z3HfE5kg==
UI-OutboundReport: notjunk:1;M01:P0:yMbiFzIdXYc=;73CRuzYU7V3KW29YjC6dDf05jmm
 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
 zWTR2bRc=
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
 migration/multifd-colo.c           |  50 +++++
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
 21 files changed, 726 insertions(+), 427 deletions(-)
=2D--
base-commit: 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


