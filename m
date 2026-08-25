Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870EFC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqx-0005n2-Sd; Tue, 25 Aug 2026 17:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqw-0005lq-J9; Tue, 25 Aug 2026 17:38:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqu-00050f-Le; Tue, 25 Aug 2026 17:38:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 17329C0964;
 Wed, 26 Aug 2026 00:38:38 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-Pj3kW4Mt; Wed, 26 Aug 2026 00:38:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693917;
 bh=3TucEDGYL4Tz/5ZHt31+D7e0DrG/4eNWyU9JDjFDsno=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=P+afU7QVgxFvREe4e6YFpA/G146cx8gSKNf9q1KazLpcrJZ1m8H3bgLFfkEOpUfCp
 c3x334nywV15dvMeU7Z/w5VyuWEfnv0hlq2HVud2/7OBEnwRnwC4x4896DUKL4ePNE
 ZqK0eLABSU6VDiOyDmi0m65sF56BzU0lB+kg7uUE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:virtio-ccw)
Subject: [PATCH 07/30] hw/s390x/virtio-ccw.c: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:47 +0300
Message-ID: <20260825213811.3725682-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/s390x/virtio-ccw.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 848ed09e94b..6bc901a64ec 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -40,7 +40,7 @@
 
 bool have_virtio_ccw = true;
 
-static int virtio_ccw_dev_post_load(void *opaque, int version_id)
+static bool virtio_ccw_dev_post_load(void *opaque, int version_id, Error **errp)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(opaque);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
@@ -56,7 +56,7 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
     if (ck->refill_ids) {
         ck->refill_ids(ccw_dev);
     }
-    return 0;
+    return true;
 }
 
 typedef struct VirtioCcwDeviceTmp {
@@ -64,7 +64,7 @@ typedef struct VirtioCcwDeviceTmp {
     uint16_t config_vector;
 } VirtioCcwDeviceTmp;
 
-static int virtio_ccw_dev_tmp_pre_save(void *opaque)
+static bool virtio_ccw_dev_tmp_pre_save(void *opaque, Error **errp)
 {
     VirtioCcwDeviceTmp *tmp = opaque;
     VirtioCcwDevice *dev = tmp->parent;
@@ -72,23 +72,24 @@ static int virtio_ccw_dev_tmp_pre_save(void *opaque)
 
     tmp->config_vector = vdev->config_vector;
 
-    return 0;
+    return true;
 }
 
-static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
+static bool virtio_ccw_dev_tmp_post_load(void *opaque, int version_id,
+                                         Error **errp)
 {
     VirtioCcwDeviceTmp *tmp = opaque;
     VirtioCcwDevice *dev = tmp->parent;
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
 
     vdev->config_vector = tmp->config_vector;
-    return 0;
+    return true;
 }
 
 const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
     .name = "s390_virtio_ccw_dev_tmp",
-    .pre_save = virtio_ccw_dev_tmp_pre_save,
-    .post_load = virtio_ccw_dev_tmp_post_load,
+    .pre_save_errp = virtio_ccw_dev_tmp_pre_save,
+    .post_load_errp = virtio_ccw_dev_tmp_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
         VMSTATE_END_OF_LIST()
@@ -99,7 +100,7 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
     .name = "s390_virtio_ccw_dev",
     .version_id = 1,
     .minimum_version_id = 1,
-    .post_load = virtio_ccw_dev_post_load,
+    .post_load_errp = virtio_ccw_dev_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
@@ -107,7 +108,7 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
         VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
         /*
          * Ugly hack because VirtIODevice does not migrate itself.
-         * This also makes legacy via vmstate_save_state possible.
+         * This also makes legacy via vmstate_save_vmsd possible.
          */
         VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
                          vmstate_virtio_ccw_dev_tmp),
-- 
2.43.0


