Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81C5C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Hb-0003n7-BN; Fri, 11 Sep 2026 12:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54HZ-0003kL-Qs
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54HY-0006eJ-6X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgmINsOfsOg8avUK0DI3pyw4m6ampH+tq1kvfcER51g=;
 b=K3GTM18xcvIG1hKdNfD16AZgLHGkcbcbHl5oaCYEZGECIiX52A/4zuzfUPFjZInQGzfqK4
 sbGaQYB09OOdjfQiCp4RP5el1MThWPDltGl4aCKMRJDtmhUWNVP99xfIh94GExIJnZoPk1
 GonHFRPCfho7YGpRv4XXiwD4Ov77ddQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-dnq8je54PB2dsVgNJhC7Bg-1; Fri,
 11 Sep 2026 12:39:16 -0400
X-MC-Unique: dnq8je54PB2dsVgNJhC7Bg-1
X-Mimecast-MFC-AGG-ID: dnq8je54PB2dsVgNJhC7Bg_1789144755
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950951800671; Fri, 11 Sep 2026 16:39:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45504195608F; Fri, 11 Sep 2026 16:39:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:03 +0400
Subject: [PATCH v5 29/62] whpx: convert OnOffSplit property to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-29-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=65zE86SlpLyxllbMtWWTTzs6HGNGESGG/p9K0JvZjvc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC25s1fgeJxREGDJLbqxKzdTHOLfwdwbZ9q5i
 Or2N+r8aPCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuQAKCRDa6OEJdZac
 5Xk3D/4ryGv9rx03Qbh2ijMmJDadeAn1KByzyeT+DZwhbf/1KTRk9s5TvWBueRYxPZBOShJCBcC
 xSBGMTpQ4wcwXy2B5oZj5MhZ4ioF962NOmwQl0J5jyFtDFwwWP/wKBzAJL/H3NbMLYKB+ckEaS9
 B7DscwIDeaenpyk4umK2BEVgCZsjTmncYMCrD0z0AB8J0FtFBfUFjB/f7CzVa1doEnWy6SnE4b/
 vSPsrdkyP6MP+VB8QPFIqD8MPjFUHxdsJ7svh+nIT0ufeePmIOsGyhB2T+qv7XKPlHVo/40aH5z
 nPuG1YXPYyGRGK3HWPgRXBEVH7sQzJWPYCo81rWRRkd91WVEig70q9yYsO4dh6KtFRNGQznUK9T
 v0r4ffG1CD/1jlLmcTrCt8CPeqJPm9PGLC7od6nPpIY252E9JdOmwlEEJSeW9YQ0BGojYK2xAuj
 VrKc0kbBtRb3TrcgVC1lnjYzIlBmDCec0/4/VU7F9QoTmS/aWxzvU68vXrHnp4WOtx1x0c/BMsT
 Tyg5tJQ6s1+GrCtienYC+Wn/w7yeKVz8ni0OkpIYadp9PNDoy9xNAwP5LImPXFzY2c/SSqZ8jEx
 RIA7kJ4JOL0DU6k+kcaNEIlP+BgkAUrWye0lidftRy60pNppCM2agnng9xVWcgRLA2V2gxn5VaR
 vJ9NBsN/gPyLcjw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 187938c02b51..5d4b405e56d3 100644
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
2.55.0.543.g5ebe2ebe4ea8


