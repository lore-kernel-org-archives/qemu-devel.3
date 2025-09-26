Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCEECAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2948-0007kW-1S; Fri, 26 Sep 2025 10:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293y-0007Qc-6d
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293m-0004xN-NK
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSI4koEj6hTiFW4jnJoIN1bQ8wVMLP2Vge1rchVPfvU=;
 b=AytI5zL3ZC1nwhg3I8NaRGXLD7HcpOH+TlkmQq4yNPhPSK99ZMUokRCSyBifm5FrbPe4Q9
 UtjhNvx7QLKrPD+C9LvS9iKJzzp8LLRkOKbQUyJO12PeFab/7thg+4nOQ1KCZnMa3ccAOo
 iZC8JVHn92uf4VrzfDSmemtN14pys+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-2b71tKyLOYi4bilypwR__A-1; Fri,
 26 Sep 2025 10:04:26 -0400
X-MC-Unique: 2b71tKyLOYi4bilypwR__A-1
X-Mimecast-MFC-AGG-ID: 2b71tKyLOYi4bilypwR__A_1758895465
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C377119560B5; Fri, 26 Sep 2025 14:04:25 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF84B1956095; Fri, 26 Sep 2025 14:04:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 29/32] hw: mark test/demo devices as insecure
Date: Fri, 26 Sep 2025 15:01:40 +0100
Message-ID: <20250926140144.1998694-30-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These devices are either intended for use by the test suite,
or as a demonstration for how to write devices. None of them
should be used for real guest workload deployments.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/hyperv/hyperv_testdev.c | 1 +
 hw/misc/edu.c              | 1 +
 hw/misc/pc-testdev.c       | 1 +
 hw/misc/pci-testdev.c      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index 2d4a63693b..e31df31207 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -316,6 +316,7 @@ static const TypeInfo hv_test_dev_info = {
     .parent         = TYPE_ISA_DEVICE,
     .instance_size  = sizeof(HypervTestDev),
     .class_init     = hv_test_dev_class_init,
+    .secure         = false,
 };
 
 static void hv_test_dev_register_types(void)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cece633e11..8b7c8b9467 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -436,6 +436,7 @@ static const TypeInfo edu_types[] = {
         .instance_size = sizeof(EduState),
         .instance_init = edu_instance_init,
         .class_init    = edu_class_init,
+        .secure        = false,
         .interfaces    = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 67c486f347..bae405b687 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -206,6 +206,7 @@ static const TypeInfo testdev_info = {
     .parent         = TYPE_ISA_DEVICE,
     .instance_size  = sizeof(PCTestdev),
     .class_init     = testdev_class_init,
+    .secure         = false,
 };
 
 static void testdev_register_types(void)
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index ba71c5069f..22ca87722f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -353,6 +353,7 @@ static const TypeInfo pci_testdev_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCITestDevState),
     .class_init    = pci_testdev_class_init,
+    .secure        = false,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
-- 
2.50.1


