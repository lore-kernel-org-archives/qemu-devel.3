Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB5FCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWkV-0007LK-Fh; Fri, 05 Jun 2026 11:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkM-0006aF-W5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWkL-0006d4-Iy
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ChO/3Bdzy1ataNflAM07S9oKMcRpR+opteLb5ymzCsk=;
 b=GVTMT6jRURzoykpzO0S6N674Sr5ytC7ptqguS3ikA58RMVT/ykRYszTPYX9caqcH/5ERxu
 v5d6/P2Ru1tKi1y1tYRkAL6nIMweW6pZHT4BIotDOMOhFlT7Fiq0JQ08ov/KoTVRfP2YKJ
 n4z86djfE9tHlUKOZr1TWkG46VwJ7iY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-Dc2Z6PHfP1ig6irMCI3kIQ-1; Fri,
 05 Jun 2026 11:46:06 -0400
X-MC-Unique: Dc2Z6PHfP1ig6irMCI3kIQ-1
X-Mimecast-MFC-AGG-ID: Dc2Z6PHfP1ig6irMCI3kIQ_1780674364
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A651956048
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:46:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ADB11955BC0; Fri,  5 Jun 2026 15:46:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:38 +0400
Subject: [GIT PULL 18/23] hw/loongarch/virt: free flash devices and OEM
 strings on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-18-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O20pvfV7LycxXxxIqAxpoTODskHXvK4B1EMEAyeU4tk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7VlXqs2qHYpT4ogNa1eS5veskmiP/8c2KGd
 mswqj1ZP+6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1QAKCRDa6OEJdZac
 5SEAEAC4wiToxbC1E5cEHBHWcqrLbJl1ZyxUf0HAQpiun9gdqHqM75xbngL2DPbLLdZ9VANKb8g
 J13KAOZKkF00L201v3JnXR4L44dRawln8GZBe2tlhkUWh56zKWe/DGaKAnNuPqYpvkj2B3o0sMq
 R9m7LGnfkp0bN+qFx3up4GHQa9rdz9TPjMCpyG1WI17YB+aWC5JrNpRD99sBsNyMnVjU3fR2z0C
 wmMbq5C2MaHZznV3yGRzzcPEjAIq0IRI7NLubPLi0/z2O3Edr6bHx0lSO4LWLo17E4ucAdXcxoI
 oATUg57wAlKObyGJyTXG7zBJFsLQncdQ3qv80YKUFd/bt12Y6AIF2yGF78nDrkTt07uEnY00zmF
 e6rdOMiKw66jI9mL4Kasj1Gfr3YO4qNRNMZ4iD8TRse/65BvFf1+8AVWWYQjOBmqsNf7avIT0uv
 5bkKbbpUjod6W2TfABB1xFwK5LnkiyhUA1tzXXRXYJS0skcUXb0/z2HocBuyigjqVEVvf+jEV79
 qXz4wA80ZGkgMZwA/YaXk9lA9BWNfW6by68XPMg+RIdEZmhkL7RpDKjdy7mBmsEZU11Sl3cFV5I
 lNliOunFXVFyo2TtGlemAaco/p6lfxQ6Q4JZk4zxkQDRm78D8VrRv5AEyI9iQPBrrVq5OyRnMAO
 1Od6lrWlKLe1H4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Flash devices created in virt_initfn() via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 445c9c645 ("hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/loongarch/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f68ccdb12b7..6693dea647b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1566,6 +1566,19 @@ static void virt_class_init(ObjectClass *oc, const void *data)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_VERSION(false, major, minor)
 
+static void virt_instance_finalize(Object *obj)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(lvms->flash); i++) {
+        if (lvms->flash[i] && !qdev_is_realized(DEVICE(lvms->flash[i]))) {
+            object_unref(OBJECT(lvms->flash[i]));
+        }
+    }
+    g_free(lvms->oem_id);
+    g_free(lvms->oem_table_id);
+}
+
 static const TypeInfo virt_machine_info = {
     .name           = TYPE_LOONGARCH_VIRT_MACHINE,
     .parent         = TYPE_MACHINE,
@@ -1573,6 +1586,7 @@ static const TypeInfo virt_machine_info = {
     .instance_size  = sizeof(LoongArchVirtMachineState),
     .class_init     = virt_class_init,
     .instance_init  = virt_initfn,
+    .instance_finalize = virt_instance_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }

-- 
2.54.0


