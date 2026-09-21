Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57A1C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 05:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Wrm-0000uW-TC; Mon, 21 Sep 2026 01:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrW-0000qy-MK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:46:48 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8WrV-000300-2k
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 01:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789969605; x=1821505605;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XItzFhdsFueieco+OL6NdjNRB4JNwsT8c+1zyhvXj58=;
 b=bd/QPFv51JW4qc8XYhgRqFzVDJ6QVVJrMp5TMAphsR5FmXv4hc5f1bh9
 woGAxwxSQLgVJO28aEFBmB5GfyNwzU5FwAkjytNyJDC9EcmIctXf0dduS
 uSOc0fqQp4ASiT5IBNkLLIWD9dQ9oRzT7THZcoi91YX9jrUw60Dpyviud
 Qb3vdSmEzL+ySxcN39m5CdQBB0SSsmHdvIvbUdcRkLIttlEIX9VV89jEq
 1a6t3nvI4QqkmfErGRbFqM+/GfFZ0qTmV3gKbPpG89fTvujbPltOtucSo
 sqGV9i/3Fg1To3C2Zu8orM6PoNqdfvGVNlkEblCxUX51fX8i/YX8sNoGh A==;
X-CSE-ConnectionGUID: 5MmrmAUIQBqVBsC92bn5cw==
X-CSE-MsgGUID: KwcyWbzlRya/yD+cf8B9tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94287015"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="94287015"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:41 -0700
X-CSE-ConnectionGUID: jX27Bn99QXW8FIblJmb/kg==
X-CSE-MsgGUID: eygewb4TQoaA70Q9zL/4DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3815182"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 22:46:38 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Feifan Qian <bea1e@proton.me>
Subject: [PATCH 0/4] hw/usb/hcd-xhci: two isoch fixes with qtests
Date: Mon, 21 Sep 2026 13:46:28 +0800
Message-ID: <cover.1789968699.git.junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Two xHCI bugs from the issue tracker, each with a qtest.

The interval mask is 32 bits wide, so once MFINDEX passes 2^32 isoch TDs
with SIA are no longer held until the next interval boundary. This
matches #3973: onset after 6.2 days of uptime, cleared by re-binding the
controller in the guest.

A guest can declare a non-isoch endpoint as isoch and hit an assertion
when the device NAKs (#3886). #544 is the same assertion, reached from
the kick timer as in patch 4. Its reproducer from 2021 no longer
triggers on master, so it is not tagged.

Both tests fail on master (c1c18d1e64). Tested on x86_64 with an
ASan/UBSan build: usb-hcd-xhci-test, usb-hcd-ehci-test and
usb-hcd-uhci-test pass. The new tests skip on ppc64.

Junjie Cao (4):
  hw/usb/hcd-xhci: fix interval alignment after MFINDEX passes 2^32
  hw/usb/hcd-xhci: don't assert on NAK when retrying an isoch transfer
  tests/qtest/usb-hcd-xhci: test isoch pacing with MFINDEX above 2^32
  tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch

 hw/usb/hcd-xhci.c               |  33 +---
 tests/qtest/usb-hcd-xhci-test.c | 318 ++++++++++++++++++++++++++++++++
 2 files changed, 328 insertions(+), 23 deletions(-)


base-commit: c1c18d1e640b64292859ce9f30f3c344edfb0294
-- 
2.43.0


