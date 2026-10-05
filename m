Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887E8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 05:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDbX5-0004Ls-Un; Mon, 05 Oct 2026 01:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbX4-0004Jy-1L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:38 -0400
Received: from out-120.mta0.migadu.com ([2001:41d0:1004:224b::78]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDbX1-0004MZ-Om
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:46:37 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=duVJNez5hyGJqH1a1Fu+tWEmZja2poZI1ssYgIeav4Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791179193; v=1; x=1791783993;
 b=StO8Ufo6kBlkWBQ5goAV0hjEQ21zlfXkiamqtg+g6W670L2p3acVHDLLswhgszeyMZIK/mlb
 nDNDQodgmIn/2lNQAcK8VN8Ax/MfyBFhyAFpvq81EpAJQ0WOXdOhHttLjf+9pPc+E1XvJIwsb7v
 HQxSSnnGw+Y45PdtvHG19rfA=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id afbae5d2f97816b0;
 Mon, 05 Oct 2026 05:46:33 +0000
X-Mizu-Trace-ID: afbae5d2f97816b0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com, philmd@oss.qualcomm.com,
 marcandre.lureau@redhat.com, junjie.cao@linux.dev
Subject: [PATCH v2 0/2] usb-host: validate and release configuration
 descriptors
Date: Mon,  5 Oct 2026 00:46:24 -0500
Message-ID: <20261005054626.131577-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::78;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The libusb host backend reads interface numbers from the active
configuration descriptor while opening a device. An out-of-range number
can index past USBDevice.altsetting. The backend also leaves an allocated
descriptor behind on endpoint parse and interface claim failures.

Changes in v2:
- Use g_autoptr for configuration descriptors in usb_host_ep_update() and
  usb_host_claim_interfaces() (Marc-André).
- Collected tags from Marc-André.

v1: https://lore.kernel.org/qemu-devel/20261004042722.6937-1-junjie.cao@linux.dev/

Junjie Cao (2):
  usb-host: validate interface number before indexing altsetting
  usb-host: free configuration descriptors on error paths

 hw/usb/host-libusb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


base-commit: d7a65d1793d691d356a56833620f7d1e6f5d653b
-- 
2.43.0


