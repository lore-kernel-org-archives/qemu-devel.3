Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE14C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4jG-0006vQ-HL; Tue, 12 Mar 2024 12:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4im-00066I-GD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iY-0007Ey-VJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iWNVUyhni6FRMovVlSl30ipAzUSKstUsEhq4kAyQNY=;
 b=E04auBm7B+Zk4NFSNhApfw7D/wsiKazn5oWBwdXsoEFbYx8xYjHoDW1rjWjDo+bIX1rtLq
 C/prjmmXhrjpbtYkcQbOLb0caEIiCKkCkvoWiXLf5pxJ/F8vzLiUSgoPMD8y9ydVw9aXTL
 RaQ7oCyd5jwnwkhEOW1Z5SFtbv/51Kk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-J50qd_4DPDSVpjs_3iFwww-1; Tue,
 12 Mar 2024 12:11:00 -0400
X-MC-Unique: J50qd_4DPDSVpjs_3iFwww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5483438300A7;
 Tue, 12 Mar 2024 16:11:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEF63C23;
 Tue, 12 Mar 2024 16:10:59 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 06/20] smbios: get rid of smbios_legacy global
Date: Tue, 12 Mar 2024 17:10:36 +0100
Message-Id: <20240312161050.2248814-7-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

clean up smbios_set_defaults() which is reused by legacy
and non legacy machines from being aware of 'legacy' notion
and need to turn it off. And push legacy handling up to
PC machine code where it's relevant.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
PS: I've moved/kept legacy smbios_entries to smbios_get_tables()
but it at least is not visible to API users. To get rid of it
as well, it would be necessary to change how '-smbios' CLI
option is processed. Which is done later in the series.
---
 include/hw/firmware/smbios.h |  2 +-
 hw/arm/virt.c                |  2 +-
 hw/i386/fw_cfg.c             |  7 ++++---
 hw/loongarch/virt.c          |  2 +-
 hw/riscv/virt.c              |  2 +-
 hw/smbios/smbios.c           | 35 +++++++++++++++--------------------
 6 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index a187fbbd3d..0818184834 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -293,7 +293,7 @@ struct smbios_type_127 {
 void smbios_entry_add(QemuOpts *opts, Error **errp);
 void smbios_set_cpuid(uint32_t version, uint32_t features);
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version, bool legacy_mode,
+                         const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type);
 void smbios_set_default_processor_family(uint16_t processor_family);
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..8588681f27 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1633,7 +1633,7 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 
     smbios_set_defaults("QEMU", product,
-                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
+                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     /* build the array of physical mem area from base_memmap */
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index fcb4fb0769..c1e9c0fd9c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -63,15 +63,16 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (pcmc->smbios_defaults) {
         /* These values are guest ABI, do not change */
         smbios_set_defaults("QEMU", mc->desc, mc->name,
-                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
+                            pcmc->smbios_uuid_encoded,
                             pcms->smbios_entry_point_type);
     }
 
     /* tell smbios about cpuid version and features */
     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
 
-    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
-    if (smbios_tables) {
+    if (pcmc->smbios_legacy_mode) {
+        smbios_tables = smbios_get_table_legacy(ms->smp.cpus,
+                                                &smbios_tables_len);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
         return;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e98d8bda5..8c7601ef91 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -355,7 +355,7 @@ static void virt_build_smbios(LoongArchMachineState *lams)
         return;
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, false,
+    smbios_set_defaults("QEMU", product, mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a094af97c3..535fd047ba 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1275,7 +1275,7 @@ static void virt_build_smbios(RISCVVirtState *s)
         product = "KVM Virtual Machine";
     }
 
-    smbios_set_defaults("QEMU", product, mc->name, false,
+    smbios_set_defaults("QEMU", product, mc->name,
                         true, SMBIOS_ENTRY_POINT_TYPE_64);
 
     if (riscv_is_32bit(&s->soc[0])) {
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 15339d8dbe..c46fc93357 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -54,7 +54,6 @@ struct smbios_table {
 
 static uint8_t *smbios_entries;
 static size_t smbios_entries_len;
-static bool smbios_legacy = true;
 static bool smbios_uuid_encoded = true;
 /* end: legacy structures & constants for <= 2.0 machines */
 
@@ -570,9 +569,16 @@ static void smbios_build_type_1_fields(void)
 
 uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
 {
-    if (!smbios_legacy) {
-        *length = 0;
-        return NULL;
+    /* drop unwanted version of command-line file blob(s) */
+    g_free(smbios_tables);
+    smbios_tables = NULL;
+
+    /* also complain if fields were given for types > 1 */
+    if (find_next_bit(have_fields_bitmap,
+                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
+        error_report("can't process fields for smbios "
+                     "types > 1 on machine versions < 2.1!");
+        exit(1);
     }
 
     if (!smbios_immutable) {
@@ -1006,28 +1012,13 @@ void smbios_set_default_processor_family(uint16_t processor_family)
 }
 
 void smbios_set_defaults(const char *manufacturer, const char *product,
-                         const char *version, bool legacy_mode,
+                         const char *version,
                          bool uuid_encoded, SmbiosEntryPointType ep_type)
 {
     smbios_have_defaults = true;
-    smbios_legacy = legacy_mode;
     smbios_uuid_encoded = uuid_encoded;
     smbios_ep_type = ep_type;
 
-    /* drop unwanted version of command-line file blob(s) */
-    if (smbios_legacy) {
-        g_free(smbios_tables);
-        /* in legacy mode, also complain if fields were given for types > 1 */
-        if (find_next_bit(have_fields_bitmap,
-                          SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) {
-            error_report("can't process fields for smbios "
-                         "types > 1 on machine versions < 2.1!");
-            exit(1);
-        }
-    } else {
-        g_free(smbios_entries);
-    }
-
     SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
     SMBIOS_SET_DEFAULT(type1.product, product);
     SMBIOS_SET_DEFAULT(type1.version, version);
@@ -1103,6 +1094,10 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
+    /* drop unwanted (legacy) version of command-line file blob(s) */
+    g_free(smbios_entries);
+    smbios_entries = NULL;
+
     if (!smbios_immutable) {
         smbios_build_type_0_table();
         smbios_build_type_1_table();
-- 
2.39.3


