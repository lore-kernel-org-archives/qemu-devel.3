Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3447CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFtz-0006oj-Bm; Wed, 10 Jun 2026 06:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtx-0006o4-Qd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtw-0003cn-9f
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvqoPdvz49D5UWPcRsxN9yjil/ct7bRZ2hX5ouIvsVc=;
 b=Fm1hm2eP+sO5ClORbmgULDnD8vmfgohxRs/xI70yTOi25L8gAuKkQGYxK1M3Z5aHFfsT8D
 V8fq3XrnBuxyc1V/Gds4o5ew6zaOBlGOE/cKwYWDtz/SUuGxZkh9AFwLk+wll+47five+0
 YkJaV3gRB2IEG7QxeDPnTzbnIYtS7H4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-kLqxdxT7P2i1tKdfoTr-Uw-1; Wed, 10 Jun 2026 06:11:10 -0400
X-MC-Unique: kLqxdxT7P2i1tKdfoTr-Uw-1
X-Mimecast-MFC-AGG-ID: kLqxdxT7P2i1tKdfoTr-Uw_1781086269
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso52879455e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781086269; x=1781691069; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bvqoPdvz49D5UWPcRsxN9yjil/ct7bRZ2hX5ouIvsVc=;
 b=p7thIh//R/7kLnjXFXYr+5s2MFp8WhzI/jROBpTx48UEZnN6w6PZmPgcMNeRfs86De
 yK2i2ayLYZEgbufR4WUrfhqRAmZTviHgfQmGQVFV0gchb5oxy36ErMR44UUjU9K6tdNj
 qip/BNM316cpUXivnuf09Dm+Aw6GRy8hhgSx5ZAUK4SthYAwW0M9AcdNhaYoG/DvgAIY
 m6W9GidTn++2Nic6csTyQxwGpN4p0jpQI1RT8qVRcvGFQkio5IpXF+hA6UedRgBw76JZ
 5M3wRgIDdU6zffJwRaDChD6n5o0O4KVWsU0VnBu9EspbQo22hvHwr0rl7PiJqO0y0mgr
 mk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086269; x=1781691069;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bvqoPdvz49D5UWPcRsxN9yjil/ct7bRZ2hX5ouIvsVc=;
 b=DaP3/VqwfvaWMDictByuK1I9GAUcvDalcBsPpGgk0/sxCZgx8Gt7l0lTT9OT3xy/Un
 LRAdD4GtDVB1LGkXkYCtrVRMiqgO0iNsasUtrbjO82TpPqE4xj4uqxS4He++/ZYu2/wm
 dHgOxTBu3mzf8xCzUIu6ZRU8zpM5Pje/14tR1MBolRSJI3yjN7tGS6whiCiTRiGedyC1
 Yxz6miAflx2AGuTOEV85ba8jkoFnr+0N1/elZCl2CzkAMF1tEQJBfqBYogCC5qll9UKR
 Bh8M1w9Updlzv0CRWNVTCOslBJLfUzaQ+/kIX2ZCrWaftQOeB4A/Obmwzx7jb8t/piYg
 9QIQ==
X-Gm-Message-State: AOJu0YwzgonZQDelEC3bQYAaZYuYCtRwzeun/TwnFaCPmp0rqmM60Bz4
 qupB8B0PZygOZ1MQjDsVZ4uPt0vq8xXDY2mCZGjyVxI1JwzXr4qJvpxDaLTi5hnTCbthW4S+mVA
 Gbrc8gqsMnMq6kJYaI/0vPUZnc0Cb8V/o/HrMW5/8oWC6+rPim2k1bDvy
X-Gm-Gg: Acq92OFagkj52fJVbO5d1N/lgQt1UrlYI+RrZfNlg3Nv2BT+mBTxUSpbddRgwm9NDij
 8KW4P/beN0X34oEmzQJR1liO+Hc2w5vXWnKfdcDDZO7YK0obyCbEJSQkbKS0sAaP1wgBHK2rEDQ
 xgHe2S9DVdPtPl7HsAuFiWYyI/P6tXcA1mm4WawOlL2LyioBCXqojZ77YUzqXWa1Q2q5DRQOrSP
 C/1QXJtptMXkFE/t5JbVMfQ4Sfe+xjnwR9/CdB865I6cabdVsEF3BoSZmmWPzR44w2CIFzEq/0O
 ZSQDtbjfvg2te4Hcv26AlkPDIahVgImcmxKTL9d7pNOGZJOgSwGxbHjtgcQpkNR/7K2+rU59URw
 QqaLe6prPSJFSPdpXLxCBZVrOaX88lGe94iwqdiIzZ0c8umI2edc7hP14QVVZo+7AsTSdQBUTRq
 amW/avvdc6e5W7764J3K506s7g27E=
X-Received: by 2002:a05:600c:314b:b0:490:bfae:55cb with SMTP id
 5b1f17b1804b1-490c25f5df4mr363677485e9.21.1781086268806; 
 Wed, 10 Jun 2026 03:11:08 -0700 (PDT)
X-Received: by 2002:a05:600c:314b:b0:490:bfae:55cb with SMTP id
 5b1f17b1804b1-490c25f5df4mr363677135e9.21.1781086268428; 
 Wed, 10 Jun 2026 03:11:08 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm73334514f8f.4.2026.06.10.03.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:11:07 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 10 Jun 2026 12:10:58 +0200
Subject: [PATCH v2 2/2] igvm: add device tree parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-microvm_device_tree-v2-2-4fb44730c49f@redhat.com>
References: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
In-Reply-To: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Coconut SVSM, with the upcoming device tree support[1], will use
the IGVM device tree parameter to discover virtio-mmio and ISA serial
devices instead of relying on the fw_cfg interface, which is
QEMU-specific.

Because this code is architecture-independent, it is implemented in
the generic IGVM backend.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

---

Error handling on `qigvm_find_param_entry` will change when [2] will be
merged. Here i am already using the new approach.

[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
---
 backends/igvm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..de27db0c9f 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -25,6 +25,7 @@
 
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
+#include <libfdt.h>
 
 
 /*
@@ -100,6 +101,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp);
 
 struct QIGVMHandler {
     uint32_t type;
@@ -130,6 +133,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
@@ -752,6 +757,41 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+/*
+ * Process device tree IGVM parameter
+ */
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    uint32_t fdt_size;
+
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
+    }
+
+    if (ctx->machine_state->fdt == NULL) {
+        error_setg(errp, "IGVM: device tree not available");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
+    if (fdt_size > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: device tree size exceeds parameter area"
+                   " defined in IGVM file");
+        return -1;
+    }
+
+    memcpy(param_entry->data, ctx->machine_state->fdt, fdt_size);
+
+    return 0;
+}
+
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data, Error **errp)
 {

-- 
2.54.0


