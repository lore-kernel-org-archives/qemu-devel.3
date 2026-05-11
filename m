Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA71CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX9w-0007IX-Bc; Mon, 11 May 2026 16:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9p-00075E-Bn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9l-0002Mc-2U
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQy+NU8C0RinKCdFv+xlIMSg10VBOsE5SofX/O6Ilz8=;
 b=MbyawPOoVQY8WfaDILd17vFmgq42Vc4vzIoKSl7eeOd0yujG4bA63xnvf1orXvIZC5Z4jw
 JZ359JjUFILDjQnYcIs69zJW5tsXN7jsFok8lJbHFlzTQHSKZgEHJSMl0mrHXnP40vHrbZ
 urTBv/3SvVW9d5PC+ivTQ2wsRWSda2s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-SkfVHJAdMti97mV7ht17Cw-1; Mon,
 11 May 2026 16:23:07 -0400
X-MC-Unique: SkfVHJAdMti97mV7ht17Cw-1
X-Mimecast-MFC-AGG-ID: SkfVHJAdMti97mV7ht17Cw_1778530986
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 378A519560B4; Mon, 11 May 2026 20:23:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD6461803A8E; Mon, 11 May 2026 20:23:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 20/24] hw/arm/virt: free flash devices and OEM strings on
 finalization
Date: Tue, 12 May 2026 00:21:06 +0400
Message-ID: <20260511202111.3091440-21-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Flash devices created in instance_init via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 602b458201ff ("acpi: Permit OEM ID and OEM table ID fields to be changed")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 10b19543826..b090233893c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4321,6 +4321,19 @@ static void virt_instance_init(Object *obj)
     cxl_machine_init(obj, &vms->cxl_devices_state);
 }
 
+static void virt_instance_finalize(Object *obj)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(vms->flash); i++) {
+        if (vms->flash[i] && !qdev_is_realized(DEVICE(vms->flash[i]))) {
+            object_unref(OBJECT(vms->flash[i]));
+        }
+    }
+    g_free(vms->oem_id);
+    g_free(vms->oem_table_id);
+}
+
 static const TypeInfo virt_machine_info = {
     .name          = TYPE_VIRT_MACHINE,
     .parent        = TYPE_MACHINE,
@@ -4329,6 +4342,7 @@ static const TypeInfo virt_machine_info = {
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
     .instance_init = virt_instance_init,
+    .instance_finalize = virt_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
-- 
2.54.0


