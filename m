Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CC3CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERv2-0000bH-IR; Thu, 30 Oct 2025 08:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERuy-0000Zt-1x
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERup-00075B-Vq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761827879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vo2QpaQ8nvXy8DWiIEvHHrIUdQrToRlPa1cWo0N8OS4=;
 b=RknW0PM9+Jg20ZjDgFtHWCnVeVvlwnq30JfwNU+zt4I10DPbqaQwZWm8gv+pItDDEdGcCh
 mswwHnW4MrQm6qaMQavvmXy3Prdv10VqpG4kBK07FyYcB91JD/U0xl9aw+NN6+A1IGUBNx
 d9vzH8z8ZFeibJ1W75mkPR5Lv1r79nQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-sBZcrUzVPj2guVReBYpZrA-1; Thu,
 30 Oct 2025 08:37:57 -0400
X-MC-Unique: sBZcrUzVPj2guVReBYpZrA-1
X-Mimecast-MFC-AGG-ID: sBZcrUzVPj2guVReBYpZrA_1761827877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61381805C2C
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:37:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 523A3180035A; Thu, 30 Oct 2025 12:37:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, berrange@redhat.com, rjones@redhat.com
Subject: [PATCH 1/5] x86: q35: ich9: add 'wdat' property
Date: Thu, 30 Oct 2025 13:37:46 +0100
Message-ID: <20251030123750.136175-2-imammedo@redhat.com>
In-Reply-To: <20251030123750.136175-1-imammedo@redhat.com>
References: <20251030123750.136175-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

it will be used to make QEMU generate WDAT ACPI table,
that describes TCO watchdog in platfom independed way
and allows guest to use generic 'wdat' driver.
To enable it use '-global ICH9-LPC.wdat=on' option.

PS:
On linux wdat driver takes ove TCO watchdog if WDAT
table is present, hence 'wdat=off' by default to
avoid guest visible change on existing VMs.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/ich9.h | 1 +
 hw/acpi/ich9.c         | 5 +++++
 hw/isa/lpc_ich9.c      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 245fe08dc2..c84e17f9f6 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -69,6 +69,7 @@ typedef struct ICH9LPCPMRegs {
     bool smm_compat;
     bool enable_tco;
     TCOIORegs tco_regs;
+    bool enable_wdat;
 
     bool swsmi_timer_enabled;
     bool periodic_timer_enabled;
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2b3b493c01..08a01aa1aa 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -321,6 +321,11 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
         acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
 
+    if (pm->enable_wdat && !pm->enable_tco) {
+        error_setg(&error_fatal,
+            "'wdat' can not be enabled without 'enable_tco=on'");
+    }
+
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
         object_property_set_link(OBJECT(lpc_pci), "bus",
                                  OBJECT(pci_get_bus(lpc_pci)), &error_abort);
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index c9cb8f7779..ce9cf87363 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -832,6 +832,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
 
 static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
+    DEFINE_PROP_BOOL("wdat", ICH9LPCState, pm.enable_wdat, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
-- 
2.47.3


