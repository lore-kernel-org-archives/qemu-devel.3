Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB5C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYruE-0002UN-Lc; Fri, 17 Jan 2025 14:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYruC-0002UA-5m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYruA-0008BY-Ez
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737141677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aCpLVc9AMKm7QfyYqSU8fXrC2KisDrJRpA7sf4qSdCw=;
 b=c+Cw0DJJ7v1nDZQJ1ZNDYXOXbWNT7N8O9yNKCyYyG2rV4oGKdFMf8d3oZm9c49gkhbeSTb
 JA+mB1QLuwQVy1iYffSKZH1BRruXCocYrvxy40HEnl8gylNSG9HcZ1g8EPlorP5fGCS663
 exixjpRfW718UY/FVBy6R3mj+DQzab8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-T0aMoKWOM8KL1KlLRrH0eg-1; Fri,
 17 Jan 2025 14:21:11 -0500
X-MC-Unique: T0aMoKWOM8KL1KlLRrH0eg-1
X-Mimecast-MFC-AGG-ID: T0aMoKWOM8KL1KlLRrH0eg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89FE5196A961; Fri, 17 Jan 2025 19:21:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBC0B19560AE; Fri, 17 Jan 2025 19:21:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
Date: Fri, 17 Jan 2025 20:21:06 +0100
Message-ID: <20250117192106.471029-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU currently crashes when you try to inspect the machines based on
TYPE_PC_MACHINE for their properties:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
                      { "typename": "pc-q35-10.0-machine"}}' \
   | ./qemu-system-x86_64 -M pc -qmp stdio
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
 {"return": {}}
 Segmentation fault (core dumped)

This happens because TYPE_PC_MACHINE machines add a machine_init-
done_notifier in their instance_init function - but instance_init
of machines are not only called for machines that are realized,
but also for machines that are introspected, so in this case the
listener is added for a q35 machine that is never realized. But
since there is already a running pc machine, the listener function
is triggered immediately, causing a crash since it was not for the
right machine it was meant for.

Such listener functions must never be installed from an instance_init
function. Let's do it from pc_basic_device_init() instead - this
function is called from the MachineClass->init() function instead,
i.e. guaranteed to be only called once in the lifetime of a QEMU
process.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b46975c8a4..85b8a76455 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
+
+    pcms->machine_done.notify = pc_machine_done;
+    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
@@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
-
-    pcms->machine_done.notify = pc_machine_done;
-    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 static void pc_machine_reset(MachineState *machine, ResetType type)
-- 
2.48.1


