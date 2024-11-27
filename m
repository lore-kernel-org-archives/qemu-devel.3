Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDAAD609B0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGE9O-00026o-Fk; Wed, 27 Nov 2024 04:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGE9M-00026D-3j; Wed, 27 Nov 2024 04:15:56 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tGE9K-0004K2-3h; Wed, 27 Nov 2024 04:15:55 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 27 Nov
 2024 17:15:43 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Nov 2024 17:15:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 00/10] Add smc qtest testcase to support AST2700
Date: Wed, 27 Nov 2024 17:15:33 +0800
Message-ID: <20241127091543.1243114-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

change from v1:
 1. Fix write incorrect data into flash in user mode.
 2. Refactor aspeed smc qtest testcases to support AST2600, AST2500 and
AST1030.
 3. Add ast2700 smc qtest testcase to support AST2700.

change from v2:
1. Introduce a new aspeed-smc-utils.c to place common testcases.
2. Fix hardcode attach flash model of spi controllers
3. Add reviewers suggestion and fix review issue.

change from v3:
1. replace the TestData type name with AspeedSMCTestData
2. add an 'aspeed_smc' prefix in the name of aspeed smc test routine functions

Jamin Lin (10):
  test/qtest/aspeed_smc-test: Move testcases to test_palmetto_bmc
    function
  test/qtest/aspeed_smc-test: Introduce a new TestData to test different
    BMC SOCs
  test/qtest/aspeed_smc-test: Support to test all CE pins
  test/qtest/aspeed_smc-test: Introducing a "page_addr" data field
  test/qtest/aspeed_smc-test: Support to test AST2500
  test/qtest/aspeed_smc-test: Support to test AST2600
  test/qtest/aspeed_smc-test: Support to test AST1030
  test/qtest/aspeed_smc-test: Support write page command with QPI mode
  test/qtest: Introduce a new aspeed-smc-utils.c to place common
    testcases
  test/qtest/ast2700-smc-test: Support to test AST2700

 tests/qtest/aspeed-smc-utils.c | 686 +++++++++++++++++++++++++++++
 tests/qtest/aspeed-smc-utils.h |  95 ++++
 tests/qtest/aspeed_smc-test.c  | 775 ++++++++-------------------------
 tests/qtest/ast2700-smc-test.c |  71 +++
 tests/qtest/meson.build        |   5 +-
 5 files changed, 1034 insertions(+), 598 deletions(-)
 create mode 100644 tests/qtest/aspeed-smc-utils.c
 create mode 100644 tests/qtest/aspeed-smc-utils.h
 create mode 100644 tests/qtest/ast2700-smc-test.c

-- 
2.34.1


