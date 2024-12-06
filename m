Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A986E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY7e-0003vh-Dt; Fri, 06 Dec 2024 08:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7c-0003vC-2I
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY7a-00071U-8E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=45go0LrAT5n+9R8paT38cRmHgq3lUHQp/c/KxlNZdMY=;
 b=IbaybmETMsQEQexQgXs4kv0MBK2WzDsplCXGC+Qf5TKDXHKlb6hHN3Y85yjz6zUdBS7E6u
 RsvMxV/r25z6Z8YTanxvT1hQdyJ68QzP6ZVdqDYfwo2+hsmMftPEy0vIE1HTfTzDpGzMh4
 EWJj5nyLMreDPMqYhZNPDMtcBVnuQQY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-2DvmWNpxOg-4E0OBOWO0ag-1; Fri,
 06 Dec 2024 08:11:44 -0500
X-MC-Unique: 2DvmWNpxOg-4E0OBOWO0ag-1
X-Mimecast-MFC-AGG-ID: 2DvmWNpxOg-4E0OBOWO0ag
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 741481955F45; Fri,  6 Dec 2024 13:11:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.16])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 412371955F3F; Fri,  6 Dec 2024 13:11:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/7] tests/functional: Split aspeed tests 
Date: Fri,  6 Dec 2024 14:11:25 +0100
Message-ID: <20241206131132.520911-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

All functional tests of aspeed machine are run from a single test
file. Splitting the tests will improve parallelism and allow us to
set different timeouts.

The timeout values were chosen from a (single cpu) run on a raspberry
pi4 :

  func-arm-arm_aspeed_ast1030       2.52s
  func-arm-arm_aspeed_palmetto     50.54s
  func-arm-arm_aspeed_romulus      61.81s
  func-arm-arm_aspeed_rainier     127.23s
  func-arm-arm_aspeed_ast2500     378.60s
  func-arm-arm_aspeed_ast2600     559.13s

Thanks,

C.

Cédric Le Goater (7):
  tests/functional: Introduce a specific test for ast1030 SoC
  tests/functional: Introduce a specific test for palmetto-bmc machine
  tests/functional: Introduce a specific test for romulus-bmc machine
  tests/functional: Introduce a specific test for ast2500 SoC
  tests/functional: Introduce a specific test for ast2600 SoC
  tests/functional: Introduce a specific test for rainier-bmc machine
  tests/functional: Move debian boot test from avocado

 tests/avocado/boot_linux_console.py          |  26 --
 tests/functional/aspeed.py                   |  56 +++
 tests/functional/meson.build                 |  14 +-
 tests/functional/test_arm_aspeed.py          | 351 -------------------
 tests/functional/test_arm_aspeed_ast1030.py  |  81 +++++
 tests/functional/test_arm_aspeed_ast2500.py  |  59 ++++
 tests/functional/test_arm_aspeed_ast2600.py  | 143 ++++++++
 tests/functional/test_arm_aspeed_palmetto.py |  24 ++
 tests/functional/test_arm_aspeed_rainier.py  |  64 ++++
 tests/functional/test_arm_aspeed_romulus.py  |  24 ++
 10 files changed, 463 insertions(+), 379 deletions(-)
 create mode 100644 tests/functional/aspeed.py
 delete mode 100755 tests/functional/test_arm_aspeed.py
 create mode 100644 tests/functional/test_arm_aspeed_ast1030.py
 create mode 100644 tests/functional/test_arm_aspeed_ast2500.py
 create mode 100644 tests/functional/test_arm_aspeed_ast2600.py
 create mode 100644 tests/functional/test_arm_aspeed_palmetto.py
 create mode 100644 tests/functional/test_arm_aspeed_rainier.py
 create mode 100644 tests/functional/test_arm_aspeed_romulus.py

-- 
2.47.0


