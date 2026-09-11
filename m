Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166CBC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52UB-0003bd-Ap; Fri, 11 Sep 2026 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Ns-0002to-39
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nl-0008FA-Ey
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNbkkFHCYKpbxfWO4D+I7H8XxjKgGoTqJimeW8ycrfY=;
 b=Cqf5cwpvfgcBqTxcRKy47Q5URJI89fC08ikz4A7ZvmoGDPcgp/W20aMiWwekm0yWFUWAC5
 yvh58jsXuJtdptvrzqafkz10LOBcnXWID3uh6Z1m6WPRCSj4WsBFZXENZeuhG1Mhb2dnqF
 09cbLrLdmb7y5dPnnPlsiAp3bOzXERo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-snL57JxmM_i6WZC-vCI9tQ-1; Fri,
 11 Sep 2026 10:37:26 -0400
X-MC-Unique: snL57JxmM_i6WZC-vCI9tQ-1
X-Mimecast-MFC-AGG-ID: snL57JxmM_i6WZC-vCI9tQ_1789137444
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 398031955DD1; Fri, 11 Sep 2026 14:37:24 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69BE23000229; Fri, 11 Sep 2026 14:37:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 24/28] hw/acpi: mark erst,
 vmclock and vmgenid devices as secure
Date: Fri, 11 Sep 2026 15:36:23 +0100
Message-ID: <20260911143627.2743803-25-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are all used in virtualization scenarios so must be
declare to provide a security boundary

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/erst.c    | 1 +
 hw/acpi/vmclock.c | 1 +
 hw/acpi/vmgenid.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index b6c1942e30..44560004a5 100644
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
index d51cab2e20..b545354600 100644
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
index 27cc0128d1..67f815d8a1 100644
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
2.55.0


