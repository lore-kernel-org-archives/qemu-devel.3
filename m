Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB1ACD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdNJ-0007C8-8D; Thu, 11 Jun 2026 07:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXdNH-0007Bs-JV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXdNF-0004Gu-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781176499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e05Y74bqj4LuPcuNyrGYpBQ2Db1rYe3gnWJlN54b0Rg=;
 b=WmrqB9CCboJOYtlEwdvh/RuC67nTZMNvhwueOz+ZpJXHmXRJdzyS70S5zz+9OvAzr47nbi
 ml1PBZTR5+0y3EAQ77BDJ+EgZ9tEZOmzu+p1gbzfKcFPE9nxoJ7YEmSG37ALw+h7FAiuOl
 cF+HJzH40J/dPNsKAjvdUJHQ9dujZ8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199--MB4ZIjfPTuvoxPDI3JmqQ-1; Thu, 11 Jun 2026 07:14:55 -0400
X-MC-Unique: -MB4ZIjfPTuvoxPDI3JmqQ-1
X-Mimecast-MFC-AGG-ID: -MB4ZIjfPTuvoxPDI3JmqQ_1781176495
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b3f53c81so35799715e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781176494; x=1781781294; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e05Y74bqj4LuPcuNyrGYpBQ2Db1rYe3gnWJlN54b0Rg=;
 b=aycw0ttkzcU7vqLnav+/qbg4a8llVjYJ0KBmkaUDquj2SzZgW503+QwhwYBAh4pA6Y
 iGE4pvQ7YVl4FFYHtJ6n6JMx/qcSPggM3sbFmh9tU85JlZtL1CfBRSbqwLrafvdyWUeA
 zFGlfuLtA5wYD2T/FnAK+IVVQIvM7b4JLAmNxgEYh5mjgU3a62eN6vAdJJydTOU+vLTe
 mzfAPsXD7jmsiJF7pcPDKVw5HImL7ydnymlWucDDZqealSMJqbiBSdYTKbRo32DZXU1U
 10kA7wAq28w8nTcNpADPJxmhzGUfHO6SVRrKLbpccoOB1GVsXfPQpu3Q/x1yHTvVzcSO
 9yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176494; x=1781781294;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e05Y74bqj4LuPcuNyrGYpBQ2Db1rYe3gnWJlN54b0Rg=;
 b=YxJc6jI1FhHJ2taOSUdnSqb4pdBHoGBApfQ1Piji+8MZvitGKs1BPgpHrZ+EnDHX7L
 /aXfPCq/LlqEBtP46RbURyl8X9ugL2ZozKKakFfOVdSiV7k2MxdwgddXr4Jfq9Z99Inc
 kH6AjWV2ov/+BdpcqO904l0ACJM6gWRmeiCHbG4ATs+ShlRbYBseMwiNGXvGREYoVzXR
 ppBpYGSBduoNVXS1Q40Uzp44Oj2/nmnTU8NS70daZOw5AvBpHEiJ/QBtGQvnGFgPHuig
 HVcIVL8Daj03JTgCASxNJLWaGDXqXX+AGYhtQ6JSoh/xeAU6HX9UdRr2d8pC2r6dgYdN
 a+DQ==
X-Gm-Message-State: AOJu0YxPNdGddmtNk7zpK80HbB4kVauXxm8EoYqIYiCqXUV2dnnOJk9B
 vkPBeVqemBsG2afOUPqfyMhmgpgFUe+xa6yFPHKEPA4YufROPDfspojfcKUusS4t80Y19CppqcY
 9P8KfwYaUC778RA4KO4TWgQ+s2WTiW1tCMyUYfsl0bsGQBKNvt+1lgj8A
X-Gm-Gg: Acq92OFsm1CagIs2a7sGpjabdN8cAAPXroiHL7OYIqIptdRVMy/QXRZCqxX2bd5UYpx
 IUERSsJS9U2i4Th9NSI7hbEsgaT48otTo8V2tZIHGxZlBlZdK9dL3TvZ9mGar7bG7dpxPx0zXgi
 rDhOo2hTJex71QN0v5YJd7L3CamAL4pLwHUECQ/gqKBPut6OQOzM41O61SV0Q7pFvuu03SrVOOv
 UvWGEMECkaHtoUxyrMPWzD0KYO6uGqL0b/UinkPl9sMxY95f/vZ4urXUOhBuey5pZiPLA54y02Y
 68ogq+RSd6K7S3HSUj8ZsdrCmDFzli8IrlrgpogxurqSt02UsM32hy3S7tKJLnYeWZ0MLFtVm2D
 DtDvcHTLTtNnhHPJxzVRysX3XfcvYSLZa3m1xNK0TseixFQFCC73tlwLcn+9XhI15Ldyy0+l/ko
 aXxXjam6aEGJOiRLM1smb1bCUNBoQ=
X-Received: by 2002:a05:600c:8b23:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490e55bd82bmr30479675e9.5.1781176494537; 
 Thu, 11 Jun 2026 04:14:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-490e55bd82bmr30479035e9.5.1781176494084; 
 Thu, 11 Jun 2026 04:14:54 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ead0sm64662605e9.3.2026.06.11.04.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:14:53 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 11 Jun 2026 13:14:47 +0200
Subject: [PATCH v3] igvm: add device tree parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBAF4KuQrq2Z/gSqK+9hDIF2kC6gpm0aD
 eHuDqw0MS7fzJtvFpYwekzsXC0sYvHJh5mCOlTMjt18R+4dZSZB1lCD4ZO3MZSpdVS22OaIyGm
 nrOpFj6ZmdPmIOPjnrl5vlEefcoiv/UkR2/S/VwQH3igwje4cAJhLRDd2+WjDxDawyA9EwG9EE
 qKHXmuSrD4NX8i6rm/axATC/AAAAA==
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Coconut SVSM, with the upcoming device tree support [1], will use
the IGVM device tree parameter to discover virtio-mmio and ISA serial
devices instead of relying on the fw_cfg interface, which is
QEMU-specific.

The device tree is packed before copying into the IGVM parameter area
to reduce its size, since IGVM files can define tighter memory
constraints for parameter areas. Packing is done in the generic IGVM
backend rather than in per-architecture device tree setup code, so
that each architecture does not need to handle it individually.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
This device tree will be consumed by Coconut SVSM with the upcoming device
tree support [1]. This will allow SVSM to run on a normal CPU
(not AMD SEV-SNP) and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

[1] https://github.com/coconut-svsm/svsm/pull/1006

To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Oliver Steffen <osteffen@redhat.com>
---
Changes in v3:
- Device tree is packed in igvm core code. [Gerd]
- Dropped microvm patch.
- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com

Changes in v2:
- First patch introduced a shadowed variable, fixed.
- When parameter area is not found return -1.
- Moved `qigvm_directive_device_tree` to backends/igvm.c
- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com
---

Error handling on qigvm_find_param_entry will change once [2] is
merged. I am already using the new approach here.

[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
---
 backends/igvm.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..452715b105 100644
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
@@ -752,6 +757,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    g_autofree void *fdt_packed = NULL;
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
+    fdt_packed = g_malloc(fdt_size);
+    memcpy(fdt_packed, ctx->machine_state->fdt, fdt_size);
+
+    if (fdt_pack(fdt_packed)) {
+        error_setg(errp, "IGVM: failed to pack device tree");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(fdt_packed);
+    if (fdt_size > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: device tree size exceeds parameter area"
+                   " defined in IGVM file");
+        return -1;
+    }
+
+    memcpy(param_entry->data, fdt_packed, fdt_size);
+
+    return 0;
+}
+
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data, Error **errp)
 {

---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


