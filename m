Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A74D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYE-00065K-VB; Mon, 15 Dec 2025 15:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYC-000632-T9
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYB-0005hE-A6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wO48eSARApGSxLARmClClQ2cyCpnzYZ9Xqioz+EDiGc=;
 b=X+MjSOvCP+EIZfcd725O6lP3+ytono1P1FUB7hVwjP4gANgWVXv6nSPBkMNPoxHRlG3wsF
 Zy6u0HAZqauGGMxMdlz1LL4NsPbFiVSM2BGX2PH11GzULTDcyMJ569StX7eYRSzXIVJNs/
 sCiYv5mZxakjRglV8kp/ItIIPq0PVto=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-o_1Ec0UGO-yvRfRt8zcZSw-1; Mon, 15 Dec 2025 15:52:09 -0500
X-MC-Unique: o_1Ec0UGO-yvRfRt8zcZSw-1
X-Mimecast-MFC-AGG-ID: o_1Ec0UGO-yvRfRt8zcZSw_1765831929
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2194e266aso802937285a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831928; x=1766436728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO48eSARApGSxLARmClClQ2cyCpnzYZ9Xqioz+EDiGc=;
 b=GVdZapjvwll4ufRh+mGAixISFDWTGePkbQNuUjOURaUke/7Hf8tNmIJE0wVWZu2XWS
 5ZfV9qi9kHS59pDii/mhyiAtEhK6IIx6YtGzBF87y+zg+rhhVi3CWDNMp4QekJtUSW8t
 he2G6pOmu+xFS7Oty4GUXkR17x+hOBudqoqPQAVKZX5spUPoNPuGZsHdkQDM8/A6uda0
 19UrWzXGq1g5za24WJOa2QYEJVHr0hGdiNeTU4awfoeUYX3TdSJlQlt2xROcvxEB2aRb
 b7E2Os25lBrJRC+dfWYNhEA2uqcNNA2XEAUNInoqlq4kBRmqrCev1RlSYHqtEniX9/lo
 FcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831928; x=1766436728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO48eSARApGSxLARmClClQ2cyCpnzYZ9Xqioz+EDiGc=;
 b=nnJSZWFaG48D2kf/xpbmU+9FhGEZKcEhs3O/Lqkbior/JPS74D5aXo7/zXtpo+IeiJ
 ZtAbzTzJ71CBhkdTBZ3J19NiMIhXGS9LCExz0/jlgdvjR7wC003tj7jj6xHC/NRBqbZR
 wMQbusPXGFILON1LhiqiLkXe+MwkrNsiEO2QE4M16OoLvelgdAr62FT/lAXi9HnBYcPn
 XJCeEA7sJbdQqie5EIVJlhpq1HVhUBISpXvitFqiczMJuhhfksh9D4z/FKkoiaG53w/f
 TFqUTk45YdZ3GDSznjrDolM3CsooTEP0N0OsTg0ak1BQ7Hgzvt6WkOPWO10TCorPIafu
 RI9Q==
X-Gm-Message-State: AOJu0Yw3d+qc2Kc552tv4J1zVB7lobHxPnhoxE+7B1l67qgyq8J7fPIj
 6ewovJQ2l7KJ56MVUnVBAevS0KMaDcU6agqcs+GUDz7R2rK7J0L6Ino9RCVHr98uh16TOsAf/yo
 hit/kKUC4sR5+Eq+v+Tfxm+Ifbg65RKWOgP8xyfiETla4OX31VD0IsKsyZiJyzU0pVP+EHHm1od
 w9AffQsSiGCVl7AGrWLmie5VHI7BZ3UBQGPVbJ2w==
X-Gm-Gg: AY/fxX4ue5YVWezAXuxvx2JE6ChzRH1ABK5WrsUe1SMfrv+ZdU6cFCTnlcawGsF1YZd
 oFUeVQ87N8Ic9oD4cen5T3VOn1ituFb/3xxuO/pbEFJAu8U/hl+zENRtohjg3j8uqXkqy2rerzf
 Fl9LERCknkjctA88mkj47NQxaF8g/qFWQ0EAp1P0lc8Z+pEih5oYS6FHKZ8OHvP7qTKmQlfx1WW
 rPWjT4nmj44Y7hRZtHah5x4I0aL1exwAZDd28nIqVJ1OxLfAkWPXpa35QtWYwf0jHs7B5Q2XfpT
 CXO16qxfrDDD3xgdc8yfYKDUjLjFjbuqh6/tchzoiO8C3nYE8J9acOGU3Erv6JVBZSehsFxEaid
 F
X-Received: by 2002:a05:620a:2a02:b0:8b2:ea56:9660 with SMTP id
 af79cd13be357-8bb39eb9b2amr1641545285a.30.1765831928072; 
 Mon, 15 Dec 2025 12:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoyjdtJ/rhPtsdiJKjZlM6aawycNkDpUb37ahVdf1nFzJGnKCJNQO7JsQiwCj8NiRuOqNtKA==
X-Received: by 2002:a05:620a:2a02:b0:8b2:ea56:9660 with SMTP id
 af79cd13be357-8bb39eb9b2amr1641540785a.30.1765831927470; 
 Mon, 15 Dec 2025 12:52:07 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Mon, 15 Dec 2025 15:51:52 -0500
Message-ID: <20251215205203.1185099-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

With the mmap support of guest memfd, KVM allows usersapce to create
guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
However, KVM doesn't support private memory attriute for X86 DEFAULT
VM.

Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
requires guest_memfd to serve as private memory.

This allows QMEU to create guest memfd with mmap to serve as the memory
backend for X86 DEFAULT VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/kvm.h   | 1 +
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 system/physmem.c       | 8 ++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 8f9eecf044..b5811c90f1 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 28006d73c5..59836ebdff 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
     return kvm_set_memory_attributes(start, size, 0);
 }
 
+bool kvm_private_memory_attribute_supported(void)
+{
+    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 68cd33ba97..73f04eb589 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..3555d2f6f7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       " KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.50.1


