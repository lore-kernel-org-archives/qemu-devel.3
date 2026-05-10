Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D96CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4WS-0007In-Fc; Sun, 10 May 2026 09:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4WQ-00073w-Hv
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4WO-0005PK-Uq
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWwxkLE91xXofymgFvGI+w9Kgvt7VkkQKMY2pY7orTU=;
 b=Rsd9qm/g7n67SlpSxrMJi1yRYKloUc6uxBxgnXZuS0qKJm1HBkDNskrQdEzAyYp0QbM6FH
 R8Wp9dSZw6MVrL2S9bL8pYL55xoBncX9ZvzgvWiR/WzlwDU2QFEU2rVirrKv0NrzCkN1r+
 w1khIwgsBz6vC93YrmJ6arfHEi9HOKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-kxOCISNzNRCYS5az5thCOQ-1; Sun,
 10 May 2026 09:48:38 -0400
X-MC-Unique: kxOCISNzNRCYS5az5thCOQ-1
X-Mimecast-MFC-AGG-ID: kxOCISNzNRCYS5az5thCOQ_1778420917
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1028195608B
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:48:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18A6819560A6; Sun, 10 May 2026 13:48:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:23 +0400
Subject: [PATCH 26/54] accel/kvm: convert OnOffSplit property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-26-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1C5Es6ei64bnxBu+6I2DyhEV4JA9pADA42542Q0T2jY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvFtT7jDWgmd0qyt0mhsmEkIfRZhmoKTAH7
 kmkZcQLxIOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5YxAD/4heKCOXgE7BDbtXcNWTzApUn7LSSyu6AE61P8cQbXaGqJF/ROw/2xOCY5xL184Q+E38/F
 X85l165Ix9AqQWeNizJo04fqkO9rWDwWnyNpO7roKA+V5/JqETnxURExQ0TbgZqESyZdqACpLAC
 qt0KP00KpmKavBZzK0/5s0IANjerZQ3KFK6ribo3CcD0Sok4VDl2peytWTIsCEeU0zEsYwMGRDe
 0QdUPEtPt5NKd+tcHQWbUFrdsokG9px+3+aihYilh7tPoozIvrHbZW4Ktb7DlMYHBQhxAX/nq3D
 q4/7VRSN4CKP9CmsWO4hhKf0jyQWCtEANVPGaw5utV0wP5wB5RerBHWq1JHMToO7V8cpX59fF/y
 fb/0jFt2pM4yjBpPfUqsurdxWbC26bQ9WLmfnGguGUCP0q01ReTIkG+/FvuxXidn9dr7ADEzSc+
 bs6EPSFKOMhm9yF7vuDvL+Hz5bvr7ibAVxNaSyVUeDmqsY0xja5h15pa1A3O0ipRsKETMaNThaz
 TRprrhB96omoaxDravaIbniUzKF4x694/RVlyC3quZS4S/xi3AXrE/a21oS0rrgpIpDXyGQpR2H
 N2yozY1XWHU9wy93g8dAJwRhX1iZ5N7DGH6jP/Kc3oTiIEDcGv/80t0fCS+eyokqiLdNjuDQtqt
 JaVY8p95aeW0fcQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the OnOffSplit property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b1..94b64cde621 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -46,6 +46,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "system/reset.h"
 #include "qemu/guest-random.h"
 #include "system/hw_accel.h"
@@ -4142,22 +4143,17 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
     s->kvm_shadow_mem = value;
 }
 
-static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
+static void kvm_set_kernel_irqchip(Object *obj, int value,
                                    Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
-    OnOffSplit mode;
 
     if (s->fd != -1) {
         error_setg(errp, "Cannot set properties after the accelerator has been initialized");
         return;
     }
 
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
         s->kernel_irqchip_allowed = true;
         s->kernel_irqchip_required = true;
@@ -4174,10 +4170,7 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
         s->kernel_irqchip_split = ON_OFF_AUTO_ON;
         break;
     default:
-        /* The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -4306,11 +4299,12 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     ac->allowed = &kvm_allowed;
     ac->gdbstub_supported_sstep_flags = kvm_gdbstub_sstep_flags;
 
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, kvm_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure KVM in-kernel irqchip");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = kvm_set_kernel_irqchip,
+        .description = "Configure KVM in-kernel irqchip",
+    ));
 
     object_class_property_add(oc, "kvm-shadow-mem", "int",
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,

-- 
2.54.0


