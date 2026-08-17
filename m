Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4791C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqP-0001VE-S1; Mon, 17 Aug 2026 06:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqM-0001Kg-6B; Mon, 17 Aug 2026 06:45:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqK-0003zy-Dg; Mon, 17 Aug 2026 06:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=qDnfeC9t2q76LFVSjpwtBKLyxNSQJjo+X1rGFDUpmWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k2OBLgEAML2DOE1wJ3Y1MxdlpvnvX8j7vTuDNvMY2DGcHUDPZw3MsIWZ1XOpfsVHi
 ZDrS150Bp0AozS35L+RwWjjaCAeDbqPSj3tEWFxeM7LsaUEgO3OYcQ8Mp4euZr7esx
 +pk1oDabEc690RbCeowRRPZeorddxuML262YLxZ1ODMt1BbWrRt7V90vIpNVtfC5Xt
 t1tmd/9/tBA3tA0EJ1DN1capL6H3vPCGGsyxejbRm0p5kf0e6W4ZT4ivP288lTBmhn
 JgVieaeTt9t/4S1XJL/dmgCi+1/c7l16U1KbNt8YCNWsjZ7SzQdsBwbEl6VkOQA3uU
 AwXdGX2o93vtg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B2941CBB70;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7C83F40D201;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0DAA030E58; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 131/161] pc-bios/s390-ccw: Refactor byte swapping
Date: Mon, 17 Aug 2026 13:42:45 +0300
Message-ID: <20260817104344.2047346-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Introduce local variables to cache the byte-swapped values eliminating
some redundant byte swap operations.  Additionally, do byte swap when
polling to avoid a special case where endianness is preserved.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260630141917.673995-2-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit c12bb74fd57f9ec9a90887a79282c24f17690183)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 390b55c7b92..a448dc96e26 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -153,14 +153,14 @@ static void vr_bswap_descriptor(VRingDesc *desc)
 
 void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
-    }
+    uint16_t avail_idx;
+
+    avail_idx = be_ipl() ? vr->avail->idx : bswap16(vr->avail->idx);
 
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
-        vr->avail->ring[vr->avail->idx % vr->num] = be_ipl() ? vr->next_idx :
-                                                               bswap16(vr->next_idx);
+        vr->avail->ring[avail_idx % vr->num] = be_ipl() ? vr->next_idx :
+                                                          bswap16(vr->next_idx);
     }
 
     vr->desc[vr->next_idx].addr = (unsigned long)p;
@@ -177,23 +177,23 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
 
     /* Chains only have a single ID */
     if (!(flags & VRING_DESC_F_NEXT)) {
-        vr->avail->idx++;
-    }
-
-    if (!be_ipl()) {
-        vr->avail->idx = bswap16(vr->avail->idx);
+        avail_idx++;
+        vr->avail->idx = be_ipl() ? avail_idx : bswap16(avail_idx);
     }
 }
 
 int vr_poll(VRing *vr)
 {
-    if (vr->used->idx == vr->used_idx) {
+    uint16_t used_idx;
+
+    used_idx = be_ipl() ? vr->used->idx : bswap16(vr->used->idx);
+    if (used_idx == vr->used_idx) {
         vring_notify(vr);
         yield();
         return 0;
     }
 
-    vr->used_idx = vr->used->idx; /* Endianness is preserved */
+    vr->used_idx = used_idx;
     vr->next_idx = 0;
     vr->desc[0].len = 0;
     vr->desc[0].flags = 0;
-- 
2.47.3


