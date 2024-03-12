Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4iu-0006Hk-Mo; Tue, 12 Mar 2024 12:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iX-0005y4-T8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iV-0007Bn-4z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4c9OhW/hQJQKbDD3J0uL/RxP31+gk21VGQFZ1SY7OM=;
 b=IEWA6mK2J75YZfyfhYjnl38/ZB6GMvg5/gN6rZZENlFhiPC4vRXNMhNGl0Mqp3KHe6UT6q
 G4JHfs4793bgQ2MTiMS+Y0NXS1qbCnfEO3eqXaCjfXrgYYj2c9Jzm3umkoL42vyJuoPKOR
 qDs6bi/sBNalFEAFvefC0+AOFzeo5LE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-5Atmn7RtMbCFuCI867FFkw-1; Tue, 12 Mar 2024 12:10:58 -0400
X-MC-Unique: 5Atmn7RtMbCFuCI867FFkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2445800265;
 Tue, 12 Mar 2024 16:10:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7C8A3C21;
 Tue, 12 Mar 2024 16:10:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 04/20] smbios: cleanup smbios_get_tables() from legacy
 handling
Date: Tue, 12 Mar 2024 17:10:34 +0100
Message-Id: <20240312161050.2248814-5-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

smbios_get_tables() bails out right away if leagacy mode is enabled
and won't generate any SMBIOS tables. At the same time x86 specific
fw_cfg_build_smbios() will genarate legacy tables and then proceed
to preparing temporary mem_array for useless call to
smbios_get_tables() and then discard it.

Drop legacy related check in smbios_get_tables() and return from
fw_cfg_build_smbios() early if legacy tables where built without
proceeding to non legacy part of the function.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/i386/fw_cfg.c   | 1 +
 hw/smbios/smbios.c | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 98a478c276..a635234e68 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -74,6 +74,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
     if (smbios_tables) {
         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
                          smbios_tables, smbios_tables_len);
+        return;
     }
 
     /* build the array of physical mem area from e820 table */
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a3c4e52ce9..8e86c62184 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1106,12 +1106,6 @@ void smbios_get_tables(MachineState *ms,
 {
     unsigned i, dimm_cnt, offset;
 
-    if (smbios_legacy) {
-        *tables = *anchor = NULL;
-        *tables_len = *anchor_len = 0;
-        return;
-    }
-
     if (!smbios_immutable) {
         smbios_build_type_0_table();
         smbios_build_type_1_table();
-- 
2.39.3


