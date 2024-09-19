Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EED6CF3964
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srMLt-0006jL-Nq; Thu, 19 Sep 2024 14:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMLs-0006ip-VZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1srMLq-0001MF-T2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 14:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726772280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YDsPO+cW+ysC6WSGjeIy4c6qyf0bbb/gE0rcX8Pnb68=;
 b=EFMKGShPFonHBbIWWbHxyqGYqbjy3fqtssxWZk9w1MuJi1dNGqGOqvInGzMWsudLGA0fPa
 CRLbozbzbLXJ+xYQG/gLMehzOiSC/fC7pTmHGAH0aj53g0dIBgzqwwxyhsHdciRz+pOwXL
 YlVHvSsX1H4Glps7qpKkhtBoySqg3uU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-ouID22wKMdGiT3BEMYRjpg-1; Thu,
 19 Sep 2024 14:57:56 -0400
X-MC-Unique: ouID22wKMdGiT3BEMYRjpg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9158C1944CEE; Thu, 19 Sep 2024 18:57:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7316519560AA; Thu, 19 Sep 2024 18:57:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/7] tests/functional: Convert the advent calendar tests 
Date: Thu, 19 Sep 2024 20:57:40 +0200
Message-ID: <20240919185749.71222-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Convert the advent calendar avocado tests to the new functional
framework. Since most tests are doing pretty much the same
(add a "-kernel" parameter and maybe "-initrd" and "-dtb", then
launch QEMU and wait for a string on the serial console), we
first introduce a helper function to shorten this repetive task.

Thomas Huth (7):
  tests/functional/qemu_test: Add a function for launching kernels more
    easily
  tests/functional: Convert the vexpressa9 Avocado test
  tests/functional: Convert the xtensa lx60 Avocado test
  tests/functional: Convert the SPARCStation Avocado test
  tests/functional: Convert the e500 ppc64 Avocado test
  tests/functional: Convert the mac ppc Avocado tests
  tests/functional: Convert the r2d sh4 Avocado test

 MAINTAINERS                               |  7 ++
 tests/avocado/boot_linux_console.py       | 92 -----------------------
 tests/functional/meson.build              | 15 ++++
 tests/functional/qemu_test/linuxkernel.py | 12 +++
 tests/functional/test_arm_vexpress.py     | 26 +++++++
 tests/functional/test_ppc64_e500.py       | 25 ++++++
 tests/functional/test_ppc_mac.py          | 38 ++++++++++
 tests/functional/test_sh4_r2d.py          | 31 ++++++++
 tests/functional/test_sparc_sun4m.py      | 25 ++++++
 tests/functional/test_xtensa_lx60.py      | 26 +++++++
 10 files changed, 205 insertions(+), 92 deletions(-)
 create mode 100755 tests/functional/test_arm_vexpress.py
 create mode 100755 tests/functional/test_ppc64_e500.py
 create mode 100755 tests/functional/test_ppc_mac.py
 create mode 100755 tests/functional/test_sh4_r2d.py
 create mode 100755 tests/functional/test_sparc_sun4m.py
 create mode 100755 tests/functional/test_xtensa_lx60.py

-- 
2.46.0


