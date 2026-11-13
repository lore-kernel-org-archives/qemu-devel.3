Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EE606CC85
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKg+LKN6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFJ-0007Gb-WF; Fri, 13 Nov 2026 13:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF2-0007CA-4k
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF0-0005OA-0Q
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pCx/O6oyYaCRX/lQ1ZUEFAWTsFz8iYKW4yjMhURvNM=;
 b=FKg+LKN6q1AaPVqFOTocu4BP247RZpfFkAm3NVrR51JSdcnWMPDQu5JHgp4ouGVYJXQEV4
 7H8666jIAVeOFi5we6blkYPJUSH8qnYnJF8wvHhPv4sWVKauVkB2lLLTB4lv1H4bvX321U
 aWHLDZMLSMDYYIZ8KcLwwxp4WGl1vy4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-528TTAsAOvOf1VTQ4SdUPA-1; Fri,
 13 Nov 2026 13:43:11 -0500
X-MC-Unique: 528TTAsAOvOf1VTQ4SdUPA-1
X-Mimecast-MFC-AGG-ID: 528TTAsAOvOf1VTQ4SdUPA_1794595390
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C8D195606B
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:10 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3695819634E9; Fri, 13 Nov 2026 18:43:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/26] hw/net: mark e1000, e1000e,
 rtl8139 & sPAPR VLAN as secure
Date: Fri, 13 Nov 2026 18:42:35 +0000
Message-ID: <20261113184254.2524253-8-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Historically most NICs are only interesting for non-virtualization
use cases and have not been written with malicious guests in mind.

As a general rule either virtio-net or xen-net should be used in
all virtualized guests requiring a security boundary.

There are a handful of exceptions resulting from historical usage
in the x86 world, to support virtualized guests lacking virtio
support.

Thus the rtl8139, e1000 & e1000e  NICs are declared to provide
a security boundary.

The PPC sPAPR Virtual LAN device is also marked secure.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/e1000.c      | 1 +
 hw/net/e1000e.c     | 1 +
 hw/net/rtl8139.c    | 1 +
 hw/net/spapr_llan.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 202ad404013..2f540dbb417 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1759,6 +1759,7 @@ static void e1000_register_types(void)
         type_info.parent = TYPE_E1000_BASE;
         type_info.class_data = info;
         type_info.class_init = e1000_class_init;
+        type_info.secure = true;
 
         type_register_static(&type_info);
     }
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 9faf0c74c3d..96737ddb51a 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -721,6 +721,7 @@ static const TypeInfo e1000e_info = {
     .instance_size = sizeof(E1000EState),
     .class_init = e1000e_class_init,
     .instance_init = e1000e_instance_init,
+    .secure = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 16479284eea..38bc16f312f 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3450,6 +3450,7 @@ static const TypeInfo rtl8139_info = {
     .instance_size = sizeof(RTL8139State),
     .class_init    = rtl8139_class_init,
     .instance_init = rtl8139_instance_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index a5b8906849c..784e46f57d4 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -891,6 +891,7 @@ static const TypeInfo spapr_vlan_info = {
     .class_init    = spapr_vlan_class_init,
     .instance_init = spapr_vlan_instance_init,
     .instance_finalize = spapr_vlan_instance_finalize,
+    .secure        = true,
 };
 
 static void spapr_vlan_register_types(void)
-- 
2.56.1


