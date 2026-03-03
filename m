Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731D0EC047C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM19-00040U-Ci; Tue, 03 Mar 2026 04:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0o-0003iC-IQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0m-0004OM-7F
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdHNx4XbPANB2aNzpa5xx400fH2SDRE74EJc40dN18k=;
 b=Il3EeuAo0kboa4Hl+4KwHRVVFi9vIgz4odrszAKDWZrl2+h8FCl8DIn8IRAmfKaHbRkAet
 dHswsIWzBdHTn9LH22zxe7GXNc0ztNj286ctJWmpB+qTlQz1A/72Gm+pOKYM/pE3lSka/g
 BTCcGNUPTYpRXsJwTkAqZC2JXryQaBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-TTq2Ua4FPHyjV_05hxHypg-1; Tue,
 03 Mar 2026 04:25:46 -0500
X-MC-Unique: TTq2Ua4FPHyjV_05hxHypg-1
X-Mimecast-MFC-AGG-ID: TTq2Ua4FPHyjV_05hxHypg_1772529945
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29D271800464; Tue,  3 Mar 2026 09:25:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70E9A30001B9; Tue,  3 Mar 2026 09:25:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 02/21] x86: q35: add 'wdat' property
Date: Tue,  3 Mar 2026 10:25:13 +0100
Message-ID: <20260303092532.2410177-3-imammedo@redhat.com>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Used for enabling WDAT based watchdog for builtin iTCO watchdog.
Usage:
    -M q35,wdat={on|off}
By default it is disabled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/pc.h |  1 +
 hw/i386/pc_q35.c     | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1cf88c1697..8e34e57be3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -45,6 +45,7 @@ typedef struct PCMachineState {
     const char *south_bridge;
 
     bool acpi_build_enabled;
+    bool wdat_enabled;
     bool smbus_enabled;
     bool sata_enabled;
     bool hpet_enabled;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9158631f76..49f89544f3 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -330,6 +330,18 @@ static void pc_q35_init(MachineState *machine)
     }
 }
 
+static bool pc_q35_machine_get_wdat(Object *o, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(o);
+    return pcms->wdat_enabled;
+}
+
+static void pc_q35_machine_set_wdat(Object *o, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(o);
+    pcms->wdat_enabled = value;
+}
+
 #define DEFINE_Q35_MACHINE(major, minor) \
     DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor);
 
@@ -342,6 +354,7 @@ static void pc_q35_init(MachineState *machine)
 static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    ObjectClass *oc = OBJECT_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
@@ -360,6 +373,11 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
+    object_class_property_add_bool(oc, "wdat",
+        pc_q35_machine_get_wdat, pc_q35_machine_set_wdat);
+    object_class_property_set_description(oc, "wdat",
+        "Enable WDAT watchdog support. Default: off");
+
     compat_props_add(m->compat_props,
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
-- 
2.47.3


