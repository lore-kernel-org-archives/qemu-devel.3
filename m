Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9645CD1268E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQho9-00033i-JY; Wed, 03 Dec 2025 03:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQho1-0002bq-2b; Wed, 03 Dec 2025 03:01:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnu-00074C-Vl; Wed, 03 Dec 2025 03:01:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7EB0170776;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 75FDF32B49D;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 105/116] hw/arm/armv7m: Disable reentrancy guard for
 v7m_sysreg_ns_ops MRs
Date: Wed,  3 Dec 2025 10:59:25 +0300
Message-ID: <20251203075939.2366131-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Peter Maydell <peter.maydell@linaro.org>

For M-profile cores which support TrustZone, there are some memory
areas which are "NS aliases" -- a Secure access to these addresses
really performs an NS access to a different part of the device.  We
implement these using MemoryRegionOps read and write functions which
pass the access on with adjusted attributes using
memory_region_dispatch_read() and memory_region_dispatch_write().

Since the MR we are dispatching to is owned by the same device that
owns the NS-alias MR (the TYPE_ARMV7M container object), this trips
the reentrancy-guard that is applied by access_with_adjusted_size().

Mark the NS alias MemoryRegions as disable_reentrancy_guard; this is
safe because v7m_sysreg_ns_read() and v7m_sysreg_ns_write() do not
touch any of the device's state.  (Any further reentrancy attempts by
the underlying MR will still be caught.)

Without this fix, an attempt to read from an address like 0xe002e010,
which is a register in the NS systick alias, will fail and provoke

 qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: v7m_systick at addr: 0x0

We didn't notice this earlier because almost all code accesses
the registers and systick via the non-alias addresses; the NS
aliases are only need for the rarer case of Secure code that needs
to manage the NS timer or system state on behalf of NS code.

Note that although the v7m_systick_ops read and write functions
also call memory_region_dispatch_{read,write}, this MR does not
need to have the reentrancy-guard disabled because the underlying
MR that it forwards to is owned by a different device (the
TYPE_SYSTICK timer device).

Reported via a stackoverflow question:
https://stackoverflow.com/questions/79808107/what-this-error-is-even-about-qemu-system-arm-warning-blocked-re-entrant-io

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251114155304.2662414-1-peter.maydell@linaro.org
(cherry picked from commit 4a934d284dfac9fa19b0f47874f12d9b3519c21c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 64009174b9..be15740726 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -442,6 +442,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
                               &v7m_sysreg_ns_ops,
                               sysbus_mmio_get_region(sbd, 0),
                               "nvic_sysregs_ns", 0x1000);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the NVIC sysregs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->sysreg_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion(&s->container, 0xe002e000,
                                     &s->sysreg_ns_mem);
     }
@@ -499,6 +505,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&s->systick_ns_mem, OBJECT(s),
                               &v7m_sysreg_ns_ops, &s->systickmem,
                               "v7m_systick_ns", 0xe0);
+        /*
+         * This MR calls memory_region_dispatch_read/write to access the
+         * real region for the systick regs (which is also owned by this
+         * device), so reentrancy through here is expected and safe.
+         */
+        s->systick_ns_mem.disable_reentrancy_guard = true;
         memory_region_add_subregion_overlap(&s->container, 0xe002e010,
                                             &s->systick_ns_mem, 1);
     }
-- 
2.47.3


