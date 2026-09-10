Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14497C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4iuc-0005tf-9f; Thu, 10 Sep 2026 13:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4iub-0005rR-96
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x4iuZ-00085W-Or
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789062610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=okWc0wzIZhNIR6RveiCd/MeNer3r5ng3F5lZCSU5TbY=;
 b=Ta7dH1zXvJiCUrmXm0LuJb7j4VIcRKJAoYgALgbwVso376o8Yvvc+NdA2vhj15Dffe4Rcw
 DannAVNiVgJb8tJacPETSAR5OxcOa8kWGJmQwOKGnMdgXUdwooUmW9KFnfAwjNLMZLY467
 eXbAQZ1p7w0EhOlNOe/3OzqU+C1jm0E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-c8eRPzjmNWmBVDQ-zntRcw-1; Thu,
 10 Sep 2026 13:50:06 -0400
X-MC-Unique: c8eRPzjmNWmBVDQ-zntRcw-1
X-Mimecast-MFC-AGG-ID: c8eRPzjmNWmBVDQ-zntRcw_1789062605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3FE41800742; Thu, 10 Sep 2026 17:50:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2DE81956096; Thu, 10 Sep 2026 17:50:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH] hw/misc/bcm2835_powermgt: Free timer during finalize to avoid
 memory leak
Date: Thu, 10 Sep 2026 19:50:01 +0200
Message-ID: <20260910175001.76278-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When running e.g. the device-introspect-test with valgrind, there are
reports that the code in bcm2835_powermgt.c leaks memory like this:

  48 bytes in 1 blocks are definitely lost in loss record 2,090 of 4,315
     at 0x6B4B62B: calloc (vg_replace_malloc.c:1616)
     by 0x7AFF6E1: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.8800.3)
     by 0x42B1E48: timer_new_full (timer.h:520)
     by 0x42B1E48: timer_new (timer.h:543)
     by 0x42B1E48: timer_new_ns (timer.h:563)
     by 0x42B1E48: bcm2835_powermgt_init (bcm2835_powermgt.c:151)
     by 0x48632E3: object_init_with_type (object.c:426)
     by 0x48632E3: object_initialize_with_type (object.c:508)
     by 0x48636BE: object_new_with_type (object.c:706)
     by 0x4962FF1: qmp_device_list_properties (qom-qmp-cmds.c:206)
     by 0x44ACB90: qdev_device_help (qdev-monitor.c:315)
     by 0x44AE14E: hmp_device_add (qdev-monitor.c:1018)

Free the timer during finalize() to avoid this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/bcm2835_powermgt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/bcm2835_powermgt.c b/hw/misc/bcm2835_powermgt.c
index 7b01be48bb7..e31fcb1f131 100644
--- a/hw/misc/bcm2835_powermgt.c
+++ b/hw/misc/bcm2835_powermgt.c
@@ -152,6 +152,14 @@ static void bcm2835_powermgt_init(Object *obj)
                                  bcm2835_powermgt_expire, s);
 }
 
+static void bcm2835_powermgt_finalize(Object *obj)
+{
+    BCM2835PowerMgtState *s = BCM2835_POWERMGT(obj);
+
+    timer_free(s->wdog_timer);
+    s->wdog_timer = NULL;
+}
+
 static void bcm2835_powermgt_reset(DeviceState *dev)
 {
     BCM2835PowerMgtState *s = BCM2835_POWERMGT(dev);
@@ -177,6 +185,7 @@ static const TypeInfo bcm2835_powermgt_info = {
     .instance_size = sizeof(BCM2835PowerMgtState),
     .class_init    = bcm2835_powermgt_class_init,
     .instance_init = bcm2835_powermgt_init,
+    .instance_finalize = bcm2835_powermgt_finalize,
 };
 
 static void bcm2835_powermgt_register_types(void)
-- 
2.55.0


