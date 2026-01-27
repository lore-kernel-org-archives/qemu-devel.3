Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D98D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbSD-00072o-0L; Tue, 27 Jan 2026 00:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSA-0006zd-T3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbS9-0008QN-AM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=et/y6KJu/aHqVWV0I+qVjbDkGCIuxh/ISKglEVriQ0l7prY+aCkJes6VF+ILdKSDgpVrLt
 jB11evUnPv34bYvDMceVBN7mLFJPllvkyYdEMFzvRCg1OZrgxp+pyAX3JmRqe3WQNfv1vM
 ykem0G/C3AsC2CZRFV21VlBCtQPhZBQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Y5yn7r8JPMeE4330VwL3dw-1; Tue, 27 Jan 2026 00:17:22 -0500
X-MC-Unique: Y5yn7r8JPMeE4330VwL3dw-1
X-Mimecast-MFC-AGG-ID: Y5yn7r8JPMeE4330VwL3dw_1769491041
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34e70e2e363so4657493a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491041; x=1770095841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=IoXLwvHSZkKEUwvG4A7z9iJcWDdYgLdNyOd4tUpSjpj8TpbO7CD6HdPr0vnIiueOLo
 nznmaq+SJSS7JDuNqErXdOyWJ/+j5ft7HNu7GUTNJ/6kfE+Cby6Zg5baaLipkYGur6Nh
 V8xB3YNwbcUgd5ZGDo0bnyRcNt7r5KLMpCBAb+yVMBlfqCM4DQoJNPwS9d+lFQUhP2zq
 B6iI6/OGXRTOcIlYotP8G2q0/vdyaM8rlBc8TN4ByO8m7yUfO9aaG8E9XA0sJ5lNnTWM
 VctAppF5JtZkiAp57GaGsPwErK9PL+CqEiGobjtd6I8dDF4r8S4k7Z9iAe7NUKJId1bF
 K8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491041; x=1770095841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=fyZ9LHNTxVG6l2KH7/RigKv+uQtnR2LW3/LRRYXsdLBn3nJkqY3Yw9tKHgtu7kU/Rt
 uzVJu9nLN5n8H+/pJ4aCkSY0FjXzscS/0WZaO/rVHyZ5V7Ip/4YotMjyssPM84q4MI15
 hFxKFX0vekE822g/sHenTelXq2EYMPOzIalanXc1QxyJZae7KyWcH6PnqaHu5l5wamWS
 +ByPEIbgSRTkTQicZTNvxyw/PIaQMhOGZc078q/pGfEsyL+R+BlslxYAWZ5zEbJ+SfP7
 dQygql232Hwb2jArW71O+m2a2Dnx38OY4lOzlHJVOzXqZ2pvUkoLj/8dkcuRglhgD++7
 s7qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiq2N75Y9eU/7TNOWEv5DDNuOQsZSLvdS7c3zphYQbf4mozMTAgrGM7k7af3xK1Dz02opiY9soKjlk@nongnu.org
X-Gm-Message-State: AOJu0Yy+ApNhwDzdXlYtTqhckaTWOT2gWGklhXoAKbXX7YNMTQ3EyFPj
 TGeGzNtU3WhDr6bsziBsw45iWA8t6ooWM2Bf3GsYSH3ZcDhyLWJQIKoEWiILBqYfslDS3xEveh0
 uqNH4cL9WsMGT7mACm4TnEfAwpYzQHCjPvzJ9h+Btp/tt7fFGc7I67/uc
X-Gm-Gg: AZuq6aKlA8pqLJKSosS/lM2TIcNeubDMupm2lxwXrnOw3t8a+8RAEuytRvecUoByeUh
 FHUVR8uipgf5xN8nuffl25JM9ZI/xXlYnGc+OKOvM6TSd2pwqupMO4zkzR/TN+9Qm0Sx7vH+MIK
 XSp+iBQGdJ6xC2X8z+I4mcJ/Q1CIEaWz5cOBpyAlMm9+vYO1Wsf2XizX/On0Px9gIS/GryaGAoD
 QNlox9foDJG1M/OfVVRNdiocNQ/TxCAXhYCthjqYrrzQiZmvS9MCNmprTYvnuf1PipeCKxkiJ0q
 uhjWarMlrMuBxJfOYryE8trB1PzNOQ6OwKXP96bu8PfA/ya08dEuUsrw7ZPQ8bSNRSmpHK6EXEi
 2ZM65K6BS+/gtG6Q1iOvXu7EVYI5A79PufOB/tRoJ5A==
X-Received: by 2002:a17:90b:3ccf:b0:353:356c:6821 with SMTP id
 98e67ed59e1d1-353fecd0906mr710448a91.8.1769491040983; 
 Mon, 26 Jan 2026 21:17:20 -0800 (PST)
X-Received: by 2002:a17:90b:3ccf:b0:353:356c:6821 with SMTP id
 98e67ed59e1d1-353fecd0906mr710436a91.8.1769491040627; 
 Mon, 26 Jan 2026 21:17:20 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:20 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 15/33] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Tue, 27 Jan 2026 10:45:43 +0530
Message-ID: <20260127051612.219475-16-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

A new helper function is introduced that refactors all firmware memory
initialization code into a separate function. No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 73 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a3e81e1c0c..fd8e3de969 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -295,14 +295,51 @@ static void tdx_post_init_vcpus(void)
     }
 }
 
-static void tdx_finalize_vm(Notifier *notifier, void *unused)
+static void tdx_init_fw_mem_region(void)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
-    RAMBlock *ram_block;
     Error *local_err = NULL;
     int r;
 
+    for_each_tdx_fw_entry(tdvf, entry) {
+        struct kvm_tdx_init_mem_region region;
+        uint32_t flags;
+
+        region = (struct kvm_tdx_init_mem_region) {
+            .source_addr = (uintptr_t)entry->mem_ptr,
+            .gpa = entry->address,
+            .nr_pages = entry->size >> 12,
+        };
+
+        flags = entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND ?
+                KVM_TDX_MEASURE_MEMORY_REGION : 0;
+
+        do {
+            error_free(local_err);
+            local_err = NULL;
+            r = tdx_vcpu_ioctl(first_cpu, KVM_TDX_INIT_MEM_REGION, flags,
+                               &region, &local_err);
+        } while (r == -EAGAIN || r == -EINTR);
+        if (r < 0) {
+            error_report_err(local_err);
+            exit(1);
+        }
+
+        if (entry->type == TDVF_SECTION_TYPE_TD_HOB ||
+            entry->type == TDVF_SECTION_TYPE_TEMP_MEM) {
+            qemu_ram_munmap(-1, entry->mem_ptr, entry->size);
+            entry->mem_ptr = NULL;
+        }
+    }
+}
+
+static void tdx_finalize_vm(Notifier *notifier, void *unused)
+{
+    TdxFirmware *tdvf = &tdx_guest->tdvf;
+    TdxFirmwareEntry *entry;
+    RAMBlock *ram_block;
+
     tdx_init_ram_entries();
 
     for_each_tdx_fw_entry(tdvf, entry) {
@@ -339,37 +376,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
     tdvf_hob_create(tdx_guest, tdx_get_hob_entry(tdx_guest));
 
     tdx_post_init_vcpus();
-
-    for_each_tdx_fw_entry(tdvf, entry) {
-        struct kvm_tdx_init_mem_region region;
-        uint32_t flags;
-
-        region = (struct kvm_tdx_init_mem_region) {
-            .source_addr = (uintptr_t)entry->mem_ptr,
-            .gpa = entry->address,
-            .nr_pages = entry->size >> 12,
-        };
-
-        flags = entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND ?
-                KVM_TDX_MEASURE_MEMORY_REGION : 0;
-
-        do {
-            error_free(local_err);
-            local_err = NULL;
-            r = tdx_vcpu_ioctl(first_cpu, KVM_TDX_INIT_MEM_REGION, flags,
-                               &region, &local_err);
-        } while (r == -EAGAIN || r == -EINTR);
-        if (r < 0) {
-            error_report_err(local_err);
-            exit(1);
-        }
-
-        if (entry->type == TDVF_SECTION_TYPE_TD_HOB ||
-            entry->type == TDVF_SECTION_TYPE_TEMP_MEM) {
-            qemu_ram_munmap(-1, entry->mem_ptr, entry->size);
-            entry->mem_ptr = NULL;
-        }
-    }
+    tdx_init_fw_mem_region();
 
     /*
      * TDVF image has been copied into private region above via
-- 
2.42.0


