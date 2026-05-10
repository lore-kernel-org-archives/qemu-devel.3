Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E126CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Xa-0002JR-Dv; Sun, 10 May 2026 09:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4XY-00029M-Ek
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4XW-0005eW-N6
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3pBO+XB8waPPvVWGGQ0Oe17o6K78G/MAtURYgwN84I=;
 b=eysxF5Un292/ogq0bt4KJNGfDX7PIp+k/FmBqdDBmo8uUF1f/vpLskylsyGfp4D1TOQNsU
 Pf/vsIS4ySyEolsoReQ4IiYRt1P6d/YlFPnbwrClBjCBiAP1mHTyw4TpVc2E0lk1XJ5CI0
 b+1xUqQFFq6yULApju7eRnms+fewzwc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-AqiqrxLgMuaPQMLcFF1-_Q-1; Sun,
 10 May 2026 09:49:48 -0400
X-MC-Unique: AqiqrxLgMuaPQMLcFF1-_Q-1
X-Mimecast-MFC-AGG-ID: AqiqrxLgMuaPQMLcFF1-_Q_1778420987
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6077D18002CB
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:49:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABAA23002D30; Sun, 10 May 2026 13:49:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:30 +0400
Subject: [PATCH 33/54] accel/hvf: convert OnOffSplit property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-33-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iwbaeAoF/33Kw17kEtq0TnwDPZ2R6UiTQZltouoz2ZI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwZqjsX6NBQDKWUfroFxmWO3D8J7VL1Gv/e
 B12q78XfkqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5YXeEACKiq6b+6XcwYzUwbHcpbWEkD3GgNvrOI1cRAmCcXNRp9rrV/Kst1rpjBeoQchwsMstywL
 iZamoBM2Rz51eP/94IgZjvAq13WgvRX0K/dzDryepMc0SMc0I++uN4nAK5Y3ta7RT2rddHT1yYW
 fRyaNOj5TITqJoDxrar2MGiNoWDVU8V0lmkm5tJpIUYru4ysxBlbOmlUjhj/ORlVf0OZ2oZszDQ
 3jtlJ9CpFmDD2e/uc5UIRJ5tZx8M9hkeHeCP0wJGgUsuiXVME109zsaT+g2abYUnvnhw5wjDjIb
 e6RSOW/UXDFsTeK/M0zPl41+dN3SYX9xSU5W5umSMBDrnk/kA4I3DBByb0aYYnta0mHe6X5TMCA
 JdddhFkVe9e9lTF27ycHmw8Du7ihxp0lSMzMxZBBZU6zf4nhN7WaupP+2HElo7WJctdqhJJmhpz
 6IiDbR9t75/fywJt665nKEfCq5X4jOaGmoQncUawDEBk67krk28Uq7MGdG0YMTLSFuA7LV8Q4Bw
 FmIr79+60IpOT8AsOZOxJfqUXwVx0V/Gy4/FxXUxF3jh1zIgkPcwJQEDwGp+dUaXtyfifl5JoUd
 vOvokWRyjpU74Sv7HNOlHcdMtzoz1TKst6YqNu3wIkFOP8VsMgkWMIF4MZM+k4KonECfbr5R8rA
 b5wc6vV7CfrJBbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 accel/hvf/hvf-all.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 946dbca59d0..982072d17ea 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "accel/accel-ops.h"
 #include "exec/cpu-common.h"
@@ -233,18 +234,12 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
     return SSTEP_ENABLE | SSTEP_NOIRQ;
 }
 
-static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
+static void hvf_set_kernel_irqchip(Object *obj, int value,
                                    Error **errp)
 {
-    OnOffSplit mode;
-
     hvf_kernel_irqchip_override = true;
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
 
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
 #ifdef HOST_X86_64
         /* macOS 12 onwards exposes an HVF virtual APIC. */
@@ -264,11 +259,7 @@ static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
         break;
 
     default:
-        /*
-         * The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
+        g_assert_not_reached();
     }
 }
 
@@ -281,11 +272,13 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
     ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
     hvf_kernel_irqchip_override = false;
     hvf_kernel_irqchip = false;
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, hvf_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure HVF irqchip");
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = hvf_set_kernel_irqchip,
+        .description = "Configure HVF irqchip",
+    ));
 }
 
 static const TypeInfo hvf_accel_type = {

-- 
2.54.0


