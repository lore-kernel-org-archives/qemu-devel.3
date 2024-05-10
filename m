Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BA9C25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Jvp-0001AW-CM; Fri, 10 May 2024 02:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvR-00015W-4Z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JvO-0001X9-Dl
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IMt1Iki+bGdU0k9hfLiLzd7efUNV5kkdo6ol/E5A5Y=;
 b=XwhjGJFx5V8pKXXQhzjlg+EcRDLYuun1ZEa00T0j1jVZEKujGMFsuIs9snU4qWLEQLFnd6
 kvduTpBzqetWaihravtbXQ1UWRt17oFl37E7uf0kyVMwKqO1WMVQ74VM019ZJfHsnHQF0q
 huSNhJsgkY5PAi0pkVG5gMInTdP7Wbs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-GTH30Qg8Owe6FbaVklMCkw-1; Fri, 10 May 2024 02:40:07 -0400
X-MC-Unique: GTH30Qg8Owe6FbaVklMCkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F64D801211;
 Fri, 10 May 2024 06:40:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA8722079B08;
 Fri, 10 May 2024 06:40:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/8] s390x: Introduce a SCLPDevice pointer under the machine
Date: Fri, 10 May 2024 08:39:55 +0200
Message-ID: <20240510064001.26002-3-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Initialize directly SCLPDevice from the machine init handler and
remove s390_sclp_init(). We will use the SCLPDevice pointer later to
create the consoles.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240502131533.377719-2-clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/sclp.h            |  2 --
 hw/s390x/s390-virtio-ccw.c         |  6 +++++-
 hw/s390x/sclp.c                    | 10 ----------
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index c1d46e78af..7605d06bff 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -13,6 +13,7 @@
 
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "hw/s390x/sclp.h"
 
 #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
 
@@ -28,6 +29,8 @@ struct S390CcwMachineState {
     bool dea_key_wrap;
     bool pv;
     uint8_t loadparm[8];
+
+    SCLPDevice *sclp;
 };
 
 #define S390_PTF_REASON_NONE (0x00 << 8)
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index b405a387b6..d32f6180e0 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -221,8 +221,6 @@ static inline int sccb_data_len(SCCB *sccb)
     return be16_to_cpu(sccb->h.length) - sizeof(sccb->h);
 }
 
-
-void s390_sclp_init(void);
 void sclp_service_interrupt(uint32_t sccb);
 void raise_irq_cpu_hotplug(void);
 int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 726c2ab436..159f67d05c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -251,11 +251,15 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
 static void ccw_init(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     int ret;
     VirtualCssBus *css_bus;
     DeviceState *dev;
 
-    s390_sclp_init();
+    ms->sclp = SCLP(object_new(TYPE_SCLP));
+    object_property_add_child(OBJECT(machine), TYPE_SCLP, OBJECT(ms->sclp));
+    qdev_realize_and_unref(DEVICE(ms->sclp), NULL, &error_fatal);
+
     /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine->ram);
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 893e71a41b..d236dbaf0b 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -378,16 +378,6 @@ void sclp_service_interrupt(uint32_t sccb)
 }
 
 /* qemu object creation and initialization functions */
-
-void s390_sclp_init(void)
-{
-    Object *new = object_new(TYPE_SCLP);
-
-    object_property_add_child(qdev_get_machine(), TYPE_SCLP, new);
-    object_unref(new);
-    qdev_realize(DEVICE(new), NULL, &error_fatal);
-}
-
 static void sclp_realize(DeviceState *dev, Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
-- 
2.45.0


