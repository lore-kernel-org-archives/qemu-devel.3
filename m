Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C516CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX9r-00075r-3R; Mon, 11 May 2026 16:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9i-0006uy-M9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9f-0002Lu-6f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjR3LbB920EXigDkIu5RxUuwQpgi24eawYW4XfIUDz8=;
 b=gFAc4Kf2t6r1lwE5NeXcJ8+6+avnslZK4/cdXFlhCmy1/lcCSDyRmjBZk2PagzXT/6eehm
 VFZMTC2QCAQgbXTRA+Cv2queCRQ5+cN0gMy7mWTAkjKnISndiNAk5IUnkTIR3ZUUASBoiC
 CI5cRU9MhYvVE3WpHdu8LB450ISA+44=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-sVr0VKRDMjuSYumLqnAxPQ-1; Mon,
 11 May 2026 16:23:02 -0400
X-MC-Unique: sVr0VKRDMjuSYumLqnAxPQ-1
X-Mimecast-MFC-AGG-ID: sVr0VKRDMjuSYumLqnAxPQ_1778530981
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE71319560AA; Mon, 11 May 2026 20:23:00 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85F5830001BE; Mon, 11 May 2026 20:22:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 19/24] hw/arm/sbsa-ref: free unrealized flash devices on
 finalization
Date: Tue, 12 May 2026 00:21:05 +0400
Message-ID: <20260511202111.3091440-20-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Flash devices are created with qdev_new() in instance_init and added as
children, but the initial reference from qdev_new() is only dropped by
sysbus_realize_and_unref() during machine init. When the machine object
is destroyed before realization (e.g. during qtest device introspection),
the flash devices leak.

Fixes: e9fdf453240e ("hw/arm: Add arm SBSA reference machine, devices part")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/sbsa-ref.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 52c35e10c2d..484b90053e8 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -892,6 +892,17 @@ static void sbsa_ref_instance_init(Object *obj)
     sbsa_flash_create(sms);
 }
 
+static void sbsa_ref_instance_finalize(Object *obj)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(obj);
+
+    for (int i = 0; i < ARRAY_SIZE(sms->flash); i++) {
+        if (sms->flash[i] && !qdev_is_realized(DEVICE(sms->flash[i]))) {
+            object_unref(OBJECT(sms->flash[i]));
+        }
+    }
+}
+
 static void sbsa_ref_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -930,6 +941,7 @@ static const TypeInfo sbsa_ref_info = {
     .name          = TYPE_SBSA_MACHINE,
     .parent        = TYPE_MACHINE,
     .instance_init = sbsa_ref_instance_init,
+    .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
     .interfaces    = aarch64_machine_interfaces,
-- 
2.54.0


