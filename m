Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B523AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WHt-00011N-2L; Thu, 02 May 2024 09:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHq-0000ya-MF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHo-0003VM-S7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714655743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRhTL59lsMRXTLWXvlCyCB/kuFdN39oX2TwZHEnGiG0=;
 b=M0UmqHc/flxop3H2C4roY4ll5Xgovu6B+kO+v/NIKBI/jJlo95lzuuWkYXXJvzyXZ9hKld
 Tf+DeIU7r9+FPWGLgV/0ixbV2QL5MAw2I+Xue+gJCpnpWnVzyX7xAUde0q/RggkY+YyLZe
 ThpwrugLW8mKSIaUOfKfXmHmW62NYjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Sx8q9wgRMw-DTSWyYwf3pQ-1; Thu, 02 May 2024 09:15:39 -0400
X-MC-Unique: Sx8q9wgRMw-DTSWyYwf3pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6813101152C;
 Thu,  2 May 2024 13:15:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE0131C0666B;
 Thu,  2 May 2024 13:15:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/3] s390x: Introduce a SCLPDevice pointer under the machine
Date: Thu,  2 May 2024 15:15:31 +0200
Message-ID: <20240502131533.377719-2-clg@redhat.com>
In-Reply-To: <20240502131533.377719-1-clg@redhat.com>
References: <20240502131533.377719-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Initialize directly SCLPDevice from the machine init handler and
remove s390_sclp_init(). We will use the SCLPDevice pointer later to
create the consoles.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/sclp.h            |  2 --
 hw/s390x/s390-virtio-ccw.c         |  6 +++++-
 hw/s390x/sclp.c                    | 10 ----------
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index c1d46e78af8524802225fb192ffd9f6a5bc4434e..7605d06bff18a6075728f3bb462284eaf211b3cb 100644
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
index b405a387b6780ea8f11a062fc02296f633171676..d32f6180e0d3e7ecca09e97ce4b9740360a69692 100644
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
index 726c2ab4363be30fe6b674d1ee697bb7d2e6352d..159f67d05c1e534800427ce46afcdaa526fd5902 100644
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
index 893e71a41b2ddd88a007bd7d395895fc4d444540..d236dbaf0bdd15c3fc07749a98a5813e05cfb9a1 100644
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
2.44.0


