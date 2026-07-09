Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjG7-0001wW-BR; Thu, 09 Jul 2026 03:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1whjG4-0001w1-5w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:33:20 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1whjFx-00032B-OW
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:33:19 -0400
X-UUID: 6280aab47b6811f1aa26b74ffac11d73-20260709
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.3.12, REQID:53bc9d5c-b045-40e7-9b2f-6cad64eb530f, IP:15,
 URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:-10
X-CID-INFO: VERSION:1.3.12, REQID:53bc9d5c-b045-40e7-9b2f-6cad64eb530f, IP:15,
 UR
 L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
 ON:release,TS:-10
X-CID-META: VersionHash:e7bac3a, CLOUDID:dee2072e230bc126d8ca6bed7c38deb5,
 BulkI
 D:260709153248B3TY825Z,BulkQuantity:0,Recheck:0,SF:10|66|78|102|123|127|86
 5|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
 :nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
 RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6280aab47b6811f1aa26b74ffac11d73-20260709
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 126432042; Thu, 09 Jul 2026 15:32:48 +0800
From: zhaoguohan@kylinos.cn
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] hw/virtio/vdpa-dev: pass set_config buffer to vhost backend
Date: Thu,  9 Jul 2026 15:32:25 +0800
Message-ID: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
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

vhost_vdpa_device_set_config() receives the updated config buffer, but
forwards s->config to the vhost backend. Since s->config is refreshed by
get_config(), it may contain stale backend state.

Pass the supplied config buffer to vhost_dev_set_config() instead.

Fixes: b430a2bd2303 ("vdpa: add vdpa-dev support")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 hw/virtio/vdpa-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 089a77f4d0b9..6dc684ab096a 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -212,7 +212,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const uint8_t *config)
     VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
     int ret;
 
-    ret = vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
+    ret = vhost_dev_set_config(&s->dev, config, 0, s->config_size,
                                VHOST_SET_CONFIG_TYPE_FRONTEND);
     if (ret) {
         error_report("set device config space failed");
-- 
2.43.0


