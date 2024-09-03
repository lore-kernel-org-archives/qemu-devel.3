Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3ACD342E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slOSe-0006kG-Du; Tue, 03 Sep 2024 04:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slOSc-0006ja-5o
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slOSZ-0004R8-2n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725350418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g9gMF5nZosX4YpZl1BMI7RIZtJmjwIKTODTm+IlxJgU=;
 b=XjQUp6qlmNFX2BnDUjDJks+RLlE9RPFD6CU4dmerU/HbY41Ip3VHRFXIG9bJyP4di9S+6/
 yVvGi2vup2bap+eJGy/yF+RZAFf3DqwIbiDFiQSSjM9jEZVsvpFaBCIqEXJgwlX91N0K6q
 jOHDYvt2+fkeIa1FZnk0q5U1CMH2hog=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-6povwN8bMrK8TfCx3-aDgA-1; Tue, 03 Sep 2024 04:00:16 -0400
X-MC-Unique: 6povwN8bMrK8TfCx3-aDgA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2da511a99e1so995449a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 01:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725350415; x=1725955215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9gMF5nZosX4YpZl1BMI7RIZtJmjwIKTODTm+IlxJgU=;
 b=oiNXqIfp2kBxaYKHEXcf/F4OHcudi2GfO3892SmDH6WwMtc0trjrgJ6wKS1b2Uhwca
 nrg0KNvlxAuGqTb90Rn/fOvRVqDVYL6Zjqt6k8mCZczOfgg6CrNkGp9ATh0DaH0BDc4U
 I7q1gL1YEXco5zn80E7Ci0wtcGs29aDnhJIDQDA0OEZm//S5G64YpJaEN5OiV/mqSsGd
 LfZZF+zYdLgtjrDBQtDqSBqCLYhF9qZ/7KRnC+ExLGSfp1ct6BR5npTwcMM6U6x8EKAx
 Yq37nOPzikuoutOkbBw9DSLqEOrM4oOw1TDTIGbGA/250Gn9IGy7AZBfpUZIYhLccrIO
 64ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZUTWTeOdOpteQyfkMuIy1n0UTQ99DIl8ZthcN+naYY5qSFoFOWIAn7UhL6l9mIX1j5bFyuduFtpHz@nongnu.org
X-Gm-Message-State: AOJu0YywrSYos0sBKetNQ5v/bHYAsThiysid4ljvTOLIGDaeYpAmY0Gz
 iIX8gL6Nz1XZ+g6UzQj664/vzYGOaL2aKNGdDxcSV+md+7xZBXU841WdmNkYs1vB8zO7K8PgEU9
 dw9PzKhxEiSnHmdvSBPEf1rc11ZiqyEG3vNGFYc8Gx6CpA+2mWcOn
X-Received: by 2002:a17:90a:1c17:b0:2c9:6f06:8005 with SMTP id
 98e67ed59e1d1-2d856383fdemr18245909a91.26.1725350415410; 
 Tue, 03 Sep 2024 01:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgp3jyb0JRyqdYlU153uTlOouysm2/8u5v4zt+2XiMXPK739+XzYYL6QlH7ASSM6+7XmH0JA==
X-Received: by 2002:a17:90a:1c17:b0:2c9:6f06:8005 with SMTP id
 98e67ed59e1d1-2d856383fdemr18245877a91.26.1725350415002; 
 Tue, 03 Sep 2024 01:00:15 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d8edadf788sm2998821a91.15.2024.09.03.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:00:14 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2] kvm/i386: fix return values of is_host_cpu_intel()
Date: Tue,  3 Sep 2024 13:30:04 +0530
Message-ID: <20240903080004.33746-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

is_host_cpu_intel() should return TRUE if the host cpu in Intel based, otherwise
it should return FALSE. Currently, it returns zero (FALSE) when the host CPU
is INTEL and non-zero otherwise. Fix the function so that it agrees more with
the semantics. Adjust the calling logic accordingly. RAPL needs Intel host cpus.
If the host CPU is not Intel baseed, we should report error.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c         | 2 +-
 target/i386/kvm/vmsr_energy.c | 4 ++--
 target/i386/kvm/vmsr_energy.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 
changelog:
v2: fix comparison logic in is_host_cpu_intel so that it returns
boolean TRUE for Intel host CPU and false otherwise.

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 11c7619bfd..503e8d956e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2898,7 +2898,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
      * 1. Host cpu must be Intel cpu
      * 2. RAPL must be enabled on the Host
      */
-    if (is_host_cpu_intel()) {
+    if (!is_host_cpu_intel()) {
         error_report("The RAPL feature can only be enabled on hosts\
                       with Intel CPU models");
         ret = 1;
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 7e064c5aef..ce7eecb02d 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -27,14 +27,14 @@ char *vmsr_compute_default_paths(void)
     return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
 }
 
-bool is_host_cpu_intel(void)
+gboolean is_host_cpu_intel(void)
 {
     int family, model, stepping;
     char vendor[CPUID_VENDOR_SZ + 1];
 
     host_cpu_vendor_fms(vendor, &family, &model, &stepping);
 
-    return strcmp(vendor, CPUID_VENDOR_INTEL);
+    return g_str_equal(vendor, CPUID_VENDOR_INTEL);
 }
 
 int is_rapl_enabled(void)
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
index 16cc1f4814..97045986b7 100644
--- a/target/i386/kvm/vmsr_energy.h
+++ b/target/i386/kvm/vmsr_energy.h
@@ -94,6 +94,6 @@ double vmsr_get_ratio(uint64_t e_delta,
                       unsigned long long delta_ticks,
                       unsigned int maxticks);
 void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState *ms);
-bool is_host_cpu_intel(void);
+gboolean is_host_cpu_intel(void);
 int is_rapl_enabled(void);
 #endif /* VMSR_ENERGY_H */
-- 
2.42.0


