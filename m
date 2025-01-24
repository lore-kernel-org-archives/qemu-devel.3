Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528FDC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKTs-00036u-QX; Fri, 24 Jan 2025 09:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTX-00030W-RB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tbKTW-0001Hb-C9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0SzSFoyDqpBA5zH/ujGJF6Q/peO6Nc+RR+6eaIICxg4=;
 b=GtB3yrX7gfZsg88yAai2bhvskIoBraA19mESheM6DCgEVYFEIWhLulnX0VXW4oht04hjw4
 llf0+TLq0mem1hFbSz6yUmMpsC7bI9+U3ede7DP4yvS0HkbVyQWuFV6YfQrX5+PkRMx8Bd
 UB5d9X8GwTpyFqsaeO67TlxOYK2jvR8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-_D4ZAJCOO2idUUvnSowYfg-1; Fri,
 24 Jan 2025 09:15:40 -0500
X-MC-Unique: _D4ZAJCOO2idUUvnSowYfg-1
X-Mimecast-MFC-AGG-ID: _D4ZAJCOO2idUUvnSowYfg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E14A1955DD4; Fri, 24 Jan 2025 14:15:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66B0B19560A7; Fri, 24 Jan 2025 14:15:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/5] Convert the MIPS replay tests to the functional framework
Date: Fri, 24 Jan 2025 15:15:24 +0100
Message-ID: <20250124141529.1626877-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

tests/avocado/replay_kernel.py is a rather big file with a lot of
Avocado-based tests in it. But in the long run, we rather want to
get away from Avocado, so we eventually have to convert these tests
to the functional framework. For this, we have to separate the tests
by target architecture, since the functional framework cannot detect
this on the fly like Avocado (which e.g. looks at the tag annotations 
in the comments). Let's start the convertion by handling the
MIPS-related tests first (the other replay_kernel tests will follow
later).

Thomas Huth (5):
  tests/functional: Add a decorator for skipping long running tests
  tests/functional: Add the ReplayKernelBase class
  tests/functional/test_mipsel_malta: Convert the mipsel replay tests
  tests/functional/test_mips64el_malta: Convert the mips64el replay
    tests
  tests/functional/test_mips_malta: Convert the mips big endian replay
    tests

 docs/devel/testing/functional.rst        |   8 ++
 tests/avocado/replay_kernel.py           | 165 -----------------------
 tests/functional/meson.build             |   1 +
 tests/functional/qemu_test/__init__.py   |   2 +-
 tests/functional/qemu_test/decorators.py |  14 ++
 tests/functional/replay_kernel.py        |  84 ++++++++++++
 tests/functional/test_arm_quanta_gsj.py  |   5 +-
 tests/functional/test_mips64el_malta.py  |  26 +++-
 tests/functional/test_mips_malta.py      |  29 +++-
 tests/functional/test_mipsel_malta.py    |  30 ++++-
 10 files changed, 189 insertions(+), 175 deletions(-)
 create mode 100644 tests/functional/replay_kernel.py

-- 
2.48.1


