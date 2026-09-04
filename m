Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403ADC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SK6-0006uH-Ve; Fri, 04 Sep 2026 07:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SK3-0006nk-6S
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SK1-0000dG-FO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788522184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4Asyc+O2ju5G8jDRXzXEhs02ZRRC0lTdqvBx/frusQ=;
 b=Q7dkQ8OZTv9sw4Ydo3V/yozbt32Wrs6ArBDk/XdJjFseaE7FT9/nwptwKcy6deSHrDEwx9
 TY9RtajMAKy4yGebfWxkoGCH8H8xdqJS9XB8B94LlKPBrfkGuW9lPegp0Q4rzIYJbZ4AVF
 rdFA32fnG8BfWp7scByzU6MwEd2JY4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-XZnl_e-BNRyqG72X8lvZ-w-1; Fri, 04 Sep 2026 07:43:03 -0400
X-MC-Unique: XZnl_e-BNRyqG72X8lvZ-w-1
X-Mimecast-MFC-AGG-ID: XZnl_e-BNRyqG72X8lvZ-w_1788522182
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49ccfbe060aso6877435e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788522182; x=1789126982; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f4Asyc+O2ju5G8jDRXzXEhs02ZRRC0lTdqvBx/frusQ=;
 b=H48BP9WO6ySmnpdOc4+TkK6yhHll15ZKIxFYSvnc5SXClpLno7PEV4wqZuOFGvdcu5
 XZHIUwKR6QCnnKpJ33W9p556bjyRPZS+LPaGt9pzugX+tFwUuJV12hf5FJlC/YaH2XL2
 TnLrLjE9cRSv9DQiamz8Bm49MYKySsNjgJDL8gl+TbzN3e3mjQjDryDhevazjTQrWNe7
 h50ZN5zZtFnaxJWy3ObXneClzhILwO12sF8Jpc6FQYZlegGVO/fRw2SNaSkwnxe4sbm3
 WPPTbz0llaNACI3x6vxPT2OJxGKmRGWLiRLF/yGDvNbazOz5oRTSZoQGgPSJ8ARGdZ1e
 Jv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788522182; x=1789126982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f4Asyc+O2ju5G8jDRXzXEhs02ZRRC0lTdqvBx/frusQ=;
 b=DEEVndASafQR7/7pynGCm4B3S8Fdy+/jdIBsZ1aoq8V/5h52hr4QFEvWS/KqoCuDIG
 ItLsrg1CQIHPqkoqXGvKgwBOaZR8zpeDE8WsqsaOEASG2XNXznVWAk5x+yq+my75dx7z
 A89iivFUB1D20j5zMJJDEOlnXe0zzq8BI3xBPxxKRS4vzB5QS7E2yPyCyqQSEycB6pKx
 P3B6XCt423y/0GIr4JA2WNO5YnMv/eWO3ArSB2ODVWbOAIr1dW3r6jL4lIBTHSxjZdUY
 XIjDraEJt23Y/6w+eHEMKxN2znze+z1kdsoCcgFqc8rLal5FWR8rowoJOEWfN2JmH+FO
 mxSw==
X-Gm-Message-State: AFuF++mhaOAr5cL6Z1+W81FqyFtX9D621T3hQ7RO7mtlcrTmNLloF9s4
 5Q1s2d3KPnyjmkOLBW022heQovJQY+eCyf0K5gO0JIj99pq/Cvh7D4EeTK8PSXVa1sOltCKe6uQ
 XtleMn0nrHz4lArEn9e2+Tt9v6GBs1ICQH55qqTPUbx24YFiO5ABKGj5I
X-Gm-Gg: AYBFou3IFjtLcsZcT2mvpoLoWRDAz3LFx1wLgcxvXexuJn00unejdmBWwQTFykFup4C
 qMHguwk8WwfTRvClwLV9v8SFXBTVDSatt9S36AXgBloprBAyx87S/KkfbI+qNQ4/5o3PkA/HePL
 X4JDe41vwotdxB14FNl7JLQr5j+R8dofSZjWhrcqMbEOzWdyeklkhPXrlcM7d/Yw/NPABcNKtOh
 /b3JmQrAKmR879FicCdh8u3Ku4roZ4eoDfS/T4MqgdLSh0PKbPxgT3SK7loN7UX+ZVO1INwMgOU
 DGo88Rt6Y8uXQe8IAjt9Q1sZXDtyyVYoZQCTAl6bpsb1fzCgrWKCngKTuIrhsrKzJKIkyx0DJp8
 4/7fi6nfj9DJWprs/GRuNbT7XQfe7RUUhTOWas9X8Q1SP/2ezCwMYNvnsDRlZ9w850eEK
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49cfa21e935mr35845785e9.20.1788522182181; 
 Fri, 04 Sep 2026 04:43:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49cfa21e935mr35845365e9.20.1788522181747; 
 Fri, 04 Sep 2026 04:43:01 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm65081995e9.9.2026.09.04.04.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:43:01 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 04 Sep 2026 13:42:56 +0200
Subject: [PATCH v2 2/2] igvm: honor byte_offset when writing memory map,
 MADT and device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-fix_offset-v2-2-f5bb4cf6d4b0@redhat.com>
References: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
In-Reply-To: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

qigvm_directive_memory_map(), qigvm_directive_madt() and
qigvm_directive_device_tree() all wrote their data unconditionally at
the start of the parameter area's buffer, ignoring param->byte_offset
from the IGVM_VHS_PARAMETER header. This is harmless when a
directive's offset happens to be 0, but breaks for IGVM files that pack
multiple parameters into a single shared parameter area at different
offsets: a later directive would overwrite the data written by an earlier
one at the start of the buffer, corrupting it.

Switch these handlers to qigvm_find_param_validate(), introduced in
the previous patch, and use the offset-adjusted data pointer and
remaining size it returns instead of writing at param_entry->data and
sizing checks against param_entry->size directly. This both honors
byte_offset and validates it against the parameter area size before
it is used.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c    | 24 ++++++++++++------------
 target/i386/igvm.c | 12 ++++++------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 8c07f2ce5e..4d622eac6a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -638,7 +638,8 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp) = NULL;
-    QIgvmParameterData *param_entry;
+    uint8_t *data;
+    uint32_t size;
     int max_entry_count;
     int entry = 0;
     IGVM_VHS_MEMORY_MAP_ENTRY *mm_entry;
@@ -659,14 +660,13 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     }
 
     /* Find the parameter area that should hold the memory map */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
+                                   &data, &size, errp)) {
         return -1;
     }
 
-    max_entry_count = param_entry->size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
-    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)param_entry->data;
+    max_entry_count = size / sizeof(IGVM_VHS_MEMORY_MAP_ENTRY);
+    mm_entry = (IGVM_VHS_MEMORY_MAP_ENTRY *)data;
 
     retval = get_mem_map_entry(entry, &cgmm_entry, errp);
     while (retval == 0) {
@@ -860,12 +860,12 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
     g_autofree void *fdt_packed = NULL;
-    QIgvmParameterData *param_entry;
+    uint8_t *data;
+    uint32_t size;
     uint32_t fdt_size;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
+                                   &data, &size, errp)) {
         return -1;
     }
 
@@ -883,14 +883,14 @@ static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
     }
 
     fdt_size = fdt_totalsize(fdt_packed);
-    if (fdt_size > param_entry->size) {
+    if (fdt_size > size) {
         error_setg(errp,
                    "IGVM: device tree size exceeds parameter area"
                    " defined in IGVM file");
         return -1;
     }
 
-    memcpy(param_entry->data, fdt_packed, fdt_size);
+    memcpy(data, fdt_packed, fdt_size);
 
     return 0;
 }
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index ad9bf87761..db365cb80e 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -187,20 +187,20 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
 int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *data;
+    uint32_t size;
     int result = 0;
 
     /* Find the parameter area that should hold the MADT data */
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
+                                   &data, &size, errp)) {
         return -1;
     }
 
     GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
 
-    if (madt->len <= param_entry->size) {
-        memcpy(param_entry->data, madt->data, madt->len);
+    if (madt->len <= size) {
+        memcpy(data, madt->data, madt->len);
     } else {
         error_setg(
             errp,

-- 
2.55.0


