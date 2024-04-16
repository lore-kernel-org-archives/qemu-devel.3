Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D6C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjIQ-0008Gs-SY; Tue, 16 Apr 2024 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjHG-00065V-DY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:55:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwjHC-0002Cx-LN
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:55:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso3777816a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275709; x=1713880509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1653K/UfEWnXUTbr/YeJw2UmUosHHOUFfds+vppZrE=;
 b=UfOJuBTEmzzhiXiiMy6oGIOkg9WNGBqsbQLSURQyR2GMU8WsPQIZYnu21l7kgIBv2F
 rJSseFWHiM9TvxECMSF/ab6JW8KTRVkG+q81JDfj0ij5eEddQaBeyo2uR0KCNEKsaiWt
 FcGBpgFYq2KizZPWTXJ6b3UO7u4gqKihJLWqAc+/rBOZaS01vjDWoeCrous1+E309bfI
 ykqqsWVPk1IVXyw5pGjpW18NCB2olVjFhOoRIYtbFi1Hci4jGTdzkWbXbEyLEoBOSAlx
 MQP2Ksgvgme1+WZgOaHJNv/y9TcqsgSGFNfGvHquttzypbTldb1t3ouNZ9n0sW1lfkQF
 q4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275709; x=1713880509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1653K/UfEWnXUTbr/YeJw2UmUosHHOUFfds+vppZrE=;
 b=UDBCLEijM8QfEvHuIrPEsFrZgrNAdjeSFd4g8uEf0WKNzj2kRChvS8aIBjpGAosEAP
 F1G9Qhz52yL90RjeQLsHVwSvbXBBKvLVcfZuPGPhlJy7CMb680NH/yWDOuFz5bZPt7TA
 ZJ7XpIfby5Jdo61/DJWH9VYjWdlo+iFTMpUvLP+4Oi0F9saw1Z/immqEgki2bWfCq36d
 HlRllZgS3+PwjGmvwVLCAKQ5dqiyEH/uKVS5lFERb8bllB5BCiL/KrUT6S8rmKvRrVFN
 gAjFr2/TAuTUs+HYPKC+XwL9O+Gtr1PB3Gz/xSKGBapkTHMRtaCShWU7T7+uBHFnWTkl
 POMQ==
X-Gm-Message-State: AOJu0YwImWi+Siop3JqZ2ZYU316mk18j+NoIhuw0qLFvAgI01YHAQcHy
 uAaVLR7ctrL6N6Uj3LxHjUY0NkgQ87/pvHox3amh/BkTZFasChgj0kJ2/wQ8nhXc1pEIH/BM9tR
 9
X-Google-Smtp-Source: AGHT+IHkUMQgIFsx5SzP07ohbcv44kLEvoExY/YrMlXFyL1i8R4mcChXMZxYy0/mFxCZjbzS5CDwpg==
X-Received: by 2002:a50:8ace:0:b0:568:d5e7:37a1 with SMTP id
 k14-20020a508ace000000b00568d5e737a1mr8273701edk.36.1713275708861; 
 Tue, 16 Apr 2024 06:55:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 bl19-20020a056402211300b0056e064a6d2dsm6108679edb.2.2024.04.16.06.55.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 06:55:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v3 21/22] target/i386: Remove X86CPU::kvm_no_smi_migration
 field
Date: Tue, 16 Apr 2024 15:52:50 +0200
Message-ID: <20240416135252.8384-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416135252.8384-1-philmd@linaro.org>
References: <20240416135252.8384-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/i386/cpu.h     | 3 ---
 target/i386/cpu.c     | 2 --
 target/i386/kvm/kvm.c | 7 +------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b05738079..5b016d6667 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2018,9 +2018,6 @@ struct ArchCPU {
     /* if set, limit maximum value for phys_bits when host_phys_bits is true */
     uint8_t host_phys_bits_limit;
 
-    /* Stop SMI delivery for migration compatibility with old machines */
-    bool kvm_no_smi_migration;
-
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee1..f9991e7398 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7905,8 +7905,6 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
-                     false),
     DEFINE_PROP_BOOL("kvm-pv-enforce-cpuid", X86CPU, kvm_pv_enforce_cpuid,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe9293..88f4a7da33 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4337,6 +4337,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.sipi_vector = env->sipi_vector;
 
     if (has_msr_smbase) {
+        events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
         if (kvm_irqchip_in_kernel()) {
@@ -4351,12 +4352,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
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


