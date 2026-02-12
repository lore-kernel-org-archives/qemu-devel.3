Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E00EEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9h-0007pR-Ge; Thu, 12 Feb 2026 01:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9g-0007of-0V
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9e-0005GJ-Jd
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=fGRnX71GZoCIBlz6/VE0TQ4CLRcX++ecFB5Sw5Lh8QDYjBgDPtk+hS04UiTKr5vIvPGB1m
 afbP0qEfczZ6Sp3fsf9B/ueO/LUZZbuU908ClhEGknCOxftXS8s2c00jzTccs7BqoVJAqj
 qPJGCIgIgWgrDPt2ld/5bdrGsOjsT6o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-FzaEgHZUM0S_ONheAyyv-A-1; Thu, 12 Feb 2026 01:26:20 -0500
X-MC-Unique: FzaEgHZUM0S_ONheAyyv-A-1
X-Mimecast-MFC-AGG-ID: FzaEgHZUM0S_ONheAyyv-A_1770877579
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6df833e1efso6933432a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877579; x=1771482379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=exVYpTtFNzpsX8XvIeRXRqEO5+bqRnQFiJh+7xWbq/tz7QRZf5lwzH1+te3gGpGAhz
 xkWLlDHuq4GL9sl/ZjOmlJG365AYdfn8AMoMVC73oU5qMgATKNp8dOac423/pzyX2RSJ
 P53+QfpXS5tmsHLQ+VI7XzsGtzlQpTUgX+HdW53qk5iVi51l/0VN+Z0ioBGwkFrkC0uA
 WK6/1OSrErosWbDHYAQl4A3r3qLNIsSSPD/y1tcAmQbW6zf1kHJ9qS/UlpmAyLAh6LCL
 j7Fn4bm4hQfAb98iKwY1/OLK3O/Wnx1niN4eeaJI6ElNccRSVqnsM0se8kSGHPoad0BC
 Ajew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877579; x=1771482379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0oM0RRyjLelkT0G5RoaNy8SGcq/Mnkz7KKwnwr3WCA=;
 b=h8qv1rxKMv6No0VLQZwS/hac5y1L/SVFKeDx+lgPp/XGxmgJ2Uagmq6zSshGsQFeKW
 7zoD/v5OPwYeidgNuKIL7hGANAADzyvA9bSB6kvePgK6dL5P7YJUGBk7bM6lKwg945fe
 qMaEkPEPfd1JHdjQHE1MEjGfsHj/t51sLITNRN3pPLOxot7vH4N/H063IZlEOF6BSYl1
 27qyJN45sWTxBAv4s2VNFByUeUA3Ear3P8NNMARlYTYwDQMzuE4bO2kUVERb1NW4s+Bu
 DZRNMbkZ04o9nFL+nH5W9pbBj7KHCSB7651x2NMXodrTAhokMqXOYK7KlpBGrVUZidbb
 1N3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRMTuEhTrITKc8I1FYxHMnsuSrFO0vrqFpYFA5RzKDRaNSRZEYaMJaHRdFPAz0ksfp5IiKWZt1UyHk@nongnu.org
X-Gm-Message-State: AOJu0YxtKZoiOe7cUylF5tXeR4uHt1A7CCC0puz1r+SqJXu62rBKtt/s
 +knpbUYLOfCQADVFBAq8PkmUMLRXIB32LXK/4NcjJnKYeoI+ghgmtDL80txra4bjEPHzgkHQQ80
 mZVxsltiotmW6oR6K7e4WKx2/hMtoAeXl9WGxV00UgjP2q+PS9Y8rR/4C
X-Gm-Gg: AZuq6aJIgt5EU3hhmhtNChyMECvEi8Hv878bULIMKGvr6vdJT/rucgdvDnYaF1nn+XT
 gT2D5+UUDD4WzpTsrjA6MTKvDy+KXN8FFcxcgzqVU1uDv+8wBiOKoPL0lie1xrHKLoOeB1lqlsB
 ORxlVEL3KLvUbFBaps4zxN3jdAdkAsxyKZB9beTWUo89s3eRe0V6aPFWgg+yTVpBuCaYol10UMl
 KR5ErXk7I3eOUqeTCRzGf1u5E6QnpeRn4ZhekQvmvZ5wGu/UKhYzF0K8OkBsfQKJr2PaufJG4AN
 CN+iwh7IH8LK4ekAxt52SfdwMT0lgPmuPVAkkXxvejjRF7+0qoLgfY3r2LqOZQaXtk1tVVBrq64
 5CWUVaVAXpT24r2uDr4SYKk0QZgwIprjx3BcY6Ud6gOdJX+Fy3/0z9as=
X-Received: by 2002:a05:6a20:430c:b0:394:426b:6791 with SMTP id
 adf61e73a8af0-3944897ea20mr1572075637.79.1770877579384; 
 Wed, 11 Feb 2026 22:26:19 -0800 (PST)
X-Received: by 2002:a05:6a20:430c:b0:394:426b:6791 with SMTP id
 adf61e73a8af0-3944897ea20mr1572056637.79.1770877579043; 
 Wed, 11 Feb 2026 22:26:19 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:18 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 14/31] i386/tdx: refactor TDX firmware memory
 initialization code into a new function
Date: Thu, 12 Feb 2026 11:54:58 +0530
Message-ID: <20260212062522.99565-15-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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


