Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A275606AF42
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F2xTnZ/N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt7k-0006vH-0u; Thu, 22 Oct 2026 09:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7d-0006tF-Ok
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:23 -0400
Received: from out-40.mta1.migadu.com ([2001:41d0:203:375::28]
 helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xJt7b-0004xb-I3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:46:21 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=0J/zfX4nB9D1pBqb9RktBdSojRn8m/F7Ejz2y+JVqkw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792676772; v=1; x=1793281572;
 b=F2xTnZ/NplhUO5+GupZ6RUijVv+Tp+yVbqzOyh21zc0g6+IIf82Qf43nfvHG/kk6LhBUma/3
 5OaH0A+OglalPuN7B6crsmFvUs/sDlpuwzEGaQj7ih+892jgjs4g623AsypFK7ST+X+Cqnsc7w9
 duYMiNvJA/70o4ZKjoCc9CCw=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 49b3bf1a7599676b;
 Thu, 22 Oct 2026 13:46:12 +0000
X-Mizu-Trace-ID: 49b3bf1a7599676b
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org, junjie.cao@intel.com
Subject: [PATCH v1 0/7] tests/qtest: Extend USB host controller transfer
 coverage
Date: Thu, 22 Oct 2026 13:45:54 +0000
Message-ID: <20261022134601.1207204-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:203:375::28;
 envelope-from=junjie.cao@linux.dev; helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

Peter's discussion of isochronous endpoint mismatches highlighted the
lack of tests as a concern for moving the checks into the USB core [1].
This series adds transfer tests motivated by that discussion, without
changing controller or USB core code.

The tests cover EHCI control transfers and isochronous IN/OUT requests
to EP0, UHCI interrupt retries and isochronous completion on NAK, and
successful UHCI/xHCI isochronous OUT transfers to USB audio. The audio
tests configure the device and enable its streaming interface through
EP0 before submitting a packet.

These cases exercise both rejection/retry behavior and successful
isochronous transfers. EHCI isochronous success and USB_RET_ASYNC
completion remain outside the coverage of this series.

Suggestions for other transfer paths to cover in follow-up patches
are welcome.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA8jcNzVT9QuFfog4GZRWt8ZpysKbOy9R-SxmtTrAZ67JQ@mail.gmail.com/

Junjie Cao (7):
  tests/qtest/usb-hcd-ehci: Test a control transfer
  tests/qtest/usb-hcd-ehci: Cover isochronous IN to EP0
  tests/qtest/usb-hcd-ehci: Cover isochronous OUT to EP0
  tests/qtest/usb-hcd-uhci: Test interrupt NAK retries
  tests/qtest/usb-hcd-uhci: Test isochronous NAK completion
  tests/qtest/usb-hcd-uhci: Test a successful isochronous transfer
  tests/qtest/usb-hcd-xhci: Test a successful isochronous transfer

 tests/qtest/usb-hcd-ehci-test.c | 208 +++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-uhci-test.c | 229 ++++++++++++++++++++++++++++++++
 tests/qtest/usb-hcd-xhci-test.c |  95 ++++++++++++-
 3 files changed, 526 insertions(+), 6 deletions(-)


base-commit: ed698be7700160c74d24ef7830adccd2a28d840a
-- 
2.43.0


