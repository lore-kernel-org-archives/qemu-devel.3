Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C2CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXoMd-00059d-Fn; Tue, 14 Jan 2025 16:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tXoMb-00059M-Qx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:22:17 -0500
Received: from smtp-190b.mail.infomaniak.ch ([185.125.25.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r@drigo.nl>) id 1tXoMY-0008Ca-Te
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:22:17 -0500
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YXhsX06Klz6v0;
 Tue, 14 Jan 2025 22:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drigo.nl;
 s=20241108; t=1736889727;
 bh=G2rbHS6u3Za8/AC5FJ/CdxlwUMqNT7soTE46QA9lHHw=;
 h=From:To:Cc:Subject:Date:From;
 b=VPsLgVDJmfmY3YHy94ysAD9X2EEpAZc/484AI69r95KdzGIDDRlr+qvjZS1s6KudA
 b/ilGuzxv8KlC+rESDZad/ok4qiKmGFUUd2K0Om+HELueJNfWhDPgWIitl0vmfbNpr
 1bCkqm88KAlgCuq4mApiJBtbobzQsIXtNChACk89fwSPq11YxjRSSiWs3kt7cX8PWI
 7Bo7q9KGh78yugy1K+CgmQNaNjbAup7eaAbiZLZDdZWvOsw1NZlRXM2gIdxJ4al+Jy
 1yxUxQLfy4jdHMfwZWNM6cjPiY+PoAYgsnFwyDRtdyhlvOuyAPXdU9MTate6rJNkZg
 vUvPGjGXNo30A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YXhsW2Z14zgJR; Tue, 14 Jan 2025 22:22:07 +0100 (CET)
From: Rodrigo Dias Correa <r@drigo.nl>
To: anup.patel@wdc.com,
	Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] goldfish_rtc: Fix tick_offset migration
Date: Tue, 14 Jan 2025 22:21:50 +0100
Message-Id: <20250114212150.228241-1-r@drigo.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=185.125.25.11; envelope-from=r@drigo.nl;
 helo=smtp-190b.mail.infomaniak.ch
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 As a new field was added to VMState, after this patch, it won't be possible to
 migrate to old versions. I'm not sure if this is needed. Please, let me know.
---
 hw/rtc/goldfish_rtc.c | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index fa1d9051f4..0f1b53e0e4 100644
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
     .fields = (const VMStateField[]) {
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
2.34.1


