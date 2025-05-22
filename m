Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5940C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI67e-0000Nm-L8; Thu, 22 May 2025 09:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67c-0000NE-Cy
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI67Z-0001Vx-EH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747921083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jTyLg8Ku8Nh97/f8stHQO9bQWMc1O1umrU9MhAnh17k=;
 b=KG8+9ODai3z0jS/yYH6Rxi0h5bOQ5QEKKg/GTrJDWh6MPzUQaySK+GbLO6B9vdR7gomiap
 O8kdW+qoWkNA5VXItV2TDATLNrGKYYpFCWa4+QJk+jwjzjbebYsAEUG2n54dL7h5gTe1Pa
 YwBVQ26HnBd8s97X/Aod2IeiOslWH3c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-7UlHSCuUNWS4B40lGE1QYA-1; Thu,
 22 May 2025 09:38:02 -0400
X-MC-Unique: 7UlHSCuUNWS4B40lGE1QYA-1
X-Mimecast-MFC-AGG-ID: 7UlHSCuUNWS4B40lGE1QYA_1747921080
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEFC519560AE; Thu, 22 May 2025 13:38:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C1CC30001A1; Thu, 22 May 2025 13:37:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 0/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Date: Thu, 22 May 2025 15:37:52 +0200
Message-ID: <20250522133756.259194-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This set of patches adds an automatic test of the vmstate via the
scripts/vmstate-static-checker.py script. For this we need some
reference files from an older version of QEMU. I chose to use QEMU 7.2
for the reference files since this is a long term support release that
is still actively being maintained, so we certainly want to make sure
that we don't break migration from that version to the latest one.

There are also some files available in tests/vmstate-static-checker-data/
which were used in the past to verify the functionality of the checker
script. Move them to tests/data/vmstate-static-checker now and add an
automated test for this task, too.

(I originally mentioned that I could also look into testing automatically
with an older version of QEMU, but I currently lack the time to do so,
so if somebody else wants to have a try that would be very welcome!)

v2:
- Dropped the patch that is already upstream
- Don't remove the old dump files, rather test for the expected
  output of the checker script with them

Thomas Huth (4):
  tests: Move the old vmstate-static-checker files to tests/data/
  tests/data/vmstate-static-checker: Add dump files from QEMU 7.2.17
  tests/functional: Test with scripts/vmstate-static-checker.py
  tests/functional/test_vmstate: Test whether the checker script works
    as expected

 MAINTAINERS                                   |    3 +-
 .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
 .../vmstate-static-checker}/dump1.json        |    0
 .../vmstate-static-checker}/dump2.json        |    0
 .../vmstate-static-checker/m68k/virt-7.2.json | 2936 +++++++++++++++
 .../ppc64/pseries-7.2.json                    | 1068 ++++++
 .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
 .../x86_64/pc-q35-7.2.json                    | 3297 +++++++++++++++++
 tests/functional/meson.build                  |   13 +-
 tests/functional/test_vmstate.py              |   96 +
 10 files changed, 10457 insertions(+), 2 deletions(-)
 create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump1.json (100%)
 rename tests/{vmstate-static-checker-data => data/vmstate-static-checker}/dump2.json (100%)
 create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
 create mode 100755 tests/functional/test_vmstate.py

-- 
2.49.0


