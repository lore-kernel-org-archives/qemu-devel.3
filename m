Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22622D1BDD1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrpS-0001kq-6E; Wed, 03 Dec 2025 13:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpL-0001hX-C7
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:47 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrpH-0005hF-8S
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:43:47 -0500
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37jcJg3681167
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 18:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=ljRmB77NnqAdrgPEzQrr268ITHscsnHq1PoRVyI/Pzk=; b=hK8n4/ZC00oi
 SFxAiPYs5KJoMpdv9WluV7rCZDyeqOc6hVWPVDX4IBEHJ8WCByQSXO4XYcRCZsk7
 m8On+C47YmknOOHq9c8YmQAa2PcSghtbGLM+QSoCXtfcHLSmxih6Pcvm08pD2cCm
 S5W+JMXDuA59xnyn4O3G95EZ6dE4l0NhSzn3P7cJ3EMyjSF8I6OgYwzjUw+vYIZD
 lQVEZIinapRGEhH0hoylRDtfqZihVqeSlDgx373crIGHSxEQA7/1cV6yCnOPEQmI
 5f6UXWSJqQa9WWbOu3U3QwhmLPYqmJK9A345ErLx+MM6EpXh2tanKvPxHv3dbwjA
 tForBXnXXw==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4aspcaad58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:43:39 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3H7Opb026170
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 10:43:38 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4aqypdkkhh-1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:43:38 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 4688991
 for <qemu-devel@nongnu.org>; Wed,  3 Dec 2025 18:43:38 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:43:24 -0500
Subject: [PATCH v3 3/8] vhost: reset vhost devices for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-3-3cc89e9b19e4@akamai.com>
References: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3cc89e9b19e4@akamai.com>
To: qemu-devel@nongnu.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787418; l=5230;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=6kTSGt3ELi899SPi+eJ4MTXel5sLxi3unzD950w6j/M=;
 b=0bWH3EO1Cx4DWscjdZmjpeJr1HCYRu8t5o6qI/Hv35EyJ+xmOzGWw5IVwbR+Q9FcjUGdWHuMK
 bbpIG0ni2GcCdoDFjF1v8l1veAwVPYr6hvVyGJQXIiLQ93tTtKCWswN
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512030146
X-Proofpoint-GUID: KrrkERjg2KXTyIGX2tFgZR_qOs-fHCZp
X-Authority-Analysis: v=2.4 cv=c5umgB9l c=1 sm=1 tr=0 ts=693084db cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=6lTwf2g7YyX0f-ifu7AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KrrkERjg2KXTyIGX2tFgZR_qOs-fHCZp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfXyx0u8m9JxNZ7
 MrCN/hbmcmRTmPICZqCJn9iJXkCQlRkNAxjGpFYhC7ExITZgxiTQGMmFarh4TvOLvfWcwJF66Gm
 Nl6ooX57+5sHzCFX5M1/Qx0+eN+TUkZmB16ilVcV8DY2fvKND1+Wwm5sw1x+7p2VPDebjq9KLnT
 DkStbsvJDzebJBWYsue+hBbpZ73UTTLPMANJAWE5beMCsoIYw65g5ufQUR/i3OC1105qcEYa4Od
 6Gr2cGjKxPLr+u2EwOtWT3aVK78X0tKrKClzHDq+RWQ+UUm/tof2Ka/iBjIfzr4WZGxKkKWgdZt
 mNsi5+xkYXUcEF73VXWQVVOn9sx1PGRQC2tqKggbOrIwb6NXtfdki0JN9f3ywqNqZnhJWlnmbHC
 rmzOIQCxNq5mXYMpO2dt2NHuD8cI0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
during vhost_dev_init.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 hw/virtio/vhost-backend.c         |  6 ++++++
 hw/virtio/vhost.c                 | 32 ++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost.h         |  1 +
 4 files changed, 40 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4367db0d95..1447d12963 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..011d73dae2 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -24,6 +24,7 @@
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/mem/memory-device.h"
+#include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
@@ -1540,6 +1541,32 @@ static int vhost_dev_get_features(struct vhost_dev *hdev,
     return r;
 }
 
+static int vhost_cpr_notifier(NotifierWithReturn *notifier,
+                              MigrationEvent *e, Error **errp)
+{
+    struct vhost_dev *dev;
+    int r;
+
+    dev = container_of(notifier, struct vhost_dev, cpr_transfer_notifier);
+
+    if (dev->vhost_ops->backend_type != VHOST_BACKEND_TYPE_KERNEL) {
+        return 0;
+    }
+
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+        r = dev->vhost_ops->vhost_reset_owner(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_reset_owner failed");
+        }
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        r = dev->vhost_ops->vhost_set_owner(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_set_owner failed");
+        }
+    }
+    return 0;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1550,6 +1577,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
+    hdev->cpr_transfer_notifier.notify = NULL;
 
     r = vhost_set_backend_type(hdev, backend_type);
     assert(r >= 0);
@@ -1650,6 +1678,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    migration_add_notifier_mode(&hdev->cpr_transfer_notifier,
+                                vhost_cpr_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1702,6 +1733,7 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         QLIST_REMOVE(hdev, entry);
     }
     migrate_del_blocker(&hdev->migration_blocker);
+    migration_remove_notifier(&hdev->cpr_transfer_notifier);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa1734..18ce5ea9a0 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -196,6 +196,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_set_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..5d11a97e43 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -133,6 +133,7 @@ struct vhost_dev {
     QLIST_ENTRY(vhost_dev) logdev_entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
     IOMMUNotifier n;
+    NotifierWithReturn cpr_transfer_notifier;
     const VhostDevConfigOps *config_ops;
 };
 

-- 
2.34.1


