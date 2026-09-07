Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB3C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aoO-0004BU-3O; Mon, 07 Sep 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoL-0004AG-8O
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3aoJ-0001v4-DZ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788793142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvPXE8g/apTypGq/sMMTB6yOGdKYamBM905yKoKLsp8=;
 b=Z9i4cMUJ06d6STvNXaEr/nycHoWm+ezZkoF74rAfhIpYlRih3nWVHeV/6xze8AX69PKCmz
 +mcR/W7Du9U9+DjVihkN8WHnBdr3oQymPmYD9RDvX99FIYmZIeCOPM2wHOtuq45ZTC3lnc
 SPPEBb86h9304uWZokQHqLChG23O8Lo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-x3YqbzLnO2ijSThIrc7WpA-1; Mon, 07 Sep 2026 10:59:01 -0400
X-MC-Unique: x3YqbzLnO2ijSThIrc7WpA-1
X-Mimecast-MFC-AGG-ID: x3YqbzLnO2ijSThIrc7WpA_1788793140
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482f763db88so2069458f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788793140; x=1789397940; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvPXE8g/apTypGq/sMMTB6yOGdKYamBM905yKoKLsp8=;
 b=QnMSCGxiLlrs+kkedFSqsW7rXQD4J0uiEYEbPMXpkyr/RjIhbY9xG/cXY2KIcBw/22
 ymrFvX5+uP7j3bY7ov4UU8tYA5k+p4HKhpDb0aEdAxSkIbQUutOfViTAOZ2iIBecyxp2
 H3FKvcS94FKcFWkUbwMsbr+iy0hPkeJz0JT5qDVcXRBJzhsituADHKf5DwdorYRWocWj
 PH0arp1kICC18YYYoKVtY0RJKbbjXumk6RD49f+5a9QEYCX2mJACpW6Tah1yG7BCJNBb
 0WymeLR6A0RYFJxWmUs7qO4lPaWVSDWE1qXPC+DFoCgCF4KEnPz7TQJloH3xL8Kqlp5e
 FuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793140; x=1789397940;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bvPXE8g/apTypGq/sMMTB6yOGdKYamBM905yKoKLsp8=;
 b=fwZen7opsWfwWVBs8WBzOUGHg6JkpAGx2lPS2T+H5O0/a73Z2npyjv0W4L0QTTVLaz
 1+Hv7tNwUxKnOKJFyaweJei9fZ02yTw3aaviduIEyHepxsKqcQR7GW91kPjkfmaKXDtN
 BeDADOkh4nJW/x4/tIpLA81jtBRZGx5iSVZNxokMuSI7armDfk/AZFBwtGPKUEFZzID9
 bif79xl5vxu/UqaibR571T6mO73MDeEh0Me99XIVHtHKcYzo44rhp+xAoISSzGaviyqR
 DhIm0OgC2ZVKyWW7aUxk759GqTvWsHQ+A3om4Mbm9qo1o67hLQlgA8NARjfNpPUjI1eT
 wdCw==
X-Gm-Message-State: AFuF++k8yT0OPIDo9pqOWfW/nzmzK9rrxnfAFUPQ3aOFM/PSgybUW1vi
 /ZH9jl5PL7cCpdBEWyl2DQw3EXXf5n/zk/Fe6XRzXC1a7YjvAx87xzwR8FPBMVbnjUD63oe2lrQ
 1gMsLH3R/S1d2iHiWB2s4QGHBdEx4lYSGaJ8fbIsNYkTZn8O/5LMmsZnl
X-Gm-Gg: AYBFou2tzi2lB1h7jevYfj1HE9EAgBoFxud5vuZxini+NMKErDGfLl6JTygSDyQ+zOJ
 whkGZn8Ml5Fn4gREfDsbT86a+ZwqdUFPCiZJCkOp8eL7TPd647k/wkg5LYXD3xRjmT4Pq6Gbv1H
 /Y3IKX8e+kdk5T8RRToDemTdivDflIOxB0cGxYEnZsnkUj4wnZ8LcayPenqqfmWApBSGcDeW/WB
 cFGI24JSNu+h2wk7+zd1D5CDUqdgFqUGgxdVUXUIEpXhwTFc0P4KN4d8JEu4zdQLjnBd/6kwZX7
 qPdNv5pdBvSKWSAYP9CSvWbyhrTV9WvUbjD42pNq3+1JN0dDV2z7bgD5YQv6gWAszi7GPpcKj3X
 2iGbWc5xQnf1InNlKznr2NXw/Fx1OzyxutnI9G5uOKQgxstJbWdyUVqlGe97YFlLdcMHL
X-Received: by 2002:a05:600c:a40f:b0:49c:fa21:e74b with SMTP id
 5b1f17b1804b1-49cfa21e9a7mr157863315e9.33.1788793140390; 
 Mon, 07 Sep 2026 07:59:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a40f:b0:49c:fa21:e74b with SMTP id
 5b1f17b1804b1-49cfa21e9a7mr157862925e9.33.1788793139932; 
 Mon, 07 Sep 2026 07:58:59 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm22547547f8f.11.2026.09.07.07.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:58:59 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 16:58:55 +0200
Subject: [PATCH v3 1/2] igvm: validate byte_offset before using it in
 parameter directives
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_offset-v3-1-bcffcefc0985@redhat.com>
References: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
In-Reply-To: <20260907-fix_offset-v3-0-bcffcefc0985@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
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

Add qigvm_get_param_data(), which looks up the parameter area,
checks byte_offset against its size, and returns the offset-adjusted
data pointer directly (NULL on failure), with the remaining space
returned via an output parameter, instead of the raw
QIgvmParameterData entry. This keeps the byte_offset arithmetic in
one place instead of repeating param_entry->data + byte_offset and
param_entry->size - byte_offset at every call site.

Use it in the vp-count and environment-info handlers, adding an
explicit check that the fixed-size write fits in the remaining space.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c                | 70 +++++++++++++++++++++++++++++++++++-------
 include/system/igvm-internal.h |  6 ++++
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..a8340d7d55 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -101,6 +101,39 @@ qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
     return NULL;
 }
 
+/*
+ * Look up a parameter area and check that param->byte_offset falls within
+ * it, in one step. On success, returns the offset-adjusted write location
+ * within the parameter area and sets *param_size to the remaining space
+ * there, so callers never need to touch param->byte_offset themselves.
+ * Returns NULL on failure.
+ */
+uint8_t *
+qigvm_get_param_data(QIgvm *igvm, uint32_t parameter_area_index,
+                     const IGVM_VHS_PARAMETER *param,
+                     uint32_t *param_size,
+                     Error **errp)
+{
+    QIgvmParameterData *param_entry;
+
+    assert(param_size);
+
+    param_entry = qigvm_find_param_entry(igvm, parameter_area_index, errp);
+    if (!param_entry) {
+        return NULL;
+    }
+
+    if (param->byte_offset > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: byte_offset 0x%x exceeds parameter area size 0x%x",
+                   param->byte_offset, param_entry->size);
+        return NULL;
+    }
+
+    *param_size = param_entry->size - param->byte_offset;
+    return param_entry->data + param->byte_offset;
+}
+
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
@@ -682,17 +715,25 @@ static int qigvm_directive_vp_count(QIgvm *ctx, const uint8_t *header_data,
                                     Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     uint32_t *vp_count;
     CPUState *cpu;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
+                                       param, &param_size, errp);
+    if (!param_data) {
         return -1;
     }
 
-    vp_count = (uint32_t *)(param_entry->data + param->byte_offset);
+    if (sizeof(*vp_count) > param_size) {
+        error_setg(errp,
+                   "IGVM: vp-count parameter exceeds parameter area "
+                   "defined in IGVM file");
+        return -1;
+    }
+
+    vp_count = (uint32_t *)param_data;
     *vp_count = 0;
     CPU_FOREACH(cpu)
     {
@@ -707,17 +748,24 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
                                             Error **errp)
 {
     const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
-    QIgvmParameterData *param_entry;
+    uint8_t *param_data;
+    uint32_t param_size;
     IgvmEnvironmentInfo *environmental_state;
 
-    param_entry = qigvm_find_param_entry(ctx,
-                                         param->parameter_area_index, errp);
-    if (param_entry == NULL) {
+    param_data = qigvm_get_param_data(ctx, param->parameter_area_index,
+                                       param, &param_size, errp);
+    if (!param_data) {
+        return -1;
+    }
+
+    if (sizeof(*environmental_state) > param_size) {
+        error_setg(errp,
+                   "IGVM: environment-info parameter exceeds parameter area "
+                   "defined in IGVM file");
         return -1;
     }
 
-    environmental_state =
-        (IgvmEnvironmentInfo *)(param_entry->data + param->byte_offset);
+    environmental_state = (IgvmEnvironmentInfo *)param_data;
     environmental_state->memory_is_shared = 1;
 
     return 0;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 9e9fa1d9af..f5ee2d5b1b 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -81,4 +81,10 @@ QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index,
                        Error **errp);
 
+uint8_t *
+qigvm_get_param_data(QIgvm *igvm, uint32_t parameter_area_index,
+                     const IGVM_VHS_PARAMETER *param,
+                     uint32_t *param_size,
+                     Error **errp);
+
 #endif

-- 
2.55.0


