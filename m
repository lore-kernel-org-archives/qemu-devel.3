Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D98FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbt-0000xz-9Y; Mon, 04 May 2026 07:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbj-0000lD-Gs
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbi-00011p-4T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eveSPPinlS5ge22zD59cWM5/VNbVy81aT0zg3hIugP0=;
 b=B3Su6JUd878QMeZfs5fvi4necCdywzng/ulAXJjbJX0jy+rKxaQkpJ+iFOFI25USH1iawB
 AoDHosbGJ9pPZMAe4pyHFAA4afQB+/bBzEMIeYCIiJSM8ojpcZoM2QNvWB4+HoBFypft5X
 JnBRHvT6mfUb4zEQNIUU/cdl6NR7IIQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-1ug8KojwM6ixqBUVbli2BA-1; Mon,
 04 May 2026 07:36:57 -0400
X-MC-Unique: 1ug8KojwM6ixqBUVbli2BA-1
X-Mimecast-MFC-AGG-ID: 1ug8KojwM6ixqBUVbli2BA_1777894617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1812818005AC; Mon,  4 May 2026 11:36:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B13E030001A1; Mon,  4 May 2026 11:36:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:06 +0400
Subject: [PATCH v2 18/46] hw/i386/x86: free oem_id and oem_table_id on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-18-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V+2eXo/TucBNqV2DxgpQIOrwZ4TdO+5VekaKqMhBHdM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsmXMbrvbLPcc1njAZ4kl81Be3nHve/fEzC
 I0fbECuFI2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5cW8D/43mfpZX7a0IYtZxXdnRmUDOeMA7FkZg7PGh3wp/nxYgRGEk+tNZkey5crQz44XXyBQEzt
 WsJWJt0c3F8o3x7H8btkcpsQANNEWrPLfCWEH0CZdENquo+d0Oexg4KdOWM8+Tjo2FQT5xr2iOG
 DlN3y6YFJsiv5+nYUIVxKBosr4wqX4VzJSrZJ4a0fxoUK8iGQjUo6u29hvneagaYRTVT4LeSJbV
 ehZsmejowpUhKMhU9egvXWgKrwDki+WVrgp9BLNPvgWzgQt1Pfx31QUVTcqEb4cxzdq7LPPAHNx
 gSvq0QqvAhqFWUai0sDfo7NTCPleaImtbxaqMxN0qf/P57LpqRsD+7n6dJYjX3C6NjwYSq0s2U7
 Ht2b2NM32da05BbPfyl2QGv8DuzyhK3fQg3XauXTw9q9b7lZlFkKJTh0BW6OQ9qU/EEDeeMBMbg
 zVXk2/4nV7YMWi6V7Ok4NhTYaI12lQv0IFYLVHrrsp8Hiqh5p/EK1zPj2BYd6VrSHfuw6mcOOLH
 5kmDGa1cInxFZiugR2p9Zm9Dl4k8k4w1McUlBp9FtI4CsZ2hG3mbPlHMx+9B2H0DPALxQawgKwE
 kU6LlfXGqPKJS4xm/T7eo5kfoHaqhwlrqWmpKFiJCO7L9/H8jKAl7oIjwtjvHJ8NEmH4h2SH+bJ
 yaN7wbZqUFgFhdQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

x86_machine_initfn allocates oem_id and oem_table_id via g_strndup,
but no instance_finalize existed for x86_machine_info, so these
strings were never freed when the object was destroyed.

Add x86_machine_finalize to release both fields.

Fixes: d07b22863b8e ("acpi: Move setters/getters of oem fields to X86MachineState")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 01872cba073..dc7f0d56b01 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -372,6 +372,14 @@ static void x86_machine_initfn(Object *obj)
     x86ms->above_4g_mem_start = 4 * GiB;
 }
 
+static void x86_machine_finalize(Object *obj)
+{
+    X86MachineState *x86ms = X86_MACHINE(obj);
+
+    g_free(x86ms->oem_id);
+    g_free(x86ms->oem_table_id);
+}
+
 static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -445,6 +453,7 @@ static const TypeInfo x86_machine_info = {
     .abstract = true,
     .instance_size = sizeof(X86MachineState),
     .instance_init = x86_machine_initfn,
+    .instance_finalize = x86_machine_finalize,
     .class_size = sizeof(X86MachineClass),
     .class_init = x86_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {

-- 
2.54.0


