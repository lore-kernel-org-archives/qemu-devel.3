Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FE606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZR5Z1Qah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJq9y-0003Uw-64; Thu, 22 Oct 2026 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJq9w-0003UN-Jm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJq9u-0007kt-4e
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u+sKn7Y2UTAAGU6sFfeJyI2+8hEhMk7bY6J/I29Nbbs=;
 b=ZR5Z1QahZMl4ktrVkcuGcBpLJqvpAVwRNMGWCdGtZk0B4xc9MXzrDLmuHzjP8zYaSSGVqf
 4L32RhH8ZeoLR7qSCIzEZ/ThcFp+xTfG74NCh0rCKcXFajPIYkXt5SFlIYZ0ZCeTJpUtmh
 3pDawcmJL/9VQBUv/lrCF34DWAvK2Lo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-G1VdrEJ5MpOAoZMWCk5D_A-1; Thu,
 22 Oct 2026 10:36:26 +0000
X-MC-Unique: G1VdrEJ5MpOAoZMWCk5D_A-1
X-Mimecast-MFC-AGG-ID: G1VdrEJ5MpOAoZMWCk5D_A_1792665385
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F57E180059B; Thu, 22 Oct 2026 10:36:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56D1B30000E7; Thu, 22 Oct 2026 10:36:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/11] Various fixes for the USB code
Date: Thu, 22 Oct 2026 12:36:11 +0200
Message-ID: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

 Hi Richard!

The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:

  Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-10-22

for you to fetch changes up to cfa70f3a82f581ad758586ecf408fe7f3602850f:

  hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code (2026-10-22 12:33:17 +0200)

----------------------------------------------------------------
Various fixes for the USB code

----------------------------------------------------------------
Haotian Jiang (2):
      usb-host: free request on libusb submit failure
      usb-host: delete bottom halves during unrealize

Junjie Cao (4):
      tests/qtest: Cover OHCI endpoint type mismatches
      usb-host: validate interface number before indexing altsetting
      usb-host: free configuration descriptors on error paths
      tests/qtest/usb-hcd-xhci: test interrupt pacing above 2^32

Peter Maydell (1):
      hw/usb/hcd-ohci: Fail iso packets sent to non-iso endpoints and vice-versa

Thomas Huth (1):
      hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code

Tommaso Califano (3):
      hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
      hw/usb/dev-mtp: Fix assert crash on short CMD_SEND_OBJECT
      hw/usb/dev-mtp: Fix heap OOB read in usb_mtp_write_metadata()

 hw/usb/dev-mtp.c                |  24 ++-
 hw/usb/hcd-ohci.c               |  67 +++---
 hw/usb/hcd-xhci.c               |  27 +++
 hw/usb/host-libusb.c            |  47 ++++-
 tests/qtest/usb-hcd-ohci-test.c | 439 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c |  46 +++++
 hw/usb/trace-events             |   2 +
 7 files changed, 613 insertions(+), 39 deletions(-)


