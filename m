Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E15CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0hc-00011q-RZ; Fri, 12 Sep 2025 06:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hY-0000ur-A1
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ux0hP-00024i-Ox
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757671687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KDMqTW3aY1B5rP6sAh49+iWoo3soWY2fmHqFSuCcfhY=;
 b=Fd6SneEwvH62IuLmUQa2yfTHvAJCQ38yvI5+NwhJvpiK8eiHyTbwnsP2Du9E1pTLHnau+B
 c+anZACtffccjlhC0N7Lsa2/eERdl/devPzTgygkmCgrPTRa7yYXFJV3SSwp5QvcR9tiG/
 ViEl3VAsRGowWn5/5PdjUT0z9f1j4Zo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79--FfUD_99PqmNqMCVHQHeVQ-1; Fri,
 12 Sep 2025 06:08:00 -0400
X-MC-Unique: -FfUD_99PqmNqMCVHQHeVQ-1
X-Mimecast-MFC-AGG-ID: -FfUD_99PqmNqMCVHQHeVQ_1757671680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCE1118004D8; Fri, 12 Sep 2025 10:07:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 231E61954126; Fri, 12 Sep 2025 10:07:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 0/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Date: Fri, 12 Sep 2025 12:07:51 +0200
Message-ID: <20250912100755.316518-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are also some files available in tests/vmstate-static-checker-data/
which were used in the past to verify the functionality of the checker
script. Move them to tests/data/vmstate-static-checker now and add an
automated test that checks for the expected output when using these files
with the scripts/vmstate-static-checker.py script.

Additionally also add an automatic test of the vmstate via good reference
files from an older version of QEMU. I chose to use QEMU 7.2 for the
reference files since this is a long term support release that is still
actively being maintained, so we certainly want to make sure that we don't
break migration from that version to the latest one.

Since the checker script can report false positives in certain cases,
the latter test is marked with the "skipFlakyTests" decorator, i.e. it
is only run if the user set the QEMU_TEST_FLAKY_TESTS environment
variable before starting the tests.

v4:
- Move the test with the dump*.json files to a separate file
- Rebase to current master since the folder layout in tests/functional
  has changed

v3:
- Do not run the tests by default, only if QEMU_TEST_FLAKY_TESTS has
  been set
- Add some hints what to do in case the test detects an error

v2:
- Dropped the patch that is already upstream
- Don't remove the old dump files, rather test for the expected
  output of the checker script with them

Thomas Huth (4):
  tests: Move the old vmstate-static-checker files to tests/data/
  tests/functional: Test whether the vmstate-static-checker script works
    fine
  tests/data/vmstate-static-checker: Add dump files from QEMU 7.2.17
  tests/functional: Use vmstate-static-checker.py to test data from v7.2

 MAINTAINERS                                   |    4 +-
 .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
 .../vmstate-static-checker}/dump1.json        |    0
 .../vmstate-static-checker}/dump2.json        |    0
 .../vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++
 .../ppc64/pseries-7.2.json                    | 1068 ++++++
 .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
 .../x86_64/pc-q35-7.2.json                    | 3297 +++++++++++++++++
 tests/functional/aarch64/meson.build          |    1 +
 tests/functional/generic/test_vmstate.py      |   67 +
 tests/functional/m68k/meson.build             |    4 +
 tests/functional/ppc64/meson.build            |    1 +
 tests/functional/s390x/meson.build            |    4 +
 tests/functional/x86_64/meson.build           |    4 +-
 tests/functional/x86_64/test_bad_vmstate.py   |   58 +
 15 files changed, 10488 insertions(+), 2 deletions(-)
 create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump1.json (100%)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump2.json (100%)
 create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
 create mode 100755 tests/functional/generic/test_vmstate.py
 create mode 100755 tests/functional/x86_64/test_bad_vmstate.py

-- 
2.51.0


