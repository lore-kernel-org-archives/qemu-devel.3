Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D40CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrdc-0000SN-H6; Mon, 04 May 2026 07:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdb-0000Ja-4F
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrdZ-0001Mq-Kr
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KEGTmyxrc7XP1G2EZKa1n2uGmD818fX8zVRKUr15Fg=;
 b=dk7RY4evrTiFQSCO2SHDTa3A55oVMOzdBiByDajppbP0t6boDqUBt5NtqbcJ1cGzwc3z2H
 tqmFgSGg81e6vlbfkfHEVygJoJoC8C7HOLNHh9cEU4EiXJ6IvF/tuaBoKJzAN4BECDtz2J
 pS4MOcOXAzD6Q5WsA7f71cmQUQHZFmY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-sRnLC6nFNxKppvSnhqseyA-1; Mon,
 04 May 2026 07:38:55 -0400
X-MC-Unique: sRnLC6nFNxKppvSnhqseyA-1
X-Mimecast-MFC-AGG-ID: sRnLC6nFNxKppvSnhqseyA_1777894734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B116E195609D; Mon,  4 May 2026 11:38:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5E5D180045E; Mon,  4 May 2026 11:38:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:26 +0400
Subject: [PATCH v2 38/46] hw/arm/virt: free flash devices and OEM strings
 on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-38-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GsOgr5n9WQyuSxd7SPoMPhp96GkvsouIHeYWWY0Z4NY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtSd3cW5fVMopqWZ6WH+5cYZt5gx9n1TDp0
 oWm94/m/W2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5W6kD/43TeJjjgdu+X5R0pWhIhGDM2jPxwvb8YNHtKy6qqS3bmx+sK3JJyruznthCwQDbh+kG9G
 1S4ifsokqBH3kXAC01h+HumUFy2BIfura09GtVyvHcOPhFBbyBB9WYsY0SuDp7D/7kg1m8bek7Y
 7Tu1lSs36XtbUQ+gLeLPGu0zFYfbga75MadukDyVXbnzD2uiyxNgXhM63imLrBpExJYaNtHE5yk
 ug6PogyFrME9AyGrSTdjjP717YR27nAPbJmvKRHocN+emvfLDGIVdme92AO6SVXsQ+Ldr57x/ga
 JY2BRC6z4JxrNoQztiiNg37waRm1ZRPFnGvNK5YcpJI4cm7rJiybRm6aR6U9VqYK7VWi++lxmE/
 VVVKZXucl9lQy9cNLLLdUvFKzqft6Yp3dkAa2/nHNXyTDaNiMz2Mkj5y4sPiWtmCKA1MGh8fr+B
 GrVAQIxlGGKh9tGW70BUYF3Q07hHhnfcgu6br7rVBldWypKR1+qAMtQxYLBHcSUX57OSkvYxagO
 lU5LlP+XQOuqs1SqCzLrksIqQS4MNFoC7Aac8eC29OTgsQ32yP8S37GuPByFT/EeTSvdOpon7Jc
 OCkMurnWCFZbyoAS+XT0a7GcdSJKlPusP6O5XB1BFCHeu21QidovuEsBTBy20FkOKYHZk6j14/R
 7RSJSrEcjp31CWw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 77891f08200..9510d9eea73 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4031,6 +4031,19 @@ static void virt_instance_init(Object *obj)
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
@@ -4039,6 +4052,7 @@ static const TypeInfo virt_machine_info = {
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
     .instance_init = virt_instance_init,
+    .instance_finalize = virt_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }

-- 
2.54.0


