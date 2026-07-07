Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEB9C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVh-0001F0-0o; Tue, 07 Jul 2026 18:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVf-0001DF-6u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVb-00044Z-BG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc8e87f29bso660665ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464191; x=1784068991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F62mc8Tl1Cc4gPDKV45QBXhrquRdA4ftBDpPYYJztPY=;
 b=eJbwYrbdhPPwpOMp3aD0eHTM5aS/ks0OClPXQQvOtedmCVziD53jodfcHae+VnS4JP
 /KnCfRAHGmAmXteuGYgNlBlHGjHymUfOXNM8sO3fmrcmjMUSBT3E7ptoSC05dt6Z2FkT
 8o+mlEatFn2m2U11yw7LAiowjQlekDrWzQ6dXRXgs1j7fv7VdMNu2EZlbQ1xoMpDi2tE
 JaTeuvLpi1iLxcd88WE66rKcCaw/Waspk2T911p8wf4CCtA0HdHzA1rrcDFdVNhi3c6f
 Qnmt9SI/YSxNYAP6ENKklS6h37HRRL/2NPHbHL2LO3EuUWe5/eSHrFfBg9SW9ySgHTfA
 3UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464191; x=1784068991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F62mc8Tl1Cc4gPDKV45QBXhrquRdA4ftBDpPYYJztPY=;
 b=ZNDGqotSGI4fPW3Y3KwpKs+/0qv7zUJ2ti58XA07YkXZ9yCS019pBGyaVJNMzawbXN
 97zm+b8l9olytVsKtqHvbexL+Wwe1mqSU0sMNbuJIPxfmosQpf8nlGzo2YIiHRtmdFMH
 uGoR1MQl4EOnRr0Z9pkJtIivMVy3NU3yFZRyJGhePnarytfPNVPGVEZDxQx4I7rDF5Je
 h658ME4z7XFZQOyZQm+kt/SbPYQRChCs3Rr71DLpjCZvqYA4vm419O65YgjO5lekoMgZ
 FLzo2rlRbNs+M7yS1T9NG0mfD+B3MoymfxmnMxsyTObiSZxZQauiVjaayQolxC0pWmXO
 dp4w==
X-Gm-Message-State: AOJu0Ywx0HTh234IEnRsGGevx8wddY8NVbRFZocGJ3aJljMD+IQuE21U
 y/oRkelz5F1EZ3Q1a/BRvzF2oa9eI+m70Kjn0eyN9cFtlsUgcHRNPxHy7BObn4uIyfU=
X-Gm-Gg: AfdE7cmCB+7L9tVZJ5qVwgMhkDQ9t4Qs+VnBQXZuIv/gsvMoLQcShEes0MRG+/3eAuS
 zrmg1Z17L80rkgm4kYj9Hq/xa9BhtVbuLw5OlS2bGFFGqfhmOrFe9ctHxKbKKwv/kZeTzELhDt6
 d0EjBKNg+wdKeZjEjZXPp+spMeMczS+uzsh5EzyD9NOU3NDq9Lw90dpyDOVlpnapubFrKlQcaX9
 HUKRJZkcSxG2ymWFqrqZA2qHFOuIGgl/fkHa1ryR1+k2dAA9kRm/H1Vu1NyRxhazxsL3ILln8Vf
 N9pTXh8XLCucHptUzxdN/oe1GDOM4Pw7X99jZM0JkDObrcWazdPHK3C7z5cfxGHWaqZni0H9pAr
 FJ6UzGNGkWFTDU+3e3PHt/KmUj7oM6trkeBbXPoNJ4fu95bT4+pjfYgLjurHNMbMjq3wiSPJIY9
 MympMpnydPaKsjIaVd5bn7gkIQjbO7jm9YrnAMsvA=
X-Received: by 2002:a17:903:3c2e:b0:2c9:97a8:afe8 with SMTP id
 d9443c01a7336-2ccbf087de6mr67975145ad.43.1783464191172; 
 Tue, 07 Jul 2026 15:43:11 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:10 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 01/25] linux-headers: Add RME related definitions
Date: Tue,  7 Jul 2026 16:42:42 -0600
Message-ID: <20260707224306.1202330-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x631.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

This is a temporary patch intended for testing purposes only. It provides
definitions related to supporting Realms by the QEMU-VMM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 linux-headers/asm-arm64/kvm.h |  9 +++++++++
 linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe7973814..4c08631ec7d2 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
 	__u64 reserved;
 };
 
+#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
+struct kvm_arm_rmi_populate {
+	__u64 base;
+	__u64 size;
+	__u64 source_uaddr;
+	__u32 flags;
+	__u32 reserved;
+};
+
 #define KVM_ARM_TAGS_TO_GUEST		0
 #define KVM_ARM_TAGS_FROM_GUEST		1
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 50e87ed72c20..dae6e5ba8457 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -685,11 +685,21 @@ struct kvm_enable_cap {
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
- * On arm64, machine type can be used to request the physical
- * address size for the VM. Bits[7-0] are reserved for the guest
- * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
- * value 0 implies the default IPA size, 40bits.
+ * On arm64, machine type can be used to request both the machine type and
+ * the physical address size for the VM.
+ *
+ * Bits[31-30] are reserved for the ARM specific machine type.
+ *
+ * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
+ * For backward compatibility, value 0 implies the default IPA size, 40bits.
  */
+#define KVM_VM_TYPE_ARM_SHIFT		30
+#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
+#define KVM_VM_TYPE_ARM(_type)		\
+	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
+#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
+#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
+
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
@@ -719,6 +729,8 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+
 /*
  * Extension capability list.
  */
@@ -985,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_ARM_RMI 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


