Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E508CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4Wl-0008Ua-Kh; Sun, 10 May 2026 09:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Wa-00082r-J9
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4WX-0005QQ-WE
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BND9yUE3GxPUKfjsdV3K95sn9j97eyDe1saK9Z1IW0=;
 b=TAcyr4uhp8o+LFU1z3a1btZpKRyig4k3xEggKrcfZdhkLH4Cx2eTlmH+wuNSlqjBuqauCd
 aSPHuoBLfF584mkVKvqX4LXApnFdyeDERME8wBGVKr1bA+JGnIUFUjDXL+kcnOgIWeoJj0
 75Vx4O6qnmsAzXZXqa8Dnw4sBVNkL2M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-xptvokV2OzWBYgXcVzmBMg-1; Sun,
 10 May 2026 09:48:47 -0400
X-MC-Unique: xptvokV2OzWBYgXcVzmBMg-1
X-Mimecast-MFC-AGG-ID: xptvokV2OzWBYgXcVzmBMg_1778420927
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE95419560BB
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:48:46 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54B3E19560A6; Sun, 10 May 2026 13:48:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:24 +0400
Subject: [PATCH 27/54] whpx: convert OnOffSplit property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-27-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SvoSExUYXPg6sVDa5rVzKfXzAc13YDagtIfmWECFwp8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItveMqrfVIU/Eix9gwEk2txaSX6nIc77kP9R
 sOxiT1KSmuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5UIsEAClL15ukfKZcv9gvdyDGb1n4cebPxryvugoIboXjRR1crRFy4wsEJJ8CyPtJEgzFt2ZhuK
 yAgicIX0mm3JK/9fr6LR7K+DigofI0q+ysxAmbhgm6hTlevMcZ3IbmBgHgT/AgPFdvMAbUgNM7G
 yfc5Ho6uhD7JuAU95uFVGQ2KC5NBBz96NUsGLne6HGaczvTHHNQv9vjn3/JtDeeua85DbXzgNoD
 3VlNcCUxd32nHXMgYwyE23Z/rp5nODykgjoN3nYcrCLox7nX1UY5VtA/QnWm02xCqvRwGFYaVg2
 NFaANeTqEMv09QgonhOCE1DJ6T5S3NbFoDvnLsHwRBBXUDP2I9XLEiTk93hbl62opYbachtOAAW
 ApGGMSOe6RMOWCX7K8sD8lIsBb9nDStlgKLtTLiZ2s+++RMJJ99b1iGMRmiK/6Iw6LQeVwI5nsw
 BoCSmFwFJC/jX77zrElwk3tk9sbKZGv0zITLqGvzJFoxuy5BeQSZr/0X3fBl9IivGuy8R7JQ52D
 tXDbFp38nngLBTDGI/sdLuv4yfFFgy91EQ/C6n2Cism/RDs7wHBUCjDDw56AUuj58qmfTiDFVqQ
 ElI42ICnj4ORGws2zBE7qPN4/WWSwm7fQVNDvHkQpNWZbK+UnNJdSNZ1iiHaOLrQNFBcjOy+/Si
 68KrorE0crdvmRg==
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


