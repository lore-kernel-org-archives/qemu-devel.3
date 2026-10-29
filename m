Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bmCzOHAh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ1U-0007sH-NK; Thu, 29 Oct 2026 09:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPxI-0000TR-MR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPxG-0006Xq-PX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tz6ECrqGFEvH2qPdvBggN2cCB6nV8NdVl/en/0ygr8c=;
 b=bmCzOHAhr0azWJclekO/yXFyP2f0PYDB+N8gWMNgM0RKIuUsnSrsf4ApZZge5NYbXKEyln
 Olmyk2E/2JubtEVH7OvdPyDTNtjB+6nKt261Ywf206vfnU/bX10ysdC2PM48prV2ACbXQo
 xJ0CPkC5pKKPpXN+GcwFJq47UClFuTg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-pOu3nCV0MLylF1T_gVYESA-1; Thu,
 29 Oct 2026 09:14:02 -0400
X-MC-Unique: pOu3nCV0MLylF1T_gVYESA-1
X-Mimecast-MFC-AGG-ID: pOu3nCV0MLylF1T_gVYESA_1793279640
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1DE71955EB6; Thu, 29 Oct 2026 13:14:00 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 740183000723; Thu, 29 Oct 2026 13:13:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 27/28] hw/display: mark cirrus and QXL as secure
Date: Thu, 29 Oct 2026 13:12:40 +0000
Message-ID: <20261029131241.2275706-28-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Most of the display adapters are emulating old hardware which is not
relevant to virtualization use cases. The previous commit added the
generic, simple devices.

This proposes two further devices based on their historical widespread
usage in virtualization use cases.

Cirrus (PCI, not ISA) was the recommended default for x86 for an
incredibly long time and while it is now discouraged, it is likely
to still be in common use.

QXL was the recommended default to be used with SPICE, which is designed
to service virtualization use cases and is still commonly shipped by
many distros and often used by default in mgmt apps still.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/cirrus_vga.c | 1 +
 hw/display/qxl.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0a8c74e1374..8232c5c4687 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3013,6 +3013,7 @@ static const TypeInfo cirrus_vga_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCICirrusVGAState),
     .class_init    = cirrus_vga_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index d5f9771f5af..a8746d9f5dc 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2651,6 +2651,7 @@ static const TypeInfo qxl_primary_info = {
     .name          = "qxl-vga",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_primary_class_init,
+    .secure        = true,
 };
 module_obj("qxl-vga");
 module_kconfig(QXL);
@@ -2669,6 +2670,7 @@ static const TypeInfo qxl_secondary_info = {
     .name          = "qxl",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_secondary_class_init,
+    .secure        = true,
 };
 module_obj("qxl");
 
-- 
2.56.0


