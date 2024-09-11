Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2473EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMXx-0005VD-NA; Wed, 11 Sep 2024 08:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXv-0005H5-Kl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMXt-00012u-LA
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pit7qiYVqnOWSVjEH0t9en0kWfam4PoVe6YUyM257fE=;
 b=Fqx0A5tyDLp2yzzOTqTHfnI+4qw+YFi6MMewuwM1GAIcdPlMF3vPrQE01NAFpEWJ/yYh+Q
 0E6/bGxbrmNXg4XIv8ha3IwlaRhKuO80YYTnw3s7YV10pEbvkSBgLnsztgF8FP061xd3GP
 WHtWjtolLWRhoMNebhxuCTGCoZCoQp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-p4mEJYwUOLKIPs-Kb8fT6w-1; Wed, 11 Sep 2024 08:34:04 -0400
X-MC-Unique: p4mEJYwUOLKIPs-Kb8fT6w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb0ed9072so37259025e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058042; x=1726662842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pit7qiYVqnOWSVjEH0t9en0kWfam4PoVe6YUyM257fE=;
 b=Hf62JALdAIcHVTuCjsV5ceIluvntqbqajYFyl6MPFZaqVjmZcMsEYs1UT71m5svLQy
 dxC02zFI/e/estb2wfBA6V4kOG5LLfTSn6URymL9pWDb2eEGeiKMNCHlG7LlArqEIJj1
 UGcH7yEWA77SvftugLq0xMgjozRVcFPcex0U4MU6Ap905I6+KSM9lybsHScGSRHGtSva
 KdAlunDSdLAwBUaE01X3ClWf3Nsn8CDPmEg3vaR9lwDtGoFUfo38bl/zsImCZ/GRgyb5
 69H/l3UC+0Xkxw2lin1SP9coPvoiJVl2EGQWYaeoLEFhiEpXST2PBt+ISfLcyrV4hRFu
 KASg==
X-Gm-Message-State: AOJu0YyT+QHdKfe0r6n3dVBgmpqi6Cs1iyFh/HzqVZWrsKyW6Yjfq+3k
 6vW9tnnv6Sqqy28/1et1SF9+K6+qS8V8ZSbsEg3XqmvCDQQbBrTZ7AN7HXzecZz+oGp4w5nRrLT
 c9ivdKJqV4d3VBiXwT4Xy/XAxl7VKoqvh60Q3DOr0OKf9GJ+jgMS9q/jKlW9JWz3EEvt4X8GxeU
 UnWUVccSklOP9fguQFSJnXJTp3Ntuj4mK7uq2uu1o=
X-Received: by 2002:a05:600c:358a:b0:42c:b950:6821 with SMTP id
 5b1f17b1804b1-42cb9506a4amr83041095e9.19.1726058042011; 
 Wed, 11 Sep 2024 05:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPWOPoXwIRnhEFSJs4L0bBpigenF/2c5N4PsmiDOGtEEWyhQYmJ1jtGqUQP5AttL87YqQpXw==
X-Received: by 2002:a05:600c:358a:b0:42c:b950:6821 with SMTP id
 5b1f17b1804b1-42cb9506a4amr83040825e9.19.1726058041501; 
 Wed, 11 Sep 2024 05:34:01 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb449aesm140800895e9.25.2024.09.11.05.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	philmd@linaro.org
Subject: [PULL 06/17] kvm/i386: make kvm_filter_msr() and related definitions
 private to kvm module
Date: Wed, 11 Sep 2024 14:33:31 +0200
Message-ID: <20240911123342.339482-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
easy for developers to understand that its not used anywhere else.
Same for QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers definitions.

CC: philmd@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240903140045.41167-1-anisinha@redhat.com
[Make struct unnamed. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h | 11 -----------
 target/i386/kvm/kvm.c      | 12 +++++++++++-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b8..9de9c0d3038 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -66,17 +66,6 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
-typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
-typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
-typedef struct kvm_msr_handlers {
-    uint32_t msr;
-    QEMURDMSRHandler *rdmsr;
-    QEMUWRMSRHandler *wrmsr;
-} KVMMSRHandlers;
-
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr);
-
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 381f414d1e0..d95013a2ce6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,7 +92,17 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
+typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
+typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
+typedef struct {
+    uint32_t msr;
+    QEMURDMSRHandler *rdmsr;
+    QEMUWRMSRHandler *wrmsr;
+} KVMMSRHandlers;
+
 static void kvm_init_msrs(X86CPU *cpu);
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                           QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -5735,7 +5745,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     return true;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr)
 {
     int i;
-- 
2.46.0


