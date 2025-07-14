Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3F6C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHAQ-0003Zb-Aw; Mon, 14 Jul 2025 07:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0C-0001HD-Ru
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0A-0001wl-QK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wVutdUCpdUXWQWTx6uVxLNXyVult81NQL9SKeIWPII=;
 b=G79SnrNL/MUbYyqZ0P+bIR7J9uM6lfCn3Of4v6V4UXBPlB4iQZitdOP8o0X0vjt4waeliA
 EF4h2FwnqTx8MEE8c7Sog0CFRJ4rLQjTH7UnxiJH2IirZQ0eYY+y1+SP7/uUHpE26tq38Q
 JLkwt8fQbjaLUBTq0bTblslQsUB+x3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-FSAkJapGPpmTfs7SofwSAA-1; Mon, 14 Jul 2025 07:05:38 -0400
X-MC-Unique: FSAkJapGPpmTfs7SofwSAA-1
X-Mimecast-MFC-AGG-ID: FSAkJapGPpmTfs7SofwSAA_1752491137
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2145723f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491136; x=1753095936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wVutdUCpdUXWQWTx6uVxLNXyVult81NQL9SKeIWPII=;
 b=YY54xBfkScAmp0zyZ8jXMfpJephBuPKQZQ1V6vufYKIYu3jgOHlwKTeK4+KG48K6X4
 Crz06KA7S6ZscjcALL47cH5nEAicMtkMucAPkg0M/l4tY2YGze2K62cgPM1Jd+APW132
 l4gggLbtrNEtcIglDkvD8LE8ZT8JlmDwDUNFtMTM1mmN3S8+HJ0lweb6CVxU3IOhTCnc
 vONkKYKFdIg/VN6v7MAeEA/RJBrr5d8w4DG5OpDoiL2igq5xBCuwiYyiDfo3TIqHIoin
 8nZHi7mYubzSy4xoYz/c0oyn0SN+gS/W412JlSPr1GVk0Qfug74xqjPgacSc1R9o8E4R
 8pEA==
X-Gm-Message-State: AOJu0Yw6iWpr6wagxSsi+ab5ROdbD4XcqaXpDMT0C7l14X0RC/vdQms4
 sMus7E9JpiH4WXKoXgvvOXGW5NTIvKOM78H46O2X3odVct3azHS6435k/vG44LiSr4Q7Pr98PfF
 TN3o3aQarY3Ga02QFy7y6msiqJA2ecvuJ/FNka5IsQpNAu5agfhVrWM3RAY0tMIXxxKcTPSUNJF
 fkbweYvcXVmnKxJOb3ohuS+GTLTrZ/4oqaLz4CWnpq
X-Gm-Gg: ASbGncvWjXyXlj1krG7z056oSpnhWBZak5oxoXLrKZRgaHusXxpVtu01ShZBJ6obUPr
 iq2L4FL64P/21GReK+ycI0H7lOrlvl9JZC4xMrwToPrPu8bD0qdaIa5TOZCC9FpwvDDf6n1nnNI
 zT/eEhJlsXM51mKa0xawAaUy7H2769DrHpq83FhQCHOMsXp3+J3flGjHIhrAtBjm9mXON2A6eT6
 3DIF4dV9pbsWhq7RnqLHN31Bnfixl4A8HRhLovLc3pbd8FwLiDPZQZG16uriFpnKg0DQTQkol2N
 fdpJJQsyjzrIXPXCdc9Tv0TyKpE+7UyiEdU6TzyQ9TU=
X-Received: by 2002:a05:6000:250f:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b5f1880f48mr11152962f8f.20.1752491136457; 
 Mon, 14 Jul 2025 04:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJCI1sBoQ6qBcC7ImXJnqnI2CFv8ld4kNnXzaZ0ADKgUvv1UVyCTMP9q+j4Ij9guCpUDIBtQ==
X-Received: by 2002:a05:6000:250f:b0:3a4:dc32:6cbc with SMTP id
 ffacd0b85a97d-3b5f1880f48mr11152929f8f.20.1752491135931; 
 Mon, 14 Jul 2025 04:05:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1792sm12341878f8f.13.2025.07.14.04.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 33/77] i386/cpu: Move the implementation of is_host_cpu_intel()
 host-cpu.c
Date: Mon, 14 Jul 2025 13:03:22 +0200
Message-ID: <20250714110406.117772-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

It's more proper to put is_host_cpu_intel() in host-cpu.c instead of
vmsr_energy.c.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250701075738.3451873-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.h        | 1 +
 target/i386/kvm/vmsr_energy.h | 1 -
 target/i386/host-cpu.c        | 9 +++++++++
 target/i386/kvm/vmsr_energy.c | 9 ---------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index b97ec01c9be..10df4b3a3a7 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -17,4 +17,5 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp);
 
 void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping);
 
+bool is_host_cpu_intel(void);
 #endif /* HOST_CPU_H */
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
index 16cc1f4814f..151bcbd6423 100644
--- a/target/i386/kvm/vmsr_energy.h
+++ b/target/i386/kvm/vmsr_energy.h
@@ -94,6 +94,5 @@ double vmsr_get_ratio(uint64_t e_delta,
                       unsigned long long delta_ticks,
                       unsigned int maxticks);
 void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState *ms);
-bool is_host_cpu_intel(void);
 int is_rapl_enabled(void);
 #endif /* VMSR_ENERGY_H */
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 3399edc1ad0..e9a49e628f8 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -161,6 +161,15 @@ void host_cpu_instance_init(X86CPU *cpu)
                             &error_abort);
 }
 
+bool is_host_cpu_intel(void)
+{
+    char vendor[CPUID_VENDOR_SZ + 1];
+
+    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
+
+    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
+}
+
 static void host_cpu_class_init(ObjectClass *oc, const void *data)
 {
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index d6aad5246b6..58ce3df53a3 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -27,15 +27,6 @@ char *vmsr_compute_default_paths(void)
     return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
 }
 
-bool is_host_cpu_intel(void)
-{
-    char vendor[CPUID_VENDOR_SZ + 1];
-
-    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
-
-    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
-}
-
 int is_rapl_enabled(void)
 {
     const char *path = "/sys/class/powercap/intel-rapl/enabled";
-- 
2.50.0


