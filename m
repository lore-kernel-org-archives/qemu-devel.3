Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A6C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4j8-0006Z0-L5; Tue, 12 Mar 2024 12:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4ii-00060i-UQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4ih-0007HQ-4I
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcRD5eJH0Tgzy5QwaOjcQclSDY34FVFXN6sYMbePaxM=;
 b=R8lqgqY33cQz48Yf+Dwjwgoh0OMoUgdYzyRKmUlSbmtirtCIOnkujSnyuXa2U10MOp96mF
 plN5ewZjQIFa6i4DIqZZb1Xo7rPT2dJKe+EvV+W45pRCti2FBxlgZzWnbDUHtOt6zkWlqk
 mcoVS8Q+1ReXaehM7IJoOYUbYNO0dgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-Ya-gpOwYOGyPcNleIqHqcQ-1; Tue, 12 Mar 2024 12:11:12 -0400
X-MC-Unique: Ya-gpOwYOGyPcNleIqHqcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B5CB800279;
 Tue, 12 Mar 2024 16:11:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70AEF3C24;
 Tue, 12 Mar 2024 16:11:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 16/20] smbios: in case of entry point is 'auto' try to
 build v2 tables 1st
Date: Tue, 12 Mar 2024 17:10:46 +0100
Message-Id: <20240312161050.2248814-17-imammedo@redhat.com>
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

QEMU for some time now uses SMBIOS 3.0 for PC/Q35 machines by
default, however Windows has a bug in locating SMBIOS 3.0
entrypoint and fails to find tables when booted on SeaBIOS
(on UEFI SMBIOS 3.0 tables work fine since firmware hands
over tables in another way)

Missing SMBIOS tables may lead to some issues for guest
though (worst are: possible reactiveation, inability to
get virtio drivers from 'Windows Update')

It's unclear  at this point if MS will fix the issue on their
side. So instead of it (or rather in addition) this patch
will try to workaround the issue.

aka, use smbios-entry-point-type=auto to make QEMU try
generating conservative SMBIOS 2.0 tables and if that
fails (due to limits/requested configuration) fallback
to SMBIOS 3.0 tables.

With this in place majority of users will use SMBIOS 2.0
tables which work fine with (Windows + legacy BIOS).
The configurations that is not to possible to describe
with SMBIOS 2.0 will switch automatically to SMBIOS 3.0
(which will trigger Windows bug but there is nothing
QEMU can do here, so go and aks Microsoft to real fix).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 hw/smbios/smbios.c | 52 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d3d89b4dd0..c4a953bbc9 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -959,7 +959,7 @@ static void smbios_entry_point_setup(SmbiosEntryPointType ep_type)
     }
 }
 
-void smbios_get_tables(MachineState *ms,
+static bool smbios_get_tables_ep(MachineState *ms,
                        SmbiosEntryPointType ep_type,
                        const struct smbios_phys_mem_area *mem_array,
                        const unsigned int mem_array_size,
@@ -968,6 +968,7 @@ void smbios_get_tables(MachineState *ms,
                        Error **errp)
 {
     unsigned i, dimm_cnt, offset;
+    ERRP_GUARD();
 
     assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
            ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
@@ -1053,11 +1054,56 @@ void smbios_get_tables(MachineState *ms,
         abort();
     }
 
-    return;
+    return true;
 err_exit:
     g_free(smbios_tables);
     smbios_tables = NULL;
-    return;
+    return false;
+}
+
+void smbios_get_tables(MachineState *ms,
+                       SmbiosEntryPointType ep_type,
+                       const struct smbios_phys_mem_area *mem_array,
+                       const unsigned int mem_array_size,
+                       uint8_t **tables, size_t *tables_len,
+                       uint8_t **anchor, size_t *anchor_len,
+                       Error **errp)
+{
+    Error *local_err = NULL;
+    bool is_valid;
+    ERRP_GUARD();
+
+    switch (ep_type) {
+    case SMBIOS_ENTRY_POINT_TYPE_AUTO:
+    case SMBIOS_ENTRY_POINT_TYPE_32:
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_32,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        if (is_valid || ep_type != SMBIOS_ENTRY_POINT_TYPE_AUTO) {
+            break;
+        }
+        /*
+         * fall through in case AUTO endpoint is selected and
+         * SMBIOS 2.x tables can't be generated, to try if SMBIOS 3.x
+         * tables would work
+         */
+    case SMBIOS_ENTRY_POINT_TYPE_64:
+        error_free(local_err);
+        local_err = NULL;
+        is_valid = smbios_get_tables_ep(ms, SMBIOS_ENTRY_POINT_TYPE_64,
+                                        mem_array, mem_array_size,
+                                        tables, tables_len,
+                                        anchor, anchor_len,
+                                        &local_err);
+        break;
+    default:
+        abort();
+    }
+    if (!is_valid) {
+        error_propagate(errp, local_err);
+    }
 }
 
 static void save_opt(const char **dest, QemuOpts *opts, const char *name)
-- 
2.39.3


