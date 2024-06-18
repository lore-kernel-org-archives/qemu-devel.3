Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995ECC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIX-0006wN-B6; Tue, 18 Jun 2024 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIO-0006W6-Ew
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIM-00074L-4S
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c6011d75dso6891785a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726572; x=1719331372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeFHpBJtgKcbbwJwJ5FK7MJMvna/CViY1T2wLMd8oks=;
 b=YZ0Vn4A1qhF8MQPYbQiBD8v4Y6HYYUwXnCJDRXrfNQjOR5CD/i5kTx0JKTBGYLtZ4C
 ldKiD98SNc9emxL9af6UNGWK5L8x78lCnbsEMu2PG1nmY0kGhpY1sN50vBOuaV/svLfz
 drlZe6PVCEDN25g6+Ii85ffyI/uY14RdiOLGbkPgMXSxy7bW46khKhjpZNquhfEEdP2M
 XKYJIsJTP0lSADLAzxfVDxktuJQoqI9LXsRejzSuufdVbVTzivcB6G4E+yFQKLG+q8IF
 A4L34ICaEhHSSOcWgGuqsfjkufNItL9sWwqD4TkRFHZ6TBN986sGR7DrpvZxV7797fiJ
 65iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726572; x=1719331372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeFHpBJtgKcbbwJwJ5FK7MJMvna/CViY1T2wLMd8oks=;
 b=qLF9KdLPDIcU/s888trHaPoa9wcIS1g8Wu9g/VMkOTHv2SPuHKKTa5W1aREJExzRME
 9BzrgmWwB9zSgtJQ2p8SaDaMCx2It8HuxfpJzoN7dPHUypDQZQUVRmaj6yBDXFqz+313
 1x77ip3zpbpHOWImL6xRXx+AcgzO18o/0BnQhZT1aD2j8DkoSwqgLmsDNTYMVGbOsTVD
 Sto3G/KY1AJkZuGDj2adfWiVakBjmqZfJGHAJdWbvJ9ffSrKhnAGBCV1LWmfHQLb0JmI
 hU44AbR+j6vg82GyEp+8vGl/+mD7jnpbgDNSHuRqm1nBs07S52EqdqbOJlAxmb6rmpzs
 oaPg==
X-Gm-Message-State: AOJu0Yym0IHELddiBc9UVzqyftkQ3YndcZfPp+PLYCmmNW/qrWBjPDT1
 YAKqTMlDIzrHu0RRE9+DIQLwt6Yk40q4uP245vm3JG5A7kOkIe/Vsih6PdIA9aGmyvP7uDGOQ+2
 J
X-Google-Smtp-Source: AGHT+IHZWDrKmmEQtw86+Gr6WJxpuLrmN1NUK/Tz8EyoZY4fFYddAYht+1XYN5/ZR3LiSXte3h74aA==
X-Received: by 2002:a50:d515:0:b0:57a:2e8d:c308 with SMTP id
 4fb4d7f45d1cf-57cbd8b9befmr7763559a12.40.1718726572391; 
 Tue, 18 Jun 2024 09:02:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cddba1a17sm3598763a12.43.2024.06.18.09.02.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 22/76] target/i386: Remove X86CPU::kvm_no_smi_migration field
Date: Tue, 18 Jun 2024 17:59:44 +0200
Message-ID: <20240618160039.36108-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

X86CPU::kvm_no_smi_migration was only used by the
pc-i440fx-2.3 machine, which got removed. Remove it
and simplify kvm_put_vcpu_events().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-23-philmd@linaro.org>
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 7 +------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e2a9b56ae..52571ababe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2108,9 +2108,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 365852cb99..4c2e6f3a71 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8281,8 +8281,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 912f5d5a6b..7ad8072748 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4474,6 +4474,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.sipi_vector = env->sipi_vector;
 
     if (has_msr_smbase) {
+        events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
@@ -4488,12 +4489,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             events.smi.pending = 0;
             events.smi.latched_init = 0;
         }
-        /* Stop SMI delivery on old machine types to avoid a reboot
-         * on an inward migration of an old VM.
-         */
-        if (!cpu->kvm_no_smi_migration) {
-            events.flags |= KVM_VCPUEVENT_VALID_SMM;
-        }
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-- 
2.41.0


