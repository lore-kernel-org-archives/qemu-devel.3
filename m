Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDB9E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjfb-0006Tk-IW; Wed, 04 Dec 2024 02:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfQ-0006Qi-QM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfM-0005Fq-DB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733296758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/23SJ3N6uJ9khTdyRfG9XjuzbSkzNHSY0+pMDfGEyIs=;
 b=coeFHtQgprD5wMPDGMndWp50/BrLL5POaTC9LHNRenSjmryLIIedfUhBTlQYeKLrCZsumS
 PK31U6psMYECrhHuscPRd69ApZ9Z5Y6fFP348r1yrdtw9YlrQ+0Kn8ZUdwrIhSTMQyIH2d
 iM/1fg3j5LBAneF2VGufFxRuTEj2/DA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Mg0yJevCP_ymjZ6F6pPksA-1; Wed,
 04 Dec 2024 02:19:15 -0500
X-MC-Unique: Mg0yJevCP_ymjZ6F6pPksA-1
X-Mimecast-MFC-AGG-ID: Mg0yJevCP_ymjZ6F6pPksA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B24451955F39; Wed,  4 Dec 2024 07:19:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A6F61956054; Wed,  4 Dec 2024 07:19:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH for-10.0 0/5] tests/functional: Convert tests with
 find_free_ports()
Date: Wed,  4 Dec 2024 08:19:06 +0100
Message-ID: <20241204071911.664057-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
be run in parallel, we extract the find_free_ports() function
into a helper and provide a locking mechanism so that the tests
don't race for the free ports (see second patch).

Thomas Huth (5):
  tests/functional: Convert the vnc test
  tests/functional: Extract the find_free_ports() function into a helper
    file
  tests/functional/test_vnc: Do not use a hard-coded VNC port
  tests/functional/test_vnc: Remove the test_no_vnc test
  tests/functional: Convert the migration avocado test

 tests/avocado/migration.py                    | 135 ------------------
 tests/functional/meson.build                  |  20 +++
 tests/functional/qemu_test/ports.py           |  53 +++++++
 tests/functional/test_migration.py            |  83 +++++++++++
 .../vnc.py => functional/test_vnc.py}         |  70 ++++-----
 5 files changed, 185 insertions(+), 176 deletions(-)
 delete mode 100644 tests/avocado/migration.py
 create mode 100644 tests/functional/qemu_test/ports.py
 create mode 100755 tests/functional/test_migration.py
 rename tests/{avocado/vnc.py => functional/test_vnc.py} (74%)
 mode change 100644 => 100755

-- 
2.47.0


