Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6771CFA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp81A-000640-0k; Fri, 13 Sep 2024 11:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp809-00025c-1S
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp806-0007n7-SS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cae102702so9679715e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240460; x=1726845260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wrqlu0MBnX/IwubC7JB6PnaVoLkJuNGIJqIpkcG99Z0=;
 b=bCjPegGDQRwUKtiLErAZs/JZfUgrz5u1wRzQKqyW2atmPICu4uX6Jb8zkC20RIPy7P
 uFG5rxjEGryHyXI5tuYhbiyN2Odm7kA34jEQy1OVSDTEoieKMTHJG1OHErTXCCiRUI39
 aBoWZwntOFx4lnmJ9NdaAUplHnHTVOrV/Mb5qSAvM66YdUVV/aBgJUMB5vbXo1dVH9ox
 sDJP2LmOT8a79pGY2N4/d7KchC1IykFt0vKXCJ7xpGdoc7LhJ9ZQlYNWpfOlqzooO0kB
 KgUtfRSz2dNNjQ1CmUcIq/ShvC+HYc2fOM+Z1Q3nZyai4NyZZYJOCbkaJ+rMdMvgpL6l
 w4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240460; x=1726845260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrqlu0MBnX/IwubC7JB6PnaVoLkJuNGIJqIpkcG99Z0=;
 b=Wcl3+IHJOYOPT1oUuhw/Yx6MCCCdtvTV2+oCNBAbfLhFTwtc1VvcUEPD1/217IVe1z
 EZ7BYSt6szGGSdm3r+f7lb1ywelTSmMglqdCQhFYSUY3+OEW6I/45GU6jzMNTLlhDunB
 BkutgXEpvnRD5+A1ujZexwEWYo+bRwlVEnCpuQe2+/i119/1qWkfZJssPV9qrkDryEyw
 r1b3d9P7wD/QP0fnbVY1VRHXH09ahd3e6ryRGJeJe64A9wUidb4JxA5DMLtPXiILMlC8
 CJdq/nejLUvda5KCGLUwg28l6crY9TWQktRkUZd6K+QQnxvSX3bq6dvxinYaKFGIFQw6
 dcAg==
X-Gm-Message-State: AOJu0Yxo6k0KoU45ViUAnfZjb2uQn+O/N4L+OQSfnj57rc2gAon6/Zb/
 QKE7AfaLRgqGjLGkgoeqq9sjc5dHiVWW+MY4qbW660FmHTvefha/AHVobjeuDYzpg1gylhJN/VS
 a
X-Google-Smtp-Source: AGHT+IHHQ2HVSDmGVdLXr6iijTfHYsoCILBoUQ5/Q0copxpqmB2BcOl0c6rOs/J90Fa97qFokLL+UQ==
X-Received: by 2002:a05:600c:4746:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-42d964d8612mr25076665e9.23.1726240460250; 
 Fri, 13 Sep 2024 08:14:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/27] hvf: Split up hv_vm_create logic per arch
Date: Fri, 13 Sep 2024 16:13:58 +0100
Message-Id: <20240913151411.2167922-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Danny Canter <danny_canter@apple.com>

This is preliminary work to split up hv_vm_create
logic per platform so we can support creating VMs
with > 64GB of RAM on Apple Silicon machines. This
is done via ARM HVF's hv_vm_config_create() (and
other APIs that modify this config that will be
coming in future patches). This should have no
behavioral difference at all as hv_vm_config_create()
just assigns the same default values as if you just
passed NULL to the function.

Signed-off-by: Danny Canter <danny_canter@apple.com>
Message-id: 20240828111552.93482-3-danny_canter@apple.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/hvf_int.h  | 1 +
 accel/hvf/hvf-accel-ops.c | 6 +-----
 target/arm/hvf/hvf.c      | 9 +++++++++
 target/i386/hvf/hvf.c     | 5 +++++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 5b28d17ba1f..42ae18433f0 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -65,6 +65,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 #define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 int hvf_vcpu_exec(CPUState *);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ac08cfb9f32..dbebf209f48 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -61,10 +61,6 @@
 
 HVFState *hvf_state;
 
-#ifdef __aarch64__
-#define HV_VM_DEFAULT NULL
-#endif
-
 /* Memory slots */
 
 hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
@@ -324,7 +320,7 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
-    ret = hv_vm_create(HV_VM_DEFAULT);
+    ret = hvf_arch_vm_create(ms, 0);
     assert_hvf_ok(ret);
 
     s = g_new0(HVFState, 1);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ace83671b59..19964d241ed 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -929,6 +929,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+{
+    hv_vm_config_t config = hv_vm_config_create();
+    hv_return_t ret = hv_vm_create(config);
+    os_release(config);
+
+    return ret;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c9c64e29781..68dc5d9cf75 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -223,6 +223,11 @@ int hvf_arch_init(void)
     return 0;
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
+{
+    return hv_vm_create(HV_VM_DEFAULT);
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
-- 
2.34.1


