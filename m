Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0EE6FE43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdLV-0006uP-Vw; Fri, 06 Sep 2024 14:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLU-0006tq-7L
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smdLP-00052G-Da
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725645960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i7M+QsQ6lDbDSxW/vGEgz6c8wWso4vRl2Lp4N8PUlDQ=;
 b=DrWuog2NUGB2fQR7s7QbuIcaaQ+8GtiKtppsFFXHR96t3s0gljjoLaKVid3vXNuLxM/pG7
 ybxbLmGurRLh+AYQKIP6mInT+iLYeskopdDeCkOrJDC3JtveomtfV0fL9iCacGkBjvJLK1
 Yw0iEDlyQ7DJwgxZNQUU1XtPWYY+FeE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-9NpXajQTOIGa1l3ZbJ1fRg-1; Fri,
 06 Sep 2024 14:05:56 -0400
X-MC-Unique: 9NpXajQTOIGa1l3ZbJ1fRg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9BD31953948; Fri,  6 Sep 2024 18:05:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.70])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F26C519560AF; Fri,  6 Sep 2024 18:05:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH 00/14] Convert Avocado tests based on LinuxKernelTest class
Date: Fri,  6 Sep 2024 20:05:35 +0200
Message-ID: <20240906180549.792832-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Here's my suggestion how to convert the Avocado tests from
tests/avocado/boot_linux_console.py to the new functional framework:
Provide a LinuxKernelTest class in tests/functional/qemu_test/
so that the tests can be converted without too much modifications
(we just have to put them into separate files now, since each
file is run with a different qemu-system-target binary now).

Philippe Mathieu-Daudé (9):
  tests/functional: Convert mips64el Fuloong2e avocado test (2/2)
  tests/functional: Convert mips64el I6400 Malta avocado tests
  tests/functional: Convert mips64el 5KEc Malta avocado tests
  tests/functional: Convert mips32el Malta YAMON avocado test
  tests/functional: Convert nanomips Malta avocado tests
  tests/functional: Convert mips32eb 4Kc Malta avocado tests
  tests/functional: Convert ARM Raspi2 avocado tests
  tests/functional: Convert Aarch64 Raspi3 avocado tests
  tests/functional: Convert Aarch64 Raspi4 avocado tests

Thomas Huth (5):
  tests/functional: Add the LinuxKernelTest for testing the Linux boot
    process
  tests/functional: Convert the m68k Q800 Avocado test into a functional
    test
  tests/functional: Convert the Alpha Clipper Avocado test
  tests/functional: Convert the m68k MCF5208EVB Avocado test
  tests/functional: Convert the or1k-sim Avocado test

 MAINTAINERS                                 |   8 +-
 tests/avocado/boot_linux_console.py         | 483 --------------------
 tests/avocado/machine_mips_malta.py         | 162 -------
 tests/functional/meson.build                |  24 +-
 tests/functional/qemu_test/__init__.py      |   1 +
 tests/functional/qemu_test/linuxkernel.py   |  41 ++
 tests/functional/test_aarch64_raspi3.py     |  41 ++
 tests/functional/test_aarch64_raspi4.py     |  99 ++++
 tests/functional/test_alpha_clipper.py      |  38 ++
 tests/functional/test_arm_raspi2.py         |  95 ++++
 tests/functional/test_m68k_mcf5208evb.py    |  29 ++
 tests/functional/test_m68k_q800.py          |  37 ++
 tests/functional/test_mips64el_fuloong2e.py |  25 +-
 tests/functional/test_mips64el_malta.py     | 186 ++++++++
 tests/functional/test_mips_malta.py         |  81 ++++
 tests/functional/test_mipsel_malta.py       |  96 ++++
 tests/functional/test_or1k_sim.py           |  29 ++
 17 files changed, 825 insertions(+), 650 deletions(-)
 delete mode 100644 tests/avocado/machine_mips_malta.py
 create mode 100644 tests/functional/qemu_test/linuxkernel.py
 create mode 100755 tests/functional/test_aarch64_raspi3.py
 create mode 100755 tests/functional/test_aarch64_raspi4.py
 create mode 100755 tests/functional/test_alpha_clipper.py
 create mode 100755 tests/functional/test_arm_raspi2.py
 create mode 100755 tests/functional/test_m68k_mcf5208evb.py
 create mode 100755 tests/functional/test_m68k_q800.py
 create mode 100755 tests/functional/test_mips64el_malta.py
 create mode 100755 tests/functional/test_mips_malta.py
 create mode 100755 tests/functional/test_mipsel_malta.py
 create mode 100755 tests/functional/test_or1k_sim.py

-- 
2.46.0


