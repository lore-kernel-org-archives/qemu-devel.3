Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C07CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDL2C-0001fq-QB; Sun, 04 Oct 2026 08:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDoz-0003NS-C1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:33 -0400
Received: from out-181.mta0.migadu.com ([2001:41d0:1004:224b::b5]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xDDox-0000XW-Dj
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 00:27:33 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=CZ/7Ogy/cZ7Ij5XnhN41Kj+HjJH0VQykO6MYhNAyR6k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791088046; v=1; x=1791692846;
 b=hr8Y0tjZg8MIv3GvZg3nOsD/JBmjdujGLbzMfm8W5U0fvg2PZteZwP2g0RY9rgZKmOsU4gWp
 j7BRn+VPXUPLwb7rxM/Ayci6ENl7Vff4DyCyVzx5I96X4hk0i3KbmZ/1R72aEy/13HKQ2zoLYnz
 RADxTpChsgax6isdHh3vCUOw=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id fa519eb845901788;
 Sun, 04 Oct 2026 04:27:26 +0000
X-Mizu-Trace-ID: fa519eb845901788
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com, philmd@oss.qualcomm.com,
 junjie.cao@linux.dev
Subject: [PATCH 0/2] usb-host: validate and release configuration descriptors
Date: Sat,  3 Oct 2026 23:27:20 -0500
Message-ID: <20261004042722.6937-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::b5;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 Oct 2026 08:09:34 -0400
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

Junjie Cao (2):
  usb-host: validate interface number before indexing altsetting
  usb-host: free configuration descriptors on error paths

 hw/usb/host-libusb.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.43.0

