Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA58CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrXj-0008I9-Gn; Fri, 16 Oct 2026 19:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliveriandrea@gmail.com>)
 id 1xHrXZ-0008HL-QY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:40:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oliveriandrea@gmail.com>)
 id 1xHrXX-00033b-6T
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:40:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so5528585e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792194041; x=1792798841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r1UFcyolx2df8n1PgORmj6GbMSmQ7olQG3p8HzmWRdU=;
 b=N/72F84L2X7RLwftPpsaj5CGvKZoUa83a95WsdgiSSfKXNl2BjX4hSOa4cYWPlAN9n
 mPHPNZnI4ytuFovPJdDy10NqILzi+DpKnsPCMMULgB1RWDJblVrz6aiPQoc8gawzE9bq
 WgMp95MOYyQVZmoX1fYib2sOQMK9KrdaigPOccxqelvdlFU8IspZ1f4zHHp/EQ32K3D2
 Y/ROtI7mXRp9QXO3GXPv6Csdb7A8C9AhVQSm37opF5ba9y6lyoz0ftevtw681/344enX
 ogE/Ya89RHPbSOM3JnUlPNsjn2XbH6DVo2y29bA9Fm5p5yv5RdgwnJW9g0qrr6Nt9YJZ
 QxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792194041; x=1792798841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r1UFcyolx2df8n1PgORmj6GbMSmQ7olQG3p8HzmWRdU=;
 b=q2wQJI+lvHy3LaBfO/R5HqNgVQ44GTplS5E+Lr+sQwwmwWln0Zh7eZAxG1Ibl2ak9T
 rw+MoJnEaHFvchWbWoMhtR3BZETy+OFfkJLHw0Rcbk7TG2f8keEoVrKhmXcPYIIzCTwC
 hrD82M4e2JVNjtT3G4C4L8YoGILqiIdx649w0h0Dd5ZEDppxmJSGlGRMZEnTR/5XyF80
 cgkD0bXnaTANsD2qALMpixOLg3KaOjwGjUJBH8yWrtjXWNMgj07f67I2X9qoNO84XimF
 y6bje2o4sooDuhZg7S8/sgSLiuusFdmNOQEuMx0rBsekFeQl2ldjR1rMw8Pbezcq/7fm
 VVKg==
X-Gm-Message-State: AFq9FYIxWTobVVaFoJFZXR52fkyLwik9PnNkg38LBNr41OrIXWKPJ260
 b5mipBsRsGCgttdtnHRYrWKMTX+CAtQZf6gLn4FGK+ZJQS+idlQk7UArYOMZXOVk9NE=
X-Gm-Gg: AYBFou1hx97paVusu8itzNZbrpUXRHsVWzyBt7NEk57yaNhczzCipUIN5qN8VWBIuLf
 0MTj18uiUu0D/U66uVERhiOkfM+Zm82o9DCC8g/vzncU4XDADcmaMD8doTb4eDVL62/ppn56ujh
 IC9P76sxfl14GuuEk3ZRBeOWkRW/1PN9b7cGRfIr8r2vNURR1+wWOZAYnvKWebcO1vYleGM3+ND
 5UwULEbRb9rwKa2rj7U4qCMGiQpeTmAupOQMkSd+5EYHx3+XWAzbTBxymqSJ9vpVO5HfJGnjh/a
 BST+hxTYFdhO99pnHQ35wFW3bWH5lGhCKVaeqK/8lyW1INIws1+ucNFFAkkcCt7bVJYYtJ5H2tL
 dKj7esrfTPXpKHygULuHytYB4AoLFmHasIqM+JNAkpugZpS2giz439KeZ7vloJWu9B4mP7BlIWE
 LZ0ASGu99HbmwkygFmmFAhRaha5K3KKOg3t/6ifvFg5iQx9kk+ez41MO4TzxBM3dpg0+PG3hp94
 nzz3fXAx9hDb1jItAQ=
X-Received: by 2002:a05:600c:4ec8:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-4a1d76001acmr30283065e9.6.1792194040695; 
 Fri, 16 Oct 2026 16:40:40 -0700 (PDT)
Received: from rio (145.176.116.78.rev.sfr.net. [78.116.176.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c0894sm7172224f8f.12.2026.10.16.16.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:40:40 -0700 (PDT)
From: Andrea Oliveri <oliveriandrea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 Andrea Oliveri <oliveriandrea@gmail.com>
Subject: [PATCH] i386: Hyper-V nested sleep states enlightenment
Date: Sat, 17 Oct 2026 01:40:27 +0200
Message-ID: <20261016234027.1002275-1-oliveriandrea@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=oliveriandrea@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
Security) allows hibernation of its root partition only if the parent
hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
it, so such guests report "The hypervisor does not support hibernation".

Add a "hv-nested-sleep" property that sets the bit. It is a hint
only and needs no KVM support. With it, Windows 11 26H2 with VBS,
HVCI and Credential Guard hibernates and resumes.

The nested hypervisor uses the bit for one more thing, on resume:
instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
TSC and the parent reference time saved at suspend, asking the parent
to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
the nested hypervisor ignores the status and already compensates the
TSC jump in software, so the guest clock stays correct.

Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
---
 docs/system/i386/hyperv.rst    | 10 ++++++++++
 target/i386/cpu.c              |  1 +
 target/i386/cpu.h              |  1 +
 target/i386/kvm/hyperv-proto.h |  1 +
 target/i386/kvm/kvm.c          |  5 +++++
 5 files changed, 18 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index e1babffb0f..4b37d5536b 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -187,6 +187,16 @@ Existing enlightenments
   Note: enabling this feature on old hardware (without APICv/AVIC support) may
   have negative effect on guest's performance.
 
+``hv-nested-sleep``
+  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
+  Security, or with the Hyper-V role) that sleep states are supported for a
+  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
+  on top of KVM disables hibernation (S4) for its root partition: Windows
+  reports "The hypervisor does not support hibernation", and an S4 attempt
+  makes the nested hypervisor reset the machine. No KVM support is needed: the
+  bit is a hint only. On resume the nested hypervisor issues a hypercall that
+  KVM does not implement; the nested hypervisor ignores the failure.
+
 ``hv-no-nonarch-coresharing`` = on/off/auto
   This enlightenment tells guest OS that virtual processors will never share a
   physical core unless they are reported as sibling SMT threads. This information
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5da80ade70..9df628ed2a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
 #ifdef CONFIG_SYNDBG
     DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
                       HYPERV_FEAT_SYNDBG, 0),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7a88074c0..bff8b1d192 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2374,6 +2374,7 @@ struct ArchCPU {
     uint64_t hyperv_features;
     bool hyperv_passthrough;
     OnOffAuto hyperv_no_nonarch_cs;
+    bool hyperv_nested_sleep;
     uint32_t hyperv_vendor_id[3];
     uint32_t hyperv_interface_id[4];
     uint32_t hyperv_limits[3];
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..df6ce6ae42 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -81,6 +81,7 @@
 #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
 #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
 #define HV_NO_NONARCH_CORESHARING           (1u << 18)
+#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
 
 /*
  * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..76f1a37ea5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
             HV_NO_NONARCH_CORESHARING;
     }
 
+    /* Only a hint for a nested Hyper-V: no KVM support is needed */
+    if (cpu->hyperv_nested_sleep) {
+        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
+    }
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_IMPLEMENT_LIMITS;
     c->eax = cpu->hv_max_vps;
-- 
2.56.0


