Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4541BCDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcewt-0005ec-2H; Thu, 25 Jun 2026 03:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewq-0005du-Rq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewo-0003pm-V9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782374189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bixA52GU/9JmhiaZNEoKJbpEC2AbtCO8l58z9HHgeQc=;
 b=SR+NMtlOqcz7SMDMPumv9j14uh7CJQqhDaACHZWRJUR8b4eH8KGEjc8P6qd/mh9mUDV/3R
 CdGadXnnQ7TvpaekKDEbaftnLm9wfp3f4zyAN/7goB19M8CS249K7VRDd1oLGgOrhS4+g6
 0UBdbd4GT7LNAdwlRvPvUkZRc1pCK3w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-NN5bZSrFN9mqqNTX3UG_ig-1; Thu, 25 Jun 2026 03:56:28 -0400
X-MC-Unique: NN5bZSrFN9mqqNTX3UG_ig-1
X-Mimecast-MFC-AGG-ID: NN5bZSrFN9mqqNTX3UG_ig_1782374187
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso1464609f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782374187; x=1782978987; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bixA52GU/9JmhiaZNEoKJbpEC2AbtCO8l58z9HHgeQc=;
 b=cerPzBvLFYd/jLLe8O9fObNdRFkDSFuzV37f48buKAHTmODbiJkmVwFUmAtkhgNoDw
 V1iOQkqPiFUXRQrw2snR/pGFSGt1YeaicsITKAf7iHBZz5X6+RZ5yqCGUGsDt4WybV57
 htUj5/amdhYvm7dixsp3lG+2h0QqMAg4N6CwkEjeSJhRfJeB4gXJwC0/Hr3vr8OYnXmW
 J7UlKMoYgvBPaqq4/tVabwc1Yrxae8olWvDV0IuXfBQukXqkzqWyjA19HyzWKA+uGMJa
 +GF2sNMu21onsOONSQ66X1vBGNfT9iRc6KLlvfP3UmTSQ60Pbioz8DiJz11gG8/UKAIJ
 eMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374187; x=1782978987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bixA52GU/9JmhiaZNEoKJbpEC2AbtCO8l58z9HHgeQc=;
 b=RIadqBtcI83ekX/N1ywEhp0hpVgr7FP0D6FuiQDBtjs/s7tVySPRLaDFL5EJZsSkWp
 qj785BaLvtXIg8wphpOvjsMF5XffT22/JkIumqkJuf+ivqKrCpvZgNuKAKCKxCe5Ao9H
 ZsNN2fO2lPZ8HVKL8x0GpDhlH3Ji3RYio0S/vGosJHGIF5nxNc9oXiUXNG0qoDboQLE8
 e+zDvHUMi6XJxa/PzxW7xe/n65Aypwe6N91EqURQOcXQJ6gssfv4vki0Tecope1AcXrz
 I4mPfjdsrD+9SWtbknazgssxsSkk3u3KAHz0cv58TiRPbkveN1y1Y9QUy2YcaM+U9b66
 OieQ==
X-Gm-Message-State: AOJu0YxuGUfBsRb10yHQPiFqJnGHElxBMIpmKBDKaYpALFzaKEeqYeR/
 zOz598OuGMhC3rL3Ex1efoZ8PmeUnyIWOEYuQvt8r5bb06RcXZg4A/dMqUISpRoRubtVmrGZaKu
 zNH4xypaiLNvSebZHag1yOqZCxgOPjSg+84vPP8t/dK+xAZNtO3NbOJIq4tJ6xwZVgf742OQgt5
 eAOG73XXPdmt/PMdw9+ZSwKw9jR8wMI8FVj/o/Jo6G
X-Gm-Gg: AfdE7ckGng+ZxBQWQhIBDB8s1Oy8qZNri+lEJLxcZWgPGolSchh2ZAnw8VPPJznKpGy
 NGBDPXx39Wk18s6cBk2Nk2YxVGz63UquTtT5GtC3GORb5iMJMMxAY8b/HWsVI3/4EVIlV1oPooH
 FnRClxXQ0Np0r2eBVStSR1q+8foIK3/JQN4mvFRc7reCo9j4Av/ee8uf+KgykqtxCo7li/xarLF
 RVjbbAKHiRu2mhvALsCSulf6b+qgIFt6DyYisNdJ9r4zW/GbkIdBpka2WC+N9Ku9UiuaUs0X0zy
 Q5qgLhMh4hQ0iCgLL7WgmrzFjcCrhYFIUZ/94orUGq+7zgIkRMNuSq+p2j6xcSagt7ZHWo9S+oN
 NUPqtXAiyWKLAacC4vUN1q+AyKdZMaOatWjpJLfaCpb4BRxkzTMaIFq3VZngSHrioPMSew5oXyF
 eL+YuO
X-Received: by 2002:a5d:584e:0:b0:46d:a16b:d1d with SMTP id
 ffacd0b85a97d-46dc1e82acemr1973692f8f.43.1782374186803; 
 Thu, 25 Jun 2026 00:56:26 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:46d:a16b:d1d with SMTP id
 ffacd0b85a97d-46dc1e82acemr1973620f8f.43.1782374186343; 
 Thu, 25 Jun 2026 00:56:26 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46de7effe5bsm1899390f8f.5.2026.06.25.00.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 00:56:25 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 25 Jun 2026 09:56:20 +0200
Subject: [PATCH v5 2/2] igvm: add device tree parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-microvm_device_tree-v5-2-bcff11fd6d1c@redhat.com>
References: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
In-Reply-To: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
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

Error handling on qigvm_find_param_entry will change once [2] is
merged. I am already using the new approach here.

[2] https://lore.kernel.org/qemu-devel/20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com/
---
 backends/igvm.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 backends/meson.build |  2 +-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3f4b97a5d4..53e96fae25 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,10 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifdef CONFIG_FDT
+#include <libfdt.h>
+#endif
+
 #ifndef IGVM_VHT_OPTIONAL_BIT
 #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
 #endif
@@ -119,6 +123,10 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp);
+#endif
 
 struct QIGVMHandler {
     IgvmVariableHeaderType type;
@@ -149,6 +157,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+#ifdef CONFIG_FDT
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
+#endif
 };
 
 static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
@@ -780,6 +792,49 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+#ifdef CONFIG_FDT
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
+    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
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
+#endif
+
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data, Error **errp)
 {
diff --git a/backends/meson.build b/backends/meson.build
index aabfaea5fd..8792c58c36 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -35,7 +35,7 @@ endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 
-system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c'), fdt])
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 

-- 
2.54.0


