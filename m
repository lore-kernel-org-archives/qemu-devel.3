Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC51CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQN-0008CF-QI; Thu, 09 Oct 2025 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQL-0008Bi-Nj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQE-0004LL-T8
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a375QZbeNwmaWpIoRvdNLtIS+2HVCnHIvRjrNsLKivI=;
 b=hiGqxAciF+Kt1lKz7GTdtdCrcg7ZItAsPRKjR12Qa7swFxQgcdauHkzIZM4F+ATzTgzuRG
 t7nCPUVV1Fzx5+ZOnV2noQk8Rz8S0y5skZHCh1ZGuup0/xf83kTJKzhHekL1h/4Vbo7Xpw
 Q+LlMV4N1UIUeJnu9wX20OF2D8rGDQ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-DjIZF7ygPeKAVaxdAKIfjg-1; Thu, 09 Oct 2025 03:50:42 -0400
X-MC-Unique: DjIZF7ygPeKAVaxdAKIfjg-1
X-Mimecast-MFC-AGG-ID: DjIZF7ygPeKAVaxdAKIfjg_1759996241
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e473e577eso4024165e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996239; x=1760601039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a375QZbeNwmaWpIoRvdNLtIS+2HVCnHIvRjrNsLKivI=;
 b=KrJ/xT/tpF4/qvtGQttJ+klFNTteya8KG8kCHb4Rp1iJ1PNEbmpi6wOZ4a89q27p7j
 TTKxvtmXEgmKB5mMyVfi5rhzYRv4EJxwoabva2/LH7ngFD4Nea2FDpwZxcDBzNeiRLti
 ECvuVhgofaIxcOZPyZHrrWLWYOwJDY93M2lCQT7WxX3Dp24stj7Aj11QxOWKDoKNHlwM
 K0917+XwTi2SYbjZfYWb3KbL7ypIcMzY0nkcOY8z4n9rM6/yuMNvGOAsuXVmUfzlslwR
 mPRCoH+W53QxxsuQ8fOnVD8wkzmo0sDtkfwEZHwSRcBZNTrINVcmGPaWQJen7mD/vS3Y
 3MZA==
X-Gm-Message-State: AOJu0YxwwzuyFtavnDNIqKJ7CvsVo7pbfWmFkWXz/GFpmlvauxA+nHoG
 ZFZUbYYkX9CsuvrJY+FkdUqJ45ks2GgYs2jlZc44A9FG5rsejmpaUmFpac1MoEdE9VJdsn8EpqM
 5wnWyYERqVw2DR8gPSOQgrw2Pht+VPHxUd9DaItRnUz+FCSP6k0j0Et5+SWV24oITnbH8alel1Q
 LVixFRfZhALLrWGsDPFBlIOcDONaE9rPDGm+Y7VhaHqqM=
X-Gm-Gg: ASbGnctA7brE8Ws4U7O9I8/pBgb/6j89B2EHP6kuMltFgJZfDtslceRU2LptaQW1otU
 GmzzP5x9pCuA/BK7hIY1oHK8BVEhjlSbaGN8qYWsBRYEz0ZZGe/5WQSba+btO6/Gc6fZdS/93Wh
 GiKz/gud1JgLgvmlpRFE3Tvxq9usF1zqbxd0kvtvNu0W3J/7Ld8Y6LaGYcqetbWDNtl08bsG0LP
 +7/+LA+2vJl9VvMO2BbR4r7hYqL1VSp8hpyTRS+1IqrGE++/mJuPQMK2mpzbOvpzQJK8wElpHhw
 ets28yWqmWzNkyFcWZ3YXgq4ykXMGrsXnjV7Rr/184ZgjCuIZxTOUHgV2E5WYUup4rQKUqVGZr2
 blOX0NE8QenBykXg6IQURAAt0Ttw9ul+CIv6AVFa3fOWoYxjC
X-Received: by 2002:a05:600c:a02:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-46fa9b052f2mr50291655e9.30.1759996239120; 
 Thu, 09 Oct 2025 00:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdy4xTp1dnf31EJIaH/MkeDuj3Q7LBkfE4v7fFCGEEjyhGfOtCVYCWiI305qefRNp4xGYuKA==
X-Received: by 2002:a05:600c:a02:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-46fa9b052f2mr50291415e9.30.1759996238513; 
 Thu, 09 Oct 2025 00:50:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b8bsm33338863f8f.4.2025.10.09.00.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:50:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hector Cao <hector.cao@canonical.com>
Subject: [PULL 06/35] target/i386: add compatibility property for pdcm feature
Date: Thu,  9 Oct 2025 09:49:56 +0200
Message-ID: <20251009075026.505715-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hector Cao <hector.cao@canonical.com>

The pdcm feature is supposed to be disabled when PMU is not
available. Up until v10.1, pdcm feature is enabled even when PMU
is off. This behavior has been fixed but this change breaks the
migration of VMs that are run with QEMU < 10.0 and expect the pdcm
feature to be enabled on the destination host.

This commit restores the legacy behavior for machines with version
prior to 10.1 to allow the migration from older QEMU to QEMU 10.1.

Signed-off-by: Hector Cao <hector.cao@canonical.com>
Link: https://lore.kernel.org/r/20250910115733.21149-3-hector.cao@canonical.com
Fixes: e68ec298090 ("i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check", 2025-06-20)
[Move property from migration object to CPU. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  6 ++++++
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 15 ++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 414ca968e84..42168f1d6d8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2320,6 +2320,12 @@ struct ArchCPU {
      */
     bool arch_cap_always_on;
 
+    /*
+     * Backwards compatibility with QEMU <10.1. The PDCM feature is now disabled when
+     * PMU is not available, but prior to 10.1 it was enabled even if PMU is off.
+     */
+    bool pdcm_on_even_without_pmu;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d7f48150fdd..4668918746e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,6 +88,7 @@ GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
     { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
+    { TYPE_X86_CPU, "x-pdcm-on-even-without-pmu", "true" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fe369bb1284..ab18de894e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7908,6 +7908,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Fixup overflow: max value for bits 23-16 is 255. */
             *ebx |= MIN(num, 255) << 16;
         }
+        if (cpu->pdcm_on_even_without_pmu) {
+            if (!cpu->enable_pmu) {
+                *ecx &= ~CPUID_EXT_PDCM;
+            }
+        }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
         const CPUCaches *caches;
@@ -8958,9 +8963,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    /* PDCM is fixed1 bit for TDX */
-    if (!cpu->enable_pmu && !is_tdx_vm()) {
-        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    if (!cpu->pdcm_on_even_without_pmu) {
+        /* PDCM is fixed1 bit for TDX */
+        if (!cpu->enable_pmu && !is_tdx_vm()) {
+            env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
@@ -10021,6 +10028,8 @@ static const Property x86_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("x-arch-cap-always-on", X86CPU,
                      arch_cap_always_on, false),
+    DEFINE_PROP_BOOL("x-pdcm-on-even-without-pmu", X86CPU,
+                     pdcm_on_even_without_pmu, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.51.0


