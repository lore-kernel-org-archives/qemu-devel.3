Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91B8D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytE-0001j9-8y; Mon, 02 Mar 2026 03:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt9-0001hT-S0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt3-0001XA-Sg
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5glJM2P7fY2YVXE7FFswaKmcrolKLgkeSRsFSCk7y4s=;
 b=YwXRziaCyY7qkaSjygiDhIXnOLGQbSYK6A2BSDluQ68cRjCu6ILmxgEM9TF4exNjqyFZ8W
 aZ6ZGkuAcNc1hPCN+miY90ejZ4WNp/lGNXHO4bQTlS8NLWF8lAG3Nan81iFoNo63YSdcS+
 ddzfZAScDTxhoP/f3p42VUcpWZpnusE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-CqsrNeRsNP-LgNVw8PfscA-1; Mon, 02 Mar 2026 03:44:10 -0500
X-MC-Unique: CqsrNeRsNP-LgNVw8PfscA-1
X-Mimecast-MFC-AGG-ID: CqsrNeRsNP-LgNVw8PfscA_1772441049
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4363333c102so2851396f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441048; x=1773045848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5glJM2P7fY2YVXE7FFswaKmcrolKLgkeSRsFSCk7y4s=;
 b=SMyVX/+3f4IsBPDwDuMJJOQhPxEnOMybY7KUWJJIBRMybL4g2Jf6YadHhkoa6zJV36
 1+cxh1YONvUZ+E+Gp+YVxAXZtHSxfuQrZLELviukzxaBFmtxXknLvhKDnUgIZZddABMk
 GAY9DK0yM7tRspBOOpXLel2MVanvpAhDa0/raJmDAtjp52p9c1/PlWB3B3/sEW3VUl8D
 keWZBnam4Xe6SsMuDWEEI9fO9Vd5jMiFYm16Mvma8VXxZ3QXpas2NwsvCvYBZ0lUaNAA
 Z8b/frh3uR64C4BqZ6GQGDZNNU8mjeAUChGvcpKpSr/Xa8hL8SIzuIXRbbPQBMtAJFZt
 2mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441048; x=1773045848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5glJM2P7fY2YVXE7FFswaKmcrolKLgkeSRsFSCk7y4s=;
 b=SrkS4K0Fjk5xBe8VPGPuA1Pm5XctprPDf4KLjWO1sZWKLFITwvFS7mGKMFHGiGrmKS
 KrtAoNkBGw9Yp2c5Ve2UGEEb0qFkbyoEZdlaW3ODyCxryLYnhm10YeIjxd81yoh+MjW8
 v0vDK2Ar2ZbMKLepyOTEjFmwCLTR1CopXCg4cjnQ1aA+0SyXAuk5V630SLW3EpKuGMfL
 34ZbEEFpWNQcG81r7qyyiRU13JhjnitQkipGdaUZkHWy0J0FThDWnU/ZEhHFD9OFF3va
 Dy8gbk/H57vjB+uw5xG8P3986+c7uZ1EjVjnEzX3YF3lrZme9jgBIWt1d+8RSQpSzTfy
 jR2g==
X-Gm-Message-State: AOJu0Yzhb17Aw7TNzwVg5y0gerM4f8OCFiVrVDWznPXiTd+dwmK0YJFe
 AXJJGaRVO+233RwLyBgiuZdnKahD5uUdXkKQ1RHbTE+ujwlB8j58IizxGus6W978qpuPNWFBhog
 REPKo3E+B3qzUhNcbm56FovW8DgChliqXAooN4TIpGocZzqsFSducRVDVompkC+NUMKOZxacicV
 VFx5wKhQ20kvkMuYRgg+UUpSEDPLJ0g4smx36lSh2g
X-Gm-Gg: ATEYQzzCXU+lkLDzsdwnE3+0lv4FI1kdw4J9EfOnaYiSuTSMM36C3H5IU04wrEgxg90
 kU2Z/Tj7rL/Ya8D1Dot5s9Trm5iFlEUZ97A3cn9Mp6a89C4who1N8WD+vGcRsdbdybcBiw4JagE
 Y705XzBFz5teOF6k4+dYGuYUuJuLiWKXfDSa/nGCCYOW3fIwgKUA3nm1luD2uBOG7+GKvHDbUVM
 h2Qc/F8YcsUmyYOZ49oww3oSDVofB4w9TJEgwO3zj2UkelWJuO4hwObzHggFD0Ecu6hYe8U0djb
 NtJlXiq5bbstpZm7h7vm6lFJVJ+4JlAReNo28u4+kqVnaKdeiPR8uWkrGWiPBpl1nhyRs5ZCUE1
 hiQxX6kAyFEMfHVWzSG00Da7NbJy/Gl8HMOA3+aHENigAghA+wbocG8h/+C88RVH5F5AyVMs9Uz
 O0KVRrvHylneF/FIe7VYjk7AybgM8=
X-Received: by 2002:a05:6000:2f86:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4399de2c5a6mr19151141f8f.46.1772441047931; 
 Mon, 02 Mar 2026 00:44:07 -0800 (PST)
X-Received: by 2002:a05:6000:2f86:b0:435:8ad8:b7a with SMTP id
 ffacd0b85a97d-4399de2c5a6mr19151089f8f.46.1772441047352; 
 Mon, 02 Mar 2026 00:44:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439abdf5430sm15119019f8f.5.2026.03.02.00.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 009/102] whpx: refactor whpx_destroy_vcpu to arch-specific
 function
Date: Mon,  2 Mar 2026 09:42:04 +0100
Message-ID: <20260302084338.473368-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Avoid a TARGET_X86_64 define by moving platform-specific code
away from generic WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260223233950.96076-9-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-all.h   | 1 +
 accel/whpx/whpx-common.c    | 5 +----
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 6 ++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index 3db074c38c5..b831c463b0b 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,6 +17,7 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+void whpx_arch_destroy_vcpu(CPUState *cpu);
 
 /* called by whpx-accel-ops */
 bool whpx_arch_supports_guest_debug(void);
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index f018a8f5c7d..c57a0d3f0f9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -236,10 +236,7 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-#ifdef HOST_X86_64
-    AccelCPUState *vcpu = cpu->accel;
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-#endif
+    whpx_arch_destroy_vcpu(cpu);
     g_free(cpu->accel);
 }
 
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index e01e6499ba4..0a31c7b9464 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -308,6 +308,11 @@ bool whpx_arch_supports_guest_debug(void)
     return false;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    /* currently empty on Arm */
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e1f0fa5e770..cdcaebbe167 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1277,6 +1277,12 @@ bool whpx_arch_supports_guest_debug(void)
     return true;
 }
 
+void whpx_arch_destroy_vcpu(CPUState *cpu)
+{
+    AccelCPUState *vcpu = cpu->accel;
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.53.0


