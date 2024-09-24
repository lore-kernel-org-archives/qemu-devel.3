Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D52CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Oj-0002fO-9k; Tue, 24 Sep 2024 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2Oe-0002OU-Ks
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2Oc-00031J-1O
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2IDiSamtAByTwgpGdjxSi/FBBtUd2seIfGTvKxQCK0=;
 b=ck7MUXTfQzG1fo89lv0UUwHxniM++ftfQDYT7lYj7D9aP0x27MezE0h2ak5ULqNg5t2HDV
 /rnUtZ3riAaGlsKZZe2xBh3h+iZjoecsbOYwGn5VUSJ3LnPWABUtHFmOBnfUpqndIeeYRO
 stNYdkUAIoW4/yxvs6dywvidI5EieM8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-KENoicgvOMue-dH5xfliJw-1; Tue,
 24 Sep 2024 06:03:48 -0400
X-MC-Unique: KENoicgvOMue-dH5xfliJw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D87C1903088; Tue, 24 Sep 2024 10:03:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97C491956048; Tue, 24 Sep 2024 10:03:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 5/6] virtio-mem: Add support for suspend+wake-up with plugged
 memory
Date: Tue, 24 Sep 2024 12:03:28 +0200
Message-ID: <20240924100329.248738-6-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
References: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Before, the virtio-mem device would unplug all the memory with any reset
of the device, including during the wake-up of the guest from a
suspended state. Due to this, the virtio-mem driver in the Linux kernel
disallowed suspend-to-ram requests in the guest when the
VIRTIO_MEM_F_PERSISTENT_SUSPEND feature is not exposed by QEMU.

This patch adds the code to skip the reset on wake-up and exposes
theVIRTIO_MEM_F_PERSISTENT_SUSPEND feature to the guest kernel driver
when suspending is possible in QEMU (currently only x86).

Message-ID: <20240904103722.946194-5-jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 10 ++++++++++
 hw/virtio/virtio-qmp.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 484d3a5a54..ae1e81d7ba 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -890,6 +890,9 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
         virtio_add_feature(&features, VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE);
     }
+    if (qemu_wakeup_suspend_enabled()) {
+        virtio_add_feature(&features, VIRTIO_MEM_F_PERSISTENT_SUSPEND);
+    }
     return features;
 }
 
@@ -1848,6 +1851,13 @@ static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
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
2.46.1


