Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A264BC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 16:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbMla-0000Ui-Nb; Tue, 06 Aug 2024 12:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbMlO-0008GT-TF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sbMlL-000366-O5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 12:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722960609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2WMu9lnCNzsVzNnuFMls45e0qsZBUGL2IWt/5pGpaw=;
 b=jLGurV8piMzeK2aUHx1EtPTbTMNpvf42Av8fka+6+btcg/CtFn6ZjDkSSOouxACXjZFzQD
 6Sv9mvc2bVVx5Jy/E+5JW/yWYuhSbb6fFI4VbnX33skqklBz4MwJ8jltMs8uABz64vXfJK
 8H2dMG2stFEPsFUeYbW2/TxzJwpsVUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-KYGQfRnWOSGsB8rA0e2dLA-1; Tue,
 06 Aug 2024 12:08:08 -0400
X-MC-Unique: KYGQfRnWOSGsB8rA0e2dLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 486B11955D52; Tue,  6 Aug 2024 16:08:07 +0000 (UTC)
Received: from rh-jmarcin.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED74E1955D42; Tue,  6 Aug 2024 16:08:05 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/4] virtio-mem: Add support for suspend+wake-up with plugged
 memory
Date: Tue,  6 Aug 2024 18:07:54 +0200
Message-ID: <20240806160756.182524-5-jmarcin@redhat.com>
In-Reply-To: <20240806160756.182524-1-jmarcin@redhat.com>
References: <20240806160756.182524-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Before, the virtio-mem device would unplug all the memory with any reset
of the device, including during the wake-up of the guest from a
suspended state. Due to this, the virtio-mem driver in the Linux kernel
disallowed suspend-to-ram requests in the guest when the
VIRTIO_MEM_F_PERSISTENT_SUSPEND feature is not exposed by QEMU.

This patch adds the code to skip the reset on wake-up and exposes
theVIRTIO_MEM_F_PERSISTENT_SUSPEND feature to the guest kernel driver
when suspending is possible in QEMU (currently only x86).

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 hw/virtio/virtio-mem.c | 10 ++++++++++
 hw/virtio/virtio-qmp.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 4f2fd7dc2e..d373eb0028 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -883,6 +883,9 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
         virtio_add_feature(&features, VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE);
     }
+    if (qemu_wakeup_suspend_enabled()) {
+        virtio_add_feature(&features, VIRTIO_MEM_F_PERSISTENT_SUSPEND);
+    }
     return features;
 }
 
@@ -1841,6 +1844,13 @@ static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
 {
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
 
+    /*
+     * When waking up from standby/suspend-to-ram, do not unplug any memory.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
     /*
      * During usual resets, we will unplug all memory and shrink the usable
      * region size. This is, however, not possible in all scenarios. Then,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 1dd96ed20f..cccc6fe761 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -450,6 +450,9 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
     FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
             "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
             "accessed"),
+    FEATURE_ENTRY(VIRTIO_MEM_F_PERSISTENT_SUSPEND, \
+            "VIRTIO_MEM_F_PERSISTENT_SUSPND: Plugged memory will remain "
+            "plugged when suspending+resuming"),
     { -1, "" }
 };
 #endif
-- 
2.45.2


