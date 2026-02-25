Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25897F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vZ-00089a-7y; Tue, 24 Feb 2026 22:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vX-00088O-HO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vW-00089N-1e
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=Tqwe2TzUoSHIz0I1qyOhGn28yqT5+SC67/XZZyks47Ed3qVfQkae3gZPzrkEci1eBaUF84
 n7NBMarXQ65H6U0nXUadRiO/mBzNH3ZHQjNkuUJX8HLKhD93CxZPeSa6b8mKrFM5eNepPW
 Ste3mKZyt3dZaKrSP5PwWM1vz7iS1Ps=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-7-Q9WRdXOlGsZTb3vdH9bg-1; Tue, 24 Feb 2026 22:51:03 -0500
X-MC-Unique: 7-Q9WRdXOlGsZTb3vdH9bg-1
X-Mimecast-MFC-AGG-ID: 7-Q9WRdXOlGsZTb3vdH9bg_1771991462
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-356236ae3c1so411632a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991462; x=1772596262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=k+L28aTKxPcA5J5Hgzyik5HrUdcu3faVAhmCdgWAnZXlRs/wrBaZu6SM+iMU5o+slP
 y4nfDlZv4UeQ5TUcypwmlmYF1t4l6K3k1j/4b3fNtY9oqbpfgT1ebvkhSxcLdAZ7o4Ii
 bgO7BcbrlmGJG2eWufuwORcBN4YcbI4hESyWCO/1Q3sSDgqP3C6PgfiNO+93ZKS3jdPu
 ol07tjOcWEO3c8vrGwUnhJP2PqYduNiYeUOqNZAFhjZdR56A/qLx7K6MxPhQulH5gYB+
 A7xiPst0fbA8PU4KjG47yiKhmdWGZyHh0a2DICMh9kQCPffGOCm1tSdERji+w1QIqoP2
 +0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991462; x=1772596262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=Ycp4+DXg10MBXnmbXXXKBJVVz+brW9c0EmbOb86n3ptoAM7uJ+0y3tDfPQzwBfV5Vx
 SEvIObzbxwAzPZRL2Z7ih1eaZQyrXdg0+1n1xhuqQGRoZXA0C8HZEJmtaNq8Z8U+V0qi
 VuBALs3hoHDAmROoRXm0FsoElgzN/lGhrrnOEPmmM+UTThSmNoQ+K5MfI+ec7ktZOtpo
 EpnlsmI6oTF26B7dNpfDyg1ag6gshTz4dd0ZHmntbZyyntrlvQyXJvLVD+T8d7AVFVED
 V4yBpqkJPqwpnOo/wZQCRqm5SBMO9mwOzc+t1NEsXdyR8e+fB9kCl6lGwWyf8ATdK9xS
 67fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNL4hkaV6n3EfSBQLYbbOBcdcyfLGAwvPscxYuAvIedz7rXf3bWvtiFxF+Ri15Ib5iMAR9ruZKbXJU@nongnu.org
X-Gm-Message-State: AOJu0YwPyI4XkvVw7DG/w7VNmv9gHjVkK/Vi3JYo8xDlhLWhAazHs1Bo
 mIysYclf5t/Cf19Xx36hhFItGd1/hGQml2HFlcQXpob/ftnEunBAeFQe+PXCikq7Lm+/ZTK3bh0
 iKHP7I+k4mCwQPUsqXGCKqwtiGqy2YTz41tfm6vkujGnG9At/fUWgEX08KOeu0V7y
X-Gm-Gg: ATEYQzwmgFYjooPp0KCsVwgDC2clBv6FgxUj+2kiMBaQwVH2+ls0I3zvvPYR57XBkLK
 4/sV/mcphN/rrTE45FNj23yZEZkO/RF9XCcWhp2qYqXLILjscG2EmwvIC1jjEbh/vl/IX3eeiLS
 pkQ7qQCS8CEfu5z5GJ/x1xvt5Z+rhztRZmZwcYJm1pRBCU+H+HKuf5RBgYKqwTcUXxY3IoinPZH
 8JmTJjez6XOpzMK9fAln+Jel5ecnRW9qT9mVwZ8a7ZyEPfTvtZZaVwdAr+uAGOwxS2x60LccHjk
 deHs+yRonWATIWZnAZLRhUoI8mpG7q3cT0udI62JrHgV/estKHUFZyttrLriV1Y3ml7LIYJVsxD
 9e8AVBQaCK5Cpx81WNbHFMUhKOkW8KM9e6JS82YlX96KlM4ioZN+JYTM=
X-Received: by 2002:a17:90b:4a51:b0:356:24c8:2291 with SMTP id
 98e67ed59e1d1-359008bd1e4mr1891321a91.0.1771991462099; 
 Tue, 24 Feb 2026 19:51:02 -0800 (PST)
X-Received: by 2002:a17:90b:4a51:b0:356:24c8:2291 with SMTP id
 98e67ed59e1d1-359008bd1e4mr1891299a91.0.1771991461744; 
 Tue, 24 Feb 2026 19:51:01 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:01 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 16/35] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Wed, 25 Feb 2026 09:19:21 +0530
Message-ID: <20260225035000.385950-17-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


