Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3F9C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXBm-0007Qq-Q8; Tue, 05 Mar 2024 10:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXBZ-0006A3-Mr
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rhXBU-0000fp-L8
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709654307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FPllFn8BVPj1SXGBKiVHW8cLEYzwd1fGRyeCtqUlUY=;
 b=O1WWicwW+klDPCp8AazpmSpxXqGLg6o8iFFVumDxJ7gjAY/3UDP9Hc7dEETr5HaL7s2lEa
 qOUL1MbXM4BeziNW+FDAnlRP9GDeKA91uH2UhEbIptBmgDNCFMWruf6V74T5TcXNReAZ0e
 D3u2TyxMaBx6CGCTWJFQopILjV2pg/M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-mCTjxIsXMKOPuOv03OKYZA-1; Tue,
 05 Mar 2024 10:58:24 -0500
X-MC-Unique: mCTjxIsXMKOPuOv03OKYZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE0F32800091;
 Tue,  5 Mar 2024 15:58:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B67517A8E;
 Tue,  5 Mar 2024 15:58:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@linaro.org, wangyanan55@huawei.com, eblake@redhat.com,
 armbru@redhat.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 19/20] pc/q35: set SMBIOS entry point type to 'auto' by
 default
Date: Tue,  5 Mar 2024 16:57:23 +0100
Message-Id: <20240305155724.2047069-20-imammedo@redhat.com>
In-Reply-To: <20240305155724.2047069-1-imammedo@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index a8e8aa2ac8..cf16337341 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1847,7 +1847,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
-    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce6aad758d..cebf61d12c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -531,12 +531,16 @@ DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
 
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
index 45a4102e75..6fef3b17bb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -369,10 +369,13 @@ DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
 
 static void pc_q35_8_2_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_9_0_machine_options(m);
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+    /* For pc-q35-8.2 and 8.1, use SMBIOS 3.X by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
 DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
-- 
2.39.3


