Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB70D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hk-000295-E9; Fri, 12 Dec 2025 10:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hh-000288-0H
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4he-0005v7-K1
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEPt+WowIb7JNUH1z2t2M9hX2SLVHr72KxzuR57IAVY=;
 b=Y9nEdc2kjDpiOmK+LNDX9pKO8+Q7hLNl8z4/HexF5v1FqPKYnrTlQqJSAcUqPNXNEJtzOO
 DpFKVOvHLI/QLo8xK3qDK+4CWUcyLZe/bmY1E/OxlNlePZs7aPmEcReFcRO+5+HI63BXX+
 9BpOZQA7wf9x0JaVbiwrdOxeCkHbMus=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Ej1sKfFBNliVaEGjcEklZQ-1; Fri, 12 Dec 2025 10:05:04 -0500
X-MC-Unique: Ej1sKfFBNliVaEGjcEklZQ-1
X-Mimecast-MFC-AGG-ID: Ej1sKfFBNliVaEGjcEklZQ_1765551903
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f25a008dbso6580815ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551903; x=1766156703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEPt+WowIb7JNUH1z2t2M9hX2SLVHr72KxzuR57IAVY=;
 b=VS+wnfQbE1DiQXifXFKAwwlT4PCkMaN80ID12+Wk+mGWGHX5xSEQgBO/H7J/tSK6TX
 bQRFhiKxB91endqz+qg84Cxamap0PA76s5mSypL3Qe74CHIurSc71mHFg2SS+3VUuBdc
 dq5otvwHt4/qRVOmtUqUBT0U/i6nl3SCgF36j/IycX/YTqLwHw9CbqdqOxbZC/PstB2w
 Gt2IjGB5RI5Z3akg5T5LeXBTAEjHGTN+V/h1nERt3sYdLIG08bJkRETuMdWiJEBt3Wx1
 zv2BGuk0BmojPAmg9oea1ZNRwrAA9NZkYUR4VTLxObn1HazMArdiMDxzw4XIE7BqgZIZ
 nRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551903; x=1766156703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QEPt+WowIb7JNUH1z2t2M9hX2SLVHr72KxzuR57IAVY=;
 b=AMuZVbIZKm6RzMFxoBBuR067r0bnF5Ua95KuxIBG3IpoZ/FGIQNm8uOusv47rTOmRA
 vl4IbH8ej1s1ZSakDOXpBicY/Y7Yh2ieQN3PgtMJw2vsiZ3CmqDWcHNC0Qe+JLZI/1bI
 /sUPL/HiGM1daXIA6BMqyikQVOug8cyyZaxm+si2X5SrmXXEk0Uyp6Qheml0pHlFK7+D
 +2HncTIYm5+UFFSoVbzIoJ7HLW0w9ZqbpOOEbIKvatL8PBDeK332BB7JdfiDdILOj/1y
 NFexhmO/U+g5SId1SAUAiMsFwEJRN+PRc0s9wAs/FbuHnoJtk1axOV0YpdYpkFceKRZo
 GrSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUae6aTXVsLMHeeqtjR3cGDZk9CjuXtu7zLef2RIEcBCAq1scIiJL11YJBGtVJe6y++Rd5kep267kdr@nongnu.org
X-Gm-Message-State: AOJu0Yxh4T2sKJm6dGJi5QNa1UDRd1t6nyzSicyRBwiHyvz97SLW2kx1
 fMM4RUBP1aQUPLpUyhitga4ZC3udUQpQUdqJuwfIm8Op+tnIv7XIpZsHy6WUSO0phKPhbTaYOau
 H58rQ83CyZU46Pk5+QnvxbcYl5CSWzxlRP1AVBeOBJ/cfXjsTxhD0ySUW
X-Gm-Gg: AY/fxX7bmOzI9NUNNRRHkHZ1XmflWs3pT1AIvpq1/RO8wjC5HOmNK7A1CAFShpqlx47
 24pEgCNesVcnX/+IH96oWNwdA1uLu+Y/aLcPKdDrGQrYb7Y4HU3XcBJR6Lxh5dUZOPJ7mN/R+qt
 PVgmtapyEDOmhmZDBIQBQScbUJQKWWbNAgjxinG/I0HXPQ8fdFtMdQiHeHJNyxov1QKtIHijlhT
 ZgkOx7/3lPqZUiBY1gmht5e/DWDY+hGNjDF/trNy2x7bHtFXd1SP0EHllwRc852zTeOtXbGrQXZ
 il2iR1+lVddMlnSzNc7YeUm+8+B8Cl9OasTWASfCGYVsMUl4OhuK8u5lrBBiJkPHSMozYbi7muJ
 fl5+UUh8rKksnTvAPQmT+ZNVyvpaxXTu5MD23+CI8Owg=
X-Received: by 2002:a17:903:3bad:b0:290:91d2:9304 with SMTP id
 d9443c01a7336-29f23dd3f75mr20990425ad.4.1765551903319; 
 Fri, 12 Dec 2025 07:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFCuDP1WPBimYZnnChi088VUoRgeHW+JpdMIlzKSP9VG3LKJNNtQYHbpwf2LR+NQccXZsDqQ==
X-Received: by 2002:a17:903:3bad:b0:290:91d2:9304 with SMTP id
 d9443c01a7336-29f23dd3f75mr20990085ad.4.1765551902848; 
 Fri, 12 Dec 2025 07:05:02 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 12/28] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Fri, 12 Dec 2025 20:33:40 +0530
Message-ID: <20251212150359.548787-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A new helper function is introduced that refactors all firmware memory
initialization code into a separate function. No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 73 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index dbf0fa2c91..bafaf62cdb 100644
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


