Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE4C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonRy-00031R-36; Tue, 28 Jul 2026 15:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRo-0002ro-3O
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:40 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRl-0001Kw-2W
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:38 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so217294a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266796; x=1785871596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nymk/KlJTSOeG9pOLHjAQMrrwDf8dwvKcqF44jXbkLg=;
 b=NYMWMX90lEFAMt/Ev2puxcJ5GtM5qTlQj1LSuq4rGvwZWZ0N5+S2cSgyjcuTLpW/pi
 0w+csaqD0vArlB41ZV8HGzd0Y2ivcPwnlFQ1bS/DoUThdfOrcqshqF/1Xb7X57o84V7/
 hh8sdkT2JI0vUm062MKZyNXzgmBNOU+knm3hhC/U3mebVvXWT/nDNoaonwb0bmPpc3yI
 EO0HCbAlV8703HTR0QRru1sbKGWGE4D+r3L2UR/XDZ5jvCVBaUWjv5u6TwjUi10RwSyd
 kkuq5hQA+zfOkiLolasgI1V6izctISGdk6tFHbvVdTU070WuZpIVpj+uE0LAQ55A34nQ
 ukuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266796; x=1785871596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nymk/KlJTSOeG9pOLHjAQMrrwDf8dwvKcqF44jXbkLg=;
 b=YWVqjBygpubvbu/HyhmHzvrLHHv5kADZE1o5SKZhykv5ZHTAFQSo2obOg7R671N1py
 z0Bs2Op7AgvbnreWirqZKJwe75GYMpYb/WpJEP1zLBHqdW+BCAsolhJr2XmqYo5TrEwj
 ijn7FADQtHjwaU8OyZ87atGQVogoazg0axLBnnoz+Gk9z1RHZXj6NAn4ECYts24QEb75
 FIC8qYHxcpuWi/PAg08OhaK07x1bHcimJk9kljy307Tay/ClAFY5lw89+6q7h1Yxmoki
 LkfweTsraLMUJ2KlOLchKJ32/6oY8pouplOMjchBuw/fiU4pS8umgvB1Yt9gigRv3OSz
 BEgA==
X-Gm-Message-State: AOJu0YyasLBe2XYJZtTa9uq790rkGppy8C7z5pqvPIPlG06SjpoXt6vk
 TJ0xv2+k66oQyLbNxEvzFJqb8MaJAJyLCIxlOvDpd8d0TpWzeDG6irTzHn+V488mtCU=
X-Gm-Gg: AR+sD13H3ccTQcut8sCz2+gZlD0q8ZAl+78edwEXnt2fj7XNM81jrbLdqJUQza3eoxL
 IgoKs+M+gXfDtoO6p6RsjQ4t2R+lVhN8wlebuOqgsV4FiMgMiYRsb+kIphMMIC7OEbn0g2AxfDg
 v4ezwGWpT+khS1U2eIrBMWnhsuZPC7B+8LvFwtZSefJwRfECJnNLpAdXpiVSNbiLmVzU1tjqwAM
 H2c9X7yiHqoX3mClaL07fv2lugN23jq4+Ui1DjQbF2JZ8cvki3Dq4B4pYGhCNvaFrC3Wivc82yT
 FhVnCLiOaaJzty4ORlJfKmlJjSp8SP5cgjwoEku6kO1chIKMRbNhnxMdpDxwu5FwGIO8qdWUz5C
 2pQpvCRAmXEUS3vlEu2eykKwFjnBFOTpRiphuBNQHG/rkHqWX9RIy1/byBwan/EHA3CYHuFWOQe
 7BWJOF3F4Moccy+ZACDVv1l0lhe4fAcHuANNLIGsAJEnI8odd9sxzDCZpJtD/JrawYDHATu64GL
 MPcBxY7bSMtn78=
X-Received: by 2002:a17:90a:d88d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-38f6a30eb9emr4333942a91.9.1785266795564; 
 Tue, 28 Jul 2026 12:26:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:35 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 01/24] linux-headers: Add RME related definitions
Date: Tue, 28 Jul 2026 13:26:07 -0600
Message-ID: <20260728192630.240375-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

This is a temporary patch intended for testing purposes only. It provides
definitions related to supporting Realms by the QEMU-VMM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 linux-headers/asm-arm64/kvm.h |  9 +++++++++
 linux-headers/linux/kvm.h     | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

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
index dd52e2a65bfd..cdd5ad11f85a 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -689,14 +689,19 @@ struct kvm_enable_cap {
  * address size for the VM. Bits[7-0] are reserved for the guest
  * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
  * value 0 implies the default IPA size, 40bits.
+ *
+ * Bits[30-31] are reserved for the VM type
  */
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 
+#define KVM_VM_TYPE_ARM_NORMAL		0
+#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
 #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
 #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
-					 KVM_VM_TYPE_ARM_PROTECTED)
+					 KVM_VM_TYPE_ARM_PROTECTED | \
+					 KVM_VM_TYPE_ARM_REALM)
 
 /*
  * ioctls for /dev/kvm fds:
@@ -719,6 +724,8 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+
 /*
  * Extension capability list.
  */
@@ -986,6 +993,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_ARM_RMI 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


