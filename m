Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E76E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVVU-0001NL-0R; Fri, 06 Dec 2024 05:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJVVS-0001N3-D6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJVVP-000476-OI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733480654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/rY+57pT2P5Ng3ssKOphDLoYD1lbGvf+h7vPE6ZI6MA=;
 b=JoSyG5TQqpkDpB5g3PgTfwmNArJgNypXq5bNzbhJhCtnLK3Fq3YRZbL24Ll0ShZQr+9dLp
 fnqQCZDH7oEUQYBE6+yFKGUR5jZw6gLHet2FFOH5gNZEPr22yhrsFJ06lZVx+VT2J4tr7O
 6BS5IN8+7FX6VJcjTUJxtsI4UlCRCoE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-47Hhx6yrM_u0U1Teyn1aSQ-1; Fri,
 06 Dec 2024 05:24:08 -0500
X-MC-Unique: 47Hhx6yrM_u0U1Teyn1aSQ-1
X-Mimecast-MFC-AGG-ID: 47Hhx6yrM_u0U1Teyn1aSQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96EDD195608A; Fri,  6 Dec 2024 10:24:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE5F0300019E; Fri,  6 Dec 2024 10:24:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-10.0 0/6] Convert more boot_linux_console avocado tests
Date: Fri,  6 Dec 2024 11:23:50 +0100
Message-ID: <20241206102358.1186644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These avocado tests can be converted to the functional framework
without much tweaking, just switch them to the new Asset() handling
and update the hashsums to sha256 instead.

Thomas Huth (6):
  tests/functional: Convert the xlnx_versal_virt avocado test
  tests/functional: Convert the emcraft_sf2 avocado test
  tests/functional: Convert the smdkc210 avocado test
  tests/functional: Convert the cubieboard avocado tests
  tests/functional: Convert the quanta-gsj avocado test
  tests/functional: Convert the arm virt avocado test

 MAINTAINERS                                  |   5 +
 tests/avocado/boot_linux_console.py          | 376 -------------------
 tests/functional/meson.build                 |   8 +
 tests/functional/test_aarch64_xlnx_versal.py |  37 ++
 tests/functional/test_arm_cubieboard.py      | 150 ++++++++
 tests/functional/test_arm_emcraft_sf2.py     |  52 +++
 tests/functional/test_arm_quanta_gsj.py      |  99 +++++
 tests/functional/test_arm_smdkc210.py        |  57 +++
 tests/functional/test_arm_virt.py            |  30 ++
 9 files changed, 438 insertions(+), 376 deletions(-)
 create mode 100755 tests/functional/test_aarch64_xlnx_versal.py
 create mode 100755 tests/functional/test_arm_cubieboard.py
 create mode 100755 tests/functional/test_arm_emcraft_sf2.py
 create mode 100755 tests/functional/test_arm_quanta_gsj.py
 create mode 100755 tests/functional/test_arm_smdkc210.py
 create mode 100755 tests/functional/test_arm_virt.py

-- 
2.47.1


