Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36593D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvt-0001JB-Gf; Mon, 02 Mar 2026 03:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuz-0005jI-6P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuu-0001zt-I9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cf6isYD+OolPZbS6pv/sewBMZtuQ2D0QF8qlsf4NjRU=;
 b=BjEVKlP8r4gAdAX07t3Q1E6UJvk2VtMUKVqptu0yhoLD9NOcpuXR6gp+VPozDw0fNyR36n
 UWCeH8coh1V2DEEIszRoYPZDADxwXa+lBhHgvmrbdA3lxhIZBH+ZU7CO2n0ykglVDYBMYm
 SJk08jckdkI+nXRYFYeVnQik5r6JMrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-nRWxzq54PmaeGW50_HkAZA-1; Mon, 02 Mar 2026 03:46:14 -0500
X-MC-Unique: nRWxzq54PmaeGW50_HkAZA-1
X-Mimecast-MFC-AGG-ID: nRWxzq54PmaeGW50_HkAZA_1772441174
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48069a43217so41051455e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441172; x=1773045972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf6isYD+OolPZbS6pv/sewBMZtuQ2D0QF8qlsf4NjRU=;
 b=o0F0ajA5BtY6TZPpG4tY9JYY+7T26rqDG9byIzr0Kswt6s/iuJMdtdQrjrTDg/RQll
 W10XkCzEYU1S/D98PcCL5aPlIGAXp861uxTBvfEd9w5PlNF76+M/rl7h9h7pE+Ucr3Ke
 VUMHbiiP3cofo8kmbxV1Y+V0P9n9phQoiAf5u41D15kBawTkM2rtNVtbfpeAKeNuAL+V
 9z/aKAn0PKGs1698qtIrR7NMnMJItG58tpmuK+sJAcwHFQhpxfpAkmuM+OkheP9+ENul
 Px0WtJTuihOGuMXGga0y+999PQoosmMbuhbeeC43eZlZ3qZhOhOvbQwrzpeEDBpOALKu
 7Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441172; x=1773045972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cf6isYD+OolPZbS6pv/sewBMZtuQ2D0QF8qlsf4NjRU=;
 b=FU53nYlikAophS/+wmoT2VmObfjn27D/W7eMYHtpIiWNB+pnCBzivkNdHDx0lPitK9
 JKliOxZhJifM9+P72o0/aJOvbcXhzSoQe2m5cGcO+hZPB9+d1TzppzVnIPwyVvpT07/o
 pwgi+pm1fuuDxCi5D4wVuK+46EdYR+jxrVf/R8bk9R6mn/DdyBrUpBwjMyaGLVPSdY2a
 +eStbvD5uDiFIi4MajyBZzQMX783rJzVhWGJ7LaMfHGE4u1mHbcUARabGINM2uSa5c38
 jxBGUbgYzTZhy0OtwEHveMs6DhfvbnbaoPsCsr2xhH8YOAZPANemAm3f+tj0UrMI+7e0
 2P7Q==
X-Gm-Message-State: AOJu0YwCVlp07qxCKbQlcgxRnReDOhEXpeZaFHyWT5IOyavtO5rbU9Wp
 G3bnJvY8cjiBmX6d1043qtkwLpbTARqrDZCKhDNxFJ/l0A2C2z+0lLF7rLym86qLLl6pc54TVVV
 UwxLZqvciSAUsSHWy+lADOHIEQ4jmJ0pRxvxmybCCuZT02hy4C9y0qsDWvt3ce6Bey8J3aRLSEZ
 rM5yjCy+HMDx8rxS2kYFvqRrhAf86FtQdtu9jP1H4s
X-Gm-Gg: ATEYQzwPzTGIyMILulsKpwhINwDKfkroveQrFE/Psi2RU72Nr6axhHATHgcKRyP6Hxn
 YxICiUHEToj4B9y0ZDiC6iflTGlKqgc9BVocG4AqyIu+9Vpxf6v2gHiNRD2bb3cFGLKto2Cd8/b
 9ZHxj5FZSJ2d+z3iFFTzJmwQCc4HrYotE9FN4wTigvB1ljVkWAx9rk1ByKJ5YL80+OSUqPTA13j
 b1Kwg6lm8t5qHpM9NFL6kWW0uLhPHk2iis3O0j3gBbGXOrKafGl3SJ7f6xYxItH8+m6I+ZghK0L
 280zR5oLulsNnDgk4HMXt59wYjjKx6isua9lacJjSIme1wCruswDPvA5RYPAxj8xumka2cUOEC2
 88DwxODM/5PL33SkcXXDSPwLkzn2tI6KKKnBMLegGCuqkTotRYuD7XM2MiQyVr7O+dqt3qHlWuc
 U1R8YCKfyAj0QXwfQXdvZTgce52n0=
X-Received: by 2002:a05:600c:818e:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-483c9ba3aadmr208018235e9.15.1772441172306; 
 Mon, 02 Mar 2026 00:46:12 -0800 (PST)
X-Received: by 2002:a05:600c:818e:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-483c9ba3aadmr208017735e9.15.1772441171828; 
 Mon, 02 Mar 2026 00:46:11 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbd781sm233589295e9.8.2026.03.02.00.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 057/102] i386/tdx: refactor TDX firmware memory initialization
 code into a new function
Date: Mon,  2 Mar 2026 09:42:52 +0100
Message-ID: <20260302084338.473368-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

A new helper function is introduced that refactors all firmware memory
initialization code into a separate function. No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-17-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 73 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a3e81e1c0cc..fd8e3de9693 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -295,13 +295,50 @@ static void tdx_post_init_vcpus(void)
     }
 }
 
+static void tdx_init_fw_mem_region(void)
+{
+    TdxFirmware *tdvf = &tdx_guest->tdvf;
+    TdxFirmwareEntry *entry;
+    Error *local_err = NULL;
+    int r;
+
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
 static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
     RAMBlock *ram_block;
-    Error *local_err = NULL;
-    int r;
 
     tdx_init_ram_entries();
 
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
2.53.0


