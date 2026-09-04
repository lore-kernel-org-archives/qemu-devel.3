Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D8C79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SK4-0006oC-Ho; Fri, 04 Sep 2026 07:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SK2-0006nS-5S
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x2SK0-0000d9-Cy
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788522183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JzNp5KGKyVCz7tGeXIsBKi9zVw0VBlLR7I/OXHIqd4=;
 b=g+crpjDirEht5EzTfr2hLxMfUTcul1DY8n8sEY0hlIOnDyeRWADo76FDX2PPg5zeWuSByO
 UcLWUYbtON0dM0xczZNDMDxM4vDGaSgtq+L35nnVgM1IM3qA4luqK4imH1TXO+vPXWLeoz
 KG0XONfwMtaebbp0Bvb6Eak9vrThaB4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-RnH-sEPpNXCnvb4v4gT49g-1; Fri, 04 Sep 2026 07:43:02 -0400
X-MC-Unique: RnH-sEPpNXCnvb4v4gT49g-1
X-Mimecast-MFC-AGG-ID: RnH-sEPpNXCnvb4v4gT49g_1788522181
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49545071724so7072485e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788522181; x=1789126981; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1JzNp5KGKyVCz7tGeXIsBKi9zVw0VBlLR7I/OXHIqd4=;
 b=CLlyd6KC/DN4PFglqsw5uZIaYXFura5CKd8ktSUDLORcOIEiBTku9BafG5VrP6bSW3
 jPTSfjQ34SPMFb6Hz6dpt0Cpf3XqqGJcxc9INi90+2+o2UMbJGNeJfypdJ4FOZFhru+/
 0q2PkMjQ24//32UZ9+gJgJ23XcKLeVmCfHlT42SDbfpfX/YgRVCeimuyMeMvMcAIlkbu
 QC2K1on5+v08e1K5P75KhWvRd7LTSOpTjb8/PNoka30Zp7oPANQ1kl2sdb8L8eYV9fnV
 j/b78RTAjV51EgN+MnlhnQ/gnQ39Ytjg2XS0btb+ZbaqQTdmgY42152QqLGv8YEc6L3s
 hD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788522181; x=1789126981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JzNp5KGKyVCz7tGeXIsBKi9zVw0VBlLR7I/OXHIqd4=;
 b=dnsrtQvAMWeZMnnECVwlLu8S7Us36qD6xtlWm84oA7ox9YO/6gbud3f1aPCm71uQkc
 3jOoZrdXiQmWHvxSQsafYWj5iqlADmZjhVtQHy5hDrlSLelbKsiDOBbhgL9Pr9jtGU5F
 zYgMhlFFwfpy3ntycqWwPyXI+CleHWO5C+G4T1DGkZj6dX0eTwV6D86MepNxOptkhBvg
 CKEA1+C3E3xOm+MEA3CZkp1aR+s92t0+5OzfJC8ZH8Zw4kYLPcHsPOa1c6igCEBzJ6Fh
 ZvRqsZOo5A5H64bE7tzRzPaX1n2VrBiNv9mcr8SuQjzAU3OUPao/gFp2hLijSTRg9GyL
 A1Cg==
X-Gm-Message-State: AFuF++nIz5V+MPXeJsG0tPJWrG5OJpB8KXHO3rzo1mg0xhB3H/6hKDIA
 Dod6exRUolY6vQaY5z/PNrwecpVLIFnkxOaEQ9YUa+qc6IzsgWWrbMSXm7fAd0NgGnHOlSjGlUz
 RBZwea2kUrPKYFs9hANz3our/XfUgQdOZCeYntWJN3Y/RKsT8BKCJY1Y/
X-Gm-Gg: AYBFou1WAak1u1br2cNz7wbPnw6eJt1yO5EwtzfC6SyOasncuaAeH195P1usTUSJhPi
 xFFlaTNvoiz8JUs/D7vbf9WhA8uKyjks2MokAFdkqNogWNJD6OiBc/zlqS7myejNEzyNzsjo4pQ
 ABfor1dj8v5kG6xuwyKt8/pr4AVRX8Qi/Cplry7yestK3Slarhf5yVdH44mmj1qDHEbq2ceAGdj
 aIm3yeY9Zje6n0SkRIqwyfV+bYkHaOjmxK4YElOSICSL4jctB3KdbwJmHd/iaoJhK2GJrSkB0IW
 AwkLJ96btyjckZy4Er4PbVkaFEWBPEnjjDALG7qgWMNMp+3riFVEj/Dwr3Q4lSHfW1aL2B7uUDO
 zDZ7I8RNYEu/2jPoyLj9nlQ1g8x3fvaG8aFAZXneiJwBSZiWX6uQn8ac4xuEEGzAgsVDH
X-Received: by 2002:a05:600d:849b:20b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49cf825d8c0mr44438345e9.9.1788522181018; 
 Fri, 04 Sep 2026 04:43:01 -0700 (PDT)
X-Received: by 2002:a05:600d:849b:20b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49cf825d8c0mr44438075e9.9.1788522180564; 
 Fri, 04 Sep 2026 04:43:00 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771e9absm65081995e9.9.2026.09.04.04.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:43:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 04 Sep 2026 13:42:55 +0200
Subject: [PATCH v2 1/2] igvm: validate byte_offset before using it in
 parameter directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-fix_offset-v2-1-f5bb4cf6d4b0@redhat.com>
References: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
In-Reply-To: <20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

None of the directive handlers that place data at a byte_offset within
a parameter area validated that byte_offset actually falls within the
parameter area's size. A malformed IGVM file with byte_offset > size would
underflow the "size - byte_offset" computation used to determine
remaining space, wrapping to a huge value and defeating the size
check, then write out of bounds through param_entry->data +
byte_offset.

Add qigvm_find_param_validate(), which looks up the parameter area,
checks byte_offset against its size, and returns the offset-adjusted
data pointer and remaining size via output parameters instead of the
raw QIgvmParameterData entry. This keeps the byte_offset arithmetic in
one place instead of repeating param_entry->data + byte_offset and
param_entry->size - byte_offset at every call site.

Use it in the vp-count and environment-info handlers, adding an
explicit check that the fixed-size write fits in the remaining space.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 68 +++++++++++++++++++++++++++++++++++-------
 include/system/igvm-internal.h |  6 ++++
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..8c07f2ce5e 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -101,6 +101,39 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
     return NULL;
 }
 
+/*
+ * Look up a parameter area and check that param->byte_offset falls within
+ * it, in one step. On success, *data and *size are set to the
+ * offset-adjusted write location and remaining space within the parameter
+ * area, so callers never need to touch param->byte_offset themselves.
+ */
+bool
+qigvm_find_param_validate(QIgvm *igvm, uint32_t parameter_area_index,
+                          const IGVM_VHS_PARAMETER *param,
+                          uint8_t **data, uint32_t *size,
+                          Error **errp)
+{
+    QIgvmParameterData *param_entry;
+
+    assert(data && size);
+
+    param_entry = qigvm_find_param_entry(igvm, parameter_area_index, errp);
+    if (!param_entry) {
+        return false;
+    }
+
+    if (param->byte_offset > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
+                   param->byte_offset, param_entry->size);
+        return false;
+    }
+
+    *data = param_entry->data + param->byte_offset;
+    *size = param_entry->size - param->byte_offset;
+    return true;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -682,17 +715,24 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
                                     Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *data;
+    uint32_t size;
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
+                                   &data, &size, errp)) {
+        return -1;
+    }
+
+    if (sizeof(*vp_count) > size) {
+        error_setg(errp,
+                   "IGVM: vp-count parameter exceeds parameter area "
+                   "defined in IGVM file");
         return -1;
     }
 
-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
+    vp_count = (uint32_t *)data;
     *vp_count = 0;
     CPU_FOREACH(cpu)
     {
@@ -707,17 +747,23 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
                                             Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *data;
+    uint32_t size;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    if (!qigvm_find_param_validate(ctx, param->parameter_area_index, param,
+                                   &data, &size, errp)) {
+        return -1;
+    }
+
+    if (sizeof(*environmental_state) > size) {
+        error_setg(errp,
+                   "IGVM: environment-info parameter exceeds parameter area "
+                   "defined in IGVM file");
         return -1;
     }
 
-    environmental_state =
-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+    environmental_state = (IgvmEnvironmentInfo *)data;
     environmental_state->memory_is_shared = 1;
 
     return 0;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..6526b5055c 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -81,4 +81,10 @@ QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp);
 
+bool
+qigvm_find_param_validate(QIgvm *igvm, uint32_t parameter_area_index,
+                          const IGVM_VHS_PARAMETER *param,
+                          uint8_t **data, uint32_t *size,
+                          Error **errp);
+
 #endif

-- 
2.55.0


