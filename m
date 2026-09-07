Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A19C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aoN-0004BP-HV; Mon, 07 Sep 2026 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoM-0004AR-BG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoK-0001vJ-J6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788793143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftcsARFbiXjTmIJ9OJxvuV/GsHCDBtGRAys02DaiBsQ=;
 b=Cn87+H/XazLUdspGCVnuzQ+QsISUkPlSbQyjoNYeei6K3vN4FPSfLcvcQWz+kKorQvNlly
 fXCBSQeN+q2j7DnsifrJRufOXppmwS2ULE/1QGXBxx1KtREoBylXG1cZDNkvAusvbGfRES
 phF79+Wz7ttLmTiDJ5hDuran3IbyTtE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-HkfgMQH7NViT3f6T8IKuUg-1; Mon, 07 Sep 2026 10:59:02 -0400
X-MC-Unique: HkfgMQH7NViT3f6T8IKuUg-1
X-Mimecast-MFC-AGG-ID: HkfgMQH7NViT3f6T8IKuUg_1788793141
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so46800195e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788793141; x=1789397941; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ftcsARFbiXjTmIJ9OJxvuV/GsHCDBtGRAys02DaiBsQ=;
 b=QHQx8we+U95tTsfyd6ee4VP8QBFf6CCiwR0+Jhx59FXXAA5U/HutwPliqQok5YjTut
 AQ3UEThY+X5FRhMMmg2RqSF4X0fpMhswhAWVpXoYFZk2ZFK4lo7YSRUSUUb5zyXG0x7K
 UhavJBML75sp0lgPBwnz25kLMcQgYTPdfdInGhuZ/BBPYD5LxyLkSTKAcR0CUwD+FHO8
 slqOUj8bn9fQNBYfiXZVACmV5Syi6GRJuGVSECujA9IfZOOMcien3b6Tq18d1Bzsoql5
 hsLewg83C5FZuMzX/5rwInJ6RPb9lQgB/Pmbpw7NX7Pr++Aiy3sax8RVB7OQqzF6E86H
 xwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793141; x=1789397941;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ftcsARFbiXjTmIJ9OJxvuV/GsHCDBtGRAys02DaiBsQ=;
 b=MUfJWL5Fq4wUv1vhDWSYBPOYeEzlxRtTRhKslws6Uzgr4DP3M90IYqHf09v6tfEv+5
 /obh7dzlohkLWjBYAKwk/zY3HLR7iSHnHzjH882VtED/YZSomdUndwlmUOS82YFxLkIw
 ubhooijLq9RuiLmZrv6aNoM6CquDsDManq/+QsjsR0Q/TbJ9u61vaCema21+kd82zzUu
 QG4l8TA/JRPSXGJJbaP0vTHoBK64m+j0rgG3ypJu1v7nXyO0snZDW+y13F2WwutFZLlT
 lItjX/8R4yB0+Qnl/JpB8It0/Pb66NaQIQJCs79eJta8gLobVZyauiNpMc8NQAEYc5J4
 l/Mw==
X-Gm-Message-State: AFuF++mLZAMQfExVQARMtYiX6HKA8syFX0plknvtv1rNa4pnB+sFtJKy
 PSLmRgqTMmyWaiuXs1h2gQmTh5HwYsMGIAALHgWfWJTXKRW69RcfeACSL2AZq5QqaE/quWVEMUx
 5iFp/ygEgF2gBJfLw6MkcI22vUyr2W5g8QqdfgCaQ37snbwZSz/GYe4Lt
X-Gm-Gg: AYBFou3ol5DDKa17BM3RbA3DaeKa8h7f3qavgaY7ory/mY8A37Kbl48eyCxsjag4vi4
 52+ufHDbSDqXkVzoOzxIEAgBheQAFA1jjbZ8Fd4lABwxOk/XryVfSQMFS2HmWCj5iCYRM5eVN8B
 IollYrCLE/ysasljWW9YTHecWgPM5n95iWAqgviLDec25r3l9QiCb1rjVzPa6B6Pw4Ttdopwz0v
 oeyYjJFmsoQlhdI4ZUEwFvl5jSnCiLioyeUu/TAB1EFrAbynNSaJNWTQlTub45iHG8HRvgB/AUG
 T/4F6Urog/YzvHpOWRWrAJGatOZjVc0kyt9vnPJZtjp9/H8IdE3FX6w1y4t0i7n3MtkD6ySAq87
 pxUcmiYKe/l0z5+q3mxv5sxe5+l3VdHwEF9qHf5PcZKytvryRIf6mZIRnzHMyA7WIrcnI
X-Received: by 2002:a05:6000:4694:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-4858704ad0amr35615723f8f.9.1788793141504; 
 Mon, 07 Sep 2026 07:59:01 -0700 (PDT)
X-Received: by 2002:a05:6000:4694:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-4858704ad0amr35615664f8f.9.1788793141100; 
 Mon, 07 Sep 2026 07:59:01 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm22547547f8f.11.2026.09.07.07.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:59:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 16:58:56 +0200
Subject: [PATCH v3 2/2] igvm: honor byte_offset when writing memory map,
 MADT and device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_offset-v3-2-bcffcefc0985@redhat.com>
References: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
In-Reply-To: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qigvm_directive_memory_map(), qigvm_directive_madt() and
qigvm_directive_device_tree() all wrote their data unconditionally at
the start of the parameter area's buffer, ignoring param->byte_offset
from the IGVM_VHS_PARAMETER header. This is harmless when a
directive's offset happens to be 0, but breaks for IGVM files that pack
multiple parameters into a single shared parameter area at different
offsets: a later directive would overwrite the data written by an earlier
one at the start of the buffer, corrupting it.

Switch these handlers to qigvm_get_param_data(), introduced in
the previous patch, and use the offset-adjusted data pointer it
returns and the remaining size it sets instead of writing at
param_entry->data and sizing checks against param_entry->size
directly. This both honors byte_offset and validates it against the
parameter area size before it is used.

Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")
Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Fixes: 1c4bd8f13c ("igvm: add device tree parameter support")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c    | 26 ++++++++++++++------------
 target/i386/igvm.c | 13 +++++++------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index a8340d7d55..b3ff6cba4a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -638,7 +638,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp) = NULL;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     int max_entry_count;
     int entry = 0;
     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
@@ -659,14 +660,14 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
+                                       param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+    max_entry_count = param_size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_data;
 
     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
     while (retval == 0) {
@@ -862,12 +863,13 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     g_autofree void *fdt_packed = NULL;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     uint32_t fdt_size;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
+                                       param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
@@ -885,14 +887,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
     }
 
     fdt_size = fdt_totalsize(fdt_packed);
-    if (fdt_size > param_entry->size) {
+    if (fdt_size > param_size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
                    " defined in IGVM file");
         return -1;
     }
 
-    memcpy(param_entry->data, fdt_packed, fdt_size);
+    memcpy(param_data, fdt_packed, fdt_size);
 
     return 0;
 }
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761..6ae662b033 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -187,20 +187,21 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
 int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
+                                       param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
 
-    if (madt->len <= param_entry->size) {
-        memcpy(param_entry->data, madt->data, madt->len);
+    if (madt->len <= param_size) {
+        memcpy(param_data, madt->data, madt->len);
     } else {
         error_setg(
             errp,

-- 
2.55.0


