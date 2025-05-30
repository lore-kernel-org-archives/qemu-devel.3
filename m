Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A28C5B553
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwU-0001vn-1y; Fri, 30 May 2025 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwM-0001WD-VA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwL-0006wB-BS
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qQiMhu5qtUDGSXmmKmRPEC3477kqRiFUy1uF23bvJc=;
 b=g3qzX5whL3kfpZ7jHLK756h6RgX+vRNr9fVdt+bZ9Bd/bf2LreuDpAPdvp9ZAxQS14gY0J
 6TSkFSP8BrPoH7EHsZnbcd62DJQl/4Y4PTKfX9wpbF/so2bU6BktagDkU2FFwpzqrdzKfj
 8/aWutBqHtjSQiuuC5vaj4lMW1AAuZA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-qTzvd7-_M1CHuDTL0-A95g-1; Fri, 30 May 2025 03:14:02 -0400
X-MC-Unique: qTzvd7-_M1CHuDTL0-A95g-1
X-Mimecast-MFC-AGG-ID: qTzvd7-_M1CHuDTL0-A95g_1748589241
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb23361d73so272963566b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589241; x=1749194041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qQiMhu5qtUDGSXmmKmRPEC3477kqRiFUy1uF23bvJc=;
 b=LY4X/hFf8m3F1A35SKVMWgPj91Lqst73FbzGtB0bRir7qnneJL0VNtA3NFMqUqt2nM
 zZEMHdn4gVK3aPhdw5dRhNigMaP1MiyTKFiN+5hBoJk8W8i0ucC+IO5s8w5JwMNoBJd8
 ioOm5GbQmIS/0YIdV4aGIsi5FdAFkkbHorO36A2pmJ3iZUOTDso/f+dh3/tJqHXZuHur
 2ktxbAnHYkq34fnM9JGZoY4qaGnEB/Vk7OCb2c3rL0J877AuqbjCC7IgjPmgF6caMBGr
 xHytn+XqfXj6WU1mcjkd2RIad1etGJNHi0je984vghb32rTAKcqFLhSGYeOH8lLI6g8t
 CQQg==
X-Gm-Message-State: AOJu0YxOEdafWlZuTxU4mcMpPhKaZsprWAYA1BWPNSBWDFd79UWwrv8J
 RPOhRKiCywFyiVVU7An1Y3HHo2t611gvkLVaASxcrfjA/7eaGyeOIJLiH7Vsl9t644YeeDb6gtL
 eOxQdBwElAJdsGZ05rxSuuurwIZYM4r4cZ1NOpKgWlKvNqiC3djxadHj0Hi/pps68ulrjtoHzds
 P5BIJN0XZ0SRJTlEZDYqmEPuqeP//X7GCOCJfFy5Vt
X-Gm-Gg: ASbGncsMTeJIYbpZ6wkqdIi1hiuqRpTlZZhCm+fBOMt00Ai991CCr+9jBIEttvtgBiA
 JFLefN9SstLa5xCqEusnoQ4t8R3s7cwVQiOzwesXJrsoNCra05Yt1ILTODw/wMlGrqzmOXW7RwI
 dCBYPGGFIN2a+AcGNAnBWywbFn2sUWVz92btE/pHnpGDfVDfUP6i+lECxl/w//qZdC/Qbsimhwk
 o5tM/xWPTVrztoQbad0Plf5u4vjYVCuxqYdY42LRnEKYRUDZ2+HYmzX9NDQA/EkRgALE0SE9x8o
 C5QMTcX6Y8lppQ==
X-Received: by 2002:a17:906:c10e:b0:ad5:6258:996f with SMTP id
 a640c23a62f3a-ad8b0e38931mr521462766b.19.1748589240615; 
 Fri, 30 May 2025 00:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24YAxBnNXs+mTebnZrEo8nq9jsM9NLS21+IBjXf83G1+nvJCtAxS+q20y/v3TyezcpRiFUQ==
X-Received: by 2002:a17:906:c10e:b0:ad5:6258:996f with SMTP id
 a640c23a62f3a-ad8b0e38931mr521459666b.19.1748589240075; 
 Fri, 30 May 2025 00:14:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fed8bsm276433266b.28.2025.05.30.00.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chao Peng <chao.p.peng@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/77] i386/tdx: load TDVF for TD guest
Date: Fri, 30 May 2025 09:11:58 +0200
Message-ID: <20250530071250.2050910-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chao Peng <chao.p.peng@linux.intel.com>

TDVF(OVMF) needs to run at private memory for TD guest. TDX cannot
support pflash device since it doesn't support read-only private memory.
Thus load TDVF(OVMF) with -bios option for TDs.

Use memory_region_init_ram_guest_memfd() to allocate the MemoryRegion
for TDVF because it needs to be located at private memory.

Also store the MemoryRegion pointer of TDVF since the shared ramblock of
it can be discared after it gets copied to private ramblock.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-17-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h | 3 +++
 hw/i386/x86-common.c  | 6 +++++-
 target/i386/kvm/tdx.c | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index d39e733d9fc..b73461b8d8a 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -30,6 +30,8 @@ typedef struct TdxGuest {
     char *mrconfigid;       /* base64 encoded sha348 digest */
     char *mrowner;          /* base64 encoded sha348 digest */
     char *mrownerconfig;    /* base64 encoded sha348 digest */
+
+    MemoryRegion *tdvf_mr;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -39,5 +41,6 @@ bool is_tdx_vm(void);
 #endif /* CONFIG_TDX */
 
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1b0671c5239..b1b5f11e739 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -44,6 +44,7 @@
 #include "standard-headers/asm-x86/bootparam.h"
 #include CONFIG_DEVICES
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen.h"
@@ -1035,11 +1036,14 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
+        if (is_tdx_vm()) {
+            tdx_set_tdvf_region(&x86ms->bios);
+        }
     } else {
         memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
                                bios_size, &error_fatal);
     }
-    if (sev_enabled()) {
+    if (sev_enabled() || is_tdx_vm()) {
         /*
          * The concept of a "reset" simply doesn't exist for
          * confidential computing guests, we have to destroy and
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 93a16a1aaa8..0f5acbf980b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -137,6 +137,12 @@ static int get_tdx_capabilities(Error **errp)
     return 0;
 }
 
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
+{
+    assert(!tdx_guest->tdvf_mr);
+    tdx_guest->tdvf_mr = tdvf_mr;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(cgs);
-- 
2.49.0


