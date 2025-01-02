Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF4E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIUY-0003pq-Op; Thu, 02 Jan 2025 05:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUX-0003pi-8H
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTIUU-0005pA-Mb
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735813905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=agYX9nekeDSsshn3KZsox4z0IqQC+Mv8Jv1DZGgTGUE=;
 b=fwmkAtBxT+/tBP5danRacWIlzLQJS8w0OrLnDd/U83Gz/O0mI1lC4VRynxRK3KSkkW9IhB
 lcO/UzfRsvcwWPoGNb+UOnWIRbsHn4ckomefwX2sIpa/N1U8ccA2Nbe1L9IyYhBfDFwgf2
 cz4GRreNKkoK7kTlS8Qn2BKzbnwNs18=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-xvipVodjPdeLOAEMOvDt1A-1; Thu,
 02 Jan 2025 05:31:44 -0500
X-MC-Unique: xvipVodjPdeLOAEMOvDt1A-1
X-Mimecast-MFC-AGG-ID: xvipVodjPdeLOAEMOvDt1A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 135DC19560AF
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 10:31:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D268D1956052; Thu,  2 Jan 2025 10:31:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/10] Functional test improvements and fixes
Date: Thu,  2 Jan 2025 11:31:28 +0100
Message-ID: <20250102103138.354618-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

 Hi Stefan!

The following changes since commit 8b70d7f2071e2db51b1910502bfb7f84ebf926be:

  Merge tag 'hw-misc-20241231' of https://github.com/philmd/qemu into staging (2025-01-01 15:17:08 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-01-02

for you to fetch changes up to c5efe54622953c4350566ab42323de61a1c06b8f:

  tests/functional/test_arm_quanta_gsj: Fix broken test (2025-01-02 09:16:42 +0100)

----------------------------------------------------------------
* Update year in copyright statements
* Convert the VNC test to the functional framework
* Improve and update the ppc64_hv functional test
* Fix broken rx_gdbsim and arm_quanta_gsj functional tests

----------------------------------------------------------------
Ani Sinha (1):
      docs: update copyright date to the year 2025

Nicholas Piggin (3):
      tests/functional/test_ppc64_hv: Simplify console handling
      tests/functional/test_ppc64_hv: Update repo management
      tests/functional/test_ppc64_hv: Update to Alpine 3.21.0

Philippe Mathieu-Daudé (1):
      tests/functional/test_rx_gdbsim: Use stable URL for test_linux_sash

Thomas Huth (5):
      tests/functional: Convert the vnc test
      tests/functional/test_vnc: Do not use a hard-coded VNC port
      tests/functional/test_vnc: Remove the test_no_vnc test
      tests/functional: Extract the find_free_ports() function into a helper file
      tests/functional/test_arm_quanta_gsj: Fix broken test

 docs/conf.py                                     |  2 +-
 include/qemu/help-texts.h                        |  2 +-
 tests/functional/meson.build                     |  1 +
 tests/functional/qemu_test/ports.py              | 56 ++++++++++++++++++++++++
 tests/functional/test_arm_quanta_gsj.py          |  2 +-
 tests/functional/test_ppc64_hv.py                | 52 ++++++++++------------
 tests/functional/test_rx_gdbsim.py               | 13 +++---
 tests/{avocado/vnc.py => functional/test_vnc.py} | 55 +++++++----------------
 8 files changed, 108 insertions(+), 75 deletions(-)
 create mode 100644 tests/functional/qemu_test/ports.py
 rename tests/{avocado/vnc.py => functional/test_vnc.py} (74%)
 mode change 100644 => 100755


