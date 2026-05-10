Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E607CD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 08:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLzlz-0003pf-Ux; Sun, 10 May 2026 04:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wLzlr-0003oF-JO; Sun, 10 May 2026 04:44:19 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wLzlo-0003hQ-Jn; Sun, 10 May 2026 04:44:19 -0400
X-UUID: 628fbb944c4c11f1aa26b74ffac11d73-20260510
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:3f5ef929-c3d7-44cf-b9be-07c08a83fd43, IP:10,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:5
X-CID-INFO: VERSION:1.3.12, REQID:3f5ef929-c3d7-44cf-b9be-07c08a83fd43, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:5
X-CID-META: VersionHash:e7bac3a, CLOUDID:d5005ae25394c59dabb18bfc7ba2f58d,
 BulkI
 D:260510164358YKDD17RY,BulkQuantity:0,Recheck:0,SF:10|66|78|81|82|102|123|
 127|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
 QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
 ,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 628fbb944c4c11f1aa26b74ffac11d73-20260510
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(120.228.139.157)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 658323952; Sun, 10 May 2026 16:43:58 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
Subject: [PATCH v2 2/2] vfio/ccw: Return false when IRQ notifier setup fails
Date: Sun, 10 May 2026 16:43:53 +0800
Message-ID: <20260510084353.58263-3-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
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

vfio_ccw_register_irq_notifier() cleans up the fd handler and EventNotifier
when vfio_device_irq_set_signaling() fails, but still returns true to its
caller.

Return false after cleanup so the caller can handle the failed
registration path instead of treating it as a successful notifier setup.

Fixes: 8aaeff97acee ("vfio/ccw: Make vfio_ccw_register_irq_notifier() return a bool")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/vfio/ccw.c | 1 +
 1 file changed, 1 insertion(+)

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


