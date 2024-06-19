Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B54AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwYG-0007t1-4u; Wed, 19 Jun 2024 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJwYD-0007rv-Og
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJwYB-0005fC-Qh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718808278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c9QG8td8OJzqVsZj1ZAdo6ySqv2jMpAVszHcQa1tvzo=;
 b=afzDZgP3InFDxcVsb4uUaMeT+tCuVmxJlAtWMccWQz5dUIi6PI4unq6OYLqms/Cv2+4EFz
 YgFsIvk8hZhHzOEb2CknBrPAmPv85P0ohd+hBgEigB6RR7yWVdDF/vnCy0mwmye/x1iOfs
 i7JX6mM5nsV7uCoyo6AaY4lq9r94d1w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-cv8A2wTzPb-bjh2H4Bsxag-1; Wed,
 19 Jun 2024 10:44:35 -0400
X-MC-Unique: cv8A2wTzPb-bjh2H4Bsxag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 134771955E77; Wed, 19 Jun 2024 14:44:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.145])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38E7A30030E2; Wed, 19 Jun 2024 14:44:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH] hw/intc/s390_flic: Fix interrupt controller migration on
 s390x with TCG
Date: Wed, 19 Jun 2024 16:44:21 +0200
Message-ID: <20240619144421.261342-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Migration of a s390x guest with TCG was long known to be very unstable,
so the tests in tests/qtest/migration-test.c are disabled if running
with TCG instead of KVM.

Nicholas Piggin did a great analysis of the problem:

"The flic pending state is not migrated, so if the machine is migrated
 while an interrupt is pending, it can be lost. This shows up in
 qtest migration test, an extint is pending (due to console writes?)
 and the CPU waits via s390_cpu_set_psw and expects the interrupt to
 wake it. However when the flic pending state is lost, s390_cpu_has_int
 returns false, so s390_cpu_exec_interrupt falls through to halting
 again."

Thus let's finally migrate the pending state, and to be on the safe
side, also the other state variables of the QEMUS390FLICState structure.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Once this has been merged, we can enable the migration-test again
 with Nicholas' patch here:
 https://lore.kernel.org/qemu-devel/20240525131241.378473-3-npiggin@gmail.com/

 include/hw/s390x/s390_flic.h |  1 +
 hw/intc/s390_flic.c          | 75 ++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-virtio-ccw.c   |  5 +++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
index 382d9833f1..4d66c5e42e 100644
--- a/include/hw/s390x/s390_flic.h
+++ b/include/hw/s390x/s390_flic.h
@@ -116,6 +116,7 @@ struct QEMUS390FLICState {
     uint8_t simm;
     uint8_t nimm;
     QLIST_HEAD(, QEMUS390FlicIO) io[8];
+    bool migrate_all_state;
 };
 
 uint32_t qemu_s390_flic_dequeue_service(QEMUS390FLICState *flic);
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 6771645699..a91a4a47e8 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -361,15 +361,77 @@ bool ais_needed(void *opaque)
     return s->ais_supported;
 }
 
+static bool ais_needed_v(void *opaque, int version_id)
+{
+    return ais_needed(opaque);
+}
+
+static bool qemu_s390_flic_full_state_needed(void *opaque)
+{
+    QEMUS390FLICState *s = opaque;
+
+    return s->migrate_all_state;
+}
+
+static bool qemu_s390_flic_state_needed(void *opaque)
+{
+    return ais_needed(opaque) || qemu_s390_flic_full_state_needed(opaque);
+}
+
+static const VMStateDescription vmstate_qemu_s390_flic_io = {
+     .name = "qemu-s390-flic-io",
+     .version_id = 1,
+     .minimum_version_id = 1,
+     .fields = (const VMStateField[]) {
+         VMSTATE_UINT16(id, QEMUS390FlicIO),
+         VMSTATE_UINT16(nr, QEMUS390FlicIO),
+         VMSTATE_UINT32(parm, QEMUS390FlicIO),
+         VMSTATE_UINT32(word, QEMUS390FlicIO),
+         VMSTATE_END_OF_LIST()
+     },
+};
+
+static const VMStateDescription vmstate_qemu_s390_flic_full = {
+    .name = "qemu-s390-flic-full",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = qemu_s390_flic_full_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(pending, QEMUS390FLICState),
+        VMSTATE_UINT32(service_param, QEMUS390FLICState),
+        VMSTATE_QLIST_V(io[0], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[1], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[2], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[3], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[4], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[5], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[6], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_QLIST_V(io[7], QEMUS390FLICState, 1,
+                        vmstate_qemu_s390_flic_io, QEMUS390FlicIO, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription qemu_s390_flic_vmstate = {
     .name = "qemu-s390-flic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = ais_needed,
+    .needed = qemu_s390_flic_state_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(simm, QEMUS390FLICState),
-        VMSTATE_UINT8(nimm, QEMUS390FLICState),
+        VMSTATE_UINT8_TEST(simm, QEMUS390FLICState, ais_needed_v),
+        VMSTATE_UINT8_TEST(nimm, QEMUS390FLICState, ais_needed_v),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_qemu_s390_flic_full,
+        NULL
     }
 };
 
@@ -383,11 +445,18 @@ static void qemu_s390_flic_instance_init(Object *obj)
     }
 }
 
+static Property qemu_s390_flic_properties[] = {
+    DEFINE_PROP_BOOL("migrate-all-state", QEMUS390FLICState,
+                     migrate_all_state, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     S390FLICStateClass *fsc = S390_FLIC_COMMON_CLASS(oc);
 
+    device_class_set_props(dc, qemu_s390_flic_properties);
     dc->reset = qemu_s390_flic_reset;
     dc->vmsd = &qemu_s390_flic_vmstate;
     fsc->register_io_adapter = qemu_s390_register_io_adapter;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cd063f8b64..f87ca36264 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -863,8 +863,13 @@ static void ccw_machine_9_0_instance_options(MachineState *machine)
 
 static void ccw_machine_9_0_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_QEMU_S390_FLIC, "migrate-all-state", "off", },
+    };
+
     ccw_machine_9_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(9_0, "9.0", false);
 
-- 
2.45.2


