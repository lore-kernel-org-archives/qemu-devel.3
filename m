Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688EDE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQut-0003BH-8S; Sat, 27 Dec 2025 04:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuk-0002PY-5B
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQug-0006v9-Nd
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zu8WUnPfYpMz8lDj9gJ6ePuGh493tji4kOMOKwvE/+4=;
 b=MiWm8HCo4nndXZbhgDIKy0j7za6/jCpJTC4b2qkBq1qwzx6JwcioQAPNfj/baKVXT/+RMS
 tWJzJbLhWNj2HN2Ixrrh2u5co87VJOqNTM77kXTgM2/dy2oSJ8tZW1Pn9Sg9Okk/m0q18K
 5omB/D4tIj1S0Ga/HMQkWIfPQL6zdKs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-i2YutWIzNt-tDJnuxGQAZg-1; Sat, 27 Dec 2025 04:48:40 -0500
X-MC-Unique: i2YutWIzNt-tDJnuxGQAZg-1
X-Mimecast-MFC-AGG-ID: i2YutWIzNt-tDJnuxGQAZg_1766828919
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so5463550f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828919; x=1767433719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zu8WUnPfYpMz8lDj9gJ6ePuGh493tji4kOMOKwvE/+4=;
 b=mHJ/LyjbmZbFBSxLf0qgiWGwcVrjDXjm8M3VunkBlRXWw7xbFhGR7gtmB74f4wOxdm
 stzMYatKNxtrzX0ChMDNMC36BlXgY1Q6kaI8HATN/A7Xg59xB+tQyboyXqDTlJAjphu9
 qm7sYnDOm1Zc7buDw0RSb7e0vf2mT4kdkcLY35r0YrZWcbcKfrC/3+Yw19sCOw/1nJvZ
 iOatUdgkK+UongFNYf1xEH9HbqqE7xbOYguTJINOwEBf1gO97B4SmhqGI3i7g0YGC8VG
 iCEK0NjkO1X233Ey38qK3nwWgqxeln3IhkpOrgeunvTiDinvtc9hZxfqiMYdIoOxhXeq
 aAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828919; x=1767433719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zu8WUnPfYpMz8lDj9gJ6ePuGh493tji4kOMOKwvE/+4=;
 b=JpkiGRLeMb4sxZZkD/cIVwJokXr/fgvEYOVHgnHIvKK8q23az0jMo98O8Rp8B8C+XP
 278L65L8eU7i2XySb4I0C9ZwS1JMogiw9wDRJWBs97G79XqW9JYQRmy90+WY65SamlZB
 V1wZtQHw4/ZxMmHT/k9eVkX2l0jPVYKuA3hZQlwYk85HR71+q8jQcEhgr9hLkvIcgXO/
 e7RO+mh9Ox2OJ9BMS50S8QTchQa5KGqLKp31nhDdZKIxSKJhvPALJ2GaQEb9B0XWgLOY
 6wceZWMEnBV/ypAzlX7az45UFrN7jlAljyNzBFDFqlr5ukp5g+hkx+GNSeKtgFrPR9hj
 GVOw==
X-Gm-Message-State: AOJu0YwRKpnTci0CGNhqQi8J2cAIDMzXu1G0espYQ6E0/pjMdAkh11QR
 +MiQc7vIJfu08xMlXBFTy9Fj0lQdskvKPOSTZ8h67a+iWtqLZimzNBRf7DqDdjkUSy7xFzo/p2p
 MJ7a1XRPPd4lPVu+pakWQizkJehGCvqGonFj2E8Q96Xnr1LcMtQWtzfTAO0lyW55ReYQdrqanKr
 UWTNYebN8LvflZZvWaWwNS1bspNYUw8QJ0V7oXm+Cd
X-Gm-Gg: AY/fxX5e2RfCHAgiOytxkj3ZLngfzWuU7xigqigo0xsJIqPzjpYFaYhy9Ot03k35Cn4
 rFAOe43XZEdlV8ZTHavrEU9f3w+pIEmot/wSxLZWjY69pvr3Ahz1Vb73buzUzzrM4+HpgX1BQQe
 knwBuG8mMAPX5OYhVoivFqfjTODJLIwEWJTkH7IE1uZ/dJBatmjVHMHmb1ajEpfEID9y1hlFLY9
 xPAT8JM4sy3/HAbl4vajldPi3B9ooogKZ8+/dUMIHoNqFqkp8JpC1mTiknNhvVW6qzP3sTT2FKb
 P43Woa8liUq0MsibRbW1hPW5ZBbgziDeEu4e3t9PPgHS5tz85l6M/Pc8zwPdA3JLwB1g5gPSGbu
 GDcJbZiWMcr5klQBVRbprjBw0KUj1YpgB2m9pjEAksgY5ACDC4+f8Jv2Rj1jIl677Z3BpSVitzo
 T5tD9SSB7nzrH3YPc=
X-Received: by 2002:a05:6000:2303:b0:42b:396e:2817 with SMTP id
 ffacd0b85a97d-4324e4fa8f9mr28000027f8f.40.1766828918780; 
 Sat, 27 Dec 2025 01:48:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/OdXTZa2q1Vx06g3f7fdvdNtLApH5gbC6mTAuD1QhnEP6qvx4xRvCRaSCcD2XI1Gh4L5YvQ==
X-Received: by 2002:a05:6000:2303:b0:42b:396e:2817 with SMTP id
 ffacd0b85a97d-4324e4fa8f9mr28000003f8f.40.1766828918220; 
 Sat, 27 Dec 2025 01:48:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fa1sm48197543f8f.23.2025.12.27.01.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>, Chao Gao <chao.gao@intel.com>
Subject: [PULL 091/153] i386/cpu: Advertise CET related flags in feature words
Date: Sat, 27 Dec 2025 10:46:56 +0100
Message-ID: <20251227094759.35658-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yang Weijiang <weijiang.yang@intel.com>

Add SHSTK and IBT flags in feature words with entry/exit
control flags.

CET SHSTK and IBT feature are enumerated via CPUID(EAX=7,ECX=0)
ECX[bit 7] and EDX[bit 20]. CET states load/restore at vmentry/
vmexit are controlled by VMX_ENTRY_CTLS[bit 20] and VMX_EXIT_CTLS[bit 28].
Enable these flags so that KVM can enumerate the features properly.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-20-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 ++
 target/i386/cpu.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 458775daaa3..33350602edd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1370,6 +1370,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
 #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
+#define VMX_VM_EXIT_SAVE_CET                        0x10000000
 #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
 #define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
 
@@ -1383,6 +1384,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
 #define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
 #define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
+#define VMX_VM_ENTRY_LOAD_CET                       0x00100000
 #define VMX_VM_ENTRY_LOAD_IA32_PKRS                 0x00400000
 
 /* Supported Hyper-V Enlightenments */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6774f662342..4e0c5cf9997 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", "cet-ss",
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -1244,7 +1244,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
             "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
-            NULL, NULL, "amx-bf16", "avx512-fp16",
+            "cet-ibt", NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
             "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
         },
@@ -1666,7 +1666,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
+            "vmx-exit-save-cet", "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1681,7 +1681,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
+            "vmx-entry-load-cet", NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.52.0


