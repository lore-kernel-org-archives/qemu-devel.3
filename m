Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D2CC9EC91
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuN-0003vM-C8; Mon, 12 Jan 2026 08:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtt-00032w-0R
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtr-0003mU-FF
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enQS01mePhcqrNpRvIEAIkNk+KPz6jEdRutgiDslPTQ=;
 b=WBCuq6XvU2UYJwDrgK5g2zM1sB3g/E+OOQvtEArpiikx+071rKbfksCHivD6gwu8NExeCC
 ku9sJF8UFvEbTkS0MBJwMv2Uif1/09nMUvvPvLf3BqNdRBpS2BtbgE2RHFKEQz3Jk63cnL
 V2ny4vh621c3LISRJJ2KJxLTUjq5xuo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-KOf7UkToNL-Jglkcp-bEIA-1; Mon, 12 Jan 2026 08:24:01 -0500
X-MC-Unique: KOf7UkToNL-Jglkcp-bEIA-1
X-Mimecast-MFC-AGG-ID: KOf7UkToNL-Jglkcp-bEIA_1768224240
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so4538111a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224240; x=1768829040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enQS01mePhcqrNpRvIEAIkNk+KPz6jEdRutgiDslPTQ=;
 b=tVMcZFt9H19SYTaBnbmlSkmu0qNk9daCiRuHlanXMzC838fzjxrfeXAOcSvplnPFJ4
 psONCTGqmror4hc4ZrBXo9daPKiB/YoJOO8AtFEhpWVZiiWEb01x5bvb8lB/JZv6Ortj
 6kXBB4Zar4dA8ZqI0RVAESVDT+/ekr1nkS3DoPsLKCQoIYXxWhSdaHBURdZL4qEmTa97
 UuqR5JnddnqvwlZtBZ0eavLFMruQZeEXZvjrpgonCAb65bVIa6E2yyEiAV7fTAgREz3x
 T6F+GxIHFkhCenwSxYGldYvVu3oQ9TvMZjXaLZAxuISJtkzox7sgJyhHitO7yjdf5xM0
 EpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224240; x=1768829040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=enQS01mePhcqrNpRvIEAIkNk+KPz6jEdRutgiDslPTQ=;
 b=eowaZeo+/srdPPM5XkCryOuE1pPKd+1k881rTuG+c+kIKSgGovoEFkQ4UsiN6Erd8s
 9L3LhKq8D9wygX2nsJhKL7SRiVJWtP7PRMnuMNi24jR/qTSnPFnjxxt9fQrP+KqDaPjH
 yHU6+2BEA+RwFHt3PA7McA0jYCDzS7hpz8NhSCzgOrk2wQL/32g2OWy/PxCjp6mtgpR/
 g0vHKi/9IyPJ4yr/BmJR7o1VpTW2SMLWrB9K+kO+nYd2erg9SbHcOhyu+t+rv3zg5Vd7
 GVIPxY5/WHWmz7/Ndb6xs3ef98d2Ing10xadGIJfPyxV8VDAOVpLbWAM8rYEWrB32fd1
 FFWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOCGDGQGMCAXAZPKgVR1KHwsZyuauW2pmjH5UlQ2azkFsTBUU+yUKh0ZbYVXjNBBhSvPIvpatOK2Om@nongnu.org
X-Gm-Message-State: AOJu0YwVmAhJ34QIAolZm+buf62OeSYIkkVk9opZLbjaS5Tq5T2lRjWC
 I2/zDF793pwJBcqwqxlsb00L5iEJx1xMn9gNyUYjdk3WIFGJ6mxf9f4gHQVAYwG6n1o391sEd43
 IYF6MzfQK2JTxfVay32+bD9skn2mTWmK19YiOSaKJduZ+HOh5YgjYpMD+
X-Gm-Gg: AY/fxX64uPhipGtJ+Em9zQhDs1JM9WaWBViYuDqBdXfmtpCDX2xaEUClL3g/yReV+ao
 uANbcB/DuOPogk6hE9J7QTL2XHSl0e1lGU9lKoFJh9CyOVvyxEbReTVTmIyx9MwfAtdZDrhgaRS
 Tkbuj4drBgVjFufm6Qu5b0ELUxeHfBYd91JHwbPVcZAWaVwcy0EVDLgAPcRaBo5+f+cQDj+fsoE
 jpS6ZXRFWCXMhnc8fpY+N6yQT9p70B/lgnWGJT5gIp6OblVSLAtWtHZl53G28O3EB/nNOCk5PEL
 /fZI3ir6dk32tXTBQzpXFGhFNYh1fPJvs1rIc6hYeQTLuoQ7LQ4GXM1Bbffvuiop9z1Kj/UGh+L
 2SDQV9pqIQopuQ9xNAQrnqy9b/1nXDBbw+PYPHHiU/2Q=
X-Received: by 2002:a05:6a20:938e:b0:2ea:41f1:d54a with SMTP id
 adf61e73a8af0-3898f97ad8cmr14440076637.55.1768224240379; 
 Mon, 12 Jan 2026 05:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9AdsORso1hajXEudPS+SoWB6CKZvQc/iJn1g5/STVkIOIrztq9DXKIx4zeqdAO8x58tFeew==
X-Received: by 2002:a05:6a20:938e:b0:2ea:41f1:d54a with SMTP id
 adf61e73a8af0-3898f97ad8cmr14440059637.55.1768224239987; 
 Mon, 12 Jan 2026 05:23:59 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:59 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 13/32] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Mon, 12 Jan 2026 18:52:26 +0530
Message-ID: <20260112132259.76855-14-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 0161985768..b595eabb6a 100644
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


