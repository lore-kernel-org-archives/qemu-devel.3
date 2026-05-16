Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D60CCD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9xU-0000pV-Jc; Sat, 16 May 2026 04:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xQ-0000br-8B
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9xO-0007oM-Jb
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8BM6lk2d/q0uYMA25e6DLVH4Eu5sV0SBk59q2zky50=;
 b=chEQGZYMzPr6DtHStFXgpPQ4sc2ATiO+h2QXPodzBch7eTtzufukdO1IXeY0gvyGOUyf5+
 IhEEgrzGRaDOqQTu+GG0+yUW5FTz5wYJUZIs8nBKhLcYsVztJvk6GaTGqxaldt5t5BECjH
 dsnd7zcJIdPCk94NcA0q/FpyQRDq50A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-Ctm3B7s1Pmiun2SYunlRyA-1; Sat,
 16 May 2026 04:01:08 -0400
X-MC-Unique: Ctm3B7s1Pmiun2SYunlRyA-1
X-Mimecast-MFC-AGG-ID: Ctm3B7s1Pmiun2SYunlRyA_1778918467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F712195605A
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:01:07 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60B7930001A2; Sat, 16 May 2026 08:01:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:18 +0400
Subject: [PATCH v3 19/24] hw/loongarch/virt: free flash devices and OEM
 strings on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-19-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=x1kW1X7a1jUz1TjYHNTyxhXK429eLvO8CiKl+XNmePw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPPbnuRHouewAm5SfrgIZHhqem5WoXZqQPWi
 E0JLLr65NqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5ViTD/91j0R7dPa7bZSXpmOCsY+CH9d5IvW4z/rFU65Hwadu7aHuq4ClEUrWsuAJFy8GODECAJg
 R4YLBBUR8+8CUZXInCLCKB23yhHcSHt2JDR6Sae7tAIyr0X2OtRB2aOQUc3SoxISbNbTOzXFmHc
 8foTCR/RI7chSdmQD/SpJko7/COal84ugaT/oE3U3zUoZVsB6VhGvaJUUgjc+5TcbX8u+LBlgz9
 UYYDn2pR+t6OeATwcRXyVbtBqJ7z42RnoSZ7LoobLZ4lr0n8OtHJd1YBax4naXOtcvTSwbv5Med
 BFiXShs6GVBIgq1gvtUGUyQs3IAfTpJ+6ktGT+/mKMCSdOsddQyAzLtGi2M90PTJEdOFUT1CPJm
 OEAN/PEhjNwQcN+HjfEO8uYEEZyd8DkiqNvCnP1VlsY1db788L5AUPK/Y9Yp+NAOqAk9crQKzp2
 b42JoJDRnfHdNALp2mQa3vxRd3Oepy7JuXhadU5eZ/eXHfVKxznXdnWMTGVqrPl0JKRCG+qcxRD
 0nqacJ+PYs1I8Mn2rPFG8evw/ByY8CMqF5F2a79PgH9xrkI9YOAF6Ur6R3lhl9LUJBQnMJu9ViF
 vTQGSttz3z/EXHcicxzqihZyKJSFwtIoUMbdtaXo+0LGuuEam45d6enrnZZ5i2FXnmpCho+I/tG
 Hira0Jmqh5lx95w==
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

Flash devices created in virt_initfn() via qdev_new() hold an extra
reference that is only dropped on sysbus_realize_and_unref(). When the
machine is destroyed before realization, the flash objects leak. Also,
the oem_id and oem_table_id strings from g_strndup() are never freed.

Fixes: 445c9c645 ("hw/loongarch/virt: Allow user to customize OEM ID and OEM table ID")
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


