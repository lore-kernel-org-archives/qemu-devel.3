Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B474CFDEE5E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6SQ-000260-UE; Thu, 23 Apr 2026 22:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wG6SO-00025o-Jb; Thu, 23 Apr 2026 22:39:52 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wG6SJ-00019I-Hp; Thu, 23 Apr 2026 22:39:52 -0400
X-UUID: d4a3ebce3f8611f1aa26b74ffac11d73-20260424
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:345f9eab-8f65-428d-b72b-f10364ce9dd6, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12, REQID:345f9eab-8f65-428d-b72b-f10364ce9dd6, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-15
X-CID-META: VersionHash:e7bac3a, CLOUDID:15b98f039f3999fd9d4ad30c698fc93a,
 BulkI
 D:2604241039377AJEGR2B,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
 |850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
 l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
 :0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4a3ebce3f8611f1aa26b74ffac11d73-20260424
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1970397967; Fri, 24 Apr 2026 10:39:35 +0800
From: zhaoguohan@kylinos.cn
To: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] vfio: propagate IRQ notifier registration failure
Date: Fri, 24 Apr 2026 10:39:04 +0800
Message-ID: <20260424023904.261258-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
fails, but still return true to their callers.

Return false after cleanup so callers can handle the failed registration
path instead of treating it as a successful notifier setup.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/vfio/ap.c  | 1 +
 hw/vfio/ccw.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 276ae8c207bf..6e2a1223ea8d 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -193,6 +193,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                        errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
+        return false;
     }
 
     return true;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index ff6ab9a7408f..c3dc7c196235 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -431,6 +431,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(notifier);
+        return false;
     }
 
     return true;
-- 
2.43.0


