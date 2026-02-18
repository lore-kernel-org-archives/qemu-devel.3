Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBADFE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfy5-0003R2-3q; Wed, 18 Feb 2026 06:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxy-0003LI-Gj
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxw-0007t6-19
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=jBqEkMFfW1KkuypqYwZfruMXljPAcnfx/s8zaG2We72ZnpYBxYyPimOlBL6Kw5zvY4lXIU
 RrTRXX7cSb9CfHQ++nmbyImmTDiLIcqBdpMSprjNp4OqCO/kFoHVImBSlM9b2qTbUhk7is
 FSBQCLAFy639Sd5p0osWTN9GEUVEVXY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-gFap8oolNgqNKVoPtH-IeQ-1; Wed, 18 Feb 2026 06:43:33 -0500
X-MC-Unique: gFap8oolNgqNKVoPtH-IeQ-1
X-Mimecast-MFC-AGG-ID: gFap8oolNgqNKVoPtH-IeQ_1771415012
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aad3380076so4967325ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415012; x=1772019812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=rDKSbxf4C5BJZwwp/nljkU0qQ6Df414Z7MFHRQG1ly8bAJMbUN/iyqDxQlVUarDF70
 AT2Wk4lCyRIYJMlPohlqXYP1uIXZKxSHrSX9eeUp1VV1Jl/tX3GlJ4TLZ+1QCdAFxy9y
 Mb4Pg5xocNT3Ii4UAIMkqUr8NxATkwIl8lhX9OdsAXECGl7NSschG7J0rMi+7zoxZbVX
 +29Eoue+24f/Vl13r9TbWRKznM9cqO3nJu1Bw66CJUCutxVZ5tncCZbdknCeqVkc92uW
 rokPMmsyrsxCJKyqG5NqboYwh81eUGMlv1wnKj+S/ikRshz7iDpFLyL0iX2sL1fhiToT
 VPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415012; x=1772019812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=MWxP4BECco4ja+Hcr+alXppmPFFsjza9puPMatWKTbkwPHzCuyrFg9fh/qK6k2lCb5
 gUYpKxG/XkBL+zUfaX4esl5FBcgf2UNfESCEs2BeiOf2eiEx0rZ15J3Bn59qyJN5nGsz
 QK8y+XbmFIBTGgv2voE0AvVJYdzrJevYJQpBH/sGcTzZn1B1MeV2z8MbEZgOhy+dDawU
 E7KvTGcrUeuAPQsv/1ilpxNYl7qBc9WQmsmAyLDTyHFDhutLqY7bCExB7+/JJAZ2z5fa
 Lw1RwTlcf9Ekk1W5AZJoiQm56HJn2W1bPyXkgLzasU9LCqhPxWdtptAgQJUC6eywjUPg
 s7Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmfzti2P1uLLnxjkVjiEjZvV9LWSnf9Rgv0DsRwLGuW9BMoKzeaR64Z9ruP5TpgDg6FgsZgl1LxQPl@nongnu.org
X-Gm-Message-State: AOJu0YyLB6CKrc8Zuh6stdoFlD194o0I/Bvmcig2ZdHhxJLi26WWfYkL
 expxKxIgt2LUfysjsnSF9P20w/6cezlBKJ1dwk4UuowZ/nT9jvJCFSRxIWUJCz1MicYcL3g2K1p
 L059idAC2H9uk7BCSuEvFd58ZgxD0mFZ54zYRdeBNVlJMY7I/APtaBzunAjKl2W95
X-Gm-Gg: AZuq6aLTBWvdzOccV70wwpU6fyFwCQPXtk2rHgCB8HOxoXoR3No04TKQ2aIQQ7dHaYs
 j4hWsXhXgBz7jpZVMEYDPtWTNNhgOt42+3zTRinKhs7rp6oVzRqB5Q3UW6aStGqlJQJtLonWjgw
 gGGvllzyBQjLX+uKFjNC2876ExHyWKx/1gJ5o+U/3T/dF+yFsZWd+XveeUoMdxZWz8/MHRpgiZa
 n96YE5dFOdldpAxtm9Rp5E2f7AIOugFUGPV7J0D+xiuaLpm4Myo3ytGAeUY0t9Y/R2gTFqRbYPw
 xeVYsAlQTOhUgiZFo/zxOTcCdhp/6npwQcg21yuKn6rLjdBJnOHhjcUzVz/3temmkP3etdOxjlA
 AJ0QBjUwUBYsOZyyYWFKd8CCHiMQrtU08d7DQ8bM3bUAXjagsznFp
X-Received: by 2002:a17:903:3ba5:b0:2a7:aac1:7201 with SMTP id
 d9443c01a7336-2ad50b5a062mr13233305ad.3.1771415012231; 
 Wed, 18 Feb 2026 03:43:32 -0800 (PST)
X-Received: by 2002:a17:903:3ba5:b0:2a7:aac1:7201 with SMTP id
 d9443c01a7336-2ad50b5a062mr13233165ad.3.1771415011824; 
 Wed, 18 Feb 2026 03:43:31 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:31 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 15/34] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Wed, 18 Feb 2026 17:12:08 +0530
Message-ID: <20260218114233.266178-16-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


