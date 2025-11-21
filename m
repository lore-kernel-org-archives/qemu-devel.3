Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCADCFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNb0-0005cv-Ra; Fri, 21 Nov 2025 04:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNax-0005cV-UZ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNaw-0004E7-71
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763717900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RTV/2GasZwK+V3a4O7pDbu+1ZIgmtGsM0tn08ahWq5g=;
 b=SZIow2kE9PiGkyNGzNqfuVhIMw4n9lvGNypfXAKshH2HzoxNfeTUVmeCKpADdyrmXRISXH
 9LS3nBNcYQcI/J0EzllXbpbrcS0oIrzM+J3+ZE6z0QKwmUxhOubjJhcWUfaA5q7zrJp9Nk
 HEh/IsmaRuGOvI9xERb2JaAQqH+b/9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-En8vXxWBMQq4a1ss4j3QiA-1; Fri,
 21 Nov 2025 04:38:16 -0500
X-MC-Unique: En8vXxWBMQq4a1ss4j3QiA-1
X-Mimecast-MFC-AGG-ID: En8vXxWBMQq4a1ss4j3QiA_1763717895
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B57419560BE; Fri, 21 Nov 2025 09:38:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 911A530044DB; Fri, 21 Nov 2025 09:38:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/10] Fixes for QEMU v10.2rc2
Date: Fri, 21 Nov 2025 10:38:02 +0100
Message-ID: <20251121093812.280911-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Richard!

The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-21

for you to fetch changes up to 88175cff49dedd709b7a01e0e5e1bdcad69e0c8d:

  MAINTAINERS: s390 maintainer updates (2025-11-21 08:34:53 +0100)

----------------------------------------------------------------
* Fix a crash that occurs when passing through virtio devices to nested guest
* Update s390x MAINTAINERS
* Fix various pylint warnings in functional tests

----------------------------------------------------------------
David Hildenbrand (Red Hat) (1):
      MAINTAINERS: s390 maintainer updates

Thomas Huth (9):
      hw/s390x: Fix a possible crash with passed-through virtio devices
      tests/functional/arm/test_aspeed_ast2600_buildroot: Fix pylint warnings
      tests/functional/x86_64/test_virtio_gpu: Fix various issues reported by pylint
      tests/functional/x86_64/test_reverse_debug: Silence pylint warning
      tests/functional/x86_64/test_memlock: Silence pylint warnings
      tests/functional/ppc/test_amiga: Fix issues reported by pylint and flake8
      tests/functional/ppc/test_ppe42: Fix style issues reported by pylint
      tests/functional/aarch64/test_reverse_debug: Fix issues reported by pylint
      tests/functional/aarch64/test_rme_sbsaref: Silence issues reported by pylint

 MAINTAINERS                                        |  9 ++--
 hw/s390x/s390-hypercall.c                          | 14 ++++++
 tests/functional/aarch64/test_reverse_debug.py     |  4 +-
 tests/functional/aarch64/test_rme_sbsaref.py       |  3 +-
 .../arm/test_aspeed_ast2600_buildroot.py           | 21 ++++----
 tests/functional/ppc/test_amiga.py                 |  6 +--
 tests/functional/ppc/test_ppe42.py                 | 14 +++---
 tests/functional/x86_64/test_memlock.py            |  6 ++-
 tests/functional/x86_64/test_reverse_debug.py      |  2 +-
 tests/functional/x86_64/test_virtio_gpu.py         | 56 +++++++++++-----------
 10 files changed, 76 insertions(+), 59 deletions(-)


