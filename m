Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4ABCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstM-0002uB-UH; Tue, 28 Oct 2025 19:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstK-0002tY-TQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst9-00014g-1N
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:14 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ACB9F81756;
 Wed, 29 Oct 2025 02:13:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-kSdLoIY9; Wed, 29 Oct 2025 02:13:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693235;
 bh=1/MGi/tsP2KZAQxhpYMWKHlovow3Rr/el/C7tdrzP30=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fJNleDlJvqjIlqmTUqR4UYjOUfRCj11H+nGYeudRI9z7zHQx3E524LxWoNy/tmfxi
 f9OyJRHpDYYtVlZPlNsFY/QJVdgY4USpqT3T1C0NyZle/3qvFUmNKAwAdZ3bsMRqys
 LAnR7IKPrpOKobR0yMjyd7PfmXmL5nRPCWU7qfbQ=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 05/22] hw/s390x/virtio-ccw.c: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:29 +0300
Message-ID: <20251028231347.194844-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/s390x/virtio-ccw.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4cb1ced001..f456856d42 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -38,7 +38,7 @@
 
 bool have_virtio_ccw = true;
 
-static int virtio_ccw_dev_post_load(void *opaque, int version_id)
+static bool virtio_ccw_dev_post_load(void *opaque, int version_id, Error **errp)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(opaque);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
@@ -54,7 +54,7 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
     if (ck->refill_ids) {
         ck->refill_ids(ccw_dev);
     }
-    return 0;
+    return true;
 }
 
 typedef struct VirtioCcwDeviceTmp {
@@ -62,7 +62,7 @@ typedef struct VirtioCcwDeviceTmp {
     uint16_t config_vector;
 } VirtioCcwDeviceTmp;
 
-static int virtio_ccw_dev_tmp_pre_save(void *opaque)
+static bool virtio_ccw_dev_tmp_pre_save(void *opaque, Error **errp)
 {
     VirtioCcwDeviceTmp *tmp = opaque;
     VirtioCcwDevice *dev = tmp->parent;
@@ -70,23 +70,24 @@ static int virtio_ccw_dev_tmp_pre_save(void *opaque)
 
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
@@ -97,7 +98,7 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
     .name = "s390_virtio_ccw_dev",
     .version_id = 1,
     .minimum_version_id = 1,
-    .post_load = virtio_ccw_dev_post_load,
+    .post_load_errp = virtio_ccw_dev_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
         VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
@@ -105,7 +106,7 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
         VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
         /*
          * Ugly hack because VirtIODevice does not migrate itself.
-         * This also makes legacy via vmstate_save_state possible.
+         * This also makes legacy via vmstate_save_vmsd possible.
          */
         VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
                          vmstate_virtio_ccw_dev_tmp),
@@ -1130,13 +1131,13 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
+    vmstate_save_vmsd(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
+    return vmstate_load_vmsd(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
-- 
2.48.1


