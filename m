Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C21C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9mmQ-0002ed-Ja; Tue, 29 Apr 2025 11:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mmO-0002eN-WE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9mmN-00046B-Bc
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745940110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OWcDNlinGNFO3RLbbYaloSh0EiMQcHVyn7VLxmHsfl0=;
 b=VvK9PAwwiI8QRzxZFnIQ3qELTtaMUEOkZfqYFSZoM7+o8Q2BNCIg+WcDT2MKvjntNkeFVO
 8Yjr8CP4l1rqrATRVNgm+1W1nFnabr/2ryaxmwjIiFw+KDaS8ZiKRg07SHnAGH4oi1EJps
 q6qIz1TCsWCMuC/slI726qvyGEQLTGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-YLKxHgj5P-CUz7ahfw7oRg-1; Tue,
 29 Apr 2025 11:21:46 -0400
X-MC-Unique: YLKxHgj5P-CUz7ahfw7oRg-1
X-Mimecast-MFC-AGG-ID: YLKxHgj5P-CUz7ahfw7oRg_1745940105
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1949195609D; Tue, 29 Apr 2025 15:21:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.241])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9AE91180045C; Tue, 29 Apr 2025 15:21:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 0/4] Test vmstate with scripts/vmstate-static-checker.py
Date: Tue, 29 Apr 2025 17:21:37 +0200
Message-ID: <20250429152141.294380-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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
reference files from an older version of QEMU. There are already
some files available in tests/vmstate-static-checker-data/ but
they are of no use anymore since they have been taken from machines
that have already been removed a long time ago (and thus these files
now get removed, too). I chose to use QEMU 7.2 for the reference files
instead since this is a long term support release that is still actively
being maintained, so we certainly want to make sure that we don't
break migration from that version to the latest one.

Thomas Huth (4):
  tests/vmstate-static-checker-data: Remove old dump files
  scripts/vmstate-static-checker.py: Allow new name for ghes_addr_le
    field
  tests/data/vmstate-static-checker: Add dump files from QEMU 7.2.17
  tests/functional: Test with scripts/vmstate-static-checker.py

 MAINTAINERS                                   |    3 +-
 scripts/vmstate-static-checker.py             |    1 +
 .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
 .../vmstate-static-checker/m68k/virt-7.2.json | 2936 ++++++++++++++
 .../ppc64/pseries-7.2.json}                   | 1276 ++++---
 .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
 .../x86_64/pc-q35-7.2.json                    | 3402 +++++++++++++++++
 tests/functional/meson.build                  |   13 +-
 tests/functional/test_vmstate.py              |   56 +
 tests/vmstate-static-checker-data/dump1.json  | 1163 ------
 10 files changed, 10143 insertions(+), 1753 deletions(-)
 create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
 rename tests/{vmstate-static-checker-data/dump2.json => data/vmstate-static-checker/ppc64/pseries-7.2.json} (51%)
 create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
 create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
 create mode 100755 tests/functional/test_vmstate.py
 delete mode 100644 tests/vmstate-static-checker-data/dump1.json

-- 
2.49.0


