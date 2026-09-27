Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F067C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkra-0002Ke-4J; Sun, 27 Sep 2026 05:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpg-0000GD-3C; Sun, 27 Sep 2026 05:06:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkpd-00086X-TM; Sun, 27 Sep 2026 05:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499956; bh=5j7SiOFAPy7GQ9dfFgPX+ZTxde1DQsReG5HFSgg/hhc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bNDo2l264UyH6TsSfPindI+GQQJEhMYw4UdcYzZzK2ButYSWQ03rI0qZD4QFuBNNx
 yT+OwxEMbgkTlOKYKU6GC9nE2Y5VendMa5puNcDjXidAJVr15Br2N++ypKVXG90R0E
 IZcWo1OovDhH/l8/ogXkTm1o4fsk64VHJNnPR8QqplBt9gSIH9+ZhYEFt2c/lh6gUo
 bDmkmW5dbzoiOzBkLvpQ099+I6T+YSgVxivUEWJvbzZoMHaNh+RYeLd7Bth/lJykMC
 0xKyz83Z5zq7poxWqNxkVZyQshPlD+enKYPHF9LhRRRqdb+Zm8fHxosox/HM3vX18X
 l3u9Bn1a2W4Ww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC8FB1D8B0D;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4C9C4320C6;
 Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D3D385E64B; Sun, 27 Sep 2026 12:05:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 60/86] igvm: Report error on missing parameter area
 in directive handlers
Date: Sun, 27 Sep 2026 12:05:07 +0300
Message-ID: <20260927090540.102811-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Luigi Leonardi <leonardi@redhat.com>

Parameter areas are how an IGVM file tells QEMU to allocate buffers
for runtime information the guest needs — VP count, memory map,
MADT and so on. Usage directives reference a parameter area by index
to tell QEMU where to write each piece of data. If the index doesn't
match any declared parameter area, the data has nowhere to go and
should be treated as an error.

The directive handlers that look up a parameter area all return 0
(success) when `qigvm_find_param_entry()` can't find it. Therefore,
the load succeeds but the guest never gets the expected parameters.

Note that the IGVM library already validates parameter area indices
when the file is loaded, so this path should only be reachable with
a malformed file that bypassed library validation. This is defensive
programming against that case.

Report the error with error_setg() and return -1 instead.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260626-microvm_device_tree-v6-1-9cd13cf057e2@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 4d3b9dc4d1fb42997d6a49155e54e552a3af3c88)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e7..3a07f85db73 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -62,7 +62,8 @@ struct QEMU_PACKED sev_id_authentication {
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp)
 {
     QIgvmParameterData *param_entry;
     QTAILQ_FOREACH(param_entry, &igvm->parameter_data, next)
@@ -71,7 +72,8 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index)
             return param_entry;
         }
     }
-    warn_report("IGVM: No parameter area for index %u", parameter_area_index);
+    error_setg(errp, "IGVM: parameter area index %u not found",
+                   parameter_area_index);
     return NULL;
 }
 
@@ -500,9 +502,10 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
         return 0;
     }
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     region = qigvm_prepare_memory(ctx, param->gpa, param_entry->size,
@@ -573,9 +576,10 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
@@ -632,9 +636,10 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
@@ -655,9 +660,10 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
     QIgvmParameterData *param_entry;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     environmental_state =
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 7f131c4d039..7eb3792ed8c 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -72,6 +72,7 @@ struct QIgvm {
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
-qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
+qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
+                       Error **errp);
 
 #endif
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index f41b498b892..ad9bf87761f 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -191,9 +191,10 @@ int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
     if (param_entry == NULL) {
-        return 0;
+        return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
-- 
2.47.3


