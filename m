Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABDE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNtt9-0002B9-7M; Wed, 18 Dec 2024 08:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNtt7-0002Al-Ln
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNtt5-0005GD-PF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734527690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VVObNrDBaegwwcQTvbXiX9OU+QPnEohXY6WU+AfElbw=;
 b=BOXjHnYOyb+wTWe+aGlQ97zmHgit+iRrp/VMRHjbPqqNTpMA2MnUVsCLZmyS6I1OY5Aviz
 Vr7Wm7jK7OvuA/8j+GsobIAeAGjocP7P9FzDSgAYfw4xKhuznnuuQ3KigtMrtuHatTtpgw
 R5miGKVzYyxaIuRJrHwRAC0qbvUDN/o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-HquKengCNrOZebq3gHRUxQ-1; Wed,
 18 Dec 2024 08:14:49 -0500
X-MC-Unique: HquKengCNrOZebq3gHRUxQ-1
X-Mimecast-MFC-AGG-ID: HquKengCNrOZebq3gHRUxQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91B41955EC7; Wed, 18 Dec 2024 13:14:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69A6B30044C1; Wed, 18 Dec 2024 13:14:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 0/5] tests/functional: Convert tests with find_free_ports()
Date: Wed, 18 Dec 2024 14:14:34 +0100
Message-ID: <20241218131439.255841-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Convert the vnc and migration test that use a find_free_ports()
function to look for a free port. Since the functional tests can
be run in parallel with other tests that might look for free ports,
we extract the find_free_ports() function into a helper and provide
a locking mechanism so that the tests don't race for the free ports.

v2:
- Use "-vnc ...,to=XYZ" in the "Do not use a hard-coded VNC port"
  to avoid that we have to take the lock of find_free_ports() here.
- Put the lock file into the build directory (as suggested by Daniel)
- Limit the port range to dynamic ports (see RFC 6335) and
  "randomize" the start address via the PID of the test program
  ==> This should make clashes much less likely

Thomas Huth (5):
  tests/functional: Convert the vnc test
  tests/functional/test_vnc: Remove the test_no_vnc test
  tests/functional/test_vnc: Do not use a hard-coded VNC port
  tests/functional: Extract the find_free_ports() function into a helper
    file
  tests/functional: Convert the migration avocado test

 MAINTAINERS                                   |   1 +
 tests/functional/meson.build                  |  20 +++
 tests/functional/qemu_test/ports.py           |  56 ++++++++
 .../test_migration.py}                        | 121 +++++-------------
 .../vnc.py => functional/test_vnc.py}         |  55 +++-----
 5 files changed, 127 insertions(+), 126 deletions(-)
 create mode 100644 tests/functional/qemu_test/ports.py
 rename tests/{avocado/migration.py => functional/test_migration.py} (41%)
 mode change 100644 => 100755
 rename tests/{avocado/vnc.py => functional/test_vnc.py} (74%)
 mode change 100644 => 100755

-- 
2.47.1


