Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DE0C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSLxd-0004cZ-T9; Thu, 19 Jun 2025 16:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxZ-0004bW-1w
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxU-0004Yn-SG
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750365244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPyEsEyR+eeawbg8Mgoqk136AaGHZYCr52XL3CFj5p0=;
 b=GZxm5CNjt2Y0+zxKCSUMDDZ7SGtuBLmStPLBxxulxSbgallUGxTXEvYH5Yae49PyjjYwJs
 V+CmEkd164044kZ9aQpenAJtkKe4vh6xOgqi6TtLqLDiAVXlKF75lHtH9DSxVLa9e2SyQv
 EBVtIC1LZZ8mT3ErKRZMafECRtFYp/0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-izfQ6bkgMTyqQoyAOwGJjA-1; Thu, 19 Jun 2025 16:34:02 -0400
X-MC-Unique: izfQ6bkgMTyqQoyAOwGJjA-1
X-Mimecast-MFC-AGG-ID: izfQ6bkgMTyqQoyAOwGJjA_1750365242
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb94dbd01fso119339966b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365239; x=1750970039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPyEsEyR+eeawbg8Mgoqk136AaGHZYCr52XL3CFj5p0=;
 b=nGn3a9wYsPs7OZfaaYRC2TfpiEO2wwXZ4QFhf4wiQ74swuu3UIrldsxUuyqQnUafEh
 B+Ew7zRRwNpDfHWU64Rhir+OdUOC8WDc0QUbfAH/ix3SaVzBnKfU4iV60OvH1eiPDpmJ
 G0Iz3kikkjS/7/07JklNe8/pLMaGV+vYaiXSpIIx1EjSXi0YNx5jzm04620dNkFvcKxH
 VsjnrafAZlgOHwkgrvTMmkiX8LnImpIjlkRF0FQf50T+WcpkgCRVGj8N8+5BMjWmrIqw
 pwEuCIS9q+Arx2NlSOx/RS40Nf0prykK10wLUf1lJqDs614hDPDOZJh+ATKgzYrPTZEP
 Imlw==
X-Gm-Message-State: AOJu0Yxfq1WOzV+wYCQiBGYCIsVwRoFR0W/8G6elSUrmBp15+fQnEDrH
 uJzOfhLG3+5YUCAa97vaiUy7uKjr8tp3JDcS0G4u5X//hEQN9fFh4AX9bDxL1P33qtpDnODorHe
 KJCieC6Kvbde1QAnp+Zyl88PLjGO0AqtlocbMXRBZz86kTl2MO9/4abpCepG7b8wCWr/4Ehwfyu
 9D1LClZkmyilH3YEJ72aJntCCWxc9CDYqT7SpLUtJu
X-Gm-Gg: ASbGncueXz5AqYrUhPpN1WXVRhnOVkTMrCb70drZWPBOGForHxLVjZRruxzJW8iiRP8
 ejqSLdmthZ06ROhMVVdDDqmkuFOCvx2hjDvZr8Im9WfenlcmA7acol28jDnjHKjBq+8NdquGRwO
 yV5LzaHNxQ7q68/S0Xb6YlZqitJru5FBWq3q068xTHQkKipANdv3yV6uLFp7iOd4Pgk6zMG+tvk
 6VDPmStLROEyioePZWWhNIYd8UuMukzm8QILzDyHTw0Uhl73limEXiTodYl2UuFoFcbpDCnLpjP
 01foeBJ9fiisLQL94johYTDBoQ==
X-Received: by 2002:a17:907:94d5:b0:ad8:914b:7d15 with SMTP id
 a640c23a62f3a-ae057ce90bbmr27097466b.7.1750365238696; 
 Thu, 19 Jun 2025 13:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFspa6qEcbWBjcSsfoBKt9VZ8tfi8VnIPOGLQGWt4K7GlrErwK1e/N1WYI5/GndLiYNxd5G3w==
X-Received: by 2002:a17:907:94d5:b0:ad8:914b:7d15 with SMTP id
 a640c23a62f3a-ae057ce90bbmr27094966b.7.1750365238220; 
 Thu, 19 Jun 2025 13:33:58 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0541b752asm41145766b.127.2025.06.19.13.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 13:33:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] i386/tdx: handle TDG.VP.VMCALL<GetTdVmCallInfo>
Date: Thu, 19 Jun 2025 22:33:50 +0200
Message-ID: <20250619203351.393786-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619203351.393786-1-pbonzini@redhat.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Binbin Wu <binbin.wu@linux.intel.com>

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.h      |  9 +++++++++
 target/i386/kvm/kvm.c      | 12 ++++++++++++
 target/i386/kvm/tdx-stub.c |  4 ++++
 target/i386/kvm/tdx.c      | 12 ++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 8dd66e90149..0dd41d5811a 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -21,6 +21,14 @@ typedef struct TdxGuestClass {
 /* TDX requires bus frequency 25MHz */
 #define TDX_APIC_BUS_CYCLES_NS 40
 
+#define TDVMCALL_GET_TD_VM_CALL_INFO    0x10000
+
+#define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
+#define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
+#define TDG_VP_VMCALL_INVALID_OPERAND   0x8000000000000000ULL
+#define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
+#define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
+
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -61,5 +69,6 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 int tdx_parse_tdvf(void *flash_ptr, int size);
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 56a6b9b6381..8ef29fc1fb1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6170,6 +6170,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             break;
         }
         break;
+    case KVM_EXIT_TDX:
+        /*
+         * run->tdx is already set up for the case where userspace
+         * does not handle the TDVMCALL.
+         */
+        switch (run->tdx.nr) {
+        case TDVMCALL_GET_TD_VM_CALL_INFO:
+            tdx_handle_get_tdvmcall_info(cpu, run);
+            break;
+        }
+        ret = 0;
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 720a4ff046e..62a12a06775 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -18,3 +18,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 {
     return -EINVAL;
 }
+
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
+{
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 2284167141a..ef10a193474 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1120,6 +1120,18 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
+{
+    if (run->tdx.get_tdvmcall_info.leaf != 1) {
+	return;
+    }
+
+    run->tdx.get_tdvmcall_info.r11 = 0;
+    run->tdx.get_tdvmcall_info.r12 = 0;
+    run->tdx.get_tdvmcall_info.r13 = 0;
+    run->tdx.get_tdvmcall_info.r14 = 0;
+}
+
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
                                         char *message, uint64_t gpa)
 {
-- 
2.49.0


