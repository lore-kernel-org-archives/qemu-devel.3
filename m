Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53B5CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10T3-0004bb-8k; Tue, 23 Sep 2025 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10T1-0004Xd-J5
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10Sy-0006C1-OZ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758624105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S7AvEaNloXl7AAmAS1Y5CI+jWkOoqizDLL87K4Tp+NY=;
 b=Pu2AhFm7gI3jKQqYTlgVv49Qw7ZNqSyhYWbXPeejgPXnUZrzh/HlgvPzM6CzvZCWDfYliR
 kDcNgXC4DSFieAkLZ5YI6r5fPxN1T5eI9Jd13eRAW+BfwMKoqPUqpIrDM2TnFv0gz2541E
 fmm6pNccG62PcvOgzcaSe7JNYJPLEcg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-53sgG4HMOW2R-9bmYnjv3Q-1; Tue, 23 Sep 2025 06:41:43 -0400
X-MC-Unique: 53sgG4HMOW2R-9bmYnjv3Q-1
X-Mimecast-MFC-AGG-ID: 53sgG4HMOW2R-9bmYnjv3Q_1758624103
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2ef8e0133fso114461666b.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624102; x=1759228902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7AvEaNloXl7AAmAS1Y5CI+jWkOoqizDLL87K4Tp+NY=;
 b=o6dsJtX0zS/4jvVug6uyUNOi9jTvLvArqxrrSERZdHPd+dJ+hQPZSeu3BfQkU1peL5
 RoBVZxGUrTQRej+GTyx0CT78i7XYoL7wk1t3LNSF5Iv2fO1rjSN8BkxDz8QUEkQGNL5a
 ajPNi82396doEGO30q1mM8ISGRUow2qEDSeW4CW3TiRN8hOHSJEVrC+vR/BRveRfvPgt
 getkTVjB6vcr8Xxj6X/NSpI6HupjJmpScXdo5dpRZ7/h4nV9iCAVW7jU9q4IaAPdWQgE
 JZKqj2LD+6gKYpYoomKi/pMGpELGJNWY7AcD7GJr+QRbjQTIHiBwpMx9rLS+/ByN54Tv
 tiZA==
X-Gm-Message-State: AOJu0YwxMDc/xpNbninEL3rgZCcrgJBCGZugvNTzo+qyZj0gQuYjgUWz
 cwPSO7LZVkMOusb7qLLpO9Bljh9+zYI3UU3MmyKzGWjbKdggSBQPE1CMw9FHHzr5qBxfxdYFLAV
 a3G4bi48+rzhTvAnSg5QJjwGsL1KJhmEChO/HG6hE/p4H4JGwkipBwgnBvorT7/5MQzROsmFrSb
 94sH5jgn43p6u8y4zmVMwsLfwn6gZp/EsRfCSSTr/P
X-Gm-Gg: ASbGncu6jQITfGX2MFyRkDSYuPUQQuYpjgk5x2Jdj4GCR8jI9/v52XQoiuWYO0++zJJ
 glafcGmubhm/6+QVS8mIb+GsFuu/kvY6Pa5n6n8ZEtC/H2JFpVVD3CbDsnO9KO3aA8QB3TjZ69g
 LgC0yOz6qxpg6cCXpUn65SLypD0eCGO0fCgi59WywPGVcRMSVkzEgqXTUMaQlOhBJ32EfLT9/GU
 nxgHeH+iTfNajm6MTGxF7QXfZQUJ3h4WZy/bn3VPE8k7K+3qWGlVDastwL5g9ekQhaUzMAhK9h+
 h3rEGiJ4aP/kTPmBJXxFlp6GQ6HG9AaUNqYBTW5Hdh7fydw6SJiqaCZsTzGcBnEsa2A8VyqjLYg
 MfbmfLuu6dmQ1u9OCXyg5SK8PivpOhTQs6uI4Fz5kjAt6Vg==
X-Received: by 2002:a17:907:1c27:b0:b0c:8280:4f40 with SMTP id
 a640c23a62f3a-b30263b326cmr185971366b.4.1758624101780; 
 Tue, 23 Sep 2025 03:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQHA7tA9o69d7U0g0p3zAVDXr1/8g6AOZ2G8tUZEkq3lbwxBT9w7wKwDklgOoCyuqiIRJtEw==
X-Received: by 2002:a17:907:1c27:b0:b0c:8280:4f40 with SMTP id
 a640c23a62f3a-b30263b326cmr185966466b.4.1758624101222; 
 Tue, 23 Sep 2025 03:41:41 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b293fa07816sm705154266b.50.2025.09.23.03.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 03:41:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: hector.cao@canonical.com,
	lk@c--e.de,
	berrange@redhat.com
Subject: [RFT PATCH v2 1/2] target/i386: add compatibility property for
 arch_capabilities
Date: Tue, 23 Sep 2025 12:41:35 +0200
Message-ID: <20250923104136.133875-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923104136.133875-1-pbonzini@redhat.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prior to v10.1, if requested by user, arch-capabilities is always on
despite the fact that CPUID advertises it to be off/unvailable.
This causes a migration issue for VMs that are run on a machine
without arch-capabilities and expect this feature to be present
on the destination host with QEMU 10.1.

Add a compatibility property to restore the legacy behavior for all
machines with version prior to 10.1.

Co-authored-by: Hector Cao <hector.cao@canonical.com>
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Fixes: d3a24134e37 ("target/i386: do not expose ARCH_CAPABILITIES on AMD CPU", 2025-07-17)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  6 ++++++
 hw/i386/pc.c          |  1 +
 target/i386/cpu.c     | 17 +++++++++++++++++
 target/i386/kvm/kvm.c |  6 +-----
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0be7a74068..414ca968e84 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2314,6 +2314,12 @@ struct ArchCPU {
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
+    /*
+     * Expose arch-capabilities unconditionally even on AMD models, for backwards
+     * compatibility with QEMU <10.1.
+     */
+    bool arch_cap_always_on;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bc048a6d137..d7f48150fdd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -87,6 +87,7 @@ const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
+    { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d85149e6e1..fe369bb1284 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7539,6 +7539,20 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 #endif
         break;
 
+    case FEAT_7_0_EDX:
+        /*
+         * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
+         * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
+         * except if needed for migration.
+         *
+         * When arch_cap_always_on is removed, this tweak can move to
+         * kvm_arch_get_supported_cpuid.
+         */
+        if (cpu && IS_AMD_CPU(&cpu->env) && !cpu->arch_cap_always_on) {
+            unavail = CPUID_7_0_EDX_ARCH_CAPABILITIES;
+        }
+        break;
+
     default:
         break;
     }
@@ -10004,6 +10018,9 @@ static const Property x86_cpu_properties[] = {
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
+
+    DEFINE_PROP_BOOL("x-arch-cap-always-on", X86CPU,
+                     arch_cap_always_on, false),
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6a3a1c1ed8e..db40caa3412 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -503,12 +503,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
          * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
          * returned by KVM_GET_MSR_INDEX_LIST.
-         *
-         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
-         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
-         * KVM sets up.
          */
-        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        if (!has_msr_arch_capabs) {
             ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
     } else if (function == 7 && index == 1 && reg == R_EAX) {
-- 
2.51.0


