Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A868DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eN-0008Bb-Gy; Fri, 26 Jun 2026 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eJ-0007su-7I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eH-0005Lk-Gp
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kj0eRBswti/AsFqB8XmuAgtDzPuzUfAZcA79+C8npY=;
 b=RfhijZnBMtRzcguImaWxRgCYWsMljrsSIgj2Ym1o8kpmcg4Lca6l2ifntzc+iCCURBJuWP
 j4CzyNovxMUk+0GlgBfQVojElXv2T5rCH8jc12PssTTqHQAi7iJ8uC1YPX1cNmI33iEse5
 AMOOj6DZSmO/yOGL57/mSrd+Hy2KN10=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-o0mm5g9QNNm-QGfV1eFRqA-1; Fri, 26 Jun 2026 06:18:59 -0400
X-MC-Unique: o0mm5g9QNNm-QGfV1eFRqA-1
X-Mimecast-MFC-AGG-ID: o0mm5g9QNNm-QGfV1eFRqA_1782469138
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so5481065e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469138; x=1783073938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kj0eRBswti/AsFqB8XmuAgtDzPuzUfAZcA79+C8npY=;
 b=JGDjok6DSMtw9yDsF141VeS0ubEyQy3Tn+gHmn5XZsPDiSu/Tsdk8aoZlbfy5ZjjWH
 KuFoKqfb80DuPzWC7KpJ+PYYsn3GZN5S2UQBOASSMAKtweFnUY5l1HDSsdbonBooKY74
 ROtW3ueL/HGKVPfCmKuCbJsodZZDEXQegD7G/202w79SROcq1Eb/DwOmjZpDs264GYi8
 9z0bwrBt6pxFmQUeKQqaLP4fayB5wM4ESS8gQ8a26Y/OS1vPysCDx0NZb1Wl6ATYovPE
 aOgnZ+ZB5iPHf8510oi5IEQ4oguceycv7YaJHkryOXBAOa7USc9KFfGkdXXnnDUtGDD/
 4iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469138; x=1783073938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kj0eRBswti/AsFqB8XmuAgtDzPuzUfAZcA79+C8npY=;
 b=H6H3LC6p7HpOPOJOxnA8yay5z87bkvZlOJYfKUkLWm//UZI8lEUy3jErybCo5jVAh/
 YsikiZf9fVS0cZbAJue4mG8CodLpo/VVjuS/AEWyi6aytnkc7FFjBVY/0vlMQ5ZovLPg
 HWPtgdvoOlf+b5iPqVL6WCOQf0hoGXoxbZtF6sezgo4Dxn37ml5DM3vWeJcGLpUPHE+K
 kEOVQK2LynoUcccvmdtxwQ/HngCaJI5P8/+mN8B/HYlsvtOQbtuTalcTGNbsXsoJCcXg
 dpnRPDL6gDLWTHu/3yKOQJW9bwKuGAE+VIsDONNqUW9zx1FgQoElmoVfu1VX1ZAdbrB2
 5g+A==
X-Gm-Message-State: AOJu0YwVDU8br9N/2lD5i/E2AkLorWS3qKFGoBlUQKAeKgogc2LQvpR+
 KBkVts/MswWTvmu28MZAxcMy8YEFXs5gqsx78ys0VNP79uDDdXQKmw9WsQXC94I4jViSsaxS//6
 8cvTgYfD7VNrGAHlWAVsw3YPovE+iMrOONvkZAcVgsD1kdj+2mDPvIt6HEwj0xzxd2mQaCm3cZG
 aRcWJJ2SZNwEJ5fyJ1VH216b8KPrlLXSQUYeGwtamA
X-Gm-Gg: AfdE7cnoSo8PMRNk1PICJwIQYJYWJ7HmDIHqoRxVbdz/6ADTgFRlnH716YHvTuE1jDn
 OfPSSC1yYUOVStx8jEcm7omuQ6bMJOiUHPw8m2/zvfysjp1MsqrYrxFjmkvIRGfzoE4HJF50nE9
 59/D5UbQdnDbNCXA+YJFPJsuVFeGPaGoB1lH00z+42guM4zQ+EePaAcNWKC4Mjnk1dIIO57hCPR
 F+/8s/ROW3hBPb9qFNp81Bk38APImQNcjoP3Y+YjhwKyL1+MENU3DBjLqhMtgh13nO/47x82VTk
 ItDcRLBTgbB5Lz89Ao2TBWCDemlWAg1mq1Vh+hN4BM+XgcWFMs0smn3PFq3kS5yjobJL7i6WNlB
 /Afs+D2OAHFiBPIUG35Wbj0WKz166FLVCY7nnbMsWd1UbvkWfrXITFHO1HzK6+BTpgBJOMxCJLu
 0A/PLOikMdY4rAuOVr
X-Received: by 2002:a05:600c:6748:b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-4926688598fmr86669495e9.22.1782469138144; 
 Fri, 26 Jun 2026 03:18:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6748:b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-4926688598fmr86668875e9.22.1782469137590; 
 Fri, 26 Jun 2026 03:18:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f8d6f10absm1739431f8f.5.2026.06.26.03.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 24/45] target/i386/mshv: expose mshv_get_generic_regs
Date: Fri, 26 Jun 2026 12:17:27 +0200
Message-ID: <20260626101748.1728079-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

We expose the fn, so we can call them from the other source files
(msr.c).

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-20-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  2 ++
 target/i386/mshv/mshv-cpu.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 0cf68d2879e..ac26bfafe48 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -80,6 +80,8 @@ int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index e3f163ef630..a0a25cd2c05 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -111,9 +111,6 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 };
 
 static int set_special_regs(const CPUState *cpu);
-static int get_generic_regs(CPUState *cpu,
-                            struct hv_register_assoc *assocs,
-                            size_t n_regs);
 
 static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
 {
@@ -171,7 +168,7 @@ static int get_fpu(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = FPU_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
@@ -191,7 +188,7 @@ static int get_xc_reg(CPUState *cpu)
 
     assocs[0].name = HV_X64_REGISTER_XFEM;
 
-    ret = get_generic_regs(cpu, assocs, 1);
+    ret = mshv_get_generic_regs(cpu, assocs, 1);
     if (ret < 0) {
         error_report("failed to get xcr0");
         return -1;
@@ -284,8 +281,8 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
     return 0;
 }
 
-static int get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
-                            size_t n_regs)
+int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
+                          size_t n_regs)
 {
     int cpu_fd = mshv_vcpufd(cpu);
     int vp_index = cpu->cpu_index;
@@ -434,7 +431,7 @@ static int get_standard_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = STANDARD_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get standard registers");
         return -1;
@@ -511,7 +508,7 @@ static int get_special_regs(CPUState *cpu)
     for (size_t i = 0; i < n_regs; i++) {
         assocs[i].name = SPECIAL_REGISTER_NAMES[i];
     }
-    ret = get_generic_regs(cpu, assocs, n_regs);
+    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
         error_report("failed to get special registers");
         return -errno;
-- 
2.54.0


