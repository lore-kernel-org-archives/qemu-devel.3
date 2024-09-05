Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69A1CE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHwN-0000pM-B7; Thu, 05 Sep 2024 15:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwM-0000op-8R
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwK-0000Lf-Ra
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cHiEjsU83nCN9jehpYJm3oJKkuwgnOXvk0hSomgHYK0=;
 b=KhNGx4SrNK6I/49FWkEiJP8XgODk2RDC6Bv9hWJrXWtNig2eQBmF1Fr4ZQUkHW0c0XfhKm
 A58ME66EdvewpBj4VLNz13/grfIta+4DiT9NzlkwU6CuFbnFonZ/aQfED0DIzW21PdAFJg
 dKPC4goBXKy6i9tVtOKip5z6ba9cnJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-ONYaUZclNi2XM4SbHXZHSQ-1; Thu,
 05 Sep 2024 15:14:40 -0400
X-MC-Unique: ONYaUZclNi2XM4SbHXZHSQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5B919560BD; Thu,  5 Sep 2024 19:14:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CC671956048; Thu,  5 Sep 2024 19:14:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] Allow check-qtest with "--without-default-devices"
Date: Thu,  5 Sep 2024 21:14:26 +0200
Message-ID: <20240905191434.694440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With these fixes in place the qtests now work when QEMU has been
configured with "--without-default-devices". The final patch enables
most targets in the related test in the CI.

The riscv patch is necessary for fixing a build failure that occurs
when compiling this target without the default devices.

Thomas Huth (8):
  tests/qtest/migration: Add a check for the availability of the "pc"
    machine
  tests/qtest/cdrom-test: Improve the machine detection in the cdrom
    test
  tests/qtest/boot-order-test: Make the machine name mandatory in this
    test
  tests/qtest/hd-geo-test: Check for availability of "pc" machine before
    using it
  tests/qtest/meson.build: Add more CONFIG switches checks for the x86
    tests
  tests/qtest: Disable numa-test if the default machine is not available
  Revert "target/riscv: Restrict semihosting to TCG"
  .gitlab-ci.d/buildtest: Build most targets in the
    build-without-defaults job

 tests/qtest/boot-order-test.c |  4 +-
 tests/qtest/cdrom-test.c      | 77 +++++++++++++++++++----------------
 tests/qtest/hd-geo-test.c     | 71 +++++++++++++++++---------------
 tests/qtest/migration-test.c  |  6 ++-
 .gitlab-ci.d/buildtest.yml    |  9 +---
 target/riscv/Kconfig          |  4 +-
 tests/qtest/meson.build       | 31 +++++++-------
 7 files changed, 106 insertions(+), 96 deletions(-)

-- 
2.46.0


