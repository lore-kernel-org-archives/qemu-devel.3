Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mqN7Nx0o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMzub-0003qB-Q1; Fri, 30 Oct 2026 23:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzuY-0003on-Pz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:42 -0400
Received: from out-39.mta0.migadu.com ([2001:41d0:1004:224b::27]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMzuW-0003sn-DR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 23:37:42 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=BYLPxCK/HZr7uSyX/tdDPXOyBGC8y/T8cVh/hvIh2rU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793417854; v=1; x=1794022654;
 b=mqN7Nx0oDxDySt6A9SLl+avNwOxOSK0vmGKV2hqhcFuZrlkw1tkdpqq9+BpwLFxLaGg/hPx/
 lWNOl65GgYePSsMD6D2591YPIuWIv/Ee4O1eg0X3wwip6pvr3vZ6DBS7IBaxIizGMLHOhEGbs5S
 mGFrSSf0C9ayKvrdSu8sNY+M=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 8984d25870e296d3;
 Sat, 31 Oct 2026 03:37:34 +0000
X-Mizu-Trace-ID: 8984d25870e296d3
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 junjie.cao@linux.dev
Subject: [PATCH 0/2] hw/usb/hcd-xhci: check the DCBAA read in Address Device
Date: Fri, 30 Oct 2026 22:37:23 -0500
Message-ID: <20261031033725.1275414-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::27;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Address Device discards the result of the DCBAA entry read. With DCBAAP
pointing at unassigned memory the command still completes with Success
and the slot and ep0 contexts are written to guest address 0:
https://gitlab.com/qemu-project/qemu/-/issues/4706

The series keeps the existing HCE-only error signalling; halting the
controller on a failed host access, as xHCI 4.10.2.6 asks, is a
separate change. The post_load path has no test.

Tested on x86_64 with the reporter's reproducer (before: Success and
address 0 overwritten; after: TRB Error, HCE set, address 0 intact) and
the full usb-hcd-xhci-test.

Patch 2 touches the same test file as the #4658 series
(20261030165807.79423-1-tcalifano@redhat.com); the two apply in either
order with a 3-way merge.

Junjie Cao (2):
  hw/usb/hcd-xhci: fail Address Device when the DCBAA entry is
    unreadable
  tests/qtest/usb-hcd-xhci: test Address Device with an unreadable DCBAA

 hw/usb/hcd-xhci.c               | 41 ++++++++++------
 tests/qtest/usb-hcd-xhci-test.c | 87 ++++++++++++++++++++++++++++-----
 2 files changed, 102 insertions(+), 26 deletions(-)


base-commit: 9703b6cf418d2ce72fae8d00e511135ce0bfda43
-- 
2.43.0


