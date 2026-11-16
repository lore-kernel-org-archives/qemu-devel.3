Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aIvW/aJa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT56F-0004mQ-1a; Mon, 16 Nov 2026 17:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55y-000467-11
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT55w-00063b-CH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794867756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5z3NPGvejmyqhncwWFMK/5I1jcApZU5nHsQ/I8anx4=;
 b=aIvW/aJalfR0WXSUb9DhfLVUPASFE2w91mrFFDe2TENZJjP7QFmhIHdfNHi13SM+bN0H9M
 7EnkzgPJ0gNsbsFvF2qgpQPumwVvb98LOV7kkT81wP/BHpWi5gRX3ncA5qcN7rD6nlmqI9
 JNWPjATUCcTvh8aQRuD81SpiRQyFK/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-mdv9SY1RNN-ymIiVuQ4DuA-1; Mon,
 16 Nov 2026 17:22:34 -0500
X-MC-Unique: mdv9SY1RNN-ymIiVuQ4DuA-1
X-Mimecast-MFC-AGG-ID: mdv9SY1RNN-ymIiVuQ4DuA_1794867753
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF6F1800361
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:22:33 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A43030001A2; Mon, 16 Nov 2026 22:22:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/26] hw/acpi: mark erst, vmclock and vmgenid devices as secure
Date: Mon, 16 Nov 2026 22:21:54 +0000
Message-ID: <20261116222158.2840471-23-berrange@redhat.com>
In-Reply-To: <20261116222158.2840471-1-berrange@redhat.com>
References: <20261116222158.2840471-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These are all used in virtualization scenarios so must be
declare to provide a security boundary

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/erst.c    | 1 +
 hw/acpi/vmclock.c | 1 +
 hw/acpi/vmgenid.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index b6c1942e308..44560004a53 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1044,6 +1044,7 @@ static const TypeInfo erst_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .class_init    = erst_class_init,
     .instance_size = sizeof(ERSTDeviceState),
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
index d51cab2e20a..b5453546006 100644
--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -169,6 +169,7 @@ static const TypeInfo vmclock_device_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(VmclockState),
     .class_init    = vmclock_device_class_init,
+    .secure        = true,
 };
 
 static void vmclock_register_types(void)
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 27cc0128d11..67f815d8a1e 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -236,6 +236,7 @@ static const TypeInfo vmgenid_device_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(VmGenIdState),
     .class_init    = vmgenid_device_class_init,
+    .secure        = true,
 };
 
 static void vmgenid_register_types(void)
-- 
2.56.1


