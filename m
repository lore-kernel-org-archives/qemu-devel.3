Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D6C35FF1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 09:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttNeW-0005SI-0J; Sat, 15 Mar 2025 05:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNck-0003VU-NX; Sat, 15 Mar 2025 05:16:13 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttNci-00084n-GN; Sat, 15 Mar 2025 05:16:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB7F8FFBC4;
 Sat, 15 Mar 2025 12:13:45 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F2DD31CAD5D;
 Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C0B5955A50; Sat, 15 Mar 2025 12:14:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Rodrigo Dias Correa <r@drigo.nl>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 19/27] goldfish_rtc: Fix tick_offset migration
Date: Sat, 15 Mar 2025 12:14:30 +0300
Message-Id: <20250315091439.657371-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
References: <qemu-stable-7.2.17-20250315101625@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Rodrigo Dias Correa <r@drigo.nl>

Instead of migrating the raw tick_offset, goldfish_rtc migrates a
recalculated value based on QEMU_CLOCK_VIRTUAL. As QEMU_CLOCK_VIRTUAL
stands still across a save-and-restore cycle, the guest RTC becomes out
of sync with the host RTC when the VM is restored.

As described in the bug description, it looks like this calculation was
copied from pl031 RTC, which had its tick_offset migration fixed by
Commit 032cfe6a79c8 ("pl031: Correctly migrate state when using -rtc
clock=host").

Migrate the tick_offset directly, adding it as a version-dependent field
to VMState. Keep the old behavior when migrating from previous versions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2033
Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250114212150.228241-1-r@drigo.nl>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 3521f9cadc29c7d68b73b325ddb46a7acebf6212)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 19a56402a0..81cc942b46 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -178,38 +178,21 @@ static void goldfish_rtc_write(void *opaque, hwaddr offset,
     trace_goldfish_rtc_write(offset, value);
 }
 
-static int goldfish_rtc_pre_save(void *opaque)
-{
-    uint64_t delta;
-    GoldfishRTCState *s = opaque;
-
-    /*
-     * We want to migrate this offset, which sounds straightforward.
-     * Unfortunately, we cannot directly pass tick_offset because
-     * rtc_clock on destination Host might not be same source Host.
-     *
-     * To tackle, this we pass tick_offset relative to vm_clock from
-     * source Host and make it relative to rtc_clock at destination Host.
-     */
-    delta = qemu_clock_get_ns(rtc_clock) -
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    s->tick_offset_vmstate = s->tick_offset + delta;
-
-    return 0;
-}
-
 static int goldfish_rtc_post_load(void *opaque, int version_id)
 {
-    uint64_t delta;
     GoldfishRTCState *s = opaque;
 
-    /*
-     * We extract tick_offset from tick_offset_vmstate by doing
-     * reverse math compared to pre_save() function.
-     */
-    delta = qemu_clock_get_ns(rtc_clock) -
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    s->tick_offset = s->tick_offset_vmstate - delta;
+    if (version_id < 3) {
+        /*
+         * Previous versions didn't migrate tick_offset directly. Instead, they
+         * migrated tick_offset_vmstate, which is a recalculation based on
+         * QEMU_CLOCK_VIRTUAL. We use tick_offset_vmstate when migrating from
+         * older versions.
+         */
+        uint64_t delta = qemu_clock_get_ns(rtc_clock) -
+                 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->tick_offset = s->tick_offset_vmstate - delta;
+    }
 
     goldfish_rtc_set_alarm(s);
 
@@ -239,8 +222,7 @@ static const MemoryRegionOps goldfish_rtc_ops[2] = {
 
 static const VMStateDescription goldfish_rtc_vmstate = {
     .name = TYPE_GOLDFISH_RTC,
-    .version_id = 2,
-    .pre_save = goldfish_rtc_pre_save,
+    .version_id = 3,
     .post_load = goldfish_rtc_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
@@ -249,6 +231,7 @@ static const VMStateDescription goldfish_rtc_vmstate = {
         VMSTATE_UINT32(irq_pending, GoldfishRTCState),
         VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
         VMSTATE_UINT32(time_high, GoldfishRTCState),
+        VMSTATE_UINT64_V(tick_offset, GoldfishRTCState, 3),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.39.5


