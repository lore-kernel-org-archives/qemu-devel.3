Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920FFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5OE-0006KU-Jy; Tue, 07 Jul 2026 08:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OD-0006I1-G2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wh5OB-0006gk-AW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783429142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FbkIW98jZ/SwSpR+1vhOb0Wiwd4C0+IxGrgo7niNvM=;
 b=QMtFYNujhWZ1BlrB0V1FXnrN+JLTRMV/bx8RLEzwr82CopuB2QsuPSINmNBkopY6eiQ4MM
 aqDwmcjIVv4RjJ2QMBs4LsW9IWXA90yvAzqZawQLaI787rC6M8CDNLAZm5d9xp3uYohfAK
 fSzv81QcB4tDgV65Awf1c+JBgiMsWVw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-C34TqVcbMfqn-7r8Jlm_Tg-1; Tue,
 07 Jul 2026 08:58:57 -0400
X-MC-Unique: C34TqVcbMfqn-7r8Jlm_Tg-1
X-Mimecast-MFC-AGG-ID: C34TqVcbMfqn-7r8Jlm_Tg_1783429135
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B31A1954198; Tue,  7 Jul 2026 12:58:55 +0000 (UTC)
Received: from gondolin.fritz.box (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E7901956040; Tue,  7 Jul 2026 12:58:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 01/15] pc-bios/s390-ccw: Refactor byte swapping
Date: Tue,  7 Jul 2026 14:58:33 +0200
Message-ID: <20260707125847.1785168-2-cohuck@redhat.com>
In-Reply-To: <20260707125847.1785168-1-cohuck@redhat.com>
References: <20260707125847.1785168-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 pc-bios/s390-ccw/virtio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 390b55c7b924..a448dc96e269 100644
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
2.54.0


