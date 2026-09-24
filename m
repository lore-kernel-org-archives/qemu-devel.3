Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D85C98311
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fP7-0008DD-HV; Thu, 24 Sep 2026 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fP4-0008Cr-Fb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x9fP2-0000iM-QR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790240763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Tx5xPA6tlIZRaho8gE9/4B9J+QN4lS7szeZhMWwMbXc=;
 b=Ue01gcuCYFNr0ocpwMMkjww3bkMasyFnSRwLsbTBkVocVItnM7fEL2OEdYGPLnF6aiynpB
 6xPXM9UYMnDn7mS12n023kDSd3cTbt4Z1s9xPhwaEqA+Alkzs3EW+UXXks2n34IeEjnA7T
 ULMPZ2SUG9AYFhVhC1REPvocelilKvU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-7fETIIF6Ok-CNKAD11hC6g-1; Thu,
 24 Sep 2026 05:06:01 -0400
X-MC-Unique: 7fETIIF6Ok-CNKAD11hC6g-1
X-Mimecast-MFC-AGG-ID: 7fETIIF6Ok-CNKAD11hC6g_1790240760
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 997DF1828AB3; Thu, 24 Sep 2026 09:06:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6E21195604C; Thu, 24 Sep 2026 09:05:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/7] XHCI fixes and drop Haiku VM
Date: Thu, 24 Sep 2026 11:05:51 +0200
Message-ID: <20260924090558.801845-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:

  Merge tag 'qom-qdev-20260922' of https://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-09-24

for you to fetch changes up to 1288b0869c082690c04c81ac940c126fb399592b:

  tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch (2026-09-23 15:49:32 +0200)

----------------------------------------------------------------
* Some fixes for the USB XHCI controller emulation
* Drop the broken Haiku VM image

----------------------------------------------------------------
Junjie Cao (4):
      hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
      hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
      tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
      tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch

Thomas Huth (3):
      hw/usb/hcd-xhci: Set reentrancy guard in timer functions (CVE-2026-17588)
      hw/usb/hcd-xhci: Limit DMA transfers to plain memory
      tests/vm: Drop the broken Haiku VM

 hw/usb/hcd-xhci.c               |  58 ++++----
 tests/qtest/usb-hcd-xhci-test.c | 318 ++++++++++++++++++++++++++++++++++++++++
 tests/vm/haiku.x86_64           | 124 ----------------
 3 files changed, 348 insertions(+), 152 deletions(-)
 delete mode 100755 tests/vm/haiku.x86_64


