Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B468CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE6Q-0002YA-6i; Mon, 15 Jun 2026 16:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6O-0002RL-5R
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6M-0002uu-L0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BND9yUE3GxPUKfjsdV3K95sn9j97eyDe1saK9Z1IW0=;
 b=OPJaJwN8gvcV3S0dSjYjhaQ6ZV9uHDmyOUwk/74vf17qKKiw6Wt8O3ESaq29/9GxIkE823
 eH4v9CGZx7gXeODzSoWA/jknOHjQ6Um93Q8a+D1lmKOAhqtjQeIAUfGkXCe7TBwV6wjAzw
 8aOLz+MSzAVnixxg+yDfhF5Vj3dgRfw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-CnN8Y3poMX6xhnMWoVQdpA-1; Mon,
 15 Jun 2026 16:40:05 -0400
X-MC-Unique: CnN8Y3poMX6xhnMWoVQdpA-1
X-Mimecast-MFC-AGG-ID: CnN8Y3poMX6xhnMWoVQdpA_1781556004
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0ECE180058C; Mon, 15 Jun 2026 20:40:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7DAA3008B37; Mon, 15 Jun 2026 20:40:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:53 +0400
Subject: [PATCH v2 27/53] whpx: convert OnOffSplit property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-27-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SvoSExUYXPg6sVDa5rVzKfXzAc13YDagtIfmWECFwp8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKPYtMkLyBZ+6Aun8V2yVYoQkkOdeHouuzWI
 448uarC6y6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5X/SD/0d2DcwdWdKk4q+RW1gEg/uyU1yrrKMX41U8qZet9Xk5IEZG1eEB3a9Zr7SqhJSFkXAyuA
 Rzvw5ImNE8S2mmSCWiGrueazUUfOqLgEpvwV7bQYVXsyR2WlJePQ4FeyIr3xDbFOLk6WTDlG3fK
 8zOkC7Q9J53g4RJUkS/74F2ogIA+z+HN+P4RZxSI+kK+iHx/h5ju9G/GZJt6CqHHR0N0ILbp1Iu
 sD6kI5dKzPE1jJGCgKKJ4qpO8jM+lnJod8cP60YnMbv/z8Wi664W6YOWZxpL1qTK/7qHS4zNjeq
 Ydq4xSqfQWza87kC2/oY3UM7vI6ptd93R4RwDqnYRMlC1cb2u/yCaNSZHEOH+Zqi4BGwoMzQsvi
 KpXrqwGdmaikdOaDc9HDOEiXFWF9bfqJfHitafPNcqXaKfY1VHe0ZEhd1DLhWpXOApNpIbPcVWV
 RFaXtaP6xK2Lk+shM8eE1FmZaNBVgS9w4e7nJtN0wLfBl69G5nbHtMOx+Hpr34H6HK/ZGp8pwur
 Amqz4h0LDGKnQdCGSSEm49rg98s3LF9AQxgYdduEgrMto6NGZQ1ZrWR5E+/2XcfDRO6+4UZXpDE
 2iaiqK3kKHsWVGBOPdbs+FSSRm7O81ERTBhq0hzapNEByKlilLt+EwXkGI4RU9WlCdFgoUZOO0J
 Brsmrql2rwo4IqQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 accel/whpx/whpx-common.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 187938c02b5..5d4b405e56d 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -434,18 +434,12 @@ error:
     return false;
 }
 
-static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
+static void whpx_set_kernel_irqchip(Object *obj, int value,
+                                    Error **errp)
 {
     struct whpx_state *whpx = &whpx_global;
-    OnOffSplit mode;
 
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
+    switch (value) {
     case ON_OFF_SPLIT_ON:
         whpx->kernel_irqchip_allowed = true;
         whpx->kernel_irqchip_required = true;
@@ -463,11 +457,7 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
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
 
@@ -518,11 +508,12 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
     ac->pre_resume_vm = whpx_pre_resume_vm;
     ac->allowed = &whpx_allowed;
 
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, whpx_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure WHPX in-kernel irqchip");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "kernel-irqchip",
+        .qapi_type = &OnOffSplit_type_info,
+        .set = whpx_set_kernel_irqchip,
+        .description = "Configure WHPX in-kernel irqchip",
+    ));
     object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
         .name = "hyperv",
         .description = "Configure Hyper-V enlightenments",

-- 
2.54.0


