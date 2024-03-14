Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67E6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 15:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkmvn-0007et-8S; Thu, 14 Mar 2024 11:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmva-0007NA-4C
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rkmvY-0003ot-Fn
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 11:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710429807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QK3VzflXInySfueK+SfexWiK/O+z9FeBvoPlrZmIFkU=;
 b=XA0tq8H9oL/jSMXjDvbOUlCJ+kMHEKoUbYuTUStNlTdVGpp5sHvnKZwm98Bo0SKCuzJMEJ
 TfBs8mslFbmSO79oAPK0iGBJ5pRZznbBRu1aSEQ0EfKLgxkCwVrWhF5mIDb+I2mLF7l2TJ
 4v0Zwnhnr0/A1F8E86AQly+Bli6hkMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688--9ani6VjO1GVqn51y520ZQ-1; Thu, 14 Mar 2024 11:23:25 -0400
X-MC-Unique: -9ani6VjO1GVqn51y520ZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A56E800277;
 Thu, 14 Mar 2024 15:23:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE0917A8E;
 Thu, 14 Mar 2024 15:23:24 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v4 19/21] pc/q35: set SMBIOS entry point type to 'auto' by
 default
Date: Thu, 14 Mar 2024 16:23:00 +0100
Message-Id: <20240314152302.2324164-20-imammedo@redhat.com>
In-Reply-To: <20240314152302.2324164-1-imammedo@redhat.com>
References: <20240314152302.2324164-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use smbios-entry-point-type='auto' for newer machine types as a workaround
for Windows not detecting SMBIOS tables. Which makes QEMU pick SMBIOS tables
based on configuration (with 2.x preferred and fallback to 3.x if the former
isn't compatible with configuration)

Default compat setting of smbios-entry-point-type after series
for pc/q35 machines:
  * 9.0-newer: 'auto'
  * 8.1-8.2: '64'
  * 8.0-older: '32'

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2008
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/i386/pc.c      | 2 +-
 hw/i386/pc_piix.c | 4 ++++
 hw/i386/pc_q35.c  | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 44eb073abd..e80f02bef4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1832,7 +1832,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
-    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c9a6c0aa68..18ba076609 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -525,12 +525,16 @@ DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_9_0_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
 
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+    /* For pc-i44fx-8.2 and 8.1, use SMBIOS 3.X by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
 DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8a427c4647..b5922b44af 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -376,11 +376,14 @@ DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
 
 static void pc_q35_8_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
     m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+    /* For pc-q35-8.2 and 8.1, use SMBIOS 3.X by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
 DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
-- 
2.39.3


