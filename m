Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18241C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvzP-00007l-LO; Wed, 03 Jul 2024 05:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOvzO-00007O-RU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOvzJ-0007Dq-Ot
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719997757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+NrTpNaHAHqpdFkMY0digZ6OBUg+4A51BmdyFxA206E=;
 b=GEpBjgkV4LG7qOkoAUpP0YjRFO+/R3PUBCLd+syv4Py1Y6GApqdF3VZkcoymqxGeKvxJkd
 bL0iaLSFDI4emksjotj9zEvpx55eUWyNI4oXNZjcdjGLQsOXgdJgHT1awLtZ7wvAFHST6E
 QvhpgzPGvna0wNM+569joQSMfRBnEX4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Vq7xrQyCO9awZR7ZMI_ZVw-1; Wed,
 03 Jul 2024 05:09:11 -0400
X-MC-Unique: Vq7xrQyCO9awZR7ZMI_ZVw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E6219560AE; Wed,  3 Jul 2024 09:09:09 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99A5630000DD; Wed,  3 Jul 2024 09:09:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 yong.huang@smartx.com
Cc: qemu-trivial@nongnu.org, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] hw: Fix crash that happens when introspecting scsi-block on
 older machine types
Date: Wed,  3 Jul 2024 11:09:04 +0200
Message-ID: <20240703090904.909720-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"make check SPEED=slow" is currently failing the device-introspect-test on
older machine types since introspecting "scsi-block" is causing an abort:

 $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio
 QEMU 9.0.50 monitor - type 'help' for more information
 (qemu) device_add scsi-block,help
 Unexpected error in object_property_find_err() at
 ../../devel/qemu/qom/object.c:1357:
 can't apply global scsi-disk-base.migrate-emulated-scsi-request=false:
 Property 'scsi-block.migrate-emulated-scsi-request' not found
 Aborted (core dumped)

The problem is that the compat code tries to change the
"migrate-emulated-scsi-request" property for all devices that are
derived from "scsi-block", but the property has only been added
to "scsi-hd" and "scsi-cd" via the DEFINE_SCSI_DISK_PROPERTIES macro.

Thus let's fix the problem by only changing the property on the devices
that really have this property.

Fixes: b4912afa5f ("scsi-disk: Fix crash for VM configured with USB CDROM after live migration")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..60858a8565 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,8 @@
 
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
-    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
+    {"scsi-hd", "migrate-emulated-scsi-request", "false" },
+    {"scsi-cd", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
-- 
2.45.2


