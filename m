Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92ECD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdZ-0000Cn-S8; Mon, 04 May 2026 07:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdX-0008WC-S4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdW-0001Lh-8e
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qwk/cPhu7UiB2QxXvkLjHJKVC7UchevJ1zlM3zy8ly4=;
 b=F6Wqw/r/cwCHyU0io7dZ8/UwCrQ6C93YRMoHTRzjcxt5ZyPYKhkNnleI4E9WvAe4EjnKsF
 uAa0bH6eQuARnA6vUISKdYg3+0tlusyV0A3bdFCeytqWS7JITjEbIUDZsKVc2LBsPbR551
 A6G4+RbU/2EE4t98ofZy6jnlxEgPf+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-di518TOJPcuj4pfkM_gpSw-1; Mon,
 04 May 2026 07:38:50 -0400
X-MC-Unique: di518TOJPcuj4pfkM_gpSw-1
X-Mimecast-MFC-AGG-ID: di518TOJPcuj4pfkM_gpSw_1777894729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94A47195608B; Mon,  4 May 2026 11:38:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A5951800446; Mon,  4 May 2026 11:38:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:25 +0400
Subject: [PATCH v2 37/46] hw/arm/sbsa-ref: free unrealized flash devices on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-37-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UpRnWtRlRxB4ZnNVthl20Ci4luK2JJ70Vb6M6RFsMfw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtrKG8NmbKLnZ+HalbC4Ok8ONizvY9uQGIB
 MTXx+XfXCWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5YCSD/4s/p1Rut93TOLBObWt+uWtyBEy6kPDzCwhacOUn+Od247rSUh4sjYQbJEhHRWkdY8rWGo
 sBLsyarNpgO6WqaXcm+iHaFN0Ynbe1b46FZPor5NL3uhSIwyAgtzidZe+ULoGXjdENKCCWytVLJ
 bSpLuN2JBtxxQRFgty0WQfkLrORhTpTCBC7oW/D0IWZlmnxq6UtI8dmjW+c7wxVSrLJFiQRD6eJ
 VkXB9hOCP10Cs+CiFJYLHYWSxhRW22dM/lUdJt5nSsre9Hv50jrD8FBcX365WCrNatuxw1648fD
 cpXeTHyftzb6hL/p1uxARwBpEeHsX/TSkSARVU5SG63eSeHUhxbGNbKqx+9yyT9UyMiuaJJHmvl
 u36mpXdcj80ymr209l8bUAx2evdapK0Z83olGKOhPTYauGCs1OVDnf2IdDB3HyyUXDf0467FAFV
 vKVsaHVw1/XQls2YN0fmRxCcxxl06foI+RC4SUXZAaPL21EnXS/JgRh52LJO7VetnCL8IF7pKQt
 gkai/Ku9N6j3kSMI5B0mpS4yLEP7zuOq7bLtgh8gJA3bW6wtr5KaHrsKnMnaxzU/RkZwS/LmZM0
 PWs0RjuKjHhaTQOapvHO3Fhea52fbL1jiN7dpfpG1icXYzk78f9qa8qIeVVklqOEHhkhIsSaFyo
 g7ez1+7tAkMCy2w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


