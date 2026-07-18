Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C74C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 16:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl8IG-00058Y-LB; Sat, 18 Jul 2026 12:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <afbe101f9fef3110d79023c604be0b28006cfb60@kylie.crudebyte.com>)
 id 1wl8ID-00057a-RZ; Sat, 18 Jul 2026 12:53:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <afbe101f9fef3110d79023c604be0b28006cfb60@kylie.crudebyte.com>)
 id 1wl8IA-0002rz-4I; Sat, 18 Jul 2026 12:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-ID:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=LqHiQUAQrZyagAjl2T9yb5rVPUQhs9ajOF5oLBjNb34=; b=FCHyD
 4qH0TTRfNdB7AhpcmiqOloAZ+69CkFdkjFD1tqIAnWqN7ZgDCaStuO0BWL1NImE/KsgUi/2uoU9Kx
 +23WlZnXasPW2EXVPpI4mOJ2oCS5HnRl95G271NvEEdBJuwkrR/nqtx7TVq30lpFkaZSmx07hkqKj
 Toa1Lf12oh8NmQZea25QkRwidIVru9ukoKwmUKXl/l3OVaBxTryzMsC0tU8eU3rgbnch2T6aG3Lu9
 ky5siTnxEhRR9vTRaxRDev1skLSs3t/pbI2Jbkqecr7R3CSPyLH3GvfxkVVlhL6F/TdXrs/dMJhEu
 bSjcEVULNGnqOXVaH0XEbjcqlffL/Eh42YqWlkNXn0gRHiKkCBV+GWW8vph1VRiLEOIpulOlQctMI
 V1pWd8fJJ/1CBWKeW0fpU4FQsL7F7JMjQ6YGHjieJVmtjDr+kD11biQ3E46B+T7+PpHDRAQ/Pz35E
 wnGFvQrSybRpnWN2DSAFU2QyK+vrPqbkj5ihdcdVK0BpttG0AlfK+yw1aRBS/XGPP3qEOEELFlPM+
 lEryNgZQ8wFWBS1TaR49BAJQFDa06UWBqh9J1vrdyPIbEB+9yd8ppeF5YGG0FfsXu1jni/3b1/8Lj
 L6hL8Po86BiXE+7jHtu07FEn8bRRChrIlsZDuUGh4kAle+0AdOunyAIty3dzvs=;
Message-ID: <cover.1784392605.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 18 Jul 2026 18:50:06 +0200
Subject: [PATCH v2 0/2] 9p: fix guest-triggered Treaddir/ACPI eject UAF
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=afbe101f9fef3110d79023c604be0b28006cfb60@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
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

A guest can trigger unplugging 9pfs server's virtio-pci device via ACPI
eject. As a consequence the device is unrealized, server's internal state
is freed while pending coroutines would still have access to them, causing
a potential heap-use-after-free.

Overview Patches:

 - Patch 1: this is the core fix, that drains all PDUs (i.e. coroutines
   that handle individual pending requests in parallel) before freeing
   server state.

 - Patch 2: fixes a similar identified issue with the Xen transport, even
   though not triggered via ACPI, it is also prone to UAF, plus a resource
   leak.

v2:
  - Patch 1: Make Jia the official author of this patch.
  - Drop prev. patch 2 ("hw/9pfs/virtio: disable hotpluggable property...")
  - Patch 2: defer explict xen_9pfs_disconnect() call from error paths of
    xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal().

Christian Schoenebeck (1):
  hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect

Jia Jia (1):
  hw/9pfs/virtio: drain in-flight PDUs before virtio-9p unrealize

 hw/9pfs/virtio-9p-device.c |  1 +
 hw/9pfs/xen-9p-backend.c   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.47.3


