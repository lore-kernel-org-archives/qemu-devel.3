Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3682DC44503
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVj-0001I2-IT; Tue, 07 Jul 2026 18:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVi-0001HL-Eu
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVe-00045z-Gw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:26 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caf228a910so564905ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464200; x=1784069000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPqEyUzT++gNY9WDAWkbqlVC0xxiLcUKrinmqOFE5ZQ=;
 b=QQOLSDrQRmS708rQdWI9huj2NuCRPbphgJ1qeMDh4HtIaR1kSaxLn96KJQvVqCYd3+
 XuwUj4ZMvbiFXQ+kwu+IfRW17oRbqeslaMquloOYcu+vpXJYwLCF8jn4UfuBLKLjQEEb
 p7z5X9f88uWDGSyqjjhCXkRAd06heUtpRehv8a/fSKzG7aMkcqRlxKJ3dqraVTfQ+fIN
 eQXRfgubqntKHNfno9LW4CK1Dfz8fmPIEoF8IuOB3jkv29UvLuXb8O+hG6gEx5bmRLUo
 f8JB8NpofW7B4V3puxE2ZeKVwW1qH4SdeFObzFxb8bgfNuuktaYCdYpv5bOjpJF+5UzW
 fbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464200; x=1784069000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LPqEyUzT++gNY9WDAWkbqlVC0xxiLcUKrinmqOFE5ZQ=;
 b=Ex8VnwR7TnOKjP6WNp1J0mxAena8NDXlXfGb69B7U4gXTbxlL2ism2oB00KkEFguBn
 XsJOG+6X5bJXBLo1yrtJTYEZPv0D97lWfpelQAU8NgBsgbBZY1XdxLIl8pEXZCTDALgq
 tY2rGuZL449Uk3WvZhz37MUzntPTNfyZmM/7t7KQ2tzSzDADujwj+bbRrRcdZSCzLIO8
 SoAfVj5GWHBWME40htuwxZdeVu9DGSztuhHY5DeNxB8vem3n0hbfQVCr/UqGGaMBJ16t
 FLBcpZ5qzbf616PUPoYsooXBsFrx5USCoFtULRGSnCw8EEjMXrEZgscI6/rXPPJQLz6o
 jq8Q==
X-Gm-Message-State: AOJu0YxtEShIMA4ru7jTlEl5Zdapb0H+Rz63OJp2+ayRx/lD8I2vyHc6
 p5CZgMRlrC6uqCqu9EV3L+MTaaCgZDbVubHIYutBRyn6Jd9pJ1rNl1+BV8DMBJiq3Rs=
X-Gm-Gg: AfdE7cktsEQ6HKg981xAtb3Aj+a77/SsOtzRhKifHEXB7J75oEUXzifqpO7Oq33VD56
 btbJsMOp7ABwZJ0tkElqlbmjhFqFYVUSLwKMok7PRjwkoG4GZTksK9u+CKvaf/CwOGEGHL762LY
 uFPObnaBL/OKXNPM8p9+7SEtTtdsGQrBM3IwZBsv8H/W7rVdD7++Ru2AXfD6mmwPqHgtX/Kpy1I
 FDk41kRIrmwVHg9WEJh76YUMEQzQCW778GEl12jm0zYCeZNyYCKHvim6s1pbYoz78vvZpkNO3l+
 HWaGYfulat7pwPMeJelq15O8XyVvT04LiJTQfBgjlxtPZ7R/kS/haHe6meCeLPht2qiT+gax4qy
 t50KYMWGz+TG4PqsVO8Hp1K6AP+R4irS3/7+yoGVtpmvC/miRxOD2704zdbHg83IAHK0bFBX1J9
 yyZ9oZSyBda5020eYWS6ol2QOsV/P5OEZUXZwYGXE=
X-Received: by 2002:a17:902:d4c7:b0:2ca:ce91:f027 with SMTP id
 d9443c01a7336-2ccbf08784fmr61937065ad.36.1783464200536; 
 Tue, 07 Jul 2026 15:43:20 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:20 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 05/25] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Tue,  7 Jul 2026 16:42:46 -0600
Message-ID: <20260707224306.1202330-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x632.google.com
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

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 28d5643d6779..b609f29c11c6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2163,7 +2163,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2266,6 +2266,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2348,7 +2361,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2451,6 +2464,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0


