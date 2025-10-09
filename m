Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AE2CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQU-0008EZ-Q5; Thu, 09 Oct 2025 03:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQS-0008EL-Ha
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQE-0004LB-Tc
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8o0W7CirxOV3+oFb65slTdKr/gut3Tw1MOGBhnjU1JQ=;
 b=E1C1IJU0ZNLegUGeMZK933rBSMjk/Z3bawLB45fX/hKk9imj4eFtsNIohHb5+I6yIFuexN
 ZsIiwIMNJX9nG3KA0VCrY3tsfONA3N9Tk4INzBbSyQRRTJk6F0/6pL6wiTDZsKI5gbRH7w
 OR+JX9/vAkHrATcNnshF6VkvUzKe+0o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-hZxwfpmcPImg8eYuGuLUXw-1; Thu, 09 Oct 2025 03:50:40 -0400
X-MC-Unique: hZxwfpmcPImg8eYuGuLUXw-1
X-Mimecast-MFC-AGG-ID: hZxwfpmcPImg8eYuGuLUXw_1759996239
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3f384f10762so512103f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996238; x=1760601038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8o0W7CirxOV3+oFb65slTdKr/gut3Tw1MOGBhnjU1JQ=;
 b=LQ0JH4WDyXEHpJ4eIhPJd5ySHnCpg/vVVJnMyYZ2o8BMJenoxXLIf3Zx2j0UTJ/zA+
 ZzEBZy64RKy5j9MrBCMVxJ+KS/hx/lJdIizhEzVJVFpSxCb8+TlwnUk7J6vmSlwaStqE
 S+oMS2ByZOQiXBH8dx6+SfDmXXumZ9Or2YamTx25JLr+72mNlOyX3qffS3+1WZX9OyFO
 AFcRaMq6EuLp+yNxVabEMYEkxMJ95w+BbgEmPn00escPNaZa21UN4iKv2rZxNi96mMbG
 08Y0S5W/OMvkF+CDDl+C0RP/wTNOFTIxRiMBXyAlmPRg9NixT+POYFz0bE/hiDo/3q7B
 qukw==
X-Gm-Message-State: AOJu0YyzH5z9Mgzwui9HmhXFTSF3k/UQkfJOq3XA8xoKZOfwPAD475sD
 YkH5PQYS9ozS2rKS3ZR3DgR7U3Xdblxy8Pi8m9+gdq+YIn+d+e/oENY595nYQY4t1GP+Fq/ih5v
 sjnij72HXStxSqt3IxxXqUCE4LtIXuuAjxSSQ9YkAM/w1/77ZEwU7zrp3nmnvRwAiSrelAi3kY3
 Ip/S+6i9jWat2zpX3ah7Scqu8L149m05Lh9OjQLaLGroQ=
X-Gm-Gg: ASbGnct0z/w+kocDBPTAnxku4tNUPffqnrkI4d0a8iboiYFnT5CXwXBNna8MoMr8VIC
 bpzWiXJg8WsRMiWgvIvoJEl+PUxXdfqlgt8PKMOjn1oQFd+4WVSphM0MHUhizfwSGz8P2EAQSCI
 EC6OD7MEAv8lIQzMZjFlj2L3jMPRBSLMWlTxBYkZRQO8p0fgwvMT+nyUZGeNe56yCQJoCXtBRPA
 3M0eKF4wkpa87DOwSR6A628SlJyZspLsbLGRYP+aAygyBvAcfRMXOG8qWmJvLKBDR7lL9eN39Xq
 eU3YqrDR69Ta9dyVU/di8jkcn3Uu9ZxyOdzuWB6mDGzut6veYPLTUDoNwpEawd3ZlFCIH0u39Eb
 TY9FFp9O3KSJLU7qFExD1wfeS2aL5sHCKkGbD5zDm+dsP/rrS
X-Received: by 2002:a05:600c:4f08:b0:45b:9afe:ad48 with SMTP id
 5b1f17b1804b1-46fa9a98ecfmr52774395e9.16.1759996237841; 
 Thu, 09 Oct 2025 00:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtkUjIRFugK6gTmJCjoVK477SWfAiaLlNvGvuxxivoj+tBOFqJX/W4mbl1F7M9YDrLEAbm3A==
X-Received: by 2002:a05:600c:4f08:b0:45b:9afe:ad48 with SMTP id
 5b1f17b1804b1-46fa9a98ecfmr52774075e9.16.1759996237308; 
 Thu, 09 Oct 2025 00:50:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9bf81a3sm73199805e9.4.2025.10.09.00.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hector Cao <hector.cao@canonical.com>
Subject: [PULL 05/35] target/i386: add compatibility property for
 arch_capabilities
Date: Thu,  9 Oct 2025 09:49:55 +0200
Message-ID: <20251009075026.505715-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To preserve the functionality (added by 10.1) of turning off
ARCH_CAPABILITIES where Windows does not like it, use directly
the guest CPU vendor: x86_cpu_get_supported_feature_word is not
KVM-specific and therefore should not necessarily use the host
CPUID.

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


