Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C84EC9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 14:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh70T-0007l0-Ey; Sat, 17 Jan 2026 09:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zy-0007YT-62
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:55 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vh6zw-0002n4-Cb
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 09:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768658974; x=1769263774; i=lukasstraub2@web.de;
 bh=QbaNks6hR3LAvQa2pZPGZsTkIROgwtHyNaNVA2/IG8M=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XsFT8tS5QUNQ4lZvwPcPG1FLljf94WteUeTmeNlFLkbn2f+RY1NrsR+IwQ9iruzz
 iySx2TBhZm0c1W6JzsOiFGWCEWkBg2pz4PYn0KmdUARc2HwRIn0w36c+LGZLlTxDn
 LZ8IVaTVf4AOMy00ZEcQiQIlutFTxE2VkShXjvt/sSOlmFuef6ZMhLYEtR7KxmwLt
 x3rc7JQsORv+kTwUEdO9/u6yneqKMZ8OlK/fwdXfMHEVzayKSbjVCQvyR8pvvtbot
 2MEuRCfCwMQ3hE7bJsVZo4q43Lv/5bIWT9LX99uUR2BjtYHT7T0l7FIt470eNFhE1
 O75MqZB5+iQL58YJSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.100.70]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVKK-1vy5wi0lvu-017Zty; Sat, 17
 Jan 2026 15:09:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH v2 0/8] migration: Add COLO multifd support and COLO
 migration unit test
Date: Sat, 17 Jan 2026 15:09:07 +0100
Message-Id: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAOYa2kC/4WOWw6CMBREt0L6bQ0tIOiX+zCE9HErN4HWtKVqC
 Hu3sAE/z0xOZlYSwCMEcitW4iFhQGcz8FNB1CjsEyjqzISXvGG8KqlykxsWi3GIEOIwL1NEo2k
 nTdNpBVLXF5JlKQJQ6YVV467PIkTwe/HyYPBzLD76zCOG6Pz3OJDYnv7dSoyW1FzbqpaqrVXL7
 m+QZw2k37btB290fhHSAAAA
X-Change-ID: 20251230-colo_unit_test_multifd-8bf58dcebd46
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Juan Quintela <quintela@trasno.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=zyH4uCpnz5oLahKybfRXOySD1WmdZ0n4c+spoFhJ6zY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpa5gbeWOfcOwr7GyTClop865e2MpLkrA8jlHgB
 VIHyWOILEOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaWuYGwAKCRA1qwsonF2y
 WNg7D/9Hpu/kaNwuvHb0xL1AwrC8tOLGCttY90NkDJAAyA+Nf4zQkrsMFwLIYMww8e/CDzLCs/g
 83jD9gSfOJBGsq6lujJSXGIDfdjd2TRWbUpxzwDz0r8da8KnO1tq7v0Sx7wWY51JZ7TW2B3UJpy
 5+wFeSo2ToGZK+VWIh2pZ8Foi0lrJG0KL5je8RB+XegDKgbz1Ax7PPZAHez19LotWEvb+VEsqYa
 ZfFTWHdSxXgDUOIDfo2VdRdYU0dkb8cHGgCy7/tULkJkaQMvmDtmuwGs8xZMl7Mo77lM9LGMIsy
 r4HbpDF4jKFr5nWcEX8Te+7OUbs43nVEqExPGZY3uGZaytmjbVSesMZJL4hVTYbUojlQgM9oFa7
 n0ejjgDv+P6q59SjeHbvbo8UleOnRAEgb96ZL1o+XSwfCjO8/E9Z728yCBakxaHTFNRdSrlbta5
 ZrjAhh0V0Os6/Vu07eJbbwxIOcdeDug522kbphvIV/b0Yc28RXpYOTDf4GQqUzNi37R7BL8Q4yH
 6V0+xIvnF2+9FLlvqH2athE3kRjNEYaB4ukgmR7y5Uw/KIN3Tydqj3/4BrMGfOOdXUCt5fjzY3I
 wKFPw3PyuMQR9vqJ+OMafmVmpcw0fAv/QOQsPSyJuqIBOxcvYLuQlkSEq+A5xMj6may2WpmmXgE
 0mY3HopkoevahKA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:6+xlIBVWQEzg1ABBu3xynAL/MmFddTFufWHSFRU38yp7ym8FYua
 c5WxQvPPH29SgKjPV4cDgG8n+NsMIM2A5vbwmLIpFL7pHmXZbzYnYrivHNftE30JWWA1GDe
 w4j05xDe/ZGrD3A99ZLyySobV2T038M+LFq2cXKcuTiYK3tDmLEC5XkNa3J5aZjBUIlTmYE
 6tVYWV/3syrk//a+wikJQ==
UI-OutboundReport: notjunk:1;M01:P0:HfblHXAnO8Q=;YtT2YBOHauL0PPgFVK5EYL3YZHr
 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
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
This adds COLO multifd support and migration unit tests for COLO migration
and failover.

Regards,
Lukas

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Changes in v2:
- Fix review comments
- Hide stderr in colo migration test since the logged errors are expected
- Add benchmarking data for multifd
- Add myself as maintainer for COLO migration framework
- Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_test_m=
ultifd-v1-0-f9734bc74c71@web.de

=2D--
Lukas Straub (8):
      MAINTAINERS: Add myself as maintainer for COLO migration framework
      MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
      Move ram state receive into multifd_ram_state_recv()
      multifd: Add COLO support
      migration-test: Add COLO migration unit test
      Convert colo main documentation to restructuredText
      qemu-colo.rst: Miscellaneous changes
      qemu-colo.rst: Simplify the block replication setup

 MAINTAINERS                        |   6 +-
 docs/COLO-FT.txt                   | 334 --------------------------------=
=2D-
 docs/system/index.rst              |   1 +
 docs/system/qemu-colo.rst          | 355 ++++++++++++++++++++++++++++++++=
+++++
 migration/meson.build              |   2 +-
 migration/multifd-colo.c           |  49 +++++
 migration/multifd-colo.h           |  26 +++
 migration/multifd.c                |  23 ++-
 migration/multifd.h                |   1 +
 tests/qtest/meson.build            |   7 +-
 tests/qtest/migration-test.c       |   1 +
 tests/qtest/migration/colo-tests.c | 113 ++++++++++++
 tests/qtest/migration/framework.c  |  87 ++++++++-
 tests/qtest/migration/framework.h  |  10 ++
 14 files changed, 675 insertions(+), 340 deletions(-)
=2D--
base-commit: 42a5675aa9dd718f395ca3279098051dfdbbc6e1
change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46

Best regards,
=2D-=20
Lukas Straub <lukasstraub2@web.de>


