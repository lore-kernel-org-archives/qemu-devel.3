Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED13C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyr-0006Oa-Ll; Fri, 30 May 2025 03:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwY-00029X-5s
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwW-0006xE-0X
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzSgMvSn5kQIqpkAjVo/+xXom1PxGg1FgYj2rm/RCjk=;
 b=c0bi+6/KCPB+fibYayYhVRAhdRTdNX2iJpD2q1hqDlIePnzVFZ/GTR6uxNyTrsrNG+YywS
 EK9T8zUT0aqonWHfGT4gRM9fsA0ONOwKy+b2FvYBLDY1ySGfXaZSWPAzxQJlIjxBBTG3vW
 uZ8osHUYzEc1LgdqR1qjBzKbbtiutC4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TRxoFDJ2O-ODJMvwNtH7pg-1; Fri, 30 May 2025 03:14:13 -0400
X-MC-Unique: TRxoFDJ2O-ODJMvwNtH7pg-1
X-Mimecast-MFC-AGG-ID: TRxoFDJ2O-ODJMvwNtH7pg_1748589253
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad9a8a5ecc6so186349466b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589252; x=1749194052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzSgMvSn5kQIqpkAjVo/+xXom1PxGg1FgYj2rm/RCjk=;
 b=esHOkIbG9tPCF0wUyNTMx/nOQuazFzZdOhsXndtA7OrQx1gJtYJjHkdNxXju9sSbAa
 n6KhiZC4Lgj+xVUVI1gZDC4lCVJ1ulegWCChVhi0oOM1Yh9fCRfRu0LCS+Fa4vAT6NXH
 6wKripZfbarhw/iyyFXkXn9ptAcB6kGH/WjVagDpKKC1GR5R4eh30WrZHw7wszzCgVIU
 k1VEwfM1JTQv/YlwlVdBl4oecjIsPIdCN9H+QSV3fmzmwWHQcxlz4R0OQf0kr0+MZvjF
 nnx1vPO2HsFR6RJW0l8A3ZGn0xPN0gtDWwBh87uJOAcwaGHR+mtwRwEKShaQr/9iiKGY
 AOfg==
X-Gm-Message-State: AOJu0YwXsi/i2Jl1wlfXPn8Kozrm80ZxINi+eBpjLYwporAy7H/unfPc
 ZuV+b8jpugouKZtKKnW70/hTfUOvVzuO3NNG9VM2bSOHES5DMEskNFdZW9RB77x+lt2W3u8SwBX
 7aqMj/GBwh6Tw6fJjn+5mmBQ6zZEj2VPjEPfyPawq3rtr3XQYKEtC9MU7BxtQW1SSJnUYNG0y6L
 2igL6/IQScVgCmy+6Li2Vtu1PESiFI0z7mH3lm4BGu
X-Gm-Gg: ASbGncsrulf7uBPSoHqOfnu6wUZV3q2vyfxbjc6RIP7zx78XX1xkIq5rW9/TJta5Igt
 ggEpBWrVDs8CODJ5ScXdRAX3wvMRQOSLgUYJEymV9hF1S90pKe/ZBoS1LnGlVUWAH0XC/6WwKYN
 yJp65FMKzJILuVdf1+jBCL2b4mMF56IdyuZFZ4QcyYGHrC60SodRa4BcPZp/G/Q8HFtptksA87v
 XecfdE7MX29qh5ndKf0u72u4N9AIP3G4KnVOeKd4uyRY3uwrCfAWjTGSidhyQtBUoXgkto0pswg
 kTUn3srAtVOl86jb6C2A9nrT
X-Received: by 2002:a17:907:868b:b0:ad5:57e0:c3b1 with SMTP id
 a640c23a62f3a-adb3229ee07mr203854966b.23.1748589251848; 
 Fri, 30 May 2025 00:14:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE85j219gtREc/C/hkLjf4MEWZ+OdESPiFzCaIyR+Zkr8cTrUA5MfyDOi3VjmZcaxuWry9wTw==
X-Received: by 2002:a17:907:868b:b0:ad5:57e0:c3b1 with SMTP id
 a640c23a62f3a-adb3229ee07mr203851766b.23.1748589251346; 
 Fri, 30 May 2025 00:14:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82d446sm273364666b.38.2025.05.30.00.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/77] i386/tdx: Track mem_ptr for each firmware entry of TDVF
Date: Fri, 30 May 2025 09:12:02 +0200
Message-ID: <20250530071250.2050910-33-pbonzini@redhat.com>
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

For each TDVF sections, QEMU needs to copy the content to guest
private memory via KVM API (KVM_TDX_INIT_MEM_REGION).

Introduce a field @mem_ptr for TdxFirmwareEntry to track the memory
pointer of each TDVF sections. So that QEMU can add/copy them to guest
private memory later.

TDVF sections can be classified into two groups:
 - Firmware itself, e.g., TDVF BFV and CFV, that located separately from
   guest RAM. Its memory pointer is the bios pointer.

 - Sections located at guest RAM, e.g., TEMP_MEM and TD_HOB.
   mmap a new memory range for them.

Register a machine_init_done callback to do the stuff.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-21-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/tdvf.h |  7 +++++++
 hw/i386/tdvf.c         |  1 +
 target/i386/kvm/tdx.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/hw/i386/tdvf.h b/include/hw/i386/tdvf.h
index 7ebcac42a36..e75c8d1acc6 100644
--- a/include/hw/i386/tdvf.h
+++ b/include/hw/i386/tdvf.h
@@ -26,13 +26,20 @@ typedef struct TdxFirmwareEntry {
     uint64_t size;
     uint32_t type;
     uint32_t attributes;
+
+    void *mem_ptr;
 } TdxFirmwareEntry;
 
 typedef struct TdxFirmware {
+    void *mem_ptr;
+
     uint32_t nr_entries;
     TdxFirmwareEntry *entries;
 } TdxFirmware;
 
+#define for_each_tdx_fw_entry(fw, e)    \
+    for (e = (fw)->entries; e != (fw)->entries + (fw)->nr_entries; e++)
+
 int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size);
 
 #endif /* HW_I386_TDVF_H */
diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
index e2d486946a0..bd993ea2f07 100644
--- a/hw/i386/tdvf.c
+++ b/hw/i386/tdvf.c
@@ -179,6 +179,7 @@ int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size)
         }
     }
 
+    fw->mem_ptr = flash_ptr;
     return 0;
 
 err:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 18beba2f5c3..bfdae4f1c0c 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,10 +12,13 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/base64.h"
+#include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
+#include "system/system.h"
 
+#include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
@@ -143,6 +146,38 @@ void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
     tdx_guest->tdvf_mr = tdvf_mr;
 }
 
+static void tdx_finalize_vm(Notifier *notifier, void *unused)
+{
+    TdxFirmware *tdvf = &tdx_guest->tdvf;
+    TdxFirmwareEntry *entry;
+
+    for_each_tdx_fw_entry(tdvf, entry) {
+        switch (entry->type) {
+        case TDVF_SECTION_TYPE_BFV:
+        case TDVF_SECTION_TYPE_CFV:
+            entry->mem_ptr = tdvf->mem_ptr + entry->data_offset;
+            break;
+        case TDVF_SECTION_TYPE_TD_HOB:
+        case TDVF_SECTION_TYPE_TEMP_MEM:
+            entry->mem_ptr = qemu_ram_mmap(-1, entry->size,
+                                           qemu_real_host_page_size(), 0, 0);
+            if (entry->mem_ptr == MAP_FAILED) {
+                error_report("Failed to mmap memory for TDVF section %d",
+                             entry->type);
+                exit(1);
+            }
+            break;
+        default:
+            error_report("Unsupported TDVF section %d", entry->type);
+            exit(1);
+        }
+    }
+}
+
+static Notifier tdx_machine_done_notify = {
+    .notify = tdx_finalize_vm,
+};
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(cgs);
@@ -157,6 +192,8 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
+
     tdx_guest = tdx;
     return 0;
 }
-- 
2.49.0


