Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AB3D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwq-0007So-VV; Wed, 03 Dec 2025 13:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwp-0007RK-Sg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwn-0000zX-LE
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B3IgRqW274411; Wed, 3 Dec 2025 18:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=ljRmB77NnqAdrgPEzQrr268ITHscsnHq1PoRVyI/Pzk=; b=PdQGilVoAKBs
 uZelBYn2NQyhZ9E4p5Y197cGB6Xo51/7pLjJsVhFl2UvmqFhi8mMvcE4zwhNhe+j
 kl+/wYe5Evg7lux92HjOC4c9Oz1FzJThjWAxehTeFtbWpA6/VZPzbO2Q8WAF2yGg
 6m7bYWzm8EDY7opnq2UkYZRqqy07kEwWix0VVYkS/s4MxED+PMQWoq9WZ1Xj/6m3
 jfvb2zYviLhmKuIBwj8NW5OtcUtHS1diCJJX+3migRnsp3ceR4Pl1pfLpnykoD9U
 qzkyB/Q2dljfK6pJ54zHuL6R8pwvfA6Zez3GbaBIonMg6auCUx6/S39C5NJ7yKrW
 j8GdTu/VjA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4atm5s6d01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3FZraq026859; Wed, 3 Dec 2025 13:51:26 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4aqw21kxw3-1;
 Wed, 03 Dec 2025 13:51:26 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id A91DF97;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:20 -0500
Subject: [PATCH v3 3/8] vhost: reset vhost devices for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-3-3c12e0a61f8e@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=5230;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=6kTSGt3ELi899SPi+eJ4MTXel5sLxi3unzD950w6j/M=;
 b=2vhlu4zmfRGEftDje4PhskkfZjP3zx3oOQARS8sNrREatZVToDTYrrzWyXmx/RE4MbvmWxQjM
 ZJrTmfATuGfBqoiBKL5EtDV3rWBnbm4+QGMCjJJ+spjwCYa15YekUHP
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-GUID: RVkisURAx_c3pRunJDSZVbm65r6TfD-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfX2sKSOrMead+G
 d7JCGWZ9kh43d7SmEygI9fwOegwJ/jUBkNK+eor7ORIW88HwBQAojilIEICahZGAJEWKkztR6Fp
 jLgl/iUNVTc5ZTaZJAt5f1QYEU/zA4Aw+WPQ+gUcPvCaxW83ErYAhy56nK3kyG+qkJmcQSxh2c5
 ZwK2O7opZn5+VKyO+gukV/86PAVcjZd4PdtMTzO7SNN9YIj8VaDCutdd2kpF53yrhxNQYsG7l6f
 7s2bGvRY/KJyJmMSmiqrbpLlPK3I8l1Km/UnXlf7eQ5x9vV91pwtr94BkzQSNBRhePbJi6V8iYY
 Mt7iIFLN9/v70fuiYc2q9KCaP+tl/xIcpj52wqAojJPCbxgQfMzkAyrFQipGIqqZOY2mKSnT/ym
 yb0s/iKIONgSGEtcwpOCOOOWaWj+dg==
X-Authority-Analysis: v=2.4 cv=VdH6/Vp9 c=1 sm=1 tr=0 ts=693086b0 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=6lTwf2g7YyX0f-ifu7AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RVkisURAx_c3pRunJDSZVbm65r6TfD-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
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


